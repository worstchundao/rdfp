# rdfp authentication

# Adapted from googlesheets package https://github.com/jennybc/googlesheets
# Specifically https://github.com/jennybc/googlesheets/blob/72abc6b218c26eecb9f32d0519cca41c6174aab8/R/gs_auth.R

# Changed elements:
#  - the scope list points to the dfp authentication endpoint: https://www.googleapis.com/auth/dfp
#  - the function get_google_token() will attempt to refresh itself before making call instead 
#    of allowing httr to refresh if 401 error occurs
#  - renamed the function gs_auth to dfp_auth to be consistent with package endpoint

# Copyright (c) 2015 Jennifer Bryan, Joanna Zhao

# Licensed under MIT license.

# environment to store credentials
.state <- new.env(parent = emptyenv())

#' Check that token appears to be legitimate
#'
#' This unexported function exists to catch tokens that are technically valid,
#' i.e. `inherits(token, "Token2.0")` is TRUE, but that have dysfunctional
#' credentials.
#'
#' @keywords internal
is_legit_token <- function(x, verbose = FALSE) {
  
  if(!inherits(x, "Token2.0")) {
    if(verbose) message("Not a Token2.0 object.")
    return(FALSE)
  }
  
  if("invalid_client" %in% unlist(x$credentials)) {
    # check for validity so error is found before making requests
    # shouldn't happen if id and secret don't change
    if(verbose) {
      message("Authorization error. Please check client_id and client_secret.")
    }
    return(FALSE)
  }
  
  if("invalid_request" %in% unlist(x$credentials)) {
    # known example: if user clicks "Cancel" instead of "Accept" when OAuth2
    # flow kicks to browser
    if(verbose) message("Authorization error. No access token obtained.")
    return(FALSE)
  }
  
  TRUE
  
}

#' Authorize \code{rdfp}
#'
#' Authorize \code{rdfp} to access your Google user data. You will be
#' directed to a web browser, asked to sign in to your Google account, and to
#' grant \code{rdfp} access to user data for Double Click for Publishers. 
#' These user credentials are cached in a file named
#' \code{.httr-oauth} in the current working directory, from where they can be
#' automatically refreshed, as necessary.
#'
#' Most users, most of the time, do not need to call this function
#' explicitly -- it will be triggered by the first action that
#' requires authorization. Even when called, the default arguments will often
#' suffice. However, when necessary, this function allows the user to
#'
#' \itemize{
#'   \item store a token -- the token is invisibly returned and can be assigned
#'   to an object or written to an \code{.rds} file
#'   \item read the token from an \code{.rds} file or pre-existing object in the
#'   workspace
#'   \item provide your own app key and secret -- this requires setting up a new
#'   project in
#'   \href{https://console.developers.google.com}{Google Developers Console}
#'   \item prevent caching of credentials in \code{.httr-oauth}
#' }
#'
#' In a call to \code{dfp_auth}, the user can provide the token, app key and
#' secret explicitly and can dictate whether credentials will be cached in
#' \code{.httr_oauth}. They must be specified.
#'
#' To set options in a more persistent way, predefine one or more of
#' them with lines like this in a \code{.Rprofile} file:
#' \preformatted{
#' options(rdfp.network_code = "12345678",
#'         rdfp.application_name = "MyApp",
#'         rdfp.client_id = "012345678901-99thisisatest99.apps.googleusercontent.com",
#'         rdfp.client_secret = "Th1s1sMyC1ientS3cr3t",
#'         rdfp.httr_oauth_cache = FALSE)
#' }
#' See \code{\link[base]{Startup}} for possible locations for this file and the
#' implications thereof.
#'
#' More detail is available from
#' \href{https://developers.google.com/identity/protocols/OAuth2}{Using OAuth
#' 2.0 to Access Google APIs}.
#'
#' @param token an actual token object or the path to a valid token stored as an
#'   \code{.rds} file
#' @param new_user logical, defaults to \code{FALSE}. Set to \code{TRUE} if you
#'   want to wipe the slate clean and re-authenticate with the same or different
#'   Google account. This deletes the \code{.httr-oauth} file in current working
#'   directory.
#' @param key,secret the "Client ID" and "Client secret" for the application
#' @param cache logical indicating if \code{rdfp} should cache
#'   credentials in the default cache file \code{.httr-oauth}
#' @param verbose a logical indicating if messages should be printed
#' @return an OAuth token object, specifically a
#'   \code{\link[=Token-class]{Token2.0}}, invisibly
#'
#' @export
dfp_auth <- function(token = NULL,
                     new_user = FALSE,
                     key = getOption("rdfp.client_id"),
                     secret = getOption("rdfp.client_secret"),
                     cache = getOption("rdfp.httr_oauth_cache"), 
                     verbose = TRUE) {
  
  if(new_user && file.exists(".httr-oauth")) {
    if(verbose) message("Removing old credentials ...")
    file.remove(".httr-oauth")
  }
  
  if(is.null(token)) {
    
    scope_list <- c("https://www.googleapis.com/auth/dfp")
    
    rdfp_app <- httr::oauth_app("google", key = key, secret = secret)
    
    google_token <-
      httr::oauth2.0_token(httr::oauth_endpoints("google"), rdfp_app,
                           scope = scope_list, cache = cache)
    
    stopifnot(is_legit_token(google_token, verbose = TRUE))
    
    .state$token <- google_token
    
  } else {
    
    if(is_legit_token(token)) {
      google_token <- token
    } else {
      google_token <- try(suppressWarnings(readRDS(token)), silent = TRUE)
      if(inherits(google_token, "try-error")) {
        if(verbose) {
         message(sprintf("Cannot read token from alleged .rds file:\n%s",
                         token))
        }
        return(invisible(NULL))
      } else if(!is_legit_token(google_token, verbose = TRUE)) {
        if(verbose) {
         message(sprintf("File does not contain a proper token:\n%s", token))
        }
        return(invisible(NULL))
      }
    }
    .state$token <- google_token
    
  }
  
  invisible(.state$token)
  
}

#' Retrieve Google token from environment
#'
#' Get token if it's previously stored, else prompt user to get one.
#'
#' @keywords internal
get_google_token <- function() {
  
  if(!is.null(.state$token) && !.state$token$validate()){
    this_config <- httr::config(token = .state$token$refresh())
  } else if(is.null(.state$token) || !is_legit_token(.state$token)) {
    dfp_auth()
    this_config <- httr::config(token = .state$token)
  } else {
    this_config <- httr::config(token = .state$token)
  }
  return(this_config)
}

#' Check if authorization currently in force
#'
#' @return logical
#'
#' @keywords internal
token_exists <- function(verbose = TRUE) {
  
  if(is.null(.state$token)) {
    if(verbose) {
      message("No authorization yet in this session!")
      
      if(file.exists(".httr-oauth")) {
        message(paste("NOTE: a .httr-oauth file exists in current working",
                      "directory.\n Run dfp_auth() to use the",
                      "credentials cached in .httr-oauth for this session."))
      } else {
        message(paste("No .httr-oauth file exists in current working directory.",
                      "Run dfp_auth() to provide credentials."))
      }
      
    }
    
    FALSE
    
  } else {
    
    TRUE
    
  }
  
}
#' CustomTargetingService
#' 
#' Provides operations for creating, updating and retrieving
#' CustomTargetingKey and CustomTargetingValue objects.
#' 
#' createCustomTargetingKeys
#' 
#' Creates new CustomTargetingKey objects. The following fields are required:
#' \itemize{
#'   \item{CustomTargetingKey name}
#'   \item{CustomTargetingKey type}
#' } 
#' 
#' @importFrom plyr llply ldply
#' @importFrom utils tail
#' @seealso \href{https://developers.google.com/doubleclick-publishers/docs/reference/v201608/CustomTargetingService#createCustomTargetingKeys}{Google Documentation for createCustomTargetingKeys}
#' 
#' @usage dfp_createCustomTargetingKeys(request_data, as_df=TRUE, verbose=FALSE)
#' @param request_data a \code{list} or \code{data.frame} of data elements
#' to be formatted for a SOAP
#' request (XML format, but passed as character string)
#' @param as_df a boolean indicating whether to attempt to parse the result into
#' a \code{data.frame}
#' @param verbose a boolean indicating whether to print the service URL and POSTed XML
#' @return a \code{data.frame} or \code{list} containing all the elements of a createCustomTargetingKeysResponse 
#' @export
dfp_createCustomTargetingKeys <- function(request_data, as_df=TRUE, verbose=FALSE){
 request_body <- make_request_body(service='CustomTargetingService', root_name='createCustomTargetingKeys', data=request_data)
  request <- build_soap_request(body = request_body, verbose=verbose)

  response <- xmlChildren(xmlChildren(xmlChildren(xmlRoot(request))$Body)[['createCustomTargetingKeysResponse']])
  result <- if(is.null(response$rval)){
    NULL
  } else if (as_df){
      if(length(response[grepl('rval', names(response))])==1 &
          names(response[grepl('rval', names(response))][[1]])[1]=='totalResultSetSize' &
           names(response[grepl('rval', names(response))][[1]])[2]=='startIndex'){
            ldply(tail(response[grepl('rval', names(response))]$rval, -2),
             .fun=function(x){
                 x <- xmlToList(x)
                 x[sapply(x, is.null)] <- NA
                 new_x <- as.data.frame(x, stringsAsFactors = F)
                 return(new_x)
             }, .id=NULL)
      } else {
      ldply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               x[sapply(x, is.null)] <- NA
               new_x <- as.data.frame(x, stringsAsFactors = F)
               return(new_x)
             }, .id=NULL)
      }
  } else {
      llply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               return(x)
             })
  }
  return(result)
}
#' 
#' createCustomTargetingValues
#' 
#' Creates new CustomTargetingValue objects. The following fields are required:
#' \itemize{
#'   \item{CustomTargetingValue customTargetingKeyId}
#'   \item{CustomTargetingValue name}
#' } 
#' 
#' @importFrom plyr llply ldply
#' @importFrom utils tail
#' @seealso \href{https://developers.google.com/doubleclick-publishers/docs/reference/v201608/CustomTargetingService#createCustomTargetingValues}{Google Documentation for createCustomTargetingValues}
#' 
#' @usage dfp_createCustomTargetingValues(request_data, as_df=TRUE, verbose=FALSE)
#' @param request_data a \code{list} or \code{data.frame} of data elements
#' to be formatted for a SOAP
#' request (XML format, but passed as character string)
#' @param as_df a boolean indicating whether to attempt to parse the result into
#' a \code{data.frame}
#' @param verbose a boolean indicating whether to print the service URL and POSTed XML
#' @return a \code{data.frame} or \code{list} containing all the elements of a createCustomTargetingValuesResponse 
#' @export
dfp_createCustomTargetingValues <- function(request_data, as_df=TRUE, verbose=FALSE){
 request_body <- make_request_body(service='CustomTargetingService', root_name='createCustomTargetingValues', data=request_data)
  request <- build_soap_request(body = request_body, verbose=verbose)

  response <- xmlChildren(xmlChildren(xmlChildren(xmlRoot(request))$Body)[['createCustomTargetingValuesResponse']])
  result <- if(is.null(response$rval)){
    NULL
  } else if (as_df){
      if(length(response[grepl('rval', names(response))])==1 &
          names(response[grepl('rval', names(response))][[1]])[1]=='totalResultSetSize' &
           names(response[grepl('rval', names(response))][[1]])[2]=='startIndex'){
            ldply(tail(response[grepl('rval', names(response))]$rval, -2),
             .fun=function(x){
                 x <- xmlToList(x)
                 x[sapply(x, is.null)] <- NA
                 new_x <- as.data.frame(x, stringsAsFactors = F)
                 return(new_x)
             }, .id=NULL)
      } else {
      ldply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               x[sapply(x, is.null)] <- NA
               new_x <- as.data.frame(x, stringsAsFactors = F)
               return(new_x)
             }, .id=NULL)
      }
  } else {
      llply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               return(x)
             })
  }
  return(result)
}
#' 
#' getCustomTargetingKeysByStatement
#' 
#' Gets a CustomTargetingKeyPage of CustomTargetingKey objects that satisfy the given Statement query. The following fields are supported for filtering: 
#' \itemize{
#'   \item{NA}
#'   \item{id}
#'   \item{name}
#'   \item{displayName}
#'   \item{type}
#' }
#' 
#' @importFrom plyr llply ldply
#' @importFrom utils tail
#' @seealso \href{https://developers.google.com/doubleclick-publishers/docs/reference/v201608/CustomTargetingService#getCustomTargetingKeysByStatement}{Google Documentation for getCustomTargetingKeysByStatement}
#' 
#' @usage dfp_getCustomTargetingKeysByStatement(request_data, as_df=TRUE, verbose=FALSE)
#' @param request_data a \code{list} or \code{data.frame} of data elements
#' to be formatted for a SOAP
#' request (XML format, but passed as character string)
#' @param as_df a boolean indicating whether to attempt to parse the result into
#' a \code{data.frame}
#' @param verbose a boolean indicating whether to print the service URL and POSTed XML
#' @return a \code{data.frame} or \code{list} containing all the elements of a getCustomTargetingKeysByStatementResponse 
#' @export
dfp_getCustomTargetingKeysByStatement <- function(request_data, as_df=TRUE, verbose=FALSE){
 request_body <- make_request_body(service='CustomTargetingService', root_name='getCustomTargetingKeysByStatement', data=request_data)
  request <- build_soap_request(body = request_body, verbose=verbose)

  response <- xmlChildren(xmlChildren(xmlChildren(xmlRoot(request))$Body)[['getCustomTargetingKeysByStatementResponse']])
  result <- if(is.null(response$rval)){
    NULL
  } else if (as_df){
      if(length(response[grepl('rval', names(response))])==1 &
          names(response[grepl('rval', names(response))][[1]])[1]=='totalResultSetSize' &
           names(response[grepl('rval', names(response))][[1]])[2]=='startIndex'){
            ldply(tail(response[grepl('rval', names(response))]$rval, -2),
             .fun=function(x){
                 x <- xmlToList(x)
                 x[sapply(x, is.null)] <- NA
                 new_x <- as.data.frame(x, stringsAsFactors = F)
                 return(new_x)
             }, .id=NULL)
      } else {
      ldply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               x[sapply(x, is.null)] <- NA
               new_x <- as.data.frame(x, stringsAsFactors = F)
               return(new_x)
             }, .id=NULL)
      }
  } else {
      llply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               return(x)
             })
  }
  return(result)
}
#' 
#' getCustomTargetingValuesByStatement
#' 
#' Gets a CustomTargetingValuePage of CustomTargetingValue objects that satisfy the given Statement query.  The WHERE clause in the Statement query must always contain CustomTargetingValue customTargetingKeyId as one of its columns in a way that it is AND'ed with the rest of the query. So, if you want to retrieve values for a known set of key ids, valid Statement query would look like:    "WHERE customTargetingKeyId IN ('17','18','19')" retrieves all values that are associated with keys having ids 17, 18, 19.   "WHERE customTargetingKeyId = '17' AND name = 'red'" retrieves values that are associated with keys having id 17 and value name is 'red'.     The following fields are supported for filtering: 
#' \itemize{
#'   \item{id}
#'   \item{customTargetingKeyId}
#'   \item{name}
#'   \item{displayName}
#'   \item{matchType}
#' }
#' 
#' @importFrom plyr llply ldply
#' @importFrom utils tail
#' @seealso \href{https://developers.google.com/doubleclick-publishers/docs/reference/v201608/CustomTargetingService#getCustomTargetingValuesByStatement}{Google Documentation for getCustomTargetingValuesByStatement}
#' 
#' @usage dfp_getCustomTargetingValuesByStatement(request_data, as_df=TRUE, verbose=FALSE)
#' @param request_data a \code{list} or \code{data.frame} of data elements
#' to be formatted for a SOAP
#' request (XML format, but passed as character string)
#' @param as_df a boolean indicating whether to attempt to parse the result into
#' a \code{data.frame}
#' @param verbose a boolean indicating whether to print the service URL and POSTed XML
#' @return a \code{data.frame} or \code{list} containing all the elements of a getCustomTargetingValuesByStatementResponse 
#' @export
dfp_getCustomTargetingValuesByStatement <- function(request_data, as_df=TRUE, verbose=FALSE){
 request_body <- make_request_body(service='CustomTargetingService', root_name='getCustomTargetingValuesByStatement', data=request_data)
  request <- build_soap_request(body = request_body, verbose=verbose)

  response <- xmlChildren(xmlChildren(xmlChildren(xmlRoot(request))$Body)[['getCustomTargetingValuesByStatementResponse']])
  result <- if(is.null(response$rval)){
    NULL
  } else if (as_df){
      if(length(response[grepl('rval', names(response))])==1 &
          names(response[grepl('rval', names(response))][[1]])[1]=='totalResultSetSize' &
           names(response[grepl('rval', names(response))][[1]])[2]=='startIndex'){
            ldply(tail(response[grepl('rval', names(response))]$rval, -2),
             .fun=function(x){
                 x <- xmlToList(x)
                 x[sapply(x, is.null)] <- NA
                 new_x <- as.data.frame(x, stringsAsFactors = F)
                 return(new_x)
             }, .id=NULL)
      } else {
      ldply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               x[sapply(x, is.null)] <- NA
               new_x <- as.data.frame(x, stringsAsFactors = F)
               return(new_x)
             }, .id=NULL)
      }
  } else {
      llply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               return(x)
             })
  }
  return(result)
}
#' 
#' performCustomTargetingKeyAction
#' 
#' Performs actions on CustomTargetingKey objects that match the given Statement query.
#' 
#' @importFrom plyr llply ldply
#' @importFrom utils tail
#' @seealso \href{https://developers.google.com/doubleclick-publishers/docs/reference/v201608/CustomTargetingService#performCustomTargetingKeyAction}{Google Documentation for performCustomTargetingKeyAction}
#' 
#' @usage dfp_performCustomTargetingKeyAction(request_data, as_df=TRUE, verbose=FALSE)
#' @param request_data a \code{list} or \code{data.frame} of data elements
#' to be formatted for a SOAP
#' request (XML format, but passed as character string)
#' @param as_df a boolean indicating whether to attempt to parse the result into
#' a \code{data.frame}
#' @param verbose a boolean indicating whether to print the service URL and POSTed XML
#' @return a \code{data.frame} or \code{list} containing all the elements of a performCustomTargetingKeyActionResponse 
#' @export
dfp_performCustomTargetingKeyAction <- function(request_data, as_df=TRUE, verbose=FALSE){
 request_body <- make_request_body(service='CustomTargetingService', root_name='performCustomTargetingKeyAction', data=request_data)
  request <- build_soap_request(body = request_body, verbose=verbose)

  response <- xmlChildren(xmlChildren(xmlChildren(xmlRoot(request))$Body)[['performCustomTargetingKeyActionResponse']])
  result <- if(is.null(response$rval)){
    NULL
  } else if (as_df){
      if(length(response[grepl('rval', names(response))])==1 &
          names(response[grepl('rval', names(response))][[1]])[1]=='totalResultSetSize' &
           names(response[grepl('rval', names(response))][[1]])[2]=='startIndex'){
            ldply(tail(response[grepl('rval', names(response))]$rval, -2),
             .fun=function(x){
                 x <- xmlToList(x)
                 x[sapply(x, is.null)] <- NA
                 new_x <- as.data.frame(x, stringsAsFactors = F)
                 return(new_x)
             }, .id=NULL)
      } else {
      ldply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               x[sapply(x, is.null)] <- NA
               new_x <- as.data.frame(x, stringsAsFactors = F)
               return(new_x)
             }, .id=NULL)
      }
  } else {
      llply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               return(x)
             })
  }
  return(result)
}
#' 
#' performCustomTargetingValueAction
#' 
#' Performs actions on CustomTargetingValue objects that match the given Statement query.
#' 
#' @importFrom plyr llply ldply
#' @importFrom utils tail
#' @seealso \href{https://developers.google.com/doubleclick-publishers/docs/reference/v201608/CustomTargetingService#performCustomTargetingValueAction}{Google Documentation for performCustomTargetingValueAction}
#' 
#' @usage dfp_performCustomTargetingValueAction(request_data, as_df=TRUE, verbose=FALSE)
#' @param request_data a \code{list} or \code{data.frame} of data elements
#' to be formatted for a SOAP
#' request (XML format, but passed as character string)
#' @param as_df a boolean indicating whether to attempt to parse the result into
#' a \code{data.frame}
#' @param verbose a boolean indicating whether to print the service URL and POSTed XML
#' @return a \code{data.frame} or \code{list} containing all the elements of a performCustomTargetingValueActionResponse 
#' @export
dfp_performCustomTargetingValueAction <- function(request_data, as_df=TRUE, verbose=FALSE){
 request_body <- make_request_body(service='CustomTargetingService', root_name='performCustomTargetingValueAction', data=request_data)
  request <- build_soap_request(body = request_body, verbose=verbose)

  response <- xmlChildren(xmlChildren(xmlChildren(xmlRoot(request))$Body)[['performCustomTargetingValueActionResponse']])
  result <- if(is.null(response$rval)){
    NULL
  } else if (as_df){
      if(length(response[grepl('rval', names(response))])==1 &
          names(response[grepl('rval', names(response))][[1]])[1]=='totalResultSetSize' &
           names(response[grepl('rval', names(response))][[1]])[2]=='startIndex'){
            ldply(tail(response[grepl('rval', names(response))]$rval, -2),
             .fun=function(x){
                 x <- xmlToList(x)
                 x[sapply(x, is.null)] <- NA
                 new_x <- as.data.frame(x, stringsAsFactors = F)
                 return(new_x)
             }, .id=NULL)
      } else {
      ldply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               x[sapply(x, is.null)] <- NA
               new_x <- as.data.frame(x, stringsAsFactors = F)
               return(new_x)
             }, .id=NULL)
      }
  } else {
      llply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               return(x)
             })
  }
  return(result)
}
#' 
#' updateCustomTargetingKeys
#' 
#' Updates the specified CustomTargetingKey objects.
#' 
#' @importFrom plyr llply ldply
#' @importFrom utils tail
#' @seealso \href{https://developers.google.com/doubleclick-publishers/docs/reference/v201608/CustomTargetingService#updateCustomTargetingKeys}{Google Documentation for updateCustomTargetingKeys}
#' 
#' @usage dfp_updateCustomTargetingKeys(request_data, as_df=TRUE, verbose=FALSE)
#' @param request_data a \code{list} or \code{data.frame} of data elements
#' to be formatted for a SOAP
#' request (XML format, but passed as character string)
#' @param as_df a boolean indicating whether to attempt to parse the result into
#' a \code{data.frame}
#' @param verbose a boolean indicating whether to print the service URL and POSTed XML
#' @return a \code{data.frame} or \code{list} containing all the elements of a updateCustomTargetingKeysResponse 
#' @export
dfp_updateCustomTargetingKeys <- function(request_data, as_df=TRUE, verbose=FALSE){
 request_body <- make_request_body(service='CustomTargetingService', root_name='updateCustomTargetingKeys', data=request_data)
  request <- build_soap_request(body = request_body, verbose=verbose)

  response <- xmlChildren(xmlChildren(xmlChildren(xmlRoot(request))$Body)[['updateCustomTargetingKeysResponse']])
  result <- if(is.null(response$rval)){
    NULL
  } else if (as_df){
      if(length(response[grepl('rval', names(response))])==1 &
          names(response[grepl('rval', names(response))][[1]])[1]=='totalResultSetSize' &
           names(response[grepl('rval', names(response))][[1]])[2]=='startIndex'){
            ldply(tail(response[grepl('rval', names(response))]$rval, -2),
             .fun=function(x){
                 x <- xmlToList(x)
                 x[sapply(x, is.null)] <- NA
                 new_x <- as.data.frame(x, stringsAsFactors = F)
                 return(new_x)
             }, .id=NULL)
      } else {
      ldply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               x[sapply(x, is.null)] <- NA
               new_x <- as.data.frame(x, stringsAsFactors = F)
               return(new_x)
             }, .id=NULL)
      }
  } else {
      llply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               return(x)
             })
  }
  return(result)
}
#' 
#' updateCustomTargetingValues
#' 
#' Updates the specified CustomTargetingValue objects.
#' 
#' @importFrom plyr llply ldply
#' @importFrom utils tail
#' @seealso \href{https://developers.google.com/doubleclick-publishers/docs/reference/v201608/CustomTargetingService#updateCustomTargetingValues}{Google Documentation for updateCustomTargetingValues}
#' 
#' @usage dfp_updateCustomTargetingValues(request_data, as_df=TRUE, verbose=FALSE)
#' @param request_data a \code{list} or \code{data.frame} of data elements
#' to be formatted for a SOAP
#' request (XML format, but passed as character string)
#' @param as_df a boolean indicating whether to attempt to parse the result into
#' a \code{data.frame}
#' @param verbose a boolean indicating whether to print the service URL and POSTed XML
#' @return a \code{data.frame} or \code{list} containing all the elements of a updateCustomTargetingValuesResponse 
#' @export
dfp_updateCustomTargetingValues <- function(request_data, as_df=TRUE, verbose=FALSE){
 request_body <- make_request_body(service='CustomTargetingService', root_name='updateCustomTargetingValues', data=request_data)
  request <- build_soap_request(body = request_body, verbose=verbose)

  response <- xmlChildren(xmlChildren(xmlChildren(xmlRoot(request))$Body)[['updateCustomTargetingValuesResponse']])
  result <- if(is.null(response$rval)){
    NULL
  } else if (as_df){
      if(length(response[grepl('rval', names(response))])==1 &
          names(response[grepl('rval', names(response))][[1]])[1]=='totalResultSetSize' &
           names(response[grepl('rval', names(response))][[1]])[2]=='startIndex'){
            ldply(tail(response[grepl('rval', names(response))]$rval, -2),
             .fun=function(x){
                 x <- xmlToList(x)
                 x[sapply(x, is.null)] <- NA
                 new_x <- as.data.frame(x, stringsAsFactors = F)
                 return(new_x)
             }, .id=NULL)
      } else {
      ldply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               x[sapply(x, is.null)] <- NA
               new_x <- as.data.frame(x, stringsAsFactors = F)
               return(new_x)
             }, .id=NULL)
      }
  } else {
      llply(response[grepl('rval', names(response))],
            .fun=function(x){
               x <- xmlToList(x)
               return(x)
             })
  }
  return(result)
}
#' 

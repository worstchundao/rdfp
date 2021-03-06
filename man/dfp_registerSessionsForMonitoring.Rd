% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/LiveStreamEventService.R
\name{dfp_registerSessionsForMonitoring}
\alias{dfp_registerSessionsForMonitoring}
\title{registerSessionsForMonitoring}
\usage{
dfp_registerSessionsForMonitoring(as_df=TRUE, verbose=FALSE)
}
\arguments{
\item{as_df}{a boolean indicating whether to attempt to parse the result into
a \code{data.frame}}

\item{verbose}{a boolean indicating whether to print the service URL and POSTed XML}
}
\value{
a \code{data.frame} or \code{list} containing all the elements of a registerSessionsForMonitoringResponse
}
\description{
Registers the specified list of sessionIds for monitoring. Once the session IDs have been registered, all logged information about the sessions will be persisted and can be viewed via the DFP UI.
A session ID is a unique identifier of a single user watching a live stream event.
}
\seealso{
\href{https://developers.google.com/doubleclick-publishers/docs/reference/v201608/LiveStreamEventService#registerSessionsForMonitoring}{Google Documentation for registerSessionsForMonitoring}
}


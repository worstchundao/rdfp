% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/OrderService.R
\name{dfp_createOrders}
\alias{dfp_createOrders}
\title{OrderService}
\usage{
dfp_createOrders(request_data, as_df=TRUE, verbose=FALSE)
}
\arguments{
\item{request_data}{a \code{list} or \code{data.frame} of data elements
to be formatted for a SOAP
request (XML format, but passed as character string)}

\item{as_df}{a boolean indicating whether to attempt to parse the result into
a \code{data.frame}}

\item{verbose}{a boolean indicating whether to print the service URL and POSTed XML}
}
\value{
a \code{data.frame} or \code{list} containing all the elements of a createOrdersResponse
}
\description{
Provides methods for creating, updating and retrieving Order objects.
}
\details{
An order is a grouping of LineItem objects. Line items have a one-to-one
relationship with orders. Each line item can belong to only one order.
Orders, however, have a one-to-many relationship with line items, meaning
each order can have multiple line items. An order can be used to manage the
line items it contains.

createOrders

Creates new Order objects.
}
\seealso{
\href{https://developers.google.com/doubleclick-publishers/docs/reference/v201608/OrderService#createOrders}{Google Documentation for createOrders}
}


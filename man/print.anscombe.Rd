% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/print.R
\name{print.anscombe}
\alias{print.anscombe}
\title{Print method for objects of class "anscombe"}
\usage{
\method{print}{anscombe}(x, ...)
}
\arguments{
\item{x}{an object of class "anscombe", a result of a call to \code{\link{anscombise}}
or \code{\link{mimic}}.}

\item{...}{Additional optional arguments to be passed to
\code{\link[=print.default]{print}}.}
}
\value{
The argument \code{x}, invisibly.
}
\description{
\code{print} method for class "anscombe".
}
\details{
Just extracts the new dataset from \code{x} and prints it using
\code{\link[=print.default]{print}}.
}
\seealso{
\code{\link{anscombise}} and \code{\link{mimic}}
}

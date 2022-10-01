\docType{data}
\name{input_datasets}
\alias{input_datasets}
\alias{input1}
\alias{input2}
\alias{input3}
\alias{input4}
\title{Input datasets for use by anscombise()}
\format{
All datasets are objects of class \code{matrix} (inherits from \code{array}) with 11 rows and 2 columns.
}
\source{
None.  Created for use in `anscombiser`.
}
\usage{
input1

input2

input3

input4

input5

input6

input7

input8
}
\description{
Provides input datasets from which \code{\link{anscombe}} will produce transformed datasets that behave like \link[datasets:anscombe]{Anscombe's quartet} of datasets, that is, with the same traditional statistical properties but different general behaviours.  Use \code{plot(input1)}, for example, to see the behaviours of the datasets.
}
\references{
Anscombe, Francis J. (1973). Graphs in statistical analysis.
\emph{The American Statistician}, \strong{27}, 17-21. \doi{10.2307/2682899}
}
\keyword{datasets}

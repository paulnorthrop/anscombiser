#' anscombiser: Create datasets with identical summary statistics
#'
#' Anscombe's quartet (Anscombe, 1973) are a set of four two-variable datasets
#' that have several common summary statistics but which have very different
#' joint distributions. This becomes apparent when the data are plotted, which
#' illustrates the importance of using graphical displays in Statistics.  This
#' package enables the creation of datasets that have identical marginal sample
#' means and sample variances, sample correlation, least squares regression
#' coefficients and coefficient of determination.  The user supplies an initial
#' dataset, which is shifted, scaled and rotated in order to achieve target
#' summary statistics.  The general shape of the initial dataset is retained.
#' The target statistics can be supplied directly or calculated based on a
#' user-supplied dataset.
#'
#' @details The main functions in `anscombiser` are
#'
#'   * [`anscombise`], which modifies a user-supplied dataset so that it shares
#'     sample summary statistics with Anscombe's quartet.
#'   * [`mimic`], which modified a user-supplied dataset so that is shares
#'     sample summary statistics with another user-supplied dataset.
#'
#'   See \code{vignette("intro-to-anscombiser", package = "anscombiser")} for
#'   an overview of the package.
#' @references Anscombe, F. J. (1973). Graphs in Statistical Analysis.
#'   The American Statistician 27 (1): 17–21.
#'   \url{https://doi.org/10.1080/00031305.1973.10478966}.
#' @seealso [`anscombise`] and [`mimic`]
#' @importFrom graphics plot
#' @docType package
#' @name anscombiser
#' @md
NULL

#' Donald Trump
#'
#' A dataset that provides an image of Donald Trump's face.
#'
#' @format A matrix with 4885 rows and 2 columns: `x` and `y`.
#' @source This image was created by Accentaur from the Noun Project.
#' \url{https://thenounproject.com/term/donald-trump/727774/}
#' @md
"trump"



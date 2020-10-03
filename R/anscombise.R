#' Create new versions of Anscombe's quartet
#'
#' Modifies a dataset `x` so that it shares sample summary statistics with
#' \code{\link[datasets:anscombe]{Anscombe's quartet}}.
#'
#' @param x A numeric matrix or data frame.  Each column contains observations
#'   on a different variable.  Missing observations are not allowed.
#' @param which An integer in \{1, 2, 3, 4\}.  Which of Anscombe's dataset to
#'   use.  Obviously, this makes very little difference.
#' @details The input dataset `x` is modified by shifting, scaling and rotating
#'   it so that its sample mean and covariance matrix match those of the
#'   Anscombe quartet.
#' @return An object of class `c("anscombe", class(x))`. A dataset with the
#'   same format as `x`.  The returned dataset has the following summary
#'   statistics in common with Anscombe's quartet.
#'   * The sample means of each variable.
#'   * The sample variances of each variable.
#'   * The sample correlation matrix.
#'   * The estimated regression coefficients from least squares linear
#'     regressions of each variable on each other variable.
#' @examples
#' new_faithful <- anscombise(datasets::faithful)
#' plot(new_faithful)
#' @export
#' @md
anscombise <- function(x, which = 1) {
  if (!is.matrix(x) && !is.data.frame(x)) {
    stop("x must be a matrix or a dataframe")
  }
  if (anyNA(x)) {
    stop("x must not contain any missing values")
  }
  if (!is_wholenumber(which) || x < 1 || x > 4) {
    stop("x must be an integer in {1, 2, 3, 4}")
  }
  anscombe_stats <- get_stats(anscombe[, c(which, which + 4)])
  new_x <- make_stats(x, anscombe_stats)
  # Calculate the summary statistics directly as a check
  new_stats <- get_stats(new_x)
  # Save the target and new statistics as attributes, for testing and plotting
  res <- structure(new_x, new_stats = new_stats,
                   anscombe_stats = anscombe_stats)
  class(res) <- c("anscombe", class(res))
  return(res)
}

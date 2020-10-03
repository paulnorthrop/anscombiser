#' Modify a dataset to achieve certain target sample summary statistics
#'
#' Modifies a dataset `x` so that it shares sample summary statistics with
#' another dataset `x2`.  Alternatively, the summary statistics themselves
#'
#' @param x,x2 Numeric matrices or data frames.  Each column contains observations
#'   on a different variable.  Missing observations are not allowed.
#'   \code{\link{get_stats(x2)}} sets the target summary statistics.
#'   If `x2` is missing then \code{\link{set_stats}} is called with
#'   `d = ncol(x)` and any additional arguments supplied via `...`.
#' @param ... Additional arguments to be passed to \code{\link{set_stats}}.
#' @details The input dataset `x` is modified by shifting, scaling and rotating
#'   it so that its sample mean and covariance matrix match those of `x2`.
#' @return A dataset with the same format as `x`.  The returned dataset has the
#'  following summary statistics in common with `x2`.
#'   * The sample means of each variable.
#'   * The sample variances of each variable.
#'   * The sample correlation matrix.
#'   * The estimated regression coefficients from least squares linear
#'     regressions of each variable on each other variable.
#' @examples
#' got_maps <- requireNamespace("maps", quietly = TRUE)
#' got_datasauRus <- requireNamespace("datasauRus", quietly = TRUE)
#' if (got_maps && got_datasauRus) {
#'   library(maps)
#'   library(datasauRus)
#'   dino <- datasaurus_dozen_wide[, c("dino_x", "dino_y")]
#'   UK <- mapdata("UK")
#'   new_UK <- mimic(UK, dino)
#'   plot(new_UK)
#' }
#' @export
#' @md
mimic <- function(x, x2, ...) {
  if (missing(x2)) {
    x2_stats <- set_stats(d = ncol(x), ...)
  } else {
    if (!is.matrix(x2) && !is.data.frame(x2)) {
      stop("x2 must be a matrix or a dataframe")
    }
    if (anyNA(x2)) {
      stop("x2 must not contain any missing values")
    }
    x2_stats <- get_stats(x2)
  }
  if (!is.matrix(x) && !is.data.frame(x)) {
    stop("x must be a matrix or a dataframe")
  }
  if (anyNA(x)) {
    stop("x must not contain any missing values")
  }
  new_x <- make_stats(x, x2_stats)
  # Calculate the summary statistics directly as a check
  new_stats <- get_stats(new_x)
  # Save the target and new statistics as attributes, for testing and plotting
  res <- structure(new_x, new_stats = new_stats, old_stats = x2_stats)
  class(res) <- c("anscombe", class(res))
  return(res)
}

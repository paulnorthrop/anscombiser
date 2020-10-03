#' Create new versions of Anscombe's quartet
#'
#' Modifies a dataset `x` so that it shares sample summary statistics with
#' \code{\link[datasets:anscombe]{Anscombe's quartet}}.
#'
#' @param x A numeric matrix or data frame.  Each column contains observations
#'   on a different variable.  Missing observations are not allowed.
#' @param which An integer in \{1, 2, 3, 4\}.  Which of Anscombe's dataset to
#'   use.  Obviously, this makes very little difference.
#' @return A dataset with the same format as `x`.  The returned dataset has the
#'  same summary statistics as those in `stats`, except perhaps for the sample
#'  size.
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
  return(new_x)
}

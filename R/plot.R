# ========================== Plot method for anscombe ======================= #

#' Plot diagnostics for an anscombe object
#'
#' \code{plot} method for objects inheriting from class `"anscombe"`.
#'
#' @param x an object of class `"anscombe"`, a result of a call to
#'   \code{\link{anscombise}} or `\link{mimic}`.
#' @param ... Further arguments to be passed to
#'   \code{\link[graphics:plot.default]{plot}}.
#' @details This function is only applicable in 2 or 3 dimensions, that is,
#'   when ``length(attr(new_UK, "new_stats")$means)`` is 2 or 3.
#' @return Nothing is returned.
#' @seealso \code{\link{anscombise}} and \code{\link{mimic}}.
#' @section Examples:
#' See the examples in \code{\link{anscombise}} and \code{\link{mimic}}.
#' @export
#' @md
plot.anscombe <- function(x, ...) {
  if (!inherits(x, "anscombe")) {
    stop("use only with \"anscombe\" objects")
  }
  d <- length(attr(new_UK, "new_stats")$means)
  if (d != 2 && d != 3) {
    stop("The plot method only works for datasets with 2 or 3 variables")
  }
  plor(x, ...)
  return(invisible())
}

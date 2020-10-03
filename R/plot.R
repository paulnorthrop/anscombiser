# ========================== Plot method for anscombe ======================= #

#' Plot diagnostics for an anscombe object
#'
#' `plot` method for objects inheriting from class `"anscombe"`.
#'
#' @param x an object of class `'anscombe'`, a result of a call to [anscombise]
#'   or [mimic].
#' @param input A logical scalar.  Should the old, input data, that is, the
#'   Anscombe's dataset chosen for [anscombise] or the argument `x2` to [mimic],
#'   be plotted?  If `old = FALSE` then the new, output data are plotted.
#'   If `old = TRUE` then the old data are plotted.
#' @param ... Further arguments to be passed to [`plot`][graphics::plot.default]
#' @details This function is only applicable in 2 or 3 dimensions, that is,
#'   when ``length(attr(x, "new_stats")$means)`` is 2 or 3.
#' @return Nothing is returned.
#' @seealso [anscombise] and [mimic].
#' @section Examples:
#' See the examples in [anscombise] and [mimic].
#' @export
#' @md
plot.anscombe <- function(x, old = FALSE, ...) {
  if (!inherits(x, "anscombe")) {
    stop("use only with \"anscombe\" objects")
  }
  d <- length(attr(x, "new_stats")$means)
  if (d != 2 && d != 3) {
    stop("The plot method only works for datasets with 2 or 3 variables")
  }
  # Extract new and old data
  new_data <- x[, 1:2]
  old_data <- attr(x, "old_data")
  # Extract attributes
  new_stats <- attr(x, "new_stats")
  old_stats <- attr(x, "old_stats")
  if (d == 2) {
    my_plot <- function(x, ..., pch = 16) {
      graphics::plot(x, ..., pch = pch)
    }
    my_plot(new_data, ...)
  }
  return(invisible())
}

# ========================== Plot method for anscombe ======================= #

#' Plot diagnostics for an anscombe object
#'
#' `plot` method for objects inheriting from class `"anscombe"`.
#'
#' @param x an object of class `'anscombe'`, a result of a call to [anscombise]
#'   or [mimc].
#' @param ... Further arguments to be passed to [`plot`][graphics::plot.default]
#' @details This function is only applicable in 2 or 3 dimensions, that is,
#'   when ``length(attr(x, "new_stats")$means)`` is 2 or 3.
#' @return Nothing is returned.
#' @seealso [anscombise] and [mimic].
#' @section Examples:
#' See the examples in [anscombise] and [mimic].
#' @export
#' @md
plot.anscombe <- function(x, ...) {
  if (!inherits(x, "anscombe")) {
    stop("use only with \"anscombe\" objects")
  }
  d <- length(attr(x, "new_stats")$means)
  if (d != 2 && d != 3) {
    stop("The plot method only works for datasets with 2 or 3 variables")
  }
  # Extract new and old data
  new_data <- x[, 1:2]
  # Extract attributes
  new_stats <- attr(x, "new_stats")
  old_stats <- attr(x, "old_stats")
  if (d == 2) {
    my_plot <- function(x, ...) {
      graphics::plot(x, ...)
    }
    my_plot(new_data, ...)
  }
  return(invisible())
}

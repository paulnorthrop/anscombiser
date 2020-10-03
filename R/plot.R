# ========================== Plot method for anscombe ======================= #

#' Plot diagnostics for an anscombe object
#'
#' `plot` method for objects inheriting from class `"anscombe"`.
#'
#' @param x an object of class `'anscombe'`, a result of a call to
#'   [`anscombise`] or [`mimic`].
#' @param input A logical scalar.  Should the old, input data, that is, the
#'   Anscombe's dataset chosen for [`anscombise`] or the argument `x2` to
#'   [`mimic`], be plotted?  If `old = FALSE` then the new, output data are
#'   plotted. If `old = TRUE` then the old data are plotted.
#' @param stats A logical scalar.  Should the sample summary statistics
#'   `n`, `means`, `variances` and `correlation` be added to the plot?
#' @param digits An integer.  The argument `digits` passed to [`signif`]
#'   to round the values of the statistics before adding them to the plot.
#' @param legend_args A list of arguments to be passed to
#'   [`legend`][graphics::legend] when `stats = TRUE`, especially
#'   `legend_args$x` to control the positio of the legend.
#' @param ... Further arguments to be passed to [`plot`][graphics::plot.default]
#' @details This function is only applicable in 2 or 3 dimensions, that is,
#'   when ``length(attr(x, "new_stats")$means)`` is 2 or 3.
#' @return Nothing is returned.
#' @seealso [`anscombise`] and [`mimic`].
#' @section Examples:
#' See the examples in [`anscombise`] and [`mimic`].
#' @export
#' @md
plot.anscombe <- function(x, input = FALSE, stats = TRUE, digits = 3,
                          legend_args = list(), ...) {
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
  # Select the dataset to plot
  if (input) {
    plot_data <- old_data
  } else {
    plot_data <- new_data
  }
  if (input) {
    n <- old_stats$n
    means <- old_stats$means
    variances <- old_stats$variances
    correlation <- old_stats$correlation
  } else {
    n <- new_stats$n
    means <- new_stats$means
    variances <- new_stats$variances
    correlation <- new_stats$correlation
  }
  if (d == 2) {
    my_plot <- function(x, ..., pch = 16) {
      graphics::plot(x, ..., pch = pch)
    }
    my_plot(plot_data, ...)
    if (stats) {
      if (is.null(legend_args$x)) {
        legend_args$x <- "topleft"
      }
      if (is.null(legend_args$bty)) {
        legend_args$bty <- "n"
      }
      nleg <- paste("n:", n)
      mleg <- paste0("means: (", signif(means[1], digits), ",",
                    signif(means[2], digits), ")")
      vleg <- paste0("variances: (", signif(variances[1], digits), ",",
                    signif(variances[2], digits), ")")
      cleg <- paste("correlation:", signif(correlation[1, 2], digits))
      legend_args$legend <- c(nleg, mleg, vleg, cleg)
      do.call(legend, legend_args)
    }
  }
  return(invisible())
}

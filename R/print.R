# ============================== print.anscombe ===============================

#' Print method for objects of class "anscombe"
#'
#' \code{print} method for class "anscombe".
#'
#' @param x an object of class "anscombe", a result of a call to [`anscombise`]
#'   or [`mimic`].
#' @param ... Additional optional arguments to be passed to
#'   [`print`][print.default].
#' @details Just extracts the new dataset from `x` and prints it using
#'   [`print`][print.default].
#' @return The argument \code{x}, invisibly, as for all
#'   \code{\link[base]{print}} methods.
#' @seealso [`anscombise`] and [`mimic`]
#' @export
#' @md
print.anscombe <- function(x, ...) {
  if (!inherits(x, "anscombe")) {
    stop("use only with \"anscombe\" objects")
  }
  d <- length(attr(x, "new_stats")$means)
  xprint <- x[, 1:d]
  print(xprint, ...)
  return(invisible(x))
}

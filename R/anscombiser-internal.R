#' Internal anscombiser functions
#'
#' Internal anscombiser functions
#' @details
#' These functions are not intended to be called by the user.
#' @name anscombiser-internal
#' @keywords internal
NULL

# Function to test whether the values in x are whole numbers

#' @keywords internal
#' @rdname anscombiser-internal
is_wholenumber <- function(x, tol = .Machine$double.eps^0.5) {
  return(abs(x - round(x)) < tol)
}

# Check positive definiteness of a symmetric matrix

#' @keywords internal
#' @rdname anscombiser-internal
is_pos_def <- function(x, tol = 1e-06) {
  evalues <- eigen(x, symmetric = TRUE)$values
  return(all(evalues >= -tol * abs(evalues[1L])))
}

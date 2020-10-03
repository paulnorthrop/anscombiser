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

# Function to extract longitude and latitude from the maps package

#' @keywords internal
#' @rdname anscombiser-internal
mapdata <- function(region = '.', map = "world", exact = FALSE, ...) {
  locs <- maps::map(map, region, exact = exact, plot = FALSE, fill = TRUE, ...)
  locs <- na.omit(data.frame(long = locs$x, lat = locs$y))
  return(locs)
}

# Check positive definiteness of a symmetric matrix

#' @keywords internal
#' @rdname anscombiser-internal
is_pos_def <- function(x, tol = 1e-06) {
  evalues <- eigen(x, symmetric = TRUE)$values
  return(all(evalues >= -tol * abs(evalues[1L])))
}

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

#' @keywords internal
#' @rdname anscombiser-internal
minimal_rotation <- function(x) {
  z <- eigen(x, symmetric = TRUE)
  return(z$vectors %*% diag(sqrt(z$values)) %*% t(z$vectors))
}

#' @keywords internal
#' @rdname anscombiser-internal
make_stats <- function(x, stats, idempotent = FALSE) {
  if (!is.matrix(x) && !is.data.frame(x)) {
    stop("x must be a matrix or a dataframe")
  }
  if (anyNA(x)) {
    stop("x must not contain any missing values")
  }
  # Set the rotation function
  if (idempotent) {
    rotation_fn <- minimal_rotation
  } else {
    rotation_fn <- chol
  }
  # Shift and scale to zero means and unit variances
  x <- scale(x)
  # Input sample correlation matrix
  s1 <- stats::cor(x)
  # Rotate to zero sample correlation
  trans1 <- rotation_fn(solve(s1))
  x <- t(trans1 %*% t(x))
  # Shift and scale again
  x <- scale(x)
  # Target sample correlation
  s2 <- stats$correlation
  # Rotate to target sample correlation
  trans2 <- rotation_fn(s2)
  x <- x %*% trans2
  # Shoof and scale back to achieve the target means and variances
  scales <- sqrt(stats$variances)
  shoofs <- stats$means
  x <- sweep(x, 2, scales, `*`)
  x <- sweep(x, 2, shoofs, `+`)
  colnames(x) <- paste0("new", 1:ncol(x))
  return(x)
}

#' Create a list of summary statistics
#'
#' Creates a list of summary statistics to pass to [mimic].
#'
#' @param d An integer that is no smaller than 2.
#' @param means A numeric vector of sample means.
#' @param variances A numeric vector of positive sample variances.
#' @param correlation A numeric correlation matrix.  None of the off-diagonal
#'   entries in `correlation` are allowed to be equal to 1 in absolute value.
#' @details The vectors `means` and `variances` are recycled using
#'   [`rep_len`][rep] to have length `d`.
#' @return A list containing the following components.
#'   * `means` a `d`-vector of sample means.
#'   * `variances` a `d`-vector sample variances.
#'   * `correlation` a `d` by `d` correlation matrix.
#' @examples
#' # Uncorrelated with zero means and unit variances
#' set_stats()
#' # Sample correlation = 0.9
#' set_stats(correlation = matrix(c(1, 0.9, 0.9, 1), 2, 2))
#' @export
#' @md
set_stats <- function(d = 2, means = 0, variances = 1, correlation = diag(2)) {
  if (!is_wholenumber(d) || d < 2) {
    stop("d must be a positive integer that is no smaller than 2")
  }
  if (any(variances <= 0)) {
    stop("All variances must be positive")
  }
  if (any(diag(correlation) != 1)) {
    stop("All the diagonal entries of correlation must be equal to 1")
  }
  if (any(abs(correlation - diag(d)) == 1)) {
    stop("None of the off-diagonal entries of correlation can be equal to 1")
  }
  if (!is_pos_def(correlation)) {
    stop("correlation is not positive definite")
  }
  means <- rep_len(means, d)
  variances <- rep_len(variances, d)
  res <- list()
  res$means <- means
  res$variances <- variances
  res$correlation <- correlation
  return(res)
}

#' Calculate Anscombe's summary statistics
#'
#' Calculates a particular set of summary statistics for a dataset.
#'
#' @param x a numeric matrix or data frame with at least 2 columns/variables.
#'   Each column contains observations on a different variable.  Missing
#'   observations are not allowed.
#' @return A named list of summary statistics containing
#'   * `n` The sample size.
#'   * `means` The sample means of each variable.
#'   * `variances` The sample means of each variable.
#'   * `correlation` The sample correlation matrix.
#'   * `intercepts`,`slopes`,`rsquared` Matrices whose (i,j)th entries are the
#'     estimated regression coefficients in a regression of `x[, i]` on
#'     `x[, j]` and the resulting coefficient of determination \eqn{R^2}.
#' @examples
#' get_stats(anscombe[, c(1, 5)])
#' @export
#' @md
get_stats <- function(x) {
   if (!is.matrix(x) && !is.data.frame(x)) {
     stop("x must be a matrix or a dataframe")
   }
   if (anyNA(x)) {
     stop("x must not contain any missing values")
   }
   res <- list()
   res$n <- nrow(x)
   res$means <- colMeans(x)
   res$variances <- apply(x, 2, stats::var)
   res$correlation <- stats::cor(x)
   nvar <- ncol(x)
   res$intercepts <- matrix(0, nvar, nvar)
   res$slopes <- matrix(1, nvar, nvar)
   res$rsquared <- matrix(1, nvar, nvar)
   # Deal with tibbles
   xdf <- as.data.frame(x)
   for (i in 2:nvar) {
     for (j in 1:(i - 1)) {
       fit <- stats::lm(xdf[, i] ~ xdf[, j])
       coefs <- coef(fit)
       res$intercepts[i, j] <- coefs[1]
       res$slopes[i, j] <- coefs[2]
       res$rsquared[i, j] <- summary(fit)$r.squared
       fit <- stats::lm(xdf[, j] ~ xdf[, i])
       coefs <- coef(fit)
       res$slopes[j, i] <- coefs[1]
       res$intercepts[j, i] <- coefs[2]
       res$rsquared[j, i] <- summary(fit)$r.squared
     }
   }
   dimnames(res$intercepts) <- list(colnames(x), colnames(x))
   dimnames(res$slopes) <- list(colnames(x), colnames(x))
   return(res)
}

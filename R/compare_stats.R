compare_stats <- function(x1, x2) {
  stats1 <- get_stats(x1)
  stats2 <- get_stats(x2)
  mapply(cbind, stats1, stats2, SIMPLIFY = FALSE)
}

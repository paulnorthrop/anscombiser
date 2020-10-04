context("mimic")

new_faithful <- mimic(datasets::faithful, anscombe[, c(4, 8)])
stats1 <- get_stats(new_faithful)
stats2 <- get_stats(anscombe[c(4, 8)])
# Remove the sample sizes because they will be different
stats1$n <- NULL
stats2$n <- NULL

test_that("mimic: new faithful and Anscombe 4 has same stats", {
  testthat::expect_equivalent(stats1, stats2)
})

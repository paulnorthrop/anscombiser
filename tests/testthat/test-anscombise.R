context("anscombise")

new_faithful <- anscombise(datasets::faithful, which = 4)
stats1 <- get_stats(new_faithful)
stats2 <- get_stats(anscombe[c(4, 8)])
# Remove the sample sizes because they will be different
stats1$n <- NULL
stats2$n <- NULL

test_that("New faithful and Anscombe 4 has same stats", {
  testthat::expect_equivalent(stats1, stats2)
})

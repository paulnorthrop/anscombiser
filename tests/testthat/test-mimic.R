#context("mimic")

# Old Faithful data mimicking Anscombe 4

new_faithful <- mimic(datasets::faithful, datasets::anscombe[, c(4, 8)])
stats1 <- get_stats(new_faithful)
stats2 <- get_stats(datasets::anscombe[c(4, 8)])
# Remove the sample sizes because they will be different
stats1$n <- NULL
stats2$n <- NULL

test_that("mimic: new faithful and Anscombe 4 have same stats", {
  testthat::expect_equal(stats1, stats2, ignore_attr = TRUE)
})

# New version of Old Faithful with zero means, unit variances, zero correlation

new_faithful <- mimic(faithful)
stats1 <- get_stats(new_faithful)
mat <- matrix(c(1, 0, 0, 1), 2, 2)
new_faithful <- mimic(faithful, means = 0, variances = 1, correlation = mat)
stats2 <- get_stats(new_faithful)

test_that("mimic: new faithful has the required stats", {
  testthat::expect_equal(stats1, stats2)
})

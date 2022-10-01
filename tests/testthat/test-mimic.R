#context("mimic")

# Old Faithful data mimicking Anscombe 4

# new_faithful <- mimic(datasets::faithful, datasets::anscombe[, c(4, 8)])
new_faithful <- mimic(datasets::faithful, anscombe4)
stats1 <- get_stats(new_faithful)
stats2 <- get_stats(datasets::anscombe[, c(4, 8)])
# Remove the sample sizes because they will be different
stats1$n <- NULL
stats2$n <- NULL

test_that("mimic: new faithful and Anscombe 4 have same stats", {
  testthat::expect_equal(stats1, stats2, ignore_attr = TRUE)
})

# New version of Old Faithful with zero means, unit variances, zero correlation

new_faithful <- mimic(datasets::faithful)
stats1 <- get_stats(new_faithful)
mat <- matrix(c(1, 0, 0, 1), 2, 2)
new_faithful <- mimic(datasets::faithful, means = 0, variances = 1,
                      correlation = mat)
stats2 <- get_stats(new_faithful)

test_that("mimic: new faithful has the required stats", {
  testthat::expect_equal(stats1, stats2)
})

# Check that idempotent = FALSE still works

new_faithful <- mimic(datasets::faithful, idempotent = FALSE)
stats1 <- get_stats(new_faithful)
mat <- matrix(c(1, 0, 0, 1), 2, 2)
new_faithful <- mimic(datasets::faithful, means = 0, variances = 1,
                      correlation = mat)
stats2 <- get_stats(new_faithful)

test_that("mimic: new faithful has the required stats, idempotent = FALSE", {
  testthat::expect_equal(stats1, stats2)
})

# Check that idempotent = TRUE achieves idempotency

## Old Faithful (2D)

new_faithful <- mimic(datasets::faithful, datasets::faithful)
stats1 <- get_stats(new_faithful)
stats2 <- get_stats(datasets::faithful)

test_that("mimic: idempotent = TRUE, stats agree", {
  testthat::expect_equal(stats1, stats2, ignore_attr = TRUE)
})
# Use as.matrix to deal with the differences in class
test_that("mimic: idempotent = TRUE, datasets agree", {
  testthat::expect_equal(as.matrix(new_faithful),
                         as.matrix(datasets::faithful), ignore_attr = TRUE)
})

## Diameter, Height and Volume for Black Cherry Trees (3D)

new_trees <- mimic(datasets::trees, datasets::trees)
stats1 <- get_stats(new_trees)
stats2 <- get_stats(datasets::trees)

test_that("mimic: idempotent = TRUE, stats agree", {
  testthat::expect_equal(stats1, stats2, ignore_attr = TRUE)
})
# Use as.matrix to deal with the differences in class
test_that("mimic: idempotent = TRUE, datasets agree", {
  testthat::expect_equal(as.matrix(new_trees),
                         as.matrix(datasets::trees), ignore_attr = TRUE)
})

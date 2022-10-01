#context("anscombise")

# Old Faithful data mimicking Anscombe 4

new_faithful <- anscombise(datasets::faithful, which = 4)
stats1 <- get_stats(new_faithful)
stats2 <- get_stats(datasets::anscombe[c(4, 8)])
# Remove the sample sizes because they will be different
stats1$n <- NULL
stats2$n <- NULL

test_that("anscombise: new faithful and Anscombe 4 have same stats", {
  testthat::expect_equal(stats1, stats2, ignore_attr = TRUE)
})

which_dataset <- 4

new_anscombe_4 <- anscombise(datasets::anscombe[c(which_dataset, which_dataset + 4L)], which = 4)
stats1 <- get_stats(new_anscombe_4)
stats2 <- get_stats(datasets::anscombe[c(4, 8)])

test_that("anscombise: new Anscombe 4 and Anscombe 4 have same stats", {
  testthat::expect_equal(stats1, stats2, ignore_attr = TRUE)
})

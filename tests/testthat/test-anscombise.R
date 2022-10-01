#context("anscombise")

# Old Faithful data mimicking Anscombe 4

new_faithful <- anscombise(datasets::faithful, which = 4)
stats1 <- get_stats(new_faithful)
#stats2 <- get_stats(datasets::anscombe[, c(4, 8)])
stats2 <- get_stats(anscombe4)
# Remove the sample sizes because they will be different
stats1$n <- NULL
stats2$n <- NULL

test_that("anscombise: new faithful and Anscombe 4 have same stats", {
  testthat::expect_equal(stats1, stats2, ignore_attr = TRUE)
})

# Test anscombise on the Anscombe datasets

## Idempotent = FALSE

for (i in 1:4) {
  which_dataset <- i
#  a_data <- datasets::anscombe[, c(which_dataset, which_dataset + 4L)]
  a_data <- switch(which_dataset, "1" = anscombe1, "2" = anscombe2,
                   "3" = anscombe3, "4" = anscombe4)
  new_anscombe <- anscombise(a_data, which = which_dataset, idempotent = FALSE)
  stats1 <- get_stats(new_anscombe)
  stats2 <- get_stats(a_data)
  the_text <- paste("anscombise: new Anscombe", which_dataset, "and Anscombe",
                    which_dataset, "have same stats")
  test_that("the_text", {
    testthat::expect_equal(stats1, stats2, ignore_attr = TRUE)
  })
}

## Idempotent = TRUE (alos check that input = output)

for (i in 1:4) {
  which_dataset <- i
#  a_data <- datasets::anscombe[, c(which_dataset, which_dataset + 4L)]
  a_data <- switch(which_dataset, "1" = anscombe1, "2" = anscombe2,
                   "3" = anscombe3, "4" = anscombe4)
  new_anscombe <- anscombise(a_data, which = which_dataset, idempotent = TRUE)
  stats1 <- get_stats(new_anscombe)
  stats2 <- get_stats(a_data)
  the_text <- paste("anscombise: new Anscombe", which_dataset, "and Anscombe",
                    which_dataset, "have same stats")
  test_that("the_text", {
    testthat::expect_equal(stats1, stats2, ignore_attr = TRUE)
  })
  the_text <- paste("Anscombe", which_dataset,
                    ": input = output when idempotent = TRUE")
  test_that("the_text", {
    testthat::expect_equal(as.matrix(a_data), as.matrix(new_anscombe),
                           ignore_attr = TRUE)
  })
}

# I looked at the plots
# plot(a_data)
# plot(new_anscombe)

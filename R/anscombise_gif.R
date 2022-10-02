#' Animation of several Anscombised datasets
#'
#' Create an animation to show datasets that share sample summary statistics
#' with [Anscombe's quartet][datasets::anscombe].
#'
#' @param x A list of input datasets.  Each one must be a suitable argument
#'   `x` for [`anscombise`].
#' @param which,idempotent Vectors that provide the arguments of the same names
#'   to [`anscombise`] for each dataset.  If necessary, [`rep_len`] is used to
#'   replicate these arguments so that the each have length `length(x)`.
#' @param theme_name A character scalar used to set the
#'   [`ggtheme`][`ggplot2::theme_bw`].
#'   One of `"grey"`, `"gray"`, `"bw"`, `"linedraw"`, `"light"`, `"dark"`,
#'   `"minimal"`, `"classic"`, `"void"` or `"test"`.
#' @param ease A character scalar passed to [`ease_aes`][`gganimate::ease_aes`]
#'   to control how the points move in transitioning from one dataset to
#'   the next.
#' @details For this function to work the packages
#'   [`ggplot2`][`ggplot2::ggplot2-package`] and
#'   [`gganimate`][`gganimate::gganimate-package`] must be installed.
#' @return An object of class `c("gganim", "gg", "ggplot")` with an additional
#'   attribute `new_data` that is a data frame with 3 variables, `x`, `y` and
#'   `dataset` containing the datasets output from `anscombise`.
#'
#'   The returned object may be displayed using by typing its name,
#'   e.g., `anim` or saved as a GIF file using
#'   [`anim_save`][`gganimate::anim_save`], e.g.,
#'   `gganimate::anim_save("anscombe.gif", anim)`.
#' @seealso [`anscombise`] modifies a dataset so that it shares sample summary
#'   statistics with [Anscombe's quartet][datasets::anscombe].
#' @seealso [`input_datasets`]: `input1` to `input8` for some input datasets
#'   of the same size as those in Anscombe's quartet.
#' @examples
#' # Animate some Anscombe-like datasets produced using input1 to input8
#' x <- list(input1, input2, input3, input4, input5, input6, input7, input8)
#' idem <- c(FALSE, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE)
#' anim <- anscombise_gif(x, idempotent = idem)
#' @export
#' @md
anscombise_gif <- function(x, which = 1, idempotent = TRUE,
                           theme_name = "classic", ease = "cubic-in-out") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package ''ggplot2'' is required. Please install it.")
  }
  if (!requireNamespace("gganimate", quietly = TRUE)) {
    stop("Package ''gganimate'' is required. Please install it.")
  }
  if (!is.list(x)) {
    stop("x must be a list")
  }
  # Check that theme_name is valid
  themes <- c("grey", "gray", "bw", "linedraw", "light", "dark", "minimal",
              "classic", "void", "test")
  if (!is.element(theme_name, themes)) {
    stop("''theme_name'' is not valid")
  }
  # Replicate which and idempotent to have the same length as x
  n_datasets <- length(x)
  which <- rep_len(which, n_datasets)
  idempotent <- rep_len(idempotent, n_datasets)
  # Call anscombise() for each dataset in the list x
  res <- mapply(anscombise, x, which, idempotent, SIMPLIFY = FALSE)
  # Convert the returned list to a data frame
  res <- as.data.frame(do.call(rbind, res))
  # Add a column containing the name of the dataset
  if (is.null(names(x))) {
    names(x) <- paste0("dataset", 1:n_datasets)
  }
  sample_sizes <- lapply(x, nrow)
  res[, "dataset"] <- rep(names(x), times = sample_sizes)
  # Rename the first 2 columns
  names(res) <- c("x", "y", "dataset")
  # Call ggplot2::ggplot to animate the plots
  animated_plots <- ggplot2::ggplot(res, ggplot2::aes(x = x, y = y)) +
    ggplot2::geom_point() +
    gganimate::transition_states(dataset, 3, 1) +
    gganimate::ease_aes(ease)
  animated_plots <- animated_plots +
    switch(theme_name,
           grey = ggplot2::theme_grey(),
           gray = ggplot2::theme_gray(),
           bw = ggplot2::theme_bw(),
           linedraw = ggplot2::theme_linedraw(),
           light = ggplot2::theme_light(),
           dark = ggplot2::theme_dark(),
           minimal = ggplot2::theme_minimal(),
           classic = ggplot2::theme_classic(),
           void = ggplot2::theme_void(),
           test = ggplot2::theme_test()
    )
  # Return the animated plots and the new data as as attribute new_data
  return(structure(animated_plots, new_data = res))
}

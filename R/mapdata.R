#' Extract longitude and latitude values
#'
#' Extracts longitude and latitude values for a particular region from the
#' world map supplied by the maps package.
#'
#' @param region Passed to [`map`][maps::map] as the argument `regions`.
#' @param map Passed to [`map`][maps::map] as the argument `database`
#' @param exact The argument `exact` passed to the [`map`][maps::map] function.
#' @return A dataframe with two columns: `long` and `lat` for longitude and
#'   latitude.
#' @section Examples:
#' See examples in [`mimic`].
#' @export
#' @md
mapdata <- function(region = '.', map = "world", exact = FALSE, ...) {
  locs <- maps::map(map, region, exact = exact, plot = FALSE, fill = TRUE, ...)
  locs <- na.omit(data.frame(long = locs$x, lat = locs$y))
  return(locs)
}

#' Add location coordinates
#' 
#' Adds longitude/latitude values to location data within an epiflows object.
#' Coordinates are added to object's location linelist as `lon` and `lat`
#' columns.
#' 
#' @param x An \code{epiflows} object.
#' @param loc_column Name of the column where location names are stored
#' (default: "country").
#' @param lon_lat_columns Names of the appended columns with longitudes
#' and latitudes, respectively (default: "lon" and "lat").
#' 
#' @return An updated \code{epiflows} object.
#' 
#' @author Pawel Piatkowski
#' 
#' @examples
#' flows <- make_epiflows(Mex_travel_2009[[2]], Mex_travel_2009[[1]])
#' flows <- add_coordinates(flows)
#' flows$linelist
#' 
#' @export
add_coordinates <- function(x,
                            loc_column = "country",
                            lon_lat_columns = c("lon", "lat")) {
  if (!"epiflows" %in% class(x)) {
    stop("`x` must be an object of class epiflows")
  }
  if (!loc_column %in% names(x$linelist)) {
    stop(sprintf("`%s` is not a valid column name", loc_column))
  }
  if (!is.character(lon_lat_columns) || length(lon_lat_columns) != 2) {
    stop("`lon_lat_columns` should contain exactly two character strings")
  }
  x$linelist[, lon_lat_columns] <- ggmap::geocode(
    as.character(x$linelist[, loc_column])
  )
  x
}
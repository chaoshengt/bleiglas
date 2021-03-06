#' tessellate
#'
#' Command line utility wrapper for the \href{http://math.lbl.gov/voro++}{voro++} software library.
#' voro++ must be installed on your system to use this function.
#'
#' @param x data.table/data.frame with the input points described by four variables (named columns):
#' \itemize{
#'   \item id: id number that is passed to the output polygon (integer)
#'   \item x: x-axis coordinate (numeric)
#'   \item y: y-axis coordinate (numeric)
#'   \item z: z-axis coordinate (numeric)
#' }
#' @param x_min minimum x-axis coordinate of the tessellation box. Default: min(x)
#' @param x_max maximum x-axis coordinate of the tessellation box. Default: max(x)
#' @param y_min minimum y-axis coordinate of the tessellation box. Default: min(y)
#' @param y_max maximum y-axis coordinate of the tessellation box. Default: max(y)
#' @param z_min minimum z-axis coordinate of the tessellation box. Default: min(z)
#' @param z_max maximum z-axis coordinate of the tessellation box. Default: max(z)
#' @param output_definition string that describes how the output file of voro++ should be structured.
#' This is passed to the -c option of the command line interface. All possible customization options
#' are documented \href{http://math.lbl.gov/voro++/doc/custom.html}{here}. Default: "\%i*\%P*\%t"
#' @param options string with additional options passed to voro++. All options are documented
#' \href{http://math.lbl.gov/voro++/doc/cmd.html}{here}. Default: "-v"
#' @param voro_path system path to the voro++ executable. Default: "voro++"
#'
#' @return raw, linewise output of voro++ in a character vector
#'
#' @examples
#' random_unique_points <- unique(data.table::data.table(
#'   id = NA,
#'   x = runif(10),
#'   y = runif(10),
#'   z = runif(10)
#' ))
#' random_unique_points$id <- 1:nrow(random_unique_points)
#'
#' voro_output <- tessellate(random_unique_points)
#'
#' polygon_points <- read_polygon_edges(voro_output)
#'
#' cut_surfaces <- cut_polygons(polygon_points, c(0.2, 0.4, 0.6))
#'
#' cut_surfaces_sf <- cut_polygons_to_sf(cut_surfaces, crs = 25832)
#' @export
tessellate <- function(
  x,
  x_min = NA, x_max = NA, y_min = NA, y_max = NA, z_min = NA, z_max = NA,
  output_definition = "%i*%P*%t", options = "-v",
  voro_path = "voro++"
) {
  
  checkmate::assert_data_frame(x)
  checkmate::assert_names(colnames(x), must.include = c("id", "x", "y", "z"))
  checkmate::assert_true(nrow(x) == nrow(unique(x[, c("x", "y", "z")])))
  checkmate::assert_number(x_min, na.ok = T)
  checkmate::assert_number(x_max, na.ok = T)
  checkmate::assert_number(y_min, na.ok = T)
  checkmate::assert_number(y_max, na.ok = T)
  checkmate::assert_number(z_min, na.ok = T)
  checkmate::assert_number(z_max, na.ok = T)
  checkmate::assert_string(output_definition, na.ok = F)
  checkmate::assert_string(options, na.ok = F)
  checkmate::assert_string(voro_path, na.ok = F)
  check_for_voro(voro_path)
  
  to_voro <- tempfile()
  from_voro <- paste0(to_voro, ".vol")

  utils::write.table(x, file = to_voro, quote = FALSE, row.names = F, col.names = F)

  system(paste(
    voro_path,
    # output string
    paste("-c", output_definition),
    # additional options
    options,
    # x_min x_max y_min y_max z_min z_max
    ifelse(is.na(x_min), min(x$x), x_min),
    ifelse(is.na(x_max), max(x$x), x_max),
    ifelse(is.na(y_min), min(x$y), y_min),
    ifelse(is.na(y_max), max(x$y), y_max),
    ifelse(is.na(z_min), min(x$z), z_min),
    ifelse(is.na(z_max), max(x$z), z_max),
    # input file
    to_voro
  ))

  poly_raw <- readLines(from_voro)
  return(poly_raw)
}

#' @keywords internal
#' @noRd
check_for_voro <- function(voro_path) {
  tryCatch({
    works <- !substr(system(paste(voro_path, "-h"), intern = TRUE)[1], 1, 6) == "Voro++"
  }, error = function(e) {
    stop_missing_voro()
  })
  if (works) {
    stop_missing_voro()
  }
}

#' @keywords internal
#' @noRd
stop_missing_voro <- function() {
  stop(
    "voro++ does not seem to be avaible. ",
    "Please make sure that it is installed (http://math.lbl.gov/voro++) ",
    "and that voro_path points to the executable."
  )
}


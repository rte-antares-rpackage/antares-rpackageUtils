#Copyright © 2016 RTE Réseau de transport d’électricité

#' Get and set Id columns
#' 
#' `idCols()` returns the id columns of an AntaresDataTable. `addIdCol()`
#' permits to declare new ID columns. This can be useful when one wants to
#' define new ID columns in an `antaresDataTable` containing for instance
#' simulation name or day of week, etc. 
#' 
#' @param x a data.table
#' @param exclude Columns to exclude in the result.
#'   
#' @return 
#' `idCols()` returns a character vector containing the name of the ID 
#' columns of an antaresDataTable. `addIdCol()` is only used for its side 
#' effects and returns nothing.
#' 
#' @export
#' 
idCols <- function(x, exclude = NULL) {
  assert_that(inherits(x, "data.table"))
  intersect(setdiff(pkgEnv$idCols, exclude), names(x))
}

#' @param colNames Name of new ID columns to declare.
#' @export
#' @rdname idCols
addIdCol <- function(colNames) {
  assert_that(is.character(colNames))
  pkgEnv$idCols <- union(pkgEnv$idCols, colNames)
  invisible(NULL)
}
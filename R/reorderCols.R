# Copyright © 2016 RTE Réseau de transport d’électricité

#' reorder the columns of an antaresDataTable
#' 
#' `reorderCols()` reorders the columns of an `antaresDataTable`. It puts first
#' the ID columns then the value columns.
#' 
#' @param x Object of class `antaresDataTable` or `data.table`.
#' 
#' @return 
#' The function modifies by reference the order of the columns of its input. For
#' convenience it invisibly returns the modified input.
#' 
#' @examples
#' require(data.table)
#' 
#' mydata <- data.table(LOAD = rexp(5), timeId = 1:5, BALANCE = rnorm(5))
#' reorderCols(mydata)
#' names(mydata)
#' 
#' @export
#' 
reorderCols <- function(x) {
  idCols <- getIdCols(x)
  neworder <- c(idCols, setdiff(names(x), idCols))
  setcolorder(x, neworder)
  invisible(x)
}

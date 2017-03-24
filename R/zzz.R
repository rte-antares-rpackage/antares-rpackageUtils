#' @import data.table
#' @import assertthat
#' 
#' @importFrom utils type.convert
#' @importFrom methods is

pkgEnv <- new.env()

# list of column names that are id variables in output files. When they are
# present in an output file, they are automatically imported, whatever the value
# of "select" is.
pkgEnv$idCols <- c("area", "district", "sector", "cluster", "link", "mcYear", 
                   "timeId", "time", "day", "week", "month", "hour")


globalVariables(c("timeId", "change"))

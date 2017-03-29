# Copyright © 2016 RTE Réseau de transport d’électricité
#' Merge two tables by reference
#' 
#' This function can be used when one wants to get exactly the same table but
#' with some new columns got from a another table. Technically this is equivalent 
#' to a left join without row duplication. Unlike with the default 
#' [merge][base::merge()] 
#' function, `mergeByRef()` does not copy data; it modifies it by reference. 
#' This results in a great performance improvement.
#' 
#' @param x data.table or object inheriting from data.table.
#' @param y data.table or object inheriting from data.table.
#' @param by Name of columns used for merging. By default, the function uses
#'   all common columns.
#' @param colsToAdd Name of columns of `y` to add to `x`. By default
#'   the function adds all columns of `y` that are not in `x`.
#' 
#' @return
#' `mergeByRef()` modifies its first input by reference so it is used for its
#' side effects. Nevertheless for convenience it invisibly returns `x` with
#' the new columns appended
#' 
#' @examples 
#' 
#' require(data.table)
#' 
#' x <- data.table(a = 1:5, b = rnorm(5))
#' y <- data.table(a = 1:5, c = rnorm(5))
#' 
#' # Add the "c" column from y to x
#' mergeByRef(x, y)
#' names(x)
#' 
#' @export
mergeByRef <- function(x, y, by = intersect(names(x), names(y)), 
                        colsToAdd = setdiff(names(y), by)) {
  # Check arguments
  assert_that(inherits(x, "data.table"))
  assert_that(inherits(y, "data.table"))
  
  assert_that(not_empty(by))
  assert_that(is.character(by))
  for (v in by) {
    assert_that(x %has_name% v)
    assert_that(y %has_name% v)
  }
  
  assert_that(not_empty(colsToAdd))
  assert_that(is.character(colsToAdd))
  for (v in colsToAdd) {
    assert_that(y %has_name% v)
  }
  
  oldKey <- key(x)
  
  # Merge the tables
  setkeyv(x, by)
  setkeyv(y, by)
  x[y, c(colsToAdd) := mget(paste0("i.", colsToAdd))]
  
  setkeyv(x, oldKey)
  invisible(x)
}

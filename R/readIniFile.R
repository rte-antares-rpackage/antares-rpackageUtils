#Copyright © 2016 RTE Réseau de transport d’électricité

#' Read and write an .ini file
#' 
#' These function read and write the content of an .ini file and converts to a list.
#' 
#' @details
#' A .ini file has the following structure:
#' ```
#' [section1]
#' key1 = value1
#' key2 = value2
#' [section2]
#' key3 = value3
#' ...
#' ```
#' readIniFile converts it to a list with the following format:
#' 
#' ```
#' list(
#'   section1 = list(key1 = value1, key2 = value2),
#'   section2 = list(key3 = value3),
#'   ...
#' )
#' ```
#' 
#' writeIniFile do the opposite operation.
#' 
#' @param file file path
#' @param stringsAsFactors Should string values treated as factors?
#'
#' @return
#' A list with an element for each section of the .ini file.
#' 
#' @export
readIniFile <- function(file, stringsAsFactors=FALSE) {
  X <- readLines(file)
  sections <- grep("^\\[.*\\]$", X)
  starts <- sections + 1
  ends <- c(sections[-1] - 1, length(X))
  L <- vector(mode="list", length=length(sections))
  names(L) <- gsub("\\[|\\]", "", X[sections])
  for(i in seq(along = sections)){
    if (starts[i] >= ends[i]) next
    pairs <- X[seq(starts[i], ends[i])]
    pairs <- pairs[pairs != ""]
    pairs <- strsplit(pairs, "=")

    key <- sapply(pairs, function(p) trimws(p[1]))
    value <- lapply(pairs, function(p) {
      v <- trimws(p[2])
      if (v == "true") return(TRUE)
      if (v == "false") return(FALSE)
      type.convert(v, as.is = !stringsAsFactors)
    })

    L[[i]] <- value
    names(L[[i]]) <- key
  }
  L
}

#' @param x Named list (see details).
#' @param overwrite Should the function overwrite the file if it already exists.
#' 
#' @export
#' @rdname readIniFile
writeIniFile <- function(x, file, overwrite = FALSE) {
  if (!overwrite & file.exists(file)) stop("File already exists.")

  file <- file(file, open = "w")

  for (n in names(x)) {
    cat(paste0("[", n,"]\n"), file = file)
    for (k in names(x[[n]])) {
      v <- x[[n]][[k]]
      if (is.na(v)) v <- ""
      if (is.logical(v)) v <- ifelse(v, "true", "false")
      cat(k, " = ", v, "\n", file = file, sep = "")
    }
    cat("\n", file = file)
  }

  close(file)
}

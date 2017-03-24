#' Convert a time id to a date
#' 
#' This function can be used to convert times ids to dates. If time step is 
#' hourly, it returns a POSIXct vector, else it always returns a date object.
#' For weekly, monthly and annual time step, it returns the first day of the
#' week, month or year.
#' 
#' @param timeId A numeric vector
#' @param timeStep Character string indicating the time step of the parameter
#'   `timeId`.
#' @param opts Simulation options. It must at least contain elements `start` and
#'   and `firstWeekday`.
#'   
#' @return
#' A vector with same length as `timeId`. If `timeStep = "hourly"`, the result
#' is a `POSIXct` vector, else it is a `Date` vector.
#' 
#' @export
#' 
timeIdToDate <- function(timeId, timeStep=c("hourly", "daily", "weekly", "monthly", "annual"), 
                         opts=simOptions()) {
  timeStep <- match.arg(timeStep)
  
  if (timeStep == "hourly") {
    
    timestamp <- as.POSIXct(opts$start)
    lubridate::hour(timestamp) <- lubridate::hour(timestamp) + 1:(24*365) - 1
    
    return(timestamp[timeId])
    
  } else if (timeStep == "daily") {
    
    date <- as.Date(opts$start)
    date <- date + 1:365 - 1
    
    return(date[timeId])
    
  } else if (timeStep == "weekly") {
    
    timestamp <- as.POSIXct(opts$start)
    lubridate::hour(timestamp) <- lubridate::hour(timestamp) + 1:(24*365) - 1
    
    weekId <- .getTimeId(1:(24*365), "weekly", opts)
    date <- as.Date(tapply(timestamp, weekId, function(x) as.Date(min(x))), origin = "1970-1-1")
    date[1] <- date[2] - 7
    
    week <- date #format(date, format = "%G-w%V")
    
    return(unname(week[timeId]))
    
  } else if (timeStep == "monthly") {
    
    timestamp <- as.POSIXct(opts$start)
    lubridate::hour(timestamp) <- lubridate::hour(timestamp) + 1:(24*365) - 1
    
    monthId <- .getTimeId(1:(24*365), "monthly", opts)
    month <- as.Date(tapply(timestamp, monthId, function(x) as.Date(min(x))), origin = "1970-1-1")
    # month <- tapply(timestamp, monthId, function(x) format(min(x), format = "%Y-%m"))
    
    return(unname(month[timeId]))
    
  } else {
    
    date <- as.Date(opts$start)
    return(rep(date, length(timeId)))
    
  }
}
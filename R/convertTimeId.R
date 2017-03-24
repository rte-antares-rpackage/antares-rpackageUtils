# Copyright © 2016 RTE Réseau de transport d’électricité

#' Convert an hourly timeId at a given time step
#' 
#' This function converts a vector of hourly time ids in time ids in another 
#' time step.
#' 
#' @param hourId A numeric vector containing hourly time ids.
#' @param timeStep timeStep of the result.
#' @param opts Simulation options. It must contain elements `start` (first date 
#'   time of the study) and `firstWeekday`
#' 
#' @return 
#' A numeric vector with same length as `hourId` reprensenting the
#' corresponding time ids at the required time step.
#' 
#' @examples 
#' opts <- list(
#'   start = as.POSIXlt("2017-01-01", tz = "UTC"),
#'   firstWeekday = "Monday"
#' )
#' 
#' hourId <- 1:(24*14)
#' table(convertTimeId(hourId, "daily", opts))
#' table(convertTimeId(hourId, "weekly", opts))
#' 
#' @export
convertTimeId <- function(hourId, timeStep, opts) {
  # Easy cases
  if (timeStep == "hourly") return(hourId)
  
  if (timeStep == "daily") {
    return( (hourId - 1) %/% 24 + 1 )
  }
  
  if (timeStep == "annual") {
    return(rep(1L, length(hourId)))
  }
  
  # Hard cases
  # Create a correlation table between hourIds and actual dates and compute new 
  # timeIds based on the actual dates
  timeRef <- data.table(hourId = 1:(24*365))
  
  tmp <- as.POSIXct(opts$start)
  lubridate::hour(tmp) <- lubridate::hour(tmp) + timeRef$hourId - 1
  timeRef$hour <- tmp
  
  if (timeStep == "weekly") {
    timeRef$wday <- lubridate::wday(timeRef$hour)
    startWeek <- which(c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday") == opts$firstWeekday)
    timeRef[, change := wday == startWeek & wday != shift(wday)]
    timeRef$change[1] <- TRUE
    timeRef[, timeId := cumsum(change)]
    
    return(timeRef$timeId[hourId])
  }
  
  if (timeStep == "monthly") {
    timeRef$month <- lubridate::month(timeRef$hour)
    timeRef[, change :=  month != shift(month)]
    timeRef$change[1] <- TRUE
    timeRef[, timeId := cumsum(change)]
    
    return(timeRef$timeId[hourId])
  }
  
}
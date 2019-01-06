library(plumber)
source("./util.R")
source("./properties.R")

#* @willItain Simple API

#* Calculate rain percentage
#* @param stationid:int station identifier
#* @param month:int to calculate percentages
#* @param day:int of the month
#* @get /rainpercentage
rainpercentage <- function (stationid, month, day=NULL) {
  stationid <- as.integer(stationid)
  month <- as.integer(month)
  
  if(!is.month.valid(as.integer(month))){
    stop("Invalid Month")
  }
  
  if(!is.null(day) && !is.day.valid(as.integer(day))){
    stop("Invalid Day")
  }
  
  if (is.null(day)) {
    return(get.month.data(stationid,month));
  } else {
    day <- as.integer(day)
    return(get.day.data(stationid,month,day));
  }
  
}

#* Get available countries
#* @get /countries
countries <- function() {
  return(get.available.countries());
}

#* Get available countries
#* @get /stations/<country>
stations <- function(country) {
  return(get.stations.by.country(country));
}

#* @filter cors
cors <- function(res) {
    res$setHeader("Access-Control-Allow-Origin", "*")
    plumber::forward()
}

#* Browser Client app
#* @assets ./client-browser/dist /
list()

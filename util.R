library(countrycode)

get.station.data.by.id <- function (stationid) {
  return (readRDS(paste(processed.folder,stationid,".rds",sep="")))
}

get.month.data <- function (stationid, month) {
  data <- get.station.data.by.id(stationid)
  return(data[[month]])
}

get.day.data <- function (stationid, month, day) {
  month <- get.month.data(stationid, month)
  return(month[day,])
}

is.month.valid <- function (month) {
  return(is.numeric(month) && month>=1 && month<=12 )
}

is.day.valid <- function (day) {
  return(is.numeric(day) && day>=1 && day<=31 )
}

get.available.countries <- function() {
  country.codes <- (sort(unique(readRDS(paste(processed.folder,"stations.rds",sep=""))$CN)))
  return (data.frame(code=country.codes, name=countrycode(country.codes,"iso2c","country.name.en",nomatch = NULL)))
}

get.stations.by.country <- function(country) {
  station.data <- readRDS(paste(processed.folder,"stations.rds",sep=""))
  stations <- subset(station.data,  station.data$CN==country)
  return(data.frame(id=stations$STAID, name=trimws(stations$STANAME), row.names = seq_along(1:nrow(stations))))
}

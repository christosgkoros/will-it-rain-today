library(countrycode)

calculate.month.percentages <- function(data, month) {
  #day iteration
  for (i in 1:31) {
    daypattern <- paste(".*", 
                        as.character(month), 
                        ifelse(i<10, paste("0", as.character(i), sep=""),
                               as.character(i)),
                        "$",
                        sep="")
    daydata <- subset(data, grepl(daypattern, data$DATE))
    yearsrecorded <- nrow(daydata);
    yearswithrain <- nrow(subset(daydata, RR>0))
    if (i == 1 ) {
      percentages <- data.frame(matrix(ncol = 3, nrow = 0))
      col.names <- c("day","years_with_rain", "percentage")
      percentages <- rbind(percentages, c(i, yearswithrain , (yearswithrain / yearsrecorded *100)))
      colnames(percentages) <- col.names
    } else if (yearswithrain > 0){
      percentages <- rbind(percentages, c(i, yearswithrain , (yearswithrain / yearsrecorded *100)))
    }
  }
  return(percentages)
}

calculatePercentages <- function (dataObj) {
  z <- list()
  station.id <- dataObj$STAID[1]
  #month iteration
  for (month in 1:12){
    print(paste("calculating percetnages for station id",station.id, "month", month))
    month.percentages <- calculate.month.percentages(dataObj, month)
    z[[month]] <- month.percentages
  }
  return(z)
}

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
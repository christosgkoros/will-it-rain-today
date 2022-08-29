# Title     : Data utils
# Objective : Functions for data processing
# Created by: GkorosC
# Created on: 08-Nov-20


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

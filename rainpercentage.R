rainpercentage <- function (month){
  
  data <- read.csv("RR_STAID000060.txt",header = TRUE)
  data <- subset(data, Q_RR == 0)
  for (i in 1:31) {
    sql <- paste("select * from data where DATE like '%",as.character(month),ifelse(i<10, paste("0",as.character(i),sep=""),as.character(i)),"'",sep="")
    daydata <- sqldf(sql);
    yearsrecorded <- nrow(daydata);
    yearswithrain <- nrow(subset(daydata, RR>0))
    if (i == 1) {
      percentages <- data.frame(matrix(ncol = 3, nrow = 0))
      x <- c("day","years_with_rain", "percentage")
      percentages <- rbind(percentages, c(i, yearswithrain , (yearswithrain / yearsrecorded *100)))
      colnames(percentages) <- x
    } else {
      percentages <- rbind(percentages, c(i, yearswithrain , (yearswithrain / yearsrecorded *100)))
    }
  }
  return(percentages);
}
averagetemp <- function (month){
  
  
  data <- read.csv("/Users/gkoro/Desktop/TN_STAID000060.txt",header = TRUE)
  data <- subset(data, Q_TN == 0)
  for (i in 1:31) {
    sql <- paste("select * from data where DATE like '%",as.character(month),ifelse(i<10, paste("0",as.character(i),sep=""),as.character(i)),"'",sep="")
    daydata <- sqldf(sql);
    
    
    yearsrecorded <- nrow(daydata);
    sumtemperature <- sum(daydata$TN)/10
    
    
    if (i == 1) {
      averagetemp <- data.frame(matrix(ncol = 3, nrow = 0))
      x <- c("day", "average_temp")
      
      averagetemp <- rbind(averagetemp, c(i, sumtemperature / yearsrecorded))
      
      colnames(averagetemp) <- x
    } else {
      averagetemp <- rbind(averagetemp, c(i, sumtemperature / yearsrecorded))
    }
  }
  return(averagetemp);
}
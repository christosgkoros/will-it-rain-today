# Title     : Process data
# Objective : Process raw data & generate statistics / produce artifacts with processed data
# Created by: GkorosC
# Created on: 31-Oct-20

source("./data_utils.R")

raw.data <- readRDS("raw.data.rds")

#station iteration
for (dataObj in raw.data) {
  if (!is.null(dataObj)) {
    station.id <- dataObj$STAID[1]
    station.processed <- calculatePercentages(dataObj)
    saveRDS(station.processed, file = paste("./processed/",station.id, ".rds", sep=""))
  }
}

station.data <- read.csv(paste(data.folder,"stations.txt",sep=""),header = TRUE, sep=",", skip = 17)
saveRDS(station.data,"./processed/stations.rds")

# Title     : Raw Data
# Objective : Extract raw data from ECA csv files and create an RDS dataset
# Created by: GkorosC
# Created on: 31-Oct-20

source("./data_props.R")

#clean-up
print(paste("Cleaning up"))
if (file.exists(data.zip.file)) {
  #Delete file if it exists
  file.remove(data.zip.file)
}
unlink(data.extracted.folder, recursive = TRUE)

#download
print(paste("Start downloading", data.url))
options(timeout = max(300, getOption("timeout"))) #set a large timeout value, the file is big
download.file(data.url, data.zip.file, "auto")

#unzip
print(paste("Unzipping", data.zip.file))
unzip(data.zip.file, exdir = data.extracted.folder)

#process
files.list <- list.files(path = data.folder, pattern=data.file.pattern, all.files = TRUE)
print("processing station data")
station.data <- read.csv(paste(data.folder, station.file, sep="/"), header = TRUE, sep = ",", skip=17)

#validate station number
if(length(files.list) != nrow(station.data)) {
  print(paste("WARNING: number of data files is different than the number of station ids!", length(files.list), nrow(station.data)))
}
station.no <- length(files.list)


raw.data <- list()

if (file.exists(raw.filename)) {
  print(paste0("File already exists ", raw.filename, " skipping"));
  raw.data <- readRDS(raw.filename)
} else {
 for (file in files.list) {
   print(paste("processing",file))
   file.location <- paste(data.folder, file, sep="/")
   fileData <- read.csv(file.location, header = TRUE, sep = ",", skip=20)
   fileData <- subset(fileData, Q_RR == 0)
   if ( nrow(fileData) > 0 ) { 
     station.id <- fileData$STAID[1]

     #validate station id
     if ( !(station.id %in% station.data$STAID)) {
       print("ERROR: Station id not in registered stations. Please check your data integrity")
       exit();
     }

     raw.data[[station.id]] <- fileData
     print("processed")
   }
   else {
     print("suspect or missing data")
   }

 }
  saveRDS(raw.data, file = raw.filename)
}

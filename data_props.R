data.url <- "https://knmi-ecad-assets-prd.s3.amazonaws.com/download/ECA_blend_rr.zip"
data.zip.file <- "ECA_blend_rr.zip"
data.extracted.folder <- "ECA_blend_rr"
workspace <- getwd()
data.folder <- paste(workspace, data.extracted.folder, sep="/")

data.file.pattern <- "RR_STAID.*"
station.file <- "stations.txt"
raw.filename <- "raw.data.rds"

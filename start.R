library(plumber)
source("./properties.R")
plumber::plumb("./plumber.R")$run(host='0.0.0.0', port = server.port)
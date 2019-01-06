source ("./util.R")

test_get.stations.by.country <- function() {
  get.stations.by.country("GR")
}

test_is.month.valid_success <- function () {
  is.month.valid(1)
}

test_is.month.valid_fail_string <- function () {
  is.month.valid('a')
}


test_is.month.valid_fail_oob <- function () {
  is.month.valid(22)
}

test_get.station.data.by.id <- function () {
  get.station.data.by.id(1);
}

test_get.month.data <- function () {
  get.month.data(1,1);
}

test_get.day.data <- function () {
  month <- get.month.data(1, 1)
  month[1,]
}
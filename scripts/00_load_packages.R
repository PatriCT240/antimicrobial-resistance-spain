packages <- c(
  "readr", "ggplot2", "gridExtra", "reshape2", "formattable",
  "FactoMineR", "factoextra", "corrplot", "tidyr", "dplyr",
  "paletteer", "dichromat", "forecast", "lubridate", "zoo",
  "rattle", "rpart", "yardstick"
)

lapply(packages, library, character.only = TRUE)

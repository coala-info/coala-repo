# Code example from 'JASPAR2024' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(JASPAR2024)
library(RSQLite)

JASPAR2024 <- JASPAR2024()
JASPARConnect <- RSQLite::dbConnect(RSQLite::SQLite(), db(JASPAR2024))
RSQLite::dbGetQuery(JASPARConnect, 'SELECT * FROM MATRIX LIMIT 5')
dbDisconnect(JASPARConnect)


## ----session_info, echo=FALSE-------------------------------------------------
sessionInfo()


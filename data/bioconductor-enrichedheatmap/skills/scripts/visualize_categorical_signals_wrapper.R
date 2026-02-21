# Code example from 'visualize_categorical_signals_wrapper' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE----------------------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    warning = FALSE,
    message = FALSE)
library(markdown)
options(width = 100)

## ----eval = grepl("tbi", Sys.info()["nodename"]) & Sys.info()["user"] == "guz", echo = FALSE------
# knit("visualize_categorical_signals", output = "visualize_categorical_signals.md", quiet = TRUE)

## ----echo = FALSE, results = "asis"---------------------------------------------------------------
lines = readLines("visualize_categorical_signals.md")
cat(lines, sep = "\n")


# Code example from 'BrowserViz' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----jsonlite,  results='hide'------------------------------------------------
  library(jsonlite)
  msg <- toJSON(list(cmd="setBrowserWindowTitle",
                     status="request", 
                     callback="handleResponse",
                     payload="BrowserViz demo"))

## ----roundTripTest,  eval=FALSE, results='hide'-------------------------------
# library(BrowserViz)
# browserVizBrowserFile <- system.file(package="BrowserViz", "browserCode",
#                                      "dist", "bvDemoApp.html")
# PORT_RANGE <- 12111:12120
# if(BrowserViz::webBrowserAvailableForTesting()){
#    bvApp <- BrowserViz(browserFile=browserVizBrowserFile, quiet=TRUE)
#    data <- list(lowercase=letters, uppercase=LETTERS)
#    json.returned <- roundTripTest(bvApp, data)
#    data.returned <- fromJSON(json.returned)
#    message(sprintf("    %5d bytes exchanged", nchar(json.returned)))
#    stopifnot(data == data.returned)
#    html <- sprintf("<h3>round trip of json-encoded data, %d chars</h3>",
#                    nchar(json.returned))
#    displayHTMLInDiv(bvApp, html, "bvDemoDiv")
#    }


# Code example from 'FastRWebDeployment' vignette. See references/ for full tutorial.

## ----echo = FALSE--------------------------------------------------------
options(markdown.HTML.options = "toc")

## ----eval = FALSE--------------------------------------------------------
#  install.packages(c('Rserve','FastRWeb'),,'http://www.rforge.net/')

## ----eval = FALSE--------------------------------------------------------
#  system(paste("cd",system.file(package="FastRWeb"),"&& install.sh"))

## ----landing-page, echo = FALSE------------------------------------------
f <- formals(AnalysisPageServer::new.FastRWeb.analysis.page.run)
unslash <- function(x) sub("/+$", "", sub("^/+", "", x))
landingPageURL <- file.path("http://localhost", 
                            unslash(f$FastRWeb.prefix),
                            "APS",
                            unslash(f$front.end.location),
                            "analysis-page-server.html")

## ----eval = FALSE--------------------------------------------------------
#  library(AnalysisPageServer)
#  
#  x <- rep(1:nrow(volcano), each = ncol(volcano))
#  y <- rep(1:ncol(volcano), nrow(volcano))
#  volcano.cells <- data.frame(x = x, y = y, Height = as.vector(t(volcano)))
#  
#  volcano.handler <- function(color1 = "red", color2 = "blue") {
#    par(mar = c(1, 1, 4, 1))
#    chosen.colors <- c(color1, color2)
#    col <- colorRampPalette(chosen.colors)(50)
#    image(datasets::volcano, xaxt = "n", yaxt = "n", main = "Maunga Whau Volcano",
#          col = col, cex.main = 2)
#  
#    return(volcano.cells)
#  }
#  
#  volcano.page <- new.analysis.page(handler = volcano.handler, name = "volcano",
#      description = "Draw the Maunga Whau Volcano in Two Colors")
#  reg <- new.registry(volcano.page)
#  
#  run <- new.FastRWeb.analysis.page.run(reg,
#                                        FastRWeb.scriptname = "APS")

## ----eval = FALSE--------------------------------------------------------
#  library(MyAPSPackage)
#  myRun <- new.FastRWeb.analysis.page.run(myAPSRegistry(),
#                                          FastRWeb.scriptname = "APS")

## ----eval = FALSE--------------------------------------------------------
#  run <- myRun

## ----eval = FALSE--------------------------------------------------------
#  killall Rserve
#  /var/FastRWeb/code/start

## ----eval = FALSE--------------------------------------------------------
#  library(AnalysisPageServer)
#  
#  x <- rep(1:nrow(volcano), each = ncol(volcano))
#  y <- rep(1:ncol(volcano), nrow(volcano))
#  volcano.cells <- data.frame(x = x, y = y, Height = as.vector(t(volcano)))
#  
#  volcano.handler <- function(color1 = "red", color2 = "blue") {
#    par(mar = c(1, 1, 4, 1))
#    chosen.colors <- c(color1, color2)
#    col <- colorRampPalette(chosen.colors)(50)
#    image(datasets::volcano, xaxt = "n", yaxt = "n", main = "Maunga Whau Volcano",
#          col = col, cex.main = 2)
#  
#    return(volcano.cells)
#  }
#  
#  volcano.page <- new.analysis.page(handler = volcano.handler, name = "volcano",
#      description = "Draw the Maunga Whau Volcano in Two Colors")
#  reg <- new.registry(volcano.page)
#  
#  run <- new.FastRWeb.analysis.page.run(reg,
#                                        FastRWeb.scriptname = "APS")


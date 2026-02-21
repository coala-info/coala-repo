# Code example from 'embedding' vignette. See references/ for full tutorial.

## ----message=FALSE, echo = FALSE-----------------------------------------
library(AnalysisPageServer)
setup.APS.knitr()

## ----results = "hide", echo = FALSE--------------------------------------
## Since the filenames have some randomness, this is just
## a trick to keep the output directory clean if the file
## is knitted more than once.
plotdir <- "embed-example"
if(file.exists(plotdir))
  unlink(dir(plotdir, full = TRUE))

## ----eval = FALSE--------------------------------------------------------
#  library(AnalysisPageServer)
#  setup.APS.knitr()

## ----eval = FALSE--------------------------------------------------------
#  x <- seq(0, 2*pi, length = 100)
#  y <- sin(x) + rnorm(100)/10
#  col <- adjustcolor(heat.colors(100), alpha.f = 0.6)
#  embed.APS.dataset({
#                      plot(x, y, col = col, pch = 19)
#                    },
#                    df = data.frame(x=x, y=y, X=x, Y=y),
#                    title = "A shaky sine curve",
#                    data.subdir = "embed-example")

## ----echo = FALSE--------------------------------------------------------
## Remember this to show later
x <- seq(0, 2*pi, length = 100)
y <- sin(x) + rnorm(100)/10
col <- adjustcolor(heat.colors(100), alpha.f = 0.6)
div.html <- embed.APS.dataset({
                                plot(x, y,
                                     col = col,
                                     pch = 19)
                              },		     
                              df = data.frame(x=x, y=y, X=x, Y=y),
                              title = "A shaky sine curve",
                              data.subdir = "embed-example")
div.html

## ------------------------------------------------------------------------
x <- rep(1:nrow(volcano), each = ncol(volcano))
y <- rep(1:ncol(volcano), nrow(volcano))
volcano.cells <- data.frame(x = x, y = y, Height = as.vector(t(volcano)))
embed.APS.dataset({
                    image(volcano, xaxt = "n", yaxt = "n", main = "Maunga Whau Volcano")
                  },                
                  df = volcano.cells,
                  title = "", data.subdir = "embed-example",
                  show.table = FALSE, show.sidebar = FALSE,
                  show.xy = TRUE,     
                  extra.div.attr = c(style = "width:60%; margin:0 auto"))

## ------------------------------------------------------------------------
embed.APS.dataset(df = iris,
                  title = "Iris data with no plot", data.subdir = "embed-example")

## ----eval = FALSE--------------------------------------------------------
#  basedir <- dirname(html.file)
#  copy.front.end(basedir)

## ------------------------------------------------------------------------
cat(custom.html.headers())

## ----echo = FALSE--------------------------------------------------------
cat(div.html)


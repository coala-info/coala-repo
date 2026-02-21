# Code example from 'InteractiveApps' vignette. See references/ for full tutorial.

## ----echo = FALSE--------------------------------------------------------
options(markdown.HTML.options = "toc")

## ----echo = FALSE, message=FALSE-----------------------------------------
library(AnalysisPageServer)
rookforkOK <- AnalysisPageServer:::checkRookForkForVignettes()

## ----eval=FALSE----------------------------------------------------------
#  volcano <- build.service(function(colors = c("red","white","purple"))  {
#    plotfile <- tempfile(fileext = ".png")
#    png(plotfile, width = 600, height = 400)
#    par(mar=c(1, 1, 4, 1))
#    col <- colorRampPalette(colors)(50)
#    image(datasets::volcano, xaxt = "n", yaxt = "n", main = "Maunga Whau Volcano",
#          col = col, cex.main = 2)
#    dev.off()
#  
#    plot.data <- readBin(plotfile, "raw", n = file.info(plotfile)[, "size"])
#  
#    new.response(body = plot.data,
#       content.type = "image/png")
#  }, name = "volcano")

## ----eval=TRUE-----------------------------------------------------------
x <- rep(1:nrow(volcano), each = ncol(volcano))
y <- rep(1:ncol(volcano), nrow(volcano))
volcano.cells <- data.frame(x = x, y = y, Height = as.vector(t(volcano)))

## ----eval = FALSE--------------------------------------------------------
#  plotfile3 <- tempfile(fileext = ".svg")
#  svg(filename = plotfile3, width = 9, height = 7)
#  image(volcano, xaxt = "n", yaxt = "n", main = "Maunga Whau Volcano")
#  dev.off()
#  result <- static.analysis.page(outdir = "static-example3",
#                       svg.files = plotfile3,
#                       dfs = volcano.cells,
#                       show.xy = TRUE,
#                       title = "Maunga Whau Volcano")

## ----message = FALSE-----------------------------------------------------
port <- 5333
library(AnalysisPageServer)
volcano.handler <- function(color1 = "red",
                                      color2 = "blue")  {

  par(mar=c(1, 1, 4, 1))
  chosen.colors <- c(color1, color2)
  col <- colorRampPalette(chosen.colors)(50)
  image(datasets::volcano, xaxt = "n", yaxt = "n", main = "Maunga Whau Volcano",
        col = col, cex.main = 2)

  return(volcano.cells)  
}
volcano.page <- new.analysis.page(handler = volcano.handler,
                                  name = "volcano",
                                  description = "Draw the Maunga Whau Volcano in Two Colors")
reg <- new.registry(volcano.page)
srv <- startRookAnalysisPageServer(reg, port = port)

## ----eval = FALSE--------------------------------------------------------
#  on.exit(kill.process(srv))

## ------------------------------------------------------------------------
rook.analysis.page.server.landing.page(srv)

## ------------------------------------------------------------------------
kill.process(srv)

## ----message=FALSE-------------------------------------------------------
cars.df <- cbind(x = cars$speed, y = cars$dist, cars)
cars.page <- new.analysis.page(function() {
  plot(cars.df$x, cars.df$y, xlab = "Speed", ylab =
       "Stopping Distance", pch = 19, col = adjustcolor(1, alpha.f = 0.6))
  cars.df
}, name = "cars", description = "Speed and Stopping Distances of Cars")
reg <- new.registry(cars.page, volcano.page)
srv <- startRookAnalysisPageServer(reg, port = port)

## ------------------------------------------------------------------------
kill.process(srv)

## ----message=FALSE-------------------------------------------------------
color.choices <- c("red", "orange", "yellow", "green", "blue", "purple")
color1 <- select.param(name = "color1", label = "Low Color",
  description = "<strong>Select</strong> a color for the lowest parts of the volcano", choices = color.choices)
color2 <- select.param(name = "color2", label = "High Color",
  description = "<strong>Select</strong> a color for the highest parts of the volcano", choices = color.choices)
color.pset <- param.set(color1, color2)
volcano.page <- new.analysis.page(handler = volcano.handler,
                                  param.set = color.pset,
                                  name = "volcano",
                                  description = "Draw the Maunga Whau Volcano in Two Colors")
reg <- new.registry(volcano.page)
srv <- startRookAnalysisPageServer(reg, port = port)

## ------------------------------------------------------------------------
color.param <- function(name = "color",
                        label = "Color",
                        description = "<strong>Select</strong> a color from the list", ...)  {
  select.param(name = name, label = label, description = description,
               choices = color.choices, ...)
}

## ----eval = FALSE--------------------------------------------------------
#  color1 <- color.param("color1", label = "Low Color")
#  color2 <- color.param("color1", label = "High Color")

## ------------------------------------------------------------------------
kill.process(srv)

## ------------------------------------------------------------------------
slider <- slider.param(name = "n",  min = 0, max = 100, step = 1, value = 50,
                       description = "Select a number between 0 and 100")
handler <- function(n=50)  {
  ## n is already numeric for a slider---no need to cast with as.numeric(n)
  html <- paste0("<h3>This is an HTML response</h3>",
                 "<ul>",
                 "  <li>n = ", n, "</li>",
                 "  <li>n+1 = ", n+1, "</li>",
                 "</ul>")

  ## This is how to have your page return arbitrary HTML, rather than
  ## the typical plot/dataset combination
  new.datanode.html("html", html)
}
slider.page <- new.analysis.page(handler,
   param.set = param.set(slider),
   annotate.plot = FALSE,
   annotate.data.frame = FALSE,
   no.plot = TRUE,
   label  = "slider widget with HTML response")
reg <- new.registry(slider.page)
srv <- startRookAnalysisPageServer(reg, port = port)

## ------------------------------------------------------------------------
kill.process(srv)

## ----eval = FALSE--------------------------------------------------------
#  volcano.handler <- function(color1 = "red",
#                              color2 = "blue",
#                              color3 = "green")  {
#  
#    par(mar=c(1, 1, 4, 1))
#    chosen.colors <- c(color1, color2, color3)
#    col <- colorRampPalette(chosen.colors)(50)
#    image(datasets::volcano, xaxt = "n", yaxt = "n", main = "Maunga Whau Volcano",
#          col = col, cex.main = 2)
#  
#    return(volcano.cells)
#  }

## ------------------------------------------------------------------------
volcano.handler2 <- function(colors = c("red","blue"))  {

  par(mar=c(1, 1, 4, 1))
  col <- colorRampPalette(colors)(50)
  image(datasets::volcano, xaxt = "n", yaxt = "n", main = "Maunga Whau Volcano",
        col = col, cex.main = 2)

  return(volcano.cells)  
}

one.color <- color.param()
color.array <- array.param(name = "colors", label = "Colors",
                           description = "Color the volcano from low to high altitude",
                           prototype = one.color,
                           min = 2, start = 2)
## Build an "AnalysisPageParamSet" with just 1 parameter, an array-type parameter
array.pset <- param.set(color.array)

volcano.page <- new.analysis.page(handler = volcano.handler2,
                                  param.set = array.pset,
                                  name = "volcano",
                                  description = "The Maunga Whau Volcano in Many Colors")
reg <- new.registry(volcano.page)
srv <- startRookAnalysisPageServer(reg, port = port)

## ------------------------------------------------------------------------
kill.process(srv)

## ------------------------------------------------------------------------
multi.color.selector <- select.param(name = "color", label = "Color", description = "Select multiple colors",
                                     choices = color.choices, allow.multiple = TRUE)

volcano.page <- new.analysis.page(handler = volcano.handler2,
                                  param.set = param.set(multi.color.selector),
                                  name = "volcano",
                                  description = "The Maunga Whau Volcano in Many Colors")
reg <- new.registry(volcano.page)
srv <- startRookAnalysisPageServer(reg, port = port)

## ------------------------------------------------------------------------
kill.process(srv)

## ------------------------------------------------------------------------
cities <- list(IL = c("Deerfield", "Springfield", "Chicago", "Urbana"),
  CA = c("San Francisco", "San Diego", "Los Angeles", "Sacramento"),
  MA = c("Deerfield", "Springfield", "Boston", "Camridge", "Arlington"))
states <- names(cities)

## ------------------------------------------------------------------------
cities.service <- build.service(function(state) cities[[state]], name = "cities")

## ------------------------------------------------------------------------
state.dropdown <- select.param(name = "state", label = "State", description = "Choose a state",
                               choices = states)

city.cbx <- combobox.param(name = "city", label = "City", description = "Choose a city",
                           uri = '/custom/RAPS/R/analysis?page="cities"&state=":statename"', dependent.params = c(statename="state"))

## ------------------------------------------------------------------------
handler <- function(state = "MA", city = "Arlington")  {
  plot.new()
  plot.window(0:1, 0:1)
  mesg <- paste(sep = "", city, ", ", state, " is for lovers\nand data analysts.")
  text(0.5, 0.5, mesg, cex = 3)
  data.frame(x = numeric(), y = numeric())
}

page <- new.analysis.page(handler = handler,
  param.set(state.dropdown, city.cbx),
  name = "state",
  description = "Information about a city",
  annotate.plot = FALSE)

reg <- new.registry(cities.service, page)
srv <- startRookAnalysisPageServer(reg, port = port)

## ------------------------------------------------------------------------
kill.process(srv)

## ------------------------------------------------------------------------
## Extra "as.list" is necessary to force creation of JSON array for length 1
city.search.service <- build.service(function(state, query) as.list(grep(query, cities[[state]], value = TRUE)),
  name = "city_search")
city.cbx <- combobox.param(name = "city", label = "City", description = "Enter a search term to find a city",
                   uri = "/custom/RAPS/R/analysis?page=\"city_search\"&state=\":statename\"&query=\":query\"",
                   dependent.params = c(statename="state", query = "city"))

## ------------------------------------------------------------------------
page <- new.analysis.page(handler = handler,
  param.set(state.dropdown, city.cbx),
  name = "state",
  description = "Information about a city",
  annotate.plot = FALSE)

reg <- new.registry(city.search.service, page)
srv <- startRookAnalysisPageServer(reg, port = port)

## ------------------------------------------------------------------------
kill.process(srv)

## ------------------------------------------------------------------------
horiz.handler <- function(word = "word")  {
  plot.new()
  plot.window(0:1, 0:1)
  text(0.5, 0.5, word)
  data.frame(x = numeric(), y = numeric())
}

vert.handler <- function(word = "word")  {
  plot.new()
  plot.window(0:1, 0:1)
  text(0.5, 0.5, word, srt = 90)
  data.frame(x = numeric(), y = numeric())
}

## ------------------------------------------------------------------------
word <- simple.param(name = "word", persistent = "word")

horiz.page <- new.analysis.page(horiz.handler, param.set(word), name = "horiz", label = "Horizontal")
vert.page <- new.analysis.page(vert.handler, param.set(word), name = "vert", label = "Vertical")

reg <- new.registry(horiz.page, vert.page)

srv <- startRookAnalysisPageServer(reg, port = port)

## ------------------------------------------------------------------------
kill.process(srv)

## ----conditional-persistent-params---------------------------------------
## First we'll rewrite the two handlers to accept
## a "language" parameter, and display "language: word"
## instead of just "word"
horiz.handler <- function(language = "English",
                          word = "word")  {
  plot.new()
  plot.window(0:1, 0:1)
  text(0.5, 0.5, paste0(language, ": ", word))
  data.frame(x = numeric(), y = numeric())
}

vert.handler <- function(language = "English",
                         word = "word")  {
  plot.new()
  plot.window(0:1, 0:1)
  text(0.5, 0.5, paste0(language, ": ", word), srt = 90)
  data.frame(x = numeric(), y = numeric())
}

## Now define language as a dropdown parameter, and make it
## persistent between the two pages.
language <- select.param(name = "language",
                         value = "English",
                         choices = c("English","Wolof","Chinese","Arabic","Klingon"),
                         persistent = "language")

## Then define the word parameter the same as above
## but make its persistence dependent on language.
word <- simple.param(name = "word", persistent = "word",
                     persistent.dependencies = "language")

## Finally, build the App and deploy:
horiz.page <- new.analysis.page(horiz.handler, param.set(language, word), name = "horiz", label = "Horizontal")
vert.page <- new.analysis.page(vert.handler, param.set(language, word), name = "vert", label = "Vertical")

reg <- new.registry(horiz.page, vert.page)


srv <- startRookAnalysisPageServer(reg, port = port)

## ----echo = FALSE--------------------------------------------------------
kill.process(srv)

## ------------------------------------------------------------------------
xmax <- simple.param("xmax", label = "Maximum Theta", value = pi)
n <- simple.param("n", value = 100, advanced = 1)
pset <- param.set(xmax, n)

handler <- function(xmax = pi, n = 100)  {
  xmax <- as.numeric(xmax)
  n <- as.numeric(n)
  x <- seq(0, xmax, length = n)
  y <- sin(x)

  plot(x, y, pch = 19, xlab = "Theta", ylab = "Sine(Theta)", main = "Sine curve")

  data.frame(x = x, y = y, Theta = x, `Sin(theta)` = y, check.names = FALSE)
}

page <- new.analysis.page(handler, param.set = pset, name = "sine", label = "Sine Plotter")
reg <- new.registry(page)
srv <- startRookAnalysisPageServer(reg, port = port)

## ----echo = FALSE--------------------------------------------------------
kill.process(srv)

## ------------------------------------------------------------------------
extremum.chooser <- select.param("extremum", choices = c("xmin", "xmax"))
xmin <- simple.param("xmin", value = 0, show.if = list(name = "extremum", values = "xmin"),
                     label = "Minimum Theta",
                     description = "Set a minimum value for the range (max will be pi)")
xmax <- simple.param("xmax", value = pi, show.if = list(name = "extremum", values  = "xmax"),
                     label = "Maximum Theta",
                     description = "Set a maximum value for the range (min will be 0)")
pset <- param.set(extremum.chooser, xmin, xmax)

handler <- function(extremum = "xmin", xmin = 0, xmax = pi)  {
  xmin <- if(extremum == "xmin") as.numeric(xmin) else 0
  xmax <- if(extremum == "xmax") as.numeric(xmax) else pi
  x <- seq(xmin, xmax, length = 200)
  y <- sin(x)
  plot(x, y, pch = 19, xlab = "Theta", ylab = "Sine(Theta)", main = "Sine curve")
  data.frame(x = x, y = y, Theta = x, `Sin(theta)` = y, check.names = FALSE)
}
page <- new.analysis.page(handler, param.set = pset, name = "sine_with_extrema", label = "Sine Plotter")
reg <- new.registry(page)
srv <- startRookAnalysisPageServer(reg, port = port)

## ----echo = FALSE--------------------------------------------------------
kill.process(srv)

## ------------------------------------------------------------------------
range.paramset <- param.set(extremum.chooser, xmin, xmax)
range <- compound.param("range", children = range.paramset)
n <- simple.param("n", value = 100)
pset <- param.set(range, n)

handler <- function(range = list(extremum = "xmin", xmin = 0), n = 100)  {
  xmin <- if(range$extremum == "xmin") as.numeric(range$xmin) else 0
  xmax <- if(range$extremum == "xmax") as.numeric(range$xmax) else pi
  x <- seq(xmin, xmax, length = as.numeric(n))
  y <- sin(x)
  plot(x, y, pch = 19, xlab = "Theta", ylab = "Sine(Theta)", main = "Sine curve")
  data.frame(x = x, y = y, Theta = x, `Sin(theta)` = y, check.names = FALSE)
}
page <- new.analysis.page(handler, param.set = pset, name = "sine_with_extrema", label = "Sine Plotter")
reg <- new.registry(page)
srv <- startRookAnalysisPageServer(reg, port = port)

## ------------------------------------------------------------------------
kill.process(srv)


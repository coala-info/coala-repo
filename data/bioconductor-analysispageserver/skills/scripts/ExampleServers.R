# Code example from 'ExampleServers' vignette. See references/ for full tutorial.

## ----echo = FALSE--------------------------------------------------------
options(markdown.HTML.options = "toc")

## ----message = FALSE, echo = FALSE---------------------------------------
library(AnalysisPageServer)
rookforkOK <- AnalysisPageServer:::checkRookForkForVignettes()

## ----message=FALSE-------------------------------------------------------
library(AnalysisPageServer)
hello <- build.service(function()  "Hello, world!",
                       name = "hello")
class(hello)

## ------------------------------------------------------------------------
reg <- new.registry(hello)
class(reg)

## ------------------------------------------------------------------------
pages(reg, include.services = TRUE)

## ------------------------------------------------------------------------
identical(get.page(reg, "hello"), hello)

## ----eval=TRUE, message=FALSE--------------------------------------------
port <- 3198  ## or some other port
server <- startRookAnalysisPageServer(reg, port = port)
server

## ------------------------------------------------------------------------
kill.process(server)

## ----eval = FALSE--------------------------------------------------------
#  server <- startRookAnalysisPageServer(reg, port = port)
#  on.exit(try(kill.process(server)))

## ----message = FALSE-----------------------------------------------------
app <- new.rook.analysis.page.app(reg)

## ----eval = FALSE--------------------------------------------------------
#  rook.server <- Rook::Rhttpd$new()
#  rook.server$add(app, name = "RAPS")
#  rook.server$start(port = port)
#  
#  ## Ping the server from another R process or from your web browser ...
#  
#  ## Then stop the server
#  rook.server$stop()

## ----echo = FALSE--------------------------------------------------------
if(rookforkOK)  {
  rook.server <- Rook::Rhttpd$new()
  rook.server$add(app, name = "RAPS")
  rook.server$start(port = port)

  ## Ping the server from another R process or from your web browser ...

  ## Then stop the server
  rook.server$stop()
}  else  {
  no.rook.fork.msg
}

## ------------------------------------------------------------------------
server <- startRookAnalysisPageServer(reg, port = port)

## ------------------------------------------------------------------------
app.base.url <- paste0("http://127.0.0.1:", port, "/custom/RAPS")
url <- service.link(page = "hello", app.base.url = app.base.url)
cat(readLines(url, warn = FALSE), "\n")

## ------------------------------------------------------------------------
kill.process(server)

## ------------------------------------------------------------------------
sine <- build.service(function(theta)  sin(theta),
     name = "sine")

reg <- new.registry(sine, hello)

server <- startRookAnalysisPageServer(reg, port = port)

## ------------------------------------------------------------------------
show.analysis <- function(page, params = list(), show.url = FALSE)  {
  url <- service.link(page, params, app.base.url)
  if(show.url)  cat(url, "\n")
  response <- readLines(url, warn = FALSE)
  rjson::fromJSON(response)
}

show.analysis("hello", show.url = TRUE)
show.analysis("sine", list(theta = 3.141592653), show.url = TRUE)
kill.process(server)

## ------------------------------------------------------------------------
cx.return <- build.service(function()  {
  list(A = 1:5,
       B = "Able was I",
       C = list(x = 1, y = c(TRUE, FALSE, TRUE)))
}, name = "complex")
reg <- new.registry(cx.return)
server <- startRookAnalysisPageServer(reg, port = port)

show.analysis("complex")
kill.process(server)

## ------------------------------------------------------------------------
cx.param <- build.service(function(struct, n)  {
  ## In Javascript:
  ## struct["A"][n - 1]
  struct$A[n]
}, name = "cxpar")
reg <- new.registry(cx.param)
server <- startRookAnalysisPageServer(reg, port = port)

show.analysis("cxpar", list(struct = list(A = c(3,1,4,1,5,9,2,6,5,3)), n = 6), show.url = TRUE)
kill.process(server)

## ------------------------------------------------------------------------
poem.file <- system.file("examples/in-a-station-of-the-metro.html", package="AnalysisPageServer")
poem.html <- readLines(poem.file, warn = FALSE)
poem <- build.service(function()  {
  new.response(paste0(poem.html, "\n"),
               content.type = "text/html")
}, name = "poem")
   
reg <- new.registry(poem)
server <- startRookAnalysisPageServer(reg, port = port)

url <- service.link("poem", app.base.url = app.base.url)
readLines(url, warn = FALSE)

## ------------------------------------------------------------------------
kill.process(server)

## ----eval = FALSE--------------------------------------------------------
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
#  reg <- new.registry(volcano)
#  server <- startRookAnalysisPageServer(reg, port = port)

## ----eval=FALSE----------------------------------------------------------
#  kill.process(server)


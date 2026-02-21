# Code example from 'BrowserVizDemo' vignette. See references/ for full tutorial.

### R code from vignette source 'BrowserVizDemo.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: plotDemo
###################################################
library(BrowserVizDemo)
plotter <- BrowserVizDemo(port=8000:8100);  # plenty of ports to choose from
stopifnot(ready(plotter))
title <- "simple xy plot test";
setBrowserWindowTitle(plotter, title)
plot(plotter, 1:10, (1:10)^2)
selectedPoints <- getSelection(plotter)
  # selectedPoints will be an empty list -unless- you have selected some in the browser with your mouse.
closeWebSocket(plotter)



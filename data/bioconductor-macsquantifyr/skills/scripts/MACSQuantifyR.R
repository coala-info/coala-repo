# Code example from 'MACSQuantifyR' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    fig.width = 8,
    fig.height = 8
)

## ----echo = FALSE-------------------------------------------------------------
library(grid)
library(png)
path_img1 <- system.file("extdata", "combo.png", package = "MACSQuantifyR")
img1 <- readPNG(path_img1)
grid.raster(img1)

## ----echo = FALSE, fig.width=4, fig.height=4----------------------------------
library(grid)
library(png)
library(gridExtra)

path_img3 <- system.file("extdata", "scheme1.png", package = "MACSQuantifyR")
path_img2 <- system.file("extdata", "scheme2.png", package = "MACSQuantifyR")

img3 <-  rasterGrob(as.raster(readPNG(path_img3)), interpolate = FALSE)
img2 <-  rasterGrob(as.raster(readPNG(path_img2)), interpolate = FALSE)

grid.arrange(img3, img2, ncol = 2)
paste("Horizontal template would allow to sort",
    "the excel document according to well names (A1, A2, A3...)", sep = " ")
paste("Vertical template would allow to sort",
    "the excel document according to well number(exp_name_001,exp_name_002))", 
    sep = " ")

## ----echo = FALSE,fig.asp=0.6-------------------------------------------------

path_img4 <- system.file("extdata", "auto.png", package = "MACSQuantifyR")
img4 <- readPNG(path_img4)
grid.raster(img4)

## ----echo = FALSE, fig.width=10, fig.height=8,fig.asp=0.6---------------------

path_img5 <- system.file("extdata", "manual.png", package = "MACSQuantifyR")
img5 <- readPNG(path_img5)
grid.raster(img5)


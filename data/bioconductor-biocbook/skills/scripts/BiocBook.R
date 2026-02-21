# Code example from 'BiocBook' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## -----------------------------------------------------------------------------
library(BiocBook)

## Note that `.local = TRUE` is only set here for demonstration. 
init("myNewBook", .local = TRUE)

## -----------------------------------------------------------------------------
bb <- BiocBook("myNewBook")
bb

## -----------------------------------------------------------------------------
add_preamble(bb, open = FALSE)
add_chapter(bb, title = 'Chapter 1', open = FALSE)
bb

## ----eval = FALSE-------------------------------------------------------------
# publish(bb)

## -----------------------------------------------------------------------------
sessionInfo()

## ----include = FALSE----------------------------------------------------------
unlink("myNewBook", recursive = TRUE)


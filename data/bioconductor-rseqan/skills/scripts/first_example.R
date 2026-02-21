# Code example from 'first_example' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
Sys.setenv("PKG_CXXFLAGS"="-std=c++14")

## ----ps_r---------------------------------------------------------------------
pattern_search("This is an awesome tutorial to get to know SeqAn!", "tutorial")


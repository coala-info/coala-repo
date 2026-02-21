# Code example from 'decoration' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE,
    warning = FALSE,
    fig.align = "center"
)
suppressPackageStartupMessages(library(InteractiveComplexHeatmap))

## ----eval = FALSE-------------------------------------------------------------
# library(ComplexHeatmap)
# m = matrix(rnorm(100), 10)
# ht = Heatmap(m, name = "foo")
# ht = draw(ht)
# decorate_heatmap_body("foo", {
#     grid.text("some text", gp = gpar(fontsize = 30))
# })

## ----eval = FALSE-------------------------------------------------------------
# library(InteractiveComplexHeatmap)
# post_fun = function(ht_list) {
#     decorate_heatmap_body("foo", {
#         grid.text("some text", gp = gpar(fontsize = 30))
#     })
# }
# ht = draw(ht, post_fun = post_fun)
# htShiny(ht)

## ----eval = FALSE-------------------------------------------------------------
# post_fun = function(ht_list) {
#     decorate_heatmap_body("foo", {
#         row_dend(ht_list)
#         row_order(ht_list)
#         ...
#     })
# }


# Code example from 'implementation' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE,
    warning = FALSE,
    fig.align = "center"
)

## -----------------------------------------------------------------------------
library(ComplexHeatmap)
library(InteractiveComplexHeatmap)
set.seed(123)
mat1 = matrix(rnorm(100), 10)
rownames(mat1) = colnames(mat1) = paste0("a", 1:10)
mat2 = matrix(sample(letters[1:10], 100, replace = TRUE), 10)
rownames(mat2) = colnames(mat2) = paste0("b", 1:10)

ht_list = Heatmap(mat1, name = "mat_a", row_km = 2, column_km = 2) +
    Heatmap(mat2, name = "mat_b")

## ----fig.width = 6, fig.height = 4--------------------------------------------
ht_list = draw(ht_list)
pos = htPositionsOnDevice(ht_list)

## -----------------------------------------------------------------------------
pos

## ----fig.width = 6, fig.height = 4, echo = FALSE------------------------------
grid.newpage()
grid.rect(gp = gpar(lty = 2))
for(i in seq_len(nrow(pos))) {
    x_min = pos[i, "x_min"]
    x_max = pos[i, "x_max"]
    y_min = pos[i, "y_min"]
    y_max = pos[i, "y_max"]
    pushViewport(viewport(x = x_min, y = y_min, name = pos[i, "slice"],
        width = x_max - x_min, height = y_max - y_min,
        just = c("left", "bottom")))
    grid.rect()
    upViewport()
}

## ----fig.width = 6, fig.height = 4, eval = FALSE------------------------------
# dev.new(width = 6, height = 4)
# grid.newpage()
# grid.rect(gp = gpar(lty = 2))
# for(i in seq_len(nrow(pos))) {
#     x_min = pos[i, "x_min"]
#     x_max = pos[i, "x_max"]
#     y_min = pos[i, "y_min"]
#     y_max = pos[i, "y_max"]
#     pushViewport(viewport(x = x_min, y = y_min, name = pos[i, "slice"],
#         width = x_max - x_min, height = y_max - y_min,
#         just = c("left", "bottom")))
#     grid.rect()
#     upViewport()
# }

## ----echo = FALSE, fig.width = 6, fig.height = 4------------------------------
source("model.R")

## ----eval = FALSE-------------------------------------------------------------
# df[1, "row_index"][[1]]
# unlist(df[1, "row_index"])
# df$row_index[[1]]

## ----fig.width = 6, fig.height = 4, eval = FALSE------------------------------
# pdf(...)
# ht_list = draw(ht_list)
# pos = selectPosition(ht_list, pos = unit(c(3, 3), "cm"))
# dev.off()

## ----fig.width = 6, fig.height = 4, echo = FALSE------------------------------
# pdf(...) or png(...) or other devices, because under this vignette generation, it is
# already under a png() device, I don't need to call `png()` explictly.
ht_list = draw(ht_list)
pos = selectPosition(ht_list, pos = unit(c(3, 3), "cm"))
# remember to dev.off()

## -----------------------------------------------------------------------------
pos

## ----fig.width = 6, fig.height = 4, eval = FALSE------------------------------
# pdf(...)
# ht_list = draw(ht_list)
# pos = selectArea(ht_list, pos1 = unit(c(3, 3), "cm"), pos2 = unit(c(5, 5), "cm"))
# dev.off()

## ----fig.width = 6, fig.height = 4, echo = FALSE------------------------------
# pdf(...) or png(...) or other devices
ht_list = draw(ht_list)
pos = selectArea(ht_list, pos1 = unit(c(3, 3), "cm"), pos2 = unit(c(5, 5), "cm"))
# remember to dev.off()

## -----------------------------------------------------------------------------
pos


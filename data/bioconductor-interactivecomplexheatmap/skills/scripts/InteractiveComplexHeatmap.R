# Code example from 'InteractiveComplexHeatmap' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE,
    warning = FALSE,
    fig.align = "center"
)

## ----echo = FALSE-------------------------------------------------------------
suppressPackageStartupMessages(library(InteractiveComplexHeatmap))

## ----eval = FALSE-------------------------------------------------------------
# library(ComplexHeatmap)
# library(InteractiveComplexHeatmap)
# m = matrix(rnorm(100*100), nrow = 100)
# ht = Heatmap(m)
# ht = draw(ht) # not necessary, but recommended
# 
# htShiny(ht)

## ----eval = FALSE-------------------------------------------------------------
# # the following code is runable
# library(cola)  # cola is from Bioconductor
# data(golub_cola)
# get_signatures(golub_cola["ATC:skmeans"], k = 2) # this makes the heatmap
# htShiny()

## ----eval = FALSE-------------------------------------------------------------
# htShiny(ht, output_ui_float = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# htShiny(ht, compact = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# set.seed(123)
# mat1 = matrix(rnorm(100), 10)
# rownames(mat1) = colnames(mat1) = paste0("a", 1:10)
# mat2 = matrix(sample(letters[1:10], 100, replace = TRUE), 10)
# rownames(mat2) = colnames(mat2) = paste0("b", 1:10)
# 
# ht_list = Heatmap(mat1, name = "mat_a", row_km = 2, column_km = 2) +
#     Heatmap(mat2, name = "mat_b")
# htShiny(ht_list)

## ----eval = FALSE-------------------------------------------------------------
# ht_list = Heatmap(mat1, name = "mat_a", row_km = 2, column_km = 2) %v%
#     Heatmap(mat2, name = "mat_b")
# htShiny(ht_list)

## ----eval = FALSE-------------------------------------------------------------
# ht = densityHeatmap(...)
# htShiny(ht)

## ----eval = FALSE-------------------------------------------------------------
# ht = oncoPrint(...)
# htShiny(ht)
# 
# ht = oncoPrint(...) + Heatmap(...) + rowAnnotation(...)
# htShiny(ht)

## ----eval = FALSE-------------------------------------------------------------
# cm = make_comb_mat(...)
# ht = UpSet(cm, ...)
# htShiny(ht)

## ----eval = FALSE-------------------------------------------------------------
# mat = normalizeToMatrix(...)
# ht = EnrichedHeatmap(mat, ...)
# htShiny(ht)
# 
# ht = EnrichedHeatmap(mat, ...) + EnrichedHeatmap(...) + Heatmap(...)
# htShiny(ht)

## ----eval = FALSE-------------------------------------------------------------
# ht = pheatmap(...) # ComplexHeatmap::pheatmap should overwrite pheatmap::pheatmap
# htShiny(ht)

## ----eval = FALSE-------------------------------------------------------------
# ht = ComplexHeatmap:::heatmap(...)
# htShiny(ht)

## ----eval = FALSE-------------------------------------------------------------
# ht = ComplexHeatmap:::heatmap.2(...)
# htShiny(ht)

## ----eval = FALSE-------------------------------------------------------------
# library(tidyverse)
# library(tidyHeatmap)
# mtcars_tidy <-
#     mtcars %>%
#     as_tibble(rownames="Car name") %>%
#     mutate_at(vars(-`Car name`, -hp, -vs), scale) %>%
#     pivot_longer(cols = -c(`Car name`, hp, vs), names_to = "Property", values_to = "Value")
# 
# mtcars_heatmap <-
#     mtcars_tidy %>%
#         heatmap(`Car name`, Property, Value ) %>%
#         add_tile(hp)
# 
# htShiny(mtcars_heatmap)

## ----eval = FALSE-------------------------------------------------------------
# ComplexHeatmap::pheatmap(...)
# htShiny()
# 
# oncoPrint(...)
# htShiny()

## -----------------------------------------------------------------------------
htShinyExample()

## ----eval = FALSE-------------------------------------------------------------
# htShinyExample(1.4)

## -----------------------------------------------------------------------------
sessionInfo()


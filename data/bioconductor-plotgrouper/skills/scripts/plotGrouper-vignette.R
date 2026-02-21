# Code example from 'plotGrouper-vignette' vignette. See references/ for full tutorial.

## ----logo, echo=FALSE---------------------------------------------------------
htmltools::img(src = knitr::image_uri("logo_small.png"), 
               alt = 'logo', 
               style = 'position:absolute; 
               top:0; 
               right:0; 
               padding:10px; 
               width:150px')

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
#   BiocManager::install("plotGrouper")

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("jdgagnon/plotGrouper")

## ----eval = FALSE-------------------------------------------------------------
# devtools::install_github("jdgagnon/plotGrouper")

## ----echo=FALSE, fig.align='center'-------------------------------------------
knitr::kable(
  matrix(c("***Sample***", "***Species***", "***Sepal.Length***",
           "setosa_1", "setosa", 5.1,
           "setosa_2", "setosa", 4.9,
           "versicolor_1", "versicolor", 7,
           "versicolor_2", "versicolor", 6.4,
           "virginica_1", "virginica", 6.3,
           "virginica_2", "virginica", 5.8,
           "etc...", "etc...", "etc..."), 
         ncol = 3, byrow = T), 
  col.names = c("Unique identifier", "Comparisons", "Variables"), 
  align = "c")

## -----------------------------------------------------------------------------
sessionInfo()


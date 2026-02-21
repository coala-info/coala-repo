# Code example from 'POMA-normalization' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.align = "center",
  comment = ">"
)

## ----eval = FALSE-------------------------------------------------------------
# # install.packages("BiocManager")
# BiocManager::install("POMA")

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
library(POMA)
library(ggtext)
library(patchwork)

## ----warning = FALSE, comment = NA--------------------------------------------
example_data <- st000336 %>% 
  PomaImpute() # KNN imputation

example_data

## ----warning = FALSE----------------------------------------------------------
none <- PomaNorm(example_data, method = "none")
auto_scaling <- PomaNorm(example_data, method = "auto_scaling")
level_scaling <- PomaNorm(example_data, method = "level_scaling")
log_scaling <- PomaNorm(example_data, method = "log_scaling")
log_transformation <- PomaNorm(example_data, method = "log")
vast_scaling <- PomaNorm(example_data, method = "vast_scaling")
log_pareto <- PomaNorm(example_data, method = "log_pareto")

## ----warning = FALSE----------------------------------------------------------
dim(SummarizedExperiment::assay(none))
dim(SummarizedExperiment::assay(auto_scaling))
dim(SummarizedExperiment::assay(level_scaling))
dim(SummarizedExperiment::assay(log_scaling))
dim(SummarizedExperiment::assay(log_transformation))
dim(SummarizedExperiment::assay(vast_scaling))
dim(SummarizedExperiment::assay(log_pareto))

## ----message = FALSE, warning = FALSE-----------------------------------------
a <- PomaBoxplots(none, 
                  x = "samples") +
  ggplot2::ggtitle("Not Normalized")

b <- PomaBoxplots(auto_scaling, 
                  x = "samples", 
                  theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Auto Scaling") +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

c <- PomaBoxplots(level_scaling, 
                  x = "samples", 
                  theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Level Scaling") +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

d <- PomaBoxplots(log_scaling, 
                  x = "samples", 
                  theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Log Scaling") +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

e <- PomaBoxplots(log_transformation, 
                  x = "samples", 
                  theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Log Transformation") +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

f <- PomaBoxplots(vast_scaling, 
                  x = "samples", 
                  theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Vast Scaling") +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

g <- PomaBoxplots(log_pareto, 
                  x = "samples", 
                  theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Log Pareto") +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

a  
(b + c + d) / (e + f + g)

## ----message = FALSE, warning = FALSE-----------------------------------------
h <- PomaDensity(none, 
                 x = "features", 
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Not Normalized")

i <- PomaDensity(auto_scaling, 
                 x = "features", 
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Auto Scaling") +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 axis.title.y = ggplot2::element_blank())

j <- PomaDensity(level_scaling, 
                 x = "features", 
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Level Scaling") +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 axis.title.y = ggplot2::element_blank())

k <- PomaDensity(log_scaling, 
                 x = "features", 
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Log Scaling") +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 axis.title.y = ggplot2::element_blank())

l <- PomaDensity(log_transformation, 
                 x = "features", 
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Log Transformation") +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 axis.title.y = ggplot2::element_blank())

m <- PomaDensity(vast_scaling, 
                 x = "features", 
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Vast Scaling") +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 axis.title.y = ggplot2::element_blank())

n <- PomaDensity(log_pareto, 
                 x = "features", 
                 theme_params = list(legend_title = FALSE, legend_position = "none")) +
  ggplot2::ggtitle("Log Pareto") +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 axis.title.y = ggplot2::element_blank())

h  
(i + j + k) / (l + m + n)

## -----------------------------------------------------------------------------
sessionInfo()


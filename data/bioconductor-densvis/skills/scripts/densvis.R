# Code example from 'densvis' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    error = FALSE,
    warning=FALSE,
    message=FALSE,
    collapse = TRUE,
    comment = "#>"
)
library("BiocStyle")

## ----setup--------------------------------------------------------------------
library("densvis")
library("Rtsne")
library("uwot")
library("ggplot2")
theme_set(theme_bw())
set.seed(14)

## ----data---------------------------------------------------------------------
data <- data.frame(
    x = c(rnorm(1000, 5), rnorm(1000, 0, 0.2)),
    y = c(rnorm(1000, 5), rnorm(1000, 0, 0.2)),
    class = c(rep("Class 1", 1000), rep("Class 2", 1000))
)
ggplot() +
    aes(data[, 1], data[, 2], colour = data$class) +
    geom_point(pch = 19) +
    scale_colour_discrete(name = "Cluster") +
    ggtitle("Original co-ordinates")

## ----run-densne---------------------------------------------------------------
fit1 <- densne(data[, 1:2], dens_frac = 0.5, dens_lambda = 0.5)
ggplot() +
    aes(fit1[, 1], fit1[, 2], colour = data$class) +
    geom_point(pch = 19) +
    scale_colour_discrete(name = "Class") +
    ggtitle("Density-preserving t-SNE") +
    labs(x = "t-SNE 1", y = "t-SNE 2")

## ----run-tsne-----------------------------------------------------------------
fit2 <- Rtsne(data[, 1:2])
ggplot() +
    aes(fit2$Y[, 1], fit2$Y[, 2], colour = data$class) +
    geom_point(pch = 19) +
    scale_colour_discrete(name = "Class") +
    ggtitle("Standard t-SNE") +
    labs(x = "t-SNE 1", y = "t-SNE 2")

## ----run-densmap--------------------------------------------------------------
fit1 <- densmap(data[, 1:2], dens_frac = 0.5, dens_lambda = 0.5)
ggplot() +
    aes(fit1[, 1], fit1[, 2], colour = data$class) +
    geom_point(pch = 19) +
    scale_colour_discrete(name = "Class") +
    ggtitle("Density-preserving t-SNE") +
    labs(x = "t-SNE 1", y = "t-SNE 2")

## ----run-umap-----------------------------------------------------------------
fit2 <- umap(data[, 1:2])
ggplot() +
    aes(fit2[, 1], fit2[, 2], colour = data$class) +
    geom_point(pch = 19) +
    scale_colour_discrete(name = "Class") +
    ggtitle("Standard t-SNE") +
    labs(x = "t-SNE 1", y = "t-SNE 2")

## -----------------------------------------------------------------------------
sessionInfo()


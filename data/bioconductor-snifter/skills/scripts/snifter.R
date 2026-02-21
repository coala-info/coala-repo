# Code example from 'snifter' vignette. See references/ for full tutorial.

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
library("snifter")
library("ggplot2")
theme_set(theme_bw())
set.seed(42)

n_obs <- 500
n_feats <- 200
means_1 <- rnorm(n_feats)
means_2 <- rnorm(n_feats)
counts_a <- replicate(n_obs, rnorm(n_feats, means_1))
counts_b <- replicate(n_obs, rnorm(n_feats, means_2))
counts <- t(cbind(counts_a, counts_b))
label <- rep(c("A", "B"), each = n_obs)

## ----run----------------------------------------------------------------------
fit <- fitsne(counts, random_state = 42L)
ggplot() +
    aes(fit[, 1], fit[, 2], colour = label) +
    geom_point(pch = 19) +
    scale_colour_discrete(name = "Cluster") +
    labs(x = "t-SNE 1", y = "t-SNE 2")

## ----split--------------------------------------------------------------------
test_ind <- sample(nrow(counts), nrow(counts) / 2)
train_ind <- setdiff(seq_len(nrow(counts)), test_ind)
train_mat <- counts[train_ind, ]
test_mat <- counts[test_ind, ]

train_label <- label[train_ind]
test_label <- label[test_ind]

embedding <- fitsne(train_mat, random_state = 42L)

## ----plot-embed---------------------------------------------------------------
new_coords <- project(embedding, new = test_mat, old = train_mat)
ggplot() +
    geom_point(
        aes(embedding[, 1], embedding[, 2],
            colour = train_label,
            shape = "Train"
        )
    ) +
    geom_point(
        aes(new_coords[, 1], new_coords[, 2], 
            colour = test_label,
            shape = "Test"
        )
    ) +
    scale_colour_discrete(name = "Cluster") +
    scale_shape_discrete(name = NULL) +
    labs(x = "t-SNE 1", y = "t-SNE 2")

## -----------------------------------------------------------------------------
sessionInfo()


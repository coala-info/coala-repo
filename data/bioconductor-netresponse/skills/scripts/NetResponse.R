# Code example from 'NetResponse' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
library(knitr)

# Global options
opts_chunk$set(fig.path="fig/", eval=FALSE)

## ----NetResponse1a, warning=FALSE, message=FALSE------------------------------
# library(netresponse)
# res <- generate.toydata(Dim = 3, Nc = 3, Ns = 200, sd0 = 3, rgam.shape = 1, rgam.scale = 1)
# 
# D <- res$data
# component.means <- res$means
# component.sds   <- res$sds
# sample2comp     <- res$sample2comp
# 
# # Use fully connected network
# network <- matrix(rep(1, 9), nrow = 3)

## ----NetResponse1b, warning=FALSE, message=FALSE------------------------------
# # Various network formats are supported, see help(detect.responses) for
# # details. With large data sets, consider the 'speedup' option.
# set.seed(4243)
# res <- detect.responses(D, network, mixture.method = "vdp", pca.basis = TRUE)
# 
# # List subnets (each is a list of nodes)
# subnet.id <- names(get.subnets(res))[[1]]

## ----NetResponse2, fig.width=6, fig.height=6, warning=FALSE, message=FALSE, fig.show="hide", eval=FALSE----
# library(ggplot2)
# vis <- plot_responses(res, subnet.id, plot_mode = "pca")

## ----NetResponse2b, fig.width=6, fig.height=5, warning=FALSE, message=FALSE, eval=FALSE----
# # Modify the resulting ggplot2 object to enhance visualization
# p <- vis$p # Pick the ggplot2 object from results
# p <- p + geom_point(size = 3) # Modify point size
# print(p)

## ----NetResponse3, fig.width=8, fig.height=8, warning=FALSE, message=FALSE, eval=FALSE----
# vis <- plot_responses(res, subnet.id, plot_mode = "network")

## ----NetResponse4, fig.width=8, fig.height=8, warning=FALSE, message=FALSE, eval=FALSE----
# vis <- plot_responses(res, subnet.id, plot_mode = "heatmap")

## ----NetResponse5, fig.width=8, fig.height=8, warning=FALSE, message=FALSE, eval=FALSE----
# vis <- plot_responses(res, subnet.id, plot_mode = "boxplot_data")

## ----NetResponse7, fig.width=8, fig.height=8, warning=FALSE, message=FALSE, eval=FALSE----
# plot_scale(vis$breaks, vis$palette, two.sided = TRUE)

## ----NetResponse8, warning=FALSE, message=FALSE-------------------------------
# subnet.id <- 'Subnet-1'
# 
# # Sample - response probabilities (soft cluster assignment)
# response.probs <- sample2response(res, subnet.id)
# tail(round(response.probs, 6))
# 
# # Sample - response hard assignments
# hard.clusters <- response2sample(res, subnet.id)
# print(hard.clusters)

## ----NetResponse9, warning=FALSE, message=FALSE-------------------------------
# params <- get.model.parameters(res, subnet.id)
# names(params)

## ----vdp, warning=FALSE, message=FALSE----------------------------------------
# # Generate 2-dimensional simulated data with 3 clusters
# res <- generate.toydata(Dim = 2, Nc = 3, Ns = 200, sd0 = 3, rgam.shape = 1, rgam.scale = 1)
# 
# D <- res$data
# real.means <- res$means
# real.sds   <- res$sds
# real.sample2comp     <- res$sample2comp
# 
# # Infinite Gaussian mixture model with
# # Variational Dirichlet Process approximation
# mixt <- vdp.mixt( D )
# 
# # Centroids of the detected Gaussian components
# estimated.means <- mixt$posterior$centroids
# 
# # The colors denote the known clusters
# # The blue ball denotes the original (known) cluster centroids and
# # the triangle denotes the estimated centroids
# plot(D, col = real.sample2comp, pch = 1)
# points(real.means, col = "blue", pch = 16, cex = 2)
# points(estimated.means, col = "blue", pch = 17, cex = 2)
# 
# # Hard mixture component assignment for each sample
# estimated.sample2comp <- apply(mixt$posterior$qOFz, 1, which.max)
# 
# # Compare known and estimated mixture components
# # (note that cluster indices may have switched due to unidentifiability)
# # nearly all samples have one-to-one match between the real and estimated
# # clusters
# head(table(estimated.sample2comp, real.sample2comp))

## ----cite, warning=FALSE, message=FALSE---------------------------------------
# citation("netresponse")

## ----version, warning=FALSE, message=FALSE------------------------------------
# sessionInfo()


# Code example from 'autoplot' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(ggcyto)
dataDir <- system.file("extdata",package="flowWorkspaceData")
gs <- load_gs(list.files(dataDir, pattern = "gs_bcell_auto",full = TRUE))
data(GvHD)
fs <- GvHD[subset(pData(GvHD), Patient %in%5 & Visit %in% c(5:6))[["name"]]]

## -----------------------------------------------------------------------------
autoplot(fs, x = 'FSC-H')

## -----------------------------------------------------------------------------
autoplot(fs, x = 'FSC-H', y = 'SSC-H', bins = 64)

## -----------------------------------------------------------------------------
autoplot(fs[[1]]) + labs_cyto("marker")

## -----------------------------------------------------------------------------
autoplot(gs, "CD3", bins = 64)

## -----------------------------------------------------------------------------
autoplot(gs, c("CD3", "CD19"), bins = 64)

## ----fig.width = 4, fig.height=3----------------------------------------------
gh <- gs[[1]]
nodes <- gs_get_pop_paths(gh, path = "auto")[c(3:6)]
nodes

autoplot(gh, nodes, bins = 64)

## ----fig.width = 8, fig.height=3----------------------------------------------
# get ggcyto_GatingLayout object from first sample
res <- autoplot(gs[[1]], nodes, bins = 64)
class(res)
# arrange it as one-row gtable object 
gt <- ggcyto_arrange(res, nrow = 1)
gt
# do the same to the second sample
gt2 <- ggcyto_arrange(autoplot(gs[[2]], nodes, bins = 64), nrow = 1)
# combine the two and print it on the sampe page
gt3 <- gridExtra::gtable_rbind(gt, gt2)
plot(gt3)


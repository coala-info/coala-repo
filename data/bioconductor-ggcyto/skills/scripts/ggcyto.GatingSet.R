# Code example from 'ggcyto.GatingSet' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE, error = TRUE)

## ----echo=FALSE---------------------------------------------------------------
library(ggcyto)
dataDir <- system.file("extdata",package="flowWorkspaceData")
gs <- load_gs(list.files(dataDir, pattern = "gs_manual",full = TRUE))

## -----------------------------------------------------------------------------
p <- ggcyto(gs, aes(x = CD4, y = CD8), subset = "CD3+") 
# 2d plot 
p <- p + geom_hex(bins = 64)
p

## -----------------------------------------------------------------------------
p + ggcyto_par_set(limits = "instrument")

## -----------------------------------------------------------------------------
myPars <- ggcyto_par_set(limits = list(x = c(0,3.5e3), y = c(-10, 4.1e3)))
p <- p + myPars# or xlim(0,3.5e3) + ylim(-10, 4e3) 
p

## -----------------------------------------------------------------------------
ggcyto_par_default()

## -----------------------------------------------------------------------------
p + geom_gate("CD4")

## -----------------------------------------------------------------------------
p <- p + geom_gate(c("CD4","CD8")) # short for geom_gate("CD8") + geom_gate("CD4")
p

## -----------------------------------------------------------------------------
p + geom_stats() + labs_cyto("marker")

## -----------------------------------------------------------------------------
p + geom_stats("CD4")

## -----------------------------------------------------------------------------
p + geom_stats("CD4", type = "count", size = 6,  color = "white", fill = "black", adjust = 0.3)

## ----error=T------------------------------------------------------------------
p <- ggcyto(gs, aes(x = CD4, y = CD8)) + geom_hex() + myPars
p

## -----------------------------------------------------------------------------
p <- p + geom_gate(c("CD4", "CD8"))
p

## -----------------------------------------------------------------------------
p + geom_overlay("CD8/CCR7- 45RA+", col = "black", size = 0.1, alpha = 0.4)

## -----------------------------------------------------------------------------
p <- ggcyto(gs, aes(x = CD4), subset = "CD3+") + geom_density(aes(y = ..count..))
p + geom_overlay("CD8/CCR7- 45RA+", aes(y = ..count..), fill = "red")

## -----------------------------------------------------------------------------
p <- ggcyto(gs, aes(x = 38, y = DR), subset = "CD4") + geom_hex(bins = 64) + geom_gate() + geom_stats()
p

## -----------------------------------------------------------------------------
ggcyto(gs, subset = "root", aes(x = CD4, y = CD8)) + geom_hex(bins = 64) + geom_gate("CD4") + myPars

## -----------------------------------------------------------------------------
p + axis_x_inverse_trans() + axis_y_inverse_trans()
#add filter (consistent with `margin` behavior in flowViz)
# ggcyto(gs, aes(x = CD4, y = CD8), subset = "CD3+", filter = marginalFilter)  + geom_hex(bins = 32, na.rm = T)


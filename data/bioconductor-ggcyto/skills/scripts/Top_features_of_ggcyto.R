# Code example from 'Top_features_of_ggcyto' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
library(knitr)
opts_chunk$set(message = FALSE, warning = FALSE, fig.height= 3, fig.width= 5)

## -----------------------------------------------------------------------------
library(ggcyto)
dataDir <- system.file("extdata",package="flowWorkspaceData")

## -----------------------------------------------------------------------------
gs <- load_gs(list.files(dataDir, pattern = "gs_manual",full = TRUE))
attr(gs, "subset") <- "CD3+"
ggplot(gs, aes(x = `<B710-A>`, y = `<R780-A>`)) + geom_hex(bins = 128) + scale_fill_gradientn(colours = gray.colors(9))

## -----------------------------------------------------------------------------
fs <- gs_pop_get_data(gs, "CD3+")
ggplot(fs, aes(x = `<B710-A>`)) + geom_density(fill = "blue", alpha= 0.5)

## -----------------------------------------------------------------------------
gates <- filterList(gs_pop_get_gate(gs, "CD8"))
ggplot(gs, aes(x = `<B710-A>`, y = `<R780-A>`)) + geom_hex(bins = 128) + geom_polygon(data = gates, fill = NA, col = "purple")

## -----------------------------------------------------------------------------
ggcyto(gs, aes(x = CD4, y = CD8)) + geom_hex(bins = 128) + geom_gate("CD8")

## -----------------------------------------------------------------------------
#1d
autoplot(fs, "CD4")
#2d
autoplot(fs, "CD4", "CD8", bins = 64)

autoplot(gs, c("CD4", "CD8"), bins = 64)

## -----------------------------------------------------------------------------
data(GvHD)
fr <- GvHD[[1]]
p <- autoplot(fr, "FL1-H")
p #raw scale
p + scale_x_logicle() #flowCore logicle scale
p + scale_x_flowJo_fasinh() # flowJo fasinh
p + scale_x_flowJo_biexp() # flowJo biexponential


## -----------------------------------------------------------------------------
fr <- fs[[1]]
p <- autoplot(fr,"CD4", "CD8") + ggcyto_par_set(limits = "instrument")
#1d gate vertical
gate_1d_v <- openCyto::gate_mindensity(fr, "<B710-A>")
p + geom_gate(gate_1d_v)
#1d gate horizontal
gate_1d_h <- openCyto::gate_mindensity(fr, "<R780-A>")
p + geom_gate(gate_1d_h)
#2d rectangle gate
gate_rect <- rectangleGate("<B710-A>" = c(gate_1d_v@min, 4e3), "<R780-A>" = c(gate_1d_h@min, 4e3))
p + geom_gate(gate_rect)
#ellipsoid Gate
gate_ellip <- gh_pop_get_gate(gs[[1]], "CD4")
class(gate_ellip)
p + geom_gate(gate_ellip)

## -----------------------------------------------------------------------------
p <- ggcyto(gs, aes(x = "CD4", y = "CD8"), subset = "CD3+") + geom_hex()
p + geom_gate("CD4") + geom_stats()
p + geom_gate("CD4") + geom_stats(type = "count") #display cell counts 

## -----------------------------------------------------------------------------
p # axis display the transformed values
p + axis_x_inverse_trans() # restore the x axis to the raw values

## -----------------------------------------------------------------------------
p <- p + ggcyto_par_set(limits = "instrument")
p

## -----------------------------------------------------------------------------
p + labs_cyto("markers")

## -----------------------------------------------------------------------------
#put all the customized settings in one layer
mySettings <- ggcyto_par_set(limits = "instrument"
                             , facet = facet_wrap("name")
                             , hex_fill = scale_fill_gradientn(colours = rev(RColorBrewer::brewer.pal(11, "Spectral")))
                            , lab = labs_cyto("marker")
                            )
# and use it repeatly in the plots later (similar to the `theme` concept)
p + mySettings


## -----------------------------------------------------------------------------
class(p) # may not fully compatile with all the `ggplot` functions
p1 <- as.ggplot(p)
class(p1) # a pure ggplot object, thus can work with all the `ggplot` features

## ----fig.height = 4-----------------------------------------------------------
gh <- gs[[1]]
nodes <- gs_get_pop_paths(gh, path = "auto")[c(3:9, 14)]
nodes
p <- autoplot(gh, nodes, bins = 64)
class(p)
p

## -----------------------------------------------------------------------------
gt <- ggcyto_arrange(p, nrow = 1)
class(gt)
plot(gt)

## -----------------------------------------------------------------------------
p2 <- autoplot(gh_pop_get_data(gh, "CD3+")[,5:8]) # some density plot
p2@arrange.main <- ""#clear the default title
gt2 <- ggcyto_arrange(p2, nrow = 1)

gt3 <- gridExtra::gtable_rbind(gt, gt2)
plot(gt3)



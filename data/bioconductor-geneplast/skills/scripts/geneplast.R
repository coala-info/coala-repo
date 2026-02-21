# Code example from 'geneplast' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(geneplast)
data(gpdata.gs)

## ----label='newOgp', eval=TRUE------------------------------------------------
ogp <- gplast.preprocess(cogdata=cogdata, sspids=sspids, cogids=cogids, verbose=FALSE)

## ----label='gplastTest', eval=TRUE--------------------------------------------
ogp <- gplast(ogp, verbose=FALSE)

## ----label='gplastRes', eval=TRUE---------------------------------------------
res <- gplast.get(ogp, what="results")
head(res)

## ----label='newOgr', eval=TRUE------------------------------------------------
ogr <- groot.preprocess(cogdata=cogdata, phyloTree=phyloTree, spid="9606", verbose=FALSE)

## ----label='grootTest', eval=TRUE---------------------------------------------
set.seed(1)
ogr <- groot(ogr, nPermutations=100, verbose=FALSE)
# Note: nPermutations is set to 100 for demonstration purposes; please set nPermutations=1000

## ----label='grootRes1', eval=TRUE---------------------------------------------
res <- groot.get(ogr, what="results")
head(res)

## ----label='grootRes2', eval=TRUE---------------------------------------------
groot.plot(ogr, whichOG="NOG40170")

## ----label='rootRes', eval=TRUE-----------------------------------------------
groot.plot(ogr, plot.lcas = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# # source("https://bioconductor.org/biocLite.R")
# # biocLite("geneplast.data.string.v91")
# library(geneplast.data.string.v91)
# data(gpdata_string_v91)

## ----eval=FALSE---------------------------------------------------------------
# ogr <- groot.preprocess(cogdata=cogdata, phyloTree=phyloTree, spid="9606")

## ----eval=FALSE---------------------------------------------------------------
# ogr <- groot(ogr, nPermutations=100, verbose=TRUE)

## ----eval=FALSE---------------------------------------------------------------
# library(RedeR)
# library(igraph)
# library(RColorBrewer)
# data(ppi.gs)

## ----eval=FALSE---------------------------------------------------------------
# g <- ogr2igraph(ogr, cogdata, ppi.gs, idkey = "ENTREZ")

## ----eval=FALSE---------------------------------------------------------------
# pal <- brewer.pal(9, "RdYlBu")
# color_col <- colorRampPalette(pal)(25)
# g <- att.setv(g=g, from="Root", to="nodeColor",
#               cols=color_col, na.col="grey80",
#               breaks=seq(1,25))

## ----eval=FALSE---------------------------------------------------------------
# g <- att.setv(g = g, from = "SYMBOL", to = "nodeAlias")
# E(g)$edgeColor <- "grey80"
# V(g)$nodeLineColor <- "grey80"

## ----eval=FALSE---------------------------------------------------------------
# rdp <- RedPort()
# calld(rdp)
# resetd(rdp)
# addGraph(rdp, g)
# addLegend.color(rdp, colvec=g$legNodeColor$scale,
#                 size=15, labvec=g$legNodeColor$legend,
#                 title="Roots represented in Fig4")
# relax(rdp)

## ----eval=FALSE---------------------------------------------------------------
# myTheme <- list(nestFontSize=25, zoom=80, isNest=TRUE, gscale=65, theme=2)
# nestNodes(rdp, nodes=V(g)$name[V(g)$Apoptosis==1],
#           theme=c(myTheme, nestAlias="Apoptosis"))
# nestNodes(rdp, nodes=V(g)$name[V(g)$GenomeStability==1],
#           theme=c(myTheme, nestAlias="Genome Stability"))
# relax(rdp, p1=50, p2=50, p3=50, p4=50, p5= 50)

## ----eval=FALSE---------------------------------------------------------------
# library(RTN)
# library(Fletcher2013b)
# library(RedeR)
# library(igraph)
# library(RColorBrewer)
# data("rtni1st")

## ----eval=FALSE---------------------------------------------------------------
# regs <- c("FOXM1","PTTG1")
# g <- tni.graph(rtni1st, gtype = "rmap", regulatoryElements = regs)

## ----eval=FALSE---------------------------------------------------------------
# g <- ogr2igraph(ogr, cogdata, g, idkey = "ENTREZ")

## ----eval=FALSE---------------------------------------------------------------
# pal <- brewer.pal(9, "RdYlBu")
# color_col <- colorRampPalette(pal)(25)
# g <- att.setv(g=g, from="Root", to="nodeColor",
#               cols=color_col, na.col = "grey80",
#               breaks = seq(1,25))

## ----eval=FALSE---------------------------------------------------------------
# idx <- V(g)$SYMBOL %in% regs
# V(g)$nodeFontSize[idx] <- 30
# V(g)$nodeFontSize[!idx] <- 1
# E(g)$edgeColor <- "grey80"
# V(g)$nodeLineColor <- "grey80"

## ----eval=FALSE---------------------------------------------------------------
# rdp <- RedPort()
# calld(rdp)
# resetd(rdp)
# addGraph(rdp, g, layout=NULL)
# addLegend.color(rdp, colvec=g$legNodeColor$scale,
#                 size=15, labvec=g$legNodeColor$legend,
#                 title="Roots represented in Fig4")
# relax(rdp, 15, 100, 20, 50, 10, 100, 10, 2)

## ----label='runtime', eval=FALSE----------------------------------------------
# #--- Load ggplot
# library(ggplot2)
# library(ggthemes)
# library(egg)
# library(data.table)
# 
# #--- Load cogdata
# data(gpdata.gs)
# 
# #--- Get "OGs" that include a ref. species (e.g. "9606")
# cogids <- unique(cogdata$cog_id[cogdata$ssp_id=="9606"])
# length(cogids)
# # [1] 142
# 
# #--- Make a function to check runtime for different input sizes
# check.rooting.runtime <- function(n){
#   cogids.subset <- cogids[1:n]
#   cogdata.subset <- cogdata[cogdata$cog_id%in%cogids.subset,]
#   rt1 <- system.time(
#     ogr <- groot.preprocess(cogdata=cogdata.subset, phyloTree=phyloTree,
#                             spid="9606", verbose=FALSE)
#   )["elapsed"]
#   rt2 <- system.time(
#     ogr <- groot(ogr, nPermutations=100, verbose=FALSE)
#   )["elapsed"]
#   rtime <- c(rt1,rt2)
#   names(rtime) <- c("runtime.preprocess","runtime.groot")
#   return(rtime)
# }
# # check.rooting.runtime(n=5)
# 
# #--- Run check.rooting.runtime() for different input sizes (x3 iterations)
# input_size <- seq.int(10,length(cogids),10)
# iterations <- 1:3
# elapsed_lt <- lapply(iterations, function(i){
#   print(paste0("Iteration ",i))
#   it <- sapply(input_size, function(n){
#     print(paste0("- size...",n))
#     check.rooting.runtime(n)
#   })
# })
# 
# #--- Get 'preprocess' runtime
# runtime.preprocess <- sapply(elapsed_lt, function(lt){
#   lt["runtime.preprocess",]
# })
# runtime.preprocess <- data.frame(InputSize=input_size, runtime.preprocess)
# runtime.preprocess <- melt(as.data.table(runtime.preprocess), "InputSize")
# colnames(runtime.preprocess) <- c("Input.Size","Iteration","Elapsed.Time")
# 
# #--- Get 'groot' runtime
# runtime.groot <- sapply(elapsed_lt, function(lt){
#   lt["runtime.groot",]
# })
# runtime.groot <- data.frame(InputSize=input_size, runtime.groot)
# runtime.groot <- melt(as.data.table(runtime.groot), "InputSize")
# colnames(runtime.groot) <- c("Input.Size","Iteration","Elapsed.Time")
# 
# #--- Plot runtime results
# cls <- c("#69b3a2",adjustcolor("#69b3a2", alpha=0.5))
# gg1 <- ggplot(runtime.preprocess, aes(x=Input.Size, y=Elapsed.Time)) +
#   geom_smooth(method=loess, se=TRUE) +
#   geom_point(color=cls[1], fill=cls[2], size=3, shape=21) +
#   scale_x_continuous(breaks=pretty(runtime.preprocess$Input.Size)) +
#   scale_y_continuous(breaks=pretty(runtime.preprocess$Elapsed.Time)) +
#   theme_pander() + labs(title="groot.preprocess()") +
#   xlab("Input size (n)") + ylab("Elapsed time (s)") +
#   theme(aspect.ratio=1, plot.title=element_text(size=12))
# gg2 <- ggplot(runtime.groot, aes(x=Input.Size, y=Elapsed.Time)) +
#   geom_smooth(method=loess, se=TRUE) +
#   geom_point(color=cls[1], fill=cls[2], size=3, shape=21) +
#   scale_x_continuous(breaks=pretty(runtime.groot$Input.Size)) +
#   scale_y_continuous(breaks=pretty(runtime.groot$Elapsed.Time)) +
#   theme_pander() + labs(title="groot()") +
#   xlab("Input size (n)") + ylab("Elapsed time (s)") +
#   theme(aspect.ratio=1, plot.title=element_text(size=12))
# grid.arrange(gg1, gg2, nrow = 1)
# # pdf(file = "rooting_runtime.pdf", width = 7, height = 3)
# # grid.arrange(gg1, gg2, nrow = 1)
# # dev.off()

## ----label='Session information', eval=TRUE, echo=FALSE-----------------------
sessionInfo()


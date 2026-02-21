# Code example from 'netbiov-intro' vignette. See references/ for full tutorial.

### R code from vignette source 'netbiov-intro.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: preliminaries
###################################################
library(netbiov)
options(SweaveHooks=list(twofig=function() {par(mfrow=c(1,2))},
                         twofig2=function() {par(mfrow=c(2,1))},
                         onefig=function() {par(mfrow=c(1,1))}))


###################################################
### code chunk number 3: plotunif
###################################################
############ Figure A #############
library("igraph")
library("netbiov")
data("PPI_Athalina")
gparm <- mst.plot.mod(g1, v.size=1.5,e.size=.25,
colors=c("red", "orange", "yellow", "green"),
mst.e.size=1.2,expression=abs(runif(vcount(g1), 
max=5, min=1)), sf=-15, v.sf=5,
mst.edge.col="white", layout.function=layout.fruchterman.reingold)

############ Figure B #############
library("igraph")
library("netbiov")
data("PPI_Athalina")

data("color_list")

gparm<- plot.abstract.nodes(g1, nodes.color=color.list$citynight, 
lab.cex=1, lab.color="white", v.sf=-18, 
layout.function=layout.fruchterman.reingold)


###################################################
### code chunk number 4: plotunif
###################################################

########## Loading the artificial network with $10,000$ edges 
data("artificial1.graph")
########## Loading the artificial network with $5,000$ edges 
data("artificial2.graph")
########## Loading the B-Cell network and module information 
data("gnet_bcell")
data("modules_bcell")
########## Loading the Arabidopsis Thaliana network and module information
data("PPI_Athalina")
data("modules_PPI_Athalina")

########## Loading a predefined list of colors 
data("color_list")


###################################################
### code chunk number 5: plotunif
###################################################
data("artificial2.graph") 
xx<- plot.abstract.nodes(g1, layout.function=layout.fruchterman.reingold, 
v.sf=-30, lab.color="green")
#tkplot.netbiov(xx)


###################################################
### code chunk number 6: global1
###################################################
getOption("SweaveHooks")[["onefig"]]()
###Generation of the network:
require(netbiov)
data("artificial1.graph")
hc <- rgb(t(col2rgb(heat.colors(20)))/255,alpha=.2)
cl <- rgb(r=0, b=.7, g=1, alpha=.05)
xx <- mst.plot.mod(g1, vertex.color=cl, v.size=3, sf=-20,
colors=hc, e.size=.5, mst.e.size=.75, 
layout.function=layout.fruchterman.reingold)


###################################################
### code chunk number 7: global2
###################################################
getOption("SweaveHooks")[["onefig"]]()
require(netbiov)
data("artificial2.graph")
hc <- rgb(t(col2rgb(heat.colors(20)))/255,alpha=.2)
cl <- rgb(r=1, b=.7, g=0, alpha=.1)
fn <- function(x){layout.reingold.tilford(x, circular=TRUE, 
root=which.max(degree(x)))}
xx <- mst.plot.mod(g1, vertex.color=cl, v.size=1, sf=30, 
colors=hc, e.size=.5, mst.e.size=.75,
layout.function=fn, layout.overall=layout.kamada.kawai)


###################################################
### code chunk number 8: mod1
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("artificial1.graph")
xx <- plot.modules(g1, v.size=.8, 
modules.color=c("red", "yellow"), 
mod.edge.col=c("green", "purple"), sf=30)


###################################################
### code chunk number 9: mrt1
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("artificial1.graph")
cl <- c(rgb(r=1, b=1, g=0, alpha=.2))
cl <- rep(cl, 3)
ecl <-   c(rgb(r=.7, b=.7, g=.7, alpha=.2), rgb(r=.7, b=.7, g=.7, alpha=.2), 
rgb(r=0, b=0, g=1, alpha=.2), rgb(r=.7, b=.7, g=.7, alpha=.2))
ns <- c(1581, 1699, 4180, 4843, 4931, 5182, 5447, 5822, 6001,
6313, 6321, 6532, 7379, 8697, 8847, 9342)
xx <- level.plot(g1, tkplot=FALSE, level.spread=TRUE, v.size=1, 
vertex.colors=cl,  edge.col=ecl, initial_nodes=ns, order_degree=NULL,
e.curve=.25)


###################################################
### code chunk number 10: mod2
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("artificial2.graph")
xx <- plot.modules(g1,mod.lab=TRUE, color.random=TRUE, mod.edge.col="grey",
ed.color="gold", sf=15, v.size=.5,layout.function=layout.fruchterman.reingold,
lab.color="grey", modules.name.num=FALSE, lab.cex=1, lab.dist=5)


###################################################
### code chunk number 11: mod3
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("artificial2.graph")
xx<- plot.abstract.nodes(g1, layout.function=layout.fruchterman.reingold, 
v.sf=-30, lab.color="green")


###################################################
### code chunk number 12: plotnetbiov1
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("gnet_bcell")
ecl <- rgb(r=0, g=1, b=1, alpha=.6)
ppx <- mst.plot.mod(gnet, v.size=degree(gnet),e.size=.5,
colors=ecl,mst.e.size=1.2,expression=degree(gnet),
mst.edge.col="white", sf=-10, v.sf=6)


###################################################
### code chunk number 13: plotnetbiov2
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("gnet_bcell")
cl <- rgb(r=.6, g=.6, b=.6, alpha=.5)
xx <- level.plot(gnet, init_nodes=20,tkplot=FALSE, level.spread=TRUE,
order_degree=NULL, v.size=1, edge.col=c(cl, cl, "green", cl),
vertex.colors=c("red", "red", "red"), e.size=.5, e.curve=.25)
data("gnet_bcell")
cl <- rgb(r=.6, g=.6, b=.6, alpha=.5)
xx <- level.plot(gnet, init_nodes=20,tkplot=FALSE, level.spread=TRUE,
order_degree=NULL, v.size=1, edge.col=c(cl, cl, "green", cl),
vertex.colors=c("red", "red", "red"), e.size=.5, e.curve=.25)



###################################################
### code chunk number 14: plotnetbiov3
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("gnet_bcell")
xx<-plot.modules(gnet, color.random=TRUE, v.size=1, 
layout.function=layout.graphopt)



###################################################
### code chunk number 15: plotnetbiov4
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("gnet_bcell")
xx <- plot.modules(gnet, modules.color=cl, mod.edge.col=cl,
sf=5, nodeset=c(2,5,44,34), 
mod.lab=TRUE, v.size=.9, 
path.col=c("blue",  "purple", "green"), 
col.s1 = c("yellow", "pink"), 
col.s2 = c("orange", "white" ),
e.path.width=c(1.5,3.5), v.size.path=.9)



###################################################
### code chunk number 16: plotnetbiov5
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("gnet_bcell")
xx<-plot.abstract.nodes(gnet, v.sf=-35,
layout.function=layout.fruchterman.reingold, lab.color="white",lab.cex=.75)


###################################################
### code chunk number 17: plotnetbiov6
###################################################
getOption("SweaveHooks")[["onefig"]]()

data("PPI_Athalina")
data("color_list")

id <- mst.plot(g1, colors=c("purple4","purple"),mst.edge.col="green", 
vertex.color = "white",tkplot=FALSE, 
layout.function=layout.fruchterman.reingold)



###################################################
### code chunk number 18: plotnetbiov7
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")
data("color_list")
id <- mst.plot(g1, colors=c("purple4","purple"),mst.edge.col="green", 
vertex.color = "white",tkplot=FALSE, layout.function=layout.kamada.kawai)


###################################################
### code chunk number 19: plotnetbiov8
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")
data("color_list")
data("modules_PPI_Athalina")

cl <- rep("blue", length(lm))
cl[1] <- "green"

id <- plot.modules(g1, layout.function = layout.graphopt, modules.color = cl, 
mod.edge.col=c("green","darkgreen") , tkplot=FALSE, ed.color = c("blue"),sf=-25)



###################################################
### code chunk number 20: plotnetbiov9
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")

data("color_list")
data("modules_PPI_Athalina")
cl <- rep("blue", length(lm))
cl[1] <- "green"
cl[2] <- "orange"
cl[10] <- "red"

id <- plot.modules(g1, mod.list = lm, 
layout.function = layout.graphopt, modules.color = cl, 
mod.edge.col=c("green","darkgreen") , 
tkplot=FALSE, ed.color = c("blue"),sf=-25)



###################################################
### code chunk number 21: plotnetbiov10
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")
data("modules_PPI_Athalina")
data("color_list")

id<-plot.modules(g1,mod.list=lm,layout.function=c(layout.fruchterman.reingold),
modules.color="grey", mod.edge.col = sample(color.list$bright), tkplot=FALSE)


###################################################
### code chunk number 22: plotnetbiov11
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")

data("color_list")
id <- plot.modules(g1, layout.function = c(layout.fruchterman.reingold),
modules.color = sample(color.list$bright),layout.overall = layout.star,
sf=40, tkplot=FALSE)


###################################################
### code chunk number 23: plotnetbiov12
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")

data("color_list")
id <- plot.modules(g1, layout.function = c(layout.fruchterman.reingold,
layout.star,layout.reingold.tilford, layout.graphopt,layout.kamada.kawai),
modules.color = sample(color.list$bright), sf=40, tkplot=FALSE)


###################################################
### code chunk number 24: plotnetbiov13
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")

data("color_list")


cl <- list(rainbow(40),  heat.colors(40) )

id <- plot.modules(g1,  col.grad=cl , tkplot=FALSE)



###################################################
### code chunk number 25: plotnetbiov14
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")

data("color_list")

exp <- rnorm(vcount(g1))

id <- plot.modules(g1, expression  = exp,  tkplot=FALSE)



###################################################
### code chunk number 26: plotnetbiov15
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")

data("color_list")

exp <- rnorm(vcount(g1))

id <- plot.modules(g1, modules.color="grey",
expression  = exp, exp.by.module = c(1,2,5),  tkplot=FALSE)



###################################################
### code chunk number 27: plotnetbiov16
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")

data("color_list")

id <- plot.modules(g1, layout.function = layout.reingold.tilford, 
col.grad=list(color.list$citynight), tkplot=FALSE)


###################################################
### code chunk number 28: plotnetbiov17
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")

data("color_list")
n = vcount(g1)
xx <- plot.NetworkSperical(g1, mo="in", v.lab=FALSE, tkplot = FALSE,v.size=1 )


###################################################
### code chunk number 29: plotnetbiov18
###################################################
getOption("SweaveHooks")[["onefig"]]()
g <- barabasi.game(500)
xx <- plot.NetworkSperical.startSet(g, mo = "in", nc = 5)


###################################################
### code chunk number 30: plotnetbiov19
###################################################
getOption("SweaveHooks")[["onefig"]]()
g <- barabasi.game(3000, directed=FALSE)
fn <- function(g)plot.spiral.graph(g,60)$layout
xx <- plot.modules(g, layout.function=fn, 
layout.overall=layout.fruchterman.reingold,sf=20, v.size=1, color.random=TRUE)


###################################################
### code chunk number 31: plotnetbiov20
###################################################
getOption("SweaveHooks")[["onefig"]]()
g <- barabasi.game(3000, directed=FALSE)
fn <- function(g)plot.spiral.graph(g,12)$layout
xx <- plot.modules(g, layout.function=fn, 
layout.overall=layout.fruchterman.reingold,sf=20, v.size=1, color.random=TRUE)


###################################################
### code chunk number 32: plotnetbiov21
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")
data("color_list")
xx <- plot.spiral.graph(g1, tp=179,vertex.color=sample(color.list$bright) )


###################################################
### code chunk number 33: plotnetbiov22
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")
data("color_list")
xx <- plot.spiral.graph(g1, tp=60,vertex.color=sample(color.list$bright))


###################################################
### code chunk number 34: plotnetbiov23
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")
data("color_list")
xx <- plot.spiral.graph(g1, tp=90,vertex.color="blue",e.col="gold",
rank.function=layout.reingold.tilford)


###################################################
### code chunk number 35: plotnetbiov24
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")
data("color_list")
xx <- plot.abstract.module(g1, tkplot = FALSE, layout.function=layout.star)




###################################################
### code chunk number 36: plotnetbiov25
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")
data("color_list")

xx <- plot.abstract.nodes(g1,  nodes.color ="grey",layout.function=layout.star, 
edge.colors= sample(color.list$bright), tkplot =FALSE,lab.color = "red")


###################################################
### code chunk number 37: plotnetbiov26
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")
data("color_list")
xx <- splitg.mst(g1,  vertex.color = sample(color.list$bright), 
colors = color.list$warm[1:30], tkplot = FALSE)


###################################################
### code chunk number 38: poltnetbiov27
###################################################
getOption("SweaveHooks")[["onefig"]]()
data("PPI_Athalina")

xx <- level.plot(g, tkplot=FALSE, level.spread=FALSE,
layout.function=layout.fruchterman.reingold)


###################################################
### code chunk number 39: netbiov-intro.Rnw:1454-1455
###################################################
sessionInfo()



# Code example from 'supraHex_vignettes' vignette. See references/ for full tutorial.

### R code from vignette source 'supraHex_vignettes.Rnw'

###################################################
### code chunk number 1: supraHex_vignettes.Rnw:99-104
###################################################
library("supraHex")
pdf("supraHex_vignettes-suprahex.pdf", width=6, height=6)
sTopol <- sTopology(xdim=15, ydim=15, lattice="hexa", shape="suprahex")
visHexMapping(sTopol,mappingType="indexes",newpage=FALSE)
dev.off()


###################################################
### code chunk number 2: supraHex_vignettes.Rnw:129-132 (eval = FALSE)
###################################################
## source("http://bioconductor.org/biocLite.R")
## biocLite("supraHex")
## library(supraHex) # load the package


###################################################
### code chunk number 3: supraHex_vignettes.Rnw:136-139 (eval = FALSE)
###################################################
## install.packages("hexbin",repos="http://www.stats.bris.ac.uk/R")
## install.packages("supraHex",repos="http://R-Forge.R-project.org", type="source")
## library(supraHex) # load the package


###################################################
### code chunk number 4: supraHex_vignettes.Rnw:143-145 (eval = FALSE)
###################################################
## library(help="supraHex") # real-time help
## help.start() # html help (follow the links to supraHex)


###################################################
### code chunk number 5: supraHex_vignettes.Rnw:149-150 (eval = FALSE)
###################################################
## browseVignettes("supraHex")


###################################################
### code chunk number 6: supraHex_vignettes.Rnw:154-155 (eval = FALSE)
###################################################
## citation("supraHex") # cite the package


###################################################
### code chunk number 7: startup
###################################################
data <- cbind(
matrix(rnorm(1000*3,mean=0.5,sd=1), nrow=1000, ncol=3), 
matrix(rnorm(1000*3,mean=-0.5,sd=1), nrow=1000, ncol=3)
)
colnames(data) <- c("S1","S1","S1","S2","S2","S2")


###################################################
### code chunk number 8: supraHex_vignettes.Rnw:249-250
###################################################
data[1:5,]


###################################################
### code chunk number 9: supraHex_vignettes.Rnw:255-256 (eval = FALSE)
###################################################
## data <- read.table(file="you_input_data_file", header=TRUE, row.names=1, sep="\t")


###################################################
### code chunk number 10: supraHex_vignettes.Rnw:278-279
###################################################
sMap <- sPipeline(data=data)


###################################################
### code chunk number 11: supraHex_vignettes.Rnw:284-287
###################################################
# it will also write out a file ('Output.txt') into your disk
output <- sWriteData(sMap=sMap, data=data, filename="Output.txt") 
output[1:5,]


###################################################
### code chunk number 12: supraHex_vignettes.Rnw:301-302 (eval = FALSE)
###################################################
## visHexMapping(sMap,mappingType="indexes",newpage=FALSE)


###################################################
### code chunk number 13: supraHex_vignettes.Rnw:306-309
###################################################
pdf("supraHex_vignettes-hit.pdf", width=6, height=6)
visHexMapping(sMap,mappingType="hits",newpage=FALSE)
dev.off()


###################################################
### code chunk number 14: supraHex_vignettes.Rnw:314-317
###################################################
pdf("supraHex_vignettes-distance.pdf", width=6, height=6)
visHexMapping(sMap,mappingType="dist",newpage=FALSE)
dev.off()


###################################################
### code chunk number 15: supraHex_vignettes.Rnw:329-333
###################################################
pdf("supraHex_vignettes-line.pdf", width=6, height=6)
visHexPattern(sMap, plotType="lines", 
customized.color=rep(c("red","green"),each=3),newpage=FALSE)
dev.off()


###################################################
### code chunk number 16: supraHex_vignettes.Rnw:338-342
###################################################
pdf("supraHex_vignettes-bar.pdf", width=6, height=6)
visHexPattern(sMap, plotType="bars", 
customized.color=rep(c("red","green"),each=3),newpage=FALSE)
dev.off()


###################################################
### code chunk number 17: supraHex_vignettes.Rnw:349-351 (eval = FALSE)
###################################################
## ?visHexMapping
## ?visHexPattern


###################################################
### code chunk number 18: supraHex_vignettes.Rnw:360-365
###################################################
sBase <- sDmatCluster(sMap=sMap, which_neigh=1, 
distMeasure="median", clusterLinkage="average")
pdf("supraHex_vignettes-cluster.pdf", width=6, height=6)
visDmatCluster(sMap, sBase, newpage=FALSE)
dev.off()


###################################################
### code chunk number 19: supraHex_vignettes.Rnw:371-374
###################################################
# it will also write out a file ('Output_base.txt') into your disk
output <- sWriteData(sMap, data, sBase, filename="Output_base.txt")
output[1:5,]


###################################################
### code chunk number 20: supraHex_vignettes.Rnw:385-387 (eval = FALSE)
###################################################
## sReorder <- sCompReorder(sMap=sMap)
## visCompReorder(sMap=sMap, sReorder=sReorder)


###################################################
### code chunk number 21: supraHex_vignettes.Rnw:400-403
###################################################
pdf("supraHex_vignettes-kernels.pdf", width=12, height=6)
visKernels(newpage=FALSE)
dev.off()


###################################################
### code chunk number 22: supraHex_vignettes.Rnw:412-414 (eval = FALSE)
###################################################
## sMap_ga <- sPipeline(data=data, neighKernel="gaussian", init="uniform")
## visHexMulComp(sMap_ga)


###################################################
### code chunk number 23: supraHex_vignettes.Rnw:419-421 (eval = FALSE)
###################################################
## sMap_bu <- sPipeline(data=data, neighKernel="bubble", init="uniform")
## visHexMulComp(sMap_bu)


###################################################
### code chunk number 24: supraHex_vignettes.Rnw:426-428 (eval = FALSE)
###################################################
## sMap_cu <- sPipeline(data=data, neighKernel="cutgaussian", init="uniform")
## visHexMulComp(sMap_cu)


###################################################
### code chunk number 25: supraHex_vignettes.Rnw:433-435 (eval = FALSE)
###################################################
## sMap_ep <- sPipeline(data=data, neighKernel="ep", init="uniform")
## visHexMulComp(sMap_ep)


###################################################
### code chunk number 26: supraHex_vignettes.Rnw:440-442 (eval = FALSE)
###################################################
## sMap_gm <- sPipeline(data=data, neighKernel="gamma", init="uniform")
## visHexMulComp(sMap_gm)


###################################################
### code chunk number 27: sessinfo
###################################################
sessionInfo()



# Code example from 'GOSim' vignette. See references/ for full tutorial.

### R code from vignette source 'GOSim.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: GOSim.Rnw:42-44
###################################################
library(GOSim)
genes=c("207","208","596","901","780","3169","9518","2852","26353","8614","7494")


###################################################
### code chunk number 2: GOSim.Rnw:47-48
###################################################
getGOInfo(genes)


###################################################
### code chunk number 3: GOSim.Rnw:54-55
###################################################
getTermSim(c("GO:0007166","GO:0007267","GO:0007584","GO:0007165","GO:0007186"),method="Resnik",verbose=FALSE)


###################################################
### code chunk number 4: GOSim.Rnw:68-70
###################################################
data("ICsBPhumanall")
IC[c("GO:0007166","GO:0007267","GO:0007584","GO:0007165","GO:0007186")]


###################################################
### code chunk number 5: GOSim.Rnw:77-78
###################################################
getTermSim(c("GO:0007166","GO:0007267","GO:0007584","GO:0007165","GO:0007186"),verbose=FALSE)


###################################################
### code chunk number 6: GOSim.Rnw:87-88
###################################################
getTermSim(c("GO:0007166","GO:0007267","GO:0007584","GO:0007165","GO:0007186"),method="Lin",verbose=FALSE)


###################################################
### code chunk number 7: GOExample
###################################################
library(igraph)
G = getGOGraph(c("GO:0007166","GO:0007267"))
G2 = igraph.from.graphNEL(G)
plot(G2, vertex.label=V(G2)$name)


###################################################
### code chunk number 8: GOSim.Rnw:102-103
###################################################
getMinimumSubsumer("GO:0007166","GO:0007267")


###################################################
### code chunk number 9: GOSim.Rnw:114-115
###################################################
getDisjCommAnc("GO:0007166","GO:0007267")


###################################################
### code chunk number 10: GOSim.Rnw:124-125
###################################################
getTermSim(c("GO:0007166","GO:0007267"),method="CoutoResnik",verbose=FALSE)


###################################################
### code chunk number 11: GOSim.Rnw:129-131
###################################################
setEnrichmentFactors(alpha=0.5,beta=0.3)
getTermSim(c("GO:0007166","GO:0007267"),method="CoutoEnriched",verbose=FALSE)


###################################################
### code chunk number 12: GOSim.Rnw:138-139
###################################################
getTermSim(c("GO:0007166","GO:0007267","GO:0007584","GO:0007165","GO:0007186"),method="relevance",verbose=FALSE)


###################################################
### code chunk number 13: GOSim.Rnw:193-194
###################################################
getGOInfo(c("8614","2852"))


###################################################
### code chunk number 14: GOSim.Rnw:213-214
###################################################
getGeneSim(c("8614","2852"),similarity="OA",similarityTerm="Lin",avg=FALSE, verbose=FALSE)


###################################################
### code chunk number 15: GOSim.Rnw:218-220
###################################################
getGeneSim(c("8614","2852"),similarity="max",similarityTerm="Lin",verbose=FALSE)
getGeneSim(c("8614","2852"),similarity="funSimMax",similarityTerm="Lin",verbose=FALSE)


###################################################
### code chunk number 16: GOSim.Rnw:233-234
###################################################
getGeneSim(c("8614","2852"),similarity="hausdorff",similarityTerm="Lin",verbose=FALSE)


###################################################
### code chunk number 17: GOSim.Rnw:243-244
###################################################
getGeneSim(c("8614","2852"),similarity="dot",method="Tanimoto", verbose=FALSE)


###################################################
### code chunk number 18: GOSim.Rnw:247-248
###################################################
features = getGeneFeatures(c("8614","2852"))


###################################################
### code chunk number 19: GOSim.Rnw:255-256
###################################################
proto = selectPrototypes(n=3,verbose=FALSE)


###################################################
### code chunk number 20: GOSim.Rnw:266-267 (eval = FALSE)
###################################################
## PHI = getGeneFeaturesPrototypes(genes,prototypes=proto, verbose=FALSE)


###################################################
### code chunk number 21: GOPCAExample (eval = FALSE)
###################################################
## x=seq(min(PHI$features[,1]),max(PHI$features[,1]),length.out=100)
## y=seq(min(PHI$features[,2]),max(PHI$features[,2]),length.out=100)
## plot(x,y,xlab="principal component 1",ylab="principal component 2",type="n")
## text(PHI$features[,1],PHI$features[,2],labels=genes)


###################################################
### code chunk number 22: GOSim.Rnw:288-291 (eval = FALSE)
###################################################
## sim = getGeneSimPrototypes(genes[1:3],prototypes=proto,similarityTerm="Resnik",verbose=FALSE)
## h=hclust(as.dist(1-sim$similarity),"average")
## plot(h,xlab="")


###################################################
### code chunk number 23: GOSim.Rnw:317-319 (eval = FALSE)
###################################################
## ev = evaluateClustering(c(2,3,2,3,1,2,1,1,3,1,2), sim$similarity)
## plot(ev$clustersil,main="")


###################################################
### code chunk number 24: GOSim.Rnw:333-337
###################################################
library(org.Hs.eg.db)
library(topGO)
allgenes = union(c("8614", "9518", "780", "2852"), sample(keys(org.Hs.egGO), 1000)) # suppose these are all genes 
GOenrichment(c("8614", "9518", "780", "2852"), allgenes) # print out what cluster 1 is about



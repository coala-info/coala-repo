# Code example from 'mAPKL' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----setup, include=FALSE--------------------------------------------------
library(knitr)

## ----results='hide',message=FALSE------------------------------------------
library(mAPKL)
library(mAPKLData)
data(mAPKLData)
varLabels(mAPKLData)
breast <- sampling(Data=mAPKLData, valPercent=40, classLabels="type", seed=135)

## ----tidy=TRUE-------------------------------------------------------------
breast

## ----tidy=TRUE,results='hide',message=FALSE--------------------------------
normTrainData <- preprocess(breast$trainData)
normTestData <- preprocess(breast$testData)

## ----tidy=TRUE-------------------------------------------------------------
attributes(normTrainData)

## ----tidy=TRUE,tidy.opts=list(width.cutoff=60)-----------------------------
exprs(breast$trainData)<-normTrainData$clL2.normdata
exprs(breast$testData)<-normTestData$clL2.normdata
out.clL2 <- mAPKL(trObj=breast$trainData, classLabels="type", 
valObj=breast$testData,dataType=7)

## ----tidy=TRUE,tidy.opts=list(width.cutoff=60)-----------------------------
clasPred <- classification(out.clL2@exemplTrain,"type",out.clL2@exemplTest)

## ----tidy=TRUE,tidy.opts=list(width.cutoff=60),message=FALSE---------------
gene.info <- annotate(out.clL2@exemplars,"hgu133plus2.db")
gene.info@results

## ----tidy=TRUE,tidy.opts=list(width.cutoff=60),message=FALSE---------------
probes2pathways(gene.info)

## ----tidy=TRUE,tidy.opts=list(width.cutoff=60),message=FALSE---------------
net.attr <- netwAttr(out.clL2)
wDegreeL <- net.attr@degree$WdegreeL[out.clL2@exemplars]
wClosenessL <- net.attr@closeness$WclosenessL[out.clL2@exemplars]
wBetweenessL <- net.attr@betweenness$WbetweennessL[out.clL2@exemplars]
wTransitivityL <- net.attr@transitivity$WtransitivityL[out.clL2@exemplars]

## ----tidy=TRUE,tidy.opts=list(width.cutoff=60)-----------------------------
Global.val <- c(net.attr@degree$WdegreeG, net.attr@closeness$WclosenessG, 
net.attr@betweenness$WbetweennessG, net.attr@transitivity$WtransitivityG)

## ----tidy=TRUE-------------------------------------------------------------
Global.val <- round(Global.val,2)
exempl.netattr <- rbind(wDegreeL,wClosenessL,wBetweenessL,wTransitivityL)

## ----tidy=TRUE-------------------------------------------------------------
netAttr <- cbind(Global.val,exempl.netattr)
netAttr <- t(netAttr)
netAttr

## ----tidy=TRUE,tidy.opts=list(width.cutoff=60),message=FALSE---------------
# For local degree > global + standard deviation
sdev<-sd(net.attr@degree$WdegreeL)
msd <- net.attr@degree$WdegreeG + sdev
hubs <- wDegreeL[which(wDegreeL > msd)]
hubs

## ----tidy=TRUE,tidy.opts=list(width.cutoff=60),message=FALSE---------------
sdev<-sd(net.attr@degree$WdegreeL)
ms2d <- net.attr@degree$WdegreeG + 2*sdev
net <- net.attr@degree$WdegreeL[which(net.attr@degree$WdegreeL > ms2d)]
idx <- which(net.attr@edgelist[,1] %in% names(net))
new.edgeList <- net.attr@edgelist[idx,]
dim(new.edgeList)
require(igraph)
g=graph.data.frame(new.edgeList,directed=FALSE)
#tkplot(g,layout=layout.fruchterman.reingold)

## ----tidy=TRUE,tidy.opts=list(width.cutoff=60)-----------------------------
sessionInfo()


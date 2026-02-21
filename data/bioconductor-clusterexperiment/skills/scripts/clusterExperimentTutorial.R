# Code example from 'clusterExperimentTutorial' vignette. See references/ for full tutorial.

## ----GlobalOptions, results="hide", include=FALSE, cache=FALSE----------------
knitr::opts_chunk$set(fig.align="center", cache=FALSE, cache.path = "clusterExperimentTutorial_cache/",  fig.path="clusterExperimentTutorial_figure/",error=FALSE, #make it stop on error
fig.width=6,fig.height=6,autodep=TRUE,out.width="600px",out.height="600px",
message=FALSE)
#knitr::opts_knit$set(stop_on_error = 2L) #really make it stop
#knitr::dep_auto()

## ----cache=FALSE--------------------------------------------------------------
set.seed(14456) ## for reproducibility, just in case
library(clusterExperiment)
data(fluidigmData) ## list of the two datasets (tophat_counts and rsem_tpm)
data(fluidigmColData)
se<-SummarizedExperiment(fluidigmData,colData=fluidigmColData)

## -----------------------------------------------------------------------------
assay(se)[1:5,1:10]
colData(se)[,1:5]
NCOL(se) #number of samples

## ----filter-------------------------------------------------------------------
wh_zero <- which(rowSums(assay(se))==0)
pass_filter <- apply(assay(se), 1, function(x) length(x[x >= 10]) >= 10)
se <- se[pass_filter,]
dim(se)

## ----normalization------------------------------------------------------------
#provides matrix of normalized counts
fq <- round(limma::normalizeQuantiles(assay(se)))

## ----addToAssays--------------------------------------------------------------
assays(se) <- c(SimpleList(normalized_counts=fq),assays(se))
assays(se)

## ----colnames-----------------------------------------------------------------
wh<-which(colnames(colData(se)) %in% c("Cluster1","Cluster2"))
colnames(colData(se))[wh]<-c("Published1","Published2")

## ----RSECLoad-----------------------------------------------------------------
data("rsecFluidigm")
# package version the object was created under
metadata(rsecFluidigm)$packageVersion

## ----include=FALSE------------------------------------------------------------
# #check still valid object, in case updated class definitions
# if(!validObject(rsecFluidigm)) stop("rsecFluidigm is not a valid ClusterExperiment object")
# clusterExperiment:::checkRsecFluidigmObject(rsecFluidigm)

## ----RSEC, eval=FALSE---------------------------------------------------------
# ## Example of RSEC call (not run by vignette)
# ## Will overwrite the rsecFluidigm brought in above.
# library(clusterExperiment)
# system.time(rsecFluidigm<-RSEC(se, isCount = TRUE,
#     reduceMethod="PCA", nReducedDims=10,
#     k0s = 4:15,
#     alphas=c(0.1, 0.2, 0.3),
#     ncores=1, random.seed=176201))

## ----RSECprint----------------------------------------------------------------
rsecFluidigm

## ----primaryCluster-----------------------------------------------------------
head(primaryCluster(rsecFluidigm),20)
tableClusters(rsecFluidigm)

## ----clusterMatrix------------------------------------------------------------
head(clusterMatrix(rsecFluidigm)[,1:4])

## ----clusterLabels------------------------------------------------------------
head(clusterLabels(rsecFluidigm))

## ----clusterParams------------------------------------------------------------
head(getClusterManyParams(rsecFluidigm))

## ----plotClusterRSEC----------------------------------------------------------
defaultMar<-par("mar")
plotCMar<-c(1.1,8.1,4.1,1.1)
par(mar=plotCMar)
plotClusters(rsecFluidigm,main="Clusters from RSEC", whichClusters="workflow", colData=c("Biological_Condition","Published2"), axisLine=-1)

## ----plotClustersWorkflow-----------------------------------------------------
par(mar=plotCMar)
plotClustersWorkflow(rsecFluidigm)

## ----plotBarplotRSEC----------------------------------------------------------
plotBarplot(rsecFluidigm,main=paste("Distribution of samples of",primaryClusterLabel(rsecFluidigm)))

## ----plotBarplotRSEC.2--------------------------------------------------------
plotBarplot(rsecFluidigm,whichClusters=c("makeConsensus" ))

## ----plotBarplot2-------------------------------------------------------------
plotBarplot(rsecFluidigm,whichClusters=c("mergeClusters" ,"makeConsensus"))

## ----plotClustersTable--------------------------------------------------------
plotClustersTable(rsecFluidigm,whichClusters=c("mergeClusters" ,"makeConsensus"), margin=1)

## ----plotClustersTableBubble--------------------------------------------------
plotClustersTable(rsecFluidigm,whichClusters=c("mergeClusters" ,"makeConsensus"), margin=1,plotType="bubble")

## ----plotCoClustering_rsec----------------------------------------------------
plotCoClustering(rsecFluidigm,whichClusters=c("mergeClusters","makeConsensus"))

## ----plotDendroRSEC-----------------------------------------------------------
plotDMar<-c(8.1,1.1,5.1,8.1)
par(mar=plotDMar)
plotDendrogram(rsecFluidigm,whichClusters=c("makeConsensus","mergeClusters"))

## ----plotReducedDims----------------------------------------------------------
plotReducedDims(rsecFluidigm)

## ----plotReducedDimsMany------------------------------------------------------
plotReducedDims(rsecFluidigm,whichDims=c(1:4))

## ----recallRSEC---------------------------------------------------------------
rsecFluidigm<-RSEC(rsecFluidigm,isCount=TRUE,consensusProportion=0.6,mergeMethod="JC",mergeCutoff=0.05,stopOnErrors =TRUE)

## ----plotClusterRSECRecall----------------------------------------------------
defaultMar<-par("mar")
plotCMar<-c(1.1,8.1,4.1,1.1)
par(mar=plotCMar)
plotClusters(rsecFluidigm,main="Clusters from RSEC", whichClusters=c("mergeClusters.1","makeConsensus.1","mergeClusters","makeConsensus"), colData=c("Biological_Condition","Published2"), axisLine=-1)

## ----plotClusterRSECReset-----------------------------------------------------
data(rsecFluidigm)

## ----getBestFeatures----------------------------------------------------------
pairsAllRSEC<-getBestFeatures(rsecFluidigm,contrastType="Pairs",p.value=0.05,
                          number=nrow(rsecFluidigm),DEMethod="edgeR")
head(pairsAllRSEC)

## ----getBestFeatures_size-----------------------------------------------------
# We have duplicates of some genes:
any(duplicated(pairsAllRSEC$Feature))

## ----getBestFeatures_heatmap--------------------------------------------------
plotHeatmap(rsecFluidigm, whichClusters=c("makeConsensus","mergeClusters"),clusterSamplesData="dendrogramValue",
            clusterFeaturesData=unique(pairsAllRSEC[,"IndexInOriginal"]),
            main="Heatmap of features w/ significant pairwise differences",
            breaks=.99)

## ----plotContrastHeatmap------------------------------------------------------
plotContrastHeatmap(rsecFluidigm, signif=pairsAllRSEC,nBlankLines=40,whichCluster="primary")

## ----clusterMany--------------------------------------------------------------
ce<-clusterMany(se, clusterFunction="pam",ks=5:10, minSizes=5,
      isCount=TRUE,reduceMethod=c("PCA","var"),nFilterDims=c(100,500,1000),
      nReducedDims=c(5,15,50),run=TRUE)

## ----plotClusterEx1-----------------------------------------------------------
defaultMar<-par("mar")
par(mar=plotCMar)
plotClusters(ce,main="Clusters from clusterMany", whichClusters="workflow", colData=c("Biological_Condition","Published2"), axisLine=-1)

## ----plotCluster_params-------------------------------------------------------
cmParams<-getClusterManyParams(ce)
head(cmParams)

## ----plotCluster_newOrder-----------------------------------------------------
ord<-order(cmParams[,"reduceMethod"],cmParams[,"nReducedDims"])
ind<-cmParams[ord,"clusteringIndex"]
par(mar=plotCMar)
plotClusters(ce,main="Clusters from clusterMany", whichClusters=ind, colData=c("Biological_Condition","Published2"), axisLine=-1)

## ----plotCluster_newLabels----------------------------------------------------
clOrig<-clusterLabels(ce)
clOrig<-gsub("Features","",clOrig)
par(mar=plotCMar)
plotClusters(ce,main="Clusters from clusterMany", whichClusters=ind, clusterLabels=clOrig[ind], colData=c("Biological_Condition","Published2"), axisLine=-1)

## -----------------------------------------------------------------------------
ce<-makeConsensus(ce,proportion=1)

## ----lookAtCombineMany--------------------------------------------------------
head(clusterMatrix(ce)[,1:3])
par(mar=plotCMar)
plotClustersWorkflow(ce)


## ----makeConsensus_changeLabel------------------------------------------------
wh<-which(clusterLabels(ce)=="makeConsensus")
if(length(wh)!=1) stop() else clusterLabels(ce)[wh]<-"makeConsensus,1"

## ----makeConsensus_newCombineMany---------------------------------------------
ce<-makeConsensus(ce,proportion=0.7,clusterLabel="makeConsensus,0.7")
par(mar=plotCMar)
plotClustersWorkflow(ce)


## ----makeConsensus_changeMinSize----------------------------------------------
ce<-makeConsensus(ce,proportion=0.7,minSize=3,clusterLabel="makeConsensus,final")
par(mar=plotCMar)
plotClustersWorkflow(ce,whichClusters=c("makeConsensus,final","makeConsensus,0.7","makeConsensus,1"),main="Min. Size=3")

## ----plotCoClustering_quickstart----------------------------------------------
plotCoClustering(ce)

## ----makeDendrogram-----------------------------------------------------------
ce<-makeDendrogram(ce,reduceMethod="var",nDims=500)
plotDendrogram(ce)

## ----makeDendrogram_show------------------------------------------------------
ce

## ----mergeClustersPlot--------------------------------------------------------
mergeClusters(ce,mergeMethod="adjP",DEMethod="edgeR",plotInfo="mergeMethod")

## ----mergeClusters------------------------------------------------------------
ce<-mergeClusters(ce,mergeMethod="adjP",DEMethod="edgeR",cutoff=0.05)

## ----mergeClusters_coClustering-----------------------------------------------
par(mar=plotCMar)
plotClustersWorkflow(ce,whichClusters="workflow") 
plotCoClustering(ce,whichClusters=c("mergeClusters","makeConsensus"),
                 colData=c("Biological_Condition","Published2"),annLegend=FALSE)

## ----plotHeatmap--------------------------------------------------------------
plotHeatmap(ce,clusterSamplesData="dendrogramValue",breaks=.99,
            colData=c("Biological_Condition", "Published1", "Published2"))

## ----quasiRsecCode, eval=FALSE------------------------------------------------
# rsecOut<-RSEC(se, isCount=TRUE, reduceMethod="PCA", nReducedDims=c(50,10), k0s=4:15,
#         alphas=c(0.1,0.2,0.3),betas=c(0.8,0.9), minSizes=c(1,5), clusterFunction="hierarchical01",
#         consensusProportion=0.7, consensusMinSize=5,
#         dendroReduce="mad",dendroNDims=500,
#         mergeMethod="adjP",mergeCutoff=0.05,
# 		)

## ----stepCode,eval=FALSE------------------------------------------------------
# ce<-clusterMany(se,ks=4:15,alphas=c(0.1,0.2,0.3),betas=c(0.8,0.9),minSizes=c(1,5),
# 	clusterFunction="hierarchical01", sequential=TRUE,subsample=TRUE,
#          reduceMethod="PCA",nFilterDims=c(50,10),isCount=TRUE)
# ce<-makeConsensus(ce, proportion=0.7, minSize=5)
# ce<-makeDendrogram(ce,reduceMethod="mad",nDims=500)
# ce<-mergeClusters(ce,mergeMethod="adjP",DEMethod="edgeR",cutoff=0.05,plot=FALSE)

## ----show---------------------------------------------------------------------
ce

## ----CEHelperCommands1--------------------------------------------------------
head(clusterMatrix(ce))[,1:5]
primaryCluster(ce)

## ----CEHelperCommands2--------------------------------------------------------
head(clusterLabels(ce),10)

## ----CEHelperCommands3--------------------------------------------------------
head(clusterTypes(ce),10)

## ----SECommandsOnCE-----------------------------------------------------------
colData(ce)[,1:5]

## ----CEClusterLengend---------------------------------------------------------
length(clusterLegend(ce))
clusterLegend(ce)[1:2]

## ----CEClusterLengendAssign---------------------------------------------------
newName<-gsub("m","M",clusterLegend(ce)[[1]][,"name"])
renameClusters(ce,whichCluster=1,value=newName)
print(ce)

## ----basicSubsetting----------------------------------------------------------
smallCe<-ce[1:5,1:10]
smallCe


## ----matrixAfterSubset--------------------------------------------------------
clusterMatrix(smallCe)[,1:4]
clusterMatrix(ce)[1:10,1:4]

## ----lookAtSubset-------------------------------------------------------------
clusterLegend(smallCe)[["mergeClusters"]]
clusterLegend(ce)[["mergeClusters"]]

## ----afterSubsetting----------------------------------------------------------
nodeMergeInfo(ce)
nodeMergeInfo(smallCe)

## ----subsampleByCluster-------------------------------------------------------
subCe<-subsetByCluster(ce,whichCluster="mergeClusters",clusterValue=c("m1","m2"))
subCe

## ----assignNeg----------------------------------------------------------------
ce<-assignUnassigned(ce,whichCluster="mergeClusters",reduceMethod="PCA",nDim=50,makePrimary=FALSE, filterIgnoresUnassigned=TRUE,clusterLabel="mergeClusters_AssignToCluster")
tableClusters(ce,whichCluster="mergeClusters_AssignToCluster")

## ----assignNeg_plotClusters---------------------------------------------------
plotClusters(ce,whichCluster=c("mergeClusters_AssignToCluster","mergeClusters"))

## ----buildInDimReduce---------------------------------------------------------
listBuiltInReducedDims()
listBuiltInFilterStats()

## ----plotClusterEx1_redo------------------------------------------------------
par(mar=plotCMar)
plotClusters(ce,main="Clusters from clusterMany", whichClusters="workflow", 
             axisLine=-1)

## ----plotClusterEx1_newOrder--------------------------------------------------
par(mar=plotCMar)
plotClusters(ce,whichClusters="clusterMany",
               main="Only Clusters from clusterMany",axisLine=-1)

## ----plotClusterEx1_addData---------------------------------------------------
par(mar=plotCMar)
plotClusters(ce,whichClusters="workflow", colData=c("Biological_Condition","Published2"), 
               main="Workflow clusters plus other data",axisLine=-1)

## ----plotClusterEx1_origColors------------------------------------------------
clusterLegend(ce)[c("mergeClusters","makeConsensus,final")]

## ----plotClusterLegend_before,out.width="300px",out.height="300px"------------
plotClusterLegend(ce,whichCluster="makeConsensus,final")

## ----plotClusterEx1_setColors-------------------------------------------------
ce_temp<-plotClusters(ce,whichClusters="workflow", colData=c("Biological_Condition","Published2"), 
               main="Cluster Alignment of Workflow Clusters",clusterLabels=FALSE, axisLine=-1, resetNames=TRUE,resetColors=TRUE,resetOrderSamples=TRUE)

## ----plotClusterEx1_newColors-------------------------------------------------
clusterLegend(ce_temp)[c("mergeClusters","makeConsensus,final")]

## ----plotClusterEx1_clusterLegend---------------------------------------------
ce_temp<-ce
clusterLegend(ce_temp)[["mergeClusters"]]

## ----plotClusterEx1_assignColors----------------------------------------------
newColors<-c("white","blue","green","cyan","purple")
newNames<-c("Not assigned","Cluster1","Cluster2","Cluster3","Cluster4")
#note we make sure they are assigned to the right cluster Ids by giving the 
#clusterIds as names to the new vectors
names(newColors)<-names(newNames)<-clusterLegend(ce_temp)[["mergeClusters"]][,"name"]
renameClusters(ce_temp,whichCluster="mergeClusters",value=newNames)
recolorClusters(ce_temp,whichCluster="mergeClusters",value=newColors)

## ----plotClusterLegend,out.width="300px",out.height="300px"-------------------
plotClusterLegend(ce_temp,whichCluster="mergeClusters")

## ----plotClusterEx1_firstOnlyNoSave-------------------------------------------
plotClusters(ce_temp,whichClusters="workflow", colData=c("Biological_Condition","Published2"), clusterLabels=FALSE,
               main="Clusters from clusterMany, different order",axisLine=-1,existingColors="firstOnly")

## ----plotClusterEx1_firstOnly-------------------------------------------------
ce_temp<-plotClusters(ce_temp,whichClusters="workflow", colData=c("Biological_Condition","Published2"), resetColors=TRUE,
               main="Clusters from clusterMany, different order",axisLine=-1, clusterLabels=FALSE, existingColors="firstOnly",plot=FALSE)

## ----plotClusterEx1_forceColors,fig.width=18,fig.height=9---------------------
par(mfrow=c(1,2))
plotClusters(ce_temp, colData=c("Biological_Condition","Published2"),
             whichClusters="workflow", existingColors="all", clusterLabels=FALSE,
             main="All Workflow Clusters, use existing colors",axisLine=-1)

plotClusters(ce_temp, colData=c("Biological_Condition","Published2"), 
             existingColors="all", whichClusters="clusterMany", clusterLabels=FALSE,
             main="clusterMany Clusters, use existing colors",
             axisLine=-1)

## ----plotClusterEx1_compareForceColors,fig.width=18,fig.height=18-------------
par(mfrow=c(2,2))
plotClusters(ce_temp, colData=c("Biological_Condition","Published2"), 
             existingColors="all", whichClusters="clusterMany", clusterLabels=FALSE,
             main="clusterMany Clusters, use existing colors",
             axisLine=-1)
plotClusters(ce_temp, colData=c("Biological_Condition","Published2"), 
               existingColors="firstOnly", whichClusters="clusterMany", clusterLabels=FALSE,
               main="clusterMany Clusters, use existing of first row only",
               axisLine=-1)
plotClusters(ce_temp, colData=c("Biological_Condition","Published2"), 
            existingColors="ignore", whichClusters="clusterMany", clusterLabels=FALSE,
            main="clusterMany Clusters, default\n(ignoring assigned colors)",
            axisLine=-1)

## ----showPalette--------------------------------------------------------------
showPalette()

## ----showPaletteOptions-------------------------------------------------------
showPalette(which=1:10)
showPalette(palette())

## ----showPaletteMassive-------------------------------------------------------
showPalette(massivePalette,cex=0.5)

## ----removeBlack--------------------------------------------------------------
plotClusters(ce,whichClusters="workflow", colData=c("Biological_Condition","Published2"), unassignedColor="black",colPalette=bigPalette[-grep("black",bigPalette)],
               main="Setting unassigned color",axisLine=-1)


## ----plotWorkflow-------------------------------------------------------------
plotClustersWorkflow(ce, axisLine= -1)

## ----plotWorkflow_resort------------------------------------------------------
par(mar=plotCMar)
plotClustersWorkflow(ce,whichClusters=c("makeConsensus,final","makeConsensus,0.7","makeConsensus,1"),main="Different choices of proportion in makeConsensus",sortBy="clusterMany",highlightOnTop=FALSE, axisLine= -1)

## ----plotHeatmap_Ex1----------------------------------------------------------
par(mfrow=c(1,1))
par(mar=defaultMar)
plotHeatmap(ce,main="Heatmap with clusterMany")

## ----plotHeatmap_Ex1.1--------------------------------------------------------
whClusterPlot<-1:2
plotHeatmap(ce,whichClusters=whClusterPlot, annLegend=FALSE)

## ----plotHeatmap_primaryCluster-----------------------------------------------
plotHeatmap(ce,clusterSamplesData="primaryCluster",
            whichClusters="primaryCluster",
            main="Heatmap with clusterMany",annLegend=FALSE)

## ----showCE_dendrogram--------------------------------------------------------
show(ce)

## ----plotHeatmap_dendro-------------------------------------------------------
plotHeatmap(ce,clusterSamplesData="dendrogramValue",
            whichClusters=c("mergeClusters","makeConsensus"),
            main="Heatmap with clusterMany",
            colData=c("Biological_Condition","Published2"),annLegend=FALSE)

## ----plotHeatmap_break99------------------------------------------------------
plotHeatmap(ce,clusterSamplesData="primaryCluster",
            whichClusters="primaryCluster", breaks=0.99,
            main="Heatmap with clusterMany, breaks=0.99",annLegend=FALSE)

## ----plotHeatmap_break95------------------------------------------------------
plotHeatmap(ce,clusterSamplesData="primaryCluster",
            whichClusters="primaryCluster", breaks=0.95,
            main="Heatmap with clusterMany, breaks=0.95",annLegend=FALSE)

## ----plotDendro_redoBasic-----------------------------------------------------
plotDendrogram(ce)

## ----plotDendro_Types---------------------------------------------------------
par(mfrow=c(1,2))
plotDendrogram(ce,leafType="clusters",plotType="colorblock")
plotDendrogram(ce,leafType="clusters",plotType="name")

## ----plotDendro_MultiClusters-------------------------------------------------
par(mar=plotDMar)
plotDendrogram(ce,whichClusters=c("makeConsensus","mergeClusters"))

## ----plotDendro_Merge---------------------------------------------------------
par(mar=plotDMar)
plotDendrogram(ce,whichClusters=c("makeConsensus","mergeClusters"),merge="mergeMethod")

## ----plotDendro_colData-------------------------------------------------------
plotDendrogram(ce,whichClusters=c("makeConsensus","mergeClusters"),colData=c("Biological_Condition","Published1","Published2"),merge="mergeMethod")

## ----plotDendro_NodeNames-----------------------------------------------------
par(mar=plotDMar)
plotDendrogram(ce,whichClusters=c("makeConsensus","mergeClusters"),show.node.label=TRUE)

## ----plotDendro_NodeColors----------------------------------------------------
nodeNames<-paste("NodeId",1:6,sep="")
nodeColors<-massivePalette[1:length(nodeNames)]
names(nodeColors)<-nodeNames
par(mar=plotDMar)
plotDendrogram(ce,whichClusters=c("makeConsensus","mergeClusters"),merge="mergeMethod",nodeColors=nodeColors)

## ----builtInFunctions---------------------------------------------------------
listBuiltInFunctions()

## ----getInputType-------------------------------------------------------------
inputType(c("kmeans","pam","hierarchicalK"))

## ----getAlgorithmType---------------------------------------------------------
algorithmType(c("kmeans","hierarchicalK","hierarchical01"))

## ----builtInKFunctions--------------------------------------------------------
listBuiltInTypeK()

## ----builtIn01Functions-------------------------------------------------------
listBuiltInType01()

## ----requiredArgs-------------------------------------------------------------
requiredArgs(c("hierarchical01","hierarchicalK"))

## ----mainClusterArgsSyntax,eval=FALSE-----------------------------------------
# clusterMany(x,clusterFunction="hierarchicalK", ... , mainClusterArgs=list(clusterArgs=list(method="single") ))

## ----subsampleArgsSyntax,eval=FALSE-------------------------------------------
# clusterMany(x,..., subsampleArgs=list(resamp.num=100,samp.p=0.5,clusterFunction="hiearchicalK", clusterArgs=list(method="single") ))

## ----seqArgsSyntax,eval=FALSE-------------------------------------------------
# clusterMany(x,..., seqArgs=list( remain.n=10))

## ----tableArguments, echo=FALSE, message=FALSE, warnings=FALSE, results='asis'----
# simple table creation here
tabl <- "  
Argument| Dependencies |  Passed to | Argument passed to
---------------|-----------------|:-------------:|------:|
ks             | sequential=TRUE |  seqCluster   |  k0 
-    | sequential=FALSE, findBestK=FALSE, clusterFunction of type 'K' | mainClustering | k
-              | sequential=FALSE, findBestK=FALSE, subsample=TRUE | subsampleClustering | k
-               | sequential=FALSE, findBestK=TRUE, clusterFunction of type 'K' | mainClustering | kRange
reduceMethod      | none            | transform     | reduceMethod
nFilterDims       | reduceMethod in 'mad','cv','var' | transform | nFilterDims
nReducedDims       | reduceMethod='PCA' | transform     | nReducedDims
clusterFunction| none            | mainClustering      | clusterFunction    
minSizes       | none            | mainClustering      | minSize
distFunction   | subsample=FALSE | mainClustering      | distFunction
alphas         | clusterFunction of type '01'| mainClustering | alpha
findBestK      | clusterFunction of type 'K' | mainClustering | findBestK
removeSil      | clusterFunction of type 'K' | mainClustering | removeSil
silCutoff      | clusterFunction of type 'K' | mainClustering | silCutoff
betas          | sequential=TRUE | seqCluster    | beta
"
cat(tabl) # output the table in a format good for HTML/PDF/docx conversion

## ----defineDist---------------------------------------------------------------
corDist<-function(x){(1-cor(t(x),method="pearson"))/2}
spearDist<-function(x){(1-cor(t(x),method="spearman"))/2}

## ----visualizeSubsamplingD----------------------------------------------------
ceSub<-clusterSingle(ce,reduceMethod="mad",nDims=1000,subsample=TRUE,subsampleArgs=list(clusterFunction="pam",clusterArgs=list(k=8)),clusterLabel="subsamplingCluster",mainClusterArgs=list(clusterFunction="hierarchical01",clusterArgs=list(alpha=0.1),minSize=5), saveSubsamplingMatrix=TRUE)
plotCoClustering(ceSub)

## ----visualizeSpearmanDist----------------------------------------------------
dSp<-spearDist(t(transformData(ce,reduceMethod="mad",nFilterDims=1000)))
plotHeatmap(dSp,isSymmetric=TRUE)

## ----clusterManyDiffDist_calculateMad,fig.width=15,fig.height=6---------------
ceDist<-makeFilterStats(ce,filterStats="mad")
ceDist

## ----clusterManyDiffDist,fig.width=15,fig.height=6----------------------------
ceDist<-clusterMany(ceDist, k=7:9, alpha=c(0.35,0.4,0.45), 
    clusterFunction=c("tight","hierarchical01","pam","hierarchicalK"),
    findBestK=FALSE,removeSil=c(FALSE), distFunction=c("corDist","spearDist"),
    makeMissingDiss=TRUE,
    reduceMethod=c("mad"),nFilterDims=1000,run=TRUE)
clusterLabels(ceDist)<-gsub("clusterFunction","alg",clusterLabels(ceDist))
clusterLabels(ceDist)<-gsub("Dist","",clusterLabels(ceDist))
clusterLabels(ceDist)<-gsub("distFunction","dist",clusterLabels(ceDist))
clusterLabels(ceDist)<-gsub("hierarchical","hier",clusterLabels(ceDist))
par(mar=c(1.1,15.1,1.1,1.1))
plotClusters(ceDist,axisLine=-2,colData=c("Biological_Condition"))

## ----custom-------------------------------------------------------------------
library(scran)
library(igraph)
SNN_wrap <- function(inputMatrix, k, steps = 4, ...) {
  snn <- buildSNNGraph(inputMatrix, k = k, d = NA, transposed = FALSE) ##scran package
  res <- cluster_walktrap(snn, steps = steps) #igraph package
  return(res$membership)
}

## ----custom_validate----------------------------------------------------------
internalFunctionCheck(SNN_wrap, inputType = "X", algorithmType = "K",
                      outputType="vector")

## ----custom_s4----------------------------------------------------------------
SNN <- ClusterFunction(SNN_wrap, inputType = "X", algorithmType = "K",
                     outputType="vector")

## ----custom_clusterSingle-----------------------------------------------------
ceCustom <- clusterSingle(ce, reduceMethod="PCA", 
    nDims=50, subsample = TRUE, 
    sequential = FALSE,
    mainClusterArgs = list(clusterFunction = "hierarchical01",
                         clusterArgs = list(alpha = 0.3),
                         minSize = 1),
    subsampleArgs = list(resamp.num=100,
                       samp.p = 0.7,
                       clusterFunction = SNN,
                       clusterArgs = list(k = 10),
                       ncores = 1,
                       classifyMethod='InSample')
)
ceCustom

## ----custom_getBuiltIn--------------------------------------------------------
clFuns<-getBuiltInFunction(c("pam","kmeans"))

## ----custom_addSNN------------------------------------------------------------
clFuns<-c(clFuns, "SNN"=SNN)

## ----run_custom---------------------------------------------------------------
ceCustom <- clusterMany(ce, dimReduce="PCA",nPCADims=50,
                        clusterFunction=clFuns,
                        ks=4:15, findBestK=FALSE)


## ----clusterManyCheckParam----------------------------------------------------
checkParam<-clusterMany(se, clusterFunction="pam", ks=2:10,
                        removeSil=c(TRUE,FALSE), isCount=TRUE,
                        reduceMethod=c("PCA","var"), makeMissingDiss=TRUE,
                        nFilterDims=c(100,500,1000),nReducedDims=c(5,15,50),run=FALSE)
dim(checkParam$paramMatrix) #number of rows is the number of clusterings

## ----clusterManyCheckParam2,eval=FALSE----------------------------------------
# # ce<-clusterMany(se,  paramMatrix=checkParam$paramMatrix, mainClusterArgs=checkParam$mainClusterArgs, seqArgs=checkParam$seqArgs,subsampleArgs=checkParam$subsampleArgs)
# ce<-clusterMany(ce, clusterFunction="pam",ks=2:10,findBestK=TRUE,removeSil=c(TRUE), isCount=TRUE,reduceMethod=c("PCA","var"),nFilterDims=c(100,500,1000),nReducedDims=c(5,15,50),run=TRUE)

## ----makeConsensus_detailed---------------------------------------------------
plotCoClustering(ce)

## ----sub_getParams------------------------------------------------------------
params <- getClusterManyParams(ce)
head(params)

## ----sub_makeConsensus--------------------------------------------------------
clusterIndices15 <- params$clusteringIndex[which(params$nReducedDims == 15)]
clusterIndices50 <- params$clusteringIndex[which(params$nReducedDims == 50)]
#note, the indices will change as we add clusterings!
clusterNames15 <- clusterLabels(ce)[clusterIndices15]
clusterNames50 <- clusterLabels(ce)[clusterIndices50]
shortNames15<-gsub("reduceMethod=PCA,nReducedDims=15,nFilterDims=NA,","",clusterNames15)
shortNames50<-gsub("reduceMethod=PCA,nReducedDims=50,nFilterDims=NA,","",clusterNames50)

ce <- makeConsensus(ce, whichClusters = clusterNames15, proportion = 0.7,
                       clusterLabel = "consensusPCA15")
ce <- makeConsensus(ce, whichClusters = clusterNames50, proportion = 0.7,
                       clusterLabel = "consensusPCA50")

## ----sub_visualize,fig.width=12,fig.height=6----------------------------------
par(mar=plotCMar,mfrow=c(1,2))
plotClustersWorkflow(ce, whichClusters ="consensusPCA15",clusterLabel="Consensus",whichClusterMany=match(clusterNames15,clusterLabels(ceSub)),clusterManyLabels=c(shortNames15),axisLine=-1,nBlankLines=1,main="15 PCs")
plotClustersWorkflow(ce, whichClusters = c("consensusPCA50"),clusterLabel="Consensus",clusterManyLabels=shortNames50, whichClusterMany=match(clusterNames50,clusterLabels(ceSub)),nBlankLines=1,main="50 PCs")

## ----makeConsensus_chooseClusters---------------------------------------------
wh<-getClusterManyParams(ce)$clusteringIndex[getClusterManyParams(ce)$reduceMethod=="var"]
ce<-makeConsensus(ce,whichCluster=wh,proportion=0.7,minSize=3,
                clusterLabel="makeConsensus,nVAR")
plotCoClustering(ce)

## ----makeConsensus_showDifferent----------------------------------------------
wh<-grep("makeConsensus",clusterTypes(ce))
par(mar=plotCMar)
plotClusters(ce,whichClusters=rev(wh),axisLine=-1)

## ----makeDendrogram_reducedFeatures-------------------------------------------
ce<-makeDendrogram(ce,reduceMethod="var",nDims=500)
plotDendrogram(ce)

## ----showCe-------------------------------------------------------------------
show(ce)

## ----remakeMakeDendrogram-----------------------------------------------------
ce<-makeDendrogram(ce,reduceMethod="var",nDims=500,
                   whichCluster="makeConsensus,final")

## ----plotRemadeDendrogram-----------------------------------------------------
plotDendrogram(ce,leafType="sample",plotType="colorblock")

## ----plotRemadeDendrogram_compare---------------------------------------------
par(mar=plotDMar)
whCM<-grep("makeConsensus",clusterTypes(ce))
plotDendrogram(ce,whichClusters=whCM,leafType="sample",plotType="colorblock")

## ----showCurrentPrimaryCluster------------------------------------------------
primaryClusterLabel(ce)
show(ce)

## ----clusterTypeOfCombineMany-------------------------------------------------
whFinal<-which(clusterLabels(ce)=="makeConsensus,final")
head(clusterMatrix(ce,whichCluster=whFinal))
clusterTypes(ce)[whFinal]

## ----getBackCombineMany-------------------------------------------------------
ce<-setToCurrent(ce,whichCluster="makeConsensus,final")
show(ce)

## ----printClusterDendrogram---------------------------------------------------
clusterDendrogram(ce)
head(sampleDendrogram(ce))

## ----showPhylobase------------------------------------------------------------
library(phylobase)
nodeLabels(clusterDendrogram(ce))
descendants(clusterDendrogram(ce),node="NodeId3")

## ----changeNodeLabels---------------------------------------------------------
newNodeLabels<-LETTERS[1:nNodes(ce)]
names(newNodeLabels)<-nodeLabels(ce)
nodeLabels(ce)<-newNodeLabels

## ----checkWhatDendro----------------------------------------------------------
ce

## ----runMergeDetail-----------------------------------------------------------
ce<-mergeClusters(ce,mergeMethod="adjP",plotInfo=c("adjP"),calculateAll=FALSE)

## ----getMergeInfo-------------------------------------------------------------
mergeMethod(ce)
mergeCutoff(ce)
nodeMergeInfo(ce)

## ----mergeClusters_plot,fig.width=12------------------------------------------
ce<-mergeClusters(ce,mergeMethod="none",plotInfo="all")

## ----showMergeAll-------------------------------------------------------------
nodeMergeInfo(ce)

## ----mergeClusters_ex---------------------------------------------------------
ce<-mergeClusters(ce,cutoff=0.05,mergeMethod="adjP",clusterLabel="mergeClusters,v2",plot=FALSE)
ce

## ----mergeClusters_reexamineNode----------------------------------------------
nodeMergeInfo(ce)

## ----mergeClusters_redo-------------------------------------------------------
ce<-mergeClusters(ce,cutoff=0.15,mergeMethod="Storey",
                  clusterLabel="mergeClusters,v3",plot=FALSE)
ce

## ----mergeClusters_compareMerges----------------------------------------------
par(mar=c(1.1,1.1,6.1,2.1))
plotDendrogram(ce,whichClusters=c("mergeClusters,v3","mergeClusters,v2"),mergeInfo="mergeMethod")

## ----mergeClusters_logFC------------------------------------------------------
ce<-mergeClusters(ce,cutoff=0.05,mergeMethod="adjP", logFCcutoff=2,
                  clusterLabel="mergeClusters,FC1",plot=FALSE)
ce

## ----mergeClusters_compareMergesAgain-----------------------------------------
par(mar=c(1.1,1.1,6.1,2.1))
plotDendrogram(ce,whichClusters=c("mergeClusters,FC1","mergeClusters,v3","mergeClusters,v2"),mergeInfo="mergeMethod")

## ----workflowTable------------------------------------------------------------
workflowClusterTable(ce)

## ----workflowDetails----------------------------------------------------------
head(workflowClusterDetails(ce),8)

## ----markFinal----------------------------------------------------------------
ce<-setToFinal(ce,whichCluster="mergeClusters,v2",
               clusterLabel="Final Clustering")
par(mar=plotCMar)
plotClusters(ce,whichClusters="workflow")

## ----rsecTable, echo=FALSE, message=FALSE, warnings=FALSE, results='asis'-----
# simple table creation here
tabl <- "  
| | Arguments in original function internally fixed | Arguments in RSEC for the user |   |  |
|:-----------------|:-----------------|:-------------|:------|:------|
     | | *Name of Argument in original function (if different)* | *Notes*|
*clusterMany*| sequential=TRUE | k0s              | ks | RSEC only sets 'k0', no other k 
- | distFunction=NA | clusterFunction | |
- | removeSil=FALSE | reduceMethod | | 
- | subsample=TRUE | nFilterDims | | 
- |  silCutoff=0 | nReducedDims | | 
- |  | alphas | |
- |  | betas | |
- |  | minSizes | |
-  | | mainClusterArgs | |
-  | | subsampleArgs | |
- |  | seqArgs | |
- |  | run | |
- |  | ncores | |
- |  | random.seed | |
- |  | isCount | |
- |  | transFun | |
-  |  | isCount | |  
*makeConsensus*  | propUnassigned = *(default)* | consensusProportion | proportion 
-  | consensusMinSize    | minSize | |
*makeDendrogram* | filterIgnoresUnassigned=TRUE | dendroReduce      | reduceMethod | 
-  | unassignedSamples= *(default)* | dendroNDims       | nDims |  
*mergeClusters*   | plot=FALSE | mergeMethod     | | 
-  | | mergeCutoff | cutoff | 
-  | | mergeDEMethod | DEMethod |
-  | | mergeLogFCcutoff | logFCcutoff |
"

cat(tabl) # output the table in a format good for HTML/PDF/docx conversion


## ----getBestFeatures_onlyTopPairs---------------------------------------------
pairsAllTop<-getBestFeatures(rsecFluidigm,contrastType="Pairs",DEMethod="edgeR",p.value=0.05)
dim(pairsAllTop)
head(pairsAllTop)

## ----getBestFeatures_oneAgainstAll--------------------------------------------
best1vsAll<-getBestFeatures(rsecFluidigm,contrastType="OneAgainstAll",DEMethod="edgeR",p.value=0.05,number=NROW(rsecFluidigm))
head(best1vsAll)

## ----getBestFeatures_oneHeatmap-----------------------------------------------
plotContrastHeatmap(rsecFluidigm,signifTable=best1vsAll,nBlankLines=10, whichCluster="primary")

## ----getBestFeatures_dendro---------------------------------------------------
bestDendro<-getBestFeatures(rsecFluidigm,contrastType="Dendro",DEMethod="edgeR",p.value=0.05,number=NROW(rsecFluidigm))
head(bestDendro)

## ----dendroContrastLevels-----------------------------------------------------
levels((bestDendro)$Contrast)

## ----getBestFeatures_dendroHeatmap--------------------------------------------
plotContrastHeatmap(rsecFluidigm,signifTable=bestDendro,nBlankLines=10)

## ----dendroWithNodeNames------------------------------------------------------
plotDendrogram(rsecFluidigm,show.node.label=TRUE,whichClusters=c("makeConsensus","mergeClusters"),leaf="samples",plotType="colorblock")

## ----exampleCode,eval=FALSE---------------------------------------------------
# assay(rsecFluidigm,"weights")<- myweights

## ----slotnames----------------------------------------------------------------
assayNames(se)

## ----clusterUnnormalized, eval=FALSE------------------------------------------
# rsecTPM <- RSEC(se, whichAssay = "rsem_tpm", transFun = log1p, mergeDEMethod="limma",
#               reduceMethod="PCA", nReducedDims=10, consensusMinSize=3,
#               ncores=1, random.seed=176201)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()


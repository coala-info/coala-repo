# Code example from 'sincell-vignette' vignette. See references/ for full tutorial.

## ----knitr, echo=FALSE, results="hide"----------------------------------------
library("knitr")
opts_chunk$set(tidy=FALSE,tidy.opts=list(width.cutoff=30),dev="png",fig.show="hide",
               fig.width=4,fig.height=4.5,
               message=FALSE)

## ----style, eval=TRUE, echo=FALSE, results="asis"--------------------------
BiocStyle::latex()

## ----options, results="hide", echo=FALSE--------------------------------------
options(digits=3, width=80, prompt=" ", continue=" ")

## ----install_sincell, eval=FALSE----------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("sincell")

## ----install_missing_bioconductor_packages, eval=FALSE------------------------
# packages.bioconductor<-c("biomaRt","monocle")
# packages.bioconductor.2install <- packages [!(packages.bioconductor
#      %in%  installed.packages()[, "Package"])]
# if(length(packages.bioconductor.2install)>0){
#   for (i in 1:length(packages.bioconductor.2install)){
#     BiocManager::install(packages.bioconductor.2install[i])
#   }
# }

## ----init_sincell, cache=FALSE, eval=TRUE,warning=FALSE-----------------------
library(sincell)

## ----set_seed, echo=FALSE, results="hide"-------------------------------------
set.seed(42)

## ----initialize_sincellObject_example, eval=FALSE-----------------------------
# # Do not run
# SincellObject<-sc_InitializingSincellObject(ExpressionMatrix)

## ----monocle_expression_matrix_filtering, eval = TRUE-------------------------
# Within R console we load monocle package:
library(monocle)

## ----monocle_expression_matrix_filtering_2, eval = FALSE----------------------
# # WARNING: do not run
# 
# HSMM <- detectGenes(HSMM, min_expr = 0.1)
# expressed_genes <- row.names(subset(fData(HSMM), num_cells_expressed >= 50))
# # The vector expressed_genes now holds the identifiers for genes expressed in
# # at least 50 cells of the data set.
# 
# # Keeping expressed genes with q-value < 0.01
# diff_test_res <- differentialGeneTest(HSMM[expressed_genes,],
#                          fullModelFormulaStr = "expression~Media")
# ordering_genes <- row.names(subset(diff_test_res, qval < 0.01))
# HSMM <- HSMM[ordering_genes,]

## ----load_data, eval=TRUE-----------------------------------------------------
data(ExpressionMatrix)

## ----logtransform_data, eval=TRUE---------------------------------------------
EMlog <- unique(
       log(ExpressionMatrix[which(apply(ExpressionMatrix,1,var)>0),]+1)
       )
EMlog <- as.matrix( EMlog[as.logical(apply(!is.nan(EMlog),1,sum)),])

## ----change_geneIDs, eval=TRUE------------------------------------------------
GeneEnsemblID<-rownames(EMlog)
head(GeneEnsemblID)
GeneEnsemblID <- sapply( strsplit(GeneEnsemblID, split=".",fixed=TRUE),"[",1)
head(GeneEnsemblID)
library("biomaRt")
ensembl = useMart( "ensembl", dataset = "hsapiens_gene_ensembl" ) 
genemap <- getBM( attributes = c("ensembl_gene_id", "entrezgene_id", "hgnc_symbol"), 
	filters = "ensembl_gene_id", values = GeneEnsemblID, mart = ensembl, useCache = FALSE ) 
idx <- match(GeneEnsemblID, genemap$ensembl_gene_id ) 
GeneEntrez <- genemap$entrezgene_id[ idx ] 
GeneHGCN <- genemap$hgnc_symbol[ idx ]

rownames(EMlog)[!is.na(GeneHGCN)&(GeneHGCN!="")]<- 
	GeneHGCN[!is.na(GeneHGCN)&(GeneHGCN!="")]
head(rownames(EMlog))

## ----initialize_sincellObject, eval=TRUE--------------------------------------
SO<-sc_InitializingSincellObject(EMlog)

## ----accessing_expressionmatrix, eval=TRUE------------------------------------
expressionmatrix<-SO[["expressionmatrix"]]

## ----cell_to_cell_distance_matrix, eval=FALSE---------------------------------
# ## Assessment of a cell-to-cell distance matrix
# # help(sc_distanceObj())
# 
# # Euclidean distance
# SO<-sc_distanceObj(SO, method="euclidean")
# cell2celldist_Euclidean<-SO[["cell2celldist"]]
# 
# # Cosine distance
# SO<-sc_distanceObj(SO, method="cosine")
# cell2celldist_Cosine<-SO[["cell2celldist"]]
# 
# # Distance based on 1-Pearson correlation
# SO<-sc_distanceObj(SO, method="pearson")
# cell2celldist_Pearson<-SO[["cell2celldist"]]
# 
# # Distance based on 1-Spearman correlation
# SO<- sc_distanceObj(SO, method="spearman")
# cell2celldist_Spearman<-SO[["cell2celldist"]]
# 
# # L1 distance
# SO<- sc_distanceObj(SO, method="L1")
# cell2celldist_L1<-SO[["cell2celldist"]]

## ----Mutual_Information, eval=FALSE-------------------------------------------
# # Mutual information distance is assessed by making bins of expression levels
# # as defined by the "bines" parameter. This function internally calls function
# #  mi.empirical from package "entropy" using unit="log2".
# SO<-sc_distanceObj(SO, method="MI", bins=c(-Inf,0,1,2,Inf))
# cell2celldist_MI<-SO[["cell2celldist"]]

## ----PCA, eval=TRUE-----------------------------------------------------------
# help(sc_DimensionalityReductionObj)

# Principal Component Analysis (PCA)
SO <- sc_DimensionalityReductionObj(SO, method="PCA", dim=3)
cellsLowDimensionalSpace_PCA<-SO[["cellsLowDimensionalSpace"]]

## ----EigenValues, echo=TRUE, fig.width=4.5, fig.height=4.5--------------------
plot(SO[["EigenValuesPCA"]],las=1, 
	main="Proportion of variance explained by\neach PCA principal axis", 
	ylab="Proportion of variance",xlab="Principal axes",
	pch=16,ylim=c(0,0.25))

## ----ICA_tSNE, eval=TRUE,message=FALSE,warning=FALSE,results="hide"-----------
# Independent Component Analysis (ICA)
SO <- sc_DimensionalityReductionObj(SO, method="ICA", dim=3)
cellsLowDimensionalSpace_ICA<-SO[["cellsLowDimensionalSpace"]]
# t-Distributed Stochastic Neighbor Embedding (t-SNE)
SO <- sc_DimensionalityReductionObj(SO, method="tSNE", dim=3)
cellsLowDimensionalSpace_tSNE<-SO[["cellsLowDimensionalSpace"]]

## ----MDS, eval=TRUE,message=FALSE,warning=FALSE,results="hide"----------------
# Classic Multidimensional Scaling (classical-MDS).
SO <- sc_DimensionalityReductionObj(SO, method="classical-MDS", dim=3)
cellsLowDimensionalSpace_classicalMDS<-SO[["cellsLowDimensionalSpace"]]

# Non-metric Multidimensional Scaling (nonmetric-MDS).
SO <- sc_DimensionalityReductionObj(SO, method="nonmetric-MDS", dim=3)
cellsLowDimensionalSpace_nonmetricMDS<-SO[["cellsLowDimensionalSpace"]]

## ----cell2cell_dist, eval=TRUE------------------------------------------------
# Cell-to-cell distance matrix from coordinates in low dimensional space
cell2celldist <- SO[["cell2celldist"]]

## ----plot_cellsLowDimensionalSpace_ICA, echo=TRUE, fig.width=4.5, fig.height=4.5----
plot(t(cellsLowDimensionalSpace_ICA),col= "black",
     xlab="First axis after dimensionality reduction", 
     ylab="Second axis after dimensionality reduction")

# We can add to the plot the individual cell identifiers 
# as indicated by the column's name of the matrix
text(t(cellsLowDimensionalSpace_ICA),colnames(cellsLowDimensionalSpace_ICA), 
     pos=3,cex=0.4,col="black")

## ----color_by_time, eval=TRUE-------------------------------------------------
ColorT0<-"blue"
ColorT24<-"green"
ColorT48<-"orange"
ColorT72<-"red"

colorSCsByTime<- character(dim(SO[["expressionmatrix"]])[2])
colorSCsByTime[grep("T0_", colnames(SO[["expressionmatrix"]]))]<- ColorT0
colorSCsByTime[grep("T24_",colnames(SO[["expressionmatrix"]]))]<- ColorT24
colorSCsByTime[grep("T48_",colnames(SO[["expressionmatrix"]]))]<- ColorT48
colorSCsByTime[grep("T72_",colnames(SO[["expressionmatrix"]]))]<- ColorT72

## ----plot_cellsLowDimensionalSpace_ICA_coloredbytime, echo=TRUE, fig.width=7.5, fig.height=6.5----
mycex<-1.2
mylwd<-4
myps<-1.2
par(bty="o",xaxs="i",yaxs="i",cex.axis=mycex-0.2,cex.main=mycex,cex.lab=mycex,
     las=1,mar=c(5.3,5.3,2.9,1.6),oma=c(1,1,2,6))
plot(t(cellsLowDimensionalSpace_ICA),col= colorSCsByTime, xlab="First axis", 
     ylab="Second axis",main="ICA")
par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE, 
     xpd = TRUE) 
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n") 
legend("right",title="Time\npoint", c("0h","24h","48h","72h"), 
     fill= c(ColorT0,ColorT24,ColorT48,ColorT72), inset=c(0.03,0),  bty="n")

## ----color_by_marker, eval=TRUE-----------------------------------------------
myMarker<-"CDK1"
colorSCsByMarker<-sc_marker2color(SO, marker=myMarker, color.minimum="yellow3", 
	color.maximum="blue", relative.to.marker=TRUE)

## ----plot_cellsLowDimensionalSpace_ICA_coloredbymarker, echo=TRUE, fig.width=7.5, fig.height=6.5----
mycex<-1.2
mylwd<-4
myps<-1.2
par(bty="o",xaxs="i",yaxs="i",cex.axis=mycex-0.2,cex.main=mycex,cex.lab=mycex,
	las=1,mar=c(5.3,5.3,2.9,1.6),oma=c(1,1,2,6))
plot(t(cellsLowDimensionalSpace_ICA[1:2,]),col= colorSCsByMarker, 
	xlab="First axis", ylab="Second axis",
	main=paste("ICA - Marker:",myMarker),pch=10)

## ----plot_cellsLowDimensional_panel, echo=TRUE, fig.width=6, fig.height=10----
mycex<-1.5
mylwd<-4
myps<-1.2
par(bty="o",xaxs="i",yaxs="i",cex.axis=mycex-0.2,cex.main=mycex,cex.lab=mycex,
	las=1,mar=c(5.3,5.3,2.9,1.6),oma=c(1,1,2,10))
zones=matrix(c(1:8),ncol=2,byrow=FALSE)

layout(zones)
myxlab="First axis"
myylab="Second axis"
plot(t(cellsLowDimensionalSpace_PCA[1:2,]),col= colorSCsByTime, 
	xlab=myxlab, ylab= myylab, main="PCA")
plot(t(cellsLowDimensionalSpace_ICA[1:2,]),col= colorSCsByTime, 
	xlab=myxlab, ylab= myylab, main="ICA")
plot(t(cellsLowDimensionalSpace_tSNE[1:2,]),col= colorSCsByTime, 
	xlab=myxlab, ylab= myylab, main="tSNE")
plot(t(cellsLowDimensionalSpace_nonmetricMDS[1:2,]),col= colorSCsByTime, 
	xlab=myxlab, ylab= myylab, main="nonmetricMDS")

myxlab="Third axis"
myylab="Second axis"
plot(t(cellsLowDimensionalSpace_PCA[c(3,2),]),col= colorSCsByTime, 
	xlab=myxlab, ylab= myylab, main="PCA")
plot(t(cellsLowDimensionalSpace_ICA[c(3,2),]),col= colorSCsByTime, 
	xlab=myxlab, ylab= myylab, main="ICA")
plot(t(cellsLowDimensionalSpace_tSNE[c(3,2),]),col= colorSCsByTime, 
	xlab=myxlab, ylab= myylab, main="tSNE")
plot(t(cellsLowDimensionalSpace_nonmetricMDS[c(3,2),]),col= colorSCsByTime, 
	xlab=myxlab, ylab= myylab, main="nonmetricMDS")

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), 
	new = TRUE, xpd = TRUE) 
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n") 
legend("right",title="Time\npoint", c("0h","24h","48h","72h"), 
	fill= c(ColorT0,ColorT24,ColorT48,ColorT72), inset=c(0.01,0),bty="n")

## ----using_rgl_package, eval=FALSE--------------------------------------------
# library(rgl)
# # Coloring by time point
# plot3d(t(cellsLowDimensionalSpace_nonmetricMDS),
# 	cex=1, size=2, type="s", col= colorSCsByTime)
# plot3d(t(cellsLowDimensionalSpace_ICA),
# 	cex=1, size=2, type="s", col= colorSCsByTime)
# plot3d(t(cellsLowDimensionalSpace_PCA),
# 	cex=1, size=2, type="s", col= colorSCsByTime)
# plot3d(t(cellsLowDimensionalSpace_tSNE),
# 	cex=1, size=2, type="s", col= colorSCsByTime)
# 
# # Coloring by marker
# plot3d(t(cellsLowDimensionalSpace_nonmetricMDS), cex=1, size=2, type="s", col= colorSCsByMarker)

## ----ICA_2dim, eval=TRUE------------------------------------------------------
# Independent Component Analysis (ICA)
SO <- sc_DimensionalityReductionObj(SO, method="ICA", dim=2) 

## ----Cluster_assessment, eval=FALSE-------------------------------------------
# # help(sc_clusterObj)
# 
# # Clusters defined as subgraphs generated by a maximum pair-wise distance cut-off:
# # From a totally connected graph where all cells are connected to each other,
# # the algorithm keeps only pairs of cells connected by a distance lower than
# # a given threshold
# SO<- sc_clusterObj(SO, clust.method="max.distance", max.distance=0.5)
# cellsClustering_SubgraphDist <-SO[["cellsClustering"]]
# clusters(SO[["cellsClustering"]])
# 
# # Clusters defined as subgraphs generated by a given rank-percentile of the
# # shortest pair-wise distances:
# # From a totally connected graph where all cells are connected to each other,
# # the algorithm  keeps only the top "x" percent of shortest pairwise distances.
# # In the example, only the shortest 10\% of all pairwise distances are retained
# # to define subgraphs.
# SO<- sc_clusterObj(SO, clust.method="percent", shortest.rank.percent=10)
# cellsClustering_SubgraphPercent <-SO[["cellsClustering"]]
# clusters(SO[["cellsClustering"]])
# 
# # K-Nearest Neighbours (K-NN) clustering.
# # In the example k is set up to 3
# SO <- sc_clusterObj (SO, clust.method="knn", mutual=FALSE, k=3)
# cellsClustering_KNN <-SO[["cellsClustering"]]
# clusters(SO[["cellsClustering"]])
# 
# # K-Mutual Nearest Neighbours clustering.
# # We present here a variant from K-NN clustering in which only k reciprocal
# # nearest neighbours are clustered together.
# SO <- sc_clusterObj (SO, clust.method="knn", mutual=TRUE, k=3)
# cellsClustering_KMNN <-SO[["cellsClustering"]]
# clusters(SO[["cellsClustering"]])

## ----Cluster_assessment2, eval=FALSE------------------------------------------
# # K-medoids, as calculated by function pam() in package "cluster" on
# # the distance matrix SO[["cell2celldist"]] with a predefined number of groups k
# SO <- sc_clusterObj (SO, clust.method="k-medoids", mutual=TRUE, k=3)
# cellsClustering_kmedoids <-SO[["cellsClustering"]]
# clusters(SO[["cellsClustering"]])
# 
# # Agglomerative clustering as calculated by function hclust with different
# # methods and "cutting" the tree in a given number of groups k with
# # function cutree()
# SO <- sc_clusterObj (SO, clust.method="complete", mutual=TRUE, k=3)
# cellsClustering_hclustcomplete <-SO[["cellsClustering"]]
# clusters(SO[["cellsClustering"]])

## ----graph_assessment0, eval=TRUE---------------------------------------------
# help(sc_GraphBuilderObj)

# Minimum Spanning Tree (MST)
SO<- sc_GraphBuilderObj(SO, graph.algorithm="MST", 
	graph.using.cells.clustering=FALSE)
cellstateHierarchy_MST<-SO[["cellstateHierarchy"]]

## ----graph_assessment1, eval=FALSE--------------------------------------------
# # Maximum Similarity Spanning Tree (SST)
# SO<- sc_GraphBuilderObj(SO, graph.algorithm="SST",
# 	graph.using.cells.clustering=FALSE)
# cellstateHierarchy_SST<-SO[["cellstateHierarchy"]]

## ----graph_assessment2, eval=TRUE---------------------------------------------
# Iterative Mutual Clustering Graph (IMC)
SO<- sc_GraphBuilderObj(SO, graph.algorithm="IMC") 
cellstateHierarchy_IMC<-SO[["cellstateHierarchy"]]

## ----graph_assessment3, eval=FALSE--------------------------------------------
# # Minimum Spanning Tree (MST) with previous clustering of cells
# 
# # MST with K-Mutual Nearest Neighbours clustering
# SO <- sc_clusterObj (SO, clust.method="knn", mutual=TRUE, k=5)
# SO<- sc_GraphBuilderObj(SO, graph.algorithm="MST",
# 	graph.using.cells.clustering=TRUE)
# cellstateHierarchy_MST_clustKNN<-SO[["cellstateHierarchy"]]
# 
# # MST with K-medoids
# SO <- sc_clusterObj (SO, clust.method="k-medoids", k=15)
# SO<- sc_GraphBuilderObj(SO, graph.algorithm="MST",
# 	graph.using.cells.clustering=TRUE)
# cellstateHierarchy_MST_clustKmedoids<-SO[["cellstateHierarchy"]]
# 
# # Weights must be positive for Kamada-Kawai layout
# E(cellstateHierarchy_SST_clustKmedoids)$weight = E(cellstateHierarchy_SST_clustKmedoids)$weight + 0.000000001

## ----graph_assessment4, eval=TRUE---------------------------------------------
# SST with previous clustering of cells

# SST with K-Mutual Nearest Neighbours clustering
SO <- sc_clusterObj (SO, clust.method="knn", mutual=TRUE, k=5)
SO<- sc_GraphBuilderObj(SO, graph.algorithm="SST", 
	graph.using.cells.clustering=TRUE)
cellstateHierarchy_SST_clustKNN<-SO[["cellstateHierarchy"]]

# SST with K-medoids
SO <- sc_clusterObj (SO, clust.method="k-medoids", k=15)
SO<- sc_GraphBuilderObj(SO, graph.algorithm="SST", 
	graph.using.cells.clustering=TRUE)
cellstateHierarchy_SST_clustKmedoids<-SO[["cellstateHierarchy"]]

# Weights must be positive for Kamada-Kawai layout
E(cellstateHierarchy_SST_clustKmedoids)$weight = E(cellstateHierarchy_SST_clustKmedoids)$weight + 0.000000001

## ----plot_hierarchies_panel, echo=TRUE, fig.width=10, fig.height=10-----------

# Plotting parameters
vertex.size=5; 
edge.color="black"; 
edge.width=2; 
vertex.label.cex=0.2; 
vertex.label.dist=1
vertex.color=colorSCsByTime
vertex.label="";
layout.graph=layout.kamada.kawai;

par(bty="o",xaxs="i",yaxs="i",cex.axis=mycex-0.2,cex.main=mycex,cex.lab=mycex,
	las=1,mar=c(5.3,5.3,2.9,1.6),oma=c(1,1,2,10))
zones=matrix(c(1:4),ncol=2,byrow=FALSE)
graphics::layout(zones)

plot.igraph(cellstateHierarchy_MST ,main="MST",
	vertex.color=vertex.color,vertex.label=vertex.label,
	vertex.size=vertex.size,edge.color=edge.color,
	edge.width=edge.width,vertex.color=vertex.color,
	vertex.label.cex=vertex.label.cex,layout=layout.graph)

plot.igraph(cellstateHierarchy_SST_clustKNN ,main="SST - KNN cluster",
	vertex.color=vertex.color,vertex.label=vertex.label,
	vertex.size=vertex.size,edge.color=edge.color,
	edge.width=edge.width,vertex.color=vertex.color,
	vertex.label.cex=vertex.label.cex,layout=layout.graph)

plot.igraph(cellstateHierarchy_SST_clustKmedoids ,main="SST - K-medoids",
	vertex.color=vertex.color,vertex.label=vertex.label,
	vertex.size=vertex.size,edge.color=edge.color,
	edge.width=edge.width,vertex.color=vertex.color,
	vertex.label.cex=vertex.label.cex,layout=layout.graph)

plot.igraph(cellstateHierarchy_IMC ,main="IMC",
	vertex.color=vertex.color,vertex.label=vertex.label,
	vertex.size=vertex.size,edge.color=edge.color,
	edge.width=edge.width,vertex.color=vertex.color,
	vertex.label.cex=vertex.label.cex,layout=layout.graph)

## ----plot_parameters_1, eval=FALSE--------------------------------------------
# # To color by marker, set following parameter to:
#  vertex.color=colorSCsByMarker

## ----plot_parameters_2, eval=FALSE--------------------------------------------
# # To color by time point:
# vertex.color=colorSCsByTime

## ----plot_parameters_3, eval=FALSE--------------------------------------------
# vertex.label=colnames(SO[["expressionmatrix"]]);

## ----plot_parameters_4, eval=FALSE--------------------------------------------
# layout=t(cellsLowDimensionalSpace_ICA[1:2,])

## ----plot_parameters_5, eval=FALSE--------------------------------------------
# layout=layout.fruchterman.reingold
# layout=layout.reingold.tilford
# layout=layout.graphopt
# layout=layout.svd
# layout=layout.lgl

## ----Comparisson_graphs, eval=TRUE--------------------------------------------

sc_ComparissonOfGraphs(
  cellstateHierarchy_MST,
  cellstateHierarchy_SST_clustKNN,
  cellstateHierarchy_SST_clustKmedoids,
  # graph.names=c("MST","SST-KNNcluster","SST-K-medoids"),
  cellstateHierarchy_IMC,
  graph.names=c("MST","SST-KNNcluster","SST-K-medoids","IMC")
)

## ----graphs_separately, eval=TRUE---------------------------------------------
t0 <- grep("T0_", colnames(EMlog))
t24 <- grep("T24_", colnames(EMlog))
t48 <- grep("T48_", colnames(EMlog))
t72 <- grep("T72_", colnames(EMlog))

EMlog_t0<-EMlog[,t0]
EMlog_t24<-EMlog[,t24]
EMlog_t48<-EMlog[,t48]
EMlog_t72<-EMlog[,t72]

dim(EMlog_t0)
dim(EMlog_t24)
dim(EMlog_t48)
dim(EMlog_t72)

SO_t0 <- sc_InitializingSincellObject(EMlog_t0)
SO_t0 <- sc_DimensionalityReductionObj(SO_t0, method="ICA",dim=2)
SO_t0 <- sc_GraphBuilderObj(SO_t0, graph.algorithm="MST", 
	graph.using.cells.clustering=FALSE)

SO_t24 <- sc_InitializingSincellObject(EMlog_t24)
SO_t24 <- sc_DimensionalityReductionObj(SO_t24, method="ICA",dim=2)
SO_t24 <- sc_GraphBuilderObj(SO_t24, graph.algorithm="MST", 
	graph.using.cells.clustering=FALSE)

SO_t48 <- sc_InitializingSincellObject(EMlog_t48)
SO_t48 <- sc_DimensionalityReductionObj(SO_t48, method="ICA",dim=2)
SO_t48 <- sc_GraphBuilderObj(SO_t48, graph.algorithm="MST", 
	graph.using.cells.clustering=FALSE)

SO_t72 <- sc_InitializingSincellObject(EMlog_t72)
SO_t72 <- sc_DimensionalityReductionObj(SO_t72, method="ICA",dim=2)
SO_t72 <- sc_GraphBuilderObj(SO_t72, graph.algorithm="MST", 
	graph.using.cells.clustering=FALSE)

## ----plot_hierarchies_timepoints_panel, echo=TRUE, fig.width=10, fig.height=10----

# Plotting parameters
vertex.size=5; 
edge.color="black"; 
edge.width=2; 
vertex.label.cex=0.2; 
vertex.label.dist=1
vertex.color=colorSCsByTime
vertex.label="";
layout.graph=layout.kamada.kawai;

par(bty="o",xaxs="i",yaxs="i",cex.axis=mycex-0.2,cex.main=mycex,cex.lab=mycex,
	las=1,mar=c(5.3,5.3,2.9,1.6),oma=c(1,1,2,10))
zones=matrix(c(1:4),ncol=2,byrow=FALSE)
graphics::layout(zones)

plot.igraph(SO_t0[["cellstateHierarchy"]],main="0 hours",
	vertex.color=ColorT0,vertex.label=vertex.label,
	vertex.size=vertex.size,edge.color=edge.color,
	edge.width=edge.width,vertex.color=vertex.color,
	vertex.label.cex=vertex.label.cex,layout=layout.graph)

plot.igraph(SO_t24[["cellstateHierarchy"]],main="24 hours",
	vertex.color=ColorT24,vertex.label=vertex.label,
	vertex.size=vertex.size,edge.color=edge.color,
	edge.width=edge.width,vertex.color=vertex.color,
	vertex.label.cex=vertex.label.cex,layout=layout.graph)

plot.igraph(SO_t48[["cellstateHierarchy"]],main="48 hours",
	vertex.color=ColorT48,vertex.label=vertex.label,
	vertex.size=vertex.size,edge.color=edge.color,
	edge.width=edge.width,vertex.color=vertex.color,
	vertex.label.cex=vertex.label.cex,layout=layout.graph)

plot.igraph(SO_t72[["cellstateHierarchy"]],main="72 hours",
	vertex.color=ColorT72,vertex.label=vertex.label,
	vertex.size=vertex.size,edge.color=edge.color,
	edge.width=edge.width,vertex.color=vertex.color,
	vertex.label.cex=vertex.label.cex,layout=layout.graph)

## ----gene_resampling, eval=TRUE-----------------------------------------------
# For the sake of time we set here num_it=100. 
# For a higher significance, we recommend setting  num_it=1000
SO_t0<-sc_StatisticalSupportByGeneSubsampling(SO_t0, num_it=100)
SO_t24<-sc_StatisticalSupportByGeneSubsampling(SO_t24, num_it=100)
SO_t48<-sc_StatisticalSupportByGeneSubsampling(SO_t48, num_it=100)
SO_t72<-sc_StatisticalSupportByGeneSubsampling(SO_t72, num_it=100)

## ----plot_gene_resampling, echo=TRUE, fig.width=5.75, fig.height=4.75---------
mycex<-1
par(bty="o",xaxs="i",yaxs="i",cex.axis=mycex-0.2,cex.main=mycex,cex.lab=mycex,
	las=1,mar=c(5.3,5.3,2.9,1.6),oma=c(1,1,2,6))

plot(density(SO_t0[["StatisticalSupportbyGeneSubsampling"]]),col=ColorT0,lwd=4,
	main="Similarities of hierarchies \nupon gene subsamping",xlim=c(0.5,1),
	ylim=c(0,20),ylab="Density",xlab="Spearman rank correlation")
lines(density(SO_t24[["StatisticalSupportbyGeneSubsampling"]]),col=ColorT24,lwd=4)
lines(density(SO_t48[["StatisticalSupportbyGeneSubsampling"]]),col=ColorT48,lwd=4)
lines(density(SO_t72[["StatisticalSupportbyGeneSubsampling"]]),col=ColorT72,lwd=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), 
	new = TRUE, xpd = TRUE) 
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n") 
legend("right",title="Time\npoint", c("0h","24h","48h","72h"), 
	fill= c(ColorT0,ColorT24,ColorT48,ColorT72), 
	inset=c(0.03,0),  bty="n")

## ----gene_resampling2, eval=TRUE----------------------------------------------
summary(SO_t0[["StatisticalSupportbyGeneSubsampling"]])
summary(SO_t24[["StatisticalSupportbyGeneSubsampling"]])
summary(SO_t48[["StatisticalSupportbyGeneSubsampling"]])
summary(SO_t72[["StatisticalSupportbyGeneSubsampling"]])

var(SO_t0[["StatisticalSupportbyGeneSubsampling"]])
var(SO_t24[["StatisticalSupportbyGeneSubsampling"]])
var(SO_t48[["StatisticalSupportbyGeneSubsampling"]])
var(SO_t72[["StatisticalSupportbyGeneSubsampling"]])

## ----insilico_replicates, eval=TRUE-------------------------------------------
# For the sake of time we set here multiplier=100. 
# For a higher significance, we recommend setting multiplier=1000
SO_t0 <- sc_InSilicoCellsReplicatesObj(SO_t0, 
	method="variance.deciles", multiplier=100)
SO_t24 <- sc_InSilicoCellsReplicatesObj(SO_t24, 
	method="variance.deciles", multiplier=100)
SO_t48 <- sc_InSilicoCellsReplicatesObj(SO_t48, 
	method="variance.deciles", multiplier=100)
SO_t72 <- sc_InSilicoCellsReplicatesObj(SO_t72, 
	method="variance.deciles", multiplier=100)

## ----replacement_replicates, eval=TRUE----------------------------------------
SO_t0<-sc_StatisticalSupportByReplacementWithInSilicoCellsReplicates(SO_t0,
	num_it=100,fraction.cells.to.replace=1)
SO_t24<-sc_StatisticalSupportByReplacementWithInSilicoCellsReplicates(SO_t24,
	num_it=100,fraction.cells.to.replace=1)
SO_t48<-sc_StatisticalSupportByReplacementWithInSilicoCellsReplicates(SO_t48,
	num_it=100,fraction.cells.to.replace=1)
SO_t72<-sc_StatisticalSupportByReplacementWithInSilicoCellsReplicates(SO_t72,
	num_it=100,fraction.cells.to.replace=1)

## ----plot_insilico_replicates, echo=TRUE, fig.width=5.75, fig.height=4.75-----
mycex<-1
par(bty="o",xaxs="i",yaxs="i",cex.axis=mycex-0.2,cex.main=mycex,cex.lab=mycex,
	las=1,mar=c(5.3,5.3,2.9,1.6),oma=c(1,1,2,6))

plot(density(SO_t0[["StatisticalSupportByReplacementWithInSilicoCellReplicates"]]),
	col=ColorT0,lwd=4,
	main="Similarities of hierarchies upon substitution\nwith in silico cell replicates",
	xlim=c(0.5,1),ylim=c(0,20),ylab="Density",xlab="Spearman rank correlation")
lines(density(SO_t24[["StatisticalSupportByReplacementWithInSilicoCellReplicates"]]),
	col=ColorT24,lwd=4)
lines(density(SO_t48[["StatisticalSupportByReplacementWithInSilicoCellReplicates"]]),
	col=ColorT48,lwd=4)
lines(density(SO_t72[["StatisticalSupportByReplacementWithInSilicoCellReplicates"]]),
	col=ColorT72,lwd=4)

par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), 
	new = TRUE, xpd = TRUE) 
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n") 
legend("right",title="Time\npoint", c("0h","24h","48h","72h"), 
	fill= c(ColorT0,ColorT24,ColorT48,ColorT72), 
	inset=c(0.03,0),  bty="n")

## ----replacement_replicates2, eval=TRUE---------------------------------------
summary(SO_t0[["StatisticalSupportByReplacementWithInSilicoCellReplicates"]])
summary(SO_t24[["StatisticalSupportByReplacementWithInSilicoCellReplicates"]])
summary(SO_t48[["StatisticalSupportByReplacementWithInSilicoCellReplicates"]])
summary(SO_t72[["StatisticalSupportByReplacementWithInSilicoCellReplicates"]])

var(SO_t0[["StatisticalSupportByReplacementWithInSilicoCellReplicates"]])
var(SO_t24[["StatisticalSupportByReplacementWithInSilicoCellReplicates"]])
var(SO_t48[["StatisticalSupportByReplacementWithInSilicoCellReplicates"]])
var(SO_t72[["StatisticalSupportByReplacementWithInSilicoCellReplicates"]])

## ----help_functional_association, eval=FALSE----------------------------------
# # help(sc_AssociationOfCellsHierarchyWithAGeneSet())

## ----functional_association, eval=TRUE----------------------------------------
# geneset.list <- lapply(strsplit(readLines("c2.cp.reactome.v4.0.symbols.gmt"),"\t"),
#	as.character)
# geneset.list  is provided here for illustrative purposes:
data(geneset.list)
head(geneset.list[[1]])

# We establish a minimum gene set size overlap with the genes in 
# the expression matrix
minimum.geneset.size=30
myAssociationOfCellsHierarchyWithAGeneSet<-list()
for (i in 1:length(geneset.list)){
  if(sum(rownames(SO_t72[["expressionmatrix"]]) 
  	%in% geneset.list[[i]])>=minimum.geneset.size){
	
    SO_t72<-sc_AssociationOfCellsHierarchyWithAGeneSet(SO_t72,geneset.list[[i]],
    	minimum.geneset.size=minimum.geneset.size,p.value.assessment=TRUE,
	spearman.rank.threshold=0.5,num_it=1000)
    myAssociationOfCellsHierarchyWithAGeneSet[[
    	as.character(i)]]<-list()
    myAssociationOfCellsHierarchyWithAGeneSet[[
    	as.character(i)]][["AssociationOfCellsHierarchyWithAGeneSet"]]<-
		SO[["AssociationOfCellsHierarchyWithAGeneSet"]]
    myAssociationOfCellsHierarchyWithAGeneSet[[
    	as.character(i)]][["AssociationOfCellsHierarchyWithAGeneSet.pvalue"]]<-
	SO[["AssociationOfCellsHierarchyWithAGeneSet.pvalue"]]
  }
}
length(names(myAssociationOfCellsHierarchyWithAGeneSet))

## ----session_info, eval=TRUE--------------------------------------------------
sessionInfo()

## ----renaming_figures, echo=FALSE, results="hide", eval=TRUE------------------
library(stringr)
figs <- list.files("./figure", full.names=TRUE)
figs.new <- str_replace(figs, "-1", "")
file.rename(figs, figs.new )


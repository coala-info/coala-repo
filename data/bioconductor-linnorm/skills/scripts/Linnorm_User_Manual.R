# Code example from 'Linnorm_User_Manual' vignette. See references/ for full tutorial.

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)

# Obtain data
data(Islam2011)

# Do not filter gene list:
Transformed <- Linnorm(Islam2011)

# Filter low count genes
result <- Linnorm(Islam2011, Filter=TRUE)
FTransformed <- result[["Linnorm"]]

## ----echo=TRUE----------------------------------------------------------------
# You can use this file with Excel.
# This file includes all genes.
write.table(Transformed, "Transformed.txt",
quote=FALSE, sep="\t", col.names=TRUE, row.names=TRUE)

# This file filtered low count genes.
write.table(FTransformed, "Transformed.txt",
quote=FALSE, sep="\t", col.names=TRUE, row.names=TRUE)

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)
Normalized <- Linnorm.Norm(Islam2011)
# Important: depending on downstream analysis, please
# set output to be "XPM" or "Raw".
# Set to "XPM" if downstream tools will convert the 
# dataset into CPM or TPM.
# Set to "Raw" if input is raw counts and downstream 
# tools will work with raw counts.

## ----echo=TRUE----------------------------------------------------------------
# You can use this file with Excel.
write.table(Normalized, "Normalized.txt",
quote=FALSE, sep="\t", col.names=TRUE, row.names=TRUE)

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)
data(LIHC)

## ----echo=TRUE----------------------------------------------------------------
# Now, we can calculate fold changes between
# sample set 1 and sample set 2.
# Index of sample set 1
set1 <- 1:5
# Index of sample set 2
set2 <- 6:10

# Normalization
LIHC2 <- Linnorm.Norm(LIHC,output="XPM")

# Optional: Only use genes with at least 50%
# of the values being non-zero
LIHC2 <- LIHC2[rowSums(LIHC2 != 0) >= ncol(LIHC2)/2,]

## ----echo=TRUE----------------------------------------------------------------
# Put resulting data into a matrix
FCMatrix <- matrix(0, ncol=1, nrow=nrow(LIHC2))
rownames(FCMatrix) <- rownames(LIHC2)
colnames(FCMatrix) <- c("Log 2 Fold Change")
FCMatrix[,1] <- log((rowMeans(LIHC2[,set1])+1)/(rowMeans(LIHC2[,set2])+1),2)
# Now FCMatrix contains fold change results.

# If the optional filtering step is not done,
# users might need to remove infinite and zero values:
# Remove Infinite values.
FCMatrix <- FCMatrix[!is.infinite(FCMatrix[,1]),,drop=FALSE]
# Remove Zero values
FCMatrix <- FCMatrix[FCMatrix[,1] != 0,,drop=FALSE]

# Now FCMatrix contains fold change results.

## ----echo=TRUE, fig.height=6, fig.width=6-------------------------------------
Density <- density(FCMatrix[,1])
plot(Density$x,Density$y,type="n",xlab="Log 2 Fold Change of TPM+1",
ylab="Probability Density",)
lines(Density$x,Density$y, lwd=1.5, col="blue")
title("Probability Density of Fold Change.\nTCGA Partial LIHC data
Paired Tumor vs Adjacent Normal")
legend("topright",legend=paste("mean = ", 
round(mean(FCMatrix[,1]),2),
"\nStdev = ", round(sd(FCMatrix[,1]),2)))

## ----echo=TRUE, fig.height=6, fig.width=6-------------------------------------
# Normalization with BE_strength set to 1.
# This increases normalization strength.
LIHC2 <- Linnorm.Norm(LIHC,output="XPM",BE_strength=1)

# Optional: Only use genes with at least 50%
# of the values being non-zero
LIHC2 <- LIHC2[rowSums(LIHC2 != 0) >= ncol(LIHC2)/2,]

FCMatrix <- matrix(0, ncol=1, nrow=nrow(LIHC2))
rownames(FCMatrix) <- rownames(LIHC2)
colnames(FCMatrix) <- c("Log 2 Fold Change")
FCMatrix[,1] <- log((rowMeans(LIHC2[,set1])+1)/(rowMeans(LIHC2[,set2])+1),2)
# Now FCMatrix contains fold change results.


Density <- density(FCMatrix[,1])
plot(Density$x,Density$y,type="n",xlab="Log 2 Fold Change of TPM+1",
ylab="Probability Density",)
lines(Density$x,Density$y, lwd=1.5, col="blue")
title("Probability Density of Fold Change.\nTCGA Partial LIHC data
Paired Tumor vs Adjacent Normal")
legend("topright",legend=paste("mean = ", 
round(mean(FCMatrix[,1]),2),
"\nStdev = ", round(sd(FCMatrix[,1]),2)))

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)
data(Islam2011)
# Obtain transformed data
Transformed <- Linnorm(Islam2011)

# Data Imputation
DataImputed <- Linnorm.DataImput(Transformed)

# Or, users can directly perform data imputation during transformation.
DataImputed <- Linnorm(Islam2011,DataImputation=TRUE)

## ----echo=TRUE----------------------------------------------------------------
# You can use this file with Excel.
write.table(DataImputed, "DataImputed.txt",
quote=FALSE, sep="\t", col.names=TRUE, row.names=TRUE)

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)
data(Islam2011)
# Obtain stable genes
StableGenes <- Linnorm.SGenes(Islam2011)

## ----echo=TRUE----------------------------------------------------------------
# You can use this file with Excel.
write.table(StableGenes, "StableGenes.txt",
quote=FALSE, sep="\t", col.names=TRUE, row.names=TRUE)

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)
data(LIHC)
datamatrix <- LIHC

## ----echo=TRUE----------------------------------------------------------------
# 5 samples for condition 1 and 5 samples for condition 2.
# You might need to edit this line
design <- c(rep(1,5),rep(2,5))
# These lines can be copied directly.
design <- model.matrix(~ 0+factor(design))
colnames(design) <- c("group1", "group2")
rownames(design) <- colnames(datamatrix)

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)
# The Linnorm-limma pipeline only consists of one line.
DEG_Results <- Linnorm.limma(datamatrix,design)
# The DEG_Results matrix contains your DEG analysis results.

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)
# Just add output="Both" into the argument list
BothResults <- Linnorm.limma(datamatrix,design,output="Both")

# To separate results into two matrices:
DEG_Results <- BothResults$DEResults
TransformedMatrix <- BothResults$Linnorm
# The DEG_Results matrix now contains DEG analysis results.
# The TransformedMatrix matrix now contains a Linnorm
# Transformed dataset.

## -----------------------------------------------------------------------------
write.table(DEG_Results, "DEG_Results.txt", quote=FALSE, sep="\t",
col.names=TRUE,row.names=TRUE)

## ----echo=TRUE----------------------------------------------------------------
Genes10 <- DEG_Results[order(DEG_Results[,"adj.P.Val"]),][1:10,]
# Users can print the gene list by the following command:
# print(Genes10)

# logFC: log 2 fold change of the gene.
# XPM: If input is raw count or CPM, XPM is CPM.
# 	If input is RPKM, FPKM or TPM, XPM is TPM.
# t: moderated t statistic.
# P.Value: p value.
# adj.P.Val: Adjusted p value. This is also called False Discovery Rate or q value.}
# B: log odds that the feature is differential.

# Note all columns are printed here

## ----kable1, echo=FALSE-------------------------------------------------------
library(knitr)
kable(Genes10[,c(1:5)], digits=4)

## ----echo=TRUE----------------------------------------------------------------
SignificantGenes <- DEG_Results[DEG_Results[,5] <= 0.05,1]

## ----echo=TRUE, fig.height=6, fig.width=6-------------------------------------
plot(x=DEG_Results[,1], y=DEG_Results[,5], col=ifelse(DEG_Results[,1] %in%
SignificantGenes, "red", "green"),log="y", ylim = 
rev(range(DEG_Results[,5])), main="Volcano Plot", 
xlab="log2 Fold Change", ylab="q values", cex = 0.5)

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)
data(Islam2011)
IslamData <- Islam2011[,1:92]

## ----echo=TRUE----------------------------------------------------------------
# 48 samples for condition 1 and 44 samples for condition 2.
# You might need to edit this line
design <- c(rep(1,48),rep(2,44))
# There lines can be copied directly.
design <- model.matrix(~ 0+factor(design))
colnames(design) <- c("group1", "group2")
rownames(design) <- colnames(IslamData)

## ----echo=TRUE----------------------------------------------------------------
# Example 1: Filter low count genes.
# and genes with high technical noise.
scRNAseqResults <- Linnorm.limma(IslamData,design,Filter=TRUE)


# Example 2: Do not filter gene list.
scRNAseqResults <- Linnorm.limma(IslamData,design)

## ----echo=TRUE----------------------------------------------------------------
data(Islam2011)

# Obtain embryonic stem cell data
datamatrix <- Islam2011[,1:48]

## ----echo=TRUE----------------------------------------------------------------
# Setting plotNetwork to TRUE will create a figure file in your current directory.
# Setting it to FALSE will stop it from creating a figure file, but users can plot it
# manually later using the igraph object in the output.
# For this vignette, we will plot it manually in step 4.
results <- Linnorm.Cor(datamatrix, plotNetwork=FALSE,
# Edge color when correlation is positive
plot.Pos.cor.col="red",
# Edge color when correlation is negative
plot.Neg.cor.col="green")

## ----echo=TRUE----------------------------------------------------------------
Genes10 <- results$Results[order(results$Results[,5]),][1:10,]
# Users can print the gene list by the following command:
# print(Genes10)

## ----kable2, echo=FALSE-------------------------------------------------------
library(knitr)
kable(Genes10, digits=4, row.names=FALSE)

## ----echo=TRUE, fig.height=6, fig.width=6-------------------------------------
library(igraph)
Thislayout <- layout_with_kk(results$igraph)
plot(results$igraph,
# Vertex size
vertex.size=2,
# Vertex color, based on clustering results
vertex.color=results$Cluster$Cluster,
# Vertex frame color
vertex.frame.color="transparent",
# Vertex label color (the gene names)
vertex.label.color="black",
# Vertex label size
vertex.label.cex=0.05,
# This is how much the edges should be curved.
edge.curved=0.1,
# Edge width
edge.width=0.05,
# Use the layout created previously
layout=Thislayout
)

## ----echo=TRUE----------------------------------------------------------------
TheCluster <- which(results$Cluster[,1] == "Mmp2")

## ----echo=TRUE----------------------------------------------------------------
# Index of the genes
ListOfGenes <- which(results$Cluster[,2] == TheCluster)

# Names of the genes
GeneNames <- results$Cluster[ListOfGenes,1]

# Users can write these genes into a file for further analysis.

## ----echo=TRUE----------------------------------------------------------------
top100 <- results$Results[order(results$Results[,4],decreasing=FALSE)[1:100],1]

## ----echo=TRUE----------------------------------------------------------------
Top100.Cor.Matrix <- results$Cor.Matrix[top100,top100]

## ----echo=TRUE, fig.height=6, fig.width=6-------------------------------------
library(RColorBrewer)
library(gplots)
heatmap.2(as.matrix(Top100.Cor.Matrix),
# Hierarchical clustering on both row and column
Rowv=TRUE, Colv=TRUE,
# Center white color at correlation 0
symbreaks=TRUE,
# Turn off level trace
trace="none",
# x and y axis labels
xlab = 'Genes', ylab = "Genes",
# Turn off density info
density.info='none',
# Control color
key.ylab=NA,
col=colorRampPalette(c("blue", "white", "yellow"))(n = 1000),
lmat=rbind(c(4, 3), c(2, 1)),
# Gene name font size
cexRow=0.3,
cexCol=0.3,
# Margins
margins = c(8, 8)
)

## ----echo=TRUE----------------------------------------------------------------
data(Islam2011)


## ----echo=TRUE----------------------------------------------------------------
# The first 48 columns are the embryonic stem cells.
results <- Linnorm.HVar(Islam2011[,1:48])

## ----echo=TRUE----------------------------------------------------------------
resultsdata <- results$Results
Genes10 <- resultsdata[order(resultsdata[,"q.value"]),][1:10,3:5]
# Users can print the gene list by the following command:
# print(Genes10)

## ----kable3, echo=FALSE-------------------------------------------------------
library(knitr)
kable(Genes10, digits=4)

## ----echo=TRUE, fig.height=6, fig.width=6-------------------------------------
print(results$plot$plot)
# By default, this plot highlights genes/features with p value less than 0.05.

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)
data(Islam2011)

## ----echo=TRUE----------------------------------------------------------------
tSNE.results <- Linnorm.tSNE(Islam2011[,1:92])

## ----echo=TRUE, fig.height=6, fig.width=6-------------------------------------
# Here, we can see two clusters.
print(tSNE.results$plot$plot)

## ----echo=TRUE----------------------------------------------------------------
# The first 48 samples belong to mouse embryonic stem cells.
Groups <- rep("ES_Cells",48)
# The next 44 samples are mouse embryonic fibroblasts.
Groups <- c(Groups, rep("EF_Cells",44))

## ----echo=TRUE----------------------------------------------------------------
# Useful arguments:
# Group:
# allows user to provide each sample's information.
# num_center:
# how many clusters are supposed to be there.
# num_PC:
# how many principal components should be used in k-means
# clustering.

tSNE.results <- Linnorm.tSNE(Islam2011[,1:92],
 Group=Groups, num_center=2)

## ----echo=TRUE, fig.height=6, fig.width=6-------------------------------------
# Here, we can see two clusters.
print(tSNE.results$plot$plot)

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)
data(Islam2011)

## ----echo=TRUE----------------------------------------------------------------
PCA.results <- Linnorm.PCA(Islam2011[,1:92])

## ----echo=TRUE, fig.height=6, fig.width=6-------------------------------------
# Here, we can see multiple clusters.
print(PCA.results$plot$plot)

## ----echo=TRUE----------------------------------------------------------------
# The first 48 samples belong to mouse embryonic stem cells.
Groups <- rep("ES_Cells",48)
# The next 44 samples are mouse embryonic fibroblasts.
Groups <- c(Groups, rep("EF_Cells",44))

## ----echo=TRUE----------------------------------------------------------------
# Useful arguments:
# Group:
# allows user to provide each sample's information.
# num_center:
# how many clusters are supposed to be there.
# num_PC
# how many principal components should be used in k-means
# clustering.

PCA.results <- Linnorm.PCA(Islam2011[,1:92],
Group=Groups, num_center=2, num_PC=3)

## ----echo=TRUE, fig.height=6, fig.width=6-------------------------------------
# Here, we can see two clusters.
print(PCA.results$plot$plot)

## ----echo=TRUE----------------------------------------------------------------
data(Islam2011)
Islam <- Islam2011[,1:92]

## ----echo=TRUE----------------------------------------------------------------
# 48 ESC, 44 EF, and 4 NegCtrl
Group <- c(rep("ESC",48),rep("EF",44))
colnames(Islam) <- paste(colnames(Islam),Group,sep="_")

## ----echo=TRUE----------------------------------------------------------------
# Note that there are 3 known clusters.
HClust.Results <- Linnorm.HClust(Islam,Group=Group,
num_Clust=2, fontsize=1.5, Color = c("Red","Blue"), RectColor="Green")

## ----echo=TRUE, fig.height=6, fig.width=6-------------------------------------
print(HClust.Results$plot$plot)

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)
data(SEQC)
SampleA <- SEQC

## ----echo=TRUE----------------------------------------------------------------
# This will generate two sets of RNA-seq data with 5 replicates each. 
# It will have 20000 genes totally with 2000 genes being differentially 
# expressed. It has the Negative Binomial distribution.
SimulatedData <- RnaXSim(SampleA)

## ----echo=TRUE----------------------------------------------------------------
# Index of differentially expressed genes.
DE_Index <- SimulatedData[[2]]

# Expression Matrix
ExpMatrix <- SimulatedData[[1]]

# Sample Set 1
Sample1 <- ExpMatrix[,1:3]

# Sample Set 2
Sample2 <- ExpMatrix[,4:6]

## ----echo=TRUE----------------------------------------------------------------
data(SEQC)
SampleA <- SEQC

## ----echo=TRUE----------------------------------------------------------------
library(Linnorm)
SimulatedData <- RnaXSim(SampleA,
distribution="Gamma", # Distribution in the simulated dataset.
# Put "NB" for Negative Binomial, "Gamma" for Gamma,
# "Poisson" for Poisson and "LogNorm" for Log Normal distribution.
NumRep=5, # Number of replicates in each sample set. 
# 5 will generate 10 samples in total.
NumDiff = 1000, # Number of differentially expressed genes.
NumFea = 5000 # Total number of genes in the dataset
)

## ----echo=TRUE----------------------------------------------------------------
# Index of differentially expressed genes.
DE_Index <- SimulatedData[[2]]

# Expression Matrix
ExpMatrix <- SimulatedData[[1]]

# Simulated Sample Set 1
Sample1 <- ExpMatrix[,1:3]

# Simulated Sample Set 2
Sample2 <- ExpMatrix[,4:6]


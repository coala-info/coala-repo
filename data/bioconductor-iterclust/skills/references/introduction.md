Introduction to Iterative Clustering Analysis Using
iterClust

Hongxu Ding and Andrea Califano
Department of Systems Biology, Columbia University, New York, USA

October 30, 2018

Contents

1 Introduction

1.1 General Work Flow . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
Internal Variables (IV) . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.2
Installation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.3
1.4 Citing . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Data Preparation

3 Deﬁne functions

4 Run iterClust

5 Compare iterClust, PAM and Consensus Clustering

1

Introduction

1
2
2
2
2

2

3

4

5

In a scenario where populations A, B1, B2 exist, pronounce diﬀerences between A and
B may mask subtle diﬀerences between B1 and B2. To solve this problem, so that het-
erogeneity can be better detected, clustering analysis needs to be performed iteratively,
so that, for example, in iteration 1, A and B are separated and in iteration 2, B1 and
B2 are separated . The iterClust() function in iterClust package provides an sta-
tistical framework for performing such iterative clustering analysis, which can be used
to, for instance discover cell populations using single cells RNA-Seq proﬁles, clustering
clinically-related patient gene expression proﬁles and solve general clustering problems.

1

1.1 General Work Flow

iterClust() organizes user-deﬁned functions and parameters as follows:

ith Iteration Start =>
featureSelect (feature selection) =>
minFeatureSize (conﬁrm enough features are selected) =>
clustHetero (conﬁrm heterogeneity) =>
coreClust (generate several clustering schemes, only for heterogenous clusters) =>
clustEval (pick the optimal clustering scheme) =>
minClustSize (remove clusters with few observations) =>
obsEval (evaluate how each observations are clustered) =>
obsOutlier (remove poorly clustered observations) =>
results in Internal Variables (IV) =>
ith Iteration End

1.2 Internal Variables (IV)

iterClust() has the following IVs which can be used in user-deﬁned functions:

cluster, a list with two elements, named cluster and feature, which are also list ob-
ject, organized by round of iterations, containing names of observations for each clusters
in this speciﬁc iteration, and features used to split clusters in previous iterations thereby
produce the current clusters organized as lists, respectively.
depth, an integer specifying current round of iteration.

1.3 Installation

iterClust depends on SummarizedExperiment and Biobase. Running examples in iter-
Clust requires tsne, cluster, ConsensusClusterPlus and bcellViper. To install iterClust,
from bioconductor

if (!requireNamespace("BiocManager", quietly=TRUE))

install.packages("BiocManager")

BiocManager::install("iterClust")

1.4 Citing

2 Data Preparation

We applied iterClust() to a B-cell expression dataset included in bcellViper. We load
the two librarues ﬁrst, followed by load and ﬁlter expression matrix and phenotype
annotation.

2

> library(iterClust)
> library(bcellViper)
> data(bcellViper)
> exp <- exprs(dset)
> pheno <- as.character(dset@phenoData@data$description)
> exp <- exp[, pheno %in% names(table(pheno))[table(pheno) > 5]]
> pheno <- pheno[pheno %in% names(table(pheno))[table(pheno) > 5]]
> dim(exp)

[1] 6249 161

> table(pheno)

pheno

B-CLL
16

BL
23

DLCL
53

HCL
13

PEL pB-CLL pDLCL
15
18

9

pFL
6

pMCL
8

3 Deﬁne functions

We deﬁne functions needed for iterClust(), as well as load package cluster that these
functions needed.

> library(cluster)

In every iterations, all genes in the dataset were used for clustering analysis.

> featureSelect <- function(dset, iteration, feature) return(rownames(dset))

In every iterations, the core function for clustering is pam() in package cluster. We

searched through 2 to 5 clusters to ﬁnd the optimal result.

> coreClust <- function(dset, iteration){
+
+
+
+
+

dist <- as.dist(1 - cor(dset))
range=seq(2, (ncol(dset)-1), by = 1)
clust <- vector("list", length(range))
for (i in 1:length(range)) clust[[i]] <- pam(dist, range[i])$clustering
return(clust)}

In every iterations, the core function for evaluating diﬀerent clustering schemes is
silhouette() in package cluster. We considered clustering schemes with the high-
est average silhouette score as the optimal scheme. clust is the output for function
clustfun().

3

dist <- as.dist(1 - cor(dset))
clustEval <- vector("numeric", length(clust))
for (i in 1:length(clust)){

> clustEval <- function(dset, iteration, clust){
+
+
+
+
+

return(clustEval)}

clustEval[i] <- mean(silhouette(clust[[i]], dist)[, "sil_width"])}

In every iterations, clusters with average silhouette score greater than 0.15 were

considered as heterogenous and further splitted.

> clustHetero <- function(clustEval, iteration){
return(clustEval > 0*iteration+0.15)}
+

In every iterations, the core function for evaluating each observation is silhouette()

in package cluster. clust is the output for function clustfun().

> obsEval <- function(dset, clust, iteration){
+
+
+

dist <- as.dist(1 - cor(dset))
obsEval <- vector("numeric", length(clust))
return(silhouette(clust, dist)[, "sil_width"])}

In every iterations, observations with silhouette score smaller than -1 were considered

as outlier observations.

> obsOutlier <- function(obsEval, iteration) return(obsEval < 0*iteration-1)

4 Run iterClust

iterClust() was run with the above deﬁned functions. Then we showed how the results
of iterClust() are organized.

> c <- iterClust(exp, maxIter=3, minFeatureSize=100, minClustSize=5)
> names(c)

[1] "cluster"

"feature"

"clustEval" "obsEval"

> names(c$cluster)

[1] "Iter1" "Iter2"

> names(c$cluster$Iter1)

[1] "Cluster1" "Cluster2" "Cluster3" "Cluster4" "Cluster5"

4

> c$cluster$Iter1$Cluster1

[1] "GSM44075" "GSM44078" "GSM44080" "GSM44081" "GSM44082" "GSM44083"
[7] "GSM44084" "GSM44088" "GSM44089" "GSM44091" "GSM44092" "GSM44094"
[13] "GSM44095" "GSM44246" "GSM44247" "GSM44248" "GSM44249" "GSM44250"
[19] "GSM44251" "GSM44252" "GSM44261" "GSM44264" "GSM44265" "GSM44266"
[25] "GSM44267" "GSM44268" "GSM44269" "GSM44076" "GSM44077" "GSM44079"
[31] "GSM44090" "GSM44093" "GSM44192" "GSM44244" "GSM44245" "GSM44253"
[37] "GSM44254" "GSM44255" "GSM44256" "GSM44257" "GSM44258" "GSM44259"
[43] "GSM44291" "GSM44292"

> names(c$feature)

[1] "Iter1" "Iter2"

> names(c$feature$Iter1)

[1] "OriginalDataset"

> names(c$feature$Iter2)

[1] "Cluster1inIter1" "Cluster2inIter1" "Cluster3inIter1" "Cluster4inIter1"
[5] "Cluster5inIter1"

> c$feature$Iter2$Cluster1inIter1[1:10]

[1] "ADA"
[8] "TANK"

"CDH2"
"HGC6.3" "C1orf68"

"MED6"

"NR2E3"

"ACOT8"

"ABI1"

"GNPDA1"

5 Compare iterClust, PAM and Consensus Cluster-

ing

In this section, we compared the performance of iterClust() with another clustering
framework ConsensusClusterPlus() as well as their underlying clustering algorithm
pam().

> library(ConsensusClusterPlus)
> set.seed(1)
> consensusClust = ConsensusClusterPlus(exp, maxK = 10,
+
+
> ICL <- calcICL(consensusClust, plot = FALSE)
> ICL <- sapply(2:10, function(k, ICL){
+
+
+

mean(s[is.finite(s)])}, ICL=ICL)

"clusterConsensus"]

s <- ICL$clusterConsensus[grep(k, ICL$clusterConsensus[, "k"]),

reps = 100, clusterAlg = "pam",
distance = "pearson", plot = FALSE)

5

We ﬁrst projected the data on 2D-tSNE space for later visualization purpose.

> library(tsne)
> dist <- as.dist(1 - cor(exp))
> set.seed(1)
> tsne <- tsne(dist, perplexity = 20, max_iter = 500)

Then we compared iterClust(), pam() and ConsensusClusterPlus().

6

> par(mfrow = c(1, 2))
> for (j in 1:length(c$cluster)){
+
+
+
+
+
+
+

COL <- structure(rep(1, ncol(exp)), names = colnames(exp))
for (i in 1:length(c$cluster[[j]])) COL[c$cluster[[j]][[i]]] <- i+1
plot(tsne[, 1], tsne[, 2], cex = 0, cex.lab = 1.5,

xlab = "Dim1", ylab = "Dim2",
main = paste("iterClust, iter=", j, sep = ""))

text(tsne[, 1], tsne[, 2], labels = pheno, cex = 0.5, col = COL)
legend("topleft", legend = "Outliers", fill = 1, bty = "n")}

Figure 1: Result of iterClust()

7

−20−1001020−50510iterClust, iter=1Dim1Dim2BLBLBLBLBLBLBLDLCLDLCLDLCLDLCLDLCLDLCLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLDLCLDLCLDLCLDLCLpFLpFLpFLpFLpFLpFLBLBLBLDLCLDLCLBLBLBLBLBLBLBLBLBLBLBLBLBLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLpMCLpMCLpMCLpMCLpMCLpMCLpMCLpMCLPELPELPELPELPELPELPELPELPELOutliers−20−1001020−50510iterClust, iter=2Dim1Dim2BLBLBLBLBLBLBLDLCLDLCLDLCLDLCLDLCLDLCLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLDLCLDLCLDLCLDLCLpFLpFLpFLpFLpFLpFLBLBLBLDLCLDLCLBLBLBLBLBLBLBLBLBLBLBLBLBLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLpMCLpMCLpMCLpMCLpMCLpMCLpMCLpMCLPELPELPELPELPELPELPELPELPELOutliersplot(tsne[, 1], tsne[, 2], cex = 0, cex.lab = 1.5,

> par(mfrow = c(1, 2))
> for (j in 1:length(c$cluster)){
+
+
+
+
+

xlab = "Dim1", ylab = "Dim2",
main = paste("PAM, k=", length(c$cluster[[j]]), sep = ""))

text(tsne[, 1], tsne[, 2], labels = pheno, cex = 0.5,

col = pam(dist, k = length(c$cluster[[j]]))$clustering)}

Figure 2: Result of PAM() with same number of clusters given by iterClust()

8

−20−1001020−50510PAM, k=5Dim1Dim2BLBLBLBLBLBLBLDLCLDLCLDLCLDLCLDLCLDLCLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLDLCLDLCLDLCLDLCLpFLpFLpFLpFLpFLpFLBLBLBLDLCLDLCLBLBLBLBLBLBLBLBLBLBLBLBLBLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLpMCLpMCLpMCLpMCLpMCLpMCLpMCLpMCLPELPELPELPELPELPELPELPELPEL−20−1001020−50510PAM, k=7Dim1Dim2BLBLBLBLBLBLBLDLCLDLCLDLCLDLCLDLCLDLCLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLDLCLDLCLDLCLDLCLpFLpFLpFLpFLpFLpFLBLBLBLDLCLDLCLBLBLBLBLBLBLBLBLBLBLBLBLBLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLpMCLpMCLpMCLpMCLpMCLpMCLpMCLpMCLPELPELPELPELPELPELPELPELPELxlab = "Dim1", ylab = "Dim2",main = "Consensus Clustering+PAM, k=2")

col = c(2, rep(1, 8)), ylim = c(0.8, 1),
cex.lab = 1.5, pch = 16, main = "")

> par(mfrow = c(2, 2))
> plot(c(2:10), ICL, xlab = "#Clusters", ylab = "Cluster Consensus Score",
+
+
> plot(tsne[, 1], tsne[, 2], cex = 0, cex.lab = 1.5,
+
> text(tsne[, 1], tsne[, 2], labels = pheno,
+
> plot(c(2:10), ICL, xlab = "#Clusters", ylab = "Cluster Consensus Score",
+
+
> plot(tsne[, 1], tsne[, 2], cex = 0, cex.lab = 1.5,
+
> text(tsne[, 1], tsne[, 2], labels = pheno, cex = 0.5,
col = consensusClust[[7]]$consensusClass)
+

col = c(rep(1, 5), 2, 1, 1), ylim = c(0.8, 1),
cex.lab = 1.5, pch = 16, main = "")

cex = 0.5, col = consensusClust[[2]]$consensusClass)

xlab = "Dim1", ylab = "Dim2",main = "Consensus Clustering+PAM, k=7")

Figure 3: Result of ConsensusClusterPlus()

9

lllllllll2468100.800.850.900.951.00#ClustersCluster Consensus Score−20−1001020−50510Consensus Clustering+PAM, k=2Dim1Dim2BLBLBLBLBLBLBLDLCLDLCLDLCLDLCLDLCLDLCLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLDLCLDLCLDLCLDLCLpFLpFLpFLpFLpFLpFLBLBLBLDLCLDLCLBLBLBLBLBLBLBLBLBLBLBLBLBLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLpMCLpMCLpMCLpMCLpMCLpMCLpMCLpMCLPELPELPELPELPELPELPELPELPELlllllllll2468100.800.850.900.951.00#ClustersCluster Consensus Score−20−1001020−50510Consensus Clustering+PAM, k=7Dim1Dim2BLBLBLBLBLBLBLDLCLDLCLDLCLDLCLDLCLDLCLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpB−CLLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLDLCLDLCLDLCLDLCLpFLpFLpFLpFLpFLpFLBLBLBLDLCLDLCLBLBLBLBLBLBLBLBLBLBLBLBLBLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLpDLCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLHCLpMCLpMCLpMCLpMCLpMCLpMCLpMCLpMCLPELPELPELPELPELPELPELPELPELThe results showed that iterClust() can distinguish subtle diﬀerences between puri-
ﬁed and unpuriﬁed B-cells (pDLCL VS DLCL, B-CLL VS pB-CLL), which cannot be dis-
tinguished by pam() and ConsensusClusterPlus(). Also, pam() and ConsensusClusterPlus()
falsely separated a homogenous cluster containing DLCL samples (DLCL samples are
known to have subpopulations and this is one subpopulation).

10


Linnorm User Manual

Shun H. Yip1,2,3, Panwen Wang3, Jean-Pierre Kocher3, Pak
Chung Sham1,4,5, Junwen Wang3,6

30 October 2025

1 Centre for Genomic Sciences, LKS Faculty of Medicine, The
University of Hong Kong, Hong Kong SAR, China;
2 School of Biomedical Sciences, LKS Faculty of Medicine, The
University of Hong Kong, Hong Kong SAR, China;
3 Department of Health Sciences Research and Center for Individualized
Medicine, Mayo Clinic, Scottsdale, AZ, 85259, USA;
4 Department of Psychiatry, LKS Faculty of Medicine, The
University of Hong Kong, Hong Kong SAR, China;
5 State Key Laboratory in Cognitive and Brain Sciences, The
University of Hong Kong, Hong Kong SAR, China;
6 Department of Biomedical Informatics, Arizona State University,
Scottsdale, AZ, 85259, USA.

Abstract

Linnorm is an R package for the analysis of single cell RNA-seq (scRNA-seq), RNA-seq,
ChIP-seq count data or any large scale count data. Its main function is to normalize and
transform such datasets for parametric tests1. Various functions and analysis pipelines are
also implemented for users’ convenience, including data imputation2, stable gene selection for
scRNA-seq3, using limma for differential expression analysis or differential peak detection4,
co-expression network analysis5, highly variable gene discovery6 and cell subpopulation analysis
with t-SNE K-means clustering7, PCA K-means clustering8 and hierarchical clustering analysis9.
Linnorm can work with raw count, CPM, RPKM, FPKM and TPM and is compatible with data
generated from simple count algorithms10 and supervised learning algorithms11. Additionally,
the RnaXSim function is included for simulating RNA-seq data for the evaluation of DEG
analysis methods.

1Implemented as Linnorm and Linnorm.Norm
2Implemented as the Linnorm.DataImput function.
3for scRNA-seq data without spike-in genes or users who do not want to rely on spike-in genes. Imple-
mented as the Linnorm.SGenes function.
4The Linnorm-limma pipeline is implemented as the "Linnorm.limma" function. Please cite both Linnorm
and limma if you use this function for publication.
5Implemented as the Linnorm.Cor function.
6Implemented as the Linnorm.HVar function.
7Implemented as the Linnorm.tSNE function.
8Implemented as the Linnorm.PCA function.
9Implemented as the Linnorm.HClust function.
10Such as HTSeq, Rsubread and etc
11Such as Cufflinks, eXpress, Kallisto, RSEM, Sailfish, and etc

Linnorm User Manual

Contents

1

Introduction .

.

.

.

.

.

.

.

.

.

.

1.1

1.2

Datatypes and Input Format.

Installation .

.

.

.

.

.

.

.

.

2

Examples with Source Codes .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2.1

2.2

2.3

2.4

2.5

2.6

2.7

Data Normalization/Transformation/Imputation .
.
2.1.1
.
2.1.2

.
.
Normalizing Transformation .
.
.
Normalization .
2.1.2.1 Procedure . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.1.2.2 Calculating Fold Change and the effects of normalization
strength . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.

Data Imputation .

2.1.3

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.

.
.

.
.

.
.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Stable Gene Selection .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

RNA-seq data .

Differential Expression Analysis using Linnorm-limma pipeline .
.
.
2.3.1

.
.
.
2.3.1.1 Analysis procedure . . . . . . . . . . . . . . . . . . . . . .
2.3.1.2 Print out the most significant genes . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . .
2.3.1.3 Volcano Plot
.
.

Single cell RNA-seq DEG Analysis .

2.3.2

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Gene Co-expression Network Analysis .
.
.
.
.
2.4.1
.
.
.
2.4.2
Identify genes that belong to a cluster . . . . . . . . . . . .
2.4.2.1
2.4.2.2 Draw a correlation heatmap . . . . . . . . . . . . . . . . .

Analysis Procedure.
.
Plot a co-expression network .

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.

.

.

.

Highly variable gene analysis .
.
Analysis Procedure.
2.5.1
.
.
Mean vs SD plot highlighting significant genes .
2.5.2

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.

.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

2.6.2

Cell subpopulation analysis .
2.6.1

.
t-SNE K-means Clustering .

.
.
Simple subpopulation analysis

.
.
.
.
2.6.1.1
. . . . . . . . . . . . . . . .
2.6.1.2 Analysis with known subpopulations . . . . . . . . . . . . .
.
.
.
2.6.2.1
. . . . . . . . . . . . . . . .
2.6.2.2 Analysis with known subpopulations . . . . . . . . . . . . .
.
.
2.6.3.1 Analysis Procedure . . . . . . . . . . . . . . . . . . . . . .
2.6.3.2 Hierarchical Clustering plot . . . . . . . . . . . . . . . . . .

.
Simple subpopulation analysis

PCA K-means Clustering. .

Hierarchical Clustering .

2.6.3

.
.

.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

RnaXSim.
2.7.1

.
.
RNA-seq Expression Data Simulation.

.
.
.
.
2.7.1.1 Default
. . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.7.1.2 Advanced . . . . . . . . . . . . . . . . . . . . . . . . . . .

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.

.

.

.

.

.

.

.

3

4

Frequently Asked Questions .

.

.

.

.

.

.

.

Bug Reports, Questions and Suggestions.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

3

3

4

5

5
5
5
5

6
9

9

10
10
10
11
11
12

13
13
14
15
15

17
17
18

18
18
19
19
20
20
21
22
22
23

23
23
23
24

26

27

2

Linnorm User Manual

1

Introduction

Linnorm is a normalization and transformation method.

The Linnorm R package contains a variety of functions for single cell RNA-seq data analysis
by utilizing Linnorm.

• scRNA-seq Expression Transformation/Normalization/Imputation

• Normalizing transformation (Linnorm)
• Normalization (Linnorm.Norm)
• Data Imputation (Linnorm.DataImput)

• Stable gene selection for scRNA-seq datasets without spike-in genes (Linnorm.SGenes)
• The Linnorm-limma pipeline (Linnorm.limma)

• Differential expression analysis
• Differential peak detection

• Coexpression network analysis (Linnorm.Cor)
• Highly variable gene discovery (Linnorm.HVar)
• Single cell RNA-seq subpopulation analysis (Clustering)

• t-SNE k-means clustering (Recommended) (Linnorm.tSNE)
• PCA k-means clustering (Linnorm.PCA)
• Hierarchical clustering analysis (Linnorm.HClust)

• RNA-seq data simulation for negative binomial, Poisson, log normal or gamma distribu-

tion. (RnaXSim)

Compared to RNA-seq or other large scale count data, scRNA-seq data have more noises and
more zero counts. Linnorm is developed to work with scRNA-seq data. Since RNA-seq data
are similar to scRNA-seq data, but with less noise, Linnorm is also compatible with RNA-seq
data analysis.

1.1

Datatypes and Input Format
Linnorm accepts any RNA-seq Expression data, including but not limited to

• Raw Count (scRNA-seq, RNA-seq, ChIP-seq or any large scale count data)
• Count per Million (CPM)
• Reads per Kilobase per Million reads sequenced (RPKM)
• expected Fragments Per Kilobase of transcript per Million fragments sequenced (FPKM)
• Transcripts per Million (TPM)

We suggest RPKM, FPKM or TPM for most purposes. Please do NOT input Log transformed
datasets, as Linnorm will perform log transformation.

Linnorm accepts matrix as its data type. Data frames are also accepted and will be automati-
cally converted into the matrix format before analysis. Each column in the matrix should be a
sample or replicate. Each row should be a Gene/Exon/Isoform/etc.

Example:

Sample 1

Sample 2

Sample 3

Gene1
Gene2
Gene3
. . .

1
3
10.87
. . .

2
0
11.56
. . .

1
4
12.98
. . .

. . .

. . .
. . .
. . .
. . .

3

Linnorm User Manual

Sample 1

Sample 2

Sample 3

. . .

. . .

. . .

. . .

. . .

. . .

Please note that undefined values such as NA, NaN, INF, etc are NOT supported.

By setting the RowSamples argument as TRUE, Linnorm can accept a matrix where each
column is a sample or replicate and each row should be a Gene/Exon/Isoform/etc. Example:

Gene 1 Gene 2 Gene 3

Sample1
Sample2
Sample3
. . . ..
. . . ..

1
2
1
. . .
. . .

3
0
4
. . .
. . .

10.87
11.56
12.98
. . .
. . .

. . .

. . .
. . .
. . .
. . .
. . .

Note that Linnorm should work slightly faster with RowSamples set to TRUE.

By using the argument, “input =”Linnorm"", several functions provided by the Linnorm
package can also accept Linnorm transformed datasets as input. Therefore, the dataset
doesn’t need to be re-transformed multiple times for multiple functions.

1.2

Installation
Instructions can be found on Linnorm’s bioconductor page. Please note that some functions
in this vignette are only available in Linnorm version 1.99.x+.

4

Linnorm User Manual

2

Examples with Source Codes

2.1

Data Normalization/Transformation/Imputation

2.1.1 Normalizing Transformation

Here, we will demonstrate how to generate and ouput Linnorm Transformed dataset into a
tab delimited file.

1. Linnorm’s normalizing transformation

library(Linnorm)

# Obtain data

data(Islam2011)

# Do not filter gene list:

Transformed <- Linnorm(Islam2011)

# Filter low count genes

result <- Linnorm(Islam2011, Filter=TRUE)

FTransformed <- result[["Linnorm"]]

2. Write out the results to a tab delimited file.

# You can use this file with Excel.

# This file includes all genes.

write.table(Transformed, "Transformed.txt",

quote=FALSE, sep="\t", col.names=TRUE, row.names=TRUE)

# This file filtered low count genes.

write.table(FTransformed, "Transformed.txt",

quote=FALSE, sep="\t", col.names=TRUE, row.names=TRUE)

2.1.2 Normalization

2.1.2.1 Procedure Here, we will demonstrate how to generate and ouput Linnorm nor-
malized dataset into a tab delimited file.

1. Linnorm Normalization

library(Linnorm)

Normalized <- Linnorm.Norm(Islam2011)

## Please note that this funciton can only work on raw pre-Linnorm transformed data.

# Important: depending on downstream analysis, please

# set output to be "XPM" or "Raw".

# Set to "XPM" if downstream tools will convert the

# dataset into CPM or TPM.

# Set to "Raw" if input is raw counts and downstream

# tools will work with raw counts.

2. Write out the results to a tab delimited file.

5

Linnorm User Manual

# You can use this file with Excel.

write.table(Normalized, "Normalized.txt",

quote=FALSE, sep="\t", col.names=TRUE, row.names=TRUE)

2.1.2.2 Calculating Fold Change and the effects of normalization strength

2.1.2.2.1 Calculate fold change Fold change can be calculated by the Linnorm.limma
function. It is included in differential expression analysis results. However, for users who would
like to calculate fold change from Linnorm transformed dataset and analyze it. Here is an
example.

1. Get 10 samples of TCGA RNA-seq data and convert it into TPM.

library(Linnorm)

data(LIHC)

2. Data filteirng and Normalization

# Now, we can calculate fold changes between

# sample set 1 and sample set 2.

# Index of sample set 1

set1 <- 1:5

# Index of sample set 2

set2 <- 6:10

# Normalization

LIHC2 <- Linnorm.Norm(LIHC,output="XPM")

## Please note that this funciton can only work on raw pre-Linnorm transformed data.

# Optional: Only use genes with at least 50%

# of the values being non-zero

LIHC2 <- LIHC2[rowSums(LIHC2 != 0) >= ncol(LIHC2)/2,]

2. Calculate Fold Change.

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

3. Draw a probability density plot of the fold changes in the dataset.

6

Linnorm User Manual

Density <- density(FCMatrix[,1])

plot(Density$x,Density$y,type="n",xlab="Log 2 Fold Change of TPM+1",

ylab="Probability Density",)

lines(Density$x,Density$y, lwd=1.5, col="blue")

title("Probability Density of Fold Change.\nTCGA Partial LIHC data

Paired Tumor vs Adjacent Normal")

legend("topright",legend=paste("mean = ",

round(mean(FCMatrix[,1]),2),

"\nStdev = ", round(sd(FCMatrix[,1]),2)))

2.1.2.2.2 Effects of normalization strength

4. Using a higher normalization strength in Linnorm.Norm

# Normalization with BE_strength set to 1.
# This increases normalization strength.
LIHC2 <- Linnorm.Norm(LIHC,output="XPM",BE_strength=1)
## Please note that this funciton can only work on raw pre-Linnorm transformed data.

# Optional: Only use genes with at least 50%

# of the values being non-zero

7

−6−4−2024680.00.20.40.60.81.0Log 2 Fold Change of TPM+1Probability DensityProbability Density of Fold Change.TCGA Partial LIHC dataPaired Tumor vs Adjacent Normalmean =  0.28 Stdev =  0.75Linnorm User Manual

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

8

−6−4−2024680.00.20.40.60.81.0Log 2 Fold Change of TPM+1Probability DensityProbability Density of Fold Change.TCGA Partial LIHC dataPaired Tumor vs Adjacent Normalmean =  0.08 Stdev =  0.73Linnorm User Manual

We can see that using a stronger normalization strength can decrease the amount of differences
between the two conditions; this causes the mean of fold change to decrease. By default,
BE_strength is set to 0.5 to prevent overfitting. However, user can adjust it based on the
dataset. Please note that the Linnorm() function for normalizing transformation also allows
users to control normalization strength.

2.1.3 Data Imputation

By default, Linnorm’s data imputation function replaces zerores in the dataset.

However, we do not recommend performing data imputation unless it is shown to improve
results.

1. Linnorm Data Imputation

library(Linnorm)

data(Islam2011)

# Obtain transformed data

Transformed <- Linnorm(Islam2011)

# Data Imputation

DataImputed <- Linnorm.DataImput(Transformed)

## Please note that this funciton can only work on Linnorm transformed data.

# Or, users can directly perform data imputation during transformation.

DataImputed <- Linnorm(Islam2011,DataImputation=TRUE)

## Please note that this funciton can only work on Linnorm transformed data.

2. Write out the results to a tab delimited file.

# You can use this file with Excel.

write.table(DataImputed, "DataImputed.txt",

quote=FALSE, sep="\t", col.names=TRUE, row.names=TRUE)

2.2

Stable Gene Selection

This function selects stable gene/features from the dataset. It is implemented for users who
need spike-in genes or do not want to rely on spike-in genes in scRNA-seq data analysis.

1. Stable Genes Selection

library(Linnorm)

data(Islam2011)

# Obtain stable genes

StableGenes <- Linnorm.SGenes(Islam2011)

## Please note that this funciton can only work on raw pre-Linnorm transformed data.

2. Write out the results to a tab delimited file.

# You can use this file with Excel.

write.table(StableGenes, "StableGenes.txt",

quote=FALSE, sep="\t", col.names=TRUE, row.names=TRUE)

9

Linnorm User Manual

2.3

Differential Expression Analysis using Linnorm-limma
pipeline

• limma package

• limma is imported with Linnorm. Please cite both Linnorm and limma if you use
the Linnorm.limma function for differential expression analysis for publication.

2.3.1 RNA-seq data

2.3.1.1 Analysis procedure We use 10 samples of RNA-seq data. These 10 samples are
paired tumor and adjacent normal tissue samples from 5 individuals from the TCGA LIHC
dataset.

1. Obtain data

library(Linnorm)

data(LIHC)

datamatrix <- LIHC

The Linnorm-limma pipeline only consists of two steps.

2. Create limma design matrix

# 5 samples for condition 1 and 5 samples for condition 2.

# You might need to edit this line

design <- c(rep(1,5),rep(2,5))

# These lines can be copied directly.

design <- model.matrix(~ 0+factor(design))

colnames(design) <- c("group1", "group2")

rownames(design) <- colnames(datamatrix)

3. Linnorm-limma Differential Expression Analysis

a. Basic Differential Expression Analysis. (Follow this if you are not sure what to do.)

library(Linnorm)

# The Linnorm-limma pipeline only consists of one line.
DEG_Results <- Linnorm.limma(datamatrix,design)
## Please note that this funciton can only work on raw pre-Linnorm transformed data.
# The DEG_Results matrix contains your DEG analysis results.

b. Advanced: to output both DEG analysis results and the transformed matrix for further

analysis

library(Linnorm)

# Just add output="Both" into the argument list

BothResults <- Linnorm.limma(datamatrix,design,output="Both")

## Please note that this funciton can only work on raw pre-Linnorm transformed data.

# To separate results into two matrices:
DEG_Results <- BothResults$DEResults
TransformedMatrix <- BothResults$Linnorm
# The DEG_Results matrix now contains DEG analysis results.

10

Linnorm User Manual

# The TransformedMatrix matrix now contains a Linnorm

# Transformed dataset.

2.3.1.2 Print out the most significant genes

1. Write out the results to a tab delimited file.

write.table(DEG_Results, "DEG_Results.txt", quote=FALSE, sep="\t",
col.names=TRUE,row.names=TRUE)

2. Print out the most significant 10 genes.

Genes10 <- DEG_Results[order(DEG_Results[,"adj.P.Val"]),][1:10,]
# Users can print the gene list by the following command:

# print(Genes10)

# logFC: log 2 fold change of the gene.

# XPM: If input is raw count or CPM, XPM is CPM.

#

If input is RPKM, FPKM or TPM, XPM is TPM.

# t: moderated t statistic.

# P.Value: p value.

# adj.P.Val: Adjusted p value. This is also called False Discovery Rate or q value.}

# B: log odds that the feature is differential.

# Note all columns are printed here

CACNA1S|779
HOXD4|3233
PYY|5697
VGF|7425
SFTA1P|207107
LOC221122|221122
LOC127841|127841
IRX5|10265
CCNA1|8900
TCP10L2|401285

logFC
0.6931
2.9023
2.0851
1.4371
4.2981
2.5027
1.7792
2.7649
1.4929
-1.3745

XPM
0.0065
0.0684
0.0342
0.0180
0.1972
0.0493
0.0257
0.0612
0.0192
0.0168

t P.Value
0
0
0
0
0
0
0
0
0
0

43.9444
40.2719
37.4934
35.1250
32.6785
29.4309
26.8891
24.7712
24.6046
-22.0944

adj.P.Val
0
0
0
0
0
0
0
0
0
0

2.3.1.3 Volcano Plot

2.3.1.3.1 Procedure

1. Record significant genes for coloring

SignificantGenes <- DEG_Results[DEG_Results[,5] <= 0.05,1]

2. Draw volcano plot with Log q values. Green dots are non-significant, red dots are

significant.

plot(x=DEG_Results[,1], y=DEG_Results[,5], col=ifelse(DEG_Results[,1] %in%
SignificantGenes, "red", "green"),log="y", ylim =

11

Linnorm User Manual

rev(range(DEG_Results[,5])), main="Volcano Plot",
xlab="log2 Fold Change", ylab="q values", cex = 0.5)

2.3.2 Single cell RNA-seq DEG Analysis

In this section, we use Islam et al. (2011)’s single cell RNA-seq dataset to perform DEG
analysis. In this analysis, we are using 48 mouse embryonic stem cells and 44 mouse embryonic
fibroblasts.

1. Obtain data

library(Linnorm)

data(Islam2011)

IslamData <- Islam2011[,1:92]

2. Create limma design matrix

# 48 samples for condition 1 and 44 samples for condition 2.

# You might need to edit this line

design <- c(rep(1,48),rep(2,44))

# There lines can be copied directly.

design <- model.matrix(~ 0+factor(design))

colnames(design) <- c("group1", "group2")

12

−10−505101e+001e−021e−041e−06Volcano Plotlog2 Fold Changeq valuesLinnorm User Manual

rownames(design) <- colnames(IslamData)

3. DEG Analysis

# Example 1: Filter low count genes.

# and genes with high technical noise.

scRNAseqResults <- Linnorm.limma(IslamData,design,Filter=TRUE)

## Please note that this funciton can only work on raw pre-Linnorm transformed data.

# Example 2: Do not filter gene list.

scRNAseqResults <- Linnorm.limma(IslamData,design)

## Please note that this funciton can only work on raw pre-Linnorm transformed data.

2.4

Gene Co-expression Network Analysis

2.4.1 Analysis Procedure

In this section, we are going to use Islam2011 single cell RNA-seq embryonic stem cell data
and perform Gene Correlation Analysis.

1. Obtain data.

data(Islam2011)

# Obtain embryonic stem cell data

datamatrix <- Islam2011[,1:48]

2. Perform analysis.

# Setting plotNetwork to TRUE will create a figure file in your current directory.

# Setting it to FALSE will stop it from creating a figure file, but users can plot it

# manually later using the igraph object in the output.

# For this vignette, we will plot it manually in step 4.

results <- Linnorm.Cor(datamatrix, plotNetwork=FALSE,

# Edge color when correlation is positive

plot.Pos.cor.col="red",

# Edge color when correlation is negative

plot.Neg.cor.col="green")

3. Print out the most significant 10 pairs of genes.

Genes10 <- results$Results[order(results$Results[,5]),][1:10,]

# Users can print the gene list by the following command:

# print(Genes10)

13

Linnorm User Manual

Gene2
Amd1
1700047I17Rik1
Gm15772
Ftl1
Rex2
Gm9786

Gene1
Amd2
1700047I17Rik2
Rpl26
Ftl2
Gm13138
Oaz1
BC002163-Chr4 Ndufs5
Rps26
r_(T)n
Hnrnpa1

Gm6654
r_(A)n
Gm5643

Cor
1.0000
1.0000
0.9995
0.9990
0.9982
0.9973
0.9964
0.9888
0.9885
0.9852

p.value
0
0
0
0
0
0
0
0
0
0

q.value
0
0
0
0
0
0
0
0
0
0

2.4.2 Plot a co-expression network

We will demonstrate how to plot the figure “networkplot.png” here.

library(igraph)

##

## Attaching package: 'igraph'

## The following objects are masked from 'package:stats':

##

##

decompose, spectrum

## The following object is masked from 'package:base':

##

union

##
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

14

Linnorm User Manual

2.4.2.1
belong to the same cluster as the Mmp2 gene?

Identify genes that belong to a cluster For example, what are the genes that

1. Identify the cluster that Mmp2 belongs to.

TheCluster <- which(results$Cluster[,1] == "Mmp2")

2. Obtain the list of genes that belong to this cluster.

# Index of the genes

ListOfGenes <- which(results$Cluster[,2] == TheCluster)

# Names of the genes

GeneNames <- results$Cluster[ListOfGenes,1]

# Users can write these genes into a file for further analysis.

2.4.2.2 Draw a correlation heatmap

1. Choose 100 most significant genes from clustering results

top100 <- results$Results[order(results$Results[,4],decreasing=FALSE)[1:100],1]

2. Extract these 100 genes from the correlation matrix.

Top100.Cor.Matrix <- results$Cor.Matrix[top100,top100]

3. Draw a correlation heatmap.

15

Amd2Amd11700047I17Rik21700047I17Rik1Rpl26Gm15772Ftl2Ftl1Gm13138Rex2Oaz1Gm9786BC002163−Chr4Ndufs5Rps26Gm6654r_(T)nr_(A)nHnrnpa1Gm5643Gm15427Rpl18aRNA_SPIKE_1RNA_SPIKE_2Bex4Bex1r_B2_Mm1tr_B2_Mm1aPtp4a1Gm13363r_L1Md_TRpl22l1LOC100042049Nutf2Gm10333Rn4.5sr_4.5SRNASrp54aSrp54br_Lx7Gm6402Rps17Zfp600UbbGm1821Rps23Rps16RNA_SPIKE_3r_L1M2r_L1_Mur3Gm10052Rpl24Rps3BC002163Rpl13Rps25Rps24Rpl10aRps10Rpl8Rpl27r_L1VL1Rps7Rps6Rpl37Rpl9Rpl27aRNA_SPIKE_4r_L1_Mus3Rpl23Rps3aThbs1Tpm1r_LTRIS3r_LTRIS2Rps28Rpl35Rps5r_L1_Mur1Rpl12S100a6Rpl19Rps14Rpl39r_L1MEgRpl13aGm9846Rps15Faur_B2_Mm2r_L1Md_F2Npm1Rpl18r_RodERV21−intRpl28Gm5506Gm5506−Chr4Gm6788Dynll1Rpl3Rpsar_L1_Mus4Rps8Rplp2Glrx3Gm12669Rpl32Rps29Uba52Rpl36Timp2Col1a2Rps20Grcc10Rnu7Rpl23ar_L1_Mus2Mxra8SparcCald1Eef1a1Sap18Gm10094Slfn5Cyp2e1r_L1_Mmr_Lx6r_L1MD2Rpl31Rpl7Acta2Serpine2Rpl21Rplp0Ccdc36r_ZP3ARAhnakFat1Actn1Cyp1b1Kif3ar_RLTRETN_MmHmga2Rpl4Gm12191Rpl11BgnRps13MgpFstRps12SnrpgHmga1Hmga1−rs1MifGm16379Col8a1Gpc4PtmaRpl10PbldCcnd26820431F20Rik2610005L07Rikr_Lx5GapdhEef1b2Itgb1Rpl6r_B1_Mmr_B1_Mus2Rpl15Serpinh1NacaCpeEno1CtslDppa5aRpl36aHspe1Tm9sf3Col5a1r_MMETn−intr_Lx8r_L1VL4CaluRpl14Btf3AppVimRps9Gm5643−ChrXSerpine1Gm15450Cyr61Gnai2Ube2r2Fbln2mt−Co1mt−Atp6Spcs2r_L1MB2r_BC1_MmRps11H3f3aRanEmp1LoxRhocDynlt3r_ORR1D2−intEef2Rpl41Rpl17r_MuRRS−intLppFn1Eif2s2Ahcyr_GC_rich6330578E17Rikr_ORR1A2Timm22Rpl37aLgals1Pls3TdhNclmt−Nd1GnasCol1a1Slc44a2mt−Co2mt−Atp8Rps21Cct2ErhHmgb2ItgavPou5f1Banf1PpiaCox6a1PrnpTsc22d2Sh3bgrl9530068E07RikB2mH2afzPerpPtrfH19Igfbp7Igf2TncCtgfPdia3Gng12r_SSU−rRNA_HsaGm4987Rcn1Mmp2Surf4ApoeCol12a1Prss23Fhl3Mdm2Atp6v1aFam101bAtp6ap1Gpx4Cox7cIfitm2Fbn2Cxcr2Fbln5Phldb2Anxa1Magt1Anxa2Gsto1Ldhbmt−Rnr2UbcF2rSpag7Mfsd11r_ORR1A2−intFlnaGas7r_RLTR21RNA_SPIKE_6Cox4i1Rbx1Rpl36alr_Lx4AS100a11Txnl4aHspa8GsnNrp1Ash2lr_RLTR12BCox8aAtp5c1Anp32aFstl1Tomm7CtsdTxn1Cox7bTug1St13Eif3iAkap2Tspan3r_Lx9WlsPabpc1Timp3r_(TTTC)nr_L1MA6Myeov2Col4a2r_IAP−d−intCav1r_B1F1SynrgLamp12310044H10RikNdufa4Nop10Spnb2r_ETnERV2−intr_ETnERV−intYwhabAtp5hRpl34Morf4l1Myl6CtsbSnrpeLoxl2Anxa5Cox7a2Psma2Rps4y2r_MTB_MmPsmd2r_MYSERV16_I−intr_L1MC4Rps15ar_(TTTTG)nCnn2ElnQsox1Ifitm1Usp7Marcksl1IarsPcbp2Exosc2Cbx3Hipk2Cxcl12Glsr_PB1Hsp90aa1Rpl30Dync1i2Atxn10Dhx9Igf2bp1Lamp2Ndufb4Tomm6r_ORR1B1−intCks2SkiHmox1LOC624853Tmsb4xCol4a1Nhp2Srsf5Rbm3r_Charlie5Nischr_MusHAL1r_ORR1A4−intPdap1r_Lx4Br_ORR1E−intPafah1b2Gsk3bUbe2d3Abce1r_RLTR25ASnrpd1r_(GA)nCcnb1Stip11500012F01Rikr_PB1D10r_RMER6Br_RLTR14−intLmnar_LSU−rRNA_Hsar_L1M4bFkbp9Uqcr10r_RLTR1BIgf2rArpc1bGm11968Arpp19Dnmt1mt−Nd4Tubb5r_ID_B1Gnl3lr_L1ME1Rps18TaglnAnxa3Tomm20Manfr_RLTR4_MmDpy30r_(CGG)n2610101N10RikWbp5Dctpp1r_L1_RodVclAtp5oEif3cHist1h2aoMrfap1r_RLTR19−intSox4Psmd14NptnSerbp1Zfp42Cd81Crtapr_MER90Tpm4MsnEif3kFcf1PtmsRps27Sod1Cox6b1r_MTD−intr_MTDHnrnpfSlc25a4r_MYSERV6−intTead1Atp5lGnb2l1r_(GAAA)nr_Lx3APafah1b1Dlc1Emg1r_MIRbSnrpd2Eif4ePsmd7Hsbp1mt−Rnr1mt−Nd2Slc23a1Snhg6Rplp1Timm23Tra2bSqstm1Ccnd1UqcrbPrdx1Wdr26BsgFam60aGrb10Mrpl52Serinc1Vdac22700060E02RikHspa5Ddx3xLmnb1Gas5r_ORR1B1LarsYap1r_RMER20Br_RMER21Br_MYSERV−intSsu72Lsm7r_ORR1D2Chchd1Gm10136Serf2AxlErgic1Tuba1amt−Cytbr_AT_richr_T−richSarnp2900010J23RikTrh2900097C17RikAtpif1Bzw1Ndufab1mt−Nd4l2810025M15RikUbl5Laptm4aPgam1Atp5f1Xpotr_U6Eif4hCalm3S100a10Dnaja1Cd44Ccnd3Eif4ebp1r_RLTR18−intSub1Fth1Mt2Actr2Eif3fIgfbp2Ei24Cops4Col5a2Eif3mNfe2l1Atp5j2Ube2cSdhcSpp1Atp6v0d1r_ORR1D1Bcas2r_RMER6CSumo1r_MTE−intr_RMER1CTbcar_PB1D9r_MMSAT4Srp9Actn4Mt1Eif4bFkbp3CltaAbcf1Slc25a5Ube2v1r_RLTR9ECalm2Nip7Kank2Brd2Kdelr2Hnrnplr_(TC)nLinnorm User Manual

library(RColorBrewer)

library(gplots)

## Registered S3 method overwritten by 'gplots':

method

from

reorder.factor gdata

##

##

##

## Attaching package: 'gplots'

## The following object is masked from 'package:stats':

##

##

lowess

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

16

Linnorm User Manual

2.5

Highly variable gene analysis

2.5.1 Analysis Procedure

In this section, we will perform highly variable gene discovery on the embryonic stem cells
from Islam(2011).

1. Obtain data.

data(Islam2011)

2. Analysis

# The first 48 columns are the embryonic stem cells.

results <- Linnorm.HVar(Islam2011[,1:48])

## Please note that this funciton can only work on raw pre-Linnorm transformed data.

3. Print out the most significant 10 genes.

resultsdata <- results$Results

Genes10 <- resultsdata[order(resultsdata[,"q.value"]),][1:10,3:5]

# Users can print the gene list by the following command:

# print(Genes10)

17

RNA_SPIKE_1RNA_SPIKE_1RNA_SPIKE_2Thbs1S100a6r_L1Md_Tr_L1Md_Tr_L1Md_Tr_Lx7r_Lx7r_(A)nr_(T)nr_(T)nr_(T)nr_L1MEgr_L1VL1BC0021631700047I17Rik2Ptp4a1Oaz1Rn4.5sZfp600Nutf2Bex4Hnrnpa1Rps15Ftl2r_B2_Mm1tGm6402Rpl37Rps7Rps7Rpl19Rpl13Rpl13aRpl12Gm15772Rpl26Rps10Rpl23Rpl23Rps16Rpl24Rps23Rps23Rpl27Rpl27Rpl27Rps24Rps24RNA_SPIKE_1RNA_SPIKE_1RNA_SPIKE_2Thbs1S100a6r_L1Md_Tr_L1Md_Tr_L1Md_Tr_Lx7r_Lx7r_(A)nr_(T)nr_(T)nr_(T)nr_L1MEgr_L1VL1BC0021631700047I17Rik2Ptp4a1Oaz1Rn4.5sZfp600Nutf2Bex4Hnrnpa1Rps15Ftl2r_B2_Mm1tGm6402Rpl37Rps7Rps7Rpl19Rpl13Rpl13aRpl12Gm15772Rpl26Rps10Rpl23Rpl23Rps16Rpl24Rps23Rps23Rpl27Rpl27Rpl27Rps24Rps24GenesGenes−100.51ValueColor KeyLinnorm User Manual

RNA_SPIKE_5
Ptcra
Sec61a2
r_(CAA)n
Kctd5
r_(TTG)n
Hmgb2
Efna4
Mrpl45
Skil

Normalized.Log2.SD.Fold.Change
1.3220
1.0955
1.0399
0.9373
0.9151
0.8830
0.8929
0.8713
0.8586
0.8157

p.value
0e+00
0e+00
0e+00
1e-04
2e-04
3e-04
2e-04
3e-04
4e-04
7e-04

q.value
0.0004
0.0166
0.0289
0.1126
0.1262
0.1446
0.1446
0.1499
0.1597
0.1943

2.5.2 Mean vs SD plot highlighting significant genes

1. Simply print the plot from results.

print(results$plot$plot)

# By default, this plot highlights genes/features with p value less than 0.05.

2.6

Cell subpopulation analysis

2.6.1

t-SNE K-means Clustering

In this section, we use Islam et al. (2011)’s single cell RNA-seq dataset to perform subpopluation
analysis. The 96 samples are consisted of 48 mouse embryonic stem cells, 44 mouse embryonic
fibroblasts and 4 negative controls. We do not use the negative controls here.

1. Read data.

library(Linnorm)

data(Islam2011)

18

0.51.01.52.0246Transformed MeanTransformed Standard DeviationSigSignificantnon−sigMean vs SD plotLinnorm User Manual

2.6.1.1 Simple subpopulation analysis

1. Perform t-SNE analysis using default configurations. This also automiatically determines

the number of cell subpopulations.

tSNE.results <- Linnorm.tSNE(Islam2011[,1:92])

## Please note that this funciton can only work on raw pre-Linnorm transformed data.

2. Draw t-SNE k-means clustering plot.

# Here, we can see two clusters.

print(tSNE.results$plot$plot)

2.6.1.2 Analysis with known subpopulations

1. Assign known groups to samples.

# The first 48 samples belong to mouse embryonic stem cells.
Groups <- rep("ES_Cells",48)
# The next 44 samples are mouse embryonic fibroblasts.
Groups <- c(Groups, rep("EF_Cells",44))

2. Perform tSNE analysis.

# Useful arguments:

# Group:

# allows user to provide each sample's information.
# num_center:
# how many clusters are supposed to be there.

19

−30−20−100102030−10010PC1PC2ClusterCluster 1Cluster 2t−SNE K−means clusteringLinnorm User Manual

# num_PC:
# how many principal components should be used in k-means

# clustering.

tSNE.results <- Linnorm.tSNE(Islam2011[,1:92],
Group=Groups, num_center=2)
## Please note that this funciton can only work on raw pre-Linnorm transformed data.

3. Draw t-SNE k-means clustering plot.

# Here, we can see two clusters.

print(tSNE.results$plot$plot)

2.6.2 PCA K-means Clustering.

In this section, we use Islam et al. (2011)’s single cell RNA-seq dataset to perform subpopluation
analysis. The 96 samples are consisted of 48 mouse embryonic stem cells, 44 mouse embryonic
fibroblasts and 4 negative controls. We do not use the negative controls here. This section is
basically identical to the t-SNE K-means Clustering section above.

1. Read data.

library(Linnorm)

data(Islam2011)

2.6.2.1 Simple subpopulation analysis

20

−10010−20−1001020PC1PC2ClusterCluster 1Cluster 2GroupEF_CellsES_Cellst−SNE K−means clusteringLinnorm User Manual

1. Perform PCA analysis using default configurations.

PCA.results <- Linnorm.PCA(Islam2011[,1:92])

## To perform cell clustering, Linnorm.tSNE is strongly recommended. Linnorm.PCA is only provided as a reference.

## Please note that this funciton can only work on raw pre-Linnorm transformed data.

2. Draw PCA k-means clustering plot.

# Here, we can see multiple clusters.

print(PCA.results$plot$plot)

2.6.2.2 Analysis with known subpopulations

1. Assign known groups to samples.

# The first 48 samples belong to mouse embryonic stem cells.
Groups <- rep("ES_Cells",48)
# The next 44 samples are mouse embryonic fibroblasts.
Groups <- c(Groups, rep("EF_Cells",44))

2. Perform PCA analysis.

# Useful arguments:

# Group:

# allows user to provide each sample's information.
# num_center:
# how many clusters are supposed to be there.
# num_PC

21

−1001020−20−1001020PC1PC2ClusterCluster 1Cluster 2Cluster 3Cluster 4PCA K−means clusteringLinnorm User Manual

# how many principal components should be used in k-means

# clustering.

PCA.results <- Linnorm.PCA(Islam2011[,1:92],
Group=Groups, num_center=2, num_PC=3)
## To perform cell clustering, Linnorm.tSNE is strongly recommended. Linnorm.PCA is only provided as a reference.

## Please note that this funciton can only work on raw pre-Linnorm transformed data.

3. Draw PCA k-means clustering plot.

# Here, we can see two clusters.

print(PCA.results$plot$plot)

2.6.3 Hierarchical Clustering

2.6.3.1 Analysis Procedure In this section, we will perform hierarchical clustering on
Islam2011 data.

1. Obtain data.

data(Islam2011)

Islam <- Islam2011[,1:92]

2. Assign group to samples.

# 48 ESC, 44 EF, and 4 NegCtrl

Group <- c(rep("ESC",48),rep("EF",44))

22

−1001020−20−1001020PC1PC2ClusterCluster 1Cluster 2GroupEF_CellsES_CellsPCA K−means clusteringLinnorm User Manual

colnames(Islam) <- paste(colnames(Islam),Group,sep="_")

3. Perform Analysis.

# Note that there are 3 known clusters.

HClust.Results <- Linnorm.HClust(Islam,Group=Group,
num_Clust=2, fontsize=1.5, Color = c("Red","Blue"), RectColor="Green")

2.6.3.2 Hierarchical Clustering plot We can simply print the plot out.

print(HClust.Results$plot$plot)

2.7

RnaXSim

2.7.1 RNA-seq Expression Data Simulation

2.7.1.1 Default
stration.

In this section, we will run RnaXSim with default settings as a demon-

23

H10_EFH11_EFB10_EFA08_EFC10_EFC12_EFD11_EFF11_EFA12_EFC07_EFB08_EFH07_EFG07_EFC08_EFD01_ESCH09_EFC09_EFB12_EFD08_EFE10_EFD09_EFA07_EFA11_EFF09_EFG08_EFH08_EFE09_EFE08_EFD12_EFD10_EFG11_EFF07_EFA09_EFG09_EFF10_EFD07_EFA10_EFF08_EFC11_EFB07_EFE11_EFG10_EFB09_EFB11_EFE07_EFH01_ESCF04_ESCD06_ESCB01_ESCG01_ESCH04_ESCF06_ESCE06_ESCD05_ESCA04_ESCC05_ESCF05_ESCA05_ESCG06_ESCC02_ESCC03_ESCC01_ESCE02_ESCA02_ESCG02_ESCE05_ESCB03_ESCH06_ESCH03_ESCG04_ESCE01_ESCF02_ESCD02_ESCH05_ESCF01_ESCD04_ESCC06_ESCB06_ESCA01_ESCH02_ESCG05_ESCA03_ESCB05_ESCB04_ESCE04_ESCD03_ESCG03_ESCC04_ESCE03_ESCA06_ESCB02_ESCF03_ESC0246Hierarchical clusteringLinnorm User Manual

1. Get RNA-seq data from SEQC. RnaXSim assume that all samples are replicate of each

other.

library(Linnorm)

data(SEQC)

SampleA <- SEQC

2. Simulate an RNA-seq dataset.

# This will generate two sets of RNA-seq data with 5 replicates each.

# It will have 20000 genes totally with 2000 genes being differentially

# expressed. It has the Negative Binomial distribution.

SimulatedData <- RnaXSim(SampleA)

3. Separate data into matrices and vectors as an example.

# Index of differentially expressed genes.
DE_Index <- SimulatedData[[2]]

# Expression Matrix

ExpMatrix <- SimulatedData[[1]]

# Sample Set 1

Sample1 <- ExpMatrix[,1:3]

# Sample Set 2

Sample2 <- ExpMatrix[,4:6]

2.7.1.2 Advanced In this section, we will show an example where RnaXSim is run with
customized settings.

1. Get RNA-seq data from SEQC.

data(SEQC)

SampleA <- SEQC

2. Simulate an RNA-seq dataset using the above parameters.

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

3. Separate data into matrices and vectors for further usage.

# Index of differentially expressed genes.
DE_Index <- SimulatedData[[2]]

24

Linnorm User Manual

# Expression Matrix

ExpMatrix <- SimulatedData[[1]]

# Simulated Sample Set 1

Sample1 <- ExpMatrix[,1:3]

# Simulated Sample Set 2

Sample2 <- ExpMatrix[,4:6]

25

Linnorm User Manual

3

Frequently Asked Questions

1. Can I use Linnorm Transformed dataset to calculate Fold Change?

Answer: Linnorm Transformed dataset is a log transformed dataset. You should not use
it to calculate fold change directly. To do it correctly, please refer to the calculate fold
change section.

2. I only have two samples in total. Can I perform Linnorm Transformation?
Answer: No, you cannot. Linnorm requires a minimum of 3 samples.

3. I only have 1 replicate for each sample set. Can I perform Differential Expression

Analysis with Linnorm and limma?
Answer: No, linear model based methods must have replicates. So, limma wouldn’t
work.

4. There are a lot of fold changes with INF values in Linnorm.limma output. Can I convert

them into numerical units like those in the voom-limma pipeline?
Answer: Since the expression in one set of sample can be zero, while the other can be
otherwise, it is arithmetically correct to generate INFs. However, it is possible for the
Linnorm.limma function to prevent generating INFs by setting the noINF argument as
TRUE, which is the default.

5. Do I need to run Linnorm.Norm() in addition to transforming the datset with Linnorm()?
Answer: Linnorm()’s transformation also performs Linnorm.Norm()’s normalization step.
Therefore, please DO NOT rerun Linnorm.Norm() before or after Linnorm().

26

Linnorm User Manual

4

Bug Reports, Questions and Suggestions

We appreciate and welcome any Bug Reports, Questions and Suggestions. They can be posted
on bioconductor’s support site, https://support.bioconductor.org. Please remember to add
the Linnorm tag in your post so that Ken will be notified. Bioconductor’s posting guide can
be found at http://www.bioconductor.org/help/support/.

27


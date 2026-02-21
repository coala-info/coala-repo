iClusterPlus: integrative clustering of multiple
genomic data sets

Qianxing Mo1 and Ronglai Shen2

October 30, 2025

1Department of Biostatistics & Bioinformatics
H. Lee Moffitt Cancer Center & Research Institute
qianxing.mo@moffitt.org

2Deparment of Epidemiology and Biostatistics
Memorial Sloan-Kettering Cancer Center
shenr@mskcc.org

Contents

1 Introduction

1

Introduction

1

Programs iClusterPlus and iClusterBayes are developed for integrative clustering analysis
of multi-type genomic data, which are significant extension of the iCluster program (Shen,
Olshen and Ladanyi, 2009). Multi-type genomic data arise from the experiments where
biological samples (e.g., tumor samples) are analyzed by multiple techniques, for instance,
array comparative genomic hybridization (aCGH), gene expression microarray, RNA-seq
and DNA-seq, and so on. Examples of these data can be obtained from the Cancer Genome
Atlas (TCGA) (http://cancergenome.nih.gov/).

The iClusterPlus User’s guide can be obtained from the Bioconductor web page. If you are
using Unix/Linux, you can get the manual by typing the following code in R Console.

> if (!requireNamespace("BiocManager", quietly=TRUE))

> install.packages("BiocManager")

> BiocManager::install("iClusterPlus")
> library(iClusterPlus)
> iManual()

In addition, a simulation was performed to test the package. For details, please see the R
code in the iClusterPlus/inst/unitTests/ folder.

1


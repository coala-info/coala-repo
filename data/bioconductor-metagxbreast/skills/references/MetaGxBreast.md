MetaGxBreast: a package for breast cancer gene
expression analysis

Michael Zon1, Deena M.A. Gendoo1,2, Natchar Ratanasirigulchai1,
Gregory Chen2, Levi Waldron3,4, and Benjamin Haibe-Kains∗1,2

1Bioinformatics and Computational Genomics Laboratory, Princess
Margaret Cancer Center, University Health Network, Toronto,
Ontario, Canada
2Department of Medical Biophysics, University of Toronto, Toronto,
Canada
3Department of Biostatistics and Computational Biology,
Dana-Farber Cancer Institute, Boston, MA, USA
4Department of Biostatistics, Harvard School of Public Health,
Boston, MA, USA

November 4, 2025

Contents

1 Installing the Package

2 Loading Datasets

3 Obtaining Sample Counts in Datasets

4 Assess Phenotype Data

5 Session Info

∗benjamin.haibe.kains@utoronto.ca

1

2

2

3

3

5

1

Installing the Package

The MetaGxBreast package is a compendium of Breast Cancer datasets. The
package is publicly available and can be installed from Bioconductor into R
version 3.5.0 or higher.

To install the MetaGxBreast package from Bioconductor:

> if (!requireNamespace("BiocManager", quietly = TRUE))
+
> BiocManager::install("MetaGxBreast")

install.packages("BiocManager")

2 Loading Datasets

First we load the MetaGxBreast package into the workspace.

To load the packages into R and obtain some datasets, please use the

following commands:

> library(MetaGxBreast)
> esets <- MetaGxBreast::loadBreastEsets(loadString = c("CAL", "DFHCC", "DFHCC2",
+

"DFHCC3", "DUKE", "DUKE2", "EMC2"))[[1]]

This will load 7 of the 37 expression datasets. Users can modify the
parameters of the function to restrict datasets that do not meet certain
criteria for loading. Also note that loadString = "majority" will load 37 of
the 39 datasets. The larger metabric and tcga studies need to be loaded
separately by altering the loadString variable to include the string metabric
or tcga. Some example parameters are shown below:

Datasets: Retain only genes that are common across all platforms loaded

(default = FALSE)

Datasets: Retain studies with a minimum sample size (default = 0)

Datasets: Retain studies with a minimum umber of genes (default = 0)

Datasets: Retain studies with a minimum number of survival events (de-

fault = 0)

Datasets: Remove duplicate samples (default = TRUE)

2

3 Obtaining Sample Counts in Datasets

To obtain the number of samples per dataset, run the following:

length(sampleNames(esets[[i]]))
}, numeric(1), esets=esets)

> library(Biobase)
> numSamples <- vapply(seq_along(esets), FUN=function(i, esets){
+
+
> SampleNumberSummaryAll <- data.frame(NumberOfSamples = numSamples,
+
> total <- sum(SampleNumberSummaryAll[,"NumberOfSamples"])
> SampleNumberSummaryAll <- rbind(SampleNumberSummaryAll, total)
> rownames(SampleNumberSummaryAll)[nrow(SampleNumberSummaryAll)] <- "Total"
> require(xtable)
> print(xtable(SampleNumberSummaryAll,digits = 2), floating = FALSE)

row.names = names(esets))

CAL
DFHCC
DFHCC2
DFHCC3
DUKE
DUKE2
EMC2
Total

NumberOfSamples
118.00
115.00
83.00
40.00
169.00
154.00
204.00
883.00

4 Assess Phenotype Data

We can also obtain a summary of the phenotype data (pData) for each ex-
pression dataset. Here, we assess the proportion of samples in every datasets
that contain a specific pData variable.

> #pData Variables
> pDataID <- c("er","pgr", "her2", "age_at_initial_pathologic_diagnosis",
+
+
+
> pDataPercentSummaryTable <- NULL
> pDataSummaryNumbersTable <- NULL
> pDataSummaryNumbersList <- lapply(esets, function(x)
+

"grade", "dmfs_days", "dmfs_status", "days_to_tumor_recurrence",
"recurrence_status", "days_to_death", "vital_status",
"sample_type", "treatment")

vapply(pDataID, function(y) sum(!is.na(pData(x)[,y])), numeric(1)))

3

,pDataPercentSummaryTable)

vapply(pDataID, function(y)

sum(!is.na(pData(x)[,y]))/nrow(pData(x)), numeric(1))*100)

> pDataPercentSummaryList <- lapply(esets, function(x)
+
+
> pDataSummaryNumbersTable <- sapply(pDataSummaryNumbersList, function(x) x)
> pDataPercentSummaryTable <- sapply(pDataPercentSummaryList, function(x) x)
> rownames(pDataSummaryNumbersTable) <- pDataID
> rownames(pDataPercentSummaryTable) <- pDataID
> colnames(pDataSummaryNumbersTable) <- names(esets)
> colnames(pDataPercentSummaryTable) <- names(esets)
> pDataSummaryNumbersTable <- rbind(pDataSummaryNumbersTable, total)
> rownames(pDataSummaryNumbersTable)[nrow(pDataSummaryNumbersTable)] <- "Total"
> # Generate a heatmap representation of the pData
> pDataPercentSummaryTable <- t(pDataPercentSummaryTable)
> pDataPercentSummaryTable <- cbind(Name=(rownames(pDataPercentSummaryTable))
+
> nba<-pDataPercentSummaryTable
> gradient_colors <- c("#ffffff","#ffffd9","#edf8b1","#c7e9b4","#7fcdbb",
+
> library(lattice)
> nbamat<-as.matrix(nba)
> rownames(nbamat) <- nbamat[,1]
> nbamat <- nbamat[,-1]
> Interval <- as.numeric(c(10,20,30,40,50,60,70,80,90,100))
> levelplot(nbamat,col.regions=gradient_colors,
+
+
+
+
+
+
+
+
+
+
>

at=seq(from=0,to=100,length=10),
cex=0.2, ylab="", xlab="", lattice.options=list(),
colorkey=list(at=as.numeric(factor(c(seq(from=0, to=100, by=10)))),

labels=as.character(c( "0","10%","20%","30%", "40%","50%",
"60%", "70%", "80%","90%", "100%"),

main="Available Clinical Annotation",
scales=list(x=list(rot=90, cex=0.5),

cex=0.2,font=1,col="brown",height=1,
width=1.4), col=(gradient_colors)))

"#41b6c4","#1d91c0","#225ea8","#253494","#081d58")

y= list(cex=0.5),key=list(cex=0.2)),

4

5 Session Info

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB,

LC_COLLATE=C, LC_MONETARY=en_US.UTF-8,
LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,

5

Available Clinical Annotationerpgrher2age_at_initial_pathologic_diagnosisgradedmfs_daysdmfs_statusdays_to_tumor_recurrencerecurrence_statusdays_to_deathvital_statussample_typetreatmentCALDFHCCDFHCC2DFHCC3DUKEDUKE2EMC2010%20%30%40%50%60%70%80%90%100%LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK:

/usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats,

utils

• Other packages: AnnotationHub 4.0.0, Biobase 2.70.0,

BiocFileCache 3.0.0, BiocGenerics 0.56.0, ExperimentHub 3.0.0,
MetaGxBreast 1.30.0, dbplyr 2.5.1, generics 0.1.4, lattice 0.22-7,
xtable 1.8-4

• Loaded via a namespace (and not attached): AnnotationDbi 1.72.0,

BiocManager 1.30.26, BiocVersion 3.22.0, Biostrings 2.78.0,
DBI 1.2.3, DelayedArray 0.36.0, GenomicRanges 1.62.0,
IRanges 2.44.0, KEGGREST 1.50.0, Matrix 1.7-4,
MatrixGenerics 1.22.0, R6 2.6.1, RSQLite 2.4.3, S4Arrays 1.10.0,
S4Vectors 0.48.0, Seqinfo 1.0.0, SparseArray 1.10.1,
SummarizedExperiment 1.40.0, XVector 0.50.0, abind 1.4-8, bit 4.6.0,
bit64 4.6.0-1, blob 1.2.4, cachem 1.1.0, cli 3.6.5, compiler 4.5.1,
crayon 1.5.3, curl 7.0.0, dplyr 1.1.4, fastmap 1.2.0, filelock 1.0.3,
glue 1.8.0, grid 4.5.1, httr 1.4.7, httr2 1.2.1, impute 1.84.0,
lifecycle 1.0.4, magrittr 2.0.4, matrixStats 1.5.0, memoise 2.0.1,
pillar 1.11.1, pkgconfig 2.0.3, png 0.1-8, purrr 1.1.0, rappdirs 0.3.3,
rlang 1.1.6, stats4 4.5.1, tibble 3.3.0, tidyselect 1.2.1, tools 4.5.1,
vctrs 0.6.5, withr 3.0.2, yaml 2.3.10

6


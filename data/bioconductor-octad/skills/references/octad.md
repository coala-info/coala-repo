# OCTAD: Open Cancer TherApeutic Discovery

* [Package overview](#package-overview)
* [Workflow](#workflow)
  + [Compute or select control samples](#compute-or-select-control-samples)
  + [Compute reverse gene expression scores](#compute-reverse-gene-expression-scores)
  + [Validate results using published pharmacogenomics data](#validate-results-using-published-pharmacogenomics-data)
  + [Compute drug enrichment](#compute-drug-enrichment)
  + [Compute DE full dataset and custom expression matrix](#compute-de-full-dataset-and-custom-expression-matrix)
* [Web-version and citation](#web-version-and-citation)
* [Session information](#session-information)

### Evgenii Chekalin, Billy Zeng, Patrick Newbury, Benjamin Glicksberg, Jing Xing, Ke Liu, Dimitri Joseph, Bin Chen

Edited on September 28, 2020; Compiled on September 29, 2020

# Package overview

As the field of precision medicine progresses, we start to tailor treatments for cancer patients classified not only by their clinical, but also by their molecular features. The emerging cancer subtypes defined by these features require dedicated resources to assist the discovery of drug candidates for preclinical evaluation. Voluminous cancer patient gene expression profiles have been accumulated in public databases, enabling the creation of a cancer-specific expression signature. Meanwhile, large-scale gene expression profiles of chemical compounds became available in recent years. By matching the cancer-specific expression signature to compound-induced gene expression profiles from large drug libraries, researchers can prioritize small molecules that present high potency to reverse expression of signature genes for further experimental testing of their efficacy. This approach has proven to be an efficient and cost-effective way to identify efficacious drug candidates. However, the success of this approach requires multiscale procedures, imposing significant challenges to many labs. Therefore, we present OCTAD (<http://octad.org>): an open workspace for virtually screening compounds targeting precise cancer patient groups using gene expression features. We have included 19,127 patient tissue samples covering 50 cancer types, and expression profiles for 12,442 distinct compounds. We will continue to include more tissue samples. We streamline all the procedures including deep-learning based reference tissue selection, disease gene expression signature creation, drug reversal potency scoring, and in silico validation. We release OCTAD as a web portal and a standalone R package to allow experimental and computational scientists to easily navigate the tool. The code and data can also be employed to answer various biological questions.

# Workflow

We use Hepatocellular Carcinoma (HCC) to illustrate the utility of the desktop pipeline. We provide the code and data for investigating differential expression, pathway enrichment, drug prediction and hit selection, and in silico validation. In this workflow, we will select case tissue samples from our compiled TCGA data and compute control tissue samples from the GTEx data. Note that the compiled data contains adjacent normal samples which can also serve as control tissues. By default, the octad package uses Small OCTAD dataset containing expression values only for LINCS 978 landmark genes required for sRGES score computation. To download the full expression values, please refer to the link [octad.counts.and.tpm.h5](https://experimenthub.bioconductor.org/fetch/7327) (~3G). We recommend to use the full expression matrix. By default, computated results are stored in the temporary directory. ## Select case samples Choosing cases (tumor samples from the phenoDF data.frame) and controls (corresponding samples treated as background such as normal tissue, adjacent normal tissue or tumor tissue samples without a specific mutation) is critical to achieving the best results. Several methods are included in the provided code which demonstrates multiple control sample selection methods. There are no built-in validation steps to evaluate case samples. Visualization of cases in a t-SNE (t-Distributed Stochastic Neighbor Embedding) plot could help understand their relations with other OCTAD samples. Samples sharing similar transcriptomic profiles tend to cluster together in the t-SNE plot. The cases scattering in multiple clusters are not recommended to choose as a group. Phenotype data frame `phenoDF` contains tissue types including normal tissue, adjacent normal tissue, primary cancer, recurrent cancer, and metastatic cancer.

To list all available samples from the octad database, use the phenoDF data frame. To select HCC samples, subset the phenoDF:

```
#select data
library(octad)
```

```
## Loading required package: magrittr
```

```
## Loading required package: dplyr
```

```
##
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
##
##     filter, lag
```

```
## The following objects are masked from 'package:base':
##
##     intersect, setdiff, setequal, union
```

```
## Loading required package: ggplot2
```

```
## Loading required package: edgeR
```

```
## Loading required package: limma
```

```
## Loading required package: RUVSeq
```

```
## Loading required package: Biobase
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following object is masked from 'package:dplyr':
##
##     explain
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following object is masked from 'package:limma':
##
##     plotMA
```

```
## The following object is masked from 'package:dplyr':
##
##     combine
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
## Loading required package: EDASeq
```

```
## Loading required package: ShortRead
```

```
## Loading required package: BiocParallel
```

```
## Loading required package: Biostrings
```

```
## Loading required package: S4Vectors
```

```
## Loading required package: stats4
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following objects are masked from 'package:dplyr':
##
##     first, rename
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
##
## Attaching package: 'IRanges'
```

```
## The following objects are masked from 'package:dplyr':
##
##     collapse, desc, slice
```

```
## Loading required package: XVector
```

```
## Loading required package: Seqinfo
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

```
## Loading required package: Rsamtools
```

```
## Loading required package: GenomicRanges
```

```
##
## Attaching package: 'GenomicRanges'
```

```
## The following object is masked from 'package:magrittr':
##
##     subtract
```

```
## Loading required package: GenomicAlignments
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: MatrixGenerics
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'matrixStats'
```

```
## The following objects are masked from 'package:Biobase':
##
##     anyMissing, rowMedians
```

```
## The following object is masked from 'package:dplyr':
##
##     count
```

```
##
## Attaching package: 'MatrixGenerics'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
##     colWeightedMeans, colWeightedMedians, colWeightedSds,
##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
##     rowWeightedSds, rowWeightedVars
```

```
## The following object is masked from 'package:Biobase':
##
##     rowMedians
```

```
##
## Attaching package: 'GenomicAlignments'
```

```
## The following object is masked from 'package:dplyr':
##
##     last
```

```
##
## Attaching package: 'ShortRead'
```

```
## The following object is masked from 'package:dplyr':
##
##     id
```

```
## The following object is masked from 'package:magrittr':
##
##     functions
```

```
## Loading required package: DESeq2
```

```
## Loading required package: rhdf5
```

```
## Loading required package: foreach
```

```
## Loading required package: Rfast
```

```
## Loading required package: Rcpp
```

```
## Loading required package: zigg
```

```
## Loading required package: RcppParallel
```

```
##
## Attaching package: 'RcppParallel'
```

```
## The following object is masked from 'package:Rcpp':
##
##     LdFlags
```

```
##
## Rfast: 2.1.5.2
```

```
##  ___ __ __ __ __    __ __ __ __ __ _             _               __ __ __ __ __     __ __ __ __ __ __
## |  __ __ __ __  |  |  __ __ __ __ _/            / \             |  __ __ __ __ /   /__ __ _   _ __ __\
## | |           | |  | |                         / _ \            | |                        / /
## | |           | |  | |                        / / \ \           | |                       / /
## | |           | |  | |                       / /   \ \          | |                      / /
## | |__ __ __ __| |  | |__ __ __ __           / /     \ \         | |__ __ __ __ _        / /__/\
## |    __ __ __ __|  |  __ __ __ __|         / /__ _ __\ \        |_ __ __ __ _   |      / ___  /
## |   \              | |                    / _ _ _ _ _ _ \                     | |      \/  / /
## | |\ \             | |                   / /           \ \                    | |         / /
## | | \ \            | |                  / /             \ \                   | |        / /
## | |  \ \           | |                 / /               \ \                  | |       / /
## | |   \ \__ __ _   | |                / /                 \ \     _ __ __ __ _| |      / /
## |_|    \__ __ __\  |_|               /_/                   \_\   /_ __ __ __ ___|      \/             team
```

```
##
## Attaching package: 'Rfast'
```

```
## The following objects are masked from 'package:MatrixGenerics':
##
##     colMads, colMaxs, colMedians, colMins, colRanks, colVars, rowMads,
##     rowMaxs, rowMedians, rowMins, rowRanks, rowVars
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colMads, colMaxs, colMedians, colMins, colRanks, colVars, rowMads,
##     rowMaxs, rowMedians, rowMins, rowRanks, rowVars
```

```
## The following object is masked from 'package:Biobase':
##
##     rowMedians
```

```
## The following object is masked from 'package:edgeR':
##
##     gini
```

```
## The following object is masked from 'package:dplyr':
##
##     nth
```

```
## Loading required package: octad.db
```

```
## Loading required package: ExperimentHub
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
##
## Attaching package: 'dbplyr'
```

```
## The following objects are masked from 'package:dplyr':
##
##     ident, sql
```

```
##
## Attaching package: 'AnnotationHub'
```

```
## The following object is masked from 'package:Biobase':
##
##     cache
```

```
## Welcome to octad.db package. This is a database package, pipeline available via the octad package. If you want to run the pipeline on the webserver, please refer to octad.org
```

```
## Loading required package: httr
```

```
##
## Attaching package: 'httr'
```

```
## The following object is masked from 'package:Biobase':
##
##     content
```

```
## Loading required package: qpdf
```

```
phenoDF=get_ExperimentHub_data("EH7274") #load data.frame with samples included in the OCTAD database.
```

```
## see ?octad.db and browseVignettes('octad.db') for documentation
```

```
## loading from cache
```

```
head(phenoDF) #list all data included within the package
```

```
##                  sample.id sample.type                  biopsy.site cancer
## 1 GTEX-1117F-0226-SM-5GZZ7      normal       ADIPOSE - SUBCUTANEOUS normal
## 2 GTEX-1117F-0426-SM-5EGHI      normal            MUSCLE - SKELETAL normal
## 3 GTEX-1117F-0526-SM-5EGHJ      normal              ARTERY - TIBIAL normal
## 4 GTEX-1117F-0626-SM-5N9CS      normal            ARTERY - CORONARY normal
## 5 GTEX-1117F-0726-SM-5GIEN      normal     HEART - ATRIAL APPENDAGE normal
## 6 GTEX-1117F-1326-SM-5EGHH      normal ADIPOSE - VISCERAL (OMENTUM) normal
##   data.source gender read.count.file age_in_year metastatic_site tumor_grade
## 1        GTEX Female      TOIL.RData        <NA>            <NA>        <NA>
## 2        GTEX Female      TOIL.RData        <NA>            <NA>        <NA>
## 3        GTEX Female      TOIL.RData        <NA>            <NA>        <NA>
## 4        GTEX Female      TOIL.RData        <NA>            <NA>        <NA>
## 5        GTEX Female      TOIL.RData        <NA>            <NA>        <NA>
## 6        GTEX Female      TOIL.RData        <NA>            <NA>        <NA>
##   tumor_stage gain_list loss_list mutation_list subtype
## 1        <NA>                              <NA>    <NA>
## 2        <NA>                              <NA>    <NA>
## 3        <NA>                              <NA>    <NA>
## 4        <NA>                              <NA>    <NA>
## 5        <NA>                              <NA>    <NA>
## 6        <NA>                              <NA>    <NA>
```

```
HCC_primary=subset(phenoDF,cancer=='liver hepatocellular carcinoma'&sample.type == 'primary') #select data
case_id=HCC_primary$sample.id #select cases
```

The sample ids will be stored in the character vector case\_id. The code can be easily modified to select for other cancers or a set of samples based on mutations and copy numbers (e.g., TP53 mutation or MYC amplification). It is also recommended to use the R package cgdsr to select TCGA samples based on more clinical and molecular features.

## Compute or select control samples

Use the function `computeRefTissue` to compute appropriate normal tissues via comparing gene expression features between case samples and normal tissue samples. Users can select adjacent normal tissue samples if available. By default, features from the precomputed `AutoEncoder` file are used, but other features such as top varying genes across samples can be employed as well. Pairwise Spearman correlation is computed between every case sample and every normal sample using these features. For each normal sample, its median correlation with all case samples is then computed. Top correlated normal samples (defined by control\_size) are then selected as control.

```
#computing top 50 reference tissues
control_id=computeRefTissue(case_id,output=FALSE,adjacent=TRUE,source = "octad",control_size = 50)
```

```
## see ?octad.db and browseVignettes('octad.db') for documentation
```

```
## loading from cache
```

```
## see ?octad.db and browseVignettes('octad.db') for documentation
```

```
## loading from cache
```

```
#please note, if \code{output = TRUE}, \code{outputFolder} variable must be specified, otherwise it will be written to \code{tempdir()}
# use adjacent normal tissue samples as control_id allow you to avoid running this function
```

There is also an availability to select control samples by hand:

```
#computing top 50 reference tissues
control_id=subset(phenoDF,biopsy.site=='LIVER'&sample.type=='normal')$sample.id[1:50] #select first 50 samples from healthy liver
# use adjacent normal tissue samples as control_id allow you to avoid running this function
```

The relationships among case, control and other samples can be visualised through a t-SNE matrix precomputed based on the features derived from autoencoder.

```
tsne=get_ExperimentHub_data("EH7276") #Download file with tsneresults for all samples in the octad.db once. After this it will be cached and no additional download required.
```

```
## see ?octad.db and browseVignettes('octad.db') for documentation
```

```
## loading from cache
```

```
tsne$type <- "others"
tsne$type[tsne$sample.id %in% case_id] <- "case"
tsne$type[tsne$sample.id %in% control_id] <- "control"

#plot
p2 <- ggplot(tsne, aes(X, Y, color = type)) + geom_point(alpha = 0.4)+
    labs(title = paste ('TNSE PLOT'), x= 'TSNE Dim1', y='TSNE Dim2', caption="OCTAD")+
    theme_bw()
p2
```

![](data:image/png;base64...) ## Compute gene differential expression between case and control samples Differential expression can be computed via edgeR, limma + voom, or DESeq2. By default, we use edgeR in the analysis. Since the function `diffExp` computes differentially expressed genes between `case_id` and `control_id` within the same data matrix, it can be used to find differentially expressed genes between any two groups of samples. By default, a small dataset containing only 978 genes shared with the LINCS database is used.

```
res=diffExp(case_id,control_id,source='octad.small',output=FALSE,DE_method='wilcox')
#please note, if \code{output = TRUE}, \code{outputFolder} variable must be specified, otherwise it will be written to \code{tempdir()}
head(res)
#Use simple subset to filter the DE results:
res=subset(res,abs(log2FoldChange)>1&padj<0.001)
```

The `diffExp` function will produce `data.frame` with DE results. Please note that option `annotate` is not required to be `TRUE`, but in this case annotation will be performed. If using custom expression matrix, please make sure `expSet row.names` contains Ensembl IDs that are used to assign gene names and gene descriptions. By default the small dataset containing 978 genes used to compute DE. To compute DE for the whole 60k genes or custom expression matrix refer to section “Compute DE full dataset and custom expression matrix”.

## Compute reverse gene expression scores

The `runsRGES` function is used to identify the drugs that potentially reverses the disease signature. Use the code below to choose significant genes; this works by keeping genes that have low adjusted P-values and high log-fold changes.
Launch the sRGES computation. It takes a few minutes to compute RGES scores. After the job is finished, it will output files all\_lincs\_score.csv (RGES of individual profiles), sRGES.csv (summarized RGES of individual drugs) and dz\_sig\_used.csv (signature genes used for drug prediction). LINCS also provides the imputed expression of the whole transcriptome based on the 978 genes. We will add it in the future when its usage is fully evaluated. There is no good way available to choose an optimal sRGES threshold, but empirically < -0.2 is good to go

```
data("res_example") #load differential expression example for HCC vs adjacent liver tissue computed in diffExp() function from previous step
res=subset(res_example,abs(log2FoldChange)>1&padj<0.001) #load example expression dataset
sRGES=runsRGES(res,max_gene_size=100,permutations=1000,output=FALSE)
#please note, if \code{output = TRUE}, \code{outputFolder} variable must be specified, otherwise it will be written to \code{tempdir()}
head(sRGES)
```

## Validate results using published pharmacogenomics data

As the pharmacogenomic database CTRPv2 consists of efficacy data of 481 drugs in 860 cancer cell lines, we may leverage this database for further in silico validation of our predictions, even without running any biological experiment. We use the HepG2 cell line to validate the prediction of HCC drugs.

```
cell_line_computed=computeCellLine(case_id=case_id,source='octad.small')
```

```
## outputFolder is NULL, writing output to tempdir()
```

```
## loading whole octad expression data for 369 samples
```

```
## computing correlation between cell lines and selected samples
```

```
## see ?octad.db and browseVignettes('octad.db') for documentation
```

```
## loading from cache
```

```
## see ?octad.db and browseVignettes('octad.db') for documentation
```

```
## loading from cache
```

```
#please note, if \code{output = TRUE}, \code{outputFolder} variable must be specified, otherwise it will be written to \code{tempdir()}
head(cell_line_computed)
```

```
##            medcor
## HEPG2   0.4997406
## HEC108  0.3828849
## A549    0.3168699
## HS578T  0.2975901
## COV644  0.2901484
## NCIH508 0.2779563
```

`computeCellLine` will produce an object with correlation scores for every cell line and case samples (stored as CellLineCorrelations.csv).

```
data("sRGES_example") #load example sRGES from octad.db
#please note, if \code{outputFolder=NULL}, output it will be written to \code{tempdir()}
topLineEval(topline = 'HEPG2',mysRGES = sRGES_example)
```

```
## outputFolder is NULL, writing output to tempdir()
```

```
## see ?octad.db and browseVignettes('octad.db') for documentation
```

```
## loading from cache
```

```
## see ?octad.db and browseVignettes('octad.db') for documentation
```

```
## loading from cache
```

```
## `geom_smooth()` using formula = 'y ~ x'
## `geom_smooth()` using formula = 'y ~ x'
```

`topLineEval` will produce CellLineEval\*\_drug\_sensitivity\_insilico\_results.txt and two .html documents: 1. \*\_auc\_insilico\_validation.html (correlation between drug AUC in the specified cell line and sRGES) 2. \*\_ic50\_insilico\_validation.html (correlation between drug IC50 in the specified cell line and sGRES)

## Compute drug enrichment

After calculation of sRGES on the LINCS L1000 compound dataset, perform drug enrichment analysis to identify interesting drug classes whose member drugs are significantly enriched at the top of the prediction. Example drug classes include anti-inflammatories, EGFR inhibitors, and dipines (calcium channel blockers). OCTAD provides MESH, CHEMBL, and CHEM\_CLUSTER for MeSH term enrichment, target enrichment, and chemical structure enrichment, respectively. The enrichment score is calculated using ssGSEA and its significance is computed by a permutation test.

```
data("sRGES_example")
octadDrugEnrichment(sRGES = sRGES_example, target_type='chembl_targets')
```

```
## outputFolder is NULL, writing output to tempdir()
```

```
## see ?octad.db and browseVignettes('octad.db') for documentation
```

```
## loading from cache
```

```
## Running enrichment for chembl_targets
```

```
## see ?octad.db and browseVignettes('octad.db') for documentation
```

```
## loading from cache
```

```
## ! 12442 genes/features with constant values throughout the samples
```

```
## ! Some gene sets have size one. Consider setting minSize > 1
```

```
## Done forchembl_targetsfor22genes
```

```
#please note, if \code{outputFolder=NULL}, output it will be written to \code{tempdir()}
```

This analysis provides much information for following candidate selection and experiment design. First, the candidates selected from the same enriched class (i.e., MeSH term, target) are more likely to be true positive than those randomly selected from the top list. Second, when the ideal candidate is not available, it is reasonable to choose an alternative from the same class. Sometimes, it is necessary to choose a new drug for testing (e.g., a second generation of one inhibitor for the same target). Lastly, since many compounds have multiple MOAs, this analysis would help interpret the MOA of promising compounds.

## Compute DE full dataset and custom expression matrix

To use the whole OCTAD dataset from octad.counts.and.tpm.h5 as input, make sure the required .h5 file is downloaded and stored in the R working directory or the whole path to the file is specified:

```
get_ExperimentHub_data('EH7277')
res=diffExp(case_id,control_id,source='octad.whole',
    output=FALSE,n_topGenes=10000,file='octad.counts.and.tpm.h5')
```

We can also perform DE analysis using an external dataset. Below is an example to perform DE analysis between tumor and non-tumor samples using the count data downloaded from GEO [GSE144269](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE144269).

```
data=data.table::fread(('https://ftp.ncbi.nlm.nih.gov/geo/series/GSE144nnn/GSE144269/suppl/GSE144269_RSEM_GeneCounts.txt.gz'),header=TRUE)
row.names(data)=data$entrez_id
data$entrez_id=NULL
samples=colnames(data) #define the case and control cohorts, A samples were obtained from tumors, B samples were obtained from adjacent tissue
case_id=samples[grepl('A_S',samples)]
control_id=samples[grepl('B_S',samples)]
res=diffExp(case_id,control_id,source='side',output=FALSE,outputFolder=tempdir(),n_topGenes=10000,
    expSet=log2(as.matrix(data)+1),annotate=FALSE) #compute DE
```

The `diffExp` function will produce `data.frame` with DE results. Please note that option `annotate` is not required to be `TRUE`, but in this case annotation will be performed. If using custom expression matrix, please make sure `expSet row.names` contains Ensembl IDs that are used to assign gene names and gene descriptions.

# Web-version and citation

Alternatively the database and the pipeline is available via website of the OCTAD project: <http://octad.org/>. If you use our work, please cite the [OCTAD paper](https://www.biorxiv.org/content/10.1101/821546v1). Both OCTAD package and website was developed by [Bin Chen laboratory](http://binchenlab.org/). octad package is github available via [link](https://github.com/Bin-Chen-Lab/octad_desktop) After the package will be accepted to the bioconductor, it will be available on the [bioconductor](https://bioconductor.org/packages/octad)

# Session information

Here is the output of sessionInfo on the system where this document was compiled:

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] octad_1.12.0                qpdf_1.4.1
##  [3] httr_1.4.7                  octad.db_1.11.0
##  [5] ExperimentHub_3.0.0         AnnotationHub_4.0.0
##  [7] BiocFileCache_3.0.0         dbplyr_2.5.1
##  [9] Rfast_2.1.5.2               RcppParallel_5.1.11-1
## [11] zigg_0.0.2                  Rcpp_1.1.0
## [13] foreach_1.5.2               rhdf5_2.54.0
## [15] DESeq2_1.50.0               RUVSeq_1.44.0
## [17] EDASeq_2.44.0               ShortRead_1.68.0
## [19] GenomicAlignments_1.46.0    SummarizedExperiment_1.40.0
## [21] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [23] Rsamtools_2.26.0            GenomicRanges_1.62.0
## [25] Biostrings_2.78.0           Seqinfo_1.0.0
## [27] XVector_0.50.0              IRanges_2.44.0
## [29] S4Vectors_0.48.0            BiocParallel_1.44.0
## [31] Biobase_2.70.0              BiocGenerics_0.56.0
## [33] generics_0.1.4              edgeR_4.8.0
## [35] limma_3.66.0                ggplot2_4.0.0
## [37] dplyr_1.1.4                 magrittr_2.0.4
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1               BiocIO_1.20.0
##   [3] bitops_1.0-9                filelock_1.0.3
##   [5] tibble_3.3.0                R.oo_1.27.1
##   [7] graph_1.88.0                XML_3.99-0.19
##   [9] lifecycle_1.0.4             httr2_1.2.1
##  [11] pwalign_1.6.0               lattice_0.22-7
##  [13] MASS_7.3-65                 crosstalk_1.2.2
##  [15] plotly_4.11.0               sass_0.4.10
##  [17] rmarkdown_2.30              jquerylib_0.1.4
##  [19] yaml_2.3.10                 askpass_1.2.1
##  [21] DBI_1.2.3                   RColorBrewer_1.1-3
##  [23] abind_1.4-8                 purrr_1.1.0
##  [25] R.utils_2.13.0              RCurl_1.98-1.17
##  [27] rappdirs_0.3.3              irlba_2.3.5.1
##  [29] GSVA_2.4.0                  annotate_1.88.0
##  [31] codetools_0.2-20            DelayedArray_0.36.0
##  [33] tidyselect_1.2.1            farver_2.1.2
##  [35] ScaledMatrix_1.18.0         jsonlite_2.0.0
##  [37] iterators_1.0.14            tools_4.5.1
##  [39] progress_1.2.3              glue_1.8.0
##  [41] SparseArray_1.10.0          xfun_0.53
##  [43] mgcv_1.9-3                  HDF5Array_1.38.0
##  [45] withr_3.0.2                 BiocManager_1.30.26
##  [47] fastmap_1.2.0               latticeExtra_0.6-31
##  [49] rhdf5filters_1.22.0         digest_0.6.37
##  [51] rsvd_1.0.5                  R6_2.6.1
##  [53] jpeg_0.1-11                 dichromat_2.0-0.1
##  [55] biomaRt_2.66.0              RSQLite_2.4.3
##  [57] cigarillo_1.0.0             R.methodsS3_1.8.2
##  [59] h5mread_1.2.0               tidyr_1.3.1
##  [61] data.table_1.17.8           rtracklayer_1.70.0
##  [63] prettyunits_1.2.0           htmlwidgets_1.6.4
##  [65] S4Arrays_1.10.0             pkgconfig_2.0.3
##  [67] gtable_0.3.6                blob_1.2.4
##  [69] S7_0.2.0                    hwriter_1.3.2.1
##  [71] SingleCellExperiment_1.32.0 htmltools_0.5.8.1
##  [73] GSEABase_1.72.0             scales_1.4.0
##  [75] png_0.1-8                   SpatialExperiment_1.20.0
##  [77] knitr_1.50                  reshape2_1.4.4
##  [79] rjson_0.2.23                nlme_3.1-168
##  [81] curl_7.0.0                  cachem_1.1.0
##  [83] stringr_1.5.2               BiocVersion_3.22.0
##  [85] parallel_4.5.1              AnnotationDbi_1.72.0
##  [87] restfulr_0.0.16             pillar_1.11.1
##  [89] grid_4.5.1                  vctrs_0.6.5
##  [91] BiocSingular_1.26.0         beachmat_2.26.0
##  [93] xtable_1.8-4                evaluate_1.0.5
##  [95] GenomicFeatures_1.62.0      magick_2.9.0
##  [97] cli_3.6.5                   locfit_1.5-9.12
##  [99] compiler_4.5.1              rlang_1.1.6
## [101] crayon_1.5.3                labeling_0.4.3
## [103] interp_1.1-6                aroma.light_3.40.0
## [105] plyr_1.8.9                  stringi_1.8.7
## [107] viridisLite_0.4.2           deldir_2.0-4
## [109] lazyeval_0.2.2              Matrix_1.7-4
## [111] hms_1.1.4                   sparseMatrixStats_1.22.0
## [113] bit64_4.6.0-1               Rhdf5lib_1.32.0
## [115] KEGGREST_1.50.0             statmod_1.5.1
## [117] memoise_2.0.1               bslib_0.9.0
## [119] bit_4.6.0
```
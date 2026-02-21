# TEKRABber

Yao-Chung Chen1\* and Katja Nowick2\*\*

1Institute of Bioinformatics, Freie Universität Berlin, Berlin, Germany
2Human Biology, Institute of Biology, Freie Universität Berlin, Berlin, Germany

\*yao-chung.chen@fu-berlin.de
\*\*katja.nowick@fu-berlin.de

#### 15 January 2026

#### Package

TEKRABber 1.14.1

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Examples](#examples)
  + [3.1 Comparing between two species, human and chimpanzee as an example](#comparing-between-two-species-human-and-chimpanzee-as-an-example)
    - [3.1.1 Query ortholog information and estimate scaling factor](#query-ortholog-information-and-estimate-scaling-factor)
    - [3.1.2 Create inputs for differentially expressed analysis and correlation estimation](#create-inputs-for-differentially-expressed-analysis-and-correlation-estimation)
    - [3.1.3 Differentially expressed analysis (DE analysis)](#differentially-expressed-analysis-de-analysis)
    - [3.1.4 Correlation analysis](#correlation-analysis)
    - [3.1.5 Explore your result using `appTEKRABber()`:](#explore-your-result-using-apptekrabber)
  + [3.2 Comparing control and treatment samples within the same species](#comparing-control-and-treatment-samples-within-the-same-species)
    - [3.2.1 DE analysis](#de-analysis)
    - [3.2.2 Correlation analysis](#correlation-analysis-1)
    - [3.2.3 Explore your result using `appTEKRABber()`:](#explore-your-result-using-apptekrabber-1)

# 1 Introduction

*[TEKRABber](https://bioconductor.org/packages/3.22/TEKRABber)* is used to estimate the correlations
between genes and transposable elements (TEs) from RNA-seq data
comparing between: **(1)** Two Species **(2)** Control vs. Experiment.
In the following sections, we will use built-in data to demonstrate how
to implement *[TEKRABber](https://bioconductor.org/packages/3.22/TEKRABber)* on you own analysis.

# 2 Installation

To use *[TEKRABber](https://bioconductor.org/packages/3.22/TEKRABber)* from your R environment, you
need to install it using *[BiocManager](https://bioconductor.org/packages/3.22/BiocManager)*:

```
install.packages("BiocManager")
BiocManager::install("TEKRABber")
```

```
library(TEKRABber)
```

# 3 Examples

## 3.1 Comparing between two species, human and chimpanzee as an example

Gene and TE expression data are generated from randomly picked brain
regions FASTQ files from 10 humans and 10 chimpanzees (Khrameeva E et
al., Genome Research, 2020). The values for the first column of gene and
TE count table must be **Ensembl gene ID** and **TE name**:

```
# load built-in data
data(speciesCounts)
hmGene <- speciesCounts$hmGene
hmTE <- speciesCounts$hmTE
chimpGene <- speciesCounts$chimpGene
chimpTE <- speciesCounts$chimpTE
# the first column must be Ensembl gene ID for gene, and TE name for TE
head(hmGene)
```

```
##            Geneid SRR8750453 SRR8750454 SRR8750455 SRR8750456 SRR8750457
## 1 ENSG00000000003        250        267        227        286        128
## 2 ENSG00000000005         13          2         15          9          5
## 3 ENSG00000000419        260        311        159        259        272
## 4 ENSG00000000457         86        131        100         94         80
## 5 ENSG00000000460         21         17         42         33         55
## 6 ENSG00000000938        162         75         95        252        195
##   SRR8750458 SRR8750459 SRR8750460 SRR8750461 SRR8750462
## 1        394        268        102        370        244
## 2          0          1          8          0          2
## 3        408        371        126        211        374
## 4        158        119         46         77         81
## 5         29         50         11         18         20
## 6        137         93        108        197         69
```

### 3.1.1 Query ortholog information and estimate scaling factor

In the first step, we use `orthologScale()` to get orthology information
and calculate the scaling factor between two species for normalizing
orthologous genes. The species name needs to be the abbreviation of
scientific species name used in Ensembl. (Note: (1)This step queries
information using *[biomaRt](https://bioconductor.org/packages/3.22/biomaRt)* and it might need
some time or try different mirrors due to the connections to Ensembl
(2)It might take some time to calculate scaling factor based on your
data size). For normalizing TEs, you need to provide a RepeatMasker
track annotation table including four columns, (1) the name of TE (2)
the class of TE (3) the average gene length of TE from your reference
species (4) the average gene length from the species you want to
compare. A way to download RepeatMasker annotations is to query from
[UCSC Genome Table
Browser](http://genome.ucsc.edu/cgi-bin/hgTables?hgsid=1582443383_JGQc9hw61oGahqe20hrSWdfkjDWx&clade=mammal&org=Human&db=hg38&hgta_group=rep&hgta_track=hg38&hgta_table=0&hgta_regionType=genome&position=chr2%3A25%2C160%2C915-25%2C168%2C903&hgta_outputType=primaryTable&hgta_outFileName=hg38rmsk.csv)
and select the RepeatMasker track. In new version v1.8.0 and above,
TEKRABber provides `prepareRMSK()` to obtain RepeatMasker track from
UCSC and merge the table for you. However, there still remain a chance
that the species you are interested in cannot be obtain from this
method. You can use `GenomeInfoDb::registered_UCSC_genomes()` for
checking the track exists for your species.

```
# You can use the code below to search for species name
ensembl <- biomaRt::useEnsembl(biomart = "genes")
biomaRt::listDatasets(ensembl)
```

```
# In order to save time, we provide the data for this tutorial.
# you can also uncomment the code below and run it for yourself.
data(fetchDataHmChimp)
fetchData <- fetchDataHmChimp

# Query the data and calculate scaling factor using orthologScale():
#' data(speciesCounts)
#' data(hg38_panTro6_rmsk)
#' hmGene <- speciesCounts$hmGene
#' chimpGene <- speciesCounts$chimpGene
#' hmTE <- speciesCounts$hmTE
#' chimpTE <- speciesCounts$chimpTE
#'
#' ## For demonstration, here we only select 1000 rows to save time
#' set.seed(1234)
#' hmGeneSample <- hmGene[sample(nrow(hmGene), 1000), ]
#' chimpGeneSample <- chimpGene[sample(nrow(chimpGene), 1000), ]
#'
#' ## hg38_panTro6_rmsk = prepareRMSK("hg38", "panTro6")
#' fetchData <- orthologScale(
#'     speciesRef = "hsapiens",
#'     speciesCompare = "ptroglodytes",
#'     geneCountRef = hmGeneSample,
#'     geneCountCompare = chimpGeneSample,
#'     teCountRef = hmTE,
#'     teCountCompare = chimpTE,
#'     rmsk = hg38_panTro6_rmsk
#' )
```

### 3.1.2 Create inputs for differentially expressed analysis and correlation estimation

We use `DECorrInputs()` to return input files for downstream analysis.

```
inputBundle <- DECorrInputs(fetchData)
```

### 3.1.3 Differentially expressed analysis (DE analysis)

In this step, we need to generate a metadata contain species name (i.e.,
human and chimpanzee). The row names need to be same as the DE input
table and the column name must be **species** (see the example below).
Then we use `DEgeneTE()` to perform DE analysis. When you are comparing
samples between two species, the parameter **expDesign** should be
**TRUE** (as default).

```
meta <- data.frame(
    species = c(rep("human", ncol(hmGene) - 1),
    rep("chimpanzee", ncol(chimpGene) - 1))
)

meta$species <- factor(meta$species, levels = c("human", "chimpanzee"))
rownames(meta) <- colnames(inputBundle$geneInputDESeq2)
hmchimpDE <- DEgeneTE(
    geneTable = inputBundle$geneInputDESeq2,
    teTable = inputBundle$teInputDESeq2,
    metadata = meta,
    expDesign = TRUE
)
```

### 3.1.4 Correlation analysis

Here we use `corrOrthologTE()` to perform correlation estimation
comparing each ortholog and TE. This is the most time-consuming step if
you have large data. For a quick demonstration, we use a relatively
small data. You can specify the correlation method and adjusted
*p-value* method. The default methods are Pearson’s correlation and FDR.
**Note:** For more efficient and specific analysis, you can subset your
data in this step to focus on only the orthologs and TEs that you are
interested in.

```
# we select the 200 rows of genes for demo
hmCorrResult <- corrOrthologTE(
    geneInput = hmchimpDE$geneCorrInputRef[c(1:200),],
    teInput = hmchimpDE$teCorrInputRef,
    numCore = 1,
    corrMethod = "pearson",
    padjMethod = "fdr"
)

chimpCorrResult <- corrOrthologTE(
    geneInput = hmchimpDE$geneCorrInputCompare[c(1:200), ],
    teInput = hmchimpDE$teCorrInputCompare,
    numCore = 1,
    corrMethod = "pearson",
    padjMethod = "fdr"
)
```

### 3.1.5 Explore your result using `appTEKRABber()`:

*[TEKRABber](https://bioconductor.org/packages/3.22/TEKRABber)* provides an app function called
`appTEKRABber()` for you to quickly view your result and select data
that you are interested in. You will need to install
[gridlayout](https://github.com/rstudio/gridlayout) to run
`appTEKRABber()` function. **Note:** you might need to installed
additional packages to run this function.

```
remotes::install_github('rstudio/gridlayout')

library(plotly)
library(bslib)
library(shiny)
library(gridlayout)

appTEKRABber(
    corrRef = hmCorrResult,
    corrCompare = chimpCorrResult,
    DEobject = hmchimpDE
)
```

![](data:image/jpeg;base64...)

The first time you opeining the app, you will see the distribution of
Gene and TE alongside pvalue axis and coefficient axis in your reference
group and comparision group. You can next select the Gene Name and
Transposable Elements which will plot a scatterplot indicating their
correlations, and also a expression plot showing the differentially
expression analysis. This help you to have a first glance at the pair of
Gene:TE which you are interested in.

## 3.2 Comparing control and treatment samples within the same species

If you want to compare selected genes and TEs **(1)** from different
tissue in same species or **(2)** control and drug treatment in same
tissue in same species, please generate all the input files following
the input format. Here we show an example data of prepared input files
including expression counts from 10 control and 10 treatment samples.
The format of input data: row names should be gene name or id, and
column name is your sample id (please see details below).

```
# load built-in data
data(ctInputDE)
geneInputDE <- ctInputDE$gene
teInputDE <- ctInputDE$te

# you need to follow the input format as below
head(geneInputDE)
```

```
##                 control_1 control_2 control_3 control_4 control_5 treatment_6
## ENSG00000180263      1470      2072      1864      2238      2246        2599
## ENSG00000185985      1599      1045       946      1642      2199         665
## ENSG00000144355       517       380      1211       812        48         388
## ENSG00000234003         4         4        14        10         5           9
## ENSG00000257342         1         1         1         2         3           3
## ENSG00000223953       259       830       133       258       850         504
##                 treatment_7 treatment_8 treatment_9 treatment_10
## ENSG00000180263        2679        2562        2532         2682
## ENSG00000185985        1023        2477        1423         1731
## ENSG00000144355         275         633          59          248
## ENSG00000234003           4          18          13           22
## ENSG00000257342           0           6           1            5
## ENSG00000223953        1143        1500         498          864
```

### 3.2.1 DE analysis

For DE analysis in the same species, you also use `DEgeneTE()` function,
however, you need to set the parameter **expDesign** to **FALSE**. You
also need to provide a metadata which this time the column name must be
**experiment**. See demonstration below:

```
metaExp <- data.frame(experiment = c(rep("control", 5), rep("treatment", 5)))
rownames(metaExp) <- colnames(geneInputDE)
metaExp$experiment <- factor(
    metaExp$experiment,
    levels = c("control", "treatment")
)

resultDE <- DEgeneTE(
    geneTable = geneInputDE,
    teTable = teInputDE,
    metadata = metaExp,
    expDesign = FALSE
)
```

### 3.2.2 Correlation analysis

Here we demonstrate using the first 200 rows of genes and all the TEs to
calculate their correlations.

```
controlCorr <- corrOrthologTE(
    geneInput = resultDE$geneCorrInputRef[c(1:200),],
    teInput = resultDE$teCorrInputRef,
    numCore = 1,
    corrMethod = "pearson",
    padjMethod = "fdr"
)

treatmentCorr <- corrOrthologTE(
    geneInput = resultDE$geneCorrInputCompare[c(1:200),],
    teInput = resultDE$teCorrInputCompare,
    numCore = 1,
    corrMethod = "pearson",
    padjMethod = "fdr"
)

head(treatmentCorr)
```

### 3.2.3 Explore your result using `appTEKRABber()`:

```
remotes::install_github('rstudio/gridlayout')
appTEKRABber(
    corrRef = controlCorr,
    corrCompare = treatmentCorr,
    DEobject = resultDE
)
```

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] TEKRABber_1.14.1 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            farver_2.1.2
##  [3] dplyr_1.1.4                 blob_1.3.0
##  [5] S7_0.2.1                    filelock_1.0.3
##  [7] Biostrings_2.78.0           fastmap_1.2.0
##  [9] apeglm_1.32.0               BiocFileCache_3.0.0
## [11] digest_0.6.39               lifecycle_1.0.5
## [13] KEGGREST_1.50.0             RSQLite_2.4.5
## [15] magrittr_2.0.4              compiler_4.5.2
## [17] rlang_1.1.7                 sass_0.4.10
## [19] tools_4.5.2                 yaml_2.3.12
## [21] knitr_1.51                  S4Arrays_1.10.1
## [23] bit_4.6.0                   curl_7.0.0
## [25] DelayedArray_0.36.0         RColorBrewer_1.1-3
## [27] plyr_1.8.9                  abind_1.4-8
## [29] BiocParallel_1.44.0         numDeriv_2016.8-1.1
## [31] BiocGenerics_0.56.0         grid_4.5.2
## [33] stats4_4.5.2                ggplot2_4.0.1
## [35] scales_1.4.0                iterators_1.0.14
## [37] MASS_7.3-65                 dichromat_2.0-0.1
## [39] SummarizedExperiment_1.40.0 bbmle_1.0.25.1
## [41] cli_3.6.5                   mvtnorm_1.3-3
## [43] rmarkdown_2.30              crayon_1.5.3
## [45] generics_0.1.4              otel_0.2.0
## [47] httr_1.4.7                  bdsmatrix_1.3-7
## [49] DBI_1.2.3                   cachem_1.1.0
## [51] parallel_4.5.2              AnnotationDbi_1.72.0
## [53] BiocManager_1.30.27         XVector_0.50.0
## [55] matrixStats_1.5.0           vctrs_0.6.5
## [57] Matrix_1.7-4                jsonlite_2.0.0
## [59] bookdown_0.46               IRanges_2.44.0
## [61] S4Vectors_0.48.0            bit64_4.6.0-1
## [63] locfit_1.5-9.12             foreach_1.5.2
## [65] jquerylib_0.1.4             glue_1.8.0
## [67] emdbook_1.3.14              codetools_0.2-20
## [69] gtable_0.3.6                BiocVersion_3.22.0
## [71] GenomicRanges_1.62.1        tibble_3.3.1
## [73] pillar_1.11.1               rappdirs_0.3.3
## [75] htmltools_0.5.9             Seqinfo_1.0.0
## [77] R6_2.6.1                    dbplyr_2.5.1
## [79] httr2_1.2.2                 doParallel_1.0.17
## [81] evaluate_1.0.5              lattice_0.22-7
## [83] Biobase_2.70.0              AnnotationHub_4.0.0
## [85] png_0.1-8                   memoise_2.0.1
## [87] bslib_0.9.0                 Rcpp_1.1.1
## [89] coda_0.19-4.1               SparseArray_1.10.8
## [91] DESeq2_1.50.2               xfun_0.55
## [93] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```
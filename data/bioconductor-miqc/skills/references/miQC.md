# An introduction to miQC

Ariel Hippen and Stephanie Hicks

#### Compiled: October 30, 2025

# 1 Installation

To install the package, please use the following.

```
if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("miQC")
```

# 2 Introduction

This vignette provides a basic example of how to run miQC, which allows users to
perform cell-wise filtering of single-cell RNA-seq data for quality control.
Single-cell RNA-seq data is very sensitive to tissue quality and choice of
experimental workflow; it’s critical to ensure compromised cells and failed cell
libraries are removed. A high proportion of reads mapping to mitochondrial DNA
is one sign of a damaged cell, so most analyses will remove cells with mtRNA
over a certain threshold, but those thresholds can be arbitrary and/or
detrimentally stringent, especially for archived tumor tissues.
miQC jointly models both the proportion of reads mapping to mtDNA genes and the
number of detected genes with mixture models in a probabilistic framework to
identify the low-quality cells in a given dataset.

For more information about the statistical background of miQC and for biological
use cases, consult the miQC paper (Hippen et al. [2021](#ref-hippen_miqc_2021)).

You’ll need the following packages installed to run this tutorial:

```
suppressPackageStartupMessages({
    library(SingleCellExperiment)
    library(scRNAseq)
    library(scater)
    library(flexmix)
    library(splines)
    library(miQC)
})
```

## 2.1 Example data

To demonstrate how to run miQC on a single-cell RNA-seq dataset, we’ll use data
from mouse brain cells, originating from an experiment by Zeisel et al
(Zeisel et al. [2015](#ref-zeisel_brain_2015)), and available through the Bioconductor package *scRNAseq*.

```
sce <- ZeiselBrainData()
sce
```

```
## class: SingleCellExperiment
## dim: 20006 3005
## metadata(0):
## assays(1): counts
## rownames(20006): Tspan12 Tshz1 ... mt-Rnr1 mt-Nd4l
## rowData names(1): featureType
## colnames(3005): 1772071015_C02 1772071017_G12 ... 1772066098_A12
##   1772058148_F03
## colData names(9): tissue group # ... level1class level2class
## reducedDimNames(0):
## mainExpName: gene
## altExpNames(2): repeat ERCC
```

## 2.2 Scater preprocessing

In order to calculate the percent of reads in a cell that map to mitochondrial
genes, we first need to establish which genes are mitochondrial. For genes
listed as HGNC symbols, this is as simple as searching for genes starting with
*mt-*. For other IDs, we recommend using a *biomaRt* query to map to chromosomal
location and identify all mitochondrial genes.

```
mt_genes <- grepl("^mt-",  rownames(sce))
feature_ctrls <- list(mito = rownames(sce)[mt_genes])

feature_ctrls
```

```
## $mito
##  [1] "mt-Tl1"  "mt-Tn"   "mt-Tr"   "mt-Tq"   "mt-Ty"   "mt-Tk"   "mt-Ta"
##  [8] "mt-Tf"   "mt-Tp"   "mt-Tc"   "mt-Td"   "mt-Tl2"  "mt-Te"   "mt-Tv"
## [15] "mt-Tg"   "mt-Tt"   "mt-Tw"   "mt-Tm"   "mt-Ti"   "mt-Nd3"  "mt-Nd6"
## [22] "mt-Nd4"  "mt-Atp6" "mt-Nd2"  "mt-Nd5"  "mt-Nd1"  "mt-Co3"  "mt-Cytb"
## [29] "mt-Atp8" "mt-Co2"  "mt-Co1"  "mt-Rnr2" "mt-Rnr1" "mt-Nd4l"
```

*miQC* is designed to be run with the Bioconductor package *scater*, which has a
built-in function *addPerCellQC* to calculate basic QC metrics like number of
unique genes detected per cell and total number of reads. When we pass in our
list of mitochondrial genes, it will also calculate percent mitochondrial reads.

```
sce <- addPerCellQC(sce, subsets = feature_ctrls)
head(colData(sce))
```

```
## DataFrame with 6 rows and 21 columns
##                     tissue   group # total mRNA mol      well       sex
##                <character> <numeric>      <numeric> <numeric> <numeric>
## 1772071015_C02    sscortex         1          21580        11         1
## 1772071017_G12    sscortex         1          21748        95        -1
## 1772071017_A05    sscortex         1          31642        33        -1
## 1772071014_B06    sscortex         1          32916        42         1
## 1772067065_H06    sscortex         1          21531        48         1
## 1772071017_E02    sscortex         1          24799        13        -1
##                      age  diameter  level1class level2class       sum  detected
##                <numeric> <numeric>  <character> <character> <numeric> <integer>
## 1772071015_C02        21      0.00 interneurons       Int10     22354      4871
## 1772071017_G12        20      9.56 interneurons       Int10     22869      4712
## 1772071017_A05        20     11.10 interneurons        Int6     32594      6055
## 1772071014_B06        21     11.70 interneurons       Int10     33525      5852
## 1772067065_H06        25     11.00 interneurons        Int9     21694      4724
## 1772071017_E02        20     11.90 interneurons        Int9     25919      5427
##                subsets_mito_sum subsets_mito_detected subsets_mito_percent
##                       <numeric>             <integer>            <numeric>
## 1772071015_C02              774                    23             3.462468
## 1772071017_G12             1121                    27             4.901832
## 1772071017_A05              952                    27             2.920783
## 1772071014_B06              611                    28             1.822521
## 1772067065_H06              164                    23             0.755969
## 1772071017_E02             1122                    19             4.328871
##                altexps_repeat_sum altexps_repeat_detected
##                         <numeric>               <numeric>
## 1772071015_C02               8181                     419
## 1772071017_G12              11854                     480
## 1772071017_A05              18021                     582
## 1772071014_B06              13955                     512
## 1772067065_H06               6876                     363
## 1772071017_E02              17364                     618
##                altexps_repeat_percent altexps_ERCC_sum altexps_ERCC_detected
##                             <numeric>        <numeric>             <numeric>
## 1772071015_C02                21.9677             6706                    43
## 1772071017_G12                28.8012             6435                    46
## 1772071017_A05                31.6435             6335                    47
## 1772071014_B06                25.5999             7032                    43
## 1772067065_H06                19.9299             5931                    39
## 1772071017_E02                34.7600             6671                    43
##                altexps_ERCC_percent     total
##                           <numeric> <numeric>
## 1772071015_C02              18.0070     37241
## 1772071017_G12              15.6349     41158
## 1772071017_A05              11.1238     56950
## 1772071014_B06              12.8999     54512
## 1772067065_H06              17.1908     34501
## 1772071017_E02              13.3543     49954
```

# 3 miQC

## 3.1 Basic usage

Using the QC metrics generated via *scater*, we can use the *plotMetrics*
function to visually inspect the quality of our dataset.

```
plotMetrics(sce)
```

![](data:image/png;base64...)

We can see that most cells have a fairly low proportion of mitochondrial reads,
given that the graph is much denser at the bottom. We likely have many cells
that are intact and biologically meaningful. There are also a few cells that
have almost half of their reads mapping to mitochondrial genes, which are likely
broken or otherwise compromised and we will want to exclude from our downstream
analysis. However, it’s not clear what boundaries to draw to separate the two
groups of cells. With that in mind, we’ll generate a linear mixture model using
the *mixtureModel* function.

```
model <- mixtureModel(sce)
```

This function is a wrapper for *flexmix*, which fits a mixture model on our data
and returns the parameters of the two lines that best fit the data, as well as
the posterior probability of each cell being derived from each distribution.

We can look at the parameters and posterior values directly with the functions

```
parameters(model)
```

```
##                         Comp.1       Comp.2
## coef.(Intercept)  9.5008085231 26.884028786
## coef.detected    -0.0008339271 -0.003754021
## sigma             3.3047231785  6.489257837
```

```
head(posterior(model))
```

```
##           [,1]       [,2]
## [1,] 0.8943357 0.10566431
## [2,] 0.9002302 0.09976979
## [3,] 0.8712705 0.12872951
## [4,] 0.8527811 0.14721891
## [5,] 0.8558051 0.14419491
## [6,] 0.8848183 0.11518170
```

Or we can visualize the model results using the *plotModel* function:

```
plotModel(sce, model)
```

![](data:image/png;base64...)

As expected, the cells at the very top of the graph are almost certainly
compromised, most likely to have been derived from the distribution with fewer
unique genes and higher baseline mitochondrial expression.

We can use these posterior probabilities to choose which cells to keep, and
visualize the consequences of this filtering with the *plotFiltering* function.

```
plotFiltering(sce, model)
```

![](data:image/png;base64...)

To actually perform the filtering and remove the indicated cells from our
SingleCellExperiment object, we can run the *filterCells* parameter.

```
sce <- filterCells(sce, model)
```

```
## Removing 359 out of 3005 cells.
```

```
sce
```

```
## class: SingleCellExperiment
## dim: 20006 2646
## metadata(0):
## assays(1): counts
## rownames(20006): Tspan12 Tshz1 ... mt-Rnr1 mt-Nd4l
## rowData names(2): featureType subsets_mito
## colnames(2646): 1772071015_C02 1772071017_G12 ... 1772066097_D04
##   1772066098_A12
## colData names(22): tissue group # ... total prob_compromised
## reducedDimNames(0):
## mainExpName: gene
## altExpNames(2): repeat ERCC
```

## 3.2 Other model types

In most cases, a linear mixture model will be satisfactory as well as simpler,
but *miQC* also supports some non-linear mixture models: currently polynomials
and b-splines. A user should only need to change the *model\_type* parameter when
making the model, and all visualization and filtering functions will work the
same as with a linear model.

```
sce <- ZeiselBrainData()
sce <- addPerCellQC(sce, subsets = feature_ctrls)

model2 <- mixtureModel(sce, model_type = "spline")
plotModel(sce, model2)
```

![](data:image/png;base64...)

```
plotFiltering(sce, model2)
```

![](data:image/png;base64...)

```
model3 <- mixtureModel(sce, model_type = "polynomial")
plotModel(sce, model3)
```

![](data:image/png;base64...)

```
plotFiltering(sce, model3)
```

![](data:image/png;base64...)

*miQC* is designed to combine information about mitochondrial percentage and
library complexity (number of genes discovered) to make filtering decisions, but
if an even simpler model is preferred, *miQC* can make a model based only on
mitochondrial information. This can be done by changing the *model\_type*
parameter to “one\_dimensional”, which runs a 1D gaussian mixture model. When
library size is not added to the model, it is possible to calculate a single
mitochondrial threshold to apply, which can be directly calculated using
the *get1DCutoff* function.

```
model4 <- mixtureModel(sce, model_type = "one_dimensional")
plotModel(sce, model4)
```

![](data:image/png;base64...)

```
plotFiltering(sce, model4)
```

![](data:image/png;base64...)

```
get1DCutoff(sce, model4)
```

```
## [1] 14.57058
```

## 3.3 Extras

### 3.3.1 Changing posterior cutoff

*miQC* defaults to removing any cell with 75% or greater posterior
probability of being compromised, but if we want to be more or less stringent,
we can alter the *posterior\_cutoff* parameter, like so:

```
plotFiltering(sce, model4, posterior_cutoff = 0.9)
```

![](data:image/png;base64...)

Note that when performing miQC multiple times on different samples for the same
experiment, it’s recommended to select the same *posterior\_cutoff* for all, to
give consistency in addition to the flexibility of sample-specific models.

### 3.3.2 Preventing exclusion of low-mito cells

*miQC* includes two parameters to accomodate unusual and undesired behavior in
the linear distributions. These issues are especially visible in some cancer
datasets with a stringent posterior cutoff. We’ve included a bare-bones version
of QC data for a high-grade serous ovarian tumor (full version of the data is
available at GEO, accession GSM4816047).

```
data("hgsoc_metrics")
sce <- SingleCellExperiment(colData = metrics)
model <- mixtureModel(sce)
plotFiltering(sce, model, posterior_cutoff = 0.6, enforce_left_cutoff = FALSE,
                keep_all_below_boundary = FALSE)
```

![](data:image/png;base64...)

The first issue is the group of cells at the bottom of the distribution getting
marked for removal. These cells happen to be near the x-intercept of the
compromised cell line, which increases their posterior probability of being
compromised. But since they have decent library complexity and a low
mitochondrial percentage, so it doesn’t make biological sense to exclude them.
When the *keep\_all\_below\_boundary* parameter is set to True, as is the default,
any cells below the intact cell line are kept:

```
plotFiltering(sce, model, posterior_cutoff = 0.6, enforce_left_cutoff = FALSE,
                keep_all_below_boundary = TRUE)
```

![](data:image/png;base64...)

### 3.3.3 Preventing U-shaped boundary

The second issue is the U-shape in the boundary between kept and discarded
cells. When this occurs, there will be cells at the bottom of the trough that
are discarded, but some cells with less library complexity (farther left) and
higher percentage of mitochondrial reads (higher) – meaning they are worse in
both of our QC metrics – will be kept. To avoid this happening, the parameter
*enforce\_left\_cutoff* will identify the cell marked for removal with the lowest
mitochondrial percentage, determine its library complexity, and discard all
cells with both lower complexity and higher mitochondrial percentage:

```
plotFiltering(sce, model, posterior_cutoff = 0.6, enforce_left_cutoff = TRUE,
                keep_all_below_boundary = TRUE)
```

![](data:image/png;base64...)

This will make a de facto mitochondrial percentage cutoff for all cells with low
library complexity, but will be more permissive for cells with high library
complexity and high mitochondrial percentage, which are more likely to be intact
cells with a biological reason for high mitochondrial expression than their low
library complexity counterparts.

## 3.4 When not to use miQC

The miQC model is based on the assumption that there are a non-trivial number of
compromised cells in the dataset, which is not true in all datasets. We
recommend running *plotMetrics* on a dataset before running miQC to see if the
two-distribution model is appropriate. Look for the distinctive triangular shape
where cells have a wide variety of mitochondrial percentages at lower gene
counts and taper off to lower mitochondrial percentage at higher gene counts, as
can be seen in the Zeisel data.

For example of a dataset where there’s not a significant number of compromised
cells, so the two-distribution assumption is not met, look at another dataset
from the *scRNAseq* package, mouse data from Buettner et al
(Buettner et al. [2015](#ref-buettner_computational_2015)).

```
sce <- BuettnerESCData()
mt_genes <- grepl("^mt-", rowData(sce)$AssociatedGeneName)
feature_ctrls <- list(mito = rownames(sce)[mt_genes])
sce <- addPerCellQC(sce, subsets = feature_ctrls)

plotMetrics(sce)
```

![](data:image/png;base64...)

The *mixtureModel* function will throw a warning if only one distribution is
found, in which case no cells would be filtered. In these cases, we recommend
using other filtering methods, such as a cutoff on mitochondrial percentage or
identifying outliers using median absolute deviation (MAD).

# 4 Session Information

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] splines   stats4    stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] ensembldb_2.34.0            AnnotationFilter_1.34.0     GenomicFeatures_1.62.0      AnnotationDbi_1.72.0
##  [5] miQC_1.18.0                 flexmix_2.3-20              lattice_0.22-7              scater_1.38.0
##  [9] ggplot2_4.0.0               scuttle_1.20.0              scRNAseq_2.24.0             SingleCellExperiment_1.32.0
## [13] SummarizedExperiment_1.40.0 Biobase_2.70.0              GenomicRanges_1.62.0        Seqinfo_1.0.0
## [17] IRanges_2.44.0              S4Vectors_0.48.0            BiocGenerics_0.56.0         generics_0.1.4
## [21] MatrixGenerics_1.22.0       matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       jsonlite_2.0.0           magrittr_2.0.4           magick_2.9.0
##   [5] modeltools_0.2-24        ggbeeswarm_0.7.2         gypsum_1.6.0             farver_2.1.2
##   [9] rmarkdown_2.30           BiocIO_1.20.0            vctrs_0.6.5              memoise_2.0.1
##  [13] Rsamtools_2.26.0         RCurl_1.98-1.17          tinytex_0.57             htmltools_0.5.8.1
##  [17] S4Arrays_1.10.0          AnnotationHub_4.0.0      curl_7.0.0               BiocNeighbors_2.4.0
##  [21] Rhdf5lib_1.32.0          SparseArray_1.10.0       rhdf5_2.54.0             sass_0.4.10
##  [25] alabaster.base_1.10.0    bslib_0.9.0              alabaster.sce_1.10.0     httr2_1.2.1
##  [29] cachem_1.1.0             GenomicAlignments_1.46.0 lifecycle_1.0.4          pkgconfig_2.0.3
##  [33] rsvd_1.0.5               Matrix_1.7-4             R6_2.6.1                 fastmap_1.2.0
##  [37] digest_0.6.37            irlba_2.3.5.1            ExperimentHub_3.0.0      RSQLite_2.4.3
##  [41] beachmat_2.26.0          labeling_0.4.3           filelock_1.0.3           httr_1.4.7
##  [45] abind_1.4-8              compiler_4.5.1           bit64_4.6.0-1            withr_3.0.2
##  [49] S7_0.2.0                 BiocParallel_1.44.0      viridis_0.6.5            DBI_1.2.3
##  [53] HDF5Array_1.38.0         alabaster.ranges_1.10.0  alabaster.schemas_1.10.0 rappdirs_0.3.3
##  [57] DelayedArray_0.36.0      rjson_0.2.23             tools_4.5.1              vipor_0.4.7
##  [61] beeswarm_0.4.0           nnet_7.3-20              glue_1.8.0               h5mread_1.2.0
##  [65] restfulr_0.0.16          rhdf5filters_1.22.0      grid_4.5.1               gtable_0.3.6
##  [69] BiocSingular_1.26.0      ScaledMatrix_1.18.0      XVector_0.50.0           ggrepel_0.9.6
##  [73] BiocVersion_3.22.0       pillar_1.11.1            dplyr_1.1.4              BiocFileCache_3.0.0
##  [77] rtracklayer_1.70.0       bit_4.6.0                tidyselect_1.2.1         Biostrings_2.78.0
##  [81] knitr_1.50               gridExtra_2.3            bookdown_0.45            ProtGenerics_1.42.0
##  [85] xfun_0.54                UCSC.utils_1.6.0         lazyeval_0.2.2           yaml_2.3.10
##  [89] evaluate_1.0.5           codetools_0.2-20         cigarillo_1.0.0          tibble_3.3.0
##  [93] alabaster.matrix_1.10.0  BiocManager_1.30.26      cli_3.6.5                jquerylib_0.1.4
##  [97] dichromat_2.0-0.1        Rcpp_1.1.0               GenomeInfoDb_1.46.0      dbplyr_2.5.1
## [101] png_0.1-8                XML_3.99-0.19            parallel_4.5.1           blob_1.2.4
## [105] bitops_1.0-9             alabaster.se_1.10.0      viridisLite_0.4.2        scales_1.4.0
## [109] purrr_1.1.0              crayon_1.5.3             rlang_1.1.6              KEGGREST_1.50.0
```

# References

Buettner, Florian, Kedar N. Natarajan, F. Paolo Casale, Valentina Proserpio, Antonio Scialdone, Fabian J. Theis, Sarah A. Teichmann, John C. Marioni, and Oliver Stegle. 2015. “Computational Analysis of Cell-to-Cell Heterogeneity in Single-Cell RNA-Sequencing Data Reveals Hidden Subpopulations of Cells.” *Nature Biotechnology* 33 (2): 155–60. <https://doi.org/10.1038/nbt.3102>.

Hippen, Ariel A., Matias M. Falco, Lukas M. Weber, Erdogan Pekcan Erkan, Kaiyang Zhang, Jennifer Anne Doherty, Anna Vähärautio, Casey S. Greene, and Stephanie C. Hicks. 2021. “miQC: An Adaptive Probabilistic Framework for Quality Control of Single-Cell RNA-Sequencing Data.” *PLOS Computational Biology* 17 (8): e1009290. <https://doi.org/10.1371/journal.pcbi.1009290>.

Zeisel, Amit, Ana B. Muñoz-Manchado, Simone Codeluppi, Peter Lönnerberg, Gioele La Manno, Anna Juréus, Sueli Marques, et al. 2015. “Brain Structure. Cell Types in the Mouse Cortex and Hippocampus Revealed by Single-Cell RNA-Seq.” *Science (New York, N.Y.)* 347 (6226). <https://doi.org/10.1126/science.aaa1934>.
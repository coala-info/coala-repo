# shinyMethyl: interactive visualization of Illumina 450K methylation arrays

Jean-Philippe Fortin and Kasper Daniel Hansen

#### 2025-10-30

# 1 Introduction

Up to now, more than 10,000 methylation samples from the state-of-the-art
450K microarray have been made available through The Cancer Genome Atlas
portal (The Cancer Genome Atlas [2014](#ref-tcga)) and the Gene Expression Omnibus (GEO) (Edgar, Domrachev, and Lash [2002](#ref-Geo)).
Large-scale comparison studies, for instance between cancers or tissues,
become possible epigenome-widely. These large studies often require a
substantial amount of time spent on preprocessing the data and performing
quality control. For such studies, it is not rare to encounter significant
batch effects, and those can have a dramatic impact on the validity of the
biological results (Leek et al. [2010](#ref-batchreview)), (Harper, Peters, and Gamble [2013](#ref-Harper:2013)). With that in mind,
we developed `shinyMethyl` to make the preprocessing of large 450K
datasets intuitive, enjoyable and reproducible. `shinyMethyl`
is an interactive visualization tool for Illumina 450K methylation array
data based on the packages *[minfi](https://bioconductor.org/packages/3.22/minfi)* and
*[shiny](https://CRAN.R-project.org/package%3Dshiny)*.

A few mouse clicks allow the user to appreciate insightful
biological inter-array differences on a large scale. The goal of
`shinyMethyl` is two-fold: (1) summarize a high-dimensional 450K
array experiment into an exportable small-sized R object and (2)
launch an interactive visualization tool for quality control assessment
as well as exploration of global methylation patterns associated
with different phenotypes.

# 2 Example dataset

To take a quick look at how the interactive interface of
`shinyMethyl` works, we have included an example dataset in
the companion package *[shinyMethylData](https://bioconductor.org/packages/3.22/shinyMethylData)*.
The dataset contains the extracted data of 369 Head and Neck cancer
samples downloaded from The
Cancer Genome Atlas (TCGA) data portal (The Cancer Genome Atlas [2014](#ref-tcga)): 310 tumor samples,
50 matched normals and 9 replicates of a control cell line. The
first `shinyMethylSet` object (see Section 3 for the definition
of a `shinyMethylSet` object) was created from the raw data (no
normalization) and is stored under the name `summary.tcga.raw.rda`;
the second `shinyMethylSet` object was created from a
`GenomicRatioSet` containing the normalized data and the file is stored
under the name `summary.tcga.norm.rda`. The samples were normalized
using functional normalization, a preprocessing procedure that we recently
developed for heterogeneous methylation data (Fortin et al. [2014](#ref-funnorm)).

To launch `shinyMethyl` with this TCGA dataset, simply
type the following commands in a fresh R session:

```
library(shinyMethyl)
library(shinyMethylData)
runShinyMethyl(summary.tcga.raw, summary.tcga.norm)
```

The interactive interface will take a few seconds to be launched in
your default HTML browser.

# 3 Creating your own dataset visualization

In this section, we describe how to launch an interactive visualization for
your methylation dataset.

## 3.1 Step 1: creating a RGChannelSet object with minfi

An `RGChannelSet` is an object defined in `minfi` containing
the raw intensities of the green and red channels of your 450K experiment.
To create an `RGChannelSet`, you will need to have the raw files of
the experiment with extension .IDAT (we refer to those as .IDAT files).
In case you do not have these files, you might want to ask your collaborators
or your processing core if they have those. You absolutely need them to both
use the packages `minfi` and `shinyMethyl`. The vignette in
`minfi` describes carefully how to read the data in for different
scenarios and how to construct an `RGChannelSet`. Here, we show a
quick way to create an `RGChannelSet` from the .IDAT files
contained in the package `minfiData`.

```
library(minfi)
library(minfiData)
```

We need to tell R which directory contains the .IDAT files and the
experiment sheet:

```
baseDir <- system.file("extdata", package = "minfiData")
# baseDir <- "/home/yourDirectoryPath"
```

We also need to read in the experiment sheet:

```
targets <- read.450k.sheet(baseDir)
head(targets)
```

Finally, we construct the `RGChannelSet` using `read.450k.exp`:

```
RGSet <- read.450k.exp(base = baseDir, targets = targets)
```

The function `pData` in `minfi` allows to see the phenotype
data of the samples:

```
pd <- pData(RGSet)
head(pd)
```

## 3.2 Step 2: creating a shinyMethylSet object

From the `RGChannelSet` created in the
previous section, we create a `shinyMethylSet` by using the command
`shinySummarize`

```
myShinyMethylSet <- shinySummarize(RGSet)
```

This is a small object containing all of the necessary information
extracted from a RGChannelSet to launch shinyMethyl.

## 3.3 Step 3: launching the interactive shiny interface

To launch a `shinyMethyl` session, simply pass your
`shinyMethylSet` object to the `runShinyMethyl` function
as follows:

```
runShinyMethyl(myShinyMethylSet)
```

# 4 How to use the different panels

The different figures at the end of the vignette explain how to use each of the `shinyMethyl` panels.

# 5 Advanced option: visualization of normalized data

`shinyMethyl` also offers the possibility to visualize normalized
data that are stored in a `GenomicRatioSet` object. For instance,
suppose we normalize the data by using the quantile normalization algorithm
implemented in `minfi` (this function returns a `GenomicRatioSet`
object by default):

```
GRSet.norm <- preprocessQuantile(RGSet)
```

We can then create two separate `shinyMethylSet` objects corresponding
to the raw and normalized data respectively:

```
summary   <- shinySummarize(RGSset)
summary.norm <- shinySummarize(GRSet.norm)
```

To launch the `shinyMethyl` interface, use `runShinyMethyl` with
the first argument being the `shinyMethylSet` extracted from the raw data
and the second argument being the `shinyMethylSet` extracted from the
data as follows:

```
runShinyMethyl(summary, summary.norm)
```

# 6 What does a shinyMethylSet contain?

A `shinyMethylSet` object contains several summary data from a 450K
experiment: the names of the samples, a data frame for the phenotype, a
list of quantiles for the M and Beta values, a list of quantiles for the
methylated and unmethylated channels intensities and a list of quantiles
for the copy numbers, the green and red intensities of different control
probes, and the principal component analysis (PCA) results performed on the
Beta values. One can access the different summaries by using the slot
operator `@`. The slot names can be obtained with the function
`slotNames` as follows:

```
library(shinyMethyl)
library(shinyMethylData)
slotNames(summary.tcga.raw)
```

```
##  [1] "sampleNames"     "phenotype"       "mQuantiles"      "betaQuantiles"
##  [5] "methQuantiles"   "unmethQuantiles" "cnQuantiles"     "greenControls"
##  [9] "redControls"     "pca"             "originObject"    "array"
```

For instance, one can retrieve the phenotype by

```
head(summary.tcga.raw@phenotype)
```

```
##                   gender caseControlStatus  plate position
## 5775446049_R01C01   MALE            Normal 577544   R01C01
## 5775446049_R01C02 FEMALE            Normal 577544   R01C02
## 5775446049_R02C01   MALE             Tumor 577544   R02C01
## 5775446049_R02C02   MALE             Tumor 577544   R02C02
## 5775446049_R03C01   MALE             Tumor 577544   R03C01
## 5775446049_R03C02 FEMALE             Tumor 577544   R03C02
```

`shinyMethyl` also contain different accessor functions to
access the slots. Please see the manual for more information.

# 7 Figures

## 7.1 Quality control figure

This is an example of interactive visualization and quality control assessment.
The three plots react simultaneously to the user mouse clicks and selected
samples are represented in black. In this scenario, colors represent batch,
but colors can be chosen to reflect the phenotype of the samples as well via
the left-hand-side panel. The three different plots are: A) Plot of the quality
controls probes reacting to the left-hand-side panel; the current plot shows
the bisulfite conversion probes intensities. B) Quality control plot as
implemented in `minfi`: the median intensity of the M channel against the
median intensity of the U channel. Samples with bad quality would cluster
away from the cloud shown in the current plot. For this dataset, all samples
look good. C) Densities of the methylation intensities (can be chosen to be
Beta-values or M-values, and can be chosen by probe type). The current plot
shows the M-value densities for Infinium I probes, for the raw data.
The dashed and solid lines in black correspond to the two samples selected
by the user and match to the dots circled in black in the left-hand plots.
The left-hand-side panel allows users to select different tuning parameters
for the plots, as well as different phenotypes for the colors. The user can
click on the samples that seem to have low quality, and can download the
names of the samples in a csv file for further analysis
(not shown in the screenshot).}

![](data:image/png;base64...)

## 7.2 Array design panel

The plot represents the physical slides (6 x 2 samples) on which the samples
were assayed in the machine. The user can select the phenotype to color
the samples. This plot allows to explore the quality of the randomization
of the samples for a given phenotype.

![](data:image/png;base64...)

## 7.3 Sex prediction algorithm panel

The difference of the median copy number intensity for the Y chromosome and
the median copy number intensity for the X chromosome can be used to separate
males and females. In A), the user can select the vertical cutoff (dashed line)
manually with the mouse to separate the two clusters (orange for females,
blue for males). Corresponding Beta-value densities appear in B) for further
validation. The predicted sex can be downloaded in a csv file in C), and
samples for which the predicted sex differs from the sex provided in the
phenotype will appear in D).

![](data:image/png;base64...)

## 7.4 Principal Component Analysis (PCA)

Users can select the principal components to visualize (PC1 and PC2 are shown
in the current plot) and can choose the phenotype for the coloring.
In the present plot, one can observe that the first two principal
components distinguish tumor samples from normal samples for the TCGA
example dataset (see example dataset section).

![](data:image/png;base64...)

## 7.5 Type I/II probe bias

The distributional differences between the Type I and Type II probes can be
observed for each sample (selected by the user).

![](data:image/png;base64...)

## 7.6 Comparison of raw and normalized data

As discussed in the Advanced option, normalized data can be added as well
to the visualization interface. In the present plot, the top plot at the
right shows the raw densities while the bottom plot shows the densities
after functional normalization (Fortin et al. [2014](#ref-funnorm)).

![](data:image/png;base64...)

## 7.7 Visualization of batch effects in the TCGA HNSCC dataset

In the first two plots are shown the densities of the M-values for Type I green
probes before and after functional normalization (Fortin et al. [2014](#ref-funnorm)).
Each curve represents one sample and different colors represent different
batches. The last two plots show the average density for each plate
before and after normalization. One can observe that functional
normalization removed significantly global batch effects.

![](data:image/jpeg;base64...)

## 7.8 Visualization of cancer/normal differences in the TCGA HNSCC dataset

In the first two plots are shown the densities of the M-values for Type I
green probes before (a) and after (b) functional normalization (Fortin et al. [2014](#ref-funnorm)).
Green and blue densities represent tumor and normal samples respectively, and
red densities represent 9 technical replicates of a control cell line.
The last two plots show the average density for each sample group before
and after normalization. Functional normalization preserves the expected
marginal differences between normal and cancer, while reducing the
variation between the technical controls (red lines).

![](data:image/jpeg;base64...)

# 8 Session info

Here is the output of `sessionInfo` on the system on which
this document was compiled:

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] shinyMethylData_1.29.0
##  [2] shinyMethyl_1.46.0
##  [3] minfiData_0.55.0
##  [4] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
##  [5] IlluminaHumanMethylation450kmanifest_0.4.0
##  [6] minfi_1.56.0
##  [7] bumphunter_1.52.0
##  [8] locfit_1.5-9.12
##  [9] iterators_1.0.14
## [10] foreach_1.5.2
## [11] Biostrings_2.78.0
## [12] XVector_0.50.0
## [13] SummarizedExperiment_1.40.0
## [14] Biobase_2.70.0
## [15] MatrixGenerics_1.22.0
## [16] matrixStats_1.5.0
## [17] GenomicRanges_1.62.0
## [18] Seqinfo_1.0.0
## [19] IRanges_2.44.0
## [20] S4Vectors_0.48.0
## [21] BiocGenerics_0.56.0
## [22] generics_0.1.4
## [23] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] magrittr_2.0.4            GenomicFeatures_1.62.0
##   [5] rmarkdown_2.30            BiocIO_1.20.0
##   [7] vctrs_0.6.5               multtest_2.66.0
##   [9] memoise_2.0.1             Rsamtools_2.26.0
##  [11] DelayedMatrixStats_1.32.0 RCurl_1.98-1.17
##  [13] askpass_1.2.1             htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0           curl_7.0.0
##  [17] Rhdf5lib_1.32.0           SparseArray_1.10.0
##  [19] rhdf5_2.54.0              sass_0.4.10
##  [21] nor1mix_1.3-3             bslib_0.9.0
##  [23] plyr_1.8.9                cachem_1.1.0
##  [25] GenomicAlignments_1.46.0  mime_0.13
##  [27] lifecycle_1.0.4           pkgconfig_2.0.3
##  [29] Matrix_1.7-4              R6_2.6.1
##  [31] fastmap_1.2.0             shiny_1.11.1
##  [33] digest_0.6.37             siggenes_1.84.0
##  [35] reshape_0.8.10            AnnotationDbi_1.72.0
##  [37] RSQLite_2.4.3             base64_2.0.2
##  [39] httr_1.4.7                abind_1.4-8
##  [41] compiler_4.5.1            beanplot_1.3.1
##  [43] rngtools_1.5.2            bit64_4.6.0-1
##  [45] BiocParallel_1.44.0       DBI_1.2.3
##  [47] HDF5Array_1.38.0          MASS_7.3-65
##  [49] openssl_2.3.4             DelayedArray_0.36.0
##  [51] rjson_0.2.23              tools_4.5.1
##  [53] otel_0.2.0                rentrez_1.2.4
##  [55] httpuv_1.6.16             glue_1.8.0
##  [57] quadprog_1.5-8            h5mread_1.2.0
##  [59] restfulr_0.0.16           nlme_3.1-168
##  [61] rhdf5filters_1.22.0       promises_1.4.0
##  [63] grid_4.5.1                tzdb_0.5.0
##  [65] preprocessCore_1.72.0     tidyr_1.3.1
##  [67] data.table_1.17.8         hms_1.1.4
##  [69] xml2_1.4.1                pillar_1.11.1
##  [71] limma_3.66.0              genefilter_1.92.0
##  [73] later_1.4.4               splines_4.5.1
##  [75] dplyr_1.1.4               lattice_0.22-7
##  [77] survival_3.8-3            rtracklayer_1.70.0
##  [79] bit_4.6.0                 GEOquery_2.78.0
##  [81] annotate_1.88.0           tidyselect_1.2.1
##  [83] knitr_1.50                bookdown_0.45
##  [85] xfun_0.53                 scrime_1.3.5
##  [87] statmod_1.5.1             yaml_2.3.10
##  [89] evaluate_1.0.5            codetools_0.2-20
##  [91] cigarillo_1.0.0           tibble_3.3.0
##  [93] BiocManager_1.30.26       cli_3.6.5
##  [95] xtable_1.8-4              jquerylib_0.1.4
##  [97] Rcpp_1.1.0                png_0.1-8
##  [99] XML_3.99-0.19             readr_2.1.5
## [101] blob_1.2.4                mclust_6.1.1
## [103] doRNG_1.8.6.2             sparseMatrixStats_1.22.0
## [105] bitops_1.0-9              illuminaio_0.52.0
## [107] purrr_1.1.0               crayon_1.5.3
## [109] rlang_1.1.6               KEGGREST_1.50.0
```

# References

Edgar, R., M. Domrachev, and A. E. Lash. 2002. “Gene Expression Omnibus: NCBI gene expression and hybridization array data repository.” *Nucleic Acids Res.* 30 (1): 207–10.

Fortin, Jean-Philippe, Aurelie Labbe, Mathieu Lemire, Brent W. Zanke, Thomas J. Hudson, Elana J. Fertig, Celia M. T. Greenwood, and Kasper D. Hansen. 2014. “Functional Normalization of 450k Methylation Array Data Improves Replication in Large Cancer Studies.” *Genome Biology* 15 (11): 503. <https://doi.org/10.1186/s13059-014-0503-2>.

Harper, Kristin N, Brandilyn A Peters, and Mary V Gamble. 2013. “Batch Effects and Pathway Analysis: Two Potential Perils in Cancer Studies Involving Dna Methylation Array Analysis.” *Cancer Epidemiol Biomarkers Prev* 22 (6): 1052–60. <https://doi.org/10.1158/1055-9965.EPI-13-0114>.

Leek, Jeffrey T, Robert B Scharpf, Héctor Corrada Bravo, David Simcha, Benjamin Langmead, W Evan Johnson, Donald Geman, Keith Baggerly, and Rafael A Irizarry. 2010. “Tackling the widespread and critical impact of batch effects in high-throughput data.” *Nature Reviews Genetics* 11 (10): 733–39. <https://doi.org/10.1038/nrg2825>.

The Cancer Genome Atlas. 2014. *Data Portal*. <https://tcga-data.nci.nih.gov/tcga/>.
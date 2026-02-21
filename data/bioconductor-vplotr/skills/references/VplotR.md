# VplotR

#### Jacques Serizay

#### 2025-10-30

* [Introduction](#introduction)
  + [Overview](#overview)
  + [Installation](#installation)
* [Importing sequencing datasets](#importing-sequencing-datasets)
  + [Using `importPEBamFiles()` function](#using-importpebamfiles-function)
  + [Provided datasets](#provided-datasets)
* [Fragment size distribution](#fragment-size-distribution)
* [Vplot(s)](#vplots)
  + [Single Vplot](#single-vplot)
  + [Multiple Vplots](#multiple-vplots)
  + [Vplots normalization](#vplots-normalization)
* [Footprints](#footprints)
* [Local fragment distribution](#local-fragment-distribution)
* [Session Info](#session-info)

## Introduction

### Overview

VplotR is an R package streamlining the process of generating V-plots, i.e. two-dimensional paired-end fragment density plots. It contains functions to import paired-end sequencing bam files from any type of DNA accessibility experiments (e.g. ATAC-seq, DNA-seq, MNase-seq) and can produce V-plots and one-dimensional footprint profiles over single or aggregated genomic loci of interest. The R package is well integrated within the Bioconductor environment and easily fits in standard genomic analysis workflows. Integrating V-plots into existing analytical frameworks has already brought additional insights in chromatin organization (Serizay et al., 2020).

The main user-level functions of VplotR are `getFragmentsDistribution()`, `plotVmat()`, `plotFootprint()` and `plotProfile()`.

* `getFragmentsDistribution()` computes the distribution of fragment sizes over sets of genomic ranges;
* `plotVmat()` is used to compute fragment density and generate V-plots;
* `plotFootprint()` generates the MNase-seq or ATAC-seq footprint at a set of genomic ranges.
* `plotProfile()` is used to plot the distribution of paired-end fragments at a single locus of interest.

### Installation

VplotR can be installed from Bioconductor:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
BiocManager::install("VplotR")
library("VplotR")
```

## Importing sequencing datasets

### Using `importPEBamFiles()` function

Paired-end .bam files are imported using the `importPEBamFiles()` function as follows:

```
library(VplotR)
bamfile <- system.file("extdata", "ex1.bam", package = "Rsamtools")
fragments <- importPEBamFiles(
    bamfile,
    shift_ATAC_fragments = TRUE
)
#> > Importing /home/biocbuild/bbs-3.22-bioc/R/site-library/Rsamtools/extdata/ex1.bam ...
#> > Filtering /home/biocbuild/bbs-3.22-bioc/R/site-library/Rsamtools/extdata/ex1.bam ...
#> > Shifting /home/biocbuild/bbs-3.22-bioc/R/site-library/Rsamtools/extdata/ex1.bam ...
#> > /home/biocbuild/bbs-3.22-bioc/R/site-library/Rsamtools/extdata/ex1.bam import completed.
fragments
#> GRanges object with 1572 ranges and 0 metadata columns:
#>          seqnames    ranges strand
#>             <Rle> <IRanges>  <Rle>
#>      [1]     seq1    41-215      +
#>      [2]     seq1    54-255      +
#>      [3]     seq1    56-258      +
#>      [4]     seq1    65-255      +
#>      [5]     seq1    65-265      +
#>      ...      ...       ...    ...
#>   [1568]     seq2 1326-1542      -
#>   [1569]     seq2 1336-1544      -
#>   [1570]     seq2 1358-1550      -
#>   [1571]     seq2 1380-1557      -
#>   [1572]     seq2 1353-1562      -
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

### Provided datasets

Several datasets are available for this package:

* Sets of tissue-specific ATAC-seq experiments in young adult C. elegans (Serizay et al., 2020):

```
data(ce11_proms)
ce11_proms
#> GRanges object with 17458 ranges and 3 metadata columns:
#>           seqnames            ranges strand |   TSS.fwd   TSS.rev which.tissues
#>              <Rle>         <IRanges>  <Rle> | <numeric> <numeric>      <factor>
#>       [1]     chrI       11273-11423      + |     11294     11416       Intest.
#>       [2]     chrI       11273-11423      - |     11294     11416       Intest.
#>       [3]     chrI       26903-27053      - |     27038     26901       Ubiq.
#>       [4]     chrI       36019-36169      - |     36112     36028       Intest.
#>       [5]     chrI       42127-42277      - |     42216     42119       Soma
#>       ...      ...               ...    ... .       ...       ...           ...
#>   [17454]     chrX 17670496-17670646      + |  17670678  17670478  Muscle
#>   [17455]     chrX 17684894-17685044      - |  17684919  17684932  Hypod.
#>   [17456]     chrX 17686030-17686180      - |  17686189  17686064  Unclassified
#>   [17457]     chrX 17694789-17694939      + |  17694962  17694934  Intest.
#>   [17458]     chrX 17711839-17711989      - |  17711974  17711854  Germline
#>   -------
#>   seqinfo: 6 sequences from an unspecified genome; no seqlengths
data(ATAC_ce11_Serizay2020)
ATAC_ce11_Serizay2020
#> $Germline
#> GRanges object with 462371 ranges and 0 metadata columns:
#>            seqnames            ranges strand
#>               <Rle>         <IRanges>  <Rle>
#>        [1]     chrI           426-514      +
#>        [2]     chrI         3588-3854      +
#>        [3]     chrI         3640-3798      +
#>        [4]     chrI         3650-3694      +
#>        [5]     chrI         3732-3863      +
#>        ...      ...               ...    ...
#>   [462367]     chrX 17712277-17712469      -
#>   [462368]     chrX 17712279-17712342      -
#>   [462369]     chrX 17712282-17712565      -
#>   [462370]     chrX 17712285-17712384      -
#>   [462371]     chrX 17712287-17712576      -
#>   -------
#>   seqinfo: 7 sequences from an unspecified genome; no seqlengths
#>
#> $Neurons
#> GRanges object with 367935 ranges and 0 metadata columns:
#>            seqnames            ranges strand
#>               <Rle>         <IRanges>  <Rle>
#>        [1]     chrI         4011-4241      +
#>        [2]     chrI         7397-7614      +
#>        [3]     chrI       11279-11502      +
#>        [4]     chrI       12744-12819      +
#>        [5]     chrI       14381-14433      +
#>        ...      ...               ...    ...
#>   [367931]     chrX 17687948-17687982      -
#>   [367932]     chrX 17699614-17699853      -
#>   [367933]     chrX 17706798-17706923      -
#>   [367934]     chrX 17708264-17708347      -
#>   [367935]     chrX 17709920-17710007      -
#>   -------
#>   seqinfo: 7 sequences from an unspecified genome; no seqlengths
```

* MNase-seq experiment in yeast (Henikoff et al., 2011) and ABF1 binding sites:

```
data(ABF1_sacCer3)
ABF1_sacCer3
#> GRanges object with 567 ranges and 2 metadata columns:
#>         seqnames          ranges strand |  relScore       ID
#>            <Rle>       <IRanges>  <Rle> | <numeric>    <Rle>
#>     [1]    chrIV   392624-392639      + |  0.979866 MA0265.1
#>     [2]    chrIV 1196424-1196439      + |  0.979866 MA0265.1
#>     [3]   chrXIV   400687-400702      + |  0.979866 MA0265.1
#>     [4]    chrII   216540-216555      - |  0.978608 MA0265.1
#>     [5]   chrXVI     95317-95332      - |  0.974833 MA0265.1
#>     ...      ...             ...    ... .       ...      ...
#>   [563]    chrIV 1402786-1402801      + |  0.900182 MA0265.1
#>   [564]     chrX   545320-545335      + |  0.900182 MA0265.1
#>   [565]    chrXI   571301-571316      - |  0.900182 MA0265.1
#>   [566]   chrXIV   140631-140646      - |  0.900182 MA0265.1
#>   [567]   chrXVI   919179-919194      - |  0.900182 MA0265.1
#>   -------
#>   seqinfo: 17 sequences from an unspecified genome; no seqlengths
data(MNase_sacCer3_Henikoff2011)
MNase_sacCer3_Henikoff2011
#> GRanges object with 400000 ranges and 0 metadata columns:
#>            seqnames        ranges strand
#>               <Rle>     <IRanges>  <Rle>
#>        [1]     chrI         2-116      +
#>        [2]     chrI         14-66      +
#>        [3]     chrI        15-134      +
#>        [4]     chrI        54-167      +
#>        [5]     chrI        66-104      +
#>        ...      ...           ...    ...
#>   [399996]   chrXVI 920439-920471      -
#>   [399997]   chrXVI 920439-920486      -
#>   [399998]   chrXVI 920439-920528      -
#>   [399999]   chrXVI 920442-920659      -
#>   [400000]   chrXVI 920454-920683      -
#>   -------
#>   seqinfo: 17 sequences from an unspecified genome
```

## Fragment size distribution

A preliminary control to check the distribution of fragment sizes (regardless of their location relative to genomic loci) can be performed using the `getFragmentsDistribution()` function.

```
df <- getFragmentsDistribution(
    MNase_sacCer3_Henikoff2011,
    ABF1_sacCer3
)
#> Warning in as.cls(x): NAs introduced by coercion
#> Warning in as.cls(x): NAs introduced by coercion
#> Warning in as.cls(x): NAs introduced by coercion
p <- ggplot(df, aes(x = x, y = y)) + geom_line() + theme_ggplot2()
#> Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the VplotR package.
#>   Please report the issue at <https://github.com/js2264/VplotR/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the VplotR package.
#>   Please report the issue at <https://github.com/js2264/VplotR/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
p
#> Warning: Removed 2 rows containing missing values or values outside the scale range
#> (`geom_line()`).
```

![](data:image/png;base64...)

## Vplot(s)

### Single Vplot

Once data is imported, a V-plot of paired-end fragments over loci of interest is generated using the `plotVmat()` function:

```
p <- plotVmat(x = MNase_sacCer3_Henikoff2011, granges = ABF1_sacCer3)
#> Computing V-mat
#> Normalizing the matrix
#> No normalization applied
#> Smoothing the matrix
p
```

![](data:image/png;base64...)

### Multiple Vplots

The generation of multiple V-plots can be parallelized using a list of parameters:

```
list_params <- list(
    "MNase\n@ ABF1" = list(MNase_sacCer3_Henikoff2011, ABF1_sacCer3),
    "MNase\n@ random loci" = list(
        MNase_sacCer3_Henikoff2011, sampleGRanges(ABF1_sacCer3)
    )
)
p <- plotVmat(
    list_params,
    cores = 1
)
#> - Processing sample 1/2
#> - Processing sample 2/2
p
```

![](data:image/png;base64...)

For instance, ATAC-seq fragment density can be visualized at different classes of ubiquitous and tissue-specific promoters in *C. elegans*.

```
list_params <- list(
    "Germline ATACseq\n@ Ubiq. proms" = list(
        ATAC_ce11_Serizay2020[['Germline']],
        ce11_proms[ce11_proms$which.tissues == 'Ubiq.']
    ),
    "Germline ATACseq\n@ Germline proms" = list(
        ATAC_ce11_Serizay2020[['Germline']],
        ce11_proms[ce11_proms$which.tissues == 'Germline']
    ),
    "Neuron ATACseq\n@ Ubiq. proms" = list(
        ATAC_ce11_Serizay2020[['Neurons']],
        ce11_proms[ce11_proms$which.tissues == 'Ubiq.']
    ),
    "Neuron ATACseq\n@ Neuron proms" = list(
        ATAC_ce11_Serizay2020[['Neurons']],
        ce11_proms[ce11_proms$which.tissues == 'Neurons']
    )
)
p <- plotVmat(
    list_params,
    cores = 1,
    nrow = 2, ncol = 5
)
#> - Processing sample 1/4
#> - Processing sample 2/4
#> - Processing sample 3/4
#> - Processing sample 4/4
p
```

![](data:image/png;base64...)

### Vplots normalization

Different normalization approaches are available using the `normFun` argument.

* Un-normalized raw counts can be plotted by specifying `normFun = 'none'`.

```
# No normalization
p <- plotVmat(
    list_params,
    cores = 1,
    nrow = 2, ncol = 5,
    verbose = FALSE,
    normFun = 'none'
)
#> Computing V-mat
#> Normalizing the matrix
#> No normalization applied
#> Smoothing the matrix
#> Computing V-mat
#> Normalizing the matrix
#> No normalization applied
#> Smoothing the matrix
#> Computing V-mat
#> Normalizing the matrix
#> No normalization applied
#> Smoothing the matrix
#> Computing V-mat
#> Normalizing the matrix
#> No normalization applied
#> Smoothing the matrix
p
```

![](data:image/png;base64...)

* By default, plots are normalized by the library depth of the sequencing run and by the number of loci used to compute fragment density.

```
# Library depth + number of loci of interest (default)
p <- plotVmat(
    list_params,
    cores = 1,
    nrow = 2, ncol = 5,
    verbose = FALSE,
    normFun = 'libdepth+nloci'
)
#> Computing V-mat
#> Normalizing the matrix
#> Computing raw library depth
#> Dividing Vmat by its number of loci
#> Smoothing the matrix
#> Computing V-mat
#> Normalizing the matrix
#> Computing raw library depth
#> Dividing Vmat by its number of loci
#> Smoothing the matrix
#> Computing V-mat
#> Normalizing the matrix
#> Computing raw library depth
#> Dividing Vmat by its number of loci
#> Smoothing the matrix
#> Computing V-mat
#> Normalizing the matrix
#> Computing raw library depth
#> Dividing Vmat by its number of loci
#> Smoothing the matrix
p
```

![](data:image/png;base64...)

* Alternatively, heatmaps can be internally z-scored or scaled to a specific quantile.

```
# Zscore
p <- plotVmat(
    list_params,
    cores = 1,
    nrow = 2, ncol = 5,
    verbose = FALSE,
    normFun = 'zscore'
)
#> Computing V-mat
#> Normalizing the matrix
#> Smoothing the matrix
#> Computing V-mat
#> Normalizing the matrix
#> Smoothing the matrix
#> Computing V-mat
#> Normalizing the matrix
#> Smoothing the matrix
#> Computing V-mat
#> Normalizing the matrix
#> Smoothing the matrix
p
```

![](data:image/png;base64...)

```
# Quantile
p <- plotVmat(
    list_params,
    cores = 1,
    nrow = 2, ncol = 5,
    verbose = FALSE,
    normFun = 'quantile',
    s = 0.99
)
#> Computing V-mat
#> Normalizing the matrix
#> Smoothing the matrix
#> Computing V-mat
#> Normalizing the matrix
#> Smoothing the matrix
#> Computing V-mat
#> Normalizing the matrix
#> Smoothing the matrix
#> Computing V-mat
#> Normalizing the matrix
#> Smoothing the matrix
p
```

![](data:image/png;base64...)

## Footprints

VplotR also implements a function to profile the footprint from MNase or ATAC-seq over sets of genomic loci. For instance, CTCF is known for its ~40-bp large footprint at its binding loci.

```
p <- plotFootprint(
    MNase_sacCer3_Henikoff2011,
    ABF1_sacCer3
)
#> - Getting cuts
#> - Getting cut coverage
#> - Getting cut coverage / target
#> - Reformatting data into matrix
#> - Plotting footprint
#> Warning in fortify(data, ...): Arguments in `...` must be used.
#> ✖ Problematic arguments:
#> • col = "black"
#> • fill = "black"
#> ℹ Did you misspell an argument name?
p
```

![](data:image/png;base64...)

## Local fragment distribution

VplotR provides a function to plot the distribution of paired-end fragments over an individual genomic window.

```
data(MNase_sacCer3_Henikoff2011_subset)
genes_sacCer3 <- GenomicFeatures::genes(TxDb.Scerevisiae.UCSC.sacCer3.sgdGene::
    TxDb.Scerevisiae.UCSC.sacCer3.sgdGene
)
p <- plotProfile(
    fragments = MNase_sacCer3_Henikoff2011_subset,
    window = "chrXV:186,400-187,400",
    loci = ABF1_sacCer3,
    annots = genes_sacCer3,
    min = 20, max = 200, alpha = 0.1, size = 1.5
)
#> Filtering and resizing fragments
#> 32276 fragments mapped over 1001 bases
#> Filtering and resizing fragments
#> Generating plot
#> Warning: Removed 49 rows containing missing values or values outside the scale range
#> (`geom_line()`).
#> Warning: Removed 5176 rows containing missing values or values outside the scale range
#> (`geom_point()`).
#> Warning: Removed 19 rows containing missing values or values outside the scale range
#> (`geom_line()`).
p
```

![](data:image/png;base64...)

## Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#> [1] VplotR_1.20.0        ggplot2_4.0.0        GenomicRanges_1.62.0
#> [4] Seqinfo_1.0.0        IRanges_2.44.0       S4Vectors_0.48.0
#> [7] BiocGenerics_0.56.0  generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1
#>  [2] dplyr_1.1.4
#>  [3] farver_2.1.2
#>  [4] blob_1.2.4
#>  [5] Biostrings_2.78.0
#>  [6] S7_0.2.0
#>  [7] bitops_1.0-9
#>  [8] fastmap_1.2.0
#>  [9] RCurl_1.98-1.17
#> [10] GenomicAlignments_1.46.0
#> [11] XML_3.99-0.19
#> [12] digest_0.6.37
#> [13] lifecycle_1.0.4
#> [14] TxDb.Scerevisiae.UCSC.sacCer3.sgdGene_3.2.2
#> [15] KEGGREST_1.50.0
#> [16] RSQLite_2.4.3
#> [17] magrittr_2.0.4
#> [18] compiler_4.5.1
#> [19] rlang_1.1.6
#> [20] sass_0.4.10
#> [21] tools_4.5.1
#> [22] yaml_2.3.10
#> [23] rtracklayer_1.70.0
#> [24] knitr_1.50
#> [25] S4Arrays_1.10.0
#> [26] labeling_0.4.3
#> [27] bit_4.6.0
#> [28] curl_7.0.0
#> [29] DelayedArray_0.36.0
#> [30] plyr_1.8.9
#> [31] RColorBrewer_1.1-3
#> [32] abind_1.4-8
#> [33] BiocParallel_1.44.0
#> [34] withr_3.0.2
#> [35] grid_4.5.1
#> [36] scales_1.4.0
#> [37] dichromat_2.0-0.1
#> [38] SummarizedExperiment_1.40.0
#> [39] cli_3.6.5
#> [40] rmarkdown_2.30
#> [41] crayon_1.5.3
#> [42] httr_1.4.7
#> [43] reshape2_1.4.4
#> [44] rjson_0.2.23
#> [45] DBI_1.2.3
#> [46] cachem_1.1.0
#> [47] stringr_1.5.2
#> [48] parallel_4.5.1
#> [49] AnnotationDbi_1.72.0
#> [50] XVector_0.50.0
#> [51] restfulr_0.0.16
#> [52] matrixStats_1.5.0
#> [53] vctrs_0.6.5
#> [54] Matrix_1.7-4
#> [55] jsonlite_2.0.0
#> [56] bit64_4.6.0-1
#> [57] GenomicFeatures_1.62.0
#> [58] jquerylib_0.1.4
#> [59] glue_1.8.0
#> [60] codetools_0.2-20
#> [61] cowplot_1.2.0
#> [62] stringi_1.8.7
#> [63] gtable_0.3.6
#> [64] GenomeInfoDb_1.46.0
#> [65] BiocIO_1.20.0
#> [66] UCSC.utils_1.6.0
#> [67] tibble_3.3.0
#> [68] pillar_1.11.1
#> [69] htmltools_0.5.8.1
#> [70] R6_2.6.1
#> [71] evaluate_1.0.5
#> [72] lattice_0.22-7
#> [73] Biobase_2.70.0
#> [74] png_0.1-8
#> [75] Rsamtools_2.26.0
#> [76] cigarillo_1.0.0
#> [77] memoise_2.0.1
#> [78] bslib_0.9.0
#> [79] Rcpp_1.1.0
#> [80] SparseArray_1.10.0
#> [81] xfun_0.53
#> [82] MatrixGenerics_1.22.0
#> [83] zoo_1.8-14
#> [84] pkgconfig_2.0.3
```
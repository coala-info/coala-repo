# ChIPexoQual: A quality control pipeline for ChIP-exo/nexus data.

| Rene Welch and Sündüz Keleş
| Department of Statistics, University of Wisconsin-Madison

#### 29 October 2025

# Contents

* [1 Overview](#overview)
* [2 Creating an **ExoData** object](#creating-an-exodata-object)
  + [2.1 Enrichment analysis and library complexity:](#enrichment-analysis-and-library-complexity)
  + [2.2 Strand imbalance](#strand-imbalance)
    - [2.2.1 Further exploration of ChIP-exo data](#further-exploration-of-chip-exo-data)
  + [2.3 Quality evaluation](#quality-evaluation)
  + [2.4 Subsampling reads from the experiment to asses quality](#subsampling-reads-from-the-experiment-to-asses-quality)
* [3 Conclusions](#conclusions)
* [4 SessionInfo](#sessioninfo)
* [References](#references)

# 1 Overview

In this vignette, we provide a brief overview of the *[ChIPexoQual](https://bioconductor.org/packages/3.22/ChIPexoQual)* package. This package provides a statistical quality control (QC) pipeline that enables the exploration and analysis of ChIP-exo/nexus experiments. In this vignette we used the reads aligned to **chr1** in the mouse liver ChIP-exo experiment (Serandour et al. [2013](#ref-exoillumina)) to illustrate the use of the pipeline. To load the packages we use:

```
    library(ChIPexoQual)
    library(ChIPexoQualExample)
```

*[ChIPexoQual](https://bioconductor.org/packages/3.22/ChIPexoQual)* takes a set of aligned reads from a ChIP-exo (or ChIP-nexus) experiment as input and performs the following steps:

1. Identify read islands, i.e., overlapping clusters of reads separated by gaps, from read coverage.
2. Compute \(D\_i\), number of reads in island \(i\), and \(U\_i\), number of island \(i\) positions with at least one aligning read, \(i=1, \cdots, I\).
   * For each island \(i\), \(i=1, \cdots, I\) compute island statistics:
     \[
     \begin{align\*}
     \mbox{ARC}\_i &= \frac{D\_i}{W\_i}, \quad \mbox{URC}\_i = \frac{U\_i}{D\_i}, \\
     %\mbox{URC}\_i &= \frac{U\_i}{D\_i}, \\
     \mbox{FSR}\_i &= \frac{(\text{Number of forward strand reads aligning to
     island $i$})}{D\_i},
     \end{align\*}
     \]where \(W\_i\) denotes the width of island \(i\),.
3. Generate diagnostic plots (i) URC vs. ARC plot; (ii) Region Composition plot; (iii) FSR distribution plot.
4. Randomly sample \(M\) (at least 1000) islands and fit,
   \[
   \begin{align\*}
   D\_i = \beta\_1 U\_i + \beta\_2 W\_i + \varepsilon\_i,
   \end{align\*}
   \]
   where \(\varepsilon\_i\) denotes the independent error term. Repeat this process \(B\) times and generate box plots of estimated \(\beta\_1\) and \(\beta\_2\).

We analyzed a larger collection of ChIP-exo/nexus experiments in (Welch et al. [2016](#ref-qcpipeline)) including complete versions of this samples.

# 2 Creating an **ExoData** object

The minimum input to use *[ChIPexoQual](https://bioconductor.org/packages/3.22/ChIPexoQual)* are the aligned reads of a ChIP-exo/nexus experiment. *[ChIPexoQual](https://bioconductor.org/packages/3.22/ChIPexoQual)* accepts either the name of the bam file or the reads in a *GAlignments* object:

```
    files = list.files(system.file("extdata",
        package = "ChIPexoQualExample"),full.names = TRUE)
    basename(files[1])
```

```
## [1] "ChIPexo_carroll_FoxA1_mouse_rep1_chr1.bam"
```

```
    ex1 = ExoData(file = files[1],mc.cores = 2L,verbose = FALSE)
    ex1
```

```
## ExoData object with 655785 ranges and 11 metadata columns:
##            seqnames              ranges strand |  fwdReads  revReads    fwdPos
##               <Rle>           <IRanges>  <Rle> | <integer> <integer> <integer>
##        [1]     chr1     3000941-3000976      * |         2         0         1
##        [2]     chr1     3001457-3001492      * |         0         1         0
##        [3]     chr1     3001583-3001618      * |         0         2         0
##        [4]     chr1     3001647-3001682      * |         1         0         1
##        [5]     chr1     3001852-3001887      * |         1         0         1
##        ...      ...                 ...    ... .       ...       ...       ...
##   [655781]     chr1 197192012-197192047      * |         0         1         0
##   [655782]     chr1 197192421-197192456      * |         0         1         0
##   [655783]     chr1 197193059-197193094      * |         1         0         1
##   [655784]     chr1 197193694-197193729      * |         0         3         0
##   [655785]     chr1 197194986-197195021      * |         0         2         0
##               revPos     depth uniquePos       ARC       URC       FSR
##            <integer> <integer> <integer> <numeric> <numeric> <numeric>
##        [1]         0         2         1 0.0555556       0.5         1
##        [2]         1         1         1 0.0277778       1.0         0
##        [3]         1         2         1 0.0555556       0.5         0
##        [4]         0         1         1 0.0277778       1.0         1
##        [5]         0         1         1 0.0277778       1.0         1
##        ...       ...       ...       ...       ...       ...       ...
##   [655781]         1         1         1 0.0277778  1.000000         0
##   [655782]         1         1         1 0.0277778  1.000000         0
##   [655783]         0         1         1 0.0277778  1.000000         1
##   [655784]         1         3         1 0.0833333  0.333333         0
##   [655785]         1         2         1 0.0555556  0.500000         0
##                    M         A
##            <numeric> <numeric>
##        [1]      -Inf       Inf
##        [2]      -Inf      -Inf
##        [3]      -Inf      -Inf
##        [4]      -Inf       Inf
##        [5]      -Inf       Inf
##        ...       ...       ...
##   [655781]      -Inf      -Inf
##   [655782]      -Inf      -Inf
##   [655783]      -Inf       Inf
##   [655784]      -Inf      -Inf
##   [655785]      -Inf      -Inf
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
    reads = readGAlignments(files[1],param = NULL)
    ex2 = ExoData(reads = reads,mc.cores = 2L,verbose = FALSE)
    identical(GRanges(ex1),GRanges(ex2))
```

```
## [1] FALSE
```

For the rest of the vignette, we generate an **ExoData** object for each replicate:

```
    files = files[grep("bai",files,invert = TRUE)] ## ignore index files
    exampleExoData = lapply(files,ExoData,mc.cores = 2L,verbose = FALSE)
```

Finally, we can recover the number of reads that compose a **ExoData** object by using the **nreads** function:

```
    sapply(exampleExoData,nreads)
```

```
## [1] 1654985 1766665 1670117
```

## 2.1 Enrichment analysis and library complexity:

To create the *ARC vs URC plot* proposed in (Welch et al. [2016](#ref-qcpipeline)), we use the **ARC\_URC\_plot** function. This function allows to visually compare different samples:

```
    ARCvURCplot(exampleExoData,names.input = paste("Rep",1:3,sep = "-"))
```

![](data:image/png;base64...)

This plot typically exhibits one of the following three patterns for any given sample. In all three panels we can observe two arms: the first with low **Average Read Coefficient (ARC)** and varying **Unique Read Coefficient (URC)**; and the second where the **URC** decreases as the **ARC** increases. The first and third replicates exhibit a defined decreasing trend in URC as the ARC increases. This indicates that these samples exhibit a higher ChIP enrichment than the second replicate. On the other hand, the overall URC level from the first two replicates is higher than that of the third replicate, elucidating that the libraries for the first two replicates are more complex than that of the third replicate.

## 2.2 Strand imbalance

To create the *FSR distribution* and *Region Composition* plots suggested in Welch et. al 2016 (submitted), we use the **FSR\_dist\_plot** and **region\_comp\_plot**, respectively.

```
    p1 = regionCompplot(exampleExoData,names.input = paste("Rep",1:3,
        sep = "-"),depth.values = seq_len(50))
    p2 = FSRDistplot(exampleExoData,names.input = paste("Rep",1:3,sep = "-"),
        quantiles = c(.25,.5,.75),depth.values = seq_len(100))
    gridExtra::grid.arrange(p1,p2,nrow = 1)
```

![](data:image/png;base64...)

The left panel displays the *Region Composition plot* and the right panel shows the *Forward Strand Ratio (FSR) distribution plot*, both of which highlight specific problems with replicates 2 and 3. The *Region Composition plot* exhibits apparent decreasing trends in the proportions of regions formed by fragments in one exclusive strand. High quality experiments tend to show exponential decay in the proportion of single stranded regions, while for the lower quality experiments, the trend may be linear or even constant. The FSR distributions of both of replicates 2 and 3 are more spread around their respective medians. The rate at which the FSR distribution becomes more centralized around the median indicates the aforementioned lower enrichment in the second replicate and the low complexity in the third one. The asymmetric behavior of the second replicate is characteristic of low enrichment, while the constant values of replicate three for low minimum number of reads indicate that this replicate has islands composed of reads aligned to very few unique positions.

### 2.2.1 Further exploration of ChIP-exo data

All the plot functions in *[ChIPexoQual](https://bioconductor.org/packages/3.22/ChIPexoQual)* allow a list or several separate **ExoData** objects. This allows to explore island subsets for each replicate. For example, to show that the first arm is composed of regions formed by reads aligned to few positions, we can generate the following plot:

```
    ARCvURCplot(exampleExoData[[1]],
                 subset(exampleExoData[[1]],uniquePos > 10),
                 subset(exampleExoData[[1]],uniquePos > 20),
                 names.input = c("All", "uniquePos > 10", "uniquePos > 20"))
```

![](data:image/png;base64...)

For this figure, we used the *ARC vs URC* plot to show how several of the regions with low **ARC** values are composed by reads that align to a small number of unique positions. This technique highlights a strategy that can be followed to further explore the data, as with all the previously listed plotting functions we may compare different subsets of the islands in the partition.

## 2.3 Quality evaluation

The last step of the quality control pipeline is to evaluate the linear model:

\[
\begin{align\*}
D\_i = \beta\_1 U\_i + \beta\_2 U\_2 + \epsilon\_i,
\end{align\*}
\]

The distribution of the parameters of this model is built by sampling **nregions** regions (the default value is 1,000), fitting the model and repeating the process **ntimes** (the default value is 100). We visualize the distributions of the parameters with box-plots:

```
    p1 = paramDistBoxplot(exampleExoData,which.param = "beta1", names.input = paste("Rep",1:3,sep = "-"))
    p2 = paramDistBoxplot(exampleExoData,which.param = "beta2", names.input = paste("Rep",1:3,sep = "-"))
    gridExtra::grid.arrange(p1,p2,nrow = 1)
```

![](data:image/png;base64...)

Further details over this analysis are in Welch et. al 2016 (submitted). In short, when the ChIP-exo/nexus sample is not deeply sequenced, high values of \(\hat{\beta}\_1\) indicate that the library complexity is low. In contrast, lower values correspond to higher quality ChIP-exo experiments. We concluded that samples with estimated \(\hat{\beta\_1} \leq 10\) seem to be high quality samples. Similarly, samples with estimated \(\hat{\beta\_2} \approx 0\) can be considered as high quality samples. The estimated values for these parameters can be accessed with the **beta1**, **beta2**, and **param\_dist** methods. For example, using the **median** to summarize these parameter distributions, we conclude that these three replicates (in **chr1**) are high quality samples:

```
    sapply(exampleExoData,function(x)median(beta1(x)))
```

```
## [1] 1.883964 1.539396 8.015361
```

```
    sapply(exampleExoData,function(x)median(-beta2(x)))
```

```
## [1] 0.01696937 0.01031599 0.04622042
```

## 2.4 Subsampling reads from the experiment to asses quality

The behavior of the third’s FoxA1 replicate may be an indication of problems in the sample. However, it is also common to observe that pattern in deeply sequenced experiments. For convenience, we added the function `ExoDataSubsampling`, that performs the analysis suggested by Welch et. al 2016 (submitted) when the experiment is deeply sequenced. To use this function, we proceed as follows:

```
    sample.depth = seq(1e5,2e5,5e4)
    exoList = ExoDataSubsampling(file = files[3],sample.depth = sample.depth, verbose=FALSE)
```

The output of `ExoDataSubsampling` is a list of `ExoData` objects, therefore its output can be used with any of the plotting functions to asses the quality of the samples. For example, using we may use `paramDistBoxplot` to get the following figures:

```
    p1 = paramDistBoxplot(exoList,which.param = "beta1")
    p2 = paramDistBoxplot(exoList,which.param = "beta2")
    gridExtra::grid.arrange(p1,p2,nrow = 1)
```

![](data:image/png;base64...)

Clearly there are increasing trends in both plots, and since we are only using the reads in chromosome 1, we are observing fewer reads than in a typical ChIP-exo/nexus experiment. In a higher quality experiment it is expected to show lower \(\hat{\beta}\_1\) and \(\hat{\beta}\_2\) levels. Additionally, the rate at which the estimated \(\hat{\beta}\_2\) parameter increases is going to be higher in a lower quality experiment.

# 3 Conclusions

We presented a systematic exploration of a ChIP-exo experiment and show how to use the QC pipeline provided in *[ChIPexoQual](https://bioconductor.org/packages/3.22/ChIPexoQual)*. ChIPexoQual takes aligned reads as input and automatically generates several diagnostic plots and summary measures that enable assessing enrichment and library complexity. The implications of the diagnostic plots and the summary measures align well with more elaborate analysis that is computationally more expensive to perform and/or requires additional imputes that often may not be available.

# 4 SessionInfo

```
sessionInfo("ChIPexoQual")
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
## character(0)
##
## other attached packages:
## [1] ChIPexoQual_1.34.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   bitops_1.0-9
##   [3] gridExtra_2.3               rlang_1.1.6
##   [5] magrittr_2.0.4              biovizBase_1.58.0
##   [7] matrixStats_1.5.0           compiler_4.5.1
##   [9] RSQLite_2.4.3               GenomicFeatures_1.62.0
##  [11] png_0.1-8                   vctrs_0.6.5
##  [13] ProtGenerics_1.42.0         stringr_1.5.2
##  [15] pkgconfig_2.0.3             crayon_1.5.3
##  [17] fastmap_1.2.0               magick_2.9.0
##  [19] backports_1.5.0             XVector_0.50.0
##  [21] labeling_0.4.3              Rsamtools_2.26.0
##  [23] rmarkdown_2.30              grDevices_4.5.1
##  [25] UCSC.utils_1.6.0            tinytex_0.57
##  [27] purrr_1.1.0                 bit_4.6.0
##  [29] xfun_0.53                   cachem_1.1.0
##  [31] cigarillo_1.0.0             graphics_4.5.1
##  [33] GenomeInfoDb_1.46.0         jsonlite_2.0.0
##  [35] blob_1.2.4                  DelayedArray_0.36.0
##  [37] BiocParallel_1.44.0         broom_1.0.10
##  [39] parallel_4.5.1              cluster_2.1.8.1
##  [41] VariantAnnotation_1.56.0    R6_2.6.1
##  [43] bslib_0.9.0                 stringi_1.8.7
##  [45] RColorBrewer_1.1-3          rtracklayer_1.70.0
##  [47] rpart_4.1.24                GenomicRanges_1.62.0
##  [49] jquerylib_0.1.4             Rcpp_1.1.0
##  [51] Seqinfo_1.0.0               bookdown_0.45
##  [53] SummarizedExperiment_1.40.0 knitr_1.50
##  [55] base64enc_0.1-3             IRanges_2.44.0
##  [57] Matrix_1.7-4                nnet_7.3-20
##  [59] tidyselect_1.2.1            viridis_0.6.5
##  [61] rstudioapi_0.17.1           dichromat_2.0-0.1
##  [63] abind_1.4-8                 yaml_2.3.10
##  [65] codetools_0.2-20            curl_7.0.0
##  [67] lattice_0.22-7              tibble_3.3.0
##  [69] withr_3.0.2                 Biobase_2.70.0
##  [71] KEGGREST_1.50.0             S7_0.2.0
##  [73] evaluate_1.0.5              foreign_0.8-90
##  [75] base_4.5.1                  Biostrings_2.78.0
##  [77] pillar_1.11.1               BiocManager_1.30.26
##  [79] MatrixGenerics_1.22.0       checkmate_2.3.3
##  [81] stats4_4.5.1                generics_0.1.4
##  [83] RCurl_1.98-1.17             ensembldb_2.34.0
##  [85] S4Vectors_0.48.0            ggplot2_4.0.0
##  [87] scales_1.4.0                BiocStyle_2.38.0
##  [89] stats_4.5.1                 glue_1.8.0
##  [91] Hmisc_5.2-4                 lazyeval_0.2.2
##  [93] ChIPexoQualExample_1.33.0   tools_4.5.1
##  [95] datasets_4.5.1              hexbin_1.28.5
##  [97] BiocIO_1.20.0               data.table_1.17.8
##  [99] BSgenome_1.78.0             GenomicAlignments_1.46.0
## [101] XML_3.99-0.19               grid_4.5.1
## [103] utils_4.5.1                 tidyr_1.3.1
## [105] methods_4.5.1               AnnotationDbi_1.72.0
## [107] colorspace_2.1-2            htmlTable_2.4.3
## [109] restfulr_0.0.16             Formula_1.2-5
## [111] cli_3.6.5                   viridisLite_0.4.2
## [113] S4Arrays_1.10.0             dplyr_1.1.4
## [115] AnnotationFilter_1.34.0     gtable_0.3.6
## [117] sass_0.4.10                 digest_0.6.37
## [119] BiocGenerics_0.56.0         SparseArray_1.10.0
## [121] rjson_0.2.23                htmlwidgets_1.6.4
## [123] farver_2.1.2                memoise_2.0.1
## [125] htmltools_0.5.8.1           lifecycle_1.0.4
## [127] httr_1.4.7                  bit64_4.6.0-1
```

# References

Serandour, Aurelien, Brown Gordon, Joshua Cohen, and Jason Carroll. 2013. “Development of and Illumina-Based ChIP-Exonuclease Method Provides Insight into FoxA1-DNA Binding Properties.” *Genome Biology*.

Welch, Rene, Dongjun Chung, Jeffrey Grass, Robert Landick, and Sündüz Keleş. 2016. “Data Exploration, Quality Control, and Statistical Analysis of ChIP-Exo/Nexus Experiments.” *Submitted*.
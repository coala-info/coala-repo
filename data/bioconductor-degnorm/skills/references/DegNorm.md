# DegNorm: an R package for degradation normalization for RNA-seq data

#### Bin Xiong, Ji-Ping Wang

#### 2025-10-29

* [What is DegNorm?](#what-is-degnorm)
* [DegNorm pipline available formats](#degnorm-pipline-available-formats)
* [DegNorm version 1.3.4 updates](#degnorm-version-1.3.4-updates)
* [Install DegNorm R package](#install-degnorm-r-package)
* [DegNorm main features](#degnorm-main-features)
  + [1. Compute coverage score based on alignment .bam files](#compute-coverage-score-based-on-alignment-.bam-files)
  + [2. DegNorm core algorithm](#degnorm-core-algorithm)
  + [3. Plot functions in DegNorm](#plot-functions-in-degnorm)
* [Session info](#session-info)

**Maintainer**: Ji-Ping Wang, <jzwang@northwestern.edu>

**Reference**: Xiong, B., Yang, Y., Fineis, F. Wang, J.-P., DegNorm: normalization of generalized transcript degradation improves accuracy in RNA-seq analysis, Genome Biology, 2019,20:75

## What is DegNorm?

DegNorm, short for **Deg**radation **Norm**alization, is a bioinformatics pipeline designed to correct for bias due to the heterogeneous patterns of transcript degradation in RNA-seq data. DegNorm helps improve the accuracy of the differential expression analysis by accounting for this degradation.

In practice, RNA samples are often more-or-less degraded, and the degradation severity is not only sample-specific, but gene-specific as well. It is known that longer genes tend to degrade faster than shorter ones. As such, commonplace global degradation normalization approaches that impose a single normalization factor on all genes within a sample can be ineffective in correcting for RNA degradation bias.

## DegNorm pipline available formats

We’ve developed an R package and an indepedent Python package ([download](https://nustatbioinfo.github.io/DegNorm/)), both of which allow to run the entire pipeline from the RNA-seq alignment (.bam) files. **For most-updated version, we recommend to use R package from bioconductor**.

## DegNorm version 1.3.4 updates

In version 1.3.1, we made following updates: 1. In `plot_coverage` funciton, an `samples` options is provided to allow user to select which samples to plot for coverage curves. 2. We fixed a bug in `DegNorm` funciton. In earlier version, we used genes with maximum `rho<0.1` from initial SVD to determine the scaling factor before running core algorithm. For some data with many samples and large degradation, it may return `NA` to cause issues.

## Install DegNorm R package

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DegNorm")
```

## DegNorm main features

DegNorm R package contains two major functions: (1) processing the RNA-seq alignment file (.bam) to calculate the coverage; and (2) using a core algorithm written in RcppArmadillo to perform rank-one over-approximation on converage matrices for each gene to estimate the degramation index (DI) score for each gene within each sample.

DegNorm outputs DI scores together with degradation-normalized read counts (based on DI scores). It also provides supplementary functions for visualization of degradation at both gene and sample level. The following diagram illustrates the flow of DegNorm pipeline.

![](data:image/png;base64...)

A diagram of DegNorm.

The following vignette is intended to provide example codes for running DegNorm R package. It presumes that you have successfully installed DegNorm package. We illustrate below how to: 1) calculate the read coverage curves for all genes within all samples, and 2) perform degradation normalization on coverage curves. Either step is computing intensive. Dependent upon the number of samples and the sequencing depth, the total computing time may last a few hours. DegNorm utilizes the parallel computing functionality of R and automatically detects the number of cores on your computer to run jobs in parallel. Due to the large size of bam file and limited computing power of personal computer, we recommend users to run it in servers or computing clusters.

### 1. Compute coverage score based on alignment .bam files

##### Set up input file: .bam and .gtf files.

```
## specify bam_files from RNA-seq, you should replace it by your own bam files
bam_file_list=list.files(path=system.file("extdata",package="DegNorm"),
                        pattern=".bam$",full.names=TRUE)
```

The three bam files were subsetted from a specific region of chorosome 21 from the origianl bam for package size limitation. Original files can be found from the included reference above.

```
## gtf_file you used for RNA-seq alignment, replace it by your own gtf file
gtf_file=list.files(path=system.file("extdata",package="DegNorm"),
                    pattern=".gtf$",full.names=TRUE)
```

##### Run main function to create read coverage matrix and read counts

```
## calculate the read coverage score for all genes of all samples
coverage_res_chr21_sub=read_coverage_batch(bam_file_list, gtf_file,cores=2)
#> Parse gtf file...done
#> Index SRR873822_chr21_9900000-10000000.bam
#> Computing coverage for SRR873822_chr21_9900000-10000000.bam ...
#>    SRR873822_chr21_9900000-10000000.bam is a paired-end bam file
#> SRR873822_chr21_9900000-10000000.bam is done!
#>
#> Index SRR873834_chr21_9900000-10000000.bam
#> Computing coverage for SRR873834_chr21_9900000-10000000.bam ...
#>    SRR873834_chr21_9900000-10000000.bam is a paired-end bam file
#> SRR873834_chr21_9900000-10000000.bam is done!
#>
#> Index SRR873838_chr21_9900000-10000000.bam
#> Computing coverage for SRR873838_chr21_9900000-10000000.bam ...
#>    SRR873838_chr21_9900000-10000000.bam is a paired-end bam file
#> SRR873838_chr21_9900000-10000000.bam is done!
```

`cores` argument specifies the number of cores to use. Users should try to use as many as possible cores to maximize the computing efficiency.

```
## save the coverage results
save(coverage_res_chr21_sub,file="coverage_res_chr21_sub.Rda")
```

Function `read_coverage_batch` returns the coverage matrices as a list, one per gene, and a dataframe for read counts, each row for one gene and each column for one sample.

```
data("coverage_res_chr21")
## summarize the coverage results
summary_CoverageClass(coverage_res_chr21)
#> CoverageClass from read_coverage_batch function
#> $coverage    : list of length 339
#> $counts  : data.frame of dimension 339 by 3
#>
#> Samples:      SRR873822_chr21.bam SRR873834_chr21.bam SRR873838_chr21.bam
#> Total number genes:   339
```

```
## extract coverage scores and counts from coverage_res
coverage_matrix=coverage_res_chr21$coverage
counts=coverage_res_chr21$counts
```

### 2. DegNorm core algorithm

Run degnorm core algorithm for degradation normalization. DegNorm purpose is for differential expression analysis. Thus genes with extremely low read counts from all samples are filtered out. The current filtering criterion is that if more than half of the samples have less than 5 read count, that gene will not be considered in the degnorm algorithm. In the following example, I am using downsamling to save time below (default). Alternatively you can set down\_sampling = 0, which takes longer time. If `down_samplin= 1`, read coverage scores are binned with size by `grid_size` for baseline selection to achieve better efficiency. The default `grid_size` is 10 bp. We recommend to use a `grid_size` less than 50 bp. `iteration` specifies the big loop in DegNorm algorithm and 5 is usually sufficient. `loop` specifies the iteration number in the matrix factorization over-approximation.

```
res_DegNorm_chr21 = degnorm(read_coverage = coverage_res_chr21[[1]],
                    counts = coverage_res_chr21[[2]],
                    iteration = 5,
                    down_sampling = 1,
                    grid_size=10,
                    loop = 100,
                    cores=2)
#> Filtering out genes with low read counts (x<5)..
#> Initial estimation of count normalization factors...
#> Initial degradation normalization without base-line selection...
#> DegNorm core algorithm starts...
#>    DegNorm iteration 1
#>    DegNorm iteration 2
#>    DegNorm iteration 3
#>    DegNorm iteration 4
#>    DegNorm iteration 5
#> DegNorm core algorithm done!
```

If `down_sampling= 0`, then the argument `grid_size` is ignored.

```
## save the DegNorm results
save(res_DegNorm_chr21,file="res_DegNorm_chr21.Rda")
```

Function `degnorm` returns a list of multiple objects. counts\_normed is the one with degradation normalized read counts for you to input DeSeq or EdgeR for DE analysis.

```
data("res_DegNorm_chr21")
```

```
## summary of the DegNorm output
summary_DegNormClass(res_DegNorm_chr21)
#> DegNormClass from DegNorm function:
#> $counts  : data.frame of dimension 132 by 3
#> $counts_normed   : data.frame of dimension 132 by 3
#> $DI      : matrix array of dimension 132 by 3
#> $K       : matrix array of dimension 132 by 3
#> $convergence     : integer of length 132
#> $envelop     : list of length 132
#>
#> Samples:      SRR873822_chr21.bam SRR873834_chr21.bam SRR873838_chr21.bam
#> Total number genes:   132
```

The difference of number of genes between `res_DegNorm` and `coverage_res` is 207 (339-132). The 207 genes were filtered out from `degnorm` degradation normalization because less than half of the samples (3) have more than 5 read count.

```
## extrac normalized read counts
counts_normed=res_DegNorm_chr21$counts_normed
```

### 3. Plot functions in DegNorm

DegNorm provides four plot functions for visualization of degradation and sample quality diagnosis.

* plot\_coverage
* plot\_corr
* plot\_heatmap
* plot\_boxplot

##### – Plot the before-/after-degradation coverage curves

```
##gene named "SOD1"
plot_coverage(gene_name="SOD1", coverage_output=coverage_res_chr21,
            degnorm_output=res_DegNorm_chr21,group=c(0,1,1))
```

![](data:image/png;base64...)

In version 1.3.1, a new argument \(samples\) was added so the user can specifiy which samples to plot.

```
##gene named "SOD1"
plot_coverage(gene_name="SOD1", coverage_output=coverage_res_chr21,
            degnorm_output=res_DegNorm_chr21,group=c(0,1),
            samples=c("SRR873822_chr21.bam", "SRR873834_chr21.bam"))
```

![](data:image/png;base64...)

##### – Boxplot of the degradation index(DI) scores

```
plot_boxplot(DI=res_DegNorm_chr21$DI)
```

![](data:image/png;base64...)

##### – Heatmap plot of the degradation index(DI) scores

```
plot_heatmap(DI=res_DegNorm_chr21$DI)
```

##### – Correlation matrix plot of degradation index(DI) scores

```
plot_corr(DI=res_DegNorm_chr21$DI)
```

## Session info

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] knitr_1.50     DegNorm_1.20.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3                   bitops_1.0-9
#>   [3] gridExtra_2.3               httr2_1.2.1
#>   [5] biomaRt_2.66.0              rlang_1.1.6
#>   [7] magrittr_2.0.4              matrixStats_1.5.0
#>   [9] compiler_4.5.1              RSQLite_2.4.3
#>  [11] GenomicFeatures_1.62.0      reshape2_1.4.4
#>  [13] png_0.1-8                   vctrs_0.6.5
#>  [15] txdbmaker_1.6.0             stringr_1.5.2
#>  [17] pkgconfig_2.0.3             crayon_1.5.3
#>  [19] fastmap_1.2.0               dbplyr_2.5.1
#>  [21] XVector_0.50.0              labeling_0.4.3
#>  [23] ca_0.71.1                   Rsamtools_2.26.0
#>  [25] rmarkdown_2.30              UCSC.utils_1.6.0
#>  [27] purrr_1.1.0                 bit_4.6.0
#>  [29] xfun_0.53                   cachem_1.1.0
#>  [31] cigarillo_1.0.0             GenomeInfoDb_1.46.0
#>  [33] jsonlite_2.0.0              progress_1.2.3
#>  [35] blob_1.2.4                  DelayedArray_0.36.0
#>  [37] BiocParallel_1.44.0         parallel_4.5.1
#>  [39] prettyunits_1.2.0           R6_2.6.1
#>  [41] bslib_0.9.0                 stringi_1.8.7
#>  [43] RColorBrewer_1.1-3          rtracklayer_1.70.0
#>  [45] GenomicRanges_1.62.0        jquerylib_0.1.4
#>  [47] iterators_1.0.14            Rcpp_1.1.0
#>  [49] Seqinfo_1.0.0               assertthat_0.2.1
#>  [51] SummarizedExperiment_1.40.0 IRanges_2.44.0
#>  [53] Matrix_1.7-4                tidyselect_1.2.1
#>  [55] dichromat_2.0-0.1           abind_1.4-8
#>  [57] yaml_2.3.10                 viridis_0.6.5
#>  [59] TSP_1.2-5                   doParallel_1.0.17
#>  [61] codetools_0.2-20            curl_7.0.0
#>  [63] plyr_1.8.9                  lattice_0.22-7
#>  [65] tibble_3.3.0                withr_3.0.2
#>  [67] Biobase_2.70.0              KEGGREST_1.50.0
#>  [69] S7_0.2.0                    evaluate_1.0.5
#>  [71] heatmaply_1.6.0             BiocFileCache_3.0.0
#>  [73] Biostrings_2.78.0           pillar_1.11.1
#>  [75] filelock_1.0.3              MatrixGenerics_1.22.0
#>  [77] foreach_1.5.2               stats4_4.5.1
#>  [79] plotly_4.11.0               generics_0.1.4
#>  [81] RCurl_1.98-1.17             S4Vectors_0.48.0
#>  [83] hms_1.1.4                   ggplot2_4.0.0
#>  [85] scales_1.4.0                glue_1.8.0
#>  [87] lazyeval_0.2.2              tools_4.5.1
#>  [89] dendextend_1.19.1           BiocIO_1.20.0
#>  [91] data.table_1.17.8           webshot_0.5.5
#>  [93] GenomicAlignments_1.46.0    registry_0.5-1
#>  [95] XML_3.99-0.19               grid_4.5.1
#>  [97] tidyr_1.3.1                 crosstalk_1.2.2
#>  [99] seriation_1.5.8             AnnotationDbi_1.72.0
#> [101] restfulr_0.0.16             cli_3.6.5
#> [103] rappdirs_0.3.3              S4Arrays_1.10.0
#> [105] viridisLite_0.4.2           dplyr_1.1.4
#> [107] gtable_0.3.6                sass_0.4.10
#> [109] digest_0.6.37               BiocGenerics_0.56.0
#> [111] SparseArray_1.10.0          rjson_0.2.23
#> [113] htmlwidgets_1.6.4           farver_2.1.2
#> [115] memoise_2.0.1               htmltools_0.5.8.1
#> [117] lifecycle_1.0.4             httr_1.4.7
#> [119] bit64_4.6.0-1
```
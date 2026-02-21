# HighlyReplicatedRNASeq

Constantin Ahlmann-Eltze

#### 2025-11-04

The *[HighlyReplicatedRNASeq](https://bioconductor.org/packages/3.22/HighlyReplicatedRNASeq)* package provides functions to access the count matrix from bulk RNA-seq studies with many replicates. For example,the study from Schurch et al. (2016) has data on 86 samples of S. *cerevisiae* in two conditions.

# 1 Load Data

To load the dataset, call the `Schurch16()` function. It returns a *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*:

```
schurch_se <- HighlyReplicatedRNASeq::Schurch16()
#> see ?HighlyReplicatedRNASeq and browseVignettes('HighlyReplicatedRNASeq') for documentation
#> loading from cache
#> see ?HighlyReplicatedRNASeq and browseVignettes('HighlyReplicatedRNASeq') for documentation
#> loading from cache

schurch_se
#> class: SummarizedExperiment
#> dim: 7126 86
#> metadata(0):
#> assays(1): counts
#> rownames(7126): 15S_rRNA 21S_rRNA ... tY(GUA)O tY(GUA)Q
#> rowData names(0):
#> colnames(86): wildtype_01 wildtype_02 ... knockout_47 knockout_48
#> colData names(4): file_name condition replicate name
```

An alternative approach that achieves exactly the same is to load the data
directly from ExperimentHub

```
library(ExperimentHub)
eh <- ExperimentHub()
records <- query(eh, "HighlyReplicatedRNASeq")
records[1]           ## display the metadata for the first resource
#> ExperimentHub with 1 record
#> # snapshotDate(): 2025-10-29
#> # names(): EH3315
#> # package(): HighlyReplicatedRNASeq
#> # $dataprovider: Geoff Barton's group on GitHub
#> # $species: Saccharomyces cerevisiae BY4741
#> # $rdataclass: matrix
#> # $rdatadateadded: 2020-04-03
#> # $title: Schurch S. cerevesiae Highly Replicated Bulk RNA-Seq Counts
#> # $description: Count matrix for bulk RNA-sequencing dataset from 86 S. cere...
#> # $taxonomyid: 1247190
#> # $genome: Ensembl release 68
#> # $sourcetype: tar.gz
#> # $sourceurl: https://github.com/bartongroup/profDGE48
#> # $sourcesize: NA
#> # $tags: c("ExperimentHub", "ExperimentData", "ExpressionData",
#> #   "SequencingData", "RNASeqData")
#> # retrieve record with 'object[["EH3315"]]'
count_matrix <- records[["EH3315"]]  ## load the count matrix by ID
#> see ?HighlyReplicatedRNASeq and browseVignettes('HighlyReplicatedRNASeq') for documentation
#> loading from cache
count_matrix[1:10, 1:5]
#>          wildtype_01 wildtype_02 wildtype_03 wildtype_04 wildtype_05
#> 15S_rRNA           2          12          31           8          21
#> 21S_rRNA          20          76         101          99         128
#> HRA1               3           2           2           2           3
#> ICR1              75         123         107         157          98
#> LSR1              60         163         233         163         193
#> NME1              13          14          23          13          29
#> PWR1               0           0           0           0           0
#> Q0010              0           0           0           0           0
#> Q0017              0           0           0           0           0
#> Q0032              0           0           0           0           0
```

# 2 Explore Data

It has 7126 genes and 86 samples. The counts are between 0 and 467,000.

```
summary(c(assay(schurch_se, "counts")))
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>       0      89     386    1229     924  467550
```

To make the data easier to work with, I will “normalize” the data. First I divide it by the mean of each sample to account for the differential sequencing depth. Then, I apply the `log()` transformation and add a small number to avoid taking the logarithm of 0.

```
norm_counts <- assay(schurch_se, "counts")
norm_counts <- log(norm_counts / colMeans(norm_counts) + 0.001)
```

The histogram of the transformed data looks very smooth:

```
hist(norm_counts, breaks = 100)
```

![](data:image/png;base64...)

Finally, let us take a look at the MA-plot of the data and the volcano plot:

```
wt_mean <- rowMeans(norm_counts[, schurch_se$condition == "wildtype"])
ko_mean <- rowMeans(norm_counts[, schurch_se$condition == "knockout"])

plot((wt_mean+ ko_mean) / 2, wt_mean - ko_mean,
     pch = 16, cex = 0.4, col = "#00000050", frame.plot = FALSE)
abline(h = 0)
```

![](data:image/png;base64...)

```
pvalues <- sapply(seq_len(nrow(norm_counts)), function(idx){
  tryCatch(
    t.test(norm_counts[idx, schurch_se$condition == "wildtype"],
         norm_counts[idx, schurch_se$condition == "knockout"])$p.value,
  error = function(err) NA)
})

plot(wt_mean - ko_mean, - log10(pvalues),
     pch = 16, cex = 0.5, col = "#00000050", frame.plot = FALSE)
```

![](data:image/png;base64...)

# 3 Reference

* Schurch, N. J., Schofield, P., Gierliński, M., Cole, C., Sherstnev, A., Singh, V., … Barton, G. J. (2016). How many biological replicates are needed in an RNA-seq experiment and which differential expression tool should you use? Rna, 22(6), 839–851. <https://doi.org/10.1261/rna.053959.115>

# 4 Session Info

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
#>  [1] HighlyReplicatedRNASeq_1.22.0 ExperimentHub_3.0.0
#>  [3] AnnotationHub_4.0.0           BiocFileCache_3.0.0
#>  [5] dbplyr_2.5.1                  SummarizedExperiment_1.40.0
#>  [7] Biobase_2.70.0                GenomicRanges_1.62.0
#>  [9] Seqinfo_1.0.0                 IRanges_2.44.0
#> [11] S4Vectors_0.48.0              BiocGenerics_0.56.0
#> [13] generics_0.1.4                MatrixGenerics_1.22.0
#> [15] matrixStats_1.5.0             BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0      xfun_0.54            bslib_0.9.0
#>  [4] httr2_1.2.1          lattice_0.22-7       vctrs_0.6.5
#>  [7] tools_4.5.1          curl_7.0.0           tibble_3.3.0
#> [10] AnnotationDbi_1.72.0 RSQLite_2.4.3        blob_1.2.4
#> [13] pkgconfig_2.0.3      Matrix_1.7-4         lifecycle_1.0.4
#> [16] compiler_4.5.1       Biostrings_2.78.0    tinytex_0.57
#> [19] htmltools_0.5.8.1    sass_0.4.10          yaml_2.3.10
#> [22] pillar_1.11.1        crayon_1.5.3         jquerylib_0.1.4
#> [25] DelayedArray_0.36.0  cachem_1.1.0         magick_2.9.0
#> [28] abind_1.4-8          tidyselect_1.2.1     digest_0.6.37
#> [31] purrr_1.1.0          dplyr_1.1.4          bookdown_0.45
#> [34] BiocVersion_3.22.0   grid_4.5.1           fastmap_1.2.0
#> [37] SparseArray_1.10.1   cli_3.6.5            magrittr_2.0.4
#> [40] S4Arrays_1.10.0      withr_3.0.2          filelock_1.0.3
#> [43] rappdirs_0.3.3       bit64_4.6.0-1        rmarkdown_2.30
#> [46] XVector_0.50.0       httr_1.4.7           bit_4.6.0
#> [49] png_0.1-8            memoise_2.0.1        evaluate_1.0.5
#> [52] knitr_1.50           rlang_1.1.6          Rcpp_1.1.0
#> [55] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.26
#> [58] jsonlite_2.0.0       R6_2.6.1
```
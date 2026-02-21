# RNA-seq data with different levels of gDNA contamination

Robert Castelo1\*

1Dept. of Medicine and Life Sciences, Universitat Pompeu Fabra, Barcelona, Spain

\*robert.castelo@upf.edu

#### 4 November 2025

#### Abstract

The gDNAinRNAseqData package provides access through the ExperimentHub, to RNA-seq BAM files containing different levels of genomic DNA (gDNA) contamination. This vignette illustrates how to download them.

#### Package

gDNAinRNAseqData 1.10.0

# 1 Retrieval of the gDNA contaminated RNA-seq data by Li et al. (2022)

Here we show how to download a subset of the RNA-seq data published in:

> Li, X., Zhang, P., and Yu. Y. Gene expressed at low levels raise false
> discovery rates in RNA samples contaminated with genomic DNA. *BMC Genomics*,
> 23:554, 2022. <https://doi.org/10.1186/s12864-022-08785-1>

The subset of the data available through this package are BAM files containing
about 100,000 alignments, sampled uniformly at random from complete BAM files.
These complete BAM files were obtained by aligning the RNA-seq reads sequenced
from total RNA libraries mixed with different concentrations of gDNA,
concretely 0% (no contamination), 1% and 10%; see Fig. 2 from Li et al. (2022).
The original RNA-seq data is publicly available at
<https://ngdc.cncb.ac.cn/bioproject/browse/PRJCA007961> and you can find the
pipeline to generate this subset of the data in the file
`gDNAinRNAseqData/inst/scripts/make-data_LiYu22subsetBAMfiles.R` stored in this
package.

To download these subsetted BAM files, and the corresponding index (.bai) files,
we load this package and call the function `LiYu22subsetBAMfiles()`:

```
library(gDNAinRNAseqData)

bamfiles <- LiYu22subsetBAMfiles()
bamfiles
```

```
## [1] "/tmp/RtmpKBGwuO/s32gDNA0.bam"  "/tmp/RtmpKBGwuO/s33gDNA0.bam"
## [3] "/tmp/RtmpKBGwuO/s34gDNA0.bam"  "/tmp/RtmpKBGwuO/s26gDNA1.bam"
## [5] "/tmp/RtmpKBGwuO/s27gDNA1.bam"  "/tmp/RtmpKBGwuO/s28gDNA1.bam"
## [7] "/tmp/RtmpKBGwuO/s23gDNA10.bam" "/tmp/RtmpKBGwuO/s24gDNA10.bam"
## [9] "/tmp/RtmpKBGwuO/s25gDNA10.bam"
```

The previous function call can take a `path` argument to specify the path in
the filesystem where we would like to store the downloaded BAM files, which
by default is a temporary path from the current R session; consult the help
page of `LiYu22subsetBAMfiles()` for full details.

We can also retrieve the gDNA concentrations associated to each BAM file with
the following function call:

```
pdat <- LiYu22phenoData(bamfiles)
pdat
```

```
##           gDNA
## s32gDNA0     0
## s33gDNA0     0
## s34gDNA0     0
## s26gDNA1     1
## s27gDNA1     1
## s28gDNA1     1
## s23gDNA10   10
## s24gDNA10   10
## s25gDNA10   10
```

# 2 Session information

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
##  [1] Rsamtools_2.26.0        Biostrings_2.78.0       XVector_0.50.0
##  [4] GenomicRanges_1.62.0    IRanges_2.44.0          S4Vectors_0.48.0
##  [7] Seqinfo_1.0.0           BiocGenerics_0.56.0     generics_0.1.4
## [10] gDNAinRNAseqData_1.10.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      xfun_0.54            bslib_0.9.0
##  [4] httr2_1.2.1          Biobase_2.70.0       vctrs_0.6.5
##  [7] tools_4.5.1          bitops_1.0-9         curl_7.0.0
## [10] parallel_4.5.1       tibble_3.3.0         AnnotationDbi_1.72.0
## [13] RSQLite_2.4.3        blob_1.2.4           pkgconfig_2.0.3
## [16] dbplyr_2.5.1         lifecycle_1.0.4      compiler_4.5.1
## [19] codetools_0.2-20     htmltools_0.5.8.1    sass_0.4.10
## [22] RCurl_1.98-1.17      yaml_2.3.10          pillar_1.11.1
## [25] crayon_1.5.3         jquerylib_0.1.4      BiocParallel_1.44.0
## [28] cachem_1.1.0         ExperimentHub_3.0.0  AnnotationHub_4.0.0
## [31] tidyselect_1.2.1     digest_0.6.37        purrr_1.1.0
## [34] dplyr_1.1.4          bookdown_0.45        BiocVersion_3.22.0
## [37] fastmap_1.2.0        cli_3.6.5            magrittr_2.0.4
## [40] XML_3.99-0.19        withr_3.0.2          filelock_1.0.3
## [43] rappdirs_0.3.3       bit64_4.6.0-1        rmarkdown_2.30
## [46] httr_1.4.7           bit_4.6.0            png_0.1-8
## [49] memoise_2.0.1        evaluate_1.0.5       knitr_1.50
## [52] BiocFileCache_3.0.0  rlang_1.1.6          glue_1.8.0
## [55] DBI_1.2.3            BiocManager_1.30.26  jsonlite_2.0.0
## [58] R6_2.6.1
```
# spatialDmelxsim

Michael Love

#### 4 November 2025

#### Package

spatialDmelxsim 1.16.0

# Contents

* [1 Allelic counts of D melanogaster x D simulans cross](#allelic-counts-of-d-melanogaster-x-d-simulans-cross)
* [2 Additional details](#additional-details)

# 1 Allelic counts of D melanogaster x D simulans cross

This package contains data of allelic expression counts of spatial
slices of a fly embryo, which is a *D melanogaster* x *D simulans*
cross. The experiment is a reciprocal cross (see `strain`), with three
replicates of one parental arrangement and two of another, which was
sufficient to ensure at least one embryo of each sex for each parental
arrangement.

Data was downloaded from `GSE102233` as described in the publication:

> Combs PA, Fraser HB (2018)
> Spatially varying cis-regulatory divergence in Drosophila embryos
> elucidates cis-regulatory logic.
> *PLOS Genetics* 14(11): e1007631.
> <https://doi.org/10.1371/journal.pgen.1007631>

The scripts for creating the *SummarizedExperiment* object can be
found in `inst/scripts/make-data.R`.

We can find the resource via *ExperimentHub*:

```
library(ExperimentHub)
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
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
eh <- ExperimentHub()
query(eh, "spatialDmelxsim")
```

```
## ExperimentHub with 1 record
## # snapshotDate(): 2025-10-29
## # names(): EH6129
## # package(): spatialDmelxsim
## # $dataprovider: Fraser Lab, Stanford
## # $species: Drosophila melanogaster
## # $rdataclass: RangedSummarizedExperiment
## # $rdatadateadded: 2021-06-16
## # $title: spatialDmelxsim
## # $description: Allelic expression counts of spatial slices of a fly embryo ...
## # $taxonomyid: 7227
## # $genome: dm6
## # $sourcetype: TXT
## # $sourceurl: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE102233
## # $sourcesize: NA
## # $tags: c("allelic", "ASE", "Drosophila_melanogaster_Data", "embryo",
## #   "ExpressionData", "GEO", "patterning", "RNASeqData",
## #   "SequencingData", "spatial")
## # retrieve record with 'object[["EH6129"]]'
```

Or load directly with a function defined within this package:

```
suppressPackageStartupMessages(library(SummarizedExperiment))
library(spatialDmelxsim)
se <- spatialDmelxsim()
```

```
## see ?spatialDmelxsim and browseVignettes('spatialDmelxsim') for documentation
```

```
## loading from cache
```

The rownames of the *SummarizedExperiment* are Ensembl IDs. For
simplicity of code for plotting individual genes, we will change the
rownames to gene symbols (those used in the paper). We check first
that all genes have a symbol, because rownames cannot contain an NA.

```
table(is.na(mcols(se)$paper_symbol))
```

```
##
## FALSE
## 13498
```

```
rownames(se) <- mcols(se)$paper_symbol
```

Note we use the following annotation of alleles:

* a1: *D simulans*
* a2: *D melanogaster*

Then we calculate the allelic ratio for *D simulans* allele:

```
assay(se, "total") <- assay(se, "a1") + assay(se, "a2")
assay(se, "ratio") <- assay(se, "a1") / assay(se, "total")
```

We plot the ratio over the slice, using the `normSlice` column of
metadata. This is the original `slice` number, scaled up to 27 (rep2
had 26 slices and rep4 had 25 slices).

```
plotGene <- function(gene) {
    x <- se$normSlice
    y <- assay(se, "ratio")[gene,]
    col <- as.integer(se$rep)
    plot(x, y, xlab="normSlice", ylab="sim / total ratio",
        ylim=c(0,1), main=gene, col=col)
    lw <- loess(y ~ x, data=data.frame(x,y=unname(y)))
    lines(sort(lw$x), lw$fitted[order(lw$x)], col="red", lwd=2)
    abline(h=0.5, col="grey")
}
```

An example of a gene with global bias toward the *simulans* allele.

```
plotGene("DOR")
```

![](data:image/png;base64...)

Example of some genes with spatial patterning of allelic expression:

```
plotGene("uif")
```

![](data:image/png;base64...)

```
plotGene("bmm")
```

![](data:image/png;base64...)

```
plotGene("hb")
```

![](data:image/png;base64...)

```
plotGene("CG4500")
```

![](data:image/png;base64...)

Other interesting spatial genes can be found by consulting the Combs
and Fraser (2018) paper, in Supplementary Figure 6 “Complete heatmap
of ASE for genes with svASE.” Other species-specific genes are found
in Supplementary Figure 7 “Genes with species-specific expression,
regardless of parent of origin.” Note that the SF6 spatially varying
ASE genes are labelled in `mcols(se)$scASE`.

# 2 Additional details

As said above, the file `inst/scripts/make-data.R` provides the script
that was used to construct the *SummarizedExperiment* object from the
data available on GEO. Here are some additional details:

* The original allelic counts on GEO were assembled for 2,959 of the
  genes (labelled in `mcols(se)$matchDm557`). When compiling the data I
  noticed that other genes, where the genomic locations of dm5.57 and
  dm6 were not a match, had missing allelic counts. The current
  dataset is provided with respect to dm6.
* For those genes with missing allelic counts, I instead used the FPKM
  data on GEO and the allelic counts that were not missing, to predict
  the total allelic count from abundance, per sample (with ~82% r2).
* Finally I used an ASE file on GEO to impute the allelic counts from
  the allelic ratio and predicted total allelic count. These 5,673
  genes are labelled in `mcols(se)$predicted`.
* There are two symbol columns in `mcols(se)`. One is the SYMBOL that
  matches the Ensembl `gene_id` according to `org.Dm.eg.db`. The other
  is the symbol that I obtained from the per-sample FPKM matrices
  which have both Ensembl and gene symbols. The `paper_symbol` column
  is therefore better for matching genes according to their ID in the
  paper figures.

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
##  [1] spatialDmelxsim_1.16.0      SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            MatrixGenerics_1.22.0
##  [9] matrixStats_1.5.0           ExperimentHub_3.0.0
## [11] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [13] dbplyr_2.5.1                BiocGenerics_0.56.0
## [15] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      xfun_0.54            bslib_0.9.0
##  [4] httr2_1.2.1          lattice_0.22-7       vctrs_0.6.5
##  [7] tools_4.5.1          curl_7.0.0           tibble_3.3.0
## [10] AnnotationDbi_1.72.0 RSQLite_2.4.3        blob_1.2.4
## [13] pkgconfig_2.0.3      Matrix_1.7-4         lifecycle_1.0.4
## [16] compiler_4.5.1       Biostrings_2.78.0    tinytex_0.57
## [19] htmltools_0.5.8.1    sass_0.4.10          yaml_2.3.10
## [22] pillar_1.11.1        crayon_1.5.3         jquerylib_0.1.4
## [25] DelayedArray_0.36.0  cachem_1.1.0         magick_2.9.0
## [28] abind_1.4-8          tidyselect_1.2.1     digest_0.6.37
## [31] dplyr_1.1.4          purrr_1.1.0          bookdown_0.45
## [34] BiocVersion_3.22.0   grid_4.5.1           fastmap_1.2.0
## [37] SparseArray_1.10.1   cli_3.6.5            magrittr_2.0.4
## [40] S4Arrays_1.10.0      withr_3.0.2          filelock_1.0.3
## [43] rappdirs_0.3.3       bit64_4.6.0-1        rmarkdown_2.30
## [46] XVector_0.50.0       httr_1.4.7           bit_4.6.0
## [49] png_0.1-8            memoise_2.0.1        evaluate_1.0.5
## [52] knitr_1.50           rlang_1.1.6          Rcpp_1.1.0
## [55] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.26
## [58] jsonlite_2.0.0       R6_2.6.1
```
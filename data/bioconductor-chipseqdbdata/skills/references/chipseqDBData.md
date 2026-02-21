# Processing statistics for ChIP-seq datasets

Aaron Lun1

1Cancer Research UK Cambridge Institute, Cambridge, UK

#### Revised: 6 December 2018

#### Package

chipseqDBData 1.26.0

# 1 Introduction

This package contains several ChIP-seq datasets for use in differential binding (DB) analyses:

* H3K9ac and H3K4me3 ChIP-seq in murine pro-B and mature B cells (Revilla-I-Domingo et al. [2012](#ref-domingo2012bcell))
* CREB binding protein (CBP) ChIP-seq in wild-type and CBP-knockout mouse embryonic fibroblasts (Kasper et al. [2014](#ref-kasper2014genomewide))
* Nuclear transcription factor subunit gamma alpha (NF-YA) ChIP-seq in mouse terminal neurons and embryonic stem cells (Tiwari et al. [2011](#ref-tiwari2011chromatin))
* H3K27me3 ChIP-seq in mouse wild-type and Ezh2-knockout lung epithelium (Galvis et al. [2015](#ref-galvis2015repression))

These datasets are mainly used in the *[chipseqDB](https://bioconductor.org/packages/3.22/chipseqDB)* workflow (Lun and Smyth [2015](#ref-lun2015reads)) and the *[csaw](https://bioconductor.org/packages/3.22/csaw)* user’s guide (Lun and Smyth [2016](#ref-lun2016csaw)).
This vignette will briefly demonstrate how to obtain each dataset and investigate some of the processing statistics.

# 2 Obtaining each dataset

We obtain the H3K9ac dataset from *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* using the `H3K9acData()` function.
This downloads sorted and indexed BAM files to a local cache, along with the associated index files.
The function returns a `DataFrame` of file paths and sample descriptions to further use in workflows.

```
library(chipseqDBData)
h3k9ac.paths <- H3K9acData()
h3k9ac.paths
```

```
## DataFrame with 4 rows and 3 columns
##                  Name            Description      Path
##           <character>            <character>    <List>
## 1    h3k9ac-proB-8113    pro-B H3K9ac (8113) <BamFile>
## 2    h3k9ac-proB-8108    pro-B H3K9ac (8108) <BamFile>
## 3 h3k9ac-matureB-8059 mature B H3K9ac (8059) <BamFile>
## 4 h3k9ac-matureB-8086 mature B H3K9ac (8086) <BamFile>
```

Note that the time-consuming download only occurs upon the first use of the function.
Later uses will simply re-use the same files, thus avoiding the need to re-download these large files.
(Some readers may notice that the paths point to the temporary directory, which is destroyed at the end of each R session.
Here, the temporary directory contains only soft-links to the persistent BAM files in the local cache.
This is a low-cost illusion to ensure that the index files have the same prefixes as the BAM files.)

The same approach is used for all of the other datasets, e.g., `CBPData()`, `NFYAData()`.
Be aware that the initial download time will depend on the size and number of the BAM files in each dataset.

# 3 Investigating mapping statistics

We use functions from the *[Rsamtools](https://bioconductor.org/packages/3.22/Rsamtools)* package to examine the mapping statistics.
This includes the number of mapped reads, the number of marked reads (i.e., potential PCR duplicates) and the number of high-quality alignments with high mapping scores.

```
library(Rsamtools)
diagnostics <- list()
for (i in seq_len(nrow(h3k9ac.paths))) {
    stats <- scanBam(h3k9ac.paths$Path[[i]],
        param=ScanBamParam(what=c("mapq", "flag")))
    flag <- stats[[1]]$flag
    mapq <- stats[[1]]$mapq

    mapped <- bitwAnd(flag, 0x4)==0
    diagnostics[[h3k9ac.paths$Name[i]]] <- c(
        Total=length(flag),
        Mapped=sum(mapped),
        HighQual=sum(mapq >= 10 & mapped),
        DupMarked=sum(bitwAnd(flag, 0x400)!=0)
    )
}
diag.stats <- data.frame(do.call(rbind, diagnostics))
diag.stats$Prop.mapped <- diag.stats$Mapped/diag.stats$Total*100
diag.stats$Prop.marked <- diag.stats$DupMarked/diag.stats$Mapped*100
diag.stats
```

```
##                        Total  Mapped HighQual DupMarked Prop.mapped Prop.marked
## h3k9ac-proB-8113    10724526 8832006  8815503    434884    82.35335    4.923955
## h3k9ac-proB-8108    10413135 7793913  7786335    252271    74.84694    3.236770
## h3k9ac-matureB-8059 16675372 4670364  4568908    396785    28.00756    8.495805
## h3k9ac-matureB-8086  6347683 4551692  4535587    141583    71.70635    3.110558
```

More comprehensive quality checks are beyond the scope of this document, but can be performed with other packages such as *[ChIPQC](https://bioconductor.org/packages/3.22/ChIPQC)*.

# 4 Session information

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
##  [1] Rsamtools_2.26.0     Biostrings_2.78.0    XVector_0.50.0
##  [4] GenomicRanges_1.62.0 IRanges_2.44.0       S4Vectors_0.48.0
##  [7] Seqinfo_1.0.0        BiocGenerics_0.56.0  generics_0.1.4
## [10] chipseqDBData_1.26.0 knitr_1.50           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      xfun_0.53            bslib_0.9.0
##  [4] httr2_1.2.1          Biobase_2.70.0       vctrs_0.6.5
##  [7] tools_4.5.1          bitops_1.0-9         curl_7.0.0
## [10] parallel_4.5.1       tibble_3.3.0         AnnotationDbi_1.72.0
## [13] RSQLite_2.4.3        blob_1.2.4           pkgconfig_2.0.3
## [16] dbplyr_2.5.1         lifecycle_1.0.4      compiler_4.5.1
## [19] codetools_0.2-20     htmltools_0.5.8.1    sass_0.4.10
## [22] yaml_2.3.10          pillar_1.11.1        crayon_1.5.3
## [25] jquerylib_0.1.4      BiocParallel_1.44.0  cachem_1.1.0
## [28] ExperimentHub_3.0.0  AnnotationHub_4.0.0  tidyselect_1.2.1
## [31] digest_0.6.37        dplyr_1.1.4          purrr_1.1.0
## [34] bookdown_0.45        BiocVersion_3.22.0   fastmap_1.2.0
## [37] cli_3.6.5            magrittr_2.0.4       withr_3.0.2
## [40] filelock_1.0.3       rappdirs_0.3.3       bit64_4.6.0-1
## [43] rmarkdown_2.30       httr_1.4.7           bit_4.6.0
## [46] png_0.1-8            memoise_2.0.1        evaluate_1.0.5
## [49] BiocFileCache_3.0.0  rlang_1.1.6          glue_1.8.0
## [52] DBI_1.2.3            BiocManager_1.30.26  jsonlite_2.0.0
## [55] R6_2.6.1
```

# References

Galvis, L. A., A. Z. Holik, K. M. Short, J. Pasquet, A. T. Lun, M. E. Blewitt, I. M. Smyth, M. E. Ritchie, and M. L. Asselin-Labat. 2015. “Repression of Igf1 expression by Ezh2 prevents basal cell differentiation in the developing lung.” *Development* 142 (8): 1458–69.

Kasper, L. H., C. Qu, J. C. Obenauer, D. J. McGoldrick, and P. K. Brindle. 2014. “Genome-wide and single-cell analyses reveal a context dependent relationship between CBP recruitment and gene expression.” *Nucleic Acids Res.* 42 (18): 11363–82.

Lun, A. T., and G. K. Smyth. 2015. “From reads to regions: a Bioconductor workflow to detect differential binding in ChIP-seq data.” *F1000Res.* 4: 1080.

———. 2016. “csaw: a Bioconductor package for differential binding analysis of ChIP-seq data using sliding windows.” *Nucleic Acids Res.* 44 (5): e45.

Revilla-I-Domingo, R., I. Bilic, B. Vilagos, H. Tagoh, A. Ebert, I. M. Tamir, L. Smeenk, et al. 2012. “The B-cell identity factor Pax5 regulates distinct transcriptional programmes in early and late B lymphopoiesis.” *EMBO J.* 31 (14): 3130–46.

Tiwari, V. K., M. B. Stadler, C. Wirbelauer, R. Paro, D. Schubeler, and C. Beisel. 2011. “A chromatin-modifying function of JNK during stem cell differentiation.” *Nat. Genet.* 44 (1): 94–100.
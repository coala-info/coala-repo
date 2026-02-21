# Pairwise whole genome alignment

Ge Tan

#### 29 October 2025

#### Abstract

Pipeline of generating pairwise whole genome alignment.

#### Package

CNEr 1.46.0

# Contents

* [1 Introduction](#introduction)
* [2 Prerequisite](#prerequisite)
* [3 Aligning](#aligning)
  + [3.1 LASTZ aligner](#lastz-aligner)
  + [3.2 last aligner](#last-aligner)
  + [3.3 YASS aligner](#yass-aligner)
* [4 Chaining:](#chaining)
* [5 Netting:](#netting)
* [6 axtNet](#axtnet)
* [7 Session info](#session-info)

# 1 Introduction

*[CNEr](https://bioconductor.org/packages/3.22/CNEr)* identifies conserved noncoding elments (CNEs) from pairwise whole genome alignment (*net.axt* files) of two species.
UCSC has provided alignments between many species on the [downloads](http://hgdownload.cse.ucsc.edu/downloads.html),
hence it is highly recommended to use their alignments when available.
When the alignments of some new assemblies/species are not availble from UCSC yet, this vignette describes the pipeline of generating the alignments merely from soft-masked *2bit* files or *fasta* files.
This vignette is based on the [genomewiki](http://genomewiki.ucsc.edu/index.php/Whole_genome_alignment_howto) from UCSC.

**Note:**

* The whole pipeline relies on [Kent’s utilities](http://hgdownload.cse.ucsc.edu/admin/exe/).
  Since Kent’s utilities don’t support Windows platform, this pipeline also only works on Linux and Unix platform.
* Many of the functions in this pipeline are just wrapper functions, in order to simplfy the settings and work consistently with the rest of CNEs pipeline within *R* environment.
* Due to large file size of the genome assemblies, the commands in this vignette don’t run during the vignette compilation. Users have to set the correct paths on their machine in order to make these commands work.

# 2 Prerequisite

List of external softwares have to be installed on the machine:
\* The sequence alignment program [LASTZ](http://www.bx.psu.edu/miller_lab/dist/README.lastz-1.02.00/README.lastz-1.02.00a.html)
\* [Kent Utilities](http://hgdownload.cse.ucsc.edu/admin/jksrc.zip). In this pipeline, *lavToPsl*, *axtChain*, *chainMergeSort*, *chainPreNet*, *chainNet*, *netSyntenic*, *netToAxt*, *axtSort* are essential. netClass is optional.

# 3 Aligning

Here, as an example, we will get the pairwise alignment only on “chr1”, “chr2” and “chr3” between zebrafish(*danRer10*) and human(*hg38*).

## 3.1 LASTZ aligner

First we need to download the *2bit* files from UCSC, and set the appropriate paths of `assemblyTarget`, `assemblyQuery` and intermediate files.
Then we can run `lastz` function to generate the *lav* files.

```
## lastz aligner
assemblyDir <- "/Users/gtan/OneDrive/Project/CSC/CNEr/2bit"
axtDir <- "/Users/gtan/OneDrive/Project/CSC/CNEr/axt"
assemblyTarget <- file.path(system.file("extdata",
                            package="BSgenome.Drerio.UCSC.danRer10"),
                            "single_sequences.2bit")
assemblyQuery <- file.path(system.file("extdata",
                                       package="BSgenome.Hsapiens.UCSC.hg38"),
                           "single_sequences.2bit")
lavs <- lastz(assemblyTarget, assemblyQuery,
              outputDir=axtDir,
              chrsTarget=c("chr1", "chr2", "chr3"),
              chrsQuery=c("chr1", "chr2", "chr3"),
              distance="far", mc.cores=4)

## lav files to psl files conversion
psls <- lavToPsl(lavs, removeLav=FALSE, binary="lavToPsl")
```

One essential argument here is the `distance`. It determines the scoring matrix to use in `lastz` aligner. See `?scoringMatrix` for more details.

**Note:**
This step may encounter difficulties if the two assemblies are too fragmented, because there can be millions of combinations of the chromosomes/scaffolds. The `lastz` is overwhelmed with reading small pieces from assembly for each combination, rather than doing actual alignment.
In this case, another aligner [last](http://last.cbrc.jp/) is recommended and introduced in nex section.

## 3.2 last aligner

`last` aligner is considered faster and memory efficient.
It creates *maf* file, which can converted to *psl* files.
Then the same following processes can be used on *psl* files.

Different from `lastz`, `last` aligner starts with *fasta* files.
The target genome sequence has to build the *index* file first, and then align with the query genome sequence.

```
## Build the lastdb index
system2(command="lastdb", args=c("-c", file.path(assemblyDir, "danRer10"),
                                 file.path(assemblyDir, "danRer10.fa")))

## Run last aligner
lastal(db=file.path(assemblyDir, "danRer10"),
       queryFn=file.path(assemblyDir, "hg38.fa"),
       outputFn=file.path(axtDir, "danRer10.hg38.maf"),
       distance="far", binary="lastal", mc.cores=4L)

## maf to psl
psls <- file.path(axtDir, "danRer10.hg38.psl")
system2(command="maf-convert", args=c("psl",
                                      file.path(axtDir, "danRer10.hg38.maf"),
                                      ">", psls))
```

## 3.3 YASS aligner

Another alternative of alignment software is
[YASS](http://bioinfo.lifl.fr/yass/).
It may be added into this pipeline after we test the performance.

# 4 Chaining:

If two matching alignments next to each other are close enough, they are joined into one fragment.
Then these *chain* files are sorted and combined into one big file.

```
## Join close alignments
chains <- axtChain(psls, assemblyTarget=assemblyTarget,
                   assemblyQuery=assemblyQuery, distance="far",
                   removePsl=FALSE, binary="axtChain")

## Sort and combine
allChain <- chainMergeSort(chains, assemblyTarget, assemblyQuery,
              allChain=file.path(axtDir,
                         paste0(sub("\\.2bit$", "", basename(assemblyTarget),
                                    ignore.case=TRUE), ".",
                                sub("\\.2bit$", "", basename(assemblyQuery),
                                    ignore.case=TRUE), ".all.chain")),
                           removeChains=FALSE, binary="chainMergeSort")
```

# 5 Netting:

In this step, first we filter out chains that are unlikely to be netted by `chainPreNet`.
During the alignment, every genomic fragment can match with several others, and certainly we want to keep the best one.
This is done by `chainNet`.
Then we add the synteny information with `netSyntenic`.

```
## Filtering out chains
allPreChain <- chainPreNet(allChain, assemblyTarget, assemblyQuery,
                           allPreChain=file.path(axtDir,
                                      paste0(sub("\\.2bit$", "",
                                                 basename(assemblyTarget),
                                                 ignore.case = TRUE), ".",
                                             sub("\\.2bit$", "",
                                                 basename(assemblyQuery),
                                                 ignore.case = TRUE),
                                                 ".all.pre.chain")),
                           removeAllChain=FALSE, binary="chainPreNet")

## Keep the best chain and add synteny information
netSyntenicFile <- chainNetSyntenic(allPreChain, assemblyTarget, assemblyQuery,
                     netSyntenicFile=file.path(axtDir,
                                               paste0(sub("\\.2bit$", "",
                                                      basename(assemblyTarget),
                                                      ignore.case = TRUE), ".",
                                                      sub("\\.2bit$", "",
                                                      basename(assemblyQuery),
                                                      ignore.case = TRUE),
                                               ".noClass.net")),
                     binaryChainNet="chainNet", binaryNetSyntenic="netSyntenic")
```

# 6 axtNet

As the last step, we create the *.net.axt* file from the previous *net* and *chain* files.

```
netToAxt(netSyntenicFile, allPreChain, assemblyTarget, assemblyQuery,
         axtFile=file.path(axtDir,
                           paste0(sub("\\.2bit$", "",
                                      basename(assemblyTarget),
                                      ignore.case = TRUE), ".",
                                  sub("\\.2bit$", "",
                                      basename(assemblyQuery),
                                      ignore.case = TRUE),
                                  ".net.axt")),
             removeFiles=FALSE,
             binaryNetToAxt="netToAxt", binaryAxtSort="axtSort")
```

# 7 Session info

Here is the output of `sessionInfo()` on the system on which this
document was compiled:

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] Gviz_1.54.0                         GenomeInfoDb_1.46.0
##  [3] BSgenome.Ggallus.UCSC.galGal3_1.4.0 BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [5] BSgenome_1.78.0                     rtracklayer_1.70.0
##  [7] BiocIO_1.20.0                       Biostrings_2.78.0
##  [9] XVector_0.50.0                      GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0                       IRanges_2.44.0
## [13] S4Vectors_0.48.0                    BiocGenerics_0.56.0
## [15] generics_0.1.4                      CNEr_1.46.0
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              magrittr_2.0.4
##   [5] GenomicFeatures_1.62.0      magick_2.9.0
##   [7] farver_2.1.2                rmarkdown_2.30
##   [9] vctrs_0.6.5                 memoise_2.0.1
##  [11] Rsamtools_2.26.0            RCurl_1.98-1.17
##  [13] base64enc_0.1-3             tinytex_0.57
##  [15] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [17] progress_1.2.3              curl_7.0.0
##  [19] SparseArray_1.10.0          Formula_1.2-5
##  [21] sass_0.4.10                 pracma_2.4.6
##  [23] bslib_0.9.0                 htmlwidgets_1.6.4
##  [25] plyr_1.8.9                  httr2_1.2.1
##  [27] cachem_1.1.0                GenomicAlignments_1.46.0
##  [29] lifecycle_1.0.4             pkgconfig_2.0.3
##  [31] Matrix_1.7-4                R6_2.6.1
##  [33] fastmap_1.2.0               MatrixGenerics_1.22.0
##  [35] digest_0.6.37               colorspace_2.1-2
##  [37] AnnotationDbi_1.72.0        Hmisc_5.2-4
##  [39] RSQLite_2.4.3               filelock_1.0.3
##  [41] labeling_0.4.3              httr_1.4.7
##  [43] abind_1.4-8                 compiler_4.5.1
##  [45] bit64_4.6.0-1               withr_3.0.2
##  [47] htmlTable_2.4.3             S7_0.2.0
##  [49] backports_1.5.0             BiocParallel_1.44.0
##  [51] DBI_1.2.3                   R.utils_2.13.0
##  [53] biomaRt_2.66.0              rappdirs_0.3.3
##  [55] poweRlaw_1.0.0              DelayedArray_0.36.0
##  [57] rjson_0.2.23                tools_4.5.1
##  [59] foreign_0.8-90              nnet_7.3-20
##  [61] R.oo_1.27.1                 glue_1.8.0
##  [63] restfulr_0.0.16             checkmate_2.3.3
##  [65] cluster_2.1.8.1             reshape2_1.4.4
##  [67] gtable_0.3.6                tzdb_0.5.0
##  [69] R.methodsS3_1.8.2           ensembldb_2.34.0
##  [71] data.table_1.17.8           hms_1.1.4
##  [73] pillar_1.11.1               stringr_1.5.2
##  [75] vroom_1.6.6                 dplyr_1.1.4
##  [77] BiocFileCache_3.0.0         lattice_0.22-7
##  [79] deldir_2.0-4                bit_4.6.0
##  [81] annotate_1.88.0             biovizBase_1.58.0
##  [83] tidyselect_1.2.1            GO.db_3.22.0
##  [85] knitr_1.50                  gridExtra_2.3
##  [87] bookdown_0.45               ProtGenerics_1.42.0
##  [89] SummarizedExperiment_1.40.0 xfun_0.53
##  [91] Biobase_2.70.0              matrixStats_1.5.0
##  [93] stringi_1.8.7               UCSC.utils_1.6.0
##  [95] lazyeval_0.2.2              yaml_2.3.10
##  [97] evaluate_1.0.5              codetools_0.2-20
##  [99] cigarillo_1.0.0             interp_1.1-6
## [101] archive_1.1.12              tibble_3.3.0
## [103] BiocManager_1.30.26         cli_3.6.5
## [105] rpart_4.1.24                xtable_1.8-4
## [107] jquerylib_0.1.4             dichromat_2.0-0.1
## [109] Rcpp_1.1.0                  dbplyr_2.5.1
## [111] png_0.1-8                   XML_3.99-0.19
## [113] parallel_4.5.1              ggplot2_4.0.0
## [115] readr_2.1.5                 blob_1.2.4
## [117] prettyunits_1.2.0           jpeg_0.1-11
## [119] latticeExtra_0.6-31         AnnotationFilter_1.34.0
## [121] bitops_1.0-9                pwalign_1.6.0
## [123] VariantAnnotation_1.56.0    scales_1.4.0
## [125] crayon_1.5.3                rlang_1.1.6
## [127] KEGGREST_1.50.0
```
# svaRetro Quick Overview

Ruining Dong

#### 2026-02-18

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Using GRanges for structural variants: a breakend-centric data structure](#using-granges-for-structural-variants-a-breakend-centric-data-structure)
* [4 Workflow](#workflow)
  + [4.1 Loading data from VCF](#loading-data-from-vcf)
  + [4.2 Identifying Retrotransposed Transcripts](#identifying-retrotransposed-transcripts)
* [5 Visualising breakpoint pairs via circos plots](#visualising-breakpoint-pairs-via-circos-plots)
* [6 SessionInfo](#sessioninfo)

# 1 Introduction

This vignette outlines a workflow of detecting retrotransposed transcripts (RTs)
from Variant Call Format (VCF) using the `svaRetro` package.

# 2 Installation

The `svaRetro` package can be installed from *Bioconductor* as follows:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("svaRetro")
```

# 3 Using GRanges for structural variants: a breakend-centric data structure

This package uses a breakend-centric event notation adopted from the
`StructuralVariantAnnotation` package. In short, breakends are stored in a
GRanges object with strand used to indicate breakpoint orientation, where
breakpoints are represented using a `partner` field containing the name of the
breakend at the other side of the breakend. This notation was chosen as it
simplifies the annotations of RTs which are detected at breakend-level.

# 4 Workflow

## 4.1 Loading data from VCF

VCF data is parsed into a `VCF` object using the `readVCF` function from the
Bioconductor package `VariantAnnotation`. Simple filters could be applied to a
`VCF` object to remove unwanted calls. The `VCF` object is then converted to a
`GRanges` object with breakend-centric notations using
`StructuralVariantAnnotation`. More information about `VCF` objects and
breakend-centric GRanges object can be found by
consulting the vignettes in the corresponding packages with
`browseVignettes("VariantAnnotation")` and
`browseVignettes("StructuralVariantAnnotation")`.

```
library(StructuralVariantAnnotation)
library(VariantAnnotation)
library(svaRetro)

RT_vcf <- readVcf(system.file("extdata", "diploidSV.vcf", package = "svaRetro"))
```

```
RT_gr <- StructuralVariantAnnotation::breakpointRanges(RT_vcf,
  nominalPosition = TRUE
)
head(RT_gr)
```

Note that `StructuralVariantAnnotation` requires the `GRanges` object to be
composed entirely of valid breakpoints. Please consult the vignette of the
`StructuralVariantAnnotation` package for ensuring breakpoint consistency.

## 4.2 Identifying Retrotransposed Transcripts

The package provides `rtDetect` to identify RTs using the provided SV calls.
This is achieved by detecting intronic deletions, which are breakpoints at
exon-intron (and intron-exon) boundaries of a transcript. Fusions consisting of
an exon boundary and a second genomic location are reported as potential
insertion sites. Due to the complexity of RT events, insertion sites can be
discovered on both left and right sides, only one side, or none at all.

```
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(dplyr)
hg19.genes <- TxDb.Hsapiens.UCSC.hg19.knownGene

RT <- rtDetect(RT_gr, hg19.genes, maxgap = 10, minscore = 0.8)
```

The output is a list of `GRanges` object consisting of two sets of `GRanges`
calls, `insSite` and `junctions`, containing candidate insertion sites and
exon-exon junctions respectively. Candidate insertion sites are annotated by
the source transcripts and whether exon-exon junctions are detected for the
source transcripts. RT junction breakends are annotated by the UCSC exon IDs,
corresponding transcripts, and NCBI gene symbols.

```
RT$SKA3
#> $junctions
#> GRanges object with 14 ranges and 17 metadata columns:
#>                                  seqnames    ranges strand | paramRangeID                    REF         ALT      QUAL      FILTER               sourceId                partner      svtype     svLen      insSeq    insLen       event    HOMLEN      exon                                      txs         exons gene_symbol
#>                                     <Rle> <IRanges>  <Rle> |     <factor>            <character> <character> <numeric> <character>            <character>            <character> <character> <numeric> <character> <numeric> <character> <numeric> <integer>                                   <list>        <list>      <list>
#>    MantaDEL:245251:6:6:0:0:0_bp2       13  21729832      - |           NA TCTGCAACAGATACAAATAA..           T       999        PASS MantaDEL:245251:6:6:.. MantaDEL:245251:6:6:..         DEL      -542                     0        <NA>         1    589252 ENST00000298260.8_4,ENST00000314759.6_11        589252        SKA3
#>    MantaDEL:245251:5:8:0:0:0_bp2       13  21732061      - |           NA                      G       <DEL>       999        PASS MantaDEL:245251:5:8:.. MantaDEL:245251:5:8:..         DEL     -2110        <NA>         0        <NA>         2    589253 ENST00000298260.8_4,ENST00000314759.6_11        589253        SKA3
#>    MantaDEL:245251:5:9:0:0:0_bp2       13  21734038      - |           NA                      A       <DEL>       525        PASS MantaDEL:245251:5:9:.. MantaDEL:245251:5:9:..         DEL     -1776        <NA>         0        <NA>         4    589254 ENST00000298260.8_4,ENST00000314759.6_11        589254        SKA3
#>   MantaDEL:245251:7:10:0:0:0_bp2       13  21735929      - |           NA                      T       <DEL>       539        PASS MantaDEL:245251:7:10.. MantaDEL:245251:7:10..         DEL     -1802        <NA>         0        <NA>         1    589255 ENST00000298260.8_4,ENST00000314759.6_11        589255        SKA3
#>   MantaDEL:245251:4:11:0:0:0_bp2       13  21742127      - |           NA                      A       <DEL>       999        PASS MantaDEL:245251:4:11.. MantaDEL:245251:4:11..         DEL     -6112        <NA>         0        <NA>         2    589256 ENST00000298260.8_4,ENST00000314759.6_11        589256        SKA3
#>                              ...      ...       ...    ... .          ...                    ...         ...       ...         ...                    ...                    ...         ...       ...         ...       ...         ...       ...       ...                                      ...           ...         ...
#>    MantaDEL:245251:5:9:0:0:0_bp1       13  21732261      + |           NA                      A       <DEL>       525        PASS MantaDEL:245251:5:9:.. MantaDEL:245251:5:9:..         DEL     -1776        <NA>         0        <NA>         4    589253 ENST00000298260.8_4,ENST00000314759.6_11        589253        SKA3
#>   MantaDEL:245251:7:10:0:0:0_bp1       13  21734126      + |           NA                      T       <DEL>       539        PASS MantaDEL:245251:7:10.. MantaDEL:245251:7:10..         DEL     -1802        <NA>         0        <NA>         1    589254 ENST00000298260.8_4,ENST00000314759.6_11        589254        SKA3
#>   MantaDEL:245251:4:11:0:0:0_bp1       13  21736014      + |           NA                      A       <DEL>       999        PASS MantaDEL:245251:4:11.. MantaDEL:245251:4:11..         DEL     -6112        <NA>         0        <NA>         2    589255 ENST00000298260.8_4,ENST00000314759.6_11        589255        SKA3
#>    MantaDEL:245251:3:4:0:0:0_bp1       13  21742538      + |           NA                      A       <DEL>       999        PASS MantaDEL:245251:3:4:.. MantaDEL:245251:3:4:..         DEL     -3939        <NA>         0        <NA>         2    589256 ENST00000298260.8_4,ENST00000314759.6_11 589256,589257        SKA3
#>    MantaDEL:245251:2:3:0:0:0_bp1       13  21746642      + |           NA                      T       <DEL>       999        PASS MantaDEL:245251:2:3:.. MantaDEL:245251:2:3:..         DEL     -3870        <NA>         0        <NA>         2    589258 ENST00000298260.8_4,ENST00000314759.6_11 589258,589259        SKA3
#>   -------
#>   seqinfo: 25 sequences (1 circular) from GRCh37.p13 genome
#>
#> $insSite
#> GRanges object with 0 ranges and 18 metadata columns:
#>    seqnames    ranges strand | paramRangeID         REF         ALT      QUAL      FILTER    sourceId     partner      svtype     svLen      insSeq    insLen       event    HOMLEN  exons    txs rtFound rtFoundSum gene_symbol
#>       <Rle> <IRanges>  <Rle> |     <factor> <character> <character> <numeric> <character> <character> <character> <character> <numeric> <character> <numeric> <character> <numeric> <list> <list>  <list>  <logical>      <list>
#>   -------
#>   seqinfo: 25 sequences (1 circular) from GRCh37.p13 genome
```

# 5 Visualising breakpoint pairs via circos plots

One way of visualising RT is by circos plots. Here we use the package
[`circlize`](https://doi.org/10.1093/bioinformatics/btu393) to demonstrate
the visualisation of insertion site and exon-exon junctions.

To generate a simple circos plot of RT event with SKA3 transcript:

```
library(circlize)
rt_chr_prefix <- c(RT$SKA3$junctions, RT$SKA3$insSite)
GenomeInfoDb::seqlevelsStyle(rt_chr_prefix) <- "UCSC"
pairs <- breakpointgr2pairs(rt_chr_prefix)
pairs
```

To see supporting breakpoints clearly, we generate the circos plot according
to the loci of event.

```
circos.initializeWithIdeogram(
  data.frame(
    V1 = c("chr13", "chr11"),
    V2 = c(21720000, 108585000),
    V3 = c(21755000, 108586000),
    V4 = c("q12.11", "q24.3"),
    V5 = c("gneg", "gpos50")
  )
)
circos.genomicLink(
  as.data.frame(S4Vectors::first(pairs)),
  as.data.frame(S4Vectors::second(pairs))
)
```

![](data:image/png;base64...)

```
circos.clear()
```

# 6 SessionInfo

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB              LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] circlize_0.4.17                          dplyr_1.2.0                              TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1 GenomicFeatures_1.62.0                   AnnotationDbi_1.72.0                     svaRetro_1.16.6                          StructuralVariantAnnotation_1.26.0       VariantAnnotation_1.56.0                 Rsamtools_2.26.0                         Biostrings_2.78.0                        XVector_0.50.0                           SummarizedExperiment_1.40.0              Biobase_2.70.0                           MatrixGenerics_1.22.0                    matrixStats_1.5.0                        rtracklayer_1.70.1                       GenomicRanges_1.62.1                     Seqinfo_1.0.0                            IRanges_2.44.0                           S4Vectors_0.48.0                         BiocGenerics_0.56.0                      generics_0.1.4                           BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1         blob_1.3.0               bitops_1.0-9             fastmap_1.2.0            RCurl_1.98-1.17          GenomicAlignments_1.46.0 XML_3.99-0.22            digest_0.6.39            lifecycle_1.0.5          pwalign_1.6.0            KEGGREST_1.50.0          RSQLite_2.4.6            magrittr_2.0.4           compiler_4.5.2           rlang_1.1.7              sass_0.4.10              tools_4.5.2              yaml_2.3.12              knitr_1.51               S4Arrays_1.10.1          bit_4.6.0                curl_7.0.0               DelayedArray_0.36.0      abind_1.4-8              BiocParallel_1.44.0      grid_4.5.2               colorspace_2.1-2         tinytex_0.58             cli_3.6.5                rmarkdown_2.30           crayon_1.5.3             otel_0.2.0               httr_1.4.8               rjson_0.2.23             DBI_1.2.3                cachem_1.1.0             stringr_1.6.0            assertthat_0.2.1         parallel_4.5.2
#> [40] BiocManager_1.30.27      restfulr_0.0.16          vctrs_0.7.1              Matrix_1.7-4             jsonlite_2.0.0           bookdown_0.46            bit64_4.6.0-1            magick_2.9.0             jquerylib_0.1.4          glue_1.8.0               codetools_0.2-20         shape_1.4.6.1            stringi_1.8.7            GenomeInfoDb_1.46.2      BiocIO_1.20.0            UCSC.utils_1.6.1         tibble_3.3.1             pillar_1.11.1            htmltools_0.5.9          BSgenome_1.78.0          R6_2.6.1                 evaluate_1.0.5           lattice_0.22-9           png_0.1-8                cigarillo_1.0.0          memoise_2.0.1            bslib_0.10.0             Rcpp_1.1.1               SparseArray_1.10.8       org.Hs.eg.db_3.22.0      xfun_0.56                pkgconfig_2.0.3          GlobalOptions_0.1.3
```
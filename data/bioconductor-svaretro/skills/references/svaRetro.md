# svaRetro Quick Overview

Ruining Dong

#### 2025-10-07

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
if(!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
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
                                                       nominalPosition=TRUE)
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

RT <- rtDetect(RT_gr, hg19.genes, maxgap=10, minscore=0.8)
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
#>                                  seqnames    ranges strand | paramRangeID                    REF         ALT      QUAL      FILTER               sourceId                partner      svtype     svLen      insSeq    insLen       event    HOMLEN      exon                   txs  exons gene_symbol
#>                                     <Rle> <IRanges>  <Rle> |     <factor>            <character> <character> <numeric> <character>            <character>            <character> <character> <numeric> <character> <numeric> <character> <numeric> <integer>                <list> <list>      <list>
#>    MantaDEL:245251:6:6:0:0:0_bp2       13  21729832      - |           NA TCTGCAACAGATACAAATAA..           T       999        PASS MantaDEL:245251:6:6:.. MantaDEL:245251:6:6:..         DEL      -542                     0        <NA>         1    176912 uc001unt.3,uc001unv.3 176912        SKA3
#>    MantaDEL:245251:5:8:0:0:0_bp2       13  21732061      - |           NA                      G       <DEL>       999        PASS MantaDEL:245251:5:8:.. MantaDEL:245251:5:8:..         DEL     -2110        <NA>         0        <NA>         2    176913 uc001unt.3,uc001unv.3 176913        SKA3
#>    MantaDEL:245251:5:9:0:0:0_bp2       13  21734038      - |           NA                      A       <DEL>       525        PASS MantaDEL:245251:5:9:.. MantaDEL:245251:5:9:..         DEL     -1776        <NA>         0        <NA>         4    176914 uc001unt.3,uc001unv.3 176914        SKA3
#>   MantaDEL:245251:7:10:0:0:0_bp2       13  21735929      - |           NA                      T       <DEL>       539        PASS MantaDEL:245251:7:10.. MantaDEL:245251:7:10..         DEL     -1802        <NA>         0        <NA>         1    176915 uc001unt.3,uc001unv.3 176915        SKA3
#>   MantaDEL:245251:4:11:0:0:0_bp2       13  21742127      - |           NA                      A       <DEL>       999        PASS MantaDEL:245251:4:11.. MantaDEL:245251:4:11..         DEL     -6112        <NA>         0        <NA>         2    176916 uc001unt.3,uc001unv.3 176916        SKA3
#>                              ...      ...       ...    ... .          ...                    ...         ...       ...         ...                    ...                    ...         ...       ...         ...       ...         ...       ...       ...                   ...    ...         ...
#>    MantaDEL:245251:5:9:0:0:0_bp1       13  21732261      + |           NA                      A       <DEL>       525        PASS MantaDEL:245251:5:9:.. MantaDEL:245251:5:9:..         DEL     -1776        <NA>         0        <NA>         4    176913 uc001unt.3,uc001unv.3 176913        SKA3
#>   MantaDEL:245251:7:10:0:0:0_bp1       13  21734126      + |           NA                      T       <DEL>       539        PASS MantaDEL:245251:7:10.. MantaDEL:245251:7:10..         DEL     -1802        <NA>         0        <NA>         1    176914 uc001unt.3,uc001unv.3 176914        SKA3
#>   MantaDEL:245251:4:11:0:0:0_bp1       13  21736014      + |           NA                      A       <DEL>       999        PASS MantaDEL:245251:4:11.. MantaDEL:245251:4:11..         DEL     -6112        <NA>         0        <NA>         2    176915 uc001unt.3,uc001unv.3 176915        SKA3
#>    MantaDEL:245251:3:4:0:0:0_bp1       13  21742538      + |           NA                      A       <DEL>       999        PASS MantaDEL:245251:3:4:.. MantaDEL:245251:3:4:..         DEL     -3939        <NA>         0        <NA>         2    176916 uc001unt.3,uc001unv.3 176916        SKA3
#>    MantaDEL:245251:2:3:0:0:0_bp1       13  21746642      + |           NA                      T       <DEL>       999        PASS MantaDEL:245251:2:3:.. MantaDEL:245251:2:3:..         DEL     -3870        <NA>         0        <NA>         2    176917 uc001unt.3,uc001unv.3 176917        SKA3
#>   -------
#>   seqinfo: 25 sequences from an unspecified genome
#>
#> $insSite
#> GRanges object with 2 ranges and 18 metadata columns:
#>                               seqnames    ranges strand | paramRangeID         REF             ALT      QUAL      FILTER               sourceId                partner      svtype     svLen      insSeq    insLen       event    HOMLEN  exons                   txs    rtFound rtFoundSum gene_symbol
#>                                  <Rle> <IRanges>  <Rle> |     <factor> <character>     <character> <numeric> <character>            <character>            <character> <character> <numeric> <character> <numeric> <character> <numeric> <list>                <list>     <list>  <logical>      <list>
#>   MantaBND:245251:0:3:0:0:0:0       13  21746762      + |           NA           T T[11:108585702[        49        PASS MantaBND:245251:0:3:.. MantaBND:245251:0:3:..         BND        NA                     0        <NA>         0 176918 uc001unt.3,uc001unu.3 TRUE,FALSE       TRUE        SKA3
#>   MantaBND:245251:0:3:0:0:0:1       11 108585702      - |           NA           T  ]13:21746762]T        49        PASS MantaBND:245251:0:3:.. MantaBND:245251:0:3:..         BND        NA                     0        <NA>         0   <NA>                  <NA>       <NA>       <NA>        <NA>
#>   -------
#>   seqinfo: 25 sequences from an unspecified genome
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
    data.frame(V1=c("chr13", "chr11"),
               V2=c(21720000,108585000),
               V3=c(21755000,108586000),
               V4=c("q12.11","q24.3"),
               V5=c("gneg","gpos50")))
circos.genomicLink(as.data.frame(S4Vectors::first(pairs)),
                   as.data.frame(S4Vectors::second(pairs)))
```

![](data:image/png;base64...)

```
circos.clear()
```

# 6 SessionInfo

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
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB              LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] circlize_0.4.16                         dplyr_1.1.4                             TxDb.Hsapiens.UCSC.hg19.knownGene_3.2.2 GenomicFeatures_1.61.6                  AnnotationDbi_1.71.1                    svaRetro_1.15.1                         StructuralVariantAnnotation_1.25.0      VariantAnnotation_1.55.1                Rsamtools_2.25.3                        Biostrings_2.77.2                       XVector_0.49.1                          SummarizedExperiment_1.39.2             Biobase_2.69.1                          MatrixGenerics_1.21.0                   matrixStats_1.5.0                       rtracklayer_1.69.1                      GenomicRanges_1.61.5                    Seqinfo_0.99.2                          IRanges_2.43.5                          S4Vectors_0.47.4                        BiocGenerics_0.55.1                     generics_0.1.4                          BiocStyle_2.37.1
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1         blob_1.2.4               bitops_1.0-9             fastmap_1.2.0            RCurl_1.98-1.17          GenomicAlignments_1.45.4 XML_3.99-0.19            digest_0.6.37            lifecycle_1.0.4          pwalign_1.5.0            KEGGREST_1.49.1          RSQLite_2.4.3            magrittr_2.0.4           compiler_4.5.1           rlang_1.1.6              sass_0.4.10              tools_4.5.1              yaml_2.3.10              knitr_1.50               S4Arrays_1.9.1           bit_4.6.0                curl_7.0.0               DelayedArray_0.35.3      abind_1.4-8              BiocParallel_1.43.4      grid_4.5.1               colorspace_2.1-2         tinytex_0.57             cli_3.6.5                rmarkdown_2.30           crayon_1.5.3             httr_1.4.7               rjson_0.2.23             DBI_1.2.3                cachem_1.1.0             stringr_1.5.2            assertthat_0.2.1         parallel_4.5.1           BiocManager_1.30.26
#> [40] restfulr_0.0.16          vctrs_0.6.5              Matrix_1.7-4             jsonlite_2.0.0           bookdown_0.45            bit64_4.6.0-1            magick_2.9.0             jquerylib_0.1.4          glue_1.8.0               codetools_0.2-20         stringi_1.8.7            shape_1.4.6.1            GenomeInfoDb_1.45.12     BiocIO_1.19.0            UCSC.utils_1.5.0         tibble_3.3.0             pillar_1.11.1            htmltools_0.5.8.1        BSgenome_1.77.2          R6_2.6.1                 evaluate_1.0.5           lattice_0.22-7           png_0.1-8                memoise_2.0.1            bslib_0.9.0              Rcpp_1.1.0               SparseArray_1.9.1        xfun_0.53                pkgconfig_2.0.3          GlobalOptions_0.1.2
```
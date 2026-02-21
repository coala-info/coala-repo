# svaNUMT Quick Overview

#### Ruining Dong

#### 2025-10-30

## Introduction

This vignette outlines a workflow of detecting nuclear-mitochondrial DNA fusions from Variant Call Format (VCF) using the `svaNUMT` package.

## Using GRanges for structural variants: a breakend-centric data structure

This package uses a breakend-centric event notation adopted from the `StructuralVariantAnnotation` package. In short, breakends are stored in a GRanges object with strand used to indicate breakpoint orientation. where breakpoints are represented using a `partner` field containing the name of the breakend at the other side of the breakend. This notation was chosen as it simplifies the annotations of RTs which are detected at breakend-level.

## Workflow

### Loading data from VCF

VCF data is parsed into a `VCF` object using the `readVCF` function from the Bioconductor package `VariantAnnotation`. Simple filters could be applied to a `VCF` object to remove unwanted calls. The `VCF` object is then converted to a `GRanges` object with breakend-centric notations using `StructuralVariantAnnotation`. More information about `VCF` objects and breakend-centric GRanges object can be found by consulting the vignettes in the corresponding packages with `browseVignettes("VariantAnnotation")` and `browseVignettes("StructuralVariantAnnotation")`.

```
library(StructuralVariantAnnotation)
library(VariantAnnotation)
library(svaNUMT)

vcf <- readVcf(system.file("extdata", "chr1_numt_pe_HS25.sv.vcf", package = "svaNUMT"))
gr <- breakpointRanges(vcf)
```

Note that `StructuralVariantAnnotation` requires the `GRanges` object to be composed entirely of valid breakpoints. Please consult the vignette of the `StructuralVariantAnnotation` package for ensuring breakpoint consistency.

### Identifying Nuclear-mitochondrial Genome Fusion Events

Function `svaNUMT` searches for NUMT events by identifying breakends supporting the fusion of nuclear chromosome and mitochondrial genome. `svaNUMT` returns identified breakends supporting candidate NUMTs in 2 lists of list of GRanges, grouped by chromosome and insertion sites.

```
library(readr)
numtS <- read_table(system.file("extdata", "numtS.txt", package = "svaNUMT"),
    col_names = FALSE)
colnames(numtS) <- c("bin", "seqnames", "start", "end", "name", "score", "strand")
numtS <- GRanges(numtS)
GenomeInfoDb::seqlevelsStyle(numtS) <- "NCBI"

library(BSgenome.Hsapiens.UCSC.hg19)
genome <- BSgenome.Hsapiens.UCSC.hg19
genomeMT <- genome$chrMT
```

```
NUMT <- numtDetect(gr, numtS, genomeMT, max_ins_dist = 20)
#> There is no MT sequence from known NUMT events detected.
```

The breakends supporting the insertion sites and the MT sequence are arranged by the order of events. Below is an example of a detected NUMT event, where MT sequence `MT:15737-15836` followed by polyadenylation is inserted between `chr1:1688363-1688364`.

```
GRangesList(NU=NUMT$MT$NU$`1`[[1]], MT=NUMT$MT$MT$`1`[[1]])
#> GRangesList object of length 2:
#> $NU
#> GRanges object with 2 ranges and 13 metadata columns:
#>                seqnames    ranges strand | paramRangeID         REF
#>                   <Rle> <IRanges>  <Rle> |     <factor> <character>
#>   gridss1fb_4o        1   1688363      + |           NA           C
#>   gridss1bf_1o        1   1688364      - |           NA           C
#>                                   ALT      QUAL      FILTER     sourceId
#>                           <character> <numeric> <character>  <character>
#>   gridss1fb_4o            C[MT:15737[   3928.49        PASS gridss1fb_4o
#>   gridss1bf_1o ]MT:15836]AAAAAAAAAA..   3581.13        PASS gridss1bf_1o
#>                     partner      svtype     svLen        insSeq    insLen
#>                 <character> <character> <numeric>   <character> <integer>
#>   gridss1fb_4o gridss1fb_4h         BND        NA                       0
#>   gridss1bf_1o gridss1bf_1h         BND        NA AAAAAAAAAAAAA        13
#>                      event    HOMLEN
#>                <character> <numeric>
#>   gridss1fb_4o gridss1fb_4         0
#>   gridss1bf_1o gridss1bf_1         0
#>   -------
#>   seqinfo: 86 sequences from an unspecified genome
#>
#> $MT
#> GRanges object with 2 ranges and 13 metadata columns:
#>                seqnames    ranges strand | paramRangeID         REF
#>                   <Rle> <IRanges>  <Rle> |     <factor> <character>
#>   gridss1fb_4h       MT     15737      - |           NA           G
#>   gridss1bf_1h       MT     15836      + |           NA           A
#>                                   ALT      QUAL      FILTER     sourceId
#>                           <character> <numeric> <character>  <character>
#>   gridss1fb_4h           ]1:1688363]G   3928.49        PASS gridss1fb_4h
#>   gridss1bf_1h AAAAAAAAAAAAAA[1:168..   3581.13        PASS gridss1bf_1h
#>                     partner      svtype     svLen        insSeq    insLen
#>                 <character> <character> <numeric>   <character> <integer>
#>   gridss1fb_4h gridss1fb_4o         BND        NA                       0
#>   gridss1bf_1h gridss1bf_1o         BND        NA AAAAAAAAAAAAA        13
#>                      event    HOMLEN
#>                <character> <numeric>
#>   gridss1fb_4h gridss1fb_4         0
#>   gridss1bf_1h gridss1bf_1         0
#>   -------
#>   seqinfo: 86 sequences from an unspecified genome
```

Below is an example to subset the detected NUMTs by a genomic region given `seqnames`, `start`, and `end`. For region `chr1:1000000-3000000`, there are 3 NUMTs detected.

```
seqnames = 1
start = 1000000
end = 3000000
i <- sapply(NUMT$MT$NU[[seqnames]], function(x)
  sum(countOverlaps(x, GRanges(seqnames = seqnames, IRanges(start, end))))>0)
list(NU=NUMT$MT$NU[[seqnames]][i], MT=NUMT$MT$MT[[seqnames]][i])
#> $NU
#> $NU[[1]]
#> GRanges object with 2 ranges and 13 metadata columns:
#>                seqnames    ranges strand | paramRangeID         REF
#>                   <Rle> <IRanges>  <Rle> |     <factor> <character>
#>   gridss1fb_4o        1   1688363      + |           NA           C
#>   gridss1bf_1o        1   1688364      - |           NA           C
#>                                   ALT      QUAL      FILTER     sourceId
#>                           <character> <numeric> <character>  <character>
#>   gridss1fb_4o            C[MT:15737[   3928.49        PASS gridss1fb_4o
#>   gridss1bf_1o ]MT:15836]AAAAAAAAAA..   3581.13        PASS gridss1bf_1o
#>                     partner      svtype     svLen        insSeq    insLen
#>                 <character> <character> <numeric>   <character> <integer>
#>   gridss1fb_4o gridss1fb_4h         BND        NA                       0
#>   gridss1bf_1o gridss1bf_1h         BND        NA AAAAAAAAAAAAA        13
#>                      event    HOMLEN
#>                <character> <numeric>
#>   gridss1fb_4o gridss1fb_4         0
#>   gridss1bf_1o gridss1bf_1         0
#>   -------
#>   seqinfo: 86 sequences from an unspecified genome
#>
#> $NU[[2]]
#> GRanges object with 2 ranges and 13 metadata columns:
#>                seqnames          ranges strand | paramRangeID         REF
#>                   <Rle>       <IRanges>  <Rle> |     <factor> <character>
#>   gridss1fb_5o        1 1791082-1791083      + |           NA           G
#>   gridss1bf_2o        1         1791084      - |           NA           A
#>                                  ALT      QUAL      FILTER     sourceId
#>                          <character> <numeric> <character>  <character>
#>   gridss1fb_5o            G[MT:2592[   1929.85        PASS gridss1fb_5o
#>   gridss1bf_2o ]MT:3592]AAAAAAAAAAAA   2894.91        PASS gridss1bf_2o
#>                     partner      svtype     svLen      insSeq    insLen
#>                 <character> <character> <numeric> <character> <integer>
#>   gridss1fb_5o gridss1fb_5h         BND        NA                     0
#>   gridss1bf_2o gridss1bf_2h         BND        NA AAAAAAAAAAA        11
#>                      event    HOMLEN
#>                <character> <numeric>
#>   gridss1fb_5o gridss1fb_5         1
#>   gridss1bf_2o gridss1bf_2         0
#>   -------
#>   seqinfo: 86 sequences from an unspecified genome
#>
#> $NU[[3]]
#> GRanges object with 2 ranges and 13 metadata columns:
#>                seqnames    ranges strand | paramRangeID         REF
#>                   <Rle> <IRanges>  <Rle> |     <factor> <character>
#>   gridss2fb_3o        1   2869079      + |           NA           G
#>   gridss2bf_2o        1   2869080      - |           NA           A
#>                                   ALT      QUAL      FILTER     sourceId
#>                           <character> <numeric> <character>  <character>
#>   gridss2fb_3o             G[MT:2786[   2472.12        PASS gridss2fb_3o
#>   gridss2bf_2o ]MT:2985]AAAAAAAAAAA..   2456.81        PASS gridss2bf_2o
#>                     partner      svtype     svLen          insSeq    insLen
#>                 <character> <character> <numeric>     <character> <integer>
#>   gridss2fb_3o gridss2fb_3h         BND        NA                         0
#>   gridss2bf_2o gridss2bf_2h         BND        NA AAAAAAAAAAAAAAA        15
#>                      event    HOMLEN
#>                <character> <numeric>
#>   gridss2fb_3o gridss2fb_3         0
#>   gridss2bf_2o gridss2bf_2         0
#>   -------
#>   seqinfo: 86 sequences from an unspecified genome
#>
#>
#> $MT
#> $MT[[1]]
#> GRanges object with 2 ranges and 13 metadata columns:
#>                seqnames    ranges strand | paramRangeID         REF
#>                   <Rle> <IRanges>  <Rle> |     <factor> <character>
#>   gridss1fb_4h       MT     15737      - |           NA           G
#>   gridss1bf_1h       MT     15836      + |           NA           A
#>                                   ALT      QUAL      FILTER     sourceId
#>                           <character> <numeric> <character>  <character>
#>   gridss1fb_4h           ]1:1688363]G   3928.49        PASS gridss1fb_4h
#>   gridss1bf_1h AAAAAAAAAAAAAA[1:168..   3581.13        PASS gridss1bf_1h
#>                     partner      svtype     svLen        insSeq    insLen
#>                 <character> <character> <numeric>   <character> <integer>
#>   gridss1fb_4h gridss1fb_4o         BND        NA                       0
#>   gridss1bf_1h gridss1bf_1o         BND        NA AAAAAAAAAAAAA        13
#>                      event    HOMLEN
#>                <character> <numeric>
#>   gridss1fb_4h gridss1fb_4         0
#>   gridss1bf_1h gridss1bf_1         0
#>   -------
#>   seqinfo: 86 sequences from an unspecified genome
#>
#> $MT[[2]]
#> GRanges object with 2 ranges and 13 metadata columns:
#>                seqnames    ranges strand | paramRangeID         REF
#>                   <Rle> <IRanges>  <Rle> |     <factor> <character>
#>   gridss1fb_5h       MT 2592-2593      - |           NA           G
#>   gridss1bf_2h       MT      3592      + |           NA           G
#>                                   ALT      QUAL      FILTER     sourceId
#>                           <character> <numeric> <character>  <character>
#>   gridss1fb_5h           ]1:1791082]G   1929.85        PASS gridss1fb_5h
#>   gridss1bf_2h GAAAAAAAAAAA[1:17910..   2894.91        PASS gridss1bf_2h
#>                     partner      svtype     svLen      insSeq    insLen
#>                 <character> <character> <numeric> <character> <integer>
#>   gridss1fb_5h gridss1fb_5o         BND        NA                     0
#>   gridss1bf_2h gridss1bf_2o         BND        NA AAAAAAAAAAA        11
#>                      event    HOMLEN
#>                <character> <numeric>
#>   gridss1fb_5h gridss1fb_5         1
#>   gridss1bf_2h gridss1bf_2         0
#>   -------
#>   seqinfo: 86 sequences from an unspecified genome
#>
#> $MT[[3]]
#> GRanges object with 2 ranges and 13 metadata columns:
#>                seqnames    ranges strand | paramRangeID         REF
#>                   <Rle> <IRanges>  <Rle> |     <factor> <character>
#>   gridss2fb_3h       MT      2786      - |           NA           T
#>   gridss2bf_2h       MT      2985      + |           NA           C
#>                                   ALT      QUAL      FILTER     sourceId
#>                           <character> <numeric> <character>  <character>
#>   gridss2fb_3h           ]1:2869079]T   2472.12        PASS gridss2fb_3h
#>   gridss2bf_2h CAAAAAAAAAAAAAAA[1:2..   2456.81        PASS gridss2bf_2h
#>                     partner      svtype     svLen          insSeq    insLen
#>                 <character> <character> <numeric>     <character> <integer>
#>   gridss2fb_3h gridss2fb_3o         BND        NA                         0
#>   gridss2bf_2h gridss2bf_2o         BND        NA AAAAAAAAAAAAAAA        15
#>                      event    HOMLEN
#>                <character> <numeric>
#>   gridss2fb_3h gridss2fb_3         0
#>   gridss2bf_2h gridss2bf_2         0
#>   -------
#>   seqinfo: 86 sequences from an unspecified genome
```

## Visualising breakpoint pairs via circos plots

One way of visualising paired breakpoints is by circos plots. Here we use the package [`circlize`](https://doi.org/10.1093/bioinformatics/btu393) to demonstrate breakpoint visualisation. The `bedpe2circos` function takes BEDPE-formatted dataframes (see `breakpointgr2bedpe()`) and plotting parameters for the `circos.initializeWithIdeogram()` and `circos.genomicLink()` functions from `circlize`.

To generate a simple circos plot of one candidate NUMT event:

```
library(circlize)
numt_chr_prefix <- c(NUMT$MT$NU$`1`[[2]], NUMT$MT$MT$`1`[[2]])
GenomeInfoDb::seqlevelsStyle(numt_chr_prefix) <- "UCSC"
pairs <- breakpointgr2pairs(numt_chr_prefix)
pairs
```

To see supporting breakpoints clearly, we generate the circos plot according to the loci of event.

```
circos.initializeWithIdeogram(
    data.frame(V1=c("chr1", "chrM"),
               V2=c(1791073,1),
               V3=c(1791093,16571),
               V4=c("p15.4",NA),
               V5=c("gpos50",NA)),  sector.width = c(0.2, 0.8))
#circos.initializeWithIdeogram()
circos.genomicLink(as.data.frame(S4Vectors::first(pairs)),
                   as.data.frame(S4Vectors::second(pairs)))
```

![](data:image/png;base64...)

```
circos.clear()
```

## SessionInfo

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
#>  [1] circlize_0.4.16                    BSgenome.Hsapiens.UCSC.hg19_1.4.3
#>  [3] BSgenome_1.78.0                    BiocIO_1.20.0
#>  [5] readr_2.1.5                        svaNUMT_1.16.0
#>  [7] StructuralVariantAnnotation_1.26.0 VariantAnnotation_1.56.0
#>  [9] Rsamtools_2.26.0                   Biostrings_2.78.0
#> [11] XVector_0.50.0                     SummarizedExperiment_1.40.0
#> [13] Biobase_2.70.0                     MatrixGenerics_1.22.0
#> [15] matrixStats_1.5.0                  rtracklayer_1.70.0
#> [17] GenomicRanges_1.62.0               Seqinfo_1.0.0
#> [19] IRanges_2.44.0                     S4Vectors_0.48.0
#> [21] BiocGenerics_0.56.0                generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1         dplyr_1.1.4              blob_1.2.4
#>  [4] bitops_1.0-9             fastmap_1.2.0            RCurl_1.98-1.17
#>  [7] GenomicAlignments_1.46.0 XML_3.99-0.19            digest_0.6.37
#> [10] lifecycle_1.0.4          pwalign_1.6.0            KEGGREST_1.50.0
#> [13] RSQLite_2.4.3            magrittr_2.0.4           compiler_4.5.1
#> [16] rlang_1.1.6              sass_0.4.10              tools_4.5.1
#> [19] yaml_2.3.10              knitr_1.50               S4Arrays_1.10.0
#> [22] bit_4.6.0                curl_7.0.0               DelayedArray_0.36.0
#> [25] abind_1.4-8              BiocParallel_1.44.0      withr_3.0.2
#> [28] grid_4.5.1               colorspace_2.1-2         cli_3.6.5
#> [31] rmarkdown_2.30           crayon_1.5.3             httr_1.4.7
#> [34] tzdb_0.5.0               rjson_0.2.23             DBI_1.2.3
#> [37] cachem_1.1.0             stringr_1.5.2            assertthat_0.2.1
#> [40] parallel_4.5.1           AnnotationDbi_1.72.0     restfulr_0.0.16
#> [43] vctrs_0.6.5              Matrix_1.7-4             jsonlite_2.0.0
#> [46] hms_1.1.4                bit64_4.6.0-1            GenomicFeatures_1.62.0
#> [49] jquerylib_0.1.4          glue_1.8.0               codetools_0.2-20
#> [52] stringi_1.8.7            shape_1.4.6.1            GenomeInfoDb_1.46.0
#> [55] UCSC.utils_1.6.0         tibble_3.3.0             pillar_1.11.1
#> [58] htmltools_0.5.8.1        R6_2.6.1                 evaluate_1.0.5
#> [61] lattice_0.22-7           png_0.1-8                cigarillo_1.0.0
#> [64] memoise_2.0.1            bslib_0.9.0              SparseArray_1.10.0
#> [67] xfun_0.53                pkgconfig_2.0.3          GlobalOptions_0.1.2
```
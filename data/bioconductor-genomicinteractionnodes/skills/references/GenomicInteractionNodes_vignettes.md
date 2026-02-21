# GenomicInteractionNodes Guide

Jianhong Ou, Yu Xiang, Xiaolin Wei, and Yarui Diao

#### 30 October 2025

#### Package

GenomicInteractionNodes 1.14.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Quick start](#quick-start)
* [4 Session Info](#session-info)

# 1 Introduction

The profiles of genome interactions can be categorized into three levels:
loops, domains and compartments.
Cis-regulatory elements (cREs) regulate the distal target gene expression
through three-dimensional chromatin looping.
Most of these loops occur within the boundaries of topologically
associating domains (TADs).
The TAD boundaries are enriched for insulator binding proteins.
HiC analysis revealed the TADs can be segregated into an active (A)
and inactive (B) compartment.
TADs are megabase-sized chromosomal regions where the loop sizes may
very from thousand bases to mega bases.
We know that not all the loops within one TADs are involved in single
binding platform.
There are hundreds or even thousands binding platforms even in a single TAD.
Batut et al. report the ‘tethering element’ help to establish
long-range enhancer-promoter interactions.
Tethering elements are the one kind of the binding platform
which bring together enhancers and promoters for rapid gene activation.
For each binding platform, multiple loops may work together to work
as a single function, such as repression or promotion one or more
distal target gene expression.
That means multiple promoters and enhancers may bind together to perform
as super enhancer or regulatory elements.

We defined such kind of binding platform as genomic interaction node or
interaction hot spot.
The interaction node can be a tethering element working as node,
or a super-enhancer (or super regulatory element region).
It is a level of genome organization higher than loops but smaller than TADs.
It is a kind of tethering element with multiple interaction loops.

The interaction node has two attributes:
1. it must contain multiple interaction loops,
2. it regulates one or more target genes.

To help users to define the interaction nodes, we developed the
`Bioconductor` package: `GenomicInteractionNodes`.
The `GenomicInteractionNodes` package will define the interaction node
by testing the involved loops within one connected component
by Poisson distribution. The annotated loops will be used for
enrichment analysis.

# 2 Installation

You can install the package via `devtools::install_github` from `github`.

```
library(devtools)
install_github("jianhong/GenomicInteractionNodes")
```

You can also try to install it via `BiocManager::install` when it is ready in Bioconductor.

```
library(BiocManager)
install("GenomicInteractionNodes")
```

# 3 Quick start

Here is an example to use `GenomicInteractionNodes` to define interaction nodes
and do downstream enrichment analysis.

There are three steps,

1. `detectNodes`, define the nodes.
2. `annotateNodes`, annotate the nodes for downstream analysis.
3. `enrichmentAnalysis`, Gene Ontology enrichment analysis.

```
## load library
library(GenomicInteractionNodes)
library(rtracklayer)
library(TxDb.Hsapiens.UCSC.hg19.knownGene) ## for human hg19
library(org.Hs.eg.db) ## used to convert gene_id to gene_symbol
library(GO.db) ## used for enrichment analysis

## import the interactions from bedpe file
p <- system.file("extdata", "WT.2.bedpe",
                 package = "GenomicInteractionNodes")
#### please try to replace the connection to your file path
interactions <- import(con=p, format="bedpe")

## define the nodes
nodes <- detectNodes(interactions)
names(nodes)
```

```
## [1] "node_connection" "nodes"           "node_regions"
```

```
lapply(nodes, head, n=2)
```

```
## $node_connection
## Pairs object with 2 pairs and 3 metadata columns:
##                         first                  second |        name     score
##                     <GRanges>               <GRanges> | <character> <numeric>
##   [1] chr22:20003029-20003427 chr22:51213576-51213946 |           *   7.38906
##   [2] chr22:40149276-40149674 chr22:51213576-51213946 |           *   7.38906
##           comp_id
##       <character>
##   [1]          24
##   [2]          24
##
## $nodes
## GRanges object with 2 ranges and 1 metadata column:
##       seqnames            ranges strand |   comp_id
##          <Rle>         <IRanges>  <Rle> | <integer>
##   [1]    chr22 26964172-26964589      * |       106
##   [2]    chr22 27077493-27077713      * |       111
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $node_regions
## GRanges object with 2 ranges and 1 metadata column:
##       seqnames            ranges strand |     comp_id
##          <Rle>         <IRanges>  <Rle> | <character>
##   [1]    chr22 20003029-20003427      * |          24
##   [2]    chr22 40149276-40149674      * |          24
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
## annotate the nodes by gene promoters
node_regions <- nodes$node_regions
node_regions <- annotateNodes(node_regions,
                        txdb=TxDb.Hsapiens.UCSC.hg19.knownGene,
                        orgDb=org.Hs.eg.db,
                        upstream=2000, downstream=500)
head(node_regions, n=2)
```

```
## GRanges object with 2 ranges and 3 metadata columns:
##       seqnames            ranges strand |     comp_id gene_id symbols
##          <Rle>         <IRanges>  <Rle> | <character>  <List>  <List>
##   [1]    chr22 20003029-20003427      * |          24  128989  TANGO2
##   [2]    chr22 40149276-40149674      * |          24    <NA>    <NA>
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
## Gene Ontology enrichment analysis
enrich <- enrichmentAnalysis(node_regions, orgDb=org.Hs.eg.db)
names(enrich$enriched)
```

```
## [1] "BP" "CC" "MF"
```

```
names(enrich$enriched_in_compound)
```

```
## [1] "BP" "CC" "MF"
```

```
res <- enrich$enriched$BP
res <- res[order(res$fdr), ]
head(res, n=2)
```

```
##                    GO
## GO:0002395 GO:0002395
## GO:0032506 GO:0032506
##                                                                    term
## GO:0002395 immune response in nasopharyngeal-associated lymphoid tissue
## GO:0032506                                          cytokinetic process
##                                                                                                                                          definition
## GO:0002395         An immune response taking place in the nasopharyngeal-associated lymphoid tissue (NALT). NALT includes the tonsils and adenoids.
## GO:0032506 A cellular process that is involved in cytokinesis (the division of the cytoplasm of a cell and its separation into two daughter cells).
##                 pvalue        fdr countInDataset countInGenome
## GO:0002395 0.001590078 0.08888534              1             2
## GO:0032506 0.000765112 0.08888534              2            52
##            totalGeneInDataset totalGeneInGenome geneInDataset
## GO:0002395                 15             18860         TTLL1
## GO:0032506                 15             18860    MYH9;MTMR3
```

# 4 Session Info

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
##  [1] GO.db_3.22.0
##  [2] org.Hs.eg.db_3.22.0
##  [3] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [4] GenomicFeatures_1.62.0
##  [5] AnnotationDbi_1.72.0
##  [6] Biobase_2.70.0
##  [7] rtracklayer_1.70.0
##  [8] GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0
## [10] IRanges_2.44.0
## [11] S4Vectors_0.48.0
## [12] BiocGenerics_0.56.0
## [13] generics_0.1.4
## [14] GenomicInteractionNodes_1.14.0
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0             SummarizedExperiment_1.40.0
##  [3] rjson_0.2.23                xfun_0.53
##  [5] bslib_0.9.0                 lattice_0.22-7
##  [7] vctrs_0.6.5                 tools_4.5.1
##  [9] bitops_1.0-9                curl_7.0.0
## [11] parallel_4.5.1              RSQLite_2.4.3
## [13] blob_1.2.4                  pkgconfig_2.0.3
## [15] Matrix_1.7-4                cigarillo_1.0.0
## [17] graph_1.88.0                lifecycle_1.0.4
## [19] compiler_4.5.1              Rsamtools_2.26.0
## [21] Biostrings_2.78.0           codetools_0.2-20
## [23] htmltools_0.5.8.1           sass_0.4.10
## [25] RCurl_1.98-1.17             yaml_2.3.10
## [27] crayon_1.5.3                jquerylib_0.1.4
## [29] BiocParallel_1.44.0         DelayedArray_0.36.0
## [31] cachem_1.1.0                abind_1.4-8
## [33] digest_0.6.37               restfulr_0.0.16
## [35] bookdown_0.45               grid_4.5.1
## [37] fastmap_1.2.0               SparseArray_1.10.0
## [39] cli_3.6.5                   S4Arrays_1.10.0
## [41] RBGL_1.86.0                 XML_3.99-0.19
## [43] bit64_4.6.0-1               rmarkdown_2.30
## [45] XVector_0.50.0              httr_1.4.7
## [47] matrixStats_1.5.0           bit_4.6.0
## [49] png_0.1-8                   memoise_2.0.1
## [51] evaluate_1.0.5              knitr_1.50
## [53] BiocIO_1.20.0               rlang_1.1.6
## [55] DBI_1.2.3                   BiocManager_1.30.26
## [57] jsonlite_2.0.0              R6_2.6.1
## [59] MatrixGenerics_1.22.0       GenomicAlignments_1.46.0
```
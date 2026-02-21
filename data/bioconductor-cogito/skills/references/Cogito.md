# Cogito: Compare annotated genomic intervals tool

Annika Buerger

#### 2025-10-29

#### Package

Cogito 1.16.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Workflow](#workflow)
* [4 References](#References)
* **Appendix**
* [A Session Information](#session-information)

# 1 Introduction

Biological studies often consist of multiple conditions which are examined
with different laboratory set ups like RNA-sequencing or ChIP-sequencing. To get
an overview about the whole resulting data set, **Cogito** provides an automated
and complete report about all samples and basic comparisons between all
different samples. This overview can be used as documentation about the data
set or as starting point for further custom analysis.

Cogito is not meant to do detailed genetic or epigenetic analysis. But provides
a reproducible and clear report about data sets consisting of samples of
different conditions and mesuared with different laboratory base technologies.

# 2 Installation

The package can be installed via `Bioconductor` and loaded into R by typing

```
BiocManager::install("Cogito")
library("Cogito")
```

into the R console.

# 3 Workflow

The workflow of Cogito consists of two main functions:

1. `aggregateRanges(ranges, configfile, organism,`
   `referenceRanges, name, verbose)`
2. `summarizeRanges(aggregated.ranges, outputFormat, verbose)`

The process is demonstrated using a small murine example. The data set from
King et al.111 [4](#References) was downloaded from the NCBI GEO database under
accession number
[GSE77004](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE77004) and
preprocessed222 for details on preprocessing of the data have a look at the
manual pages of the single data sets to `GRanges`/`GRangesList` objects and
restricted to chromosome 5 to save space and processing time.

This example data set is loaded with the package and consists of three data
objects.

The first `GRanges` object contains gene expression values from RNA-sequencing
with 1195 ranges and 11
columns with the corresponding expression values. Each column represents an
experimental condition.

```
head(MurEpi.RNA.small[, 1:3])
```

```
## GRanges object with 6 ranges and 3 metadata columns:
##       seqnames              ranges strand |   J1.RPKM  TKO.RPKM TKO3a1_1.RPKM
##          <Rle>           <IRanges>  <Rle> | <numeric> <numeric>     <numeric>
##   [1]     chr5 101234211-101249984      - |     7.904     7.142         8.420
##   [2]     chr5   73039035-73062317      + |     0.101     0.344         0.431
##   [3]     chr5     6769030-6876523      - |     0.000     0.000         0.011
##   [4]     chr5 115303673-115333668      + |     0.150     0.000         0.022
##   [5]     chr5     3657004-3680325      + |     0.000     0.000         0.000
##   [6]     chr5     3583978-3596585      - |     8.752     6.195         8.677
##   -------
##   seqinfo: 35 sequences (1 circular) from mm9 genome
```

The second `GRanges` object contains information about the methylation status
from RRBS. The object has 147644 ranges and
14 columns with the corresponding methylation
status. Where there is not information about the methylation status the value
is `NA`. Each column represents an experimental condition.

```
head(MurEpi.RRBS.small[, 1:3])
```

```
## GRanges object with 6 ranges and 3 metadata columns:
##       seqnames          ranges strand | J1_1.Methylation status
##          <Rle>       <IRanges>  <Rle> |               <ordered>
##   [1]     chr5 3021138-3021139      * |                    high
##   [2]     chr5 3021182-3021183      * |                    high
##   [3]     chr5 3021357-3021358      * |                    high
##   [4]     chr5 3021446-3021447      * |                    high
##   [5]     chr5 3025756-3025757      * |                    high
##   [6]     chr5 3025763-3025764      * |                    high
##       J1_2.Methylation status DKO.Methylation status
##                     <ordered>              <ordered>
##   [1]                  medium                 low
##   [2]                  medium                 low
##   [3]                  NA                     low
##   [4]                  NA                     medium
##   [5]                  high                   medium
##   [6]                  high                   low
##   -------
##   seqinfo: 35 sequences (1 circular) from mm9 genome
```

The third object is a `GRangesList` object containing
36 `GRanges` object. Each of this objects
represents an experimental condition and contains between
10 and
2468 ranges with one column of
attached value each. This value is the peak score resulting from the peak
calling with *homer findPeaks*333 [4](#References).

```
head(MurEpi.ChIP.small[[1]])
```

```
## GRanges object with 6 ranges and 1 metadata column:
##       seqnames              ranges strand | Homer peak score
##          <Rle>           <IRanges>  <Rle> |        <numeric>
##   [1]     chr5 125869822-125870015      * |              282
##   [2]     chr5 114221367-114221560      * |              273
##   [3]     chr5 115729732-115729925      * |              269
##   [4]     chr5 122734457-122734650      * |              265
##   [5]     chr5 124875261-124875454      * |              275
##   [6]     chr5 117565637-117565830      * |              263
##   -------
##   seqinfo: 35 sequences (1 circular) from mm9 genome
```

The data set consists of the following samples:

Table 1: Overview of murine example data set
There are several samples
of different conditions (*J1*, *TKO*, …) and base technologies (RNA-seq,
RRBS and ChIP-seq).

|  | RNA-seq | RRBS | ChIP-seq |
| --- | --- | --- | --- |
| **J1** | 1 | 2 | 5 |
| **TKO** | 1 | 2 | 5 |
| **TKO3a1** | 2 | 2 | 4 |
| **TKO3a2** | 2 | 2 | 5 |
| **TKO3b1** | 1 | 2 | 4 |
| **DKO** | 1 | 1 | 4 |
| **DKO3a1** | 1 | 1 | 3 |
| **DKO3a2** | 1 | 1 | 3 |
| **DKO3b1** | 1 | 1 | 3 |

The function `aggregateRanges` is called with the example data set and the
corresponding genomic information.

```
mm9 <- TxDb.Mmusculus.UCSC.mm9.knownGene::TxDb.Mmusculus.UCSC.mm9.knownGene

example.dataset <- list(ChIP = MurEpi.ChIP.small,
                        RNA = MurEpi.RNA.small,
                        RRBS = MurEpi.RRBS.small)

aggregated.ranges <- aggregateRanges(ranges = example.dataset,
                                        organism = mm9,
                                        name = "murine.example")
```

```
##   84 genes were dropped because they have exons located on both strands of the
##   same reference sequence or on more than one reference sequence, so cannot be
##   represented by a single genomic range.
##   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList
##   object, or use suppressMessages() to suppress this message.
```

The function aggregates all provided data to the genes of the genome, given in
the parameter `organism`: all single `IRanges` are assigned to the closest
gene within a predefined default maximal distance of 100.000bp. This
parameter can be changed in the configuration file if necessary. Consequently,
the columns of attached values of each provided `IRanges` object are assigned
to the corresponding gene. The result is one single `GRanges` object, each row
representing a gene and each column a sample of the provided input data.

The function `aggregateRanges` returns a `list` object containing this single
`GRanges` objects, i.e. a `GRanges` object with rows representing genes with
columns of attached values `mcols` where each column contains values from a
specific experimental condition (such as *wildtype*) and a specific underlying
base technology (such as RNA-seq expression).

```
head(aggregated.ranges$genes[, c(1, 2:3, 13:14, 27:28)])
```

```
## GRanges object with 6 ranges and 7 metadata columns:
##         seqnames          ranges strand |     gene_id RNA.J1.RPKM RNA.TKO.RPKM
##            <Rle>       <IRanges>  <Rle> | <character>   <numeric>    <numeric>
##   12571     chr5 3343893-3522225      + |       12571       5.647        3.996
##   68152     chr5 3543833-3570546      + |       68152          NA           NA
##   77036     chr5 3571716-3584341      + |       77036       3.176        1.396
##   71382     chr5 3596066-3637101      + |       71382       5.631        5.225
##   75010     chr5 3657004-3680325      + |       75010       0.000        0.000
##   79264     chr5 3803165-3844515      + |       79264          NA           NA
##         RRBS.J1_1.Methylation status RRBS.J1_2.Methylation status
##                            <ordered>                    <ordered>
##   12571                         low                        low
##   68152                         low                        low
##   77036                         high                       high
##   71382                         low                        low
##   75010                         high                       medium
##   79264                         low                        low
##         ChIP.H3K4me3_J1.Homer peak score ChIP.H3K4me3_TKO.Homer peak score
##                                <numeric>                         <numeric>
##   12571                              111                                83
##   68152                              199                               164
##   77036                               NA                                NA
##   71382                              212                               186
##   75010                               NA                                NA
##   79264                              199                               163
##   -------
##   seqinfo: 35 sequences (1 circular) from mm9 genome
```

The return value of the function `aggregateRanges` as well contains information
about the supposed underlying base technologies and conditions.

```
lapply(aggregated.ranges$config$technologies, head, 3)
```

```
## $ChIP
## [1] "ChIP.H3K4me3_J1.Homer peak score"
## [2] "ChIP.H3K4me3_TKO.Homer peak score"
## [3] "ChIP.H3K4me3_TKO3a2.Homer peak score"
##
## $RNA
## [1] "RNA.J1.RPKM"       "RNA.TKO.RPKM"      "RNA.TKO3a1_1.RPKM"
##
## $RRBS
## [1] "RRBS.J1_1.Methylation status" "RRBS.J1_2.Methylation status"
## [3] "RRBS.DKO.Methylation status"
```

```
head(lapply(aggregated.ranges$config$conditions, head, 3), 3)
```

```
## $J1
## [1] "RNA.J1.RPKM"                  "RRBS.J1_1.Methylation status"
## [3] "RRBS.J1_2.Methylation status"
##
## $TKO
## [1] "RNA.TKO.RPKM"                  "RRBS.TKO_1.Methylation status"
## [3] "RRBS.TKO_2.Methylation status"
##
## $TKO3a1
## [1] "RNA.TKO3a1_1.RPKM"                "RNA.TKO3a1_2.RPKM"
## [3] "RRBS.TKO3a1_1.Methylation status"
```

To advance in the workflow, these two `list`s should be carefully checked and
corrected if necessary. Also it is possible to add user defined groups of
conditions to include them in the following analysis.

```
summarizeRanges(aggregated.ranges = aggregated.ranges)
```

The function `summarizeRanges` does not has a return value but produces three
output files:

The main result is the report about the given data in a pdf (or html). The report
is divided into four chapters. The introduction holds general information about
the underlying data set as the numbers of conditions (*wildtype* etc.) and used
base technologies (ChIP-seq, RNA-seq, etc.).

The first chapter contains summaries about each single column of attached
values, consisting of a location and a dispersion parameter as well as a plot
for a visual impression.
There are 61 samples in total included
in the presented murine example data set.

The second chapter summarizes groups of columns of attached values which have
the same condition and the same base technology, for example if there are two
RNA-sequencing replicates of the condition *wildtpye* present.
In the given murine example data set there are among others 2 samples of
methylation status examined with RRBS in the condition *J1*, 5 samples of
condition *J1* of ChIP-seq experiments and 2 RNA-seq samples of condition
*TKO3a1*, see table [1](#tab:table). Consequentely, this results in 16 plots
in total.

The third chapter summarizes groups of columns of attached values which are
examined by the same base technology but do not necessarily have the same
underlying condition. This is visualized in an appropriate plot.
The presented murine example has three involved base technologies: RNA-seq,
ChIP-seq and RRBS.

Finally the fourth chapter compares every column of attached value to every
other column of attached value. The comparison is visualized with an appropriate
plot and a correlation test is made. Because this section may be long, the
report concentrates on comparisons where a significant correlation is found
(corrected p-value < 0.01).
In the exemplary murine data set there are
61 columns of attached values, so this
results in `(61*60)/2=1830` comparisons, but of not all of them show a
significant correlation.

Besides the pdf report the function `summarizeRanges` also produces a rmd file
with which the user may customize the report or take it as a starting point for
further analysis, as well as a RData file which holds all used processed data.

# 4 References

# Appendix

King AD, Huang K, Rubbi L, Liu S, Wang CY, Wang Y, Pellegrini M, Fan G.
**Reversible Regulation of Promoter and Enhancer Histone Landscape by DNA
Methylation in Mouse Embryonic Stem Cells.**
Cell Rep. 2016 Sep 27;17(1):289-302. doi: 10.1016/j.celrep.2016.08.083

Heinz S, Benner C, Spann N, Bertolino E, Lin YC, Laslo P, Cheng JX, Murre C,
Singh H, Glass CK.
**Simple combinations of lineage-determining transcription
factors prime cis-regulatory elements required for macrophage and B cell
identities.**
Mol Cell. 2010 May 28;38(4):576-89. doi: 10.1016/j.molcel.2010.05.004

The color scheme used by Cogito was generated with help of:
[iWantHue](https://medialab.github.io/iwanthue/) by Mathieu Jacomy at the at
the [Sciences-Po Medialab](http://medialab.sciences-po.fr/)

# A Session Information

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
##  [1] Cogito_1.16.0          entropy_1.3.2          GenomicFeatures_1.62.0
##  [4] AnnotationDbi_1.72.0   Biobase_2.70.0         jsonlite_2.0.0
##  [7] GenomicRanges_1.62.0   Seqinfo_1.0.0          IRanges_2.44.0
## [10] S4Vectors_0.48.0       BiocGenerics_0.56.0    generics_0.1.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0
##  [2] SummarizedExperiment_1.40.0
##  [3] gtable_0.3.6
##  [4] TxDb.Mmusculus.UCSC.mm9.knownGene_3.2.2
##  [5] ggplot2_4.0.0
##  [6] rjson_0.2.23
##  [7] xfun_0.53
##  [8] bslib_0.9.0
##  [9] lattice_0.22-7
## [10] vctrs_0.6.5
## [11] tools_4.5.1
## [12] bitops_1.0-9
## [13] curl_7.0.0
## [14] parallel_4.5.1
## [15] tibble_3.3.0
## [16] RSQLite_2.4.3
## [17] blob_1.2.4
## [18] pkgconfig_2.0.3
## [19] Matrix_1.7-4
## [20] RColorBrewer_1.1-3
## [21] S7_0.2.0
## [22] cigarillo_1.0.0
## [23] lifecycle_1.0.4
## [24] farver_2.1.2
## [25] compiler_4.5.1
## [26] Rsamtools_2.26.0
## [27] Biostrings_2.78.0
## [28] codetools_0.2-20
## [29] htmltools_0.5.8.1
## [30] sass_0.4.10
## [31] RCurl_1.98-1.17
## [32] yaml_2.3.10
## [33] pillar_1.11.1
## [34] crayon_1.5.3
## [35] jquerylib_0.1.4
## [36] BiocParallel_1.44.0
## [37] cachem_1.1.0
## [38] DelayedArray_0.36.0
## [39] abind_1.4-8
## [40] tidyselect_1.2.1
## [41] digest_0.6.37
## [42] dplyr_1.1.4
## [43] restfulr_0.0.16
## [44] bookdown_0.45
## [45] fastmap_1.2.0
## [46] grid_4.5.1
## [47] cli_3.6.5
## [48] SparseArray_1.10.0
## [49] magrittr_2.0.4
## [50] S4Arrays_1.10.0
## [51] dichromat_2.0-0.1
## [52] XML_3.99-0.19
## [53] scales_1.4.0
## [54] bit64_4.6.0-1
## [55] rmarkdown_2.30
## [56] XVector_0.50.0
## [57] httr_1.4.7
## [58] matrixStats_1.5.0
## [59] bit_4.6.0
## [60] png_0.1-8
## [61] memoise_2.0.1
## [62] evaluate_1.0.5
## [63] knitr_1.50
## [64] BiocIO_1.20.0
## [65] rtracklayer_1.70.0
## [66] rlang_1.1.6
## [67] glue_1.8.0
## [68] DBI_1.2.3
## [69] BiocManager_1.30.26
## [70] R6_2.6.1
## [71] MatrixGenerics_1.22.0
## [72] GenomicAlignments_1.46.0
```
# crisprBwa: alignment of gRNA spacer sequences using BWA

Jean-Philippe Fortin1\*

1Department of Data Science and Statistical Computing, gRED, Genentech

\*fortin946@gmail.com

#### 2025-10-29

# 1 Overview of crisprBwa

`crisprBwa` provides two main functions to align short DNA sequences to
a reference genome using the short read aligner BWA-backtrack (Li and Durbin [2009](#ref-bwa))
and return the alignments as R objects: `runBwa` and `runCrisprBwa`.
It utilizes the Bioconductor package `Rbwa` to access the BWA program
in a platform-independent manner. This means that users do not need to install
BWA prior to using `crisprBwa`.

The latter function (`runCrisprBwa`) is specifically designed
to map and annotate CRISPR guide RNA (gRNA) spacer sequences using
CRISPR nuclease objects and CRISPR genomic arithmetics defined in
the Bioconductor package [crisprBase](https://github.com/crisprVerse/crisprBase).
This enables a fast and accurate on-target and off-target search of
gRNA spacer sequences for virtually any type of CRISPR nucleases.
It also provides an off-target search engine for our main gRNA design package [crisprDesign](https://github.com/crisprVerse/crisprDesign) of the
[crisprVerse](https://github.com/crisprVerse) ecosystem. See the
`addSpacerAlignments` function in `crisprDesign` for more details.

# 2 Installation and getting started

## 2.1 Software requirements

### 2.1.1 OS Requirements

This package is supported for macOS and Linux only.
Package was developed and tested on R version 4.2.1.

### 2.1.2 R Dependencies

* crisprBase: <https://github.com/Jfortin1/crisprBase>
* RBwa: <https://github.com/Jfortin1/Rbwa>

## 2.2 Installation from Bioconductor

`crisprBwa` can be installed from from the Bioconductor devel branch
using the following commands in a fresh R session:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(version="devel")
BiocManager::install("crisprBwa")
```

# 3 Building a bwa index

To use `runBwa` or `runCrisprBwa`, users need to first build a BWA
genome index. For a given genome, this step has to be done only once.
The `Rbwa` package conveniently provides the function `bwa_build_index`
to build a BWA index from any custom genome from a FASTA file.

As an example, we build a BWA index for a small portion of the human
chromosome 12 (`chr12.fa` file provided in the `crisprBwa` package) and
save the index file as `myIndex` to a temporary directory:

```
library(Rbwa)
fasta <- system.file(package="crisprBwa", "example/chr12.fa")
outdir <- tempdir()
index <- file.path(outdir, "chr12")
Rbwa::bwa_build_index(fasta,
                      index_prefix=index)
```

To learn how to create a BWA index for a complete genome or transcriptome,
please visit our [tutorial page](https://github.com/crisprVerse/Tutorials/tree/master/Building_Genome_Indices).

# 4 Alignment using `runCrisprBwa`

As an example, we align 5 spacer sequences (of length 20bp) to the
custom genome built above, allowing a maximum of 3 mismatches between the
spacer and protospacer sequences.

We specify that the search is for the wildtype Cas9 (SpCas9) nuclease
by providing the `CrisprNuclease` object `SpCas9` available through the
`crisprBase` package. The argument `canonical=FALSE` specifies that
non-canonical PAM sequences are also considered (NAG and NGA for SpCas9).
The function `getAvailableCrisprNucleases` in `crisprBase` returns a character
vector of available `crisprNuclease` objects found in `crisprBase`.

We also need to provide a `BSgenome` object corresponding to the reference
genome used for alignment to extract protospacer and PAM sequences of the
target sequences.

```
library(crisprBwa)
library(BSgenome.Hsapiens.UCSC.hg38)
```

```
## Loading required package: GenomeInfoDb
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
## Loading required package: S4Vectors
```

```
## Loading required package: stats4
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: BSgenome
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: Biostrings
```

```
## Loading required package: XVector
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

```
## Loading required package: BiocIO
```

```
## Loading required package: rtracklayer
```

```
data(SpCas9, package="crisprBase")
crisprNuclease <- SpCas9
bsgenome <- BSgenome.Hsapiens.UCSC.hg38
spacers <- c("AGCTGTCCGTGGGGGTCCGC",
             "CCCCTGCTGCTGTGCCAGGC",
             "ACGAACTGTAAAAGGCTTGG",
             "ACGAACTGTAACAGGCTTGG",
             "AAGGCCCTCAGAGTAATTAC")
runCrisprBwa(spacers,
             bsgenome=bsgenome,
             crisprNuclease=crisprNuclease,
             n_mismatches=3,
             canonical=FALSE,
             bwa_index=index)
```

```
## [runCrisprBwa] Using BSgenome.Hsapiens.UCSC.hg38
## [runCrisprBwa] Searching for SpCas9 protospacers
```

```
##                 spacer          protospacer pam   chr pam_site strand
## 1 AAGGCCCTCAGAGTAATTAC AAGGCCCTCAGAGTAATTAC AGA chr12   170636      +
## 2 ACGAACTGTAAAAGGCTTGG ACGAACTGTAAAAGGCTTGG AGG chr12   170815      -
## 3 ACGAACTGTAACAGGCTTGG ACGAACTGTAAAAGGCTTGG AGG chr12   170815      -
## 4 AGCTGTCCGTGGGGGTCCGC AGCTGTCCGTGGGGGTCCGC AGG chr12   170585      +
## 5 CCCCTGCTGCTGTGCCAGGC CCCCTGCTGCTGTGCCAGGC CGG chr12   170609      +
##   n_mismatches canonical
## 1            0     FALSE
## 2            0      TRUE
## 3            1      TRUE
## 4            0      TRUE
## 5            0      TRUE
```

# 5 Applications beyond CRISPR

The function `runBwa` is similar to `runCrisprBwa`,
but does not impose constraints on PAM sequences.
It can be used to search for any short read sequence in a genome.

## 5.1 Example using RNAi (siRNA design)

Seed-related off-targets caused by mismatch tolerance outside of the
seed region is a well-studied and characterized problem observed in RNA
interference (RNAi) experiments. `runBWa` can be used to map shRNA/siRNA seed
sequences to reference genomes to predict putative off-targets:

```
seeds <- c("GTAAGCGGAGTGT", "AACGGGGAGATTG")
runBwa(seeds,
       n_mismatches=2,
       bwa_index=index)
```

```
##           query   chr    pos strand n_mismatches
## 1 AACGGGGAGATTG chr12  68337      -            2
## 2 AACGGGGAGATTG chr12   1666      -            2
## 3 AACGGGGAGATTG chr12 123863      +            2
## 4 AACGGGGAGATTG chr12 151731      -            2
## 5 AACGGGGAGATTG chr12 110901      +            2
## 6 GTAAGCGGAGTGT chr12 101550      -            2
```

# 6 Reproducibility

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
##  [1] BSgenome.Hsapiens.UCSC.hg38_1.4.5 BSgenome_1.78.0
##  [3] rtracklayer_1.70.0                BiocIO_1.20.0
##  [5] Biostrings_2.78.0                 XVector_0.50.0
##  [7] GenomicRanges_1.62.0              GenomeInfoDb_1.46.0
##  [9] Seqinfo_1.0.0                     IRanges_2.44.0
## [11] S4Vectors_0.48.0                  BiocGenerics_0.56.0
## [13] generics_0.1.4                    crisprBwa_1.14.0
## [15] Rbwa_1.14.0                       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 rjson_0.2.23
##  [3] xfun_0.53                   bslib_0.9.0
##  [5] Biobase_2.70.0              lattice_0.22-7
##  [7] tzdb_0.5.0                  vctrs_0.6.5
##  [9] tools_4.5.1                 bitops_1.0-9
## [11] curl_7.0.0                  parallel_4.5.1
## [13] tibble_3.3.0                pkgconfig_2.0.3
## [15] Matrix_1.7-4                cigarillo_1.0.0
## [17] lifecycle_1.0.4             compiler_4.5.1
## [19] stringr_1.5.2               Rsamtools_2.26.0
## [21] codetools_0.2-20            htmltools_0.5.8.1
## [23] sass_0.4.10                 RCurl_1.98-1.17
## [25] yaml_2.3.10                 pillar_1.11.1
## [27] crayon_1.5.3                jquerylib_0.1.4
## [29] BiocParallel_1.44.0         cachem_1.1.0
## [31] DelayedArray_0.36.0         abind_1.4-8
## [33] tidyselect_1.2.1            digest_0.6.37
## [35] stringi_1.8.7               restfulr_0.0.16
## [37] bookdown_0.45               fastmap_1.2.0
## [39] grid_4.5.1                  archive_1.1.12
## [41] cli_3.6.5                   SparseArray_1.10.0
## [43] magrittr_2.0.4              S4Arrays_1.10.0
## [45] XML_3.99-0.19               readr_2.1.5
## [47] UCSC.utils_1.6.0            bit64_4.6.0-1
## [49] rmarkdown_2.30              httr_1.4.7
## [51] matrixStats_1.5.0           bit_4.6.0
## [53] hms_1.1.4                   evaluate_1.0.5
## [55] knitr_1.50                  rlang_1.1.6
## [57] glue_1.8.0                  crisprBase_1.14.0
## [59] BiocManager_1.30.26         vroom_1.6.6
## [61] jsonlite_2.0.0              R6_2.6.1
## [63] MatrixGenerics_1.22.0       GenomicAlignments_1.46.0
```

# References

Li, Heng, and Richard Durbin. 2009. “Fast and Accurate Short Read Alignment with Burrows–Wheeler Transform.” *Bioinformatics* 25 (14): 1754–60.
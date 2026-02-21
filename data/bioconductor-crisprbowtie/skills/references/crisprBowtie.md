# crisprBowtie: alignment of gRNA spacer sequences using bowtie

Jean-Philippe Fortin1\*

1Department of Data Science and Statistical Computing, gRED, Genentech

\*fortin946@gmail.com

#### 2025-10-29

# 1 Overview of crisprBowtie

`crisprBowtie` provides two main functions to align short DNA sequences to
a reference genome using the short read aligner bowtie (Langmead et al. [2009](#ref-langmead2009bowtie))
and return the alignments as R objects: `runBowtie` and `runCrisprBowtie`.
It utilizes the Bioconductor package `Rbowtie` to access the Bowtie program
in a platform-independent manner. This means that users do not need to install
Bowtie prior to using `crisprBowtie`.

The latter function (`runCrisprBowtie`) is specifically designed
to map and annotate CRISPR guide RNA (gRNA) spacer sequences using
CRISPR nuclease objects and CRISPR genomic arithmetics defined in
the Bioconductor package
[crisprBase](https://github.com/crisprVerse/crisprBase).
This enables a fast and accurate on-target and off-target search of
gRNA spacer sequences for virtually any type of CRISPR nucleases.
It also provides an off-target search engine for our main gRNA design package [crisprDesign](https://github.com/crisprVerse/crisprDesign) of the
[crisprVerse](https://github.com/crisprVerse) ecosystem. See the
`addSpacerAlignments` function in `crisprDesign` for more details.

# 2 Installation and getting started

## 2.1 Software requirements

### 2.1.1 OS Requirements

This package is supported for macOS, Linux and Windows machines.
Package was developed and tested on R version 4.2.

## 2.2 Installation from Bioconductor

`crisprBowtie` can be installed from from the Bioconductor devel branch
using the following commands in a fresh R session:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(version="devel")
BiocManager::install("crisprBowtie")
```

# 3 Building a bowtie index

To use `runBowtie` or `runCrisprBowtie`, users need to first build a Bowtie
genome index. For a given genome, this step has to be done only once.
The `Rbowtie` package conveniently provides the function `bowtie_build`
to build a Bowtie index from any custom genome from a FASTA file.

As an example, we build a Bowtie index for a small portion of the human
chromosome 1 (`chr1.fa` file provided in the `crisprBowtie` package) and
save the index file as `myIndex` to a temporary directory:

```
library(Rbowtie)
fasta <- file.path(find.package("crisprBowtie"), "example/chr1.fa")
tempDir <- tempdir()
Rbowtie::bowtie_build(fasta,
                      outdir=tempDir,
                      force=TRUE,
                      prefix="myIndex")
```

To learn how to create a Bowtie index for a complete genome or transcriptome,
please visit our [tutorial page](https://github.com/crisprVerse/Tutorials/tree/master/Building_Genome_Indices).

# 4 Alignment using `runCrisprBowtie`

As an example, we align 6 spacer sequences (of length 20bp) to the
custom genome built above, allowing a maximum of 3 mismatches between the
spacer and protospacer sequences.

We specify that the search is for the wildtype Cas9 (SpCas9) nuclease
by providing the `CrisprNuclease` object `SpCas9` available through the
`crisprBase` package. The argument `canonical=FALSE` specifies that
non-canonical PAM sequences are also considered (NAG and NGA for SpCas9).
The function `getAvailableCrisprNucleases` in `crisprBase` returns a character
vector of available `crisprNuclease` objects found in `crisprBase`.

```
library(crisprBowtie)
data(SpCas9, package="crisprBase")
crisprNuclease <- SpCas9
spacers <- c("TCCGCGGGCGACAATGGCAT",
             "TGATCCCGCGCTCCCCGATG",
             "CCGGGAGCCGGGGCTGGACG",
             "CCACCCTCAGGTGTGCGGCC",
             "CGGAGGGCTGCAGAAAGCCT",
             "GGTGATGGCGCGGGCCGGGC")
runCrisprBowtie(spacers,
                crisprNuclease=crisprNuclease,
                n_mismatches=3,
                canonical=FALSE,
                bowtie_index=file.path(tempDir, "myIndex"))
```

```
## [runCrisprBowtie] Searching for SpCas9 protospacers
```

```
##                 spacer          protospacer pam  chr pam_site strand
## 1 CCACCCTCAGGTGTGCGGCC CCACCCTCAGGTGTGCGGCC TGG chr1      679      +
## 2 CCGGGAGCCGGGGCTGGACG CCGGGAGCCGGGGCTGGACG GAG chr1      466      +
## 3 CGGAGGGCTGCAGAAAGCCT CGGAGGGCTGCAGAAAGCCT TGG chr1      706      +
## 4 GGTGATGGCGCGGGCCGGGC GGTGATGGCGCGGGCCGGGC CGG chr1      831      +
## 5 TGATCCCGCGCTCCCCGATG TGATCCCGCGCTCCCCGATG CAG chr1      341      +
##   n_mismatches canonical
## 1            0      TRUE
## 2            0     FALSE
## 3            0      TRUE
## 4            0      TRUE
## 5            0     FALSE
```

# 5 Applications beyond CRISPR

The function `runBowtie` is similar to `runCrisprBowtie`,
but does not impose constraints on PAM sequences.
It can be used to search for any short read sequence in a genome.

## 5.1 Example using RNAi (siRNA design)

Seed-related off-targets caused by mismatch tolerance outside of the
seed region is a well-studied and characterized problem observed in RNA
interference (RNA) experiments. `runBowtie` can be used to map shRNA/siRNA seed
sequences to reference genomes to predict putative off-targets:

```
seeds <- c("GTAAAGGT", "AAGGATTG")
runBowtie(seeds,
          n_mismatches=2,
          bowtie_index=file.path(tempDir, "myIndex"))
```

```
##      query   target  chr pos strand n_mismatches
## 1 AAGGATTG AAAGAATG chr1 163      -            2
## 2 AAGGATTG AAGCCTTG chr1 700      +            2
## 3 AAGGATTG AAGGCTTT chr1 699      -            2
## 4 AAGGATTG CAGGCTTG chr1 905      -            2
## 5 GTAAAGGT GGGAAGGT chr1 724      +            2
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] crisprBowtie_1.14.0 Rbowtie_1.50.0      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 rjson_0.2.23
##  [3] xfun_0.53                   bslib_0.9.0
##  [5] Biobase_2.70.0              lattice_0.22-7
##  [7] tzdb_0.5.0                  vctrs_0.6.5
##  [9] tools_4.5.1                 bitops_1.0-9
## [11] generics_0.1.4              stats4_4.5.1
## [13] curl_7.0.0                  parallel_4.5.1
## [15] tibble_3.3.0                pkgconfig_2.0.3
## [17] Matrix_1.7-4                BSgenome_1.78.0
## [19] S4Vectors_0.48.0            cigarillo_1.0.0
## [21] lifecycle_1.0.4             compiler_4.5.1
## [23] stringr_1.5.2               Rsamtools_2.26.0
## [25] Biostrings_2.78.0           Seqinfo_1.0.0
## [27] codetools_0.2-20            htmltools_0.5.8.1
## [29] sass_0.4.10                 RCurl_1.98-1.17
## [31] yaml_2.3.10                 pillar_1.11.1
## [33] crayon_1.5.3                jquerylib_0.1.4
## [35] BiocParallel_1.44.0         cachem_1.1.0
## [37] DelayedArray_0.36.0         abind_1.4-8
## [39] tidyselect_1.2.1            digest_0.6.37
## [41] stringi_1.8.7               restfulr_0.0.16
## [43] bookdown_0.45               fastmap_1.2.0
## [45] grid_4.5.1                  archive_1.1.12
## [47] cli_3.6.5                   SparseArray_1.10.0
## [49] magrittr_2.0.4              S4Arrays_1.10.0
## [51] XML_3.99-0.19               withr_3.0.2
## [53] readr_2.1.5                 bit64_4.6.0-1
## [55] rmarkdown_2.30              XVector_0.50.0
## [57] httr_1.4.7                  matrixStats_1.5.0
## [59] bit_4.6.0                   hms_1.1.4
## [61] evaluate_1.0.5              knitr_1.50
## [63] GenomicRanges_1.62.0        IRanges_2.44.0
## [65] BiocIO_1.20.0               rtracklayer_1.70.0
## [67] rlang_1.1.6                 glue_1.8.0
## [69] crisprBase_1.14.0           BiocManager_1.30.26
## [71] BiocGenerics_0.56.0         vroom_1.6.6
## [73] jsonlite_2.0.0              R6_2.6.1
## [75] MatrixGenerics_1.22.0       GenomicAlignments_1.46.0
```

# References

Langmead, Ben, Cole Trapnell, Mihai Pop, and Steven L. Salzberg. 2009. “Ultrafast and Memory-Efficient Alignment of Short Dna Sequences to the Human Genome.” *Genome Biology* 10 (3): R25. <https://doi.org/10.1186/gb-2009-10-3-r25>.
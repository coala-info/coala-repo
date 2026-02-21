# An introduction to Rbwa

Jean-Philippe Fortin1\*

1Department of Data Science and Statistical Computing, gRED, Genentech

\*fortin946@gmail.com

#### 2025-10-30

# 1 Introduction

The *[Rbwa](https://bioconductor.org/packages/3.22/Rbwa)* package provides an **R** wrapper around the two popular
*BWA* aligners `BWA-backtrack` (Li and Durbin [2009](#ref-bwa1)) and `BWA-MEM` (Li [2013](#ref-bwa2)).

As mentioned in the BWA manual (see <http://bio-bwa.sourceforge.net/bwa.shtml>),
BWA-backtrack is designed for short Illumina reads
(up to 100bp), while BWA-MEM is more suitable for longer sequences
(70bp to 1Mbp) and supports split alignment.

# 2 Installation

`Rbwa` can be installed from Bioconductor using the following
commands in a fresh R session:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("Rbwa")
```

# 3 Overview

The two main alignment functions are:

* BWA-backtrack: `bwa_aln`
* BWA-MEM: `bwa_mem`

The package also includes the following convenience functions:

* Genome indexing: `bwa_build_index`
* Conversion of `bwa_aln` output into SAM output: `bwa_sam`
* Generation of secondary alignments: `xa2multi`

# 4 Build a reference index with `bwa_build_index`

Both `bwa_aln` and `bwa_mem` require first to create a genome index from a
FASTA file. This is done only once for a given genome.
This can be done using the function
`bwa_build_index`.

First, we load `Rbwa`:

```
library(Rbwa)
```

In the following example code, we build a BWA index for a small portion
of human chr12 that we stored in a FASTA file located within the
`Rbwa` package. We store the index files in a temporary directory.

```
dir <- tempdir()
fasta <- system.file(package="Rbwa",
                     "fasta/chr12.fa")
index_prefix <- file.path(dir, "chr12")
bwa_build_index(fasta,
                index_prefix=index_prefix)
list.files(dir)
```

```
## [1] "BiocStyle" "chr12.amb" "chr12.ann" "chr12.bwt" "chr12.pac" "chr12.sa"
```

# 5 Aligment with `bwa_aln`

We now align read sequences stored in the toy example FASTQ file
`fastq/sequences.fastq`, provided in the `Rbwa` package,
to our indexed genome:

```
fastq <- system.file(package="Rbwa",
                     "fastq/sequences.fastq")
bwa_aln(index_prefix=index_prefix,
        fastq_files=fastq,
        sai_files=file.path(dir, "output.sai"))
```

Any valid BWA arguments can be passed to the `bwa_aln` function.
To see the complete list of valid arguments, please visit the BWA reference
manual: <http://bio-bwa.sourceforge.net/bwa.shtml>.

For instance, we can specify the maximal edit distance between the query
sequence and the reference genome to be 3 using `n`, as well as the maximal edit
distance in the seed sequence `k` to be 3,
where we specify that the length of the seed sequence is 13 using
the argument `l`:

```
bwa_aln(index_prefix=index_prefix,
        fastq_files=fastq,
        sai_files=file.path(dir, "output.sai"),
        n=3, k=3, l=13)
```

## 5.1 Creating a SAM file

The output of `bwa_aln` is an intermediate `sai` file that should be
converted into a `sam` file using the `bwa_sam` function as follows:

```
bwa_sam(index_prefix=index_prefix,
        fastq_files=fastq,
        sai_files=file.path(dir, "output.sai"),
        sam_file=file.path(dir, "output.sam"))
```

Let’s read the first few lines of the SAM file:

```
strtrim(readLines(file.path(dir, "output.sam")), 65)
```

```
## [1] "@SQ\tSN:chr12\tLN:171330"
## [2] "@PG\tID:bwa\tPN:bwa\tVN:0.7.17-r1198-dirty\tCL:/tmp/RtmpM2GbR0/Rinst27818"
## [3] "ACATCAGAAAGAGCGGCAG\t0\tchr12\t170881\t37\t19M\t*\t0\t0\tACATCAGAAAGAGCGGCAG\t~~~~~~~"
## [4] "CAACCCAGCCCCCCTCCAA\t0\tchr12\t170801\t37\t19M\t*\t0\t0\tCAACCCAGCCCCCCTCCAA\t~~~~~~~"
## [5] "CCTGTGATCCACGGAGGCT\t0\tchr12\t170765\t37\t19M\t*\t0\t0\tCCTGTGATCCACGGAGGCT\t~~~~~~~"
## [6] "GCACTGCGGTGAGTGCTGT\t0\tchr12\t170665\t37\t19M\t*\t0\t0\tGCACTGCGGTGAGTGCTGT\t~~~~~~~"
## [7] "GCCTTTTACAGTTCGTACT\t0\tchr12\t170820\t37\t19M\t*\t0\t0\tGCCTTTTACAGTTCGTACT\t~~~~~~~"
## [8] "GTCATGCCCCCTCAGCCAG\t0\tchr12\t170703\t37\t19M\t*\t0\t0\tGTCATGCCCCCTCAGCCAG\t~~~~~~~"
## [9] "TCGGCTCTCACCGTGTCCG\t0\tchr12\t170646\t37\t19M\t*\t0\t0\tTCGGCTCTCACCGTGTCCG\t~~~~~~~"
```

## 5.2 Creating a SAM file with secondary alignments

By default, each row of the SAM output corresponds to the best alignment hit
for a given input query sequence. Other alignments (secondary alignments,
or other loci in case of multiple alignments) are stored in the XA tag.

The function `xa2multi` conveniently extracts the alignments from the XA
tags and represent them as additional rows in the SAM format.
This can be executed as follows:

```
xa2multi(file.path(dir, "output.sam"),
         file.path(dir, "output.multi.sam"))
strtrim(readLines(file.path(dir, "output.multi.sam")), 65)
```

```
## [1] "@SQ\tSN:chr12\tLN:171330"
## [2] "@PG\tID:bwa\tPN:bwa\tVN:0.7.17-r1198-dirty\tCL:/tmp/RtmpM2GbR0/Rinst27818"
## [3] "ACATCAGAAAGAGCGGCAG\t0\tchr12\t170881\t37\t19M\t*\t0\t0\tACATCAGAAAGAGCGGCAG\t~~~~~~~"
## [4] "CAACCCAGCCCCCCTCCAA\t0\tchr12\t170801\t37\t19M\t*\t0\t0\tCAACCCAGCCCCCCTCCAA\t~~~~~~~"
## [5] "CCTGTGATCCACGGAGGCT\t0\tchr12\t170765\t37\t19M\t*\t0\t0\tCCTGTGATCCACGGAGGCT\t~~~~~~~"
## [6] "GCACTGCGGTGAGTGCTGT\t0\tchr12\t170665\t37\t19M\t*\t0\t0\tGCACTGCGGTGAGTGCTGT\t~~~~~~~"
## [7] "GCCTTTTACAGTTCGTACT\t0\tchr12\t170820\t37\t19M\t*\t0\t0\tGCCTTTTACAGTTCGTACT\t~~~~~~~"
## [8] "GTCATGCCCCCTCAGCCAG\t0\tchr12\t170703\t37\t19M\t*\t0\t0\tGTCATGCCCCCTCAGCCAG\t~~~~~~~"
## [9] "TCGGCTCTCACCGTGTCCG\t0\tchr12\t170646\t37\t19M\t*\t0\t0\tTCGGCTCTCACCGTGTCCG\t~~~~~~~"
```

# 6 Aligment with `bwa_mem`

The `bwa_mem` function works similar to the `bwa_aln` function, except
that it does not produce intermediate `.sai` files; it outputs a SAM file
directly:

```
fastq <- system.file(package="Rbwa",
                     "fastq/sequences.fastq")
bwa_mem(index_prefix=index_prefix,
        fastq_files=fastq,
        sam_file=file.path(dir, "output.sam"))
```

```
strtrim(readLines(file.path(dir, "output.sam")), 65)
```

```
## [1] "@SQ\tSN:chr12\tLN:171330"
## [2] "@PG\tID:bwa\tPN:bwa\tVN:0.7.17-r1198-dirty\tCL:/tmp/RtmpM2GbR0/Rinst27818"
## [3] "ACATCAGAAAGAGCGGCAG\t4\t*\t0\t0\t*\t*\t0\t0\tACATCAGAAAGAGCGGCAG\t~~~~~~~~~~~~~~~~~~~\t"
## [4] "CAACCCAGCCCCCCTCCAA\t4\t*\t0\t0\t*\t*\t0\t0\tCAACCCAGCCCCCCTCCAA\t~~~~~~~~~~~~~~~~~~~\t"
## [5] "CCTGTGATCCACGGAGGCT\t4\t*\t0\t0\t*\t*\t0\t0\tCCTGTGATCCACGGAGGCT\t~~~~~~~~~~~~~~~~~~~\t"
## [6] "GCACTGCGGTGAGTGCTGT\t4\t*\t0\t0\t*\t*\t0\t0\tGCACTGCGGTGAGTGCTGT\t~~~~~~~~~~~~~~~~~~~\t"
## [7] "GCCTTTTACAGTTCGTACT\t4\t*\t0\t0\t*\t*\t0\t0\tGCCTTTTACAGTTCGTACT\t~~~~~~~~~~~~~~~~~~~\t"
## [8] "GTCATGCCCCCTCAGCCAG\t4\t*\t0\t0\t*\t*\t0\t0\tGTCATGCCCCCTCAGCCAG\t~~~~~~~~~~~~~~~~~~~\t"
## [9] "TCGGCTCTCACCGTGTCCG\t4\t*\t0\t0\t*\t*\t0\t0\tTCGGCTCTCACCGTGTCCG\t~~~~~~~~~~~~~~~~~~~\t"
```

# 7 Session info

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
## [1] Rbwa_1.14.0      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```

# References

Li, Heng. 2013. “Aligning Sequence Reads, Clone Sequences and Assembly Contigs with Bwa-Mem.” *arXiv Preprint arXiv:1303.3997*.

Li, Heng, and Richard Durbin. 2009. “Fast and Accurate Short Read Alignment with Burrows–Wheeler Transform.” *Bioinformatics* 25 (14): 1754–60.
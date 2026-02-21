# single

Rocio Espada1

1ESPCI Paris

#### 1 November 2022

#### Abstract

This vignettes shows how to use single, a package to improve consensus calling on nanopore sequencing of gene libraries.

#### Package

single 1.2.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 How to use](#how-to-use)
  + [3.1 Before starting](#before-starting)
  + [3.2 Preprocessing data](#preprocessing-data)
  + [3.3 Run SINGLe in R](#run-single-in-r)
    - [3.3.1 Other functions included in the package](#other-functions-included-in-the-package)
* [Session info](#session-info)

# 1 Introduction

SINGLe computes consensus sequence of DNA reads by (noisy) nanopore sequencing. It is focused on long amplicons sequencing, and it aims to the reads of gene libraries, typically used in directed evolution experiments.

SINGLe takes advantage that gene libraries are created from an original wild type or reference sequence, and it characterizes the systematic errors made by nanopore sequencing. Then, uses that information to correct the confidence values (QUAL) assigned to each nucleotide read in the mutants library.

Finally, given that you can identify which variant was read in each case (for example by the use of unique molecular identifiers or DNA barcodes), SINGLe groups them and computes the consensus sequence by weighting the frequencies with the corrected confidence values.

For more details, please refer to our pre-print “Accurate gene consensus at low nanopore coverage” doi: <https://doi.org/10.1101/2020.03.25.007146> for more information.

# 2 Installation

Using bioconductor:

if (!require(“BiocManager”, quietly = TRUE))
install.packages(“BiocManager”)

BiocManager::install(“single”)

# 3 How to use

## 3.1 Before starting

To use SINGLe you must have the following data:

* A fasta file with the reference sequence (ex. a wild type from which you generated the library) (**REF.fasta**).
* Nanopore reads of a reference sequence (**REF\_READS.fastq**).
* Nanopore reads of a gene libraries (**LIB\_READS.fastq**).
* Identification of each read in the gene library with a gene variant (ex via the use of DNA barcodes on your experiment) (**BC\_TABLE.txt**).

## 3.2 Preprocessing data

Align nanopore reads to the reference sequence and create a sorted bam file.

For the reads of the reference:

```
minimap2 -ax map-ont --sam-hit-only REF.fasta REF_READS.fastq > REF_READS.sam
samtools view -S -b REF_READS.sam > REF_READS.bam
samtools sort REF_READS.bam -o REF_READS.sorted.bam
```

And for the reads of the library:

```
minimap2 -ax map-ont --sam-hit-only  REF.fasta LIB_READS.fastq >LIB_READS.sam
samtools view -S -b LIB_READS.sam > LIB_READS.bam
samtools sort LIB_READS.bam -o LIB_READS.sorted.bams
```

## 3.3 Run SINGLe in R

SINGLe consists on three steps: train model, evaluate model, compute consensus. As it can be time consuming, I will only analyze a subset of positions

```
library(single)
pos_start <- 1
pos_end <- 10

refseq_fasta <- system.file("extdata", "ref_seq.fasta", package = "single")
ref_seq <- Biostrings::subseq(Biostrings::readDNAStringSet(refseq_fasta), pos_start,pos_end)
```

First, train the model using nanopore reads of the reference (wild type).

```
REF_READS <- system.file("extdata", "train_seqs_500.sorted.bam",package = "single")
train <- single_train(bamfile=REF_READS,
                      output="train",
                      refseq_fasta=refseq_fasta,
                      rates.matrix=mutation_rate,
                      mean.n.mutations=5.4,
                      pos_start=pos_start,
                      pos_end=pos_end,
                      verbose=FALSE,
                      save_partial=FALSE,
                      save_final= FALSE)
```

```
## Warning: glm.fit: algorithm did not converge
```

```
print(head(train))
```

```
##   pos strand nucleotide QUAL  p_SINGLe isWT
## 1   1      +          A    1 0.2056718 TRUE
## 2   1      -          A    1 0.2056718 TRUE
## 3   1      +          A    2 0.3690427 TRUE
## 4   1      -          A    2 0.3690427 TRUE
## 5   1      +          A    3 0.4988128 TRUE
## 6   1      -          A    3 0.4988128 TRUE
```

Second, evaluate model: use the fitted model to evaluate the reads of your library, and re-weight the QUAL (quality scores).

```
LIB_READS <- system.file("extdata","test_sequences.sorted.bam",package ="single")
corrected_reads <- single_evaluate(bamfile = LIB_READS,
                single_fits = train,
                ref_seq = ref_seq,
                pos_start=pos_start,pos_end=pos_end,
                verbose=FALSE,
                gaps_weights = "minimum",
                save = FALSE)
corrected_reads
```

```
##   A QualityScaledDNAStringSet instance containing:
##
## DNAStringSet object of length 40:
##      width seq                                              names
##  [1]    10 ATGCGTCTGC                                       1944838d-7824-496...
##  [2]    10 ATGCGTCTGC                                       100a992c-60c8-495...
##  [3]    10 ATGCGTCTGC                                       82027877-02d8-40f...
##  [4]    10 ATGCGTCTGC                                       e4e1a99b-e8ea-4bc...
##  [5]    10 ATGCGTCTGC                                       dacd1e41-d654-432...
##  ...   ... ...
## [36]    10 ATGCGTCTGC                                       2b9cc86d-275f-493...
## [37]    10 ATGCGTCTGC                                       158ddec8-702c-451...
## [38]    10 ATGCGTCTGC                                       7f1a9ec1-688a-4ba...
## [39]    10 ATGCGTCTGC                                       865c645d-6b61-4ed...
## [40]    10 ATGCGTCTGC                                       72627b8a-6b8f-4de...
##
## PhredQuality object of length 40:
##      width seq                                              names
##  [1]    10 667;8888:>                                       1944838d-7824-496...
##  [2]    10 &&'+-23::<                                       100a992c-60c8-495...
##  [3]    10 455656789=                                       82027877-02d8-40f...
##  [4]    10 )),0/430/+                                       e4e1a99b-e8ea-4bc...
##  [5]    10 63>A?@>@;9                                       dacd1e41-d654-432...
##  ...   ... ...
## [36]    10 **)*6666>=                                       2b9cc86d-275f-493...
## [37]    10 9:?>???A@?                                       158ddec8-702c-451...
## [38]    10 ****:75510                                       7f1a9ec1-688a-4ba...
## [39]    10 7666<:9821                                       865c645d-6b61-4ed...
## [40]    10 --..=:8960                                       72627b8a-6b8f-4de...
```

Finally, use the reads of the library with the corrected QUAL scores to compute a weighted consensus sequences in subsets of reads. The sets of reads corresponding to each variant are indicated in a table (here BC\_TABLE) of two columns: SeqID (name of the read) and BCid (barcode or group identity).

```
BC_TABLE = system.file("extdata", "Barcodes_table.txt",package = "single")
consensus <- single_consensus_byBarcode(barcodes_table = BC_TABLE,
                           sequences = corrected_reads,
                           verbose = FALSE)
consensus
```

```
## DNAStringSet object of length 3:
##     width seq                                               names
## [1]    10 ATGCGTCTGC                                        5
## [2]    10 ATGCGTCTGC                                        6
## [3]    10 ATGCGTCTGC                                        7
```

### 3.3.1 Other functions included in the package

Use pileup to create a data.frame with counts by position nucleotide and quality score

```
counts_pnq <- pileup_by_QUAL(bam_file=REF_READS,
                    pos_start=pos_start,
                    pos_end=pos_end)
head(counts_pnq)
```

```
##   pos strand nucleotide count QUAL
## 1   1      +          A     1    2
## 2   1      +          A     4    3
## 3   1      +          A     6    4
## 4   1      +          A     6    5
## 5   1      +          A    15    6
## 6   1      +          A    13    7
```

Compute a priori probability of making errors

```
p_prior_errors <- p_prior_errors(counts_pnq=counts_pnq,
                                  save=FALSE)
p_prior_errors
```

```
## # A tibble: 40 × 4
##    strand   pos nucleotide p_prior_error
##    <fct>  <dbl> <fct>              <dbl>
##  1 +          1 A                 1
##  2 -          1 A                 1
##  3 +          2 T                 1
##  4 -          2 T                 1
##  5 +          3 G                 1
##  6 -          3 G                 1
##  7 +          4 C                 1
##  8 -          4 C                 0.972
##  9 -          4 T                 0.0278
## 10 +          5 A                 0.0235
## # … with 30 more rows
```

Compute a priori probability of having a mutation

```
p_prior_mutations <- p_prior_mutations(rates.matrix = mutation_rate,
                        mean.n.mut = 5,ref_seq = ref_seq,save = FALSE)
head(p_prior_mutations)
```

```
##   wt.base nucleotide p_mutation
## 2       C          A 0.16206897
## 3       G          A 0.29310345
## 4       T          A 0.32758621
## 5       A          C 0.05402299
## 7       G          C 0.04712644
## 8       T          C 0.20114943
```

Fit SINGLe logistic regression using the prior probabilities and the counts

```
fits <- fit_logregr(counts_pnq = counts_pnq,ref_seq=ref_seq,
                    p_prior_errors = p_prior_errors,
                    p_prior_mutations = p_prior_mutations,
                    save=FALSE)
```

```
## Warning: glm.fit: algorithm did not converge
```

```
head(fits)
```

```
## # A tibble: 6 × 5
##   strand   pos nucleotide prior_slope prior_intercept
##   <fct>  <dbl> <fct>            <dbl>           <dbl>
## 1 +          1 C                   NA              NA
## 2 +          1 G                   NA              NA
## 3 +          1 T                   NA              NA
## 4 +          1 -                   NA              NA
## 5 +          2 A                   NA              NA
## 6 +          2 C                   NA              NA
```

Use the fits to obtain the replacement Qscores after SINGLe fit, for all possible QUAL, nucleotide and position values

```
evaluated_fits <- evaluate_fits(pos_range = c(1,5),q_range = c(0,10),
                                data_fits = fits,ref_seq = ref_seq,
                                save=FALSE,verbose = FALSE)
head(evaluated_fits)
```

```
##   pos strand nucleotide QUAL  p_SINGLe isWT
## 1   1      +          A    0 0.0000000 TRUE
## 2   1      -          A    0 0.0000000 TRUE
## 3   1      +          A    1 0.2056718 TRUE
## 4   1      -          A    1 0.2056718 TRUE
## 5   1      +          A    2 0.3690427 TRUE
## 6   1      -          A    2 0.3690427 TRUE
```

Compute one consensus sequence weighted by QUAL values.

```
data_barcode = data.frame(
    nucleotide=unlist(sapply(as.character(corrected_reads),strsplit, split="")),
    p_SINGLe=unlist(1-as(Biostrings::quality(corrected_reads),"NumericList")),
    pos=rep(1:Biostrings::width(corrected_reads[1]),length(corrected_reads)))
consensus_seq <- weighted_consensus(df = data_barcode, cutoff_prob = 0.9)
consensus_seq
```

```
## 10-letter DNAString object
## seq: ATGCGTCTGC
```

```
another_consensus_seq <- weighted_consensus(df = data_barcode, cutoff_prob = 0.999)
another_consensus_seq
```

```
## 10-letter DNAString object
## seq: -TGCGTCTGC
```

```
list_mismatches(ref_seq[[1]],another_consensus_seq)
```

```
## [1] "A1-"
```

# Session info

```
## R version 4.2.1 (2022-06-23)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.5 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.16-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.16-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] single_1.2.0     BiocStyle_2.26.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.9                  lattice_0.20-45
##  [3] tidyr_1.2.1                 Rsamtools_2.14.0
##  [5] Biostrings_2.66.0           assertthat_0.2.1
##  [7] digest_0.6.30               utf8_1.2.2
##  [9] R6_2.5.1                    GenomeInfoDb_1.34.0
## [11] plyr_1.8.7                  stats4_4.2.1
## [13] evaluate_0.17               pillar_1.8.1
## [15] zlibbioc_1.44.0             rlang_1.0.6
## [17] jquerylib_0.1.4             S4Vectors_0.36.0
## [19] Matrix_1.5-1                rmarkdown_2.17
## [21] BiocParallel_1.32.0         stringr_1.4.1
## [23] RCurl_1.98-1.9              DelayedArray_0.24.0
## [25] compiler_4.2.1              xfun_0.34
## [27] pkgconfig_2.0.3             BiocGenerics_0.44.0
## [29] htmltools_0.5.3             tidyselect_1.2.0
## [31] SummarizedExperiment_1.28.0 tibble_3.1.8
## [33] GenomeInfoDbData_1.2.9      bookdown_0.29
## [35] IRanges_2.32.0              codetools_0.2-18
## [37] matrixStats_0.62.0          fansi_1.0.3
## [39] crayon_1.5.2                dplyr_1.0.10
## [41] withr_2.5.0                 GenomicAlignments_1.34.0
## [43] bitops_1.0-7                grid_4.2.1
## [45] jsonlite_1.8.3              lifecycle_1.0.3
## [47] DBI_1.1.3                   magrittr_2.0.3
## [49] cli_3.4.1                   stringi_1.7.8
## [51] cachem_1.0.6                XVector_0.38.0
## [53] reshape2_1.4.4              bslib_0.4.0
## [55] ellipsis_0.3.2              generics_0.1.3
## [57] vctrs_0.5.0                 tools_4.2.1
## [59] Biobase_2.58.0              glue_1.6.2
## [61] purrr_0.3.5                 MatrixGenerics_1.10.0
## [63] parallel_4.2.1              fastmap_1.1.0
## [65] yaml_2.3.6                  BiocManager_1.30.19
## [67] GenomicRanges_1.50.0        knitr_1.40
## [69] sass_0.4.2
```
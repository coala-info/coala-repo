# motifmatchr

The motifmatchr package is designed for analyzing many sequences and many motifs to find which sequences contain which motifs. It uses the MOODS C++ library (developedby Pasi Rastas, Janne Korhonen, and Petri Martinmaki) internally for motif matching. The primary method of motifmatchr is `matchMotifs`, which takes in motif PWMs/PFMs and genomic ranges or sequences and returns either which ranges/sequences match which motifs or the positions of the matches.

Compared with alternative motif matching functions available in Bioconductor (e.g. matchPWM in Biostrings or searchSeq in TFBSTools), motifmatchr is designed specifically for the use case of determining whether many different sequences/ranges contain many different motifs. For example, when analyzing ChIP-seq or ATAC-seq data one might want to find what motifs in a collection of motifs like the JASPAR database are found in what peaks.

## Quickstart

Example use case of motifmatchr with a set of peaks and a few motifs. For additional options for inputs & outputs, see remainder of vignette.

```
library(motifmatchr)
library(GenomicRanges)
library(SummarizedExperiment)
library(BSgenome)

# load some example motifs
data(example_motifs, package = "motifmatchr")

# Make a set of peaks
peaks <- GRanges(seqnames = c("chr1","chr2","chr2"),
                 ranges = IRanges(start = c(76585873,42772928,100183786),
                                  width = 500))

# Get motif matches for example motifs in peaks
motif_ix <- matchMotifs(example_motifs, peaks, genome = "hg19")
motifMatches(motif_ix) # Extract matches matrix from result
```

```
## 3 x 3 sparse Matrix of class "lgCMatrix"
##      MA0599.1_KLF5 MA0107.1_RELA MA0137.3_STAT1
## [1,]             |             |              .
## [2,]             |             .              |
## [3,]             |             .              |
```

```
# Get motif positions within peaks for example motifs in peaks
motif_pos <- matchMotifs(example_motifs, peaks, genome = "hg19",
                         out = "positions")
```

# Inputs

This method has two mandatory arguments:

1. Position weight matrices or position frequency matrices, stored in the PWMatrix, PFMatrix, PWMatrixList, or PFMatrixList objects from the TFBSTools package
2. Either a set of genomic ranges (GenomicRanges or RangedSummarizedExperiment object) or a set of sequences (either DNAStringSet, DNAString, or simple character vector)

If the second argument is a set of genomic ranges, a genome sequence is also required. By default [BSgenome.Hsapiens.UCSC.hg19](https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hg19.html) is used — you will have to have installed BSgenome.Hsapiens.UCSC.hg19. If using another genome build, either the appropraiate BSgenome object for your species or a DNAStringSet or FaFile object for your species should be passed to the `genome` argument.

```
# using peaks
motif_ix_peaks <- matchMotifs(example_motifs, peaks, genome = "hg19")

# using SummarizedExperiment
example_SummarizedExperiment <-
    SummarizedExperiment(assays = list(counts = matrix(1,
                                                       ncol = 4,
                                                       nrow = 3)),
                         rowRanges = peaks)

motif_ix_SummarizedExperiment <- matchMotifs(example_motifs,
                                              example_SummarizedExperiment,
                                              genome = "hg19")

all.equal(motifMatches(motif_ix_peaks),
          motifMatches(motif_ix_SummarizedExperiment))
```

```
## [1] TRUE
```

```
# using BSgenomeViews

example_BSgenomeViews <- BSgenomeViews(BSgenome.Hsapiens.UCSC.hg19, peaks)

motif_ix_BSgenomeViews <- matchMotifs(example_motifs, example_BSgenomeViews)
```

```
## Warning in matrix(log2(bg(pwm)) - log2(bg_freqs), nrow = 4, ncol = length(pwm),
## : data length [12] is not a sub-multiple or multiple of the number of columns
## [10]
## Warning in matrix(log2(bg(pwm)) - log2(bg_freqs), nrow = 4, ncol = length(pwm),
## : data length [12] is not a sub-multiple or multiple of the number of columns
## [10]
```

```
## Warning in matrix(log2(bg(pwm)) - log2(bg_freqs), nrow = 4, ncol = length(pwm),
## : data length [12] is not a sub-multiple or multiple of the number of columns
## [11]
```

```
all.equal(motifMatches(motif_ix_peaks), motifMatches(motif_ix_BSgenomeViews))
```

```
## [1] "Attributes: < Component \"i\": Numeric: lengths (6, 9) differ >"
## [2] "Attributes: < Component \"p\": Mean relative difference: 0.5 >"
## [3] "Attributes: < Component \"x\": Lengths (6, 9) differ (comparison on first 6 components) >"
```

```
# using DNAStringSet
library(Biostrings)
library(BSgenome.Hsapiens.UCSC.hg19)

example_DNAStringSet <- getSeq(BSgenome.Hsapiens.UCSC.hg19, peaks)

motif_ix_DNAStringSet <- matchMotifs(example_motifs, example_DNAStringSet)

all.equal(motifMatches(motif_ix_peaks), motifMatches(motif_ix_DNAStringSet))
```

```
## [1] TRUE
```

```
# using character vector
example_character <- as.character(example_DNAStringSet)

motif_ix_character <- matchMotifs(example_motifs, example_character)

all.equal(motifMatches(motif_ix_peaks), motifMatches(motif_ix_character))
```

```
## [1] TRUE
```

## Options

### Background nucleotide frequencies

In determining motif matches, background nucleotide frequencies are used. By default the background frequencies are the nucleotide frequencies within the input sequence – to use alternate frequencies, supply the `bg` arument to `match_pwms`. If the input sequences are fairly short (as in our vignette example!), it probably makes sense to use other input frequencies. Here we show how to use even frequencies:

```
motif_ix <- matchMotifs(example_motifs, peaks, genome = "hg19", bg = "even")
```

We can also choose to use the frequency from the genome. In this case:

```
motif_ix <- matchMotifs(example_motifs, peaks, genome = "hg19", bg = "genome")
```

A genome must be specified if using `bg = "genome"`!

To specify frequencies per base pair, the order should be “A”,“C”,“G”, then “T”, or those nucleotides should be used as names in the vector.

```
motif_ix <- matchMotifs(example_motifs, peaks, genome = "hg19",
                         bg = c("A" = 0.2,"C" = 0.3, "G" = 0.3, "T" = 0.2))
```

PWMatrix objects have associated background frequencies that can be accessed using the `bg` function. If the supplied background frequencies to `match_pwms` do not match the frequencies in the input PWM, then the PWM is adjusted to refect the supplied background frequencies. The calculated score is based on this adjusted PWM and not the direct input PWM. To ensure the score is computed using the exact PWM input, simply make sure the background frequencies passed to matchMotifs match hose used for the input PWM and stored in bg slot of PWMatrix object.

### Log base and pseudocounts

motifmatchr expects input PWMs to use either natural logarithm or log 2. If the input is a PFM, the TFBSTools toPWM is used for making the PWM with the default psueodcounts of 0.8 and base 2 logarithm. For more control of the pseudocounts, simply use the toPWM function to convert your PFMs prior to calling matchMotifs.

```
library(TFBSTools)
example_pwms <- do.call(PWMatrixList,lapply(example_motifs, toPWM,
                                            pseudocounts = 0.5))
```

### P value

The default p-value cutoff is 0.00005. No adjustment for multiple comparisons is made in this p-value cutoff. This p-value threshold is used to determine a score threshold. # Outputs

The matchMotifs can return three possible outputs, depending on the `out` argument:

1. (Default, with `out = matches`) Boolean matrix indicating which ranges/sequences contain which motifs, stored as `motifMatches` in assays slot of SummarizedExperiment object. The `motifMatches` methods can be used to extract the boolean matrix. If either the `subject` argument is a GenomicRanges or RangedSummarizedExperiment object OR a `ranges` argument is provided, then a RangedSummarizedExeriment is returned rather than a SummarizedExperiment.
2. (out = `scores`) Same as (1) plus two additional assays – a matrix with the score of the high motif score within each range/sequence (score only reported if match present) and a matrix with the number of motif matches. The `motifScores` and `motifCounts` methods can be used to access these components.
3. (out = `positions`) A GenomicRangesList with the ranges of all matches within the input ranges/sequences. Note that if the `subject` argument is a character vector, DNAStringSet, or DNAString and a `ranges` argument corresponding to the ranges represented by the sequences is NOT provided, then a list of IRangesList objects will be returned instead with the relative positions withing the sequences.

```
motif_ix <- matchMotifs(example_motifs, peaks, genome = "hg19")
print(motif_ix)
```

```
## class: RangedSummarizedExperiment
## dim: 3 3
## metadata(0):
## assays(1): motifMatches
## rownames: NULL
## rowData names(0):
## colnames(3): MA0599.1_KLF5 MA0107.1_RELA MA0137.3_STAT1
## colData names(1): name
```

```
head(motifMatches(motif_ix))
```

```
## 3 x 3 sparse Matrix of class "lgCMatrix"
##      MA0599.1_KLF5 MA0107.1_RELA MA0137.3_STAT1
## [1,]             |             |              .
## [2,]             |             .              |
## [3,]             |             .              |
```

```
motif_ix_scores <- matchMotifs(example_motifs, peaks,
                                genome = "hg19", out = "scores")
print(motif_ix_scores)
```

```
## class: RangedSummarizedExperiment
## dim: 3 3
## metadata(0):
## assays(3): motifScores motifMatches motifCounts
## rownames: NULL
## rowData names(0):
## colnames(3): MA0599.1_KLF5 MA0107.1_RELA MA0137.3_STAT1
## colData names(1): name
```

```
head(motifMatches(motif_ix_scores))
```

```
## 3 x 3 sparse Matrix of class "lgCMatrix"
##      MA0599.1_KLF5 MA0107.1_RELA MA0137.3_STAT1
## [1,]             |             |              .
## [2,]             |             .              |
## [3,]             |             .              |
```

```
head(motifScores(motif_ix_scores))
```

```
## 3 x 3 sparse Matrix of class "dgCMatrix"
##      MA0599.1_KLF5 MA0107.1_RELA MA0137.3_STAT1
## [1,]      7.975145      13.55634        .
## [2,]      7.085762       .             16.29401
## [3,]      7.739609       .             14.81298
```

```
head(motifCounts(motif_ix_scores))
```

```
## 3 x 3 sparse Matrix of class "dgCMatrix"
##      MA0599.1_KLF5 MA0107.1_RELA MA0137.3_STAT1
## [1,]             1             1              .
## [2,]             1             .              1
## [3,]             1             .              2
```

```
motif_pos <- matchMotifs(example_motifs, peaks, genome = "hg19",
                          out = "positions")
print(motif_pos)
```

```
## GRangesList object of length 3:
## $MA0599.1_KLF5
## GRanges object with 3 ranges and 1 metadata column:
##       seqnames              ranges strand |     score
##          <Rle>           <IRanges>  <Rle> | <numeric>
##   [1]     chr1   76585928-76585937      - |   7.97515
##   [2]     chr2   42773248-42773257      - |   7.08576
##   [3]     chr2 100184023-100184032      - |   7.73961
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
##
## $MA0107.1_RELA
## GRanges object with 1 range and 1 metadata column:
##       seqnames            ranges strand |     score
##          <Rle>         <IRanges>  <Rle> | <numeric>
##   [1]     chr1 76585933-76585942      + |   13.5563
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
##
## $MA0137.3_STAT1
## GRanges object with 3 ranges and 1 metadata column:
##       seqnames              ranges strand |     score
##          <Rle>           <IRanges>  <Rle> | <numeric>
##   [1]     chr2   42773087-42773097      - |   16.2940
##   [2]     chr2 100183852-100183862      + |   14.8130
##   [3]     chr2 100183852-100183862      - |   13.9536
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

## Session Info

```
Sys.Date()
```

```
## [1] "2025-10-30"
```

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
##  [1] TFBSTools_1.48.0                  BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [3] BSgenome_1.78.0                   rtracklayer_1.70.0
##  [5] BiocIO_1.20.0                     Biostrings_2.78.0
##  [7] XVector_0.50.0                    SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0                    MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0                 GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0                     IRanges_2.44.0
## [15] S4Vectors_0.48.0                  BiocGenerics_0.56.0
## [17] generics_0.1.4                    motifmatchr_1.32.0
##
## loaded via a namespace (and not attached):
##  [1] DirichletMultinomial_1.52.0 rjson_0.2.23
##  [3] xfun_0.53                   bslib_0.9.0
##  [5] caTools_1.18.3              lattice_0.22-7
##  [7] vctrs_0.6.5                 tools_4.5.1
##  [9] bitops_1.0-9                curl_7.0.0
## [11] parallel_4.5.1              RSQLite_2.4.3
## [13] blob_1.2.4                  Matrix_1.7-4
## [15] cigarillo_1.0.0             lifecycle_1.0.4
## [17] compiler_4.5.1              Rsamtools_2.26.0
## [19] codetools_0.2-20            htmltools_0.5.8.1
## [21] sass_0.4.10                 RCurl_1.98-1.17
## [23] yaml_2.3.10                 crayon_1.5.3
## [25] jquerylib_0.1.4             BiocParallel_1.44.0
## [27] DelayedArray_0.36.0         cachem_1.1.0
## [29] abind_1.4-8                 gtools_3.9.5
## [31] digest_0.6.37               restfulr_0.0.16
## [33] fastmap_1.2.0               grid_4.5.1
## [35] cli_3.6.5                   SparseArray_1.10.0
## [37] S4Arrays_1.10.0             XML_3.99-0.19
## [39] TFMPvalue_0.0.9             bit64_4.6.0-1
## [41] pwalign_1.6.0               rmarkdown_2.30
## [43] httr_1.4.7                  bit_4.6.0
## [45] memoise_2.0.1               evaluate_1.0.5
## [47] knitr_1.50                  rlang_1.1.6
## [49] Rcpp_1.1.0                  DBI_1.2.3
## [51] seqLogo_1.76.0              jsonlite_2.0.0
## [53] R6_2.6.1                    GenomicAlignments_1.46.0
```
# Introduction to the `motifcounter` package

#### Wolfgang Kopp

#### 2017-10-06

* [1 Usage examples](#usage-examples)
* [2 Introduction](#introduction)
  + [2.1 Biological background](#biological-background)
  + [2.2 Hallmarks of `motifcounter`](#hallmarks-of-motifcounter)
* [3 Getting started](#getting-started)
  + [3.1 Preliminary steps](#preliminary-steps)
    - [3.1.1 Acquire a background model](#acquire-a-background-model)
    - [3.1.2 Acquire a motif](#acquire-a-motif)
    - [3.1.3 Optional settings](#optional-settings)
  + [3.2 Retrieve position- and strand-specific scores and hits](#retrieve-position--and-strand-specific-scores-and-hits)
    - [3.2.1 Analysis of individual DNA sequences](#analysis-of-individual-dna-sequences)
    - [3.2.2 Analysis of a set of DNA sequences](#analysis-of-a-set-of-dna-sequences)
  + [3.3 Test for motif hit enrichment](#test-for-motif-hit-enrichment)
* [4 Session Info](#session-info)

This software package grew out of the work that I did to obtain my PhD. If it is of help for your analysis, please cite

```
@Manual{,
    title = {motifcounter: R package for analysing TFBSs in DNA sequences},
    author = {Wolfgang Kopp},
    year = {2017},
    doi = {10.18129/B9.bioc.motifcounter}
}
```

Details about the compound Poisson model are available under

```
@article{improvedcompound,
  title={An improved compound Poisson model for the number of motif hits in DNA sequences},
  author={Kopp, Wolfgang and Vingron, Martin},
  journal={Bioinformatics},
  pages={btx539},
  year={2017},
  publisher={Oxford University Press}
}
```

# 1 Usage examples

```
# Estimate a background model on a set of sequences
bg <- readBackground(sequences, order)
```

```
# Normalize a given PFM
new_motif <- normalizeMotif(motif)
```

```
# Evaluate the scores along a given sequence
scores <- scoreSequence(sequence, motif, bg)
```

```
# Evaluate the motif hits along a given sequence
hits <- motifHits(sequence, motif, bg)
```

```
# Evaluate the average score profile
average_scores <- scoreProfile(sequences, motif, bg)
```

```
# Evaluate the average motif hit profile
average_hits <- motifHitProfile(sequences, motif, bg)
```

```
# Compute the motif hit enrichment
enrichment_result <- motifEnrichment(sequences, motif, bg)
```

# 2 Introduction

## 2.1 Biological background

Transcription factors (TFs) play a crucial role in gene regulation. They function by recognizing and binding to specific DNA stretches that are usually 5-30bp in length which are referred to as *transcription factor binding sites* (TFBSs). TF-binding acts on the neighboring genes by up- or down-regulating their gene expression levels.

The aim of the `motifcounter` package is to provide statistical tools for studying putative TFBSs in given DNA sequence, including the presence and location of TFBSs and the enrichment of TFBSs.

## 2.2 Hallmarks of `motifcounter`

The main ingredients for an analysis with `motifcounter` consist of

1. a position frequency matrix (PFM) (also called TF motif)
2. a background model that serves as a reference for the statistical analysis
3. a set of DNA sequences that is subject to the TFBS analysis
4. a *false positive probability* \(\alpha\) for predicting TFBSs in a random sequence. E.g. \(\alpha=0.001\).

A **PFM** represents the affinity of a TF to bind a certain DNA segment. A large set of known PFMs can be acquired e.g. from the `MotifDb` package [@motifdb]. On the other hand, the **background model** defines the properties of unbound DNA sequences. `motifcounter` implements the background model as an **order-\(d\) Markov model**, where \(d\) is prescribed by the user. The advantage of using higher-order background models is that they are able to capture higher-order sequence features which is crucial for studying naturally occurring DNA sequences (e.g. CpGs islands).

Using the PFM and the background model, `motifcounter` computes the **motif score** for a given DNA sequence, which is defined to be the log-likelihood ratio between the PFM and the background. The motif score represents a measure that indicates whether a certain position in the DNA sequence is bound or unbound by the TF. Intuitively, the higher the score, the more like does the sequence represent a TFBS.

The motif scores are also used to determine **motif hits** (e.g. putative TFBSs) in the DNA sequence. To this end, `motifcounter` uses a predetermined **score threshold** and calls putative TFBSs whenever the observed score at a give position is greater or equal to the score threshold. `motifcounter` establishes the **score threshold** automatically based on 1) the **score distribution** and 2) the user-prescribed false positive level \(\alpha\). To this end, the score distribution is determined by an efficient dynamic programming algorithm for general order-\(d\) background models. Details of the algorithm are described our paper (see above).

Testing for **motif hit enrichment** in `motifcounter` is based on the **number of motif hits** that are observed in a set of DNA sequences. In order to be able to judge significance of the observed number of hits (e.g. 10 predicted TFBSs in the sequence of length 10kb), the package approximates the **distribution of the number of motif hits** in random DNA sequences with matched lengths.

Accordingly, `motifcounter` provides two fast and accurate alternatives for approximating this distribution:

1. A compound Poisson approximation (see Kopp and Vingron (2017) Bioinformatics.)
2. A combinatorial model (manuskript in preparation)

Both of these methods support higher-order background models and account for the **self-overlapping** structure of the motif. For example, a repeat-like word, e.g. ‘AAAA’, likely gives rise to a string of mutually overlapping hits which
are referred to as **clumps** [@reinert, @pape][1](#fn1). `motifcounter` not only account for overlapping motif hits with respect to a single DNA strand, but also for overlapping reverse complementary hits, if both DNA strands are scanned for motif hits. It is essential to account for clumping, as that influences the distribution of the number of motif hits and thereby the motif hit enrichment test. Ignoring this effect could cause misleading statistical conclusions.

# 3 Getting started

## 3.1 Preliminary steps

### 3.1.1 Acquire a background model

The background model is used to specify the properties of unbound DNA sequences. That is, it plays a role as a reference for identifying putative TFBSs as well as for judging motif hit enrichment.

`motifcounter` offers the opportunity to use order-\(d\) Markov model with user-defined \(d\). The background model is estimated on a set of user-provided DNA sequences which are supplied as `DNAStringSet`-objects from the `Biostrings` Bioconductor package.

The following code fragment illustrates how an order-\(1\) background model is estimated from a given set of DNA sequences:

```
order <- 1
file <- system.file("extdata", "seq.fasta", package = "motifcounter")
seqs <- Biostrings::readDNAStringSet(file)
bg <- readBackground(seqs, order)
```

**Hint:** Ideally, the DNA sequence for estimating the background model should be representative (or even the same) as the sequences that are latter analysed (e.g. for motif hit enrichment).

**Hint:** For the purpose of motif enrichment testing, we recommend to use orders \(d=1\) or \(d=2\). Using a background with very high order \(d\) might be very costly to compute and, more importantly, due to its increased flexibility, might capture relevant TFBS signals. In that case, enriched motifs might not be recovered.

### 3.1.2 Acquire a motif

`motifcounter` handles motifs in terms of *position frequency matrices* (PFMs), which are commonly used to represent the binding affinity of transcription factors (TFs).

A convenient source of known motifs is the `MotifDb` Bioconductor package [@motifdb], which shall be the basis for our tutorial. For example, we retrieve the motif for the human *Pou5f1* (or *Oct4*) transcription factor as follows

```
# Extract the Oct4 motif from MotifDb
library(MotifDb)
oct4 <- as.list(query(query(query(MotifDb, "hsapiens"),
                "pou5f1"), "jolma2013"))[[1]]
motif <- oct4

# Visualize the motif using seqLogo
library(seqLogo)
seqLogo(motif)
```

![](data:image/png;base64...)

**Hint:** `motifcounter` requires strictly positive entries for a PFM. If this is not the case, the package provides the function `normalizeMotif`, which adds pseudo-observations and re-normalize the columns:

```
new_motif <- normalizeMotif(motif)
```

### 3.1.3 Optional settings

By default, `motifcounter` identifies TFBS with a the false positive probability of \(\alpha=0.001\). The user might want to change the stringency level of \(\alpha\), which is facilitated by `motifcounterOptions`:

```
alpha <- 0.01
motifcounterOptions(alpha)
```

For other options consult `?motifcounterOptions`.

## 3.2 Retrieve position- and strand-specific scores and hits

For the following example, we explore the DNA sequences of a set of *Oct4*-ChIP-seq peaks that were obtained in human *hESC* by the ENCODE project [@encode2012]. The peak regions were trimmed to 200 bps centered around the midpoint.

```
file <- system.file("extdata", "oct4_chipseq.fa", package = "motifcounter")
oct4peaks <- Biostrings::readDNAStringSet(file)
```

### 3.2.1 Analysis of individual DNA sequences

The `motifcounter` package provides functions for exploring position- and strand-specific putative TFBSs in individual DNA sequences. One way to explore a given DNA sequence for TFBSs is by utilizing `scoreSequence`. This function returns the per position and strand scores for a given `Biostring::DNAString`-object (left panel below). To put the observed scores into perspective, the right panel shows the theoretical score distribution in random sequences, which is obtained by `scoreDist`[2](#fn2). Scores at the tail of the distribution occur very rarely by chance. Those are also the ones that give rise to TFBS predictions:

```
# Determine the per-position and per-strand scores
scores <- scoreSequence(oct4peaks[[1]], motif, bg)

# As a comparison, compute the theoretical score distribution
sd <- scoreDist(motif, bg)

par(mfrow = c(1, 2))
# Plot the observed scores, per position and per strand
plot(1:length(scores$fscores), scores$fscores, type = "l",
    col = "blue", xlab = "position", ylab = "score",
    ylim = c(min(sd$score), max(sd$score)), xlim = c(1, 250))
points(scores$rscores, col = "red", type = "l")
legend("topright", c("forw.", "rev."), col = c("blue", "red"), lty = c(1, 1))

# Plot the theoretical score distribution for the comparison
plot(sd$dist, sd$scores, type = "l", xlab = "probability", ylab = "")
```

![](data:image/png;base64...)

Per-position and strand scores

To obtain the predicted TFBSs positions and strands, `motifcounter` provides the function `motifHits`. This function calls motif hits if the observed score exceeds a pre-determined score threshold[3](#fn3).

```
# Call putative TFBSs
mhits <- motifHits(oct4peaks[[1]], motif, bg)

# Inspect the result
fhitpos <- which(mhits$fhits == 1)
rhitpos <- which(mhits$rhits == 1)
fhitpos
```

```
## integer(0)
```

```
rhitpos
```

```
## [1] 94
```

In the example sequence, we obtain no motif hit on the forward strand and one motif hit on the reverse strand at position 94. The underlying DNA sequence at this hit can be retrieved by

```
oct4peaks[[1]][rhitpos:(rhitpos + ncol(motif) - 1)]
```

```
## 9-letter DNAString object
## seq: ATTTACATA
```

Next, we illustrate how a relaxed stringency level influences the number of motif hits. Using `motifcounterOptions`, we prescribe a false positive probability of \(\alpha=0.01\) (the default was \(\alpha=0.001\)). This will increase the tendency of producing motif hits

```
# Prescribe a new false positive level for calling TFBSs
motifcounterOptions(alpha = 0.01)

# Determine TFBSs
mhits <- motifHits(oct4peaks[[1]], motif, bg)

fhitpos <- which(mhits$fhits == 1)
rhitpos <- which(mhits$rhits == 1)
fhitpos
```

```
## [1]  54  87  93 112
```

```
rhitpos
```

```
## [1]  55  94 111 118
```

Now we obtain four hits on each strand.

### 3.2.2 Analysis of a set of DNA sequences

While, `scoreSequence` and `motifHits` can be applied to study TFBSs in a single DNA sequence (given by a `DNAString`-object), one might also be interested in the average score or motif hit profiles across multiple sequences of equal length. This might reveal positional constraints of the motif occurrences with respect to e.g. the TSS, or the summit of ChIP-seq peaks. On the one hand, `motifcounter` provides the method `scoreProfile` which can be applied for `Biostrings::DNAStringSet`-objects.

```
# Determine the average score profile across all Oct4 binding sites
scores <- scoreProfile(oct4peaks, motif, bg)

plot(1:length(scores$fscores), scores$fscores, type = "l",
    col = "blue", xlab = "position", ylab = "score")
points(scores$rscores, col = "red", type = "l")
legend("bottomleft", legend = c("forward", "reverse"),
    col = c("blue", "red"), lty = c(1, 1))
```

![](data:image/png;base64...)

Average score profile

On the other hand, `motifHitProfile` constructs a similar profile by computing the position and strand specific mean motif hit frequency

```
motifcounterOptions()  # let's use the default alpha=0.001 again

# Determine the average motif hit profile
mhits <- motifHitProfile(oct4peaks, motif, bg)

plot(1:length(mhits$fhits), mhits$fhits, type = "l",
    col = "blue", xlab = "position", ylab = "score")
points(mhits$rhits, col = "red", type = "l")
legend("bottomleft", legend = c("forward", "reverse"),
    col = c("blue", "red"), lty = c(1, 1))
```

![](data:image/png;base64...)

Average motif hit profile

## 3.3 Test for motif hit enrichment

A central feature of `motifcounter` represents a sophisticated novel approach for identifying motif hit enrichment in DNA sequences.

To this end, the package contains the method `motifEnrichment`, which evaluates the *P-value* associated with the number of motif hits that are found in the observed sequence, compared to the background model.

```
# Enrichment of Oct4 in Oct4-ChIP-seq peaks
result <- motifEnrichment(oct4peaks[1:10], motif, bg)
result
```

```
## $pvalue
## [1] 6.624993e-07
##
## $fold
## [1] 4.710889
```

The method returns a list that contains `pvalue` as well as `fold`. While, the `pvalue` represents the probability that more or equally many hits are produced in random DNA sequences, `fold` represents the fold-enrichment of motif hits relative the expected number of hits in random DNA sequences. That is, it represents a measure of the effect size.

**Hint:** In case, very long or many DNA sequences are scanned for TFBSs, the distribution of the number of motif hits becomes very narrow. In that case, the tiniest differences between the observed and the expected number of hits give rise to very small *P-values*. In this case, the fold-enrichment should be consulted to reveal if the effect size is of biological relevance.

**Hint:** By default, `motifEnrichment` scans both DNA strands for motif hits and draws its statistical conclusions based on the compound Poisson model. However, motif enrichment can also be performed with respect to scanning single strands (e.g. when analyzing RNA sequences). Please consult `?motifEnrichment` for the single strand option.

**Hint:** `motifEnrichment` may optionally invoke two alternative approaches for approximating the *P-value*, 1) by a **compound Poisson approxmiation** and 2) by a **combinatorial approximation** (see `?motifEnrichment`). As a rule of thumb, we recommend the use compound Poisson model for studying long (or many ) DNA sequences with a fairly stringent \(\alpha\) (e.g. 0.001 or smaller). On the other hand, if a relaxed \(\alpha\) is desired for your analysis (e.g \(\alpha\geq 0.01\)), the **combinatorial approximation** is likely to give more accurate results.

**Hint:** We recommend against using too relaxed choices for \(\alpha\) (e.g \(\alpha\geq 0.05\)), as this violates some of the assumptions on which the models are based on. The consequence might be significant biases of the results.

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] seqLogo_1.76.0       MotifDb_1.52.0       Biostrings_2.78.0
##  [4] XVector_0.50.0       GenomicRanges_1.62.0 Seqinfo_1.0.0
##  [7] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
## [10] generics_0.1.4       motifcounter_1.34.0  knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 SparseArray_1.10.0
##  [3] prettydoc_0.4.1             bitops_1.0-9
##  [5] lattice_0.22-7              digest_0.6.37
##  [7] evaluate_1.0.5              fastmap_1.2.0
##  [9] jsonlite_2.0.0              Matrix_1.7-4
## [11] cigarillo_1.0.0             restfulr_0.0.16
## [13] httr_1.4.7                  XML_3.99-0.19
## [15] codetools_0.2-20            jquerylib_0.1.4
## [17] abind_1.4-8                 cli_3.6.5
## [19] rlang_1.1.6                 crayon_1.5.3
## [21] Biobase_2.70.0              cachem_1.1.0
## [23] DelayedArray_0.36.0         yaml_2.3.10
## [25] S4Arrays_1.10.0             tools_4.5.1
## [27] parallel_4.5.1              BiocParallel_1.44.0
## [29] Rsamtools_2.26.0            SummarizedExperiment_1.40.0
## [31] curl_7.0.0                  R6_2.6.1
## [33] BiocIO_1.20.0               matrixStats_1.5.0
## [35] lifecycle_1.0.4             rtracklayer_1.70.0
## [37] bslib_0.9.0                 data.table_1.17.8
## [39] xfun_0.53                   GenomicAlignments_1.46.0
## [41] MatrixGenerics_1.22.0       rjson_0.2.23
## [43] htmltools_0.5.8.1           rmarkdown_2.30
## [45] compiler_4.5.1              splitstackshape_1.4.8
## [47] RCurl_1.98-1.17
```

---

1. By contrast, a simple binomial approximation [@rsat1,@rahmann] does not account for self-overlapping matches.[↩︎](#fnref1)
2. The score distribution is computed using an efficient dynamic programming algorithm.[↩︎](#fnref2)
3. The threshold is determined for a user-defined false positive level \(\alpha\) (e.g. \(\alpha=0.001\)) based on the theoretical score distribution.[↩︎](#fnref3)
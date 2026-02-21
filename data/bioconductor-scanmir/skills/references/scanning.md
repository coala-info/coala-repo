# Scanning sequences for miRNA binding sites and exploring matches with scanMiR

Fridolin Gross1, Pierre-Luc Germain2,3 and Michael Soutschek1

1Lab of Systems Neuroscience, D-HEST Institute for Neuroscience, ETH
2D-HEST Institute for Neuroscience, ETH
3Lab of Statistical Bioinformatics, UZH

#### 30 October 2025

#### Abstract

This vignettes explores scanMiR’s scanning functions.

#### Package

scanMiR 1.16.0

# Contents

* [1 Scanning](#scanning)
  + [1.1 Background](#background)
  + [1.2 Basic Scan](#basic-scan)
    - [1.2.1 Using a miRNA Seed](#using-a-mirna-seed)
    - [1.2.2 Using a miRNA sequence](#using-a-mirna-sequence)
    - [1.2.3 Using a KdModel](#using-a-kdmodel)
    - [1.2.4 About match types](#about-match-types)
  + [1.3 Further Options](#further-options)
    - [1.3.1 ORF length](#orf-length)
    - [1.3.2 Supplementary 3’ pairing](#sec:3pAlignment)
    - [1.3.3 Shadow and Overlapping Matches](#shadow-and-overlapping-matches)
    - [1.3.4 Aggregation on the fly](#aggregation-on-the-fly)
* [2 Aggregating Sites](#sec:aggregating)
  + [2.1 Background](#background-1)
  + [2.2 Basic Aggregation](#basic-aggregation)
* [3 Dealing with very large scans](#dealing-with-very-large-scans)
  + [3.1 Multithreading](#multithreading)
  + [3.2 Dealing with large collections of predictions](#dealing-with-large-collections-of-predictions)
* [Session info](#session-info)

![](data:image/svg+xml;base64...)

# 1 Scanning

## 1.1 Background

*[scanMiR](https://bioconductor.org/packages/3.22/scanMiR)* can be used to identify potential binding sites given a
set of miRNAs and a set of transcripts. Furthermore, it determines the type of
binding site and, given a `KdModel` object, the predicted affinity of the site.

## 1.2 Basic Scan

The main function used for determining matches of miRNAs in a given set of
sequences is `findSeedMatches`. It accepts a set of DNA sequences either as a
character vector or as a [DNAStringSet](https://bioconductor.org/packages/release/bioc/html/Biostrings.html).
The miRNAs can be provided either as a character vector of seeds/miRNA
sequences or as a `KdModelList`.

### 1.2.1 Using a miRNA Seed

The seed must be given in the form of a (RNA or DNA) sequence of length 7 or 8
(the 8th nucleotide being the final ‘A’ - it is added if only 7 are given).
Note that the seed should be given as it would appear in a match in the target
sequence (i.e. the reverse complement of how it appears in the miRNA).

```
library(scanMiR)

# seed sequence of hsa-miR-155-5p
seed <- "AGCAUUAA"

# load a sample transcript
data("SampleTranscript")

# run scan
matches <- findSeedMatches(SampleTranscript, seed, verbose = FALSE)
matches
```

```
## GRanges object with 2 ranges and 1 metadata column:
##       seqnames    ranges strand |     type
##          <Rle> <IRanges>  <Rle> | <factor>
##   [1]     seq1   491-498      * |  8mer
##   [2]     seq1   692-699      * |  7mer-m8
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

By default, a [GRanges](https://bioconductor.org/packages/release/bioc/html/GenomicRanges.html)
object is returned. Apart from the position of the matches, it provides
information on the type of the putative binding site corresponding to the match.
Setting `ret = "data.frame"` returns the same information as a data.frame.

### 1.2.2 Using a miRNA sequence

Alternatively, we can provide the full miRNA sequence, which results in
additional information on supplementary 3’ pairing in the form of an aggregated
score (see Section [1.3.2](#sec:3pAlignment) for further details).

```
# full sequence of the mature miR-155-5p transcript
miRNA <- "UUAAUGCUAAUCGUGAUAGGGGUU"

# run scan
matches <- findSeedMatches(SampleTranscript, miRNA, verbose = FALSE)
matches
```

```
## GRanges object with 2 ranges and 3 metadata columns:
##       seqnames    ranges strand |     type  p3.score  note
##          <Rle> <IRanges>  <Rle> | <factor> <integer> <Rle>
##   [1]     seq1   491-498      * |  8mer           12 TDMD?
##   [2]     seq1   692-699      * |  7mer-m8         0     -
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

We can take a closer look at the alignment of the first match:

```
viewTargetAlignment(matches[1], miRNA, SampleTranscript)
```

```
##
## miRNA             3'-UUGGGGAUAGUGC-UAA-UCGUAAUU-5'
##                       ||||||||||||     ||||||||
## target 5'-...NGAGUAACGACCCCUAUCACGUCCGCAGCAUUAAAU...-3'
```

Apart from the direct seed match (right), this representation also reveals the
extensive supplementary 3’ pairing (left).

### 1.2.3 Using a KdModel

Finally, we can provide the miRNA in the form of a `KdModel` (see the
[vignette on KdModels](%22Kdmodels.html%22) for further information). In this case
`findSeedMatches` also returns the predicted affinity value for each match. The
`log_kd` column contains log(Kd) values multiplied by 1000, where Kd is the
predicted dissociation constant of miRNA:mRNA binding for the putative binding
site.

```
# load sample KdModel
data("SampleKdModel")

# run scan
matches <- findSeedMatches(SampleTranscript, SampleKdModel, verbose = FALSE)
matches
```

```
## GRanges object with 2 ranges and 4 metadata columns:
##       seqnames    ranges strand |     type    log_kd  p3.score  note
##          <Rle> <IRanges>  <Rle> | <factor> <integer> <integer> <Rle>
##   [1]     seq1   491-498      * |  8mer        -4868        12 TDMD?
##   [2]     seq1   692-699      * |  7mer-m8     -3702         0     -
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Running `findSeedMatches` using a `Kdmodel` also returns matches that correspond
to non-canonical binding sites. These are typically of low affinity, but may
affect repression if several of them are found on the same transcript. The scan
can be restricted to canonical sites using the option `onlyCanonical = TRUE`.

`KdModel` collections corresponding to all human, mouse and rat mirbase miRNAs
can be obtained through the
[scanMiRData](https://github.com/ETHZ-INS/scanMiRData) package.

### 1.2.4 About match types

For canonical sites, we use the site types described in [Grimson et al., Molecular Cell 2007](https://www.sciencedirect.com/science/article/pii/S1097276507004078) based on the matching nucleotides form the miRNA seed:

![Adapted from Grimson et al. 2007](data:image/jpeg;base64...)

Figure 1: Adapted from Grimson et al. 2007

In addition, we include with two additional site types that are classically
considered non-canonical, but have much stronger evidence of binding
than other non-canonical ones, namely G-bulged sites that have an extra non-matching
G in position 5–6 that is bulged out (see [Chi, Hannon & Darnell, 2012](https://www.nature.com/articles/nsmb.2230), and
wobble sites have a single G:U replacement (see [Becker et al., 2019](https://www.sciencedirect.com/science/article/pii/S1097276519304459)).

Also note that all binding sites are reported as the alignment of the seed
region of the miRNA onto the target mRNA, and as such it is always 8 nucleotide
long, even if only 6 or 7nt are actually matching the seed.

## 1.3 Further Options

### 1.3.1 ORF length

If the transcript sequences are provided as a `DNAStringSet`, one may specify
the length of the open reading frame region of the transcripts as a metadata
column in order to distinguish between matches in the ORF and 3’UTR regions.

```
library(Biostrings)

# generate set of random sequences
seqs <- DNAStringSet(getRandomSeq(length = 1000, n = 10))

# add vector of ORF lengths
mcols(seqs)$ORF.length <- sample(500:800, length(seqs))

# run scan
matches2 <- findSeedMatches(seqs, SampleKdModel, verbose = FALSE)
head(matches2)
```

```
## GRanges object with 4 ranges and 5 metadata columns:
##       seqnames    ranges strand |          type    log_kd  p3.score  note   ORF
##          <Rle> <IRanges>  <Rle> |      <factor> <integer> <integer> <Rle> <Rle>
##   [1]     seq2   913-920      * | non-canonical     -1122         2     - FALSE
##   [2]     seq3   259-266      * | 7mer-a1           -3441         0     -  TRUE
##   [3]     seq6   198-205      * | 7mer-m8           -4541         4     -  TRUE
##   [4]     seq6   892-899      * | 7mer-a1           -4497         3     - FALSE
##   -------
##   seqinfo: 10 sequences from an unspecified genome; no seqlengths
```

### 1.3.2 Supplementary 3’ pairing

Upon binding the seed regions, further complementary pairing of the target to the 3’
region of the miRNA can increase affinity and further stabilize the binding
([Schirle, Sheu-Gruttadauria and MacRae, 2014](https://dx.doi.org/10.1126/science.1258040)).
Upon finding a seed match, `scanMiR` performs a local alignment on the upstream
region to identify such complementary 3’ binding. This is internally done by the
`get3pAlignment()` function, the arguments to which (e.g. the maximum size of
the gap between the seed binding and the complementary binding) can be passed
via the `findSeedMatches` argument `p3.params`. By default, when running
`findSeedMatches` a 3’ score is reported in the matches, which roughly
corresponds to the number of consecutive matching nucleotides (adjusting for
small gaps and T/G substitutions) within the constraints (see
`?get3pAlignment` for more detail). More information (such as the size of the
miRNA and target loops between the two complementary regions) can be reported by
setting `findSeedMatches(..., p3.extra=TRUE)`. In addition, the pairing can be
visualized with `viewTargetAlignment`:

```
viewTargetAlignment(matches[1], SampleKdModel, SampleTranscript)
```

```
##
## miRNA             3'-UUGGGGAUAGUGC-UAA-UCGUAAUU-5'
##                       ||||||||||||     ||||||||
## target 5'-...NGAGUAACGACCCCUAUCACGUCCGCAGCAUUAAAU...-3'
```

Some forms of 3’ bindings can however lead to drastic functional consequences.
For example, sufficient final complementary at the 3’ end of the miRNA can lead
to Target-Directed miRNA Degradation (TDMD,
[Sheu-Gruttadauria, Pawlica et al., 2019](https://dx.doi.org/10.1016/j.molcel.2019.06.019)).
`findSeedMatches` will also flag such putative sites in the `notes` column of
the matches. Finally, while circular RNAs can act as miRNA sponges, some miRNA
bindings can slice their circular structure
[Hansen et al., 2011](https://doi.org/10.1038/emboj.2011.359) and free their
cargo. `findSeedMatches` will also flag such sites in the `notes` column.

### 1.3.3 Shadow and Overlapping Matches

The `shadow` argument can be used to take into account the observation that
sites within the first ~15 nucleotides of the 3’UTR show poor efficiency
([Grimson et al. 2007](https://www.sciencedirect.com/science/article/pii/S1097276507004078)).
`findSeedMatches` will treat matches within the first `shadow` positions of the
UTR in the same way as matches in the ORF region. If no information on ORF
lengths is provided, it will simply ignore the first `shadow` positions. The
default setting is `shadow = 0`.

The parameter `minDist` can be used to specify the minimum distance between
matches of the same miRNA (default 7). If there are multiple matches within
`minDist`, only the highest affinity match will be considered.

### 1.3.4 Aggregation on the fly

With `ret = "aggregated"` one obtains a data.frame that contains the predicted
repression for each sequence-seed-pair aggregated over all matches along with
information about the types and number of matches. Parameters for aggregation
can be specified using `agg.params`. For further details, see Section
[2](#sec:aggregating).

# 2 Aggregating Sites

## 2.1 Background

*[scanMiR](https://bioconductor.org/packages/3.22/scanMiR)* implements aggregation of miRNA sites based on the
biochemical model from
[McGeary, Lin et al. (2019)](https://dx.doi.org/10.1126/science.aav1741).
This model first predicts the occupancy of AGO-miRNA complexes at each
potential binding site as a function of the measured or estimated dissociation
constants (Kds). It then assumes an additive effect of the miRNA on the basal
decay rate of the transcript that is proportional to this occupancy.

The key parameters of this model are:

* `a`: the relative concentration of unbound AGO-miRNA complexes
* `b`: the factor that multiplies with the occupancy and is added to the basal
  decay rate (can be interpreted as the additional repression caused by a single
  bound AGO)
* `c`: the penalty factor for sites that are found within the ORF region

More specifically, the occupancy of a mRNA \(m\) by miRNA \(g\), with \(p\) matches
in the ORF region and \(q\) matches in the 3’UTR region, is given by the
following equation:
\[
\begin{equation}
N\_{m,g} =
\sum\_{i=1}^{p}\left(\frac{a\_g}{a\_g + c\_{\text{ORF}}
K\_{d,i}^{\text{ORF}}}\right) +
\sum\_{j=1}^{q}\left(\frac{a\_g}{a\_g + K\_{d,j}^{\text{3'UTR}}}\right)
\end{equation}
\]

The corresponding background occupancy is estimated by substituting the average
affinity of nonspecifically bound sites (i.e. \(K\_d = 1.0\)):
\[
\begin{equation}
N\_{m,g,\text{background}} =
\sum\_{i=1}^{p}\left(\frac{a\_g}{a\_g + c\_{\text{ORF}}}\right) +
\sum\_{j=1}^{q}\left(\frac{a\_g}{a\_g + 1}\right)
\end{equation}
\]
In addition to this original model, `scanMiR` includes a coefficient `e` which
adjusts the Kd values based on the supplementary 3’ alignment:

\[
\begin{equation}
N\_{m,g} =
\sum\_{i=1}^{p}\left(\frac{a\_g}{a\_g + e\_{i}c\_{\text{ORF}}
K\_{d,i}^{\text{ORF}}}\right) +
\sum\_{j=1}^{q}\left(\frac{a\_g}{a\_g + e\_{j}K\_{d,j}^{\text{3'UTR}}}\right)
\end{equation}
\]

with \(e\_i = \exp(\text{p3}\cdot\text{p3.score}\_i)\). `p3` is a global parameter,
and \(p3.score\_i\) is the 3’ alignment score (roughly corresponding to the number
of matched nucleotides, by default capped to 8 and set to 0 if below 3). Of
note, the default value of `p3` is very small, leading to a very mild effect.
The importance of complementary binding seems to depend on the miRNA, and at the
moment there is no easy way to predict this from the miRNA sequence. Our
conservative estimate might not attribute sufficient importance to this factor
for some miRNAs.

The repression is then obtained as the log fold change of the two occupancies:
\[
\text{repression} = \log(1+bN\_{m,g,\text{background}}) - \log(1+bN\_{m,g})
\]

Because UTR and ORF lengths have been reported to influence the efficacy of
repression, `scanMiR` also includes an additional modifier to terms handling
these effects:

\[
\text{repression}\_{\text{adj}} = \text{repression}\cdot
(1+f\cdot\text{UTR.length}+h\cdot\text{ORF.length})
\]
While `b`, `c`, `p3`, `f` and `h` are considered global parameters (i.e. the
same for different miRNAs and transcripts and also across experimental
contexts), `a` is expected to be different for each miRNA in a
given experimental condition. However, as shown by
[McGeary, Lin et al. (2019)](https://dx.doi.org/10.1126/science.aav1741), the
model performance is robust to changes in `a` over several orders of magnitude.
Aggregation for all miRNA-transcript pairs for a given data set is therefore
usually based on a single `a` value.

## 2.2 Basic Aggregation

Given a `GRanges` or data.frame of matches as returned by `findSeedMatches`,
aggregation can be performed by the function `aggregateMatches`:

```
agg_matches <- aggregateMatches(matches2)
head(agg_matches)
```

```
##   transcript  repression 8mer 7mer 6mer non-canonical ORF.canonical
## 1       seq2 -0.03865003    0    0    0             1             0
## 2       seq3 -0.09972592    0    0    0             0             1
## 3       seq6 -1.00475340    0    1    0             0             1
##   ORF.nonCanonical
## 1                0
## 2                0
## 3                0
```

This returns a data.frame with predicted repression values for each
miRNA-transcript pair along with a count table of the different site types. If
`matches` does not contain a `log_kd` column, only the count table will be
returned.

*[scanMiR](https://bioconductor.org/packages/3.22/scanMiR)* uses the following
default parameter values for aggregation that have been determined by fitting
and validating the model using several experimental data sets:

```
unlist(scanMiR:::.defaultAggParams())
```

```
##            a            b            c           p3     coef_utr     coef_orf
##     0.007726     0.573500     0.181000     0.051000    -0.171060    -0.215460
## keepSiteInfo
##     1.000000
```

Where `coef_utr` and `coef_orf` respectively correspond to the `f` and `h` in
the above formula. To disable these features, they can simply be set to
zero. `keepSiteInfo` lets you choose whether the site count table should be
returned. The parameters can be passed directly to `aggregateMatches`, or passed
to `findSeedMatch` when doing aggregation on-the-fly using the `agg.params`
argument.

# 3 Dealing with very large scans

## 3.1 Multithreading

To deal with large amounts of sequences and/or seeds, both `findSeedMatches`
and `aggregateMatches` support multithreading using the
*[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* package. This can be activated by passing
`BP = MulticoreParam(ncores)`.

Depending on the system and the size of the scan (i.e. when including all
non-canonical sites), mutlithreading can potentially take a large amount of
memory. To avoid memory issues, the number of seeds processed simultaneously by
`findSeedMatches` can be restricted using the `n_seeds` parameter.
Alternatively, scan results can be saved to temporary files using the
`useTmpFiles` argument (see `?findSeedMatches` for more detail).

Note that in addition to the multithreading specified in its arguments,
`aggregateMatches` uses the *[data.table](https://CRAN.R-project.org/package%3Ddata.table)* package, which is often
set to use multi-threading by default (see `?data.table::setDTthreads` for more
information). This can leave to CPU usage higher than specified through the
`BP` argument of `aggregateMatches`.

## 3.2 Dealing with large collections of predictions

Binding sites for all miRNAs on all transcripts, especially when including
non-canonical sites, can easily amount to prohibitive amounts of memory. The
companion [scanMiRApp](https://github.com/ETHZ-INS/scanMiRApp) package includes
a class implementing fast indexed access to on-disk GenomicRanges and
data.frames. The package additionally contains wrapper (e.g. for performing full
transcriptome scans) for common species and for detecting enriched miRNA-target
pairs, as well as a shiny interface to `scanMiR`.

# Session info

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
## [1] Biostrings_2.78.0   Seqinfo_1.0.0       XVector_0.50.0
## [4] IRanges_2.44.0      S4Vectors_0.48.0    BiocGenerics_0.56.0
## [7] generics_0.1.4      scanMiR_1.16.0      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10          stringi_1.8.7        digest_0.6.37
##  [4] magrittr_2.0.4       evaluate_1.0.5       grid_4.5.1
##  [7] RColorBrewer_1.1-3   bookdown_0.45        fastmap_1.2.0
## [10] jsonlite_2.0.0       BiocManager_1.30.26  scales_1.4.0
## [13] codetools_0.2-20     jquerylib_0.1.4      cli_3.6.5
## [16] rlang_1.1.6          crayon_1.5.3         cowplot_1.2.0
## [19] withr_3.0.2          cachem_1.1.0         yaml_2.3.10
## [22] tools_4.5.1          parallel_4.5.1       BiocParallel_1.44.0
## [25] seqLogo_1.76.0       dplyr_1.1.4          ggplot2_4.0.0
## [28] vctrs_0.6.5          R6_2.6.1             lifecycle_1.0.4
## [31] pwalign_1.6.0        pkgconfig_2.0.3      pillar_1.11.1
## [34] bslib_0.9.0          gtable_0.3.6         glue_1.8.0
## [37] data.table_1.17.8    xfun_0.53            tibble_3.3.0
## [40] GenomicRanges_1.62.0 tidyselect_1.2.1     knitr_1.50
## [43] dichromat_2.0-0.1    farver_2.1.2         htmltools_0.5.8.1
## [46] labeling_0.4.3       rmarkdown_2.30       compiler_4.5.1
## [49] S7_0.2.0
```
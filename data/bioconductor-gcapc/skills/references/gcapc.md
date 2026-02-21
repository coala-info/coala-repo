# The *gcapc* user’s guide

| Mingxiang Teng
| Rafael A. Irizarry
| Department of Biostatistics, Dana-Farber Cancer Institute &
| Harvard T.H. Chan School of Public Health, Boston, MA, USA

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Getting Started](#getting-started)
* [3 Preparing Inputs](#preparing-inputs)
* [4 Peak Calling/Refining](#peak-callingrefining)
  + [4.1 Reads coverage](#reads-coverage)
  + [4.2 Binding width](#binding-width)
  + [4.3 GC effects](#gc-effects)
  + [4.4 Peak significance](#peak-significance)
  + [4.5 Peak refining](#peak-refining)
* [5 Correcting GC Effects for A Count Table](#correcting-gc-effects-for-a-count-table)
* [6 Summary](#summary)
* [References](#references)

# 1 Introduction

ChIP-seq has been widely utilized as the standard technology to detect
protein binding regions, where peak calling algorithms were developed
particularly to serve the analysis. Existing peak callers lack of power
on ranking peaks’ significance due to sequencing technology might undergo
sequence context biases, *e.g.* GC bias. *gcapc* is designed to address this
deficiency by modeling GC effects into peak calling. *gcapc* can also help
refine the significance of peaks called by other peak callers, or correct
the GC-content bias for a read count table for a predefined set of genomic
regions across a series of samples. The *gcapc* package requires the
inputs as one ChIP-seq BAM file (for peak calling/refining) or a read
count table (for GC effects removal) as well as other optional parameters.

A common analysis for peak calling/refining contains four steps.

1. Reads coverage. In this step, BAM file records will be converted to
   coverages on basepair resolution for forward and reverse strands
   separately.
2. Binding width estimation. This parameter is a measurement for the size
   of protein binding region in crosslinked complexes of ChIP experiments.
   Also, peak detection half size are estimated based on region signals from
   two strands.
3. GC effects estimation. Generalized linear mixture models followed by EM
   algorithms are performed to evaluate potential GC effects.
4. Peak calling/refining. For peak calling, enrichment scores are
   evaluated by permutation analysis for significance. Peaks are reported
   with enrichment scores and p-values. For peak refining, peaks called by
   other peak callers should be provided as a GRanges object. New enrichment
   significances are added as meta columns for the input peaks.

For correcting GC effects on a count table, one step analysis based on
function *refineSites* is enough.

# 2 Getting Started

Load the package in R

```
library(gcapc)
```

# 3 Preparing Inputs

Preparing inputs for correcting GC effects on a count table should be easy by
referring to the function man page. Here, we focus on inputs for peak calling
and refining. The inputs could be as minimum as a path to a BAM file, which is
an indexed alignment records for sequencing reads. However, additional
options are encouraged to be specified to accelerate the analysis and
improve the accuracy. The following set are the options which can be
customized by users.

1. BAM records filtering options. In the function *read5endCoverage*,
   reads can be filtered for selected chromosomes, mapping quality,
   duplicate removal, etc. Downstream analysis could be highly accelerated
   if only a subset of chromosomes are analyzed. This actually suggests
   a divide and conquer strategy if one ChIP-seq experiment is extremely
   deeply sequenced. In that case, analysis based on each chromosome
   level could save lots of memory.
2. Sequencing fragments options. If one has prior knowledge on the
   size of sequencing fragments. The optional arguments in function
   *bindWidth* could be specified to limit searching in narrower
   ranges; Or, this function can be omitted if binding width are known
   in advance. Note that this binding width might not be equivalent to
   the binding width of protein in biology, since it could be affected
   by crosslinking operations.
3. Sampling size for GC effects estimation. The default is 0.05, which
   means 5% of genome will be used if analysis is based on whole genome.
   However, for smaller genomes or small subset of chromosomes, this size
   should be tuned higher to ensure accuracy. Or, sample genome multiple
   times, and use average estimation to aviod sampling bias. Note: larger
   sample size or more sampling times result longer computation of
   GC effects estimation.
4. GC ranges for GC effects estimation. As illustrated in the man pages,
   GC ranges (*gcrange* parameter) should be carefully selected. The reason
   is that regions with extremely low/high GC content sometimes act as
   outliers, and can drive the regression lines when selected forground
   regions are too few in mixture model fitting. This happens when
   the studied binding protein has too few genome-wide binding events.
5. EM algorithm priors and convergence. Options for EM algorithms can
   be tuned to accelerate the iterations.
6. Permutation times. As we suggested in the function help page, a
   proper times of permutation could save time as well as ensuring accuracy.

In this vignette, we will use enbedded file *chipseq.bam* as one example
to illustrate this package. This file contains about ~80000 reads from
human chromosome 21 for CTCF ChIP-seq data.

```
bam <- system.file("extdata", "chipseq.bam", package="gcapc")
```

# 4 Peak Calling/Refining

For details of the algorithms, please refer to our paper (Teng and Irizarry [2017](#ref-teng)).

## 4.1 Reads coverage

The first step is to generate the reads coverage for both forward and reverse
strands. The coverage is based on single nucleotide resolution and uses only
the 5’ ends of BAM records. That means, if duplicates are not allowed, the
maximum coverage for every nucleotide is 1.

```
cov <- read5endCoverage(bam)
cov
## $fwd
## RleList of length 1
## $chr21
## integer-Rle of length 48129895 with 40225 runs
##   Lengths: 9414767       1    8350       1 ...       1     116       1   41437
##   Values :       0       1       0       1 ...       1       0       1       0
##
##
## $rev
## RleList of length 1
## $chr21
## integer-Rle of length 48129895 with 40427 runs
##   Lengths: 9412972       1    3087       1 ...       1     367       1   34767
##   Values :       0       1       0       1 ...       1       0       1       0
```

Obejct *cov* is a two-element list representing coverages for forward and
reverse strands, respectively, while each element is a list for coverages
on individual chromosomes.

## 4.2 Binding width

The second step is to estimate the binding width and peak detection half
window size of ChIP-seq experiment.
This step could be omitted if binding width is known in advance. Binding
width is further treated as the size of region unit for effective GC
bias estimation and peak calling. Peak detection half
window size is used to define width of flanking regions.

If additional information is known from sequencing fragments, this step
could be speeded up. For example, narrowing down the range size helps.

```
bdw <- bindWidth(cov, range=c(50L,300L), step=10L)
## Starting to estimate bdwidth.
## ...... Cycle 1 for bind width estimation
## ...... Cycle 2 for bind width estimation
## ...... Cycle 3 for bind width estimation
## ...... Cycle final for bind width estimation
## ...... Estimated bind width as 111
## ...... Estimated peak window half size as 220
## Refining peak window half size by region from two strands
## ......................
## ...... Refined peak window half size as 135
bdw
## [1] 111 135
```

## 4.3 GC effects

This step performs GC effects estimation using the proposed models. It is
noted that by allowing to display the plots, one can view intermediate
results which provide you direct sense on your ChIP-seq data, such as the
extent of GC effects. Also, the EM algorithms iterations are enabled by
default to display the trace of log likelihood changes, and other
notification messages are printed for courtesy.

```
layout(matrix(1:2,1,2))
gcb <- gcEffects(cov, bdw, sampling=c(0.25,1), plot=TRUE, model='poisson')
## Starting to estimate GC effects
## ...... Too few/much ranges in 'supervise'. Selecting random sampling
## ......... Sampling 25 percent of regions by 1 times, total 108395 regions
## ...... Counting reads
## ...... Calculating GC content with flanking 79
## ...... Estimating GC effects
## ......... Iteration 1    ll -35148.61    increment 109906.9
## ......... Iteration 2    ll -34316.64    increment 831.9672
## ......... Iteration 3    ll -34285.41    increment 31.23412
```

![](data:image/png;base64...)

Here, 25% of windows were sampled with 1 repeat.
The left figure provides the correlation between forward and reverse
strands signals, by using the estimated binding width as region unit.
The right figure shows the raw and predicted GC effects using mixture model.

Two other options need to be noted here are *supervise* and *model*.
If *supervise* option is specified as a GRanges object, it provides a set of
potential peaks and allows more efficient sampling procedure. In detail, the
two mixtures are sampled separately from forground (signal) and background
regions. *model* option allows switching between Poisson and Negative Binomial
distribution (default) in model fitting. Theoratically, Negative Binomial
assumption is more accurate than poisson. Nevertheless, Poisson is a good
approximation to Negative Binomial for GC effect estimation here, and shows
much faster computing speed than Negative Binomial especially when the total
number of selected bins is large.

## 4.4 Peak significance

This is the last step for peak calling. It uses information generated in
previous steps, calculates enrichment scores and performs permutation analysis
to propose significant peak regions. Final peaks are formated into *GRanges*
object, and meta columns are used to record significance. Additional
notification messages are also printed.

```
layout(matrix(1:2,1,2))
peaks <- gcapcPeaks(cov, gcb, bdw, plot=TRUE, permute=100L)
peaks <- gcapcPeaks(cov, gcb, bdw, plot=TRUE, permute=50L)
```

![](data:image/png;base64...)

```
peaks
## GRanges object with 413 ranges and 2 metadata columns:
##         seqnames            ranges strand |        es          pv
##            <Rle>         <IRanges>  <Rle> | <numeric>   <numeric>
##     [1]    chr21   9827175-9827475      * |    23.063 9.17473e-08
##     [2]    chr21   9909602-9909750      * |     8.042 1.65546e-02
##     [3]    chr21   9915442-9915509      * |     6.937 2.80852e-02
##     [4]    chr21 11175039-11175174      * |     6.978 2.75415e-02
##     [5]    chr21 15626034-15626187      * |    32.631 9.17473e-08
##     ...      ...               ...    ... .       ...         ...
##   [409]    chr21 47705703-47705851      * |     6.330 3.72794e-02
##   [410]    chr21 47745293-47745459      * |    12.006 1.83045e-03
##   [411]    chr21 48055040-48055206      * |    13.856 5.48833e-04
##   [412]    chr21 48059797-48059983      * |    11.168 3.03785e-03
##   [413]    chr21 48081170-48081315      * |    33.969 9.17473e-08
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

It is noted that here two tests using different number of permutation times
results almost the same cutoff on enrichment scores, which suggests small
number of permutations are allowed to save time. The left figure shows here
the cutoff on enrichment scores based on 50 times of permutations, and
right figure shows it based on 100 times of permutations. Note that we only
used chromosome 21 for illustration, thus increased permutation times
from default 5 to 50 here.

## 4.5 Peak refining

In order to remove GC effects on other peak callers’ outputs, this package
provides function to refine enrichment significance for given peaks.
Peaks have to be provided as a GRanges object. A flexible set of peaks are
preferred to reduce potential false negative, meaning both significant
(e.g. p<=0.05) and non-significant (e.g. p>0.05) peaks are preferred to be
included. If the total number of peaks is not too big, a reasonable set of
peaks include all those with p-value/FDR less than 0.99 by other peak callers.

```
newpeaks <- refinePeaks(cov, gcb, bdw, peaks=peaks, permute=50L)
plot(newpeaks$es,newpeaks$newes,xlab='old score',ylab='new score')
```

![](data:image/png;base64...)

```
newpeaks
## GRanges object with 413 ranges and 4 metadata columns:
##         seqnames            ranges strand |        es          pv     newes
##            <Rle>         <IRanges>  <Rle> | <numeric>   <numeric> <numeric>
##     [1]    chr21   9827175-9827475      * |    23.063 9.17473e-08    23.063
##     [2]    chr21   9909602-9909750      * |     8.042 1.65546e-02     8.042
##     [3]    chr21   9915442-9915509      * |     6.937 2.80852e-02     6.937
##     [4]    chr21 11175039-11175174      * |     6.978 2.75415e-02     6.978
##     [5]    chr21 15626034-15626187      * |    32.631 9.17473e-08    32.631
##     ...      ...               ...    ... .       ...         ...       ...
##   [409]    chr21 47705703-47705851      * |     6.330 3.72794e-02     6.330
##   [410]    chr21 47745293-47745459      * |    12.006 1.83045e-03    12.006
##   [411]    chr21 48055040-48055206      * |    13.856 5.48833e-04    13.856
##   [412]    chr21 48059797-48059983      * |    11.168 3.03785e-03    11.168
##   [413]    chr21 48081170-48081315      * |    33.969 9.17473e-08    33.969
##               newpv
##           <numeric>
##     [1] 8.54918e-06
##     [2] 3.35447e-02
##     [3] 5.19522e-02
##     [4] 5.11407e-02
##     [5] 1.23901e-07
##     ...         ...
##   [409] 6.53721e-02
##   [410] 5.49960e-03
##   [411] 2.09207e-03
##   [412] 8.32764e-03
##   [413] 1.23901e-07
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Here, two new meta columns are added into previous peaks (GRanges), including
adjusted significance and p-values. It is noted that the new enrichment
scores are actually the same as previously calculated (figure above) since
the peak regions were previously called by *gcapc*. In practice, peak regions
and their significances called by other peak callers mostly would be different
from *gcapc* if there is strong GC bias. If refining those peak significances,
the improvement should be obvious as we showed in our paper.

# 5 Correcting GC Effects for A Count Table

In this package, function *refineSites* is provided in case that some are more
interested in correcting GC effects for pre-defined regions instead of peak
calling. We used this function to adjust signals for ENCODE reported sites
in our paper (Teng and Irizarry [2017](#ref-teng)). This function is eay-to-use, with a count table and
corresponding genomic regions are the two required inputs. For detail of
using this function, please read the function man page.

# 6 Summary

In this vignette, we went through main functions in this package, and
illustrated how they worked. By following these steps, users will be able to
remove potential GC effects either for peak identification or for read
count signals.

# References

Teng, Mingxiang, and Rafael A. Irizarry. 2017. “Accounting for Gc-Content Bias Reduces Systematic Errors and Batch Effects in Chip-Seq Data.” *Genome Research*.
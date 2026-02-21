# Some Basic Analysis of ChIP-Seq Data

Oluwabukola Bamigbade1

1Vignette translation from Sweave to Rmarkdown / HTML

#### October 29, 2025

# Contents

* [1 Example data](#example-data)
* [2 Extending reads](#extending-reads)
* [3 Coverage, islands, and depth](#coverage-islands-and-depth)
* [4 Processing multiple lanes](#processing-multiple-lanes)
* [5 Peaks](#peaks)
* [6 Differential peaks](#differential-peaks)
* [7 Placing peaks in genomic context](#placing-peaks-in-genomic-context)
* [8 Visualizing peaks in genomic context](#visualizing-peaks-in-genomic-context)
* [9 Version information](#version-information)

Our goal is to describe the use of Bioconductor software to perform some
basic tasks in the analysis of ChIP-Seq data. We will use several
functions in the as-yet-unreleased *[chipseq](https://bioconductor.org/packages/3.22/chipseq)* package, which
provides convenient interfaces to other powerful packages such as
*[ShortRead](https://bioconductor.org/packages/3.22/ShortRead)* and *[IRanges](https://bioconductor.org/packages/3.22/IRanges)*. We will also use
the *[lattice](https://CRAN.R-project.org/package%3Dlattice)* and *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* packages for
visualization.

```
library(chipseq)
library(GenomicFeatures)
library(lattice)
```

# 1 Example data

The `cstest` data set is included in the *[chipseq](https://bioconductor.org/packages/3.22/chipseq)* package
to help demonstrate its capabilities. The dataset contains data for
three chromosomes from Solexa lanes, one from a CTCF mouse ChIP-Seq, and
one from a GFP mouse ChIP-Seq. The raw reads were aligned to the
reference genome (mouse in this case) using an external program (MAQ),
and the results read in using the the `readAligned` function in the
*[ShortRead](https://bioconductor.org/packages/3.22/ShortRead)*, in conjunction with a filter produced by the
`chipseqFilter` function. This step filtered the reads to remove
duplicates, to restrict mappings to the canonical, autosomal chromosomes
and ensure that only a single read maps to a given position. A quality
score cutoff was also applied. The remaining data were reduced to a set
of aligned intervals (including orientation). This saves a great deal of
memory, as the sequences, which are unnecessary, are discarded. Finally,
we subset the data for chr10 to chr12, simply for convenience in this
vignette.

We outline this process with this unevaluated code block:

```
qa_list <- lapply(sampleFiles, qa)
report(do.call(rbind, qa_list))
## spend some time evaluating the QA report, then procede
filter <- compose(chipseqFilter(), alignQualityFilter(15))
cstest <- GenomicRangesList(lapply(sampleFiles, function(file) {
  as(readAligned(file, filter), "GRanges")
}))
cstest <- cstest[seqnames(cstest) %in% c("chr10", "chr11", "chr12")]
```

The above step has been performed in advance, and the output has been included
as a dataset in this package. We load it now:

```
data(cstest)
cstest
```

```
## GRangesList object of length 2:
## $ctcf
## GRanges object with 450096 ranges and 0 metadata columns:
##            seqnames              ranges strand
##               <Rle>           <IRanges>  <Rle>
##        [1]    chr10     3012936-3012959      +
##        [2]    chr10     3012941-3012964      +
##        [3]    chr10     3012944-3012967      +
##        [4]    chr10     3012955-3012978      +
##        [5]    chr10     3012963-3012986      +
##        ...      ...                 ...    ...
##   [450092]    chr12 121239376-121239399      -
##   [450093]    chr12 121245849-121245872      -
##   [450094]    chr12 121245895-121245918      -
##   [450095]    chr12 121246344-121246367      -
##   [450096]    chr12 121253499-121253522      -
##   -------
##   seqinfo: 35 sequences from an unspecified genome
##
## $gfp
## GRanges object with 295385 ranges and 0 metadata columns:
##            seqnames              ranges strand
##               <Rle>           <IRanges>  <Rle>
##        [1]    chr10     3002512-3002535      +
##        [2]    chr10     3009093-3009116      +
##        [3]    chr10     3020716-3020739      +
##        [4]    chr10     3023026-3023049      +
##        [5]    chr10     3024629-3024652      +
##        ...      ...                 ...    ...
##   [295381]    chr12 121213126-121213149      -
##   [295382]    chr12 121216905-121216928      -
##   [295383]    chr12 121216967-121216990      -
##   [295384]    chr12 121251805-121251828      -
##   [295385]    chr12 121253426-121253449      -
##   -------
##   seqinfo: 35 sequences from an unspecified genome
```

`cstest` is an object of class *GRangesList*, and has a list-like structure,
each component representing the alignments from one lane, as a *GRanges* object
of stranded intervals.

```
cstest$ctcf
```

```
## GRanges object with 450096 ranges and 0 metadata columns:
##            seqnames              ranges strand
##               <Rle>           <IRanges>  <Rle>
##        [1]    chr10     3012936-3012959      +
##        [2]    chr10     3012941-3012964      +
##        [3]    chr10     3012944-3012967      +
##        [4]    chr10     3012955-3012978      +
##        [5]    chr10     3012963-3012986      +
##        ...      ...                 ...    ...
##   [450092]    chr12 121239376-121239399      -
##   [450093]    chr12 121245849-121245872      -
##   [450094]    chr12 121245895-121245918      -
##   [450095]    chr12 121246344-121246367      -
##   [450096]    chr12 121253499-121253522      -
##   -------
##   seqinfo: 35 sequences from an unspecified genome
```

# 2 Extending reads

Solexa gives us the first few (24 in this example) bases of each
fragment it sequences, but the actual fragment is longer. By design,
the sites of interest (transcription factor binding sites) should be
somewhere in the fragment, but not necessarily in its initial part.
Although the actual lengths of fragments vary, extending the alignment
of the short read by a fixed amount in the appropriate direction,
depending on whether the alignment was to the positive or negative
strand, makes it more likely that we cover the actual site of
interest.

It is possible to estimate the fragment length, through a variety of methods.
There are several implemented by the `estimate.mean.fraglen` function.
Generally, this only needs to be done for one sample from each experimental
protocol. Here, we use SSISR, the default method:

```
fraglen <- estimate.mean.fraglen(cstest$ctcf, method="correlation")
fraglen[!is.na(fraglen)]
```

```
## chr10 chr11 chr12
##   340   340   340
```

Given the suggestion of \(~190\) nucleotides, we extend all reads to be 200 bases
long. This is done using the `resize` function, which considers the strand to
determine the direction of extension:

```
ctcf.ext <- resize (cstest$ctcf, width = 200)
ctcf.ext
```

```
## GRanges object with 450096 ranges and 0 metadata columns:
##            seqnames              ranges strand
##               <Rle>           <IRanges>  <Rle>
##        [1]    chr10     3012936-3013135      +
##        [2]    chr10     3012941-3013140      +
##        [3]    chr10     3012944-3013143      +
##        [4]    chr10     3012955-3013154      +
##        [5]    chr10     3012963-3013162      +
##        ...      ...                 ...    ...
##   [450092]    chr12 121239200-121239399      -
##   [450093]    chr12 121245673-121245872      -
##   [450094]    chr12 121245719-121245918      -
##   [450095]    chr12 121246168-121246367      -
##   [450096]    chr12 121253323-121253522      -
##   -------
##   seqinfo: 35 sequences from an unspecified genome
```

We now have intervals for the CTCF lane that represent the original
fragments that were precipitated.

# 3 Coverage, islands, and depth

A useful summary of this information is the *coverage*, that is, how many times
each base in the genome was covered by one of these intervals.

```
cov.ctcf <- coverage(ctcf.ext)
cov.ctcf
```

```
## RleList of length 35
## $chr1
## integer-Rle of length 197195432 with 1 run
##   Lengths: 197195432
##   Values :         0
##
## $chr2
## integer-Rle of length 181748087 with 1 run
##   Lengths: 181748087
##   Values :         0
##
## $chr3
## integer-Rle of length 159599783 with 1 run
##   Lengths: 159599783
##   Values :         0
##
## $chr4
## integer-Rle of length 155630120 with 1 run
##   Lengths: 155630120
##   Values :         0
##
## $chr5
## integer-Rle of length 152537259 with 1 run
##   Lengths: 152537259
##   Values :         0
##
## ...
## <30 more elements>
```

For efficiency, the result is stored in a run-length encoded form.

The regions of interest are contiguous segments of non-zero coverage,
also known as *islands*.

```
islands <- slice(cov.ctcf, lower = 1)
islands
```

```
## RleViewsList object of length 35:
## $chr1
## Views on a 197195432-length Rle subject
##
## views: NONE
##
## $chr2
## Views on a 181748087-length Rle subject
##
## views: NONE
##
## $chr3
## Views on a 159599783-length Rle subject
##
## views: NONE
##
## ...
## <32 more elements>
```

For each island, we can compute the number of reads in the island, and
the maximum coverage depth within that island.

```
viewSums(islands)
```

```
## IntegerList of length 35
## [["chr1"]] integer(0)
## [["chr2"]] integer(0)
## [["chr3"]] integer(0)
## [["chr4"]] integer(0)
## [["chr5"]] integer(0)
## [["chr6"]] integer(0)
## [["chr7"]] integer(0)
## [["chr8"]] integer(0)
## [["chr9"]] integer(0)
## [["chr10"]] 2400 200 200 200 200 200 200 600 ... 200 200 400 200 200 200 200
## ...
## <25 more elements>
```

```
viewMaxs(islands)
```

```
## IntegerList of length 35
## [["chr1"]] integer(0)
## [["chr2"]] integer(0)
## [["chr3"]] integer(0)
## [["chr4"]] integer(0)
## [["chr5"]] integer(0)
## [["chr6"]] integer(0)
## [["chr7"]] integer(0)
## [["chr8"]] integer(0)
## [["chr9"]] integer(0)
## [["chr10"]] 11 1 1 1 1 1 1 3 1 1 1 1 1 1 2 1 ... 1 2 1 1 1 1 3 1 1 1 2 1 1 1 1
## ...
## <25 more elements>
```

```
nread.tab <- table(viewSums(islands) / 200)
depth.tab <- table(viewMaxs(islands))

nread.tab[,1:10]
```

```
##                  1     2     3     4     5     6     7     8     9    10
## chr1             0     0     0     0     0     0     0     0     0     0
## chr2             0     0     0     0     0     0     0     0     0     0
## chr3             0     0     0     0     0     0     0     0     0     0
## chr4             0     0     0     0     0     0     0     0     0     0
## chr5             0     0     0     0     0     0     0     0     0     0
## chr6             0     0     0     0     0     0     0     0     0     0
## chr7             0     0     0     0     0     0     0     0     0     0
## chr8             0     0     0     0     0     0     0     0     0     0
## chr9             0     0     0     0     0     0     0     0     0     0
## chr10        68101 13352  3019   924   418   246   191   123   133   100
## chr11        71603 15993  4334  1410   619   338   245   199   180   151
## chr12        59141 11279  2613   816   344   175   140   119    84    71
## chr13            0     0     0     0     0     0     0     0     0     0
## chr14            0     0     0     0     0     0     0     0     0     0
## chr15            0     0     0     0     0     0     0     0     0     0
## chr16            0     0     0     0     0     0     0     0     0     0
## chr17            0     0     0     0     0     0     0     0     0     0
## chr18            0     0     0     0     0     0     0     0     0     0
## chr19            0     0     0     0     0     0     0     0     0     0
## chrX             0     0     0     0     0     0     0     0     0     0
## chrY             0     0     0     0     0     0     0     0     0     0
## chrM             0     0     0     0     0     0     0     0     0     0
## chr1_random      0     0     0     0     0     0     0     0     0     0
## chr3_random      0     0     0     0     0     0     0     0     0     0
## chr4_random      0     0     0     0     0     0     0     0     0     0
## chr5_random      0     0     0     0     0     0     0     0     0     0
## chr7_random      0     0     0     0     0     0     0     0     0     0
## chr8_random      0     0     0     0     0     0     0     0     0     0
## chr9_random      0     0     0     0     0     0     0     0     0     0
## chr13_random     0     0     0     0     0     0     0     0     0     0
## chr16_random     0     0     0     0     0     0     0     0     0     0
## chr17_random     0     0     0     0     0     0     0     0     0     0
## chrX_random      0     0     0     0     0     0     0     0     0     0
## chrY_random      0     0     0     0     0     0     0     0     0     0
## chrUn_random     0     0     0     0     0     0     0     0     0     0
```

```
depth.tab[,1:10]
```

```
##                  1     2     3     4     5     6     7     8     9    10
## chr1             0     0     0     0     0     0     0     0     0     0
## chr2             0     0     0     0     0     0     0     0     0     0
## chr3             0     0     0     0     0     0     0     0     0     0
## chr4             0     0     0     0     0     0     0     0     0     0
## chr5             0     0     0     0     0     0     0     0     0     0
## chr6             0     0     0     0     0     0     0     0     0     0
## chr7             0     0     0     0     0     0     0     0     0     0
## chr8             0     0     0     0     0     0     0     0     0     0
## chr9             0     0     0     0     0     0     0     0     0     0
## chr10        68149 14748  2386   547   256   180   150   129   120   101
## chr11        71677 17945  3527   862   362   268   205   179   181   130
## chr12        59181 12441  2078   482   191   131   131   108    95    77
## chr13            0     0     0     0     0     0     0     0     0     0
## chr14            0     0     0     0     0     0     0     0     0     0
## chr15            0     0     0     0     0     0     0     0     0     0
## chr16            0     0     0     0     0     0     0     0     0     0
## chr17            0     0     0     0     0     0     0     0     0     0
## chr18            0     0     0     0     0     0     0     0     0     0
## chr19            0     0     0     0     0     0     0     0     0     0
## chrX             0     0     0     0     0     0     0     0     0     0
## chrY             0     0     0     0     0     0     0     0     0     0
## chrM             0     0     0     0     0     0     0     0     0     0
## chr1_random      0     0     0     0     0     0     0     0     0     0
## chr3_random      0     0     0     0     0     0     0     0     0     0
## chr4_random      0     0     0     0     0     0     0     0     0     0
## chr5_random      0     0     0     0     0     0     0     0     0     0
## chr7_random      0     0     0     0     0     0     0     0     0     0
## chr8_random      0     0     0     0     0     0     0     0     0     0
## chr9_random      0     0     0     0     0     0     0     0     0     0
## chr13_random     0     0     0     0     0     0     0     0     0     0
## chr16_random     0     0     0     0     0     0     0     0     0     0
## chr17_random     0     0     0     0     0     0     0     0     0     0
## chrX_random      0     0     0     0     0     0     0     0     0     0
## chrY_random      0     0     0     0     0     0     0     0     0     0
## chrUn_random     0     0     0     0     0     0     0     0     0     0
```

# 4 Processing multiple lanes

Although data from one lane is often a natural analytical unit, we typically
want to apply any procedure to all lanes. Here is a simple summary function that
computes the frequency distribution of the number of reads.

```
islandReadSummary <- function(x)
{
    g <- resize(x, 200)
    s <- slice(coverage(g), lower = 1)
    tab <- table(viewSums(s) / 200)
    df <- DataFrame(tab)
    colnames(df) <- c("chromosome", "nread", "count")
    df$nread <- as.integer(df$nread)
    df
}
```

Applying it to our test-case, we get

```
head(islandReadSummary(cstest$ctcf))
```

```
## DataFrame with 6 rows and 3 columns
##   chromosome     nread     count
##     <factor> <integer> <integer>
## 1       chr1         1         0
## 2       chr2         1         0
## 3       chr3         1         0
## 4       chr4         1         0
## 5       chr5         1         0
## 6       chr6         1         0
```

We can now use it to summarize the full dataset, flattening the returned
*DataFrameList* with the `stack` function.

```
nread.islands <- DataFrameList(lapply(cstest, islandReadSummary))
nread.islands <- stack(nread.islands, "sample")
nread.islands
```

```
## DataFrame with 4025 rows and 4 columns
##      sample   chromosome     nread     count
##       <Rle>     <factor> <integer> <integer>
## 1      ctcf         chr1         1         0
## 2      ctcf         chr2         1         0
## 3      ctcf         chr3         1         0
## 4      ctcf         chr4         1         0
## 5      ctcf         chr5         1         0
## ...     ...          ...       ...       ...
## 4021    gfp chr16_random        34         0
## 4022    gfp chr17_random        34         0
## 4023    gfp chrX_random         34         0
## 4024    gfp chrY_random         34         0
## 4025    gfp chrUn_random        34         0
```

```
xyplot(log(count) ~  nread | sample, as.data.frame(nread.islands),
       subset = (chromosome == "chr10" & nread <= 40),
       layout = c(1, 2), pch = 16, type = c("p", "g"))
```

![](data:image/png;base64...)

If reads were sampled randomly from the genome, then the null distribution
number of reads per island would have a geometric distribution; that is,

\[P(X = k) = p^{k-1} (1-p)\]

In other words, \(\log P(X = k)\) is linear in \(k\). Although our samples are not
random, the islands with just one or two reads may be representative of the null
distribution.

```
xyplot(log(count) ~ nread | sample, data = as.data.frame(nread.islands),
       subset = (chromosome == "chr10" & nread <= 40),
       layout = c(1, 2), pch = 16, type = c("p", "g"),
       panel = function(x, y, ...) {
           panel.lmline(x[1:2], y[1:2], col = "black")
           panel.xyplot(x, y, ...)
       })
```

![](data:image/png;base64...)

We can create a similar plot of the distribution of depths.

```
islandDepthSummary <- function(x)
{
  g <- resize(x, 200)
  s <- slice(coverage(g), lower = 1)
  tab <- table(viewMaxs(s) / 200)
  df <- DataFrame(tab)
  colnames(df) <- c("chromosome", "depth", "count")
  df$depth <- as.integer(df$depth)
  df
}

depth.islands <- DataFrameList(lapply(cstest, islandDepthSummary))
depth.islands <- stack(depth.islands, "sample")

plt <- xyplot(log(count) ~ depth | sample, as.data.frame(depth.islands),
       subset = (chromosome == "chr10" & depth <= 20),
       layout = c(1, 2), pch = 16, type = c("p", "g"),
       panel = function(x, y, ...){
           lambda <- 2 * exp(y[2]) / exp(y[1])
           null.est <- function(xx) {
               xx * log(lambda) - lambda - lgamma(xx + 1)
           }
           log.N.hat <- null.est(1) - y[1]
           panel.lines(1:10, -log.N.hat + null.est(1:10), col = "black")
           panel.xyplot(x, y, ...)
       })

## depth.islands <- summarizeReads(cstest, summary.fun = islandDepthSummary)
```

![](data:image/png;base64...)

The above plot is very useful for detecting peaks, discussed in the next
section. As a convenience, it can be created for the coverage over all
chromosomes for a single sample by calling the `islandDepthPlot`
function:

```
islandDepthPlot(cov.ctcf)
```

# 5 Peaks

To obtain a set of putative binding sites, i.e., peaks, we need to find
those regions that are significantly above the noise level. Using the
same Poisson-based approach for estimating the noise distribution as in
the plot above, the `peakCutoff` function returns a cutoff value for a
specific FDR:

```
peakCutoff(cov.ctcf, fdr = 0.0001)
```

```
## [1] 6.959837
```

Considering the above calculation of \(7\) at an FDR of \(0.0001\), and
looking at the above plot, we might choose \(8\) as a conservative peak
cutoff:

```
peaks.ctcf <- slice(cov.ctcf, lower = 8)
peaks.ctcf
```

```
## RleViewsList object of length 35:
## $chr1
## Views on a 197195432-length Rle subject
##
## views: NONE
##
## $chr2
## Views on a 181748087-length Rle subject
##
## views: NONE
##
## $chr3
## Views on a 159599783-length Rle subject
##
## views: NONE
##
## ...
## <32 more elements>
```

To summarize the peaks for exploratory analysis, we call the
`peakSummary` function:

```
peaks <- peakSummary(peaks.ctcf)
```

The result is a *GRanges* object with two columns: the view maxs and the view
sums. Beyond that, this object is often useful as a scaffold for adding
additional statistics.

It is meaningful to ask about the contribution of each strand to each
peak, as the sequenced region of pull-down fragments would be on
opposite sides of a binding site depending on which strand it matched.
We can compute strand-specific coverage, and look at the individual
coverages under the combined peaks as follows:

```
peak.depths <- viewMaxs(peaks.ctcf)

cov.pos <- coverage(ctcf.ext[strand(ctcf.ext) == "+"])
cov.neg <- coverage(ctcf.ext[strand(ctcf.ext) == "-"])

peaks.pos <- Views(cov.pos, ranges(peaks.ctcf))
peaks.neg <- Views(cov.neg, ranges(peaks.ctcf))

wpeaks <- tail(order(peak.depths$chr10), 4)
wpeaks
```

```
## [1]  971  989 1079  922
```

Below, we plot the four highest peaks on chromosome 10.

```
coverageplot(peaks.pos$chr10[wpeaks[1]], peaks.neg$chr10[wpeaks[1]])
```

![](data:image/png;base64...)

```
coverageplot(peaks.pos$chr10[wpeaks[2]], peaks.neg$chr10[wpeaks[2]])
```

![](data:image/png;base64...)

```
coverageplot(peaks.pos$chr10[wpeaks[3]], peaks.neg$chr10[wpeaks[3]])
```

![](data:image/png;base64...)

```
coverageplot(peaks.pos$chr10[wpeaks[4]], peaks.neg$chr10[wpeaks[4]])
```

![](data:image/png;base64...)

# 6 Differential peaks

One common question is: which peaks are different in two samples? One
simple strategy is the following: combine the two peak sets, and
compare the two samples by calculating summary statistics for
the combined peaks on top of each coverage vector.

```
## find peaks for GFP control
cov.gfp <- coverage(resize(cstest$gfp, 200))
peaks.gfp <- slice(cov.gfp, lower = 8)

peakSummary <- diffPeakSummary(peaks.gfp, peaks.ctcf)

plt <- xyplot(asinh(sums2) ~ asinh(sums1) | seqnames,
       data = as.data.frame(peakSummary),
       panel = function(x, y, ...) {
           panel.xyplot(x, y, ...)
           panel.abline(median(y - x), 1)
       },
       type = c("p", "g"), alpha = 0.5, aspect = "iso")
```

![](data:image/png;base64...)

We use a simple cutoff to flag peaks that are different.

```
mcols(peakSummary) <-
    within(mcols(peakSummary),
       {
           diffs <- asinh(sums2) - asinh(sums1)
           resids <- (diffs - median(diffs)) / mad(diffs)
           up <- resids > 2
           down <- resids < -2
           change <- ifelse(up, "up", ifelse(down, "down", "flat"))
       })
```

# 7 Placing peaks in genomic context

Locations of individual peaks may be of interest. Alternatively, a
global summary might look at classifying the peaks of interest in the
context of genomic features such as promoters, upstream regions, etc.
The *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)* package facilitates obtaining gene
annotations from different data sources. We could download the UCSC gene
predictions for the mouse genome and generate a *GRanges* object with
the transcript regions (from the first to last exon, contiguous) using
`makeTxDbFromUCSC`; here we use a library containing a recent snapshot.

```
library(TxDb.Mmusculus.UCSC.mm9.knownGene)
gregions <- transcripts(TxDb.Mmusculus.UCSC.mm9.knownGene)
gregions
```

```
## GRanges object with 55419 ranges and 2 metadata columns:
##               seqnames          ranges strand |     tx_id     tx_name
##                  <Rle>       <IRanges>  <Rle> | <integer> <character>
##       [1]         chr1 4797974-4832908      + |         1  uc007afg.1
##       [2]         chr1 4797974-4836816      + |         2  uc007afh.1
##       [3]         chr1 4847775-4887990      + |         3  uc007afi.2
##       [4]         chr1 4847775-4887990      + |         4  uc011wht.1
##       [5]         chr1 4848409-4887990      + |         5  uc011whu.1
##       ...          ...             ...    ... .       ...         ...
##   [55415] chrUn_random 2204169-2216886      - |     55415  uc009sjw.2
##   [55416] chrUn_random 2674945-2678407      - |     55416  uc009skb.2
##   [55417] chrUn_random 2889607-2891056      - |     55417  uc009ske.1
##   [55418] chrUn_random 3830796-3837247      - |     55418  uc009skg.1
##   [55419] chrUn_random 4677114-4677187      - |     55419  uc009skh.1
##   -------
##   seqinfo: 35 sequences (1 circular) from mm9 genome
```

We can now estimate the promoter for each transcript:

```
promoters <- flank(gregions, 1000, both = TRUE)
```

And count the peaks that fall into a promoter:

```
peakSummary$inPromoter <- peakSummary %over% promoters
xtabs(~ inPromoter + change, peakSummary)
```

```
##           change
## inPromoter down flat
##      FALSE   21 5158
##      TRUE     2  625
```

or somewhere upstream or in a gene:

```
peakSummary$inUpstream <- peakSummary %over% flank(gregions, 20000)
```

```
## Warning in valid.GenomicRanges.seqinfo(x, suggest.trim = TRUE): GRanges object contains 7 out-of-bound ranges located on sequences chr13,
##   chr16, chr5_random, and chr13_random. Note that ranges located on a sequence
##   whose length is unknown (NA) or on a circular sequence are not considered
##   out-of-bound (use seqlengths() and isCircular() to get the lengths and
##   circularity flags of the underlying sequences). You can use trim() to trim
##   these ranges. See ?`trim,GenomicRanges-method` for more information.
```

```
peakSummary$inGene <- peakSummary %over% gregions
```

```
sumtab <-
    as.data.frame(rbind(total = xtabs(~ change, peakSummary),
                        promoter = xtabs(~ change,
                          subset(peakSummary, inPromoter)),
                        upstream = xtabs(~ change,
                          subset(peakSummary, inUpstream)),
                        gene = xtabs(~ change, subset(peakSummary, inGene))))
## cbind(sumtab, ratio = round(sumtab[, "down"] /  sumtab[, "up"], 3))
```

# 8 Visualizing peaks in genomic context

While it is generally informative to calculate statistics incorporating
the genomic context, eventually one wants a picture. The traditional
genome browser view is an effective method of visually integrating
multiple annotations with experimental data along the genome.

Using the *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* package, we can upload our coverage
and peaks for both samples to the UCSC Genome Browser:

```
library(rtracklayer)
session <- browserSession()
genome(session) <- "mm9"
session$gfpCov <- cov.gfp
session$gfpPeaks <- peaks.gfp
session$ctcfCov <- cov.ctcf
session$ctcfPeaks <- peaks.ctcf
```

Once the tracks are uploaded, we can choose a region to view, such as the
tallest peak on chr10 in the CTCF data:

```
peak.ord <- order(unlist(peak.depths), decreasing=TRUE)
peak.sort <- as(peaks.ctcf, "GRanges")[peak.ord]
view <- browserView(session, peak.sort[1], full = c("gfpCov", "ctcfCov"))
```

We coerce to *GRanges* so that we can sort the ranges across chromosomes. By
passing the `full` parameter to `browserView` we instruct UCSC to display the
coverage tracks as a bar chart. Next, we might programmatically display a view
for the top 5 tallest peaks:

```
views <- browserView(session, head(peak.sort, 5), full = c("gfpCov", "ctcfCov"))
```

# 9 Version information

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
##  [1] TxDb.Mmusculus.UCSC.mm9.knownGene_3.2.2
##  [2] lattice_0.22-7
##  [3] GenomicFeatures_1.62.0
##  [4] AnnotationDbi_1.72.0
##  [5] chipseq_1.60.0
##  [6] ShortRead_1.68.0
##  [7] GenomicAlignments_1.46.0
##  [8] SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0
## [10] MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0
## [12] Rsamtools_2.26.0
## [13] Biostrings_2.78.0
## [14] XVector_0.50.0
## [15] BiocParallel_1.44.0
## [16] GenomicRanges_1.62.0
## [17] Seqinfo_1.0.0
## [18] IRanges_2.44.0
## [19] S4Vectors_0.48.0
## [20] BiocGenerics_0.56.0
## [21] generics_0.1.4
## [22] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0     rjson_0.2.23        xfun_0.53
##  [4] bslib_0.9.0         hwriter_1.3.2.1     latticeExtra_0.6-31
##  [7] vctrs_0.6.5         tools_4.5.1         bitops_1.0-9
## [10] curl_7.0.0          parallel_4.5.1      RSQLite_2.4.3
## [13] blob_1.2.4          pkgconfig_2.0.3     Matrix_1.7-4
## [16] RColorBrewer_1.1-3  cigarillo_1.0.0     lifecycle_1.0.4
## [19] compiler_4.5.1      deldir_2.0-4        tinytex_0.57
## [22] codetools_0.2-20    htmltools_0.5.8.1   sass_0.4.10
## [25] RCurl_1.98-1.17     yaml_2.3.10         crayon_1.5.3
## [28] jquerylib_0.1.4     DelayedArray_0.36.0 cachem_1.1.0
## [31] magick_2.9.0        abind_1.4-8         digest_0.6.37
## [34] restfulr_0.0.16     bookdown_0.45       fastmap_1.2.0
## [37] grid_4.5.1          cli_3.6.5           SparseArray_1.10.0
## [40] magrittr_2.0.4      S4Arrays_1.10.0     XML_3.99-0.19
## [43] bit64_4.6.0-1       rmarkdown_2.30      pwalign_1.6.0
## [46] httr_1.4.7          jpeg_0.1-11         bit_4.6.0
## [49] interp_1.1-6        png_0.1-8           memoise_2.0.1
## [52] evaluate_1.0.5      knitr_1.50          BiocIO_1.20.0
## [55] rtracklayer_1.70.0  rlang_1.1.6         Rcpp_1.1.0
## [58] DBI_1.2.3           BiocManager_1.30.26 jsonlite_2.0.0
## [61] R6_2.6.1
```
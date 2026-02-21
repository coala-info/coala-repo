# BAM Quality Control Measures

#### 2025-10-30

# Contents

* [1 Loading and saving RaMWAS objects](#loading-and-saving-ramwas-objects)
  + [1.1 QC text summary](#qc-text-summary)
* [2 Quality control measures](#quality-control-measures)
  + [2.1 The number of BAM files](#NBAMs)
  + [2.2 Total number of reads in the BAM file(s)](#TotalReads)
  + [2.3 Number of reads aligned to the reference genome](#ReadsAligned)
  + [2.4 Number of reads that passed minimum score filter](#ReadsAfterFilter)
  + [2.5 Number of reads after removal of duplicate reads](#ReadsRemovedAsDuplicate)
  + [2.6 Number of recorded reads aligned to each strand](#ForwardStrandPct)
  + [2.7 Distribution of the alignment scores](#AvgAlignmentScore)
  + [2.8 Distribution of the length of the aligned part of the reads](#AvgAlignedLength)
  + [2.9 Distribution of edit distance](#AvgEditDistance)
  + [2.10 Number of reads away from CpGs](#NonCpGreadsPct)
  + [2.11 Average CpG score for CpGs and non-CpGs](#AvgNonCpGcoverage)
  + [2.12 Average CpG score vs. CpG density](#PeakSQRT)
  + [2.13 Coverage around isolated CpGs](#coverage-around-isolated-cpgs)
  + [2.14 Fraction of reads from chrX and chrY](#ChrXreadsPct)

# 1 Loading and saving RaMWAS objects

Steps 1 and 2 of RaMWAS
scan BAM files, calculate and collect
quality control (QC) metrics
The QC information is stored in .rds files in “rqc” directory.
They are also summarizes in text files in the “qc” directory
and illustrated in mulpiple plots.

## 1.1 QC text summary

The text summary is saved in two versions:

* `Summary_QC.txt` – formatted for viewing in Excel.
* `Summary_QC_R.txt` – formatted for easy import in R.

| Excel friendly column name | R friendly column name | brief description and link to section |
| --- | --- | --- |
| Sample | Sample | Sample / BAM name |
| # BAMs | NBAMs | [Number of BAMs in the sample](#NBAMs) |
| Total reads | TotalReads | [Total number of reads](#TotalReads) |
| Reads aligned | ReadsAligned | [The number of aligned reads](#ReadsAligned) |
| RA % of total | ReadsAlignedPct | Percent of reads aligned |
| Reads after filter | ReadsAfterFilter | [Number of reads that passed minimum score filter](#ReadsAfterFilter) |
| RAF % of aligned | ReadsAfterFilterPct | Percent of reads passing the filter out of all aligned reads |
| Reads removed as duplicate | ReadsRemovedAsDuplicate | [Reads removed as duplicate](#ReadsRemovedAsDuplicate) |
| RRAD % of aligned | ReadsRemovedAsDuplicatePct | Percent of reads removed as duplicate out of all aligned reads |
| Reads used for coverage | ReadsUsedForCoverage | Number of aligned reads used for coverage (left after filtering and removal of duplicate reads) |
| RUFC % of aligned | ReadsUsedForCoveragePct | Percent of reads used for coverage out of all aligned reads |
| Forward strand (%) | ForwardStrandPct | [Percent of reads used for coverage aligned to the forward strand](#ForwardStrandPct) |
| Avg alignment score | AvgAlignmentScore | [Average alignment score](#AvgAlignmentScore) |
| Avg aligned length | AvgAlignedLength | [Average length of the aligned part of the read](#AvgAlignedLength) |
| Avg edit distance | AvgEditDistance | [Average number of mismatches between the aligned part of the read and the reference genome](#AvgEditDistance) |
| Non-CpG reads (%) | NonCpGreadsPct | [Percent of reads aligned away from CpGs](#NonCpGreadsPct) |
| Avg non-CpG coverage | AvgNonCpGcoverage | [Average CpG score for non-CpG locations](#AvgNonCpGcoverage) |
| Avg CpG coverage | AvgCpGcoverage | [Average CpG score for CpGs](#AvgNonCpGcoverage) |
| Non-Cpg/CpG coverage ratio | NonCpg2CpGcoverageRatio | [Ratio of average non-CpG and CpG scores](#AvgNonCpGcoverage) |
| ChrX reads (%) | ChrXreadsPct | [Fraction of reads aligned to chromosome X](#ChrXreadsPct) |
| ChrY reads (%) | ChrYreadsPct | [Fraction of reads aligned to chromosome Y](#ChrXreadsPct) |
| Peak SQRT | PeakSQRT | [Square root of the CpG density with highest average CpG score](#PeakSQRT) |

# 2 Quality control measures

All QC measures are designed to be additive, in the sense that any QC
measure calculated for a combination of two BAM files is equal to the
sum of the respective measure calculated for those BAMs separately.

Many QC measures can be visualized by calling the `plot` function.
For most QC measures, a single number summary is
available via the `qcmean` function.

A sample QC file, which contains accumulated
QC measures from 42 BAM files,
can be loaded with the following code.

```
library(ramwas)
filename = system.file("extdata", "bigQC.rds", package = "ramwas")
qc = readRDS(filename)$qc
```

Next we describe the QC metrics calculated by RaMWAS.

## 2.1 The number of BAM files

The `nbams` QC metric counts the number of BAM files.
This cumulative metric is calculated for total of 42 BAMs.

```
cat("Number of BAMs:", qc$nbams)
```

```
## Number of BAMs: 42
```

## 2.2 Total number of reads in the BAM file(s)

The `reads.total` QC metric counts the number of reads
scanned in the BAM file(s). This includes reads later excluded
due to low alignment score or as duplicates.
The 42 BAMs contain 2.46 billion reads.

```
cat("Reads total:", qc$reads.total)
```

```
## Reads total: 2464441416
```

## 2.3 Number of reads aligned to the reference genome

The `reads.aligned` QC metric indicates the number of reads
that were successfully aligned to the reference genome.
The number of aligned reads is only 2% smaller, 2.42 billion.

```
{
cat("Reads aligned:", qc$reads.aligned, "\n")
cat("This is ", qc$reads.aligned / qc$reads.total * 100,
    "% of all reads", sep="")
}
```

```
## Reads aligned: 2422356052
## This is 98.2923% of all reads
```

## 2.4 Number of reads that passed minimum score filter

At step 1 of RaMWAS, reads are filtered by the `scoretag` parameter,
which is usually either the “MAPQ” field or “AS” tag in the BAM file.
Reads with scores below `minscore` are excluded.

The `reads.recorded` QC metric counts the number of reads
that passed the score threshold.
Almost of 2.2 billion reads passed the score threshold.

```
{
cat("Reads recorded:",qc$reads.recorded,"\n")
cat("This is ", qc$reads.recorded / qc$reads.aligned * 100,
    "% of aligned reads", sep="")
}
```

```
## Reads recorded: 2197642600
## This is 90.72335% of aligned reads
```

## 2.5 Number of reads after removal of duplicate reads

Reads that start at the same nucleotide positions
and aligned to the same strand are called duplicate reads.
When sequencing a whole genome, duplicate-reads often arise from
template preparation or amplification artifacts.
In the context of sequencing an enriched genomic fraction,
duplicate-reads are increasingly likely to occur because
reads align to a much smaller fraction of the genome.
RaMWAS allows the user to define a threshold for the number
of reads starting at the same position and
limits the read count to this threshold
(implicitly assuming that an excess of
reads are tagging the same clonal fragment).

The threshold is set by `maxrepeats` parameter with the default value 3.

When there are mulptiple reads with the same start
position, we suspect them to be falsely duplicated.

The `reads.recorded.no.repeats` QC metric records the
total number of reads after removal of duplicates.

In our example, 10% of reads are removed as duplicates.

```
{
cat("Reads without duplicates:", qc$reads.recorded.no.repeats, "\n")
cat("This is ", qc$reads.recorded.no.repeats / qc$reads.recorded * 100,
    "% of aligned reads", "\n", sep="")
}
```

```
## Reads without duplicates: 1987137468
## This is 90.42132% of aligned reads
```

## 2.6 Number of recorded reads aligned to each strand

The `frwrev` QC metric records two values – the number of reads
aligned to the forward and reverse strands respectively,
after filtering reads by alignment score.

The `frwrev.no.repeats` is similar to `frwrev`,
but it excludes duplicate reads.

For these measures, the `qcmean` function returns
the fraction of reads on the forward strand.
Normally, the number of reads on the forward
and reverse strands are very close,
so `qcmean` should give a number close to `0.5`.

```
{
    cat("Excluding duplicate reads", "\n")
    cat("Reads on forward strand:", qc$frwrev.no.repeats[1], "\n")
    cat("Reads on reverse strand:", qc$frwrev.no.repeats[2], "\n")
    cat("Fraction of reads on forward strand:",
        qcmean(qc$frwrev.no.repeats), "\n")
}
```

```
## Excluding duplicate reads
## Reads on forward strand: 993398396
## Reads on reverse strand: 993739072
## Fraction of reads on forward strand: 0.4999143
```

Clearly before removal of duplicate reads the
fraction of reads on the forward strand was further away from 0.5.

```
{
    cat("Not excluding duplicate reads", "\n")
    cat("Reads on forward strand:", qc$frwrev[1], "\n")
    cat("Reads on reverse strand:", qc$frwrev[2], "\n")
    cat("Fraction of reads on forward strand (before QC):",
        qcmean(qc$frwrev), "\n")
}
```

```
## Not excluding duplicate reads
## Reads on forward strand: 1098313225
## Reads on reverse strand: 1099329375
## Fraction of reads on forward strand (before QC): 0.4997688
```

## 2.7 Distribution of the alignment scores

The QC metrics `bf.hist.score1` and `hist.score1` record the distribution of
the alignment scores before and after the filter.
The score is defined by the `scoretag` parameter.
While `hist.score1` contain the distribution for reads that passed the filter,
`bf.hist.score1` has the distribution for all reads.
The `qcmean` function for these QC measures returns
the average score for the respective group.
The first element of the vector `qc$hist.score1` contains the number of
reads with score of 0, the second with score of 1, and so on.
Negative scores (if any) are ignored.

```
{
cat("Average alignment score, after filter:", qcmean(qc$hist.score1),    "\n")
cat("Average alignment score, no filter:   ", qcmean(qc$bf.hist.score1), "\n")
par(mfrow=c(1,2))
plot(qc$hist.score1)
plot(qc$bf.hist.score1)
}
```

```
## Average alignment score, after filter: 144.1565
## Average alignment score, no filter:    137.8565
```

![](data:image/png;base64...)

## 2.8 Distribution of the length of the aligned part of the reads

The `hist.length.matched` QC metrix records the
distribution of the length of the aligned part of the reads.
The length of the aligned part of a read is calculated from
the CIGAR string in the BAM file using the `cigarWidthAlongQuerySpace` function.
The vector `hist.length.matched` has the distribution
for reads that passed the filter,
`bf.hist.length.matched` – for all reads.
The `qcmean` function for these QC measures returns the
average length
The first element of the vector contains the number of
reads with 1 aligned basepair, the second with 2, and so on.

```
{
cat("Average aligned length, after filter:",
    qcmean(qc$hist.length.matched),    "\n")
cat("Average aligned length, no filter:   ",
    qcmean(qc$bf.hist.length.matched), "\n")
par(mfrow = c(1,2))
plot(qc$hist.length.matched)
plot(qc$bf.hist.length.matched)
}
```

```
## Average aligned length, after filter: 74.22412
## Average aligned length, no filter:    72.60318
```

![](data:image/png;base64...)

## 2.9 Distribution of edit distance

The `hist.edit.dist1` QC metricrecords the
distribution of the number of mismatches between
the aligned part of the read and the reference genome.
The mismatches are caused by base call errors and genetic variation.
The metric is calculated from the NM tag in BAM files.

The `bf.hist.edit.dist1` QC metric records
the distribution before read filtering, while `hist.edit.dist1` after.
The first element of the vector contains the number of reads
with 0 edit distance (perfect match), the second with edit distance 1,
and so on.

The `qcmean` function for this QC metric returns the average edit distance.

```
{
cat("Average edit distance, after filter:",
    qcmean(qc$hist.edit.dist1),    "\n")
cat("Average edit distance, no filter:   ",
    qcmean(qc$bf.hist.edit.dist1), "\n")
par(mfrow = c(1,2))
plot(qc$hist.edit.dist1)
plot(qc$bf.hist.edit.dist1)
}
```

```
## Average edit distance, after filter: 0.7361304
## Average edit distance, no filter:    1.220491
```

![](data:image/png;base64...)

## 2.10 Number of reads away from CpGs

MBD-seq detects CpG methylation,
such that reads aligning to loci that are
at least `maxfragmentsize` away from any CpGs represent “noise”.
These reads occur due to alignment errors or
imperfect enrichment leading to sequencing of non-methylated fragments).

The `cnt.nonCpG.reads` QC metric contains the number of
non-CpG reads in it’s first element and
the total number of reads in the second.

The `qcmean` function for this QC metric returns the
percent of non-CpG reads out of all reads.

For our data there is less than 1% of non-CpG reads,
which is consistent with low level of noise.

```
{
cat("Non-CpG reads:", qc$cnt.nonCpG.reads[1], "\n")
cat("This is ", qcmean(qc$cnt.nonCpG.reads)*100, "% of recorded reads", sep="")
}
```

```
## Non-CpG reads: 10764340
## This is 0.5669618% of recorded reads
```

## 2.11 Average CpG score for CpGs and non-CpGs

The `avg.cpg.coverage` and `avg.noncpg.coverage` QC metrics record
the average CpG score (fragment coverage) for
all CpGs and for all non-CpGs (locations away from CpGs).

For successfull enrichment, the average CpG score
should be much larger that average non-CpG score
The ratio of these metrics,
gives us a lower bound on the enrichment level (higher is better).
The opposite ratio measures the noise level (lower is better).

```
{
cat("Summed across", qc$nbams, "bams", "\n")
cat("Average     CpG coverage:", qc$avg.cpg.coverage, "\n")
cat("Average non-CpG coverage:", qc$avg.noncpg.coverage, "\n")
cat("Enrichment ratio:", qc$avg.cpg.coverage / qc$avg.noncpg.coverage, "\n")
cat("Noise level:", qc$avg.noncpg.coverage / qc$avg.cpg.coverage)
}
```

```
## Summed across 42 bams
## Average     CpG coverage: 255.8143
## Average non-CpG coverage: 1.766378
## Enrichment ratio: 144.8242
## Noise level: 0.006904925
```

## 2.12 Average CpG score vs. CpG density

Enrichment profiles are not only affected by the
total amount of methylation of the DNA fragments,
which is a function of the number of CpGs and how many of them are methylated,
but also by variability in the laboratory protocol.
To capture this variability,
the `avg.coverage.by.density` QC metric
records the dependence of average CpG score
as a function of CpG density.
The `qcmean` function returns the square root of the CpG density
where maximum average CpG score is achieved.

This ‘sqrt peak’ sensitivity measure can be used as a covariate in
downstream analyses to regress out
variability in enrichment profiles across samples
caused by lab-technical factors.

```
{
cat("Highest coverage is observed at CpG density of",
    qcmean(qc$avg.coverage.by.density)^2)
plot(qc$avg.coverage.by.density)
}
```

```
## Highest coverage is observed at CpG density of 8.4681
```

![](data:image/png;base64...)

## 2.13 Coverage around isolated CpGs

A CpG is called isolated if
there are no other CpGs within
a sufficient distance from it.
The distance is usually the longest possible fragment size.

The distribution of reads around isolated CpGs
also contains information about the enrichment profile.
Because the total amount of methylation in fragments
containing isolated CpGs is small,
this distribution reflects the sensitivity of the enrichment.
That is, a sensitive assay would be characterized by a pattern where
most reads start close to the isolated CpG.
The read counts should decrease further away from the CpG until
they eventually stabilize to a “noise” level
at distances larger than the maximum fragment size.
This pattern of read counts around isolated CpGs
also form the basis of the fragment size estimation needed
to calculate CpG score for single end sequencing data.

The `hist.isolated.dist1` QC metric records the distribution of
distances from read start sites to isolated CpGs.
In our example, as we expected,
there are more reads starting closer to the isolated CpGs.

```
plot(qc$hist.isolated.dist1)
```

![](data:image/png;base64...)

## 2.14 Fraction of reads from chrX and chrY

The fractions of reads from chromosome X and chromosome Y
can be used to test whether the investigated biosamples
have the same sex as recorded in the phenotype data.
Mismatches often indicate swapped biosamples or phenotypes information.
They can also indicate contamination across biosamples.

The `chrX.count` QC metric records the number of chromosome X reads
in its first element and the total number of reads in the second.
The `qcmean` function returns the percent of chromosome X reads
out of the total.

The `chrY.count` QC metric is defined analogously for chromosome Y.

```
{
cat("ChrX reads: ", qc$chrX.count[1], ", which is ",
    qcmean(qc$chrX.count)*100, "% of total", sep="", "\n")
cat("ChrY reads: ", qc$chrY.count[1], ", which is ",
    qcmean(qc$chrY.count)*100, "% of total", sep="", "\n")
}
```

```
## ChrX reads: 58392794, which is 2.939042% of total
## ChrY reads: 15592584, which is 0.7848102% of total
```
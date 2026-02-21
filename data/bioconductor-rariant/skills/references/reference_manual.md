Package ‘Rariant’

April 12, 2018

Type Package

Title Identiﬁcation and Assessment of Single Nucleotide Variants
through Shifts in Non-Consensus Base Call Frequencies

Version 1.14.0

Author Julian Gehring, Simon Anders, Bernd Klaus
Maintainer Julian Gehring <jg-bioc@gmx.com>

Imports methods, S4Vectors, IRanges, GenomeInfoDb, ggbio, ggplot2,
exomeCopy, SomaticSignatures, Rsamtools, shiny, VGAM, dplyr,
reshape2

Depends R (>= 3.0.2), GenomicRanges, VariantAnnotation

Suggests h5vcData, testthat, knitr, optparse,
BSgenome.Hsapiens.UCSC.hg19

Description

The 'Rariant' package identiﬁes single nucleotide variants from sequencing data based on the dif-
ference of binomially distributed mismatch rates between matched samples.

VignetteBuilder knitr

Encoding UTF-8

ByteCompile TRUE

License GPL-3

URL https://github.com/juliangehring/Rariant

BugReports https://support.bioconductor.org

LazyLoad yes

biocViews Sequencing, StatisticalMethod, GenomicVariation,
SomaticMutation, VariantDetection, Visualization

NeedsCompilation no

R topics documented:

.

Rariant-package .
.
ciAdjust
.
.
.
ciAssessment
.
ciUtils .
.
.
colorscales .

.
.
.
.

.
.

.

.
.
.
.
.

.
.
.
.
.

.
.
.
.
.

.
.
.
.
.

.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
3
3
4
5

1

2

Rariant-package

.

.

convertUtils .
.
evidenceHeatmap .
.
mismatchUtils .
.
.
.
multiCalls .
.
.
.
.
plotCIs .
.
.
.
.
.
propCIs .
.
.
.
.
propTests
.
.
rariant
.
.
.
.
.
rariantInspect
.
.
splitSample .
.
.
.
tallyBam .
.
tallyPlot
.
.
.
.
yesNoMaybe .

.
.
.
.
.
.
.
.
.
.
.

.
.

.

.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.

6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
.

Index

20

Rariant-package

Rariant package

Description

The ’Rariant’ package offers the framework to identify and characterize shifts of variant frequencies
in a comparative setting from high-throughput short-read sequencing data. It estimates shifts in the
non-consensus variant frequency and provides conﬁdence estimates that allow for a quantitative
assessment of presence or absence of variants. The vignette accompanying the package gives a
detailed explanation and outlines a typical workﬂow on real data.

Author(s)

Julian Gehring, Simon Anders, Bernd Klaus (EMBL Heidelberg)

Maintainer: Julian Gehring <julian.gehring@embl.de>

See Also

rariant

vignette(package = "Rariant")

Examples

help("rariant")

vignette(package = "Rariant")

ciAdjust

3

ciAdjust

CI Adjust

Description

Multiple testing adjustment of conﬁdence levels, as proposed by Benjamini and Yekutieli.

Usage

ciAdjustLevel(eta0, conf_level)

Arguments

eta0

Estimated fraction of tests that are consistent with the null hypothesis.

conf_level

Unadjusted conﬁdence level

Value

The adjusted conﬁdence level.

References

Benjamini, Yoav, and Daniel Yekutieli. False Discovery Rate–adjusted Multiple Conﬁdence Inter-
vals for Selected Parameters. Journal of the American Statistical Association 100, no. 469 (2005):
71–81.

Examples

conf_level = 0.95
eta0 = seq(0, 1, by = 0.02)

conf_level_adj = ciAdjustLevel(eta0, conf_level)

plot(eta0, conf_level_adj, pch = 20, ylim = c(conf_level, 1))

ciAssessment

Assessment of CI methods

Description

Functions to compute the coverage probability of a conﬁdence interval method.

Usage

coverageProbability(pars, fun = acCi, n_sample = 1e4, min_k, ...)

4

Arguments

pars

n_sample

fun

min_k

...

Value

ciUtils

Data frame with parameter combinations [data.frame]

Number of assessments per parameter combination [integer(1)].

CI function

Minimum ’k2’ value to use.

Additional arguments that are passed on to ’fun’.

The ’data.frame’ object ’pars’ with additional columns ’cp’ for the coverage probability and ’aw’
average conﬁdence interval width.

References

Fagerland, Morten W., Stian Lydersen, and Petter Laake. Recommended Conﬁdence Intervals for
Two Independent Binomial Proportions. Statistical Methods in Medical Research (2011).

Examples

## Define parameter space
pars = expand.grid(k1 = 1:5, k2 = 5, n1 = 30, n2 = 30)
conf_level = 0.95

## Compute coverage probabilities
cp = coverageProbability(pars, fun = acCi, n_sample = 1e2, conf_level = conf_level)
print(cp)

ciUtils

CI Utils

Description

Utility functions to ﬁnd conﬁdence intervals that (a) overlap a certain value (’ciOutside’, ’ciCovers’)
and (b) different conﬁdence intervals overlap (’ciOverlap’).

Usage

ciOutside(x, delta = 0)

ciCovers(x, delta = 0)

ciOverlap(x, y)

ciWidth(x)

Arguments

x, y

delta

CIs, as obtained from e.g. the ’acCi’ function.

Variant frequency value to check against [default: 0].

colorscales

Value

5

A logical vector, where each elements corresponds to the respective row of ’x’ (and ’y’).

For ’ciWidth’: A numeric vector with the widths of the conﬁdence intervals.

Examples

## Generate sample data
counts = data.frame(x1 = 1:5, n1 = 30, x2 = 0:4, n2 = 30)

## Agresti-Caffo
ci_ac = with(counts, acCi(x1, n1, x2, n2))
ci_ac2 = with(counts, acCi(x1, n1, x2, n2, 0.99))

## cover 0
idx_zero = ciCovers(ci_ac)

## cover 1
idx_one = ciCovers(ci_ac, delta = 1)

## overlap
idx_same = ciOverlap(ci_ac, ci_ac2)

## width
width = ciWidth(ci_ac)

colorscales

Rariant color scales

Description

Color and ﬁll scales used for plotting in Rariant.

Usage

eventFillScale()
verdictColorScale()
rateFillScale()
baseFillScale()

Value

A ggbio color or ﬁll scale.

See Also

tallyPlot, evidenceHeatmap, plotConﬁdenceIntervals

6

evidenceHeatmap

convertUtils

Position converters

Description

Utility functions to convert between ’GRanges’ and ’character’ objects.

Usage

gr2pos(x, range = TRUE)

pos2gr(x)

Arguments

x

range

Value

GRanges or character object.

Should the range instead of the start position be returned?

A GRanges object or character object, with the positions.

Examples

library(GenomicRanges)

gr = GRanges(1:2, IRanges(1:2, width = 1))

pos = gr2pos(gr)
gr2 = pos2gr(pos)

identical(gr, gr2)

evidenceHeatmap

Variant Evidence Heatmap

Description

Heatmap with the evidence of variant evidences.

Usage

evidenceHeatmap(x, fill = "d", color = "outside",

size = 1.5,
xvar = "sample", yvar = "loc", ...)

7

GRanges with variants, as returned by ’rariant’.
Column determining the ﬁll.
Column determining the border color.
What is this needed for?
Which column to deﬁne the tiles.
Additional arguments, passed to ’geom_tile’.

mismatchUtils

Arguments

x
fill
color
size
xvar, yvar
...

Value

A ggplot2 object.

See Also

yesNoMaybe

mismatchUtils

Tally processing low-level functions

Description

Functions for processing position-speciﬁc base count tables (tallies) and extracting mismatches
counts.

Usage

## low-level functions
selectStrand(x, strand = c("both", "plus", "minus"), idx = 1:ncol(x))

seqDepth(x)

callConsensus(counts, verbose = FALSE)

mismatchCount(counts, consensus, depth = rowSums(counts))

Arguments

x
strand
idx
counts
verbose
consensus
depth

Input object
Which strand to return?
Index of bases to consider (leave as is)
Count matrix
Show warnings
Consensus sequence
Sequencing depth for counts.

See Also

comparativeMismatch

8

plotCIs

multiCalls

Multi call processing

Description

Utilities for processing matched calls from multipe samples.

Usage

findCalls(x, ..., minCount = 1)
filterCalls(x, ..., minCount = 1)

mergeCalls(x)

updateCalls(x, ...)

Arguments

x

...

minCount

GenomicRangesList with calls from multiple samples.

Additional arguments.

For ﬁnding and ﬁltering, for how many samples must the condition ’...’ hold
true for a site to be returned?

plotCIs

Plotting Functions

Description

The ’plotConﬁdenceIntervals’ is a high-level plotting function for visualizing conﬁdence intervals.
The ’plotAbundanceShift’ function visualizes the shift in mismatch rates between two samples.

Usage

plotConfidenceIntervals(x, ylim = c(-1.05, 1.05), color = NULL, ...)

plotAbundanceShift(x, ylim = c(-0.05, 1.05), rates = TRUE, ...)

Arguments

x

ylim

color

rates

...

’GRanges’ with mcols of a CI method, or ’data.frame’ as returned by one of the
CI methods, with the optional column ’start’.

Limits of the y-axis. Using this instead of using the ’ylim’ prevents ugly warn-
ings of ’ggplot2’.

Variable that determines the coloring of the conﬁdence axis (character).

Should the non-consensus rates of both samples be visualized as colored end
points of the line range? (logical, default: TRUE).

Additional plotting arguments that are passed on to ggplot2::geom_pointrange.

9

propCIs

Value

For a ’GRanges’ input: A ’ggbio’ object

For a ’data.frame’ input: A ’ggplot’ object

Examples

## Generate sample data
counts = data.frame(x1 = 1:5, n1 = 30, x2 = 0:4, n2 = 30)

## Agresti-Caffo
ci_ac = with(counts, acCi(x1, n1, x2, n2))

library(GenomicRanges)
gr = GRanges("1", IRanges(start = 1:nrow(counts), width = 1))
mcols(gr) = ci_ac

## GRanges
plotConfidenceIntervals(gr)

## data.frame
plotConfidenceIntervals(ci_ac)

## abundance shift
plotAbundanceShift(gr)

plotAbundanceShift(ci_ac)

propCIs

Conﬁdence Interval Functions

Description

Vectorized implementation of conﬁdence intervals

Usage

acCi(x1, n1, x2, n2, conf_level = 0.95, clip = TRUE, split = FALSE)
nhsCi(x1, n1, x2, n2, conf_level = 0.95)

Arguments

x1

n1

x2

n2

Mismatch counts in the test sample.

Sequencing depth (total counts) in the test sample.

Mismatch counts in the control sample.

Sequencing depth (total counts) in the control sample.

conf_level

Conﬁdence level $beta$ (default: 0.95).

clip

split

Should the CIs be clipped to the interval [-1,1] if they exceed this?

Should the sample split method be applied? See ’splitSampleBinom’ for details.

10

Details

propCIs

These functions implement a vectorized version of the two-sided Agresti-Caffo, and Newcombe-
Hybrid-Score conﬁdence interval for the difference of two binomial proportions.

Value

A data frame with columns

• dEstimate for the difference of rates ’p1’ and ’p2’.

• p1, p2Estimates for the mismatches rates for each sample.

• lower, upperLower and upper bound of the conﬁdence interval.

• wWidth of the conﬁdence interval.

References

Agresti, Alan, and Brian Caffo. Simple and Effective Conﬁdence Intervals for Proportions and
Differences of Proportions Result from Adding Two Successes and Two Failures. The American
Statistician 54, no. 4 (2000): 280–288

Newcombe, Robert G. Interval Estimation for the Difference between Independent Proportions:
Comparison of Eleven Methods. Statistics in Medicine 17, no. 8 (1998): 873–890.

Fagerland, Morten W., Stian Lydersen, and Petter Laake. Recommended Conﬁdence Intervals for
Two Independent Binomial Proportions. Statistical Methods in Medical Research (2011).

See Also

nhsCi

splitSampleBinom

binMto::Add4 binMto::NHS

Examples

## Generate sample data
counts = data.frame(x1 = 1:5, n1 = 30, x2 = 0:4, n2 = 30)

## Agresti-Caffo
ci_ac = with(counts, acCi(x1, n1, x2, n2))

## Newcombe-Hybrid Score
ci_nhs = with(counts, nhsCi(x1, n1, x2, n2))

print(ci_ac)

propTests

11

propTests

Testing Functions

Description

Vectorized implementation of testing functions

Usage

scoreTest(x1, n1, x2, n2)

nmTest(x1, n1, x2, n2, delta = 0)

feTest(x1, n1, x2, n2, ...)

Arguments

x1

n1

x2

n2

delta

...

Details

Mismatch counts in the test sample.

Sequencing depth (total counts) in the test sample.

Mismatch counts in the control sample.

Sequencing depth (total counts) in the control sample.

Difference to test against (default: 0).

Additional arguments.

These functions implement a vectorized version of the two-sided (a) Score test and (b) Miettinen-
Nurminen test for the difference between to Binomial proportions.

Usage of the score test is discouraged in the settings considered here, since it is ill-deﬁned for
positions with no mismatches.

Value

A data frame with columns

• dhatEstimate for the difference of rates ’p1’ and ’p2’.

• p1, p2Estimates for the mismatches rates for each sample.

• tvalT-value

• pvalP-value

References

Miettinen, Olli, and Markku Nurminen. Comparative Analysis of Two Rates. Statistics in Medicine
4, no. 2 (1985): 213–226. doi:10.1002/sim.4780040211.

See Also

VariantTools package

rariant

12

Examples

## Generate sample data
counts = data.frame(x1 = 1:5, n1 = 30, x2 = 0:4, n2 = 30)

## Score test
stat_st = with(counts, scoreTest(x1, n1, x2, n2))

## NM test
stat_nm = with(counts, nmTest(x1, n1, x2, n2))

## Fisher test
stat_fet = with(counts, feTest(x1, n1, x2, n2))

print(stat_st)

print(stat_nm)

print(stat_fet)

rariant

Rariant calling functions

Description

The ’rariant’ function identiﬁes variant shifts between a test and control sample. These highlevel
functions offers a convenient interface for large-scale identiﬁcation as well as for reexamination of
existing variant calls.

Usage

## S4 method for signature 'BamFile,BamFile,GRanges'

rariant(test, control, region,

beta = 0.95, alpha = 1 - beta, select = TRUE, consensus,
resultFile, strand = c("both", "plus", "minus"), nCycles = 10,
minQual = 20, block = 1e4, value = TRUE, criteria = c("both",
"any", "fet", "ci"))

## S4 method for signature 'character,character,GRanges'

rariant(test, control, region,

beta = 0.95, alpha = 1 - beta, select = TRUE, consensus,
resultFile, strand = c("both", "plus", "minus"), nCycles = 10,
minQual = 20, block = 1e4, value = TRUE, criteria = c("both",
"any", "fet", "ci"))

## S4 method for signature 'array,array,GRanges'

rariant(test, control, region, beta =
0.95, alpha = 1 - beta, select = TRUE, consensus, strand = c("both",
"plus", "minus"), criteria = c("both", "any", "fet", "ci"))

rariantStandalone()

rariant

13

readRariant(file, ...)

writeRariant(x, file, ...)

Arguments

test, control

region

beta

alpha

select

consensus

resultFile

strand

nCycles

minQual

block

value

criteria

file

x

...

Details

Test and control BAM ﬁles. Other input sources will be supported in the future.

Region(s) of interest to analyze in the calling [GRanges with one or more en-
tries]. If missing, the entire genomic space, as deﬁned by the BAM headers of
the input ﬁles, will be covered.

Conﬁdence level [numeric in the range [0,1], default: 0.95].

Signiﬁcance threshold for BH-adjusted p-values of the Fisher’s exact test.

Should only likely variant positions be selected and returned, or the results for
all sites be returned.

How to determine the consensus sequence. By default, the consensus is given
by the most abundant allele in the control sample. Alternatively, an object with
a reference sequence (’BSgenome’, ’FaFile’) can be passed to deﬁne the con-
sensus sequence.

If not missing, write the results to a tab-delimited ﬁle.

Which strand should be extracted? By default, the counts of both strands are
summed up.

Number of sequencing cycles to remove from the beginning and end of each
read when creating the base count table. This avoids low quality read positions
[default: 10 is reasonable for current Illumina sequencing].

Minimum base call quality for reads to be considered for the nucleotide count
table [default: 20 is reasonable for current Illumina sequencing]. Reads with a
lower quality are dropped.

Number of the genomic sites to analyze in one chunk. The default is a good
compromise between memory usage and speed, and normally does not require
changing.

Should the results be returned by the function. For calls within R, this is gener-
ally set to TRUE and does not need to be changed.

The criteria to determine signiﬁcant sites. Criteria are: Fisher’s exact test, con-
ﬁdence intervals, any or both [default] of them.

Path to output ﬁle from a ’rariant’ call.

Output of ’rariant’ call.

Additional arguments passed to ’read.table’ or ’write.table’.

The ’rariant’ function is the workhorse for the comparative variant calling and assessment. It starts
with the aligned reads for the test (e.g. tumor) and the control (e.g. normal) sample in the BAM
format; later versions will support additional inputs.

The ’select’ parameter determines whether only signiﬁcant variant sites or all sites are returned.
While the ﬁrst is suitable for detecting variants, the second becomes relevant assessing for example
the abundance of variants at particular sites of interest - an example would be to determine the
absence of a speciﬁc variant.

14

rariant

For analyses over large genomic regions and for use with infrastructure outside of R, initiating the
calling from the command line may be a desirable alternative. The ’rariantStandalone’ functions
returns the full path to a script that can be directly called from the command line. For further details,
see the help of the script by calling it with the ’-h’ option, for example ’rariant -h’.

The ’readRariant’ and ’writeRariant’ functions allow to import and export the results of a ’rariant’
call from and to a ﬁle output, and will return the same object.

Value

A ’GRanges’ object, with each row corresponding to a genomic site, and columns:

• testMismatch, controlMismatchMismatch counts in the test and control sample.

• testDepth, controlDepthSequencing depth in the test and control sample.

• testRef, testAltReference and alternative allele of the test sample.

• controlRefReference allele of the control sample.

• testRefDepth, testAltDepthSupporting sequencing depth for the reference and alternative al-

lele in the test sample.

• refConsensus allele.

• p1, p2Estimated non-consensus rate in test and control, respectively.

• dEstimated shift in the non-consensus rate between test and control.

• dsEstimated shift in the non-consensus rate between test and control (shrinkage point esti-

mate).

• lower, upperLower and upper bound of the conﬁdence interval for ’d’.

• pval, padjRaw and BH-adjusted p-value of the FET test.

• calledWas the site identiﬁed as variant?

• eventTypeThe class of the event: somatic, heterozygous, undecided.

• padjSomatic, padjHeteroBH-adjusted p-values of the binomial tests for ’eventType’.

• pvalSomatic, pvalHeteroRaw p-values of the binomial tests for ’eventType’.

Examples

library(GenomicRanges)

control_bam = system.file("extdata", "NRAS.Control.bam", package = "h5vcData", mustWork = TRUE)
test_bam = system.file("extdata", "NRAS.AML.bam", package = "h5vcData", mustWork = TRUE)

roi = GRanges("1", IRanges(start = 115258439, end = 115259089))

vars = rariant(test_bam, control_bam, roi)

vars_all = rariant(test_bam, control_bam, roi, select =
FALSE)

## Not run:

system2(rariantStandalone(), "-h")

## End(Not run)

rariantInspect

15

rariantInspect

Interactive inspection

Description

Interactively inspect variant sites and results of the ’rariant’ function.

Usage

rariantInspect(x)

Arguments

x

Details

The return value of the ’rariant’ or ’readRariant’ function.

With the web interface of ’rariantInspect’ can existing variant calls and assessment be explored
interactively. It allows to select the genomic region of interest and the type of event. Results are
shown as both a conﬁdence interval plot and a results table that can be further ﬁltered and reordered.

Examples

example(rariant)

rariantInspect(vars_all)

splitSample

Split Sample for Binomial Data

Description

Sample splitting, according to Hall, 2014.

Usage

splitSampleBinom(x, n)

Arguments

x

n

Number of successes

Number of trials

16

Details

tallyBam

These functions implement sample splitting of a binomial rate.

Note that the results depend on the state of the random number generator, and are therefore not
strictly deterministic.

Value

A vector with the rate p = X

N , obtained with sample splitting.

References

Decrouez, Geoffrey, and Peter Hall. "Split Sample Methods for Constructing Conﬁdence Intervals
for Binomial and Poisson Parameters." Journal of the Royal Statistical Society: Series B (Statistical
Methodology), 2013, n/a–n/a. doi:10.1111/rssb.12051.

Examples

n = 10
m = 5
pt = 0.5

x = rbinom(m, n, pt)
p = x/n

ps = splitSampleBinom(x, n)

round(cbind(p, ps), 2)

tallyBam

Tally a genomic region

Description

Create the nucleotide count table (’tally’) of a genomic region from a BAM ﬁle.

Usage

tallyBamRegion(bam, region, minBase = 0, minMap = 0, maxDepth = 10000)

Arguments

bam

BAM ﬁle

region
minBase, minMap

GRanges with the region to tally, with one entry.

Minimum base call and mapping quality for reads to be considered for the nu-
cleotide count table [default: 0]. Reads with a lower quality are dropped.

maxDepth

Maximal sequencing depth to analyze.

Details

For details, look at the documentation of the underlying ’tallyBAM’ function in the ’h5vc’ package.

17

tallyPlot

Value

An integer array with the dimensions:

• positionLength: width(region)

• baseA, C, G, T

• strand+, -

See Also

h5vc::tallyBAM, deepSNV::bam2R, Rsamtools::pileup

tallyPlot

Mismatch plot from BAM ﬁles

Description

Create a mismatch plot from a list of BAM ﬁles directly.

Usage

tallyPlot(file, region, ref, nCycles = 0, minQual = 0, minFreq = 0, ...)

Arguments

file

region

ref

nCycles

minQual

minFreq

...

BAM ﬁle paths

GRanges with the position (width: 1) to tally, with one entry.

Reference object, as ’BSgenome’.

Number of sequencing cycles to remove from the beginning and end of each
read when creating the base count table. This avoids low quality read positions
[default: 0]. See ’tallyBamRegion’

Minimum base call quality for reads to be considered for the nucleotide count
table [default: 0]. Reads with a lower quality are dropped. See ’tallyBamRe-
gion’

Currently not used

Additional arguments, passed to ’tallyBAM’.

Value

A ’ggplot2’ or ’ggbio’ object.

See Also

h5vc::mismatchPlot

18

Examples

library(ggbio)
library(GenomicRanges)
library(BSgenome.Hsapiens.UCSC.hg19)

yesNoMaybe

region = GRanges("chr17", IRanges(7572100, width = 1))

control_bam = system.file("extdata", "platinum", "control.bam", package =
"Rariant", mustWork = TRUE)
mix_bam = system.file("extdata", "platinum", "mix.bam", package = "Rariant",
mustWork = TRUE)

bam_files = c(control_bam, mix_bam)

region = GRanges("chr17", IRanges(7572050, width = 100))

control_bam = system.file("extdata", "platinum", "control.bam", package =

"Rariant", mustWork = TRUE)

test1_bam = system.file("extdata", "platinum", "test.bam", package =

"Rariant", mustWork = TRUE)

test2_bam = system.file("extdata", "platinum", "test2.bam", package =

"Rariant", mustWork = TRUE)

mix_bam = system.file("extdata", "platinum", "mix.bam", package =

"Rariant", mustWork = TRUE)

bam_files = c(control_bam, test1_bam, test2_bam, mix_bam)

library(BSgenome.Hsapiens.UCSC.hg19)
ref = BSgenome.Hsapiens.UCSC.hg19

p = tracks(lapply(bam_files, tallyPlot, region, ref, minQual = 25))

print(p)

yesNoMaybe

Determine Variant Evidence

Description

Determine the evidence (absence, presence, dontknow) of variants.

Usage

yesNoMaybe(x, null = 0, one = 0.5)

Arguments

x

null

one

GRanges with variants, as returned by ’rariant’.

Shift consistent with the _absence_ of a variant.

Shift consistent with the _presence_ of a variant.

yesNoMaybe

Value

19

The same GRanges object as the input ’x’, with the factor column ’verdict’: ’absent’, ’present’,
’inbetween’, ’dontknow’

rariant, 12
rariant,array,array,GRanges-method

(rariant), 12

rariant,BamFile,BamFile,GRanges-method

(rariant), 12

rariant,character,character,GRanges-method

(rariant), 12
rariant-methods (rariant), 12
Rariant-package, 2
rariantInspect, 15
rariantStandalone (rariant), 12
rateFillScale (colorscales), 5
readRariant (rariant), 12

scoreTest (propTests), 11
selectStrand (mismatchUtils), 7
seqDepth (mismatchUtils), 7
splitSample, 15
splitSampleBinom (splitSample), 15

tallyBam, 16
tallyBamRegion (tallyBam), 16
tallyPlot, 17

updateCalls (multiCalls), 8

verdictColorScale (colorscales), 5

writeRariant (rariant), 12

yesNoMaybe, 18

Index

∗Topic package

Rariant-package, 2

acCi (propCIs), 9

baseFillScale (colorscales), 5

callConsensus (mismatchUtils), 7
ciAdjust, 3
ciAdjustLevel (ciAdjust), 3
ciAssessment, 3
ciCovers (ciUtils), 4
ciOutside (ciUtils), 4
ciOverlap (ciUtils), 4
ciUtils, 4
ciWidth (ciUtils), 4
colorscales, 5
convertUtils, 6
coverageProbability (ciAssessment), 3

eventFillScale (colorscales), 5
evidenceHeatmap, 6

feTest (propTests), 11
filterCalls (multiCalls), 8
findCalls (multiCalls), 8

gr2pos (convertUtils), 6

mergeCalls (multiCalls), 8
mismatchCount (mismatchUtils), 7
mismatchUtils, 7
multiCalls, 8

nhsCi (propCIs), 9
nmTest (propTests), 11

plotAbundanceShift (plotCIs), 8
plotCIs, 8
plotConfidenceIntervals (plotCIs), 8
pos2gr (convertUtils), 6
propCIs, 9
propTests, 11

Rariant (Rariant-package), 2

20


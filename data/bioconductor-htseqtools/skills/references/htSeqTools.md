htSeqTools: quality control, visualization
and processing high-throughput sequencing
data

Evarist Planet *, Camille Stephan-Otto *, Oscar Reina *,
Oscar Flores (cid:132), David Rossell *

1

Introduction

The htSeqTools package provides an easy-to-use toolset to eﬃciently per-
form a variety of tasks with high-throughput sequencing data. Although rel-
atively simple-minded, we found the tools to be extremely helpful in quality
control assessment, routine pre-processing and analysis steps and in produc-
ing useful visualizations. When using the package please cite Planet et al.
[2012]. The supplementary material of the paper should be a useful resource,
as it contains a detailed description of the methods and additional examples
(including ChIP-Seq, MNase-Seq and RNA-Seq) with R code.

Emphasis is placed on ChIP-Seq alike experiments, but many functions

are also useful for other kinds of sequencing experiments.

Many routines allow performing computations in parallel by specifying an
argument mc.cores, which uses package parallel. As this package is not
available in all platforms, in this manual we do not use parallel computing.
Please see the help page for each function for more details.

We start by loading the package and a ChIP-Seq dataset which we will

use for illustration purposes.

> options(width=70)
> library(htSeqTools)
> data(htSample)
> htSample

GRangesList object of length 4:
$ctrlBatch1

*Bioinformatics & Biostatistics Unit, IRB Barcelona
(cid:132)IRB-BSC Joint Research Program on Computational Biology, IRB Barcelona

1

GRanges object with 102866 ranges and 0 metadata columns:

seqnames
<Rle>
chr2L [499167, 499206]
chr2L [377930, 377969]
chr2L [306297, 306336]
chr2L [174413, 174452]
chr2L [322795, 322834]
...
chr2L [318650, 318689]
chr2L [294283, 294322]
chr2L [420010, 420049]
chr2L [292888, 292927]
chr2L [252943, 252982]

ranges strand
<IRanges> <Rle>
+
-
-
+
+
...
+
-
+
-
-

...

[1]
[2]
[3]
[4]
[5]
...
[102862]
[102863]
[102864]
[102865]
[102866]

...
<3 more elements>
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

> sapply(htSample,nrow)

$ctrlBatch1
NULL

$ipBatch1
NULL

$ctrlBatch2
NULL

$ipBatch2
NULL

htSample is a GRangesList object storing the chromosome, start and end
positions for reads mapped to the ﬁrst 500kb of the drosophila melanogaster
chromosome 2L. htSample contains 2 immuno-precipitated and 2 control
input samples obtained in two separate Illumina sequencing runs, which we
named Batch1 and Batch2. The standard Illumina pipeline was used for pre-
processing the data. Following the Bowtie defaults, only uniquely mapping
reads with at most 2 mismatches in the ﬁrst 28 bases were kept. We do not
give any further details about the experiment, as the results have not yet
been published.

You can easily build a GRangesList to store multiple GRanges objects
(coming from diﬀerent BED ﬁles read as data frames for instance). We
will extract two elements from htSample in order to simulate a batch of
2 externally loaded samples. Ctrl and IP1 will be two data frames with

’seqnames’, ’start’, ’end’, ’width’, and ’strand’ columns. Please note that
only ’seqnames’, ’start’ and ’end’ are necessary in order to directly generate
a GRanges object from a data frame. The ’width’ and ’strand’ column are
optional and any additional column will be added to the GRanges object as
a metadata column.

> Ctrl=as.data.frame(htSample[[1]])
> IP1=as.data.frame(htSample[[2]])
> head(Ctrl)

seqnames start

chr2L 499167 499206
chr2L 377930 377969
chr2L 306297 306336
chr2L 174413 174452
chr2L 322795 322834
chr2L 415508 415547

end width strand
+
40
-
40
-
40
+
40
+
40
+
40

1
2
3
4
5
6

> makeGRangesFromDataFrame(Ctrl)

GRanges object with 102866 ranges and 0 metadata columns:

seqnames
<Rle>
chr2L [499167, 499206]
chr2L [377930, 377969]
chr2L [306297, 306336]
chr2L [174413, 174452]
chr2L [322795, 322834]
...
chr2L [318650, 318689]
chr2L [294283, 294322]
chr2L [420010, 420049]
chr2L [292888, 292927]
chr2L [252943, 252982]

[1]
[2]
[3]
[4]
[5]
...
[102862]
[102863]
[102864]
[102865]
[102866]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

ranges strand
<IRanges> <Rle>
+
-
-
+
+
...
+
-
+
-
-

...

> htSample2 <- GRangesList(Ctrl=makeGRangesFromDataFrame(Ctrl),
+
> htSample2

IP1=makeGRangesFromDataFrame(IP1))

GRangesList object of length 2:
$Ctrl
GRanges object with 102866 ranges and 0 metadata columns:

seqnames
<Rle>
chr2L [499167, 499206]
chr2L [377930, 377969]
chr2L [306297, 306336]
chr2L [174413, 174452]

ranges strand
<IRanges> <Rle>
+
-
-
+

[1]
[2]
[3]
[4]

[5]
...
[102862]
[102863]
[102864]
[102865]
[102866]

...

chr2L [322795, 322834]
...
chr2L [318650, 318689]
chr2L [294283, 294322]
chr2L [420010, 420049]
chr2L [292888, 292927]
chr2L [252943, 252982]

+
...
+
-
+
-
-

...
<1 more element>
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

> htSample2[[

’

’

Ctrl

]]

GRanges object with 102866 ranges and 0 metadata columns:

seqnames
<Rle>
chr2L [499167, 499206]
chr2L [377930, 377969]
chr2L [306297, 306336]
chr2L [174413, 174452]
chr2L [322795, 322834]
...
chr2L [318650, 318689]
chr2L [294283, 294322]
chr2L [420010, 420049]
chr2L [292888, 292927]
chr2L [252943, 252982]

[1]
[2]
[3]
[4]
[5]
...
[102862]
[102863]
[102864]
[102865]
[102866]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

ranges strand
<IRanges> <Rle>
+
-
-
+
+
...
+
-
+
-
-

...

2 Quality control

2.1 A PCA analogue for sequencing data

PCA is a commonly used technique to assess overall quality and identify
problematic samples in high-throughput experiments. PCA requires to de-
ﬁne a common set of entities (e.g. genes) for all samples and obtain some
numerical measurement for each entity in each sample (e.g. gene expression).
Therefore, unfortunately PCA is not directly applicable to sequencing data.
One option is to pre-process the data so that PCA can be applied, e.g. com-
puting the number of reads falling in some pre-deﬁned genomic regions. The
inconvenient of this approach is its lack of generality, since diﬀerent kinds
of sequencing data generally require diﬀerent pre-processing. For instance,
while in RNA-Seq we can obtain a PCA based on RPKM expression measures

[Mortazavi et al., 2008], this same strategy is not adequate for ChIP-Seq data
where many reads may be mapped to promoter or inter-genic regions.

Instead, we propose comparing the read coverage across samples and using
Multi-Dimensional Scaling (MDS) to obtain a low-dimensional visual repre-
sentation. Read coverage is a universal measure which can be computed
eﬃciently for any type of sequencing data. We measure similarity between
samples i and j with ρij, the correlation between their log-coverages, and
deﬁne their distance as dij = 0.5(1 − ρij). Pearson, Spearman and Kendall
correlation coeﬃcients are available. We compute correlations in the log-
scale to take into account that the coverage distribution is typically highly
asymmetric. In principle, Spearman is more general as it captures non-linear
associations, but in practice all options typically produce very similar results.
MDS is then used to plot the samples in a low-dimensional space, in a way
such that the Euclidean distance between two points is closest to the Pearson
distances. Our approach is implemented in a cmds method for GRangesList
objects. We illustrate its use by obtaining a two-dimensional MDS for our
sample data.

> cmds1 <- cmds(htSample,k=2)

Computing coverage...
Computing correlations...

> cmds1

Object of class cmdsFit approximating distances between 4 objects
R-squared= 1

The R2 coeﬃcient between the original distances and their approxima-
tion in the plot can be seen as an analogue to the percentage of explained
variability in a PCA analysis. For our sample data R2=1 (up to rounding),
which indicates a perfect ﬁt and that therefore a 3-dimensional plot is not
necessary.

> plot(cmds1)

Figure 1 shows the resulting plot. The IP samples from both runs group
nicely, indicating that they have similar coverage proﬁles. The control sam-
ples also group reasonably well, although they present more diﬀerences than
the IP samples. This is to be expected, since the IP samples focus on a
relatively small genomic regions. The MDS plot also reveals a minor batch
eﬀect, as samples from the same batch appear slightly closer in the map.

Figure 1: 2-dimensional MDS plot. Samples with similar coverage appear
close-by

llll−0.20−0.15−0.10−0.050.000.050.100.15−0.20−0.100.000.050.100.15ctrlBatch1ipBatch1ctrlBatch2ipBatch22.2 Exploring coverage uniformity

In some next-generation sequencing experiments we expect some samples to
exhibit large accumulations of reads in certain genomic regions, whereas other
samples should present a more uniform coverage along the genome. For in-
stance, in ChIP-seq one should observe higher peaks for immuno-precipitated
(IP) samples than in the controls. That is, IP samples should present cov-
erage rich and coverage poor regions, whereas diﬀerences in coverage in the
controls should be smaller.

In these cases we propose to measure the unevennes in the coverage using
either the coverage standard deviation or Gini’s coeﬃcient [Gini, 1912], which
is a classical econometrics measure to assess unevennes of wealth distribution.
Comparing these statistical dispersion measures between samples can reveal
samples with inneﬃcient immuno-precipitation (e.g. due to an inadequate
antibody). Both measures can be easily obtained with the functions ssdCov-
erage and giniCoverage. Simple algebra shows that the expected value of
n, where n is the number
the coverage standard deviation is proportional to
n as a measure that
of reads. Therefore ssdCoverage reports SDn = SD/
can be compared across samples with diﬀerent number of reads. Similarly,
simulations show that the expected Gini also depends on n. Since no closed-
form expression is available, we estimate its expected value by generating n
reads uniformly distributed along the genome and computing the Gini coef-
ﬁcient. The adjusted Gini (Gn) is the diﬀerence between the observed Gini
(G) minus its estimated expected value ˆE(G|n).

√

√

> ssdCoverage(htSample)

ctrlBatch1

ipBatch1 ctrlBatch2

55.98648 169.15785

ipBatch2
18.14517 100.43349

> giniCoverage(htSample,mc.cores=1)

Simulating uniformily distributed data
Calculating gini index of original data
Simulating uniformily distributed data
Calculating gini index of original data
Simulating uniformily distributed data
Calculating gini index of original data
Simulating uniformily distributed data
Calculating gini index of original data

ctrlBatch1 0.8038884
0.9378820
ipBatch1
ctrlBatch2 0.4813761
0.9127399
ipBatch2

gini gini.adjust
0.6078046
0.7960869
0.2260839
0.7134673

Figure 2: Lorenz curves to assess coverage uniformity. Left: control; Right:
immuno-precipitated sample

The coverage exhibits higher dispersion in the IP samples than in the
controls, which indicates there were no substantial problems in the immuno-
precipitation. The function giniCoverage allows to graphically assess the
non-uniformity in the coverage distribution by plotting the probability and
cumulative probability function. The top panels in Figure 2 show the log
probability mass function of the coverage, and the bottom panels show the
Lorenz curve (Gastwirth [1972], see Lc from package ineq for details). We
observe a more pronounced non-uniformity in the IP sample.

> giniCoverage(htSample[[

’

ctrlBatch2

’

]],mc.cores=1,mk.plot=TRUE)

> giniCoverage(htSample[[

’

ipBatch2

’

]],mc.cores=1,mk.plot=TRUE)

2.3 Detecting over-ampliﬁcation artifacts

High-throughput sequencing requires a PCR ampliﬁcation step to enrich for
adapter-ligated fragments. This step can induce biases as some DNA re-
gions amplify more eﬃciently than others (e.g. depending on GC content).
These PCR artifacts, caused by over-ampliﬁcation or primer dimers, aﬀect
the accuracy of the coverage and can create biases in the downstream analy-
ses. The function filterDupReads aims to automatically detect and remove
these artifacts. The basic rationale is that, by counting the number of times
that each read is repeated, we can detect the reads repeating an unusually

010203040−10−6−2sample: missingGini index: 0.2264IndexProportion of bases (log)0.00.20.40.60.81.00.00.20.40.60.81.0Lorenz curvepL(p)0100200300400−12−6−2sample: missingGini index: 0.7131IndexProportion of bases (log)0.00.20.40.60.81.00.00.20.40.60.81.0Lorenz curvepL(p)large number of times. The argument maxRepeats can be used to elimi-
nate all reads appearing more than this user-speciﬁed threshold. However,
notice that ideally this threshold should be determined for each sample sep-
arately, as the expected number of naturally occurring repeats depends on
the sequencing depth, and may also depend on the characteristics of each
sample. For instance, sequences from IP samples focus on a relatively small
genomic region while those from controls are distributed along most of the
genome, and therefore we expect a higher number of repeats in IP samples.
When specifying the argument fdrOverAmp, filterDuplReads determines
the threshold in a data-adaptive manner.

Although this ﬁltering can be performed with a single call to filterDu-
plReads, we now illustrate its inner workings in a step-by-step fashion. We
add 200 repeats of an artiﬁcial sequence to sample "ctrlBatch1", and count
the number of times that each sequence appears with the function tabDu-
plReads.

’

’

> contamSample <- GRanges(
> contamSample <- c(htSample[[
> nrepeats <- tabDuplReads(contamSample)
> nrepeats

ctrlBatch1

chr2L

’

’

,IRanges(rep(1,200),rep(36,200)),strand=

’

’

+

)

]],contamSample)

ans

3

2

1

6
11812 10112 6744 4083 2325 1343
17
4

14
19

15
9

13
35

16
9

12
57

4

5

7
727
18
5

8
447
19
1

9
212
20
2

10
113
22
1

11
87
200
1

There are 11812 sequences appearing only once, 10112 appearing twice
etc. The function fdrEnrichedCounts (called by filterDuplReads) deter-
mines the over-ampliﬁcation threshold in a data-adaptive manner. Basically,
it assumes that only large number of repeats are artifacts and models the
reads with few repeats with a truncated negative binomial mixture (ﬁt via
Maximum Likelihood), which we observed to ﬁt experimental data reasonably
well. The number of components to be used is chosen in parameter compo-
nents. If this parameter has value 0 the optimal number of components is
selected using the Bayesian information criterion (BIC). Here we used one
component for computational speed. An empirical Bayes approach similar to
that in Efron et al. [2001] is then used to estimate the FDR associated with
a given cutoﬀ (see help(fdrEnrichedCounts) for details).

> q <- which(cumsum(nrepeats/sum(nrepeats))>.999)[1]
> q

14
14

Figure 3: Black line: estimated FDR for each number of repeats cutoﬀ.
Red line: distribution of the number of repeats as estimated by a truncated
negative binomial with 2 components (representing not over-ampliﬁed reads).
Blue line: distribution of the number of repeats in the observed data.

> fdrest <- fdrEnrichedCounts(nrepeats, use=1:q, components=1)
> numRepeArtif <- rownames(fdrest[fdrest$fdrEnriched<0.01,])[1]
> numRepeArtif

[1] "25"

Here we assumed that less than 1/1000 reads are artifacts and ﬁt a nega-
tive binomial truncated at [1, 14]. Notice that, although here we used fdrEn-
richedCounts to detect over-ampliﬁcation, it can also be used in any other
setup when one whishes to detect large counts.
In Figure 3 we produce
a plot showing the estimated FDR for a series of cutoﬀs. The argument
fdrOverAmp to filterDuplReads indicates the FDR cutoﬀ to determine
over-ampliﬁcation. We also show the distribution of the observed number of
repeats (blue) and its truncated negative binomial approximation in [1, 14]
(red). Notice that any sequence repeating over 25 times (including our arti-
ﬁcial sequence repeating 200 times) is regarded as an artifact.

’

’

’’

,ylab=

’

,xlab=

Number of repeats (r)

’

)

> plot(fdrest$fdrEnriched,type=
> lines(fdrest$pdfOverall,col=4)
> lines(fdrest$pdfH0,col=2,lty=2)
> legend(

topright

,c(

FDR

,

’

’

’

’

’

l

P(r | no artifact)

’

’

,

’

P(r)

),lty=c(1,2,1),col=c(1,2,4))

0501001502000.00.20.40.60.81.0Number of repeats (r)FDRP(r | no artifact)P(r)3 Data pre-processing

We discuss several tools which can be useful for ChIP-seq data preprocess-
ing. In these studies there typically is a strand-speciﬁc bias: reads coming
from the + strand pile up to the left of reads from the - strand. Removing
this bias is important, as it provides a highly increased accuraccy for peak
detection. alignPeaks implements a procedure to correct this bias, which is
fairly similar to the MACS procedure [Zhang et al., 2008]. A nice alterna-
tive is provided in function estimate.mean.fraglen from package chipseq.
To illustrate the need for the adjustment we plot the coverage in a certain
genomic region before the adjustment (displayed in Figure 4, left panel).
’

’

> covbefore <- coverage(htSample[[
’
> covbefore <- window(covbefore[[
> plot(as.integer(covbefore),type=

ipBatch2
’

]])

chr2L
’
’

]],295108,297413)
Coverage

)

’

’

,ylab=

l

Now we perform the adjustment with alignPeaks and plot the resulting
coverage as the solid black line in Figure 4 (right panel). In blue and red
color we display the coverage computed separately from reads on the + and
- strands, respectively. The blue and red lines present a similar proﬁle, but
they are shifted. Exploring other peaks reveals similar patterns. Removing
this strand speciﬁc bias results in sharper peaks and prevents detecting two
separate peaks when there should actually be one, as illustrated by the left-
most peak in Figure 4.

> ip2Aligned <- alignPeaks(htSample[[

’

ipBatch2

’

]],strand=

’

’

strand

, npeaks=100)

Estimated shift size is 61.49423

> covafter <- coverage(ip2Aligned)
> covafter <- window(covafter[[
> covplus <- coverage(htSample[[
> covplus <- window(covplus[[
> covminus <- coverage(htSample[[
> covminus <- window(covminus[[

’

’

’

’

’

chr2L
’

’

’

’

chr2L

]],295108,297413)

ipBatch2
’

chr2L

]],295108,297413)

]],295108,297413)

ipBatch2

]][strand(htSample[[

’

ipBatch2

’

’

]])==

’

+

])

]][strand(htSample[[

’

ipBatch2

’

’

]])==

’

-

])

> plot(as.integer(covafter),type=
’
> lines(as.integer(covplus),col=
> lines(as.integer(covminus),col=

l
blue
’
red

’
’

,lty=2)
,lty=2)

’

’

,ylab=

’

Coverage

’

)

In ChIP-seq experiments, it is sometimes convenient to extend the reads
to take into account that we only sequenced the ﬁrst few bases (typically 40-
100 bp) from a larger DNA fragment (typically around 300bp). In practice,
this achieves some smoothing of the read coverage. extendRanges extends
the reads up to a user-speciﬁed length.

Figure 4: Coverage for gene p38b. Left: Before adjustment; Right: After
- strand; Black line: global
adjustment. Blue line: + strand; Red line:
estimate after peak alignment by alignPeaks.

4 Basic data analysis

Finding genomic regions with large accumulation of reads is an important
task in many sequencing experiments, including ChIP-Seq and RNA-Seq.
islandCounts performs a simple analysis using tools provided in the IRanges
package. We search for genomic regions with an overall coverage ≥ 10 (i.e.
across all samples), and obtain the number of reads in each sample overlap-
ping with these regions.

> ip <- c(htSample[[2]],htSample[[4]])
> ctrl <- c(htSample[[1]],htSample[[3]])
> pool <- GRangesList(ip=ip, ctrl=ctrl)
> counts <- islandCounts(pool,minReads=10)
> head(counts)

GRanges object with 6 ranges and 2 metadata columns:

ip

ranges strand |

seqnames
<Rle>
chr2L [5191, 5211]
chr2L [5214, 5227]
chr2L [5411, 5476]
chr2L [5484, 5484]
chr2L [5602, 5645]
chr2L [5650, 5652]

ctrl
<IRanges> <Rle> | <integer> <integer>
5
4
14
5
13
3

* |
* |
* |
* |
* |
* |

7
9
15
5
13
7

[1]
[2]
[3]
[4]
[5]
[6]

0500100015002000050100150200250300IndexCoverage05001000150020000100200300400IndexCoverage-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

There are a number of analysis strategies to compare these counts be-
tween groups. For instance for short RNA sequencing data we could com-
pare expression levels across groups using the tools in package DEseq. Here
we show a simple analysis based on likelihood-ratio tests with the function
enrichedRegions.

> mappedreads <- c(ip=nrow(ip),ctrl=nrow(ctrl))
> mappedreads

NULL

> regions <- enrichedRegions(sample1=ip,sample2=ctrl,minReads=10,mappedreads=mappedreads,p.adjust.method=
> head(regions)

’

’

BY

,pvalFilter=.05,twoTailed=FALSE)

GRanges object with 6 ranges and 5 metadata columns:

sample1

ranges strand |

[1]
[2]
[3]
[4]
[5]
[6]

* |
* |
* |
* |
* |
* |

651
2044
991
10
10
898

seqnames
<Rle>
chr2L [66674, 67923]
chr2L [72428, 73199]
chr2L [73357, 74080]
chr2L [74484, 74484]
chr2L [86284, 86285]
chr2L [86294, 87202]

sample2
<IRanges> <Rle> | <integer> <integer>
249
200
144
0
0
260
rpkm2
<numeric>
[1] 8.07214328893402e-05 1767.67676767677 1224.52743199631
0 8986.60120622347 1592.54561249702
[2]
0 4645.8690751152 1222.65269785959
[3]
0
[4]
[5]
0
0 3353.08321752127 1758.28248262048
[6]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

0.0431594471248686 33941.5661996307
0.0431594471248686 16970.7830998154

rpkm1
<numeric>

pvalue
<numeric>

> nrow(regions)

NULL

The argument twoTailed=FALSE indicates that only regions with a sig-
niﬁcantly higher number of reads in sample1 than in sample2 are reported.
Regions with overall coverage ≥10 are selected, and a likelihood-ratio test is
used to compare the proportion of reads in sample1 falling in a given region
with the proportion in sample2. When setting exact to TRUE, a permutation-
based Chi-square test is used whenever the expected counts in any group is
below 5. Here we reported only regions with Benjamini-Yekutielli adjusted
p-values below 0.05.

enrichedRegions can also be used with no control sample, in which case
it looks for islands with a signiﬁcant accumulation of reads with an exact
Binomial test. The null hypothesis assumes that a read is equally likely to
come from any of the selected regions.

A related function is enrichedPeaks, which can be used to ﬁnd peaks
within the enriched regions. Peaks are deﬁned as enriched regions where the
diﬀerence in coverage between sample1 and sample2 is above a user-speciﬁed
threshold. In this example we use minHeight=100.

> peaks <- enrichedPeaks(regions, sample1=ip, sample2=ctrl, minHeight=100)
> peaks

GRanges object with 162 ranges and 2 metadata columns:

ranges strand |

seqnames
<Rle>
chr2L
chr2L
chr2L
chr2L
chr2L
...

[1]
[2]
[3]
[4]
[5]
...
[158]
[159]
[160]
[161]
[162]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

<IRanges> <Rle> | <integer>
141
233
114
100
100
...
102
104
102
113
103

[72615, 72665]
[72668, 72940]
[72988, 72994]
[72996, 72997]
[73475, 73475]
...
chr2L [491339, 491341]
chr2L [491345, 491347]
chr2L [491349, 491349]
chr2L [491354, 491379]
chr2L [491382, 491384]

height region.pvalue
<numeric>
0
0
0
0
0
...
0
0
0
0
0

* |
* |
* |
* |
* |
... .
* |
* |
* |
* |
* |

It is possible to merge nearby regions, e.g. say no more than 300bp apart,
into a single region with the function mergeRegions. mergeRegions allows
to combine a numerical score across regions with any user-deﬁned function,
e.g. the mean or median. In the following example we merge regions less
than 300bp apart and compute their median ’height’.

> mergeRegions(peaks, maxDist=300, score=

’

’

height

, aggregateFUN=

’

’

median

)

GRanges object with 35 ranges and 1 metadata column:

ranges strand |

seqnames
<Rle>
chr2L [ 72615, 72997]
chr2L [ 73475, 73712]
chr2L [102368, 103198]
chr2L [106082, 106784]
chr2L [108119, 109322]
...
chr2L [431278, 432063]
chr2L [453202, 453882]

height
<IRanges> <Rle> | <numeric>
127.5
102
935.5
1272
108
...
116.5
531

* |
* |
* |
* |
* |
... .
* |
* |

...

[1]
[2]
[3]
[4]
[5]
...
[31]
[32]

chr2L [473207, 473721]
chr2L [478840, 479586]
chr2L [491110, 491384]

[33]
[34]
[35]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

508
342.5
103.5

* |
* |
* |

A common task is to identify genomic features close to the identiﬁed
regions/peaks, e.g. ﬁnding the closest gene. This can be performed with the
function annotatePeakInBatch from package ChIPpeakAnno, for instance.
Sometimes it is of interest to compare the list of genes which had a nearby
peak with the genes found in another experiment. The function listOverlap
quantiﬁes the overlap and tests for its statistical signiﬁcance.

Another analysis which may be of interest is locating hot chromosomal
regions, i.e., regions in the chromosome with a large number of peaks. The
function enrichedChrRegions can be used for this purpose. First we need
to deﬁne a named vector indicating the chromosome lengths. Since our ex-
ample data only contains reads aligning to the ﬁrst 500,000 bases of chr2L,
we manually its length. More generally, one can determine the chromosome
lengths from Bioconductor packages (e.g. for drosophila melanogaster load
BSgenome.Dmelanogaster.UCSC.dm3 and evaluate seqlengths(Dmelanogaster),
and similarly for other organisms). We run the function setting a window size
of 9999 base pairs and a 0.05 false discovery rate level. For computational
speed here we only use nSims=1 simulations to estimate the FDR.

> chrLength <- 500000
> names(chrLength) <- c(
> chrregions <- enrichedChrRegions(peaks, chrLength=chrLength, windowSize=10^4-1, fdr=0.05, nSims=1)
> chrregions

chr2L

)

’

’

GRanges object with 11 ranges and 0 metadata columns:

seqnames
<Rle>
chr2L [ 68708, 77639]
chr2L [104266, 113558]
chr2L [150732, 161683]
chr2L [203117, 212706]
chr2L [244550, 255472]
chr2L [272320, 276407]
chr2L [277654, 282740]
chr2L [292857, 301000]
chr2L [301160, 302862]
chr2L [413952, 419140]
chr2L [486367, 500000]

[1]
[2]
[3]
[4]
[5]
[6]
[7]
[8]
[9]
[10]
[11]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

ranges strand
<IRanges> <Rle>
*
*
*
*
*
*
*
*
*
*
*

Figure 5: Chromosomal regions with a large number of hits. Red marks
indicate regions with high concentration of peaks.

enrichedChrRegions returns a GRanges which for our sample data is
empty, suggesting that there is no region with an unusually high density of
enriched regions. Two related functions are countHitsWindow which com-
putes the moving average of the number of hits, and plotChrRegions to
visualize the results. For illustrative purposes we make up two regions with
high density of enriched peaks and plot them.

> chrregions <- GRanges(c(
chr2R
> plotChrRegions(regions=chrregions, chrLength=c(chr2L=500000,chr2R=500000))

), IRanges(start=c(100000,200000),end=c(100100,210000)))

chr2L

,

’

’

’

’

5 Plots

stdPeakLocation and PeakLocation produce a plot useful for exploring
overall patterns in ChIP-chip or ChIP-seq experiments. Basically, it creates
a density plot indicating where the peaks were located with respect to the
closest gene/genomic feature. stdPeakLocation indicates the location in
standardized coordinates, i.e. relative to each gene/features’s length, which
in some situations can help making genes/features comparable. PeakLo-
cation produces the same plot in base pairs (i.e. non-standardized coor-
dinates), which is useful as distances have a direct physical interpretation,
e.g. to relate the peak location with nucleosome positioning. As mentioned
earlier, function annotatePeakInBatch from package ChIPpeakAnno can be

chr2Lchr2RNULL

Figure 6: Distribution of peaks around the closest gene

used to ﬁnd the gene closest to each region. For illustrative purposes here
we assign a fake gene to each region. The fake genes start, end, strand and
distance from the start to the region by default are assumed to be stored in
’start_position’, ’end_position’, ’strand’ and ’distance’, respec-
tively (although diﬀerent names can be given as arguments to PeakLocation
and stdPeakLocation).

> set.seed(1)
> peaksanno <- peaks
> mcols(peaksanno)$start_position <- start(peaksanno) + runif(length(peaksanno),-500,1000)
> mcols(peaksanno)$end_position <- mcols(peaksanno)$start_position + 500
> mcols(peaksanno)$distance <- mcols(peaksanno)$start_position - start(peaksanno)
> strand(peaksanno) <- sample(c(
> PeakLocation(peaksanno,peakDistance=1000)

),length(peaksanno),replace=TRUE)

,

-

+

’

’

’

’

NULL

Figure 6 shows the resulting plot. We see that most of the peaks occur

right around the transcription start site.

Two related functions are regionsCoverage and gridCoverage, which
evaluate the coverage on user-speciﬁed genomic regions. We illustrate their
use by obtaining the coverage for the regions which we found to be enriched
(as previously described). regionsCoverage computes the coverage in the
speciﬁed regions. As each region has a diﬀerent length it may be hard to

−10000100020000e+001e−042e−043e−044e−045e−046e−04Distance (bp)DensityStartStartStartStartcompare coverages across regions, e.g. to cluster regions with similar coverage
proﬁles. gridCoverage simpliﬁes this task by evaluating the coverage on a
regular grid of 500 equally spaced points between the region start and end.
The result is stored in an object of class gridCover. The object contains the
coverage, which can be accesed with the method getViewsInfo.

> cover <- coverage(ip)
> rcov <- regionsCoverage(seqnames(regions),start(regions),end(regions),cover=cover)
> names(rcov)

[1] "views"

"viewsInfo"

> rcov[[

’

’

views

]]

RleViewsList of length 1
names(1): chr2L

> gridcov <- gridCoverage(rcov)
> dim(getCover(gridcov))

[1] 50 500

> getViewsInfo(gridcov)

strand

DataFrame with 50 rows and 3 columns
maxCov
meanCov
<factor> <numeric> <integer>
51
244
129
10
10
...
1033
575
41
585
187

+ 20.64080
+ 105.58161
+ 54.57182
+ 10.00000
+ 10.00000
...
+ 216.27010
+ 110.71647
+ 13.15815
+ 112.99047
+ 53.23333

1
2
3
4
5
...
46
47
48
49
50

...

We plot the coverage for the selected regions and see that they present
diﬀerent proﬁles Figure 7, which suggests the use of some clustering technique
to ﬁnd subgroups of regions behaving similarly.

> ylim <- c(0,max(getViewsInfo(gridcov)[[
> plot(gridcov, ylim=ylim,lwd=2)
> for (i in seq_along(regions)) lines(getCover(gridcov)[i,], col=

maxCov

]]))

’

’

gray

, lty=2)

’

’

Figure 7: Coverage for some selected regions

References

B. Efron, R. Tibshirani, J.D. Storey, and V. Tusher. Empirical Bayes analysis
of a microarray experiment. Journal of the Americal Statistical Associa-
tion, 96:1151–1160, 2001.

J.L. Gastwirth. The estimation of the Lorenz curve and Gini index. The
review of economics and statistics (The MIT press), 54:306–316, 1972.

C. Gini. Variabilita e mutabilita. C. Cuppini, Bologna, 1912.

A. Mortazavi, B.A. Williams, K. McCue, L. Schaeﬀer, and B. Wold. Mapping
and quantifying mammalian transcriptomres by rna-seq. Nature methods,
5:621–628, 2008.

E. Planet, C. Stephan-Otto Attolini, O. Reina, O. Flores, and D. Rossell.
htseqtools: High-throughput sequencing quality control, processing and
visualization in r. Bioinformatics (in press), 2012.

Y. Zhang, T. Liu, C.A. Meyer, J. Eeckhoute, D.S. Johnson, B.E. Bernstein,
C. Nussbaum, R.M. Myers, M. Brown, W. Li, and X.S. Liu. Model-based
analysis of chip-seq (macs). Genome Biology, 9:R173, 2008.

050010001500coverageStartEnd
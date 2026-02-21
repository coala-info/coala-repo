An Introduction to the NarrowPeaks Pack-
age:
Analysis of Transcription Factor Binding ChIP-
seq Data using Functional PCA

Pedro Madrigal

Created: January, 2013. Last modiﬁed: July, 2015. Compiled: Octo-
ber 30, 2018

1 Department of Biometry and Bioinformatics, Institute of Plant Genetics, Polish Academy of
Sciences, Poznan, Poland
2 Current address: Wellcome Trust Sanger Institute, Wellcome Trust Genome Campus, Hinxton,
Cambridge, UK
3 Current address: Wellcome Trust - MRC Cambridge Stem Cell Institute, Anne McLaren
Laboratory for Regenerative Medicine, Department of Surgery, University of Cambridge,
Cambridge, UK

Contents

1

2

3

4

5

6

Citation.

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

Introduction and motivation .

Methodology .

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

3.1

3.2

Post-processing, splitting or trimming ChIP-seq peaks .

Differential transcription factor binding analysis .

Example .

Details .

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

Acknowledgements.

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

1

2

2

3

4

5

10

10

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

1

Citation

We have developed an R package able to analyze the variability in a set of candidate tran-
scription factor binding sites (TFBSs) obtained by chromatin immunoprecipitation followed by
high-throughput sequencing (ChIP-seq). The goal of this document is to introduce ChIP-seq
data analysis by means of functional principal component analysis (FPCA). An application
of the package for Arabidopsis datasets is described in:

An Introduction to the NarrowPeaks Package:
Analysis of Transcription Factor Binding ChIP-seq Data using Functional PCA

Mateos JL, Madrigal P, Tsuda K, Rawat V, Richter R, Romera-Branchat M, Fornara F,
Schneeberger K, Krajewski P and Coupland G (2015). Combinatorial activities of SHORT
VEGETATIVE PHASE and FLOWERING LOCUS C deﬁne distinct modes of ﬂowering regu-
lation in Arabidopsis. Genome Biology 16: 31. http://doi.org/10.1186/s13059-015-0597-1.

2

Introduction and motivation

Next-generation sequencing enables the scientiﬁc community to go a step further in the un-
derstanding of molecular mechanisms controlling transcriptional regulation. Comprehensive
ChIP-seq data analyses are carried out by many software tools [1]. Some of these bioinfor-
matic tools [3, 7, 11] are used to detect TFBSs in ChIP-seq data. Data analysis is usually
based on peak-search criteria of the local maxima over the read-enriched candidate regions,
but other approaches do exist [1]. For computation purposes, several assumptions are made
regarding the distribution of sample and control reads [1]. Although most sites reported by
peak ﬁnders could be narrowed down to 100-400bp using merely visual inspection, this reduc-
tion is not typically reﬂected by the regions provided by current methods, therefore degrading
the resolution [9].

Here we present the R package NarrowPeaks, able process data in WIG format (one of the
most popular standard formats for visualisation of next-generation sequencing data is the
wiggle track (WIG), and its indexed version bigWig) data, and analyze it based on statistics
of Functional Principal Component Analysis (FPCA) [8].
Instructions on how to generate
WIG/bigWig coverage tracks can be found in ‘TextS1’ in [1]. The aim of this novel approach
is to extract the most signiﬁcant regions of ChIP-seq peaks according to their primary modes
of variation in the (binding score) proﬁles. It allows to charaterise the ChIP-seq peak using
shape-based information, and could allow the user of this package to discriminate between
binding regions in close proximity and shorten the length of the transcription factor binding
sites preserving the information present in the the dataset at a user-deﬁned level of variance.
Without the trimming mode (see below), it also serves to describe peak shapes using a
set of statistics (FPCA scores) directly liked to the principal components of the dataset,
which is useful for post-processing ChIP-seq peaks after generic peak calling, and to analyze
diﬀerential binding of transcription factors across several conditions or treatments [5, 1].

3

Methodology

The functional version of PCA establishes a method for estimating orthogonal basis func-
tions (principal components or eigenfunctions) from functional data [8], in order to capture
as much of the variation as possible in as few components as possible. We can highlight
the genomic locations contributing to maximum variation (measured by an aproximation of
the variance-covariance function) from a list of peaks of a ChIP-seq experiment. We have
presented the basics of this methodology in Madrigal and Krajewski (2015) [4].

The algorithm ﬁrst converts a continuous signal of enrichment from a WIG ﬁle, and extracts
signal proﬁles of candidate TFBSs. Secondly, it characterises the binding signals using a B-
spline basis functions expansion. Finally, FPCA is performed in order to measure the variation

2

An Introduction to the NarrowPeaks Package:
Analysis of Transcription Factor Binding ChIP-seq Data using Functional PCA

of the ChIP-seq signal proﬁles under study. The output consists of a score-ranked list of sites
according to their contribution to the total variation. A more detailed description of the
method and its application to TF ChIP-seq data can be found below.

3.1

Post-processing, splitting or trimming ChIP-seq peaks

Consider a situation in which a number of peaks have been called in a ChIP-seq experiment.
The (read) enrichment signals (peaks) in n candidate TF binding sites of arbitrary length
and shape are denoted by the functions xi(t), i = 1, . . . , N , centered in a common interval
(1, L), and a proﬁle x0(t) ≡ 0, representing the null enrichment. These are considered as a
family of curves χ = {xi(t); t ∈ (1, L); i ∈ (0, N )}, approximated by linear combinations of
K B-spline basis functions φk(t) with coeﬃcients cik, i = 0, . . . , n; k = 1, . . . , K, as

xi(t) =

K
(cid:88)

k=1

cikφk(t).

1

The coeﬃcients can be estimated by either least squares or penalized residual sum of squares
criterion (for further details see [8]). The input list of sites deﬁned in χ may include also
low-enriched regions (weak peaks). For example, using the Bioconductor package CSAR
[6], candidate binding sites can be selected as those broad regions separated by a maximum
allowed gap of g bp, and proﬁle values higher than r. Alternatively, other initial set of
candidate regions, such as those obtained using general peak-calling tools [1], is also allowed
as an input ﬁle in BED format.

Subsequently, FPCA is run to estimate J ≤ K mutually orthogonal and normalized eigen-
functions ξj(t), j = 1, . . . , J capturing as much of the variation as possible in χ, thus ﬁnding
the subintervals in which the data present the highest variability. This is done solving the
equation:

(cid:90)

v(s, t)ξj(t)dt = δjξj(s)

2

3

for the appropriate eigenvalues δj. The covariance function v(s, t), is deﬁned as

v(s, t) =

1
N

N
(cid:88)

i=0

xi(s)xi(t).

For each element of χ the FPCA scores are computed as sij = (cid:82) γij(t)dt, where γij(t) =
ξj(t)[xi(t) − x(t)], with x(t) being the average ChIP-seq read-enriched proﬁle, deﬁned as:

x(t) =

1
N

N
(cid:88)

i=0

xi(t).

Then, an overall binding score is obtained for each peak as:

J
(cid:88)

(sij − s0j)2 =

f 2
i =

j=1

(cid:32) (cid:90)

J
(cid:88)

j=1

(cid:90)

γij(t)dt −

(cid:33)2

γ0j(t)dt

,

4

5

that is, as the squared distance of a site from the null enrichment proﬁle in the FPC space.
The null proﬁle included in χ serves to introduce a reference in the FPC space representing
non-enrichment (zero mapped tags). The higher the value of f 2
i , the higher the contribution

3

An Introduction to the NarrowPeaks Package:
Analysis of Transcription Factor Binding ChIP-seq Data using Functional PCA

of the site i to the total variability among the shapes of the functions in χ. Candidate peaks
are then ordered according to the value of f 2
i , which allows selecting the subset of those
presenting the majority of variation in the data. After that, a modiﬁed score ˜f 2
ih can be
optionally computed for each subpeak h = 1, . . . , H of a candidate site i by means of eq.(5),
using instead of γij(t) its trimmed version

˜γij(t) =

(cid:26) γij(t)
0

if t ∈ (Aih, Bih),
otherwise,

where (Aih, Bih) are the intervals in which

γi(t) =

P
(cid:88)

j=1

(cid:2)γij(t)(cid:3)2

≥ βT ,

βT =

(cid:16) T

(cid:17)

100

× max

t,i=1,...,n

(cid:8)γi(t)(cid:9),

6

7

8

where the narrowing threshold T ∈ [0, 100], and P is the number of principal components
accounting for at least α% of the total variation.
In practice, the subpeaks are split and
trimmed peaks from the initial list deﬁned in χ. Note that if narrowing threshold T = 0 the
input list is not modiﬁed, whereas if T = 100 just a single punctate source of variation would
be reported. Using T = 0 is also useful, as shape-based analyses reported by NarrowPeaks
can be combined with results obtained with other peak calling tools, thus providing additional
evidence of the peak calls [5], that can increase true positive rate [10].

3.2

Differential transcription factor binding analysis

Once conﬁdent and reproducible estimates of ChIP-seq peaks are determined for a set of
samples, the next question of interest in ChIP-seq data analysis is determining whether the
peak regions are bound by other TF, or by the same TF across w distinct time-, stress-
, or tissue-speciﬁc conditions, in z1, z2, . . . , zw sequenced samples (that have technical or
biological replications) [1]. In order to determine those regions of divergent ("variant") binding
for multiple treatments, we take as input a consensus list of aggregated peak regions, coming
from independent peak calls at each condition, and then apply FPCA for the normalized
read-enrichment signal of those regions across experiments. First, each genomic region for
a sample is represented as a linear combination of B-spline basis functions, then FPCA is
performed independently for each site across samples as in Equations (1-5) but discarding
the reference null proﬁle, i.e.:

f 2
i =

J
(cid:88)

j=1

s2
ij =

(cid:32) (cid:90)

J
(cid:88)

j=1

(cid:33)2

γij(t)dt

9

In order to detect pairwise diﬀerences between conditions, NarrowPeaks uses Hotelling’s T2
tests in the FPC space, with the number of components chosen to encapsulate at least α%
of variation. The chi-square approximation can be used in the Hotelling’s T2 test to relax the
assumption of data normality (test="chi" in HotellingsT2, R package ICSNP). To control
for multiple testing, p-values are corrected using the Benjamini-Hochberg adjustment. The
number of tested samples must be larger than the number of functional principal components
If there is no signiﬁcant diﬀerence (at a p-value cut-oﬀ) between the
considered (z > j).

4

An Introduction to the NarrowPeaks Package:
Analysis of Transcription Factor Binding ChIP-seq Data using Functional PCA

scores, then a chromosomal location is declared as being an "invariant binding event" in terms
of measured variability across conditions; if signiﬁcant diﬀerences between the FPC scores
are detected, then the site is declared as a "variant binding event" (see [5] for an application
of this method).

4

Example

We will use the example data set included in the NarrowPeaks package for this demonstration.
The data represents a small subset of a WIG ﬁle storing continuous value scores based on a
Poisson test [6] for the chromosome 1 of Arabidopsis thaliana [2].

First, we load the NarrowPeaks package and the data NarrowPeaks-dataset, which contains
a subsample of ﬁrst 49515 lines of the original WIG ﬁle for the full experiment. Using
the function wig2CSARScore a set of binary ﬁles is constructed storing the enrichment-score
proﬁles.

R> library(NarrowPeaks)

R> data("NarrowPeaks-dataset")
R> head(wigfile_test)

[1] "track type=wiggle_0 autoScale=on name=\"CSAR track\" description=\"CSAR track\""
[2] "variableStep

chrom=Chr1

span=1"

[3] "18732\t3.4"

[4] "18733\t3.4"

[5] "18734\t3.4"

[6] "18735\t3.4"

R> writeLines(wigfile_test, con="wigfile.wig")
R> wigScores <- wig2CSARScore(wigfilename="wigfile.wig", nbchr = 1, chrle=c(30427671))

READING [ wigfile.wig ] : done

-NB_Chr = 1
-Summary :

| Chr1 | 1 | 30427671 |

CREATING BINARY FILES [CSAR Bioconductor pkg format] :

- Chr1 : done

R> print(wigScores$infoscores$filenames)

[1] "Chr1_ChIPseq.CSARScore"

Next, the candidate binding site regions are extracted using the Bioconductor package CSAR
[6]. CSAR predictions are contiguous genomic regions separated by a maximum allowed of
g base pairs, and score enrichment values greater than t. Candidate regions are stored in a
GRanges object (see Bioconductor package GenomicRanges). Alternatively, ChIP-seq peaks
obtained using other peak-callers can be provided building an analogous GRanges object. In
this case, the metadata ’score’ must represent a numeric value directly proportional to the
conﬁdence of the peak (p-value) or the strength of the binding (fold-change).

R> library(CSAR)

R> candidates <- sigWin(experiment=wigScores$infoscores, t=1.0, g=30)

R> head(candidates)

GRanges object with 6 ranges and 2 metadata columns:

5

An Introduction to the NarrowPeaks Package:
Analysis of Transcription Factor Binding ChIP-seq Data using Functional PCA

seqnames

ranges strand |

posPeak

score

<Rle>

<IRanges>

<Rle> | <numeric> <numeric>

[1]

[2]

[3]

[4]

[5]

[6]

-------

Chr1 18732-19486

Chr1 20117-21252

Chr1 26477-26580

Chr1 27881-27890

Chr1 52613-52620

Chr1 52659-52665

* |
* |
* |
* |
* |
* |

19046

20691

26544

27881

52613

52659

38

50

4

3

3

3

seqinfo: 1 sequence from an unspecified genome

If CSAR [6] is used ﬁrst to analyze ChIP-seq data, from the results we can obtain the false
discovery rate (FDR) for a given threshold. For example, for the complete experiment de-
scribed in [2], t = 10.81 corresponds to FDR = 0.01 and t = 6.78 corresponds to FDR = 0.1.

Now we could narrow down the candidate sites with the function narrowpeaks to obtain
shortened peaks, representing each candidate signal as a linear combination of nbf B-spline
basis functions with no derivative penalization [8]. We can specify the amount of miminum
variance pv we want to describe in form of npcomp principal components, and establish a
cutoﬀ pmaxscor for trimming of scoring functions of the candidate sites.

We will run the function for three diﬀerent values of the cutoﬀ: pmaxscor = 0 (no cutoﬀ),
pmaxscor = 3 (cutoﬀ is at 3% level of the maximum value relative to the scoring PCA
functions) and pmaxscor = 100 (cutoﬀ is at the maximum value relative to the scoring PCA
functions).

R> shortpeaksP0 <- narrowpeaks(inputReg=candidates, scoresInfo=wigScores$infoscores, lmin=0, nbf=25,

rpenalty=0, nderiv=0, npcomp=2, pv=80, pmaxscor=0.0, ms=0)

R> head(shortpeaksP0$broadPeaks)

GRanges object with 6 ranges and 3 metadata columns:

seqnames

ranges strand |

max

average fpcaScore

<Rle>

<IRanges>

<Rle> | <integer> <numeric> <numeric>

[1]

[2]

[3]

[4]

[5]

[6]

-------

Chr1 18732-19486

Chr1 20117-21252

Chr1 26477-26580

Chr1 27881-27890

Chr1 52613-52620

Chr1 52659-52665

* |
* |
* |
* |
* |
* |

38

50

4

3

3

3

15.71 255256.46

15.91 421981.16

2.4

255.68

3

3

3

3.46

2.21

1.69

seqinfo: 1 sequence from an unspecified genome

R> head(shortpeaksP0$narrowPeaks)

GRanges object with 6 ranges and 4 metadata columns:

seqnames

ranges strand | broadPeak.subpeak trimmedScore narrowedDownTo

merged

[1]

[2]

[3]

[4]

[5]

[6]

<Rle>

<IRanges>

Chr1 18732-19486

Chr1 20117-21252

Chr1 26477-26580

Chr1 27881-27890

Chr1 52613-52620

Chr1 52659-52665

<Rle> |
* |
* |
* |
* |
* |
* |

-------

<character>

<numeric>

<character> <logical>

1.1

2.1

3.1

4.1

5.1

6.1

493.65

646.27

13.41

0.32

0.21

0.16

100%

100%

100%

100%

100%

100%

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

seqinfo: 1 sequence from an unspecified genome

6

An Introduction to the NarrowPeaks Package:
Analysis of Transcription Factor Binding ChIP-seq Data using Functional PCA

R> shortpeaksP3 <- narrowpeaks(inputReg=candidates, scoresInfo=wigScores$infoscores, lmin=0, nbf=25,

rpenalty=0, nderiv=0, npcomp=2, pv=80, pmaxscor=3.0, ms=0)

R> head(shortpeaksP3$broadPeaks)

GRanges object with 6 ranges and 3 metadata columns:

seqnames

ranges strand |

max

average fpcaScore

<Rle>

<IRanges>

<Rle> | <integer> <numeric> <numeric>

[1]

[2]

[3]

[4]

[5]

[6]

-------

Chr1 18732-19486

Chr1 20117-21252

Chr1 26477-26580

Chr1 27881-27890

Chr1 52613-52620

Chr1 52659-52665

* |
* |
* |
* |
* |
* |

38

50

4

3

3

3

15.71 255256.46

15.91 421981.16

2.4

255.68

3

3

3

3.46

2.21

1.69

seqinfo: 1 sequence from an unspecified genome

R> head(shortpeaksP3$narrowPeaks)

GRanges object with 6 ranges and 4 metadata columns:

seqnames

ranges strand | broadPeak.subpeak trimmedScore narrowedDownTo

merged

[1]

[2]

[3]

[4]

[5]

[6]

<Rle>

<IRanges>

Chr1

Chr1

Chr1

18996-19142

20590-20787

78229-78300

Chr1 188854-189165

Chr1 200838-200964

Chr1 300275-300450

<Rle> |
* |
* |
* |
* |
* |
* |

-------

<character>

<numeric>

<character> <logical>

1.1

2.1

20.1

35.1

40.1

56.1

249.61

422.45

98.98

602.76

202.38

272.69

19.47%

17.43%

9.47%

22.27%

25.87%

28.25%

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

seqinfo: 1 sequence from an unspecified genome

R> shortpeaksP100 <- narrowpeaks(inputReg=candidates, scoresInfo=wigScores$infoscores, lmin=0, nbf=25,

rpenalty=0, nderiv=0, npcomp=2, pv=80, pmaxscor=100, ms=0)

R> head(shortpeaksP100$broadPeaks)

GRanges object with 6 ranges and 3 metadata columns:

seqnames

ranges strand |

max

average fpcaScore

<Rle>

<IRanges>

<Rle> | <integer> <numeric> <numeric>

[1]

[2]

[3]

[4]

[5]

[6]

-------

Chr1 18732-19486

Chr1 20117-21252

Chr1 26477-26580

Chr1 27881-27890

Chr1 52613-52620

Chr1 52659-52665

* |
* |
* |
* |
* |
* |

38

50

4

3

3

3

15.71 255256.46

15.91 421981.16

2.4

255.68

3

3

3

3.46

2.21

1.69

seqinfo: 1 sequence from an unspecified genome

R> head(shortpeaksP100$narrowPeaks)

GRanges object with 1 range and 4 metadata columns:

seqnames

ranges strand | broadPeak.subpeak trimmedScore narrowedDownTo

merged

<Rle> <IRanges>

[1]

Chr1

725297

<Rle> |
* |

<character>

<numeric>

<character> <logical>

158.1

6.17

0.16%

FALSE

-------

seqinfo: 1 sequence from an unspecified genome

7

An Introduction to the NarrowPeaks Package:
Analysis of Transcription Factor Binding ChIP-seq Data using Functional PCA

As one can see, there is no diﬀerence between broadPeaks and narrowPeaks for pmaxscor =
0, whereas for pmaxscor = 100 just one punctual source of variation is reported. The number
of components (reqcomp) required, as well as the variance (pvar) achieved, are the same for
all three cases (pmaxscor of 0, 3 and 100). As our goal was to combine evidence ([1, 10]) of
peak calls provided by MACS [12] and NarrowPeaks, we used pmaxscor = 0 in [5].

R> print(shortpeaksP0$reqcomp)

[1] 1

R> print(shortpeaksP0$pvar)

[1] 80.3107

Now, we can do the same for pmaxscor = 90 and the result consists of 3 peaks very close to
each other. We can tune the parameter ms to merge the sites into a unique peak:

R> shortpeaksP90 <- narrowpeaks(inputReg=candidates,scoresInfo=wigScores$infoscores, lmin=0, nbf=25,

rpenalty=0, nderiv=0, npcomp=2, pv=80, pmaxscor=90, ms=0)

R> shortpeaksP90ms20 <- narrowpeaks(inputReg=candidates,scoresInfo=wigScores$infoscores, lmin=0, nbf=25,

rpenalty=0,nderiv=0, npcomp=2, pv=80, pmaxscor=90, ms=20)

We could make use of the class GRangesLists in the package GenomicRanges to create a
list:

R> library(GenomicRanges)

R> exampleMerge <- GRangesList("narrowpeaksP90"=shortpeaksP90$narrowPeaks,

"narrowpeaksP90ms20"=shortpeaksP90ms20$narrowPeaks);

R> exampleMerge

GRangesList object of length 2:

$narrowpeaksP90

GRanges object with 1 range and 4 metadata columns:

seqnames

ranges strand | broadPeak.subpeak trimmedScore narrowedDownTo

merged

<Rle>

<IRanges>

[1]

Chr1 725260-725327

<Rle> |
* |

<character>

<numeric>

<character> <logical>

158.1

413.67

10.76%

FALSE

$narrowpeaksP90ms20

GRanges object with 1 range and 4 metadata columns:

seqnames

ranges strand | broadPeak.subpeak trimmedScore narrowedDownTo merged

[1]

Chr1 725260-725327

* |

158.1

413.67

10.76%

FALSE

-------

seqinfo: 1 sequence from an unspecified genome

Finally, we can export GRanges objects or GRangesLists into WIG, bedGraph, bigWig or
other format ﬁles using the package rtracklayer . For example:

R> library(GenomicRanges)

R> names(elementMetadata(shortpeaksP3$broadPeaks))[3] <- "score"

R> names(elementMetadata(shortpeaksP3$narrowPeaks))[2] <- "score"

R> library(rtracklayer)

R> export.bedGraph(object=candidates, con="CSAR.bed")

R> export.bedGraph(object=shortpeaksP3$broadPeaks, con="broadPeaks.bed")

R> export.bedGraph(object=shortpeaksP3$narrowPeaks, con="narrowpeaks.bed")

8

An Introduction to the NarrowPeaks Package:
Analysis of Transcription Factor Binding ChIP-seq Data using Functional PCA

References

[1] Timothy Bailey, Pawel Krajewski, Istvan Ladunga, Celine Lefebvre, Qunhua Li, Liu Tao,
Pedro Madrigal, Cenny Taslim, and Jie Zhang. Practical guidelines for the comprehensive
analysis of chip-seq data. PLoS Computational Biology, 9(11):e1003326, 2013.

[2] Kerstin Kaufmann, Frank Wellmer, Jose Muino, Thilia Ferrier, Samuel Wuest, Vijaya Ku-
mar, Antonio Serrano-Mislata, Francisco Madueno, Pawel Krajewski, Elliot Meyerowitz,
Gerco Angenent, and Jose-Luis Riechmann. Orchestration of ﬂoral initiation by apetala1.
Science, 328:85–89, 2010.

[3] Teemu Laajala, Sunil Raghav, Soile Tuomela, Riitta Lahesmaa, Tero Aittokallio, and
Laura Elo. A practical comparison of methods for detecting transcription factor binding
sites in chip-seq experiments. BMC Genomics, 10(1):618, 2009.

[4] Pedro Madrigal and Pawel Krajewski. Uncovering correlated variability in epigenomic

datasets using the Karhunen-Loeve transform. BioData Mining, 8:20, 2015.

[5]

Julieta Mateos, Pedro Madrigal, Kenichi Tsuda, Vimal Rawat, Rene Richter, Maida
Romera-Branchat, Fabio Fornara, Korbinian Schneeberger, Pawel Krajewski, and George
Coupland. Combinatorial activities of SHORT VEGETATIVE PHASE and FLOWERING
LOCUS C deﬁne distinct modes of ﬂowering regulation in Arabidopsis. Genome Biol.,
16:31, 2015.

[6]

Jose Muino, Kerstin Kaufmann, Roeland van Ham, Gerco Angenent, and Pawel Kra-
jewski. Chip-seq analysis in r (csar): An r package for the statistical detection of
protein-bound genomic regions. Plant Methods, 7(1):11, 2011.

[7] Shirley Pepke, Barbara Wold, and Ali Mortazavi. Computation for chip-seq and rna-seq

studies. Nature Methods, 6:S22–S32, 2009.

[8]

Jim Ramsay and Bernard Silverman. Functional Data Analysis. Springer-Verlag, New
York, 2nd edition, 2005.

[9] Morten-Beck Rye, Pal Saetrom, and Finn Drablos. A manually curated chip-seq bench-
mark demonstrates room for improvement in current peak-ﬁnder programs. Nucleic
Acids Research, 39(4):e25, 2011.

[10] Christina Schweikert, Stuart Brown, Zuojian Tang, Phillip R Smith, and D. Frank Hsu.
Combining multiple ChIP-seq peak detection systems using combinatorial fusion. BMC
Genomics, 13 Suppl 8:S12, 2012.

[11] Elizabeth Wilbanks and Marc Facciotti. Evaluation of algorithm performance in chip-seq

peak detection. PLoS ONE, 5(7):e11471, 2010.

[12] Yong Zhang, Tao Liu, Cliﬀord A Meyer, Jerome Eeckhoute, David S Johnson, Bradley E
Bernstein, Chad Nusbaum, Richard M Myers, Myles Brown, Wei Li, and X Shirley Liu.
Model-based analysis of ChIP-Seq (MACS). Genome Biol., 9(9):R137, 2008.

9

An Introduction to the NarrowPeaks Package:
Analysis of Transcription Factor Binding ChIP-seq Data using Functional PCA

5

Details

This document was written using:

R> sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default

BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:
[1] LC_CTYPE=en_US.UTF-8
[4] LC_COLLATE=C
[7] LC_PAPER=en_US.UTF-8
[10] LC_TELEPHONE=C

attached base packages:

LC_NUMERIC=C
LC_MONETARY=en_US.UTF-8
LC_NAME=C
LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_TIME=en_US.UTF-8
LC_MESSAGES=en_US.UTF-8
LC_ADDRESS=C

[1] parallel

stats4

splines

stats

graphics

grDevices utils

datasets

methods

[10] base

other attached packages:
[1] rtracklayer_1.42.0
[5] IRanges_2.16.0

CSAR_1.34.0
S4Vectors_0.20.0

GenomicRanges_1.34.0 GenomeInfoDb_1.18.0
NarrowPeaks_1.26.0
BiocGenerics_0.28.0

loaded via a namespace (and not attached):
[1] ICSNP_1.1-1
[4] BiocManager_1.30.3
[7] tools_3.5.1
[10] evaluate_0.12
[13] DelayedArray_0.8.0
[16] GenomeInfoDbData_1.2.0
[19] Biostrings_2.50.0
[22] grid_3.5.1
[25] survival_2.43-1
[28] matrixStats_0.54.0
[31] htmltools_0.3.6
[34] BiocStyle_2.10.0

Rcpp_0.12.19
XVector_0.22.0
zlibbioc_1.28.0
lattice_0.20-35
yaml_2.2.0
fda_2.4.8
ICS_1.3-1
Biobase_2.42.0
BiocParallel_1.16.0
backports_1.1.2
GenomicAlignments_1.18.0
survey_3.34

compiler_3.5.1
bitops_1.0-6
digest_0.6.18
Matrix_1.2-14
mvtnorm_1.0-8
knitr_1.20
rprojroot_1.3-2
XML_3.98-1.16
rmarkdown_1.10
Rsamtools_1.34.0
SummarizedExperiment_1.12.0
RCurl_1.95-4.11

6

Acknowledgements

This work was supported by the EU Marie Curie Initial Training Network SYSFLO (agreement
number 237909).

10


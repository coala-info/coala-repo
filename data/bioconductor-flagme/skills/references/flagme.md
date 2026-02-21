flagme: Fragment-level analysis of
GC-MS-based metabolomics data

Mark Robinson
mrobinson@wehi.edu.au
Riccardo Romoli
riccardo.romoli@unifi.it

October 30, 2025

1

Introduction

This document gives a brief introduction to the flagme package, which is designed to process, visualise and sta-
tistically analyze sets of GC-MS samples. The ideas discussed here were originally designed with GC-MS-based
metabolomics in mind, but indeed some of the methods and visualizations could be useful for LC-MS data sets.
The fragment-level analysis though, takes advantage of the rich fragmentation patterns observed from electron
interaction (EI) ionization.

There are many aspects of data processing for GC-MS data. Generally, algorithms are run separately on each
sample to detect features, or peaks (e.g. AMDIS). Due to retention time shifts from run-to-run, an alignment
algorithm is employed to allow the matching of the same feature across multiple samples. Alternatively, if known
standards are introduced to the samples, retention indices can be computed for each peak and used for alignment.
After peaks are matched across all samples, further processing steps are employed to create a matrix of abundances,
leading into detecting differences in abundance.

Many of these data processing steps are prone to errors and they often tend to be black boxes. But, with effective
exploratory data analysis, many of the pitfalls can be avoided and any problems can be fixed before proceeding to
the downstream statistical analysis. The package provides various visualizations to ensure the methods applied are
not black boxes.

The flagme package gives a complete suite of methods to go through all common stages of data processing. In
addition, R is especially well suited to the downstream data analysis tasks since it is very rich in analysis tools and
has excellent visualization capabilities. In addition, it is freely available (www.r-project.org), extensible and there
is a growing community of users and developers. For routine analyses, graphical user interfaces could be designed.

2 Reading and visualizing GC-MS data

To run these examples, you must have the gcspikelite package installed. This data package contains several
GC-MS samples from a spike-in experiment we designed to interrogate data processing methods. So, first, we load
the packages:

To load the data and corresponding peak detection results, we simply create vectors of the file-names and create
a peakDataset object. Note that we can speed up the import time by setting the retention time range to a subset
of the elution, as below:

> gcmsPath <- paste(find.package("gcspikelite"), "data", sep="/")
> data(targets)
> cdfFiles <- paste(gcmsPath, targets$FileName, sep="/")

1

> eluFiles <- gsub("CDF", "ELU", cdfFiles)
> pd <- peaksDataset(cdfFiles, mz=seq(50,550), rtrange=c(7.5,8.5))

Reading
Reading
Reading
Reading
Reading
Reading
Reading
Reading
Reading

/home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_468.CDF
/home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_474.CDF
/home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_475.CDF
/home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_485.CDF
/home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_493.CDF
/home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_496.CDF
/home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_470.CDF
/home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_471.CDF
/home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_479.CDF

> pd <- addAMDISPeaks(pd, eluFiles)

Reading retention time range: 7.500133 8.499917
Reading /home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_468.ELU ... Done.
Reading /home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_474.ELU ... Done.
Reading /home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_475.ELU ... Done.
Reading /home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_485.ELU ... Done.
Reading /home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_493.ELU ... Done.
Reading /home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_496.ELU ... Done.
Reading /home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_470.ELU ... Done.
Reading /home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_471.ELU ... Done.
Reading /home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_479.ELU ... Done.

> pd

An object of class "peaksDataset"
9 samples: 0709_468 0709_474 0709_475 0709_485 0709_493 0709_496 0709_470 0709_471 0709_479
501 m/z bins - range: ( 50 550 )
scans: 175 175 175 175 175 174 175 175 175
peaks: 24 23 26 20 27 24 24 25 21

Here, we have added peaks from AMDIS, a well known and mature algorithm for deconvolution of GC-
MS data. For GC-TOF-MS data, we have implemented a parser for the ChromaTOF output (see the analogous
addChromaTOFPeaks function). The addXCMSPeaks allows to use all the XCMS peak-picking algorithms; using this
approach it is also possible to elaborate the raw data file from within R instead of using an external software. In
particular the function reads the raw data using XCMS, group each extracted ion according to their retention time
using CAMERA and attaches them to an already created peaksDataset object:

> pd.2 <- peaksDataset(cdfFiles[1:3], mz = seq(50, 550), rtrange = c(7.5, 8.5))

Reading
Reading
Reading

/home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_468.CDF
/home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_474.CDF
/home/biocbuild/bbs-3.22-bioc/R/site-library/gcspikelite/data/0709_475.CDF

> mfp <- xcms::MatchedFilterParam(fwhm = 10, snthresh = 5)
> pd.2 <- addXCMSPeaks(cdfFiles[1:3], pd.2, settings = mfp)

Start grouping after retention time.
Created 164 pseudospectra.
Start grouping after correlation.

2

Calculating peak correlations in 164 Groups...

% finished: 10

20

30

40 50

60

70 80

90

100

Calculating graph cross linking in 164 Groups...

% finished: 10

20

30

60

70 80

90

100

40 50
250

New number of ps-groups:
xsAnnotate has now 250 groups, instead of 164
Start grouping after retention time.
Created 153 pseudospectra.
Start grouping after correlation.

Calculating peak correlations in 153 Groups...

% finished: 10

20

30

40 50

60

70 80

90

100

Calculating graph cross linking in 153 Groups...

% finished: 10

20

30

60

70 80

90

100

40 50
245

New number of ps-groups:
xsAnnotate has now 245 groups, instead of 153
Start grouping after retention time.
Created 163 pseudospectra.
Start grouping after correlation.

Calculating peak correlations in 163 Groups...

% finished: 10

20

30

40 50

60

70 80

90

100

Calculating graph cross linking in 163 Groups...

% finished: 10

20

30

60

70 80

90

100

New number of ps-groups:
xsAnnotate has now 245 groups, instead of 163

40 50
245

> pd.2

An object of class "peaksDataset"
3 samples: 0709_468 0709_474 0709_475
418 m/z bins - range: ( 51 468 )
scans: 175 175 175
peaks: 47 45 44

The possibility to work using computer cluster will be added in the future.
Regardless of platform and peak detection algorithm, a useful visualization of a set of samples is the set of total

ion currents (TIC), or extracted ion currents (XICs). To view TICs, you can call:

> plotChrom(pd, rtrange=c(7.5,8.5), plotPeaks=TRUE, plotPeakLabels=TRUE,
+

max.near=8, how.near=0.5, col=rep(c("blue","red","black"), each=3))

Note here the little hashes represent the detected peaks and are labelled with an integer index. One of the main
challenges is to match these peak detections across several samples, given that the appear at slightly different times
in different runs.

For XICs, you need to give the indices (of pd@mz, the grid of mass-to-charge values) that you want to plot
through the mzind argument. This could be a single ion (e.g. mzind=24) or could be a range of indices if multiple
ions are of interest (e.g. mzind=c(24,25,98,99)).

3

There are several other features within the plot command on peaksDataset objects that can be useful. See

?plot (and select the flagme version) for full details.

Another useful visualization, at least for individual samples, is a 2D heatmap of intensity. Such plots can be
enlightening, especially when peak detection results are overlaid. For example (with detected fragment peaks from
AMDIS shown in white):

> r <- 1
> plotImage(pd, run=r, rtrange=c(7.5,8.5), main="")
> v <- which(pd@peaksdata[[r]] > 0, arr.ind=TRUE) # find detected peaks
> abline(v=pd@peaksrt[[r]])
> points(pd@peaksrt[[r]][v[,2]], pd@mz[v[,1]], pch=19, cex=.6, col="white")

3 Pairwise alignment with dynamic programming algorithm

One of the first challenges of GC-MS data is the matching of detected peaks (i.e. metabolites) across several samples.
Although gas chromatography is quite robust, there can be some drift in the elution time of the same analyte from
run to run. We have devised a strategy, based on dynamic programming, that takes into account both the similarity
in spectrum (at the apex of the called peak) and the similarity in retention time, without requiring the identity
of each peak; this matching uses the data alone.
If each sample gives a ‘peak list’ of the detected peaks (such
as that from AMDIS that we have attached to our peaksDataset object), the challenge is to introduce gaps into
these lists such that they are best aligned. From this a matrix of retention times or a matrix of peak abundances
can be extracted for further statistical analysis, visualization and interpretation. For this matching, we created a
procedure analogous to a multiple sequence alignment.

To highlight the dynamic programming-based alignment strategy, we first illustrate a pairwise alignment of two
peak lists. This example also illustrates the selection of parameters necessary for the alignment. From the data read
in previously, let us consider the alignment of two samples, denoted 0709_468 and 0709_474. First, a similarity
matrix for two samples is calculated. This is calculated based on a scoring function and takes into account the
similarity in retention time and in the similarity of the apex spectra, according to:

Sij(D) =

(cid:80)K

k=1 xikyjk
ik · (cid:80)K

k=1 x2

(cid:113)(cid:80)K

k=1 y2
jk

(cid:18)

· exp

−

(cid:19)

1
2

(ti − tj)2
D2

where i is the index of the peak in the first sample and j is the index of the peak in the second sample, xi and yj are
the spectra vectors and ti and tj are their respective retention times. As you can see, there are two components to
the similarity: spectra similarity (left term) and similarity in retention time (right term). Of course, other metrics
for spectra similarity are feasible. Ask the author if you want to see other metrices implemented. We have some
non-optimized code for a few alternative metrics.

The peak alignment algorithm, much like sequence alignments, requires a gap parameter to be set, here a number
between 0 and 1. A high gap penalty discourages gaps when matching the two lists of peaks and a low gap penalty
allows gaps at a very low cost. We find that a gap penalty in the middle range (0.4-0.6) works well for GC-MS peak
matching. Another parameter, D, modulates the impact of the difference in retention time penalty. A large value
for D essentially eliminates the effect. Generally, we set this parameter to be a bit larger than the average width of
a peak, allowing a little flexibility for retention time shifts between samples. Keep in mind the D parameter should
be set on the scale (i.e. seconds or minutes) of the peaksrt slot of the peaksDataset object. The next example
shows the effect of the gap and D penalty on the matching of a small ranges of peaks.

> Ds <- c(0.1, 10, 0.1, 0.1)
> gaps <- c(0.5, 0.5, 0.1, 0.9)
> par(mfrow=c(2,2), mai=c(0.8466,0.4806,0.4806,0.1486))
> for(i in 1:4){
+

pa <- peaksAlignment(pd@peaksdata[[1]], pd@peaksdata[[2]],

4

pd@peaksrt[[1]], pd@peaksrt[[2]], D=Ds[i],
gap=gaps[i], metric=1, type=1, compress = FALSE)

plotAlignment(pa, xlim=c(0, 17), ylim=c(0, 16), matchCol="yellow",

main=paste("D=", Ds[i], " gap=", gaps[i], sep=""))

+
+
+
+
+ }

Similarity= 0.2308905

[peaksAlignment] Comparing 24 peaks to 23 peaks -- gap= 0.5 D= 0.1 , metric= 1 , type= 1
[peaksAlignment] 21 matched.
[peaksAlignment] Comparing 24 peaks to 23 peaks -- gap= 0.5 D= 10 , metric= 1 , type= 1
[peaksAlignment] 21 matched.
[peaksAlignment] Comparing 24 peaks to 23 peaks -- gap= 0.1 D= 0.1 , metric= 1 , type= 1
[peaksAlignment] 15 matched.
[peaksAlignment] Comparing 24 peaks to 23 peaks -- gap= 0.9 D= 0.1 , metric= 1 , type= 1
[peaksAlignment] 22 matched.

Similarity= 0.01170268

Similarity= 0.2180835

Similarity= 0.2785359

You might ask: is the flagme package useful without peak detection results? Possibly. There have been some
developments in alignment (generally on LC-MS proteomics experiments) without peak/feature detection, such
as Prince et al. 2006, where a very similar dynamic programming is used for a pairwise alignment. We have
experimented with alignments without using the peaks, but do not have any convincing results. It does introduce a
new set of challenges in terms of highlighting differentially abundant metabolites. However, in the peaksAlignment
routine above (and those mentioned below), you can set usePeaks=FALSE in order to do scan-based alignments
instead of peak-based alignments. In addition, the flagme package may be useful simply for its bare-bones dynamic
programming algorithm.

3.1 Normalizing retention time score to drift estimates

In what is mentioned above for pairwise alignments, we are penalizing for differences in retention times that are
non-zero. But, as you can see from the TICs, some differences in retention time are consistent. For example, all
of the peaks from sample 0709_485 elute at later times than peaks from sample 0709_496. We should be able to
estimate this drift and normalize the time penalty to that estimate, instead of penalizing to zero. That is, we should
replace ti − tj with ti − tj − ˆdij where ˆdij is the expected drift between peak i of the first sample and peak j of the
second sample.

More details coming soon.

3.2

Imputing location of undetected peaks

One goal of the alignment leading into downstream data analyses is the generation of a table of abundances for each
metabolite across all samples. As you can see from the TICs above, there are some low intensity peaks that fall
below detection in some but not all samples. Our view is that instead of inserting arbitrary low constants (such as 0
or half the detection limit) or imputing the intensities post-hoc or having missing data in the data matrices, it is best
to return to the area of the where the peak should be and give some kind of abundance. The alignments themselves
are rich in information with respect to the location of undetected peaks. We feel this is a more conservative and
statistically valid approach than introducing arbitrary values.

More details coming soon.

4 Multiple alignment of several experimental groups

Next, we discuss the multiple alignment of peaks across many samples. With replicates, we typically do an alignment
within replicates, then combine these together into a summarized form. This cuts down on the computational cost.
For example, consider 2 sets of samples, each with 5 replicates. Aligning first within replicates requires 10+10+1
total alignments whereas an all-pairwise alignment requires 45 pairwise alignments. In addition, this allows some

5

flexibility in setting different gap and distance penalty parameters for the within alignment and between alignment.
An example follows.

> print(targets)

FileName Group
mmA
mmA
mmA
mmC
mmC
mmC
mmD
mmD
mmD

1 0709_468.CDF
2 0709_474.CDF
3 0709_475.CDF
4 0709_485.CDF
5 0709_493.CDF
6 0709_496.CDF
7 0709_470.CDF
8 0709_471.CDF
9 0709_479.CDF

> ma <- multipleAlignment(pd, group=targets$Group, wn.gap=0.5, wn.D=.05,
+
+

bw.gap=.6, bw.D=0.05, usePeaks=TRUE, filterMin=1,
df=50, verbose=FALSE, metric = 1, type = 1) # bug

Similarity= 0.2816753

[clusterAlignment] Aligning 0709_468 to 0709_474
[peaksAlignment] Comparing 24 peaks to 23 peaks -- gap= 0.5 D= 0.05 , metric= 1 , type= 1
[peaksAlignment] 22 matched.
[clusterAlignment] Aligning 0709_468 to 0709_475
[peaksAlignment] Comparing 24 peaks to 26 peaks -- gap= 0.5 D= 0.05 , metric= 1 , type= 1
[peaksAlignment] 20 matched.
[clusterAlignment] Aligning 0709_474 to 0709_475
[peaksAlignment] Comparing 23 peaks to 26 peaks -- gap= 0.5 D= 0.05 , metric= 1 , type= 1
[peaksAlignment] 20 matched.
[progressiveAlignment] Doing merge -1 -3
[progressiveAlignment] left.runs: 1 , right.runs: 3
[progressiveAlignment] Doing merge -2 1
[progressiveAlignment] left.runs: 2 , right.runs: 1 3
[progressiveAlignment] (dot=50) going to 23 :

Similarity= 0.1831043

Similarity= 0.1618763

used

(Mb) gc trigger

(Mb) max used

(Mb)
17271770 922.5 17271770 922.5
46840596 357.4 46840596 357.4

Similarity= 0.2221932

Ncells 11035778 589.4
Vcells 20770935 158.5
[clusterAlignment] Aligning 0709_485 to 0709_493
[peaksAlignment] Comparing 20 peaks to 27 peaks -- gap= 0.5 D= 0.05 , metric= 1 , type= 1
[peaksAlignment] 20 matched.
[clusterAlignment] Aligning 0709_485 to 0709_496
[peaksAlignment] Comparing 20 peaks to 24 peaks -- gap= 0.5 D= 0.05 , metric= 1 , type= 1
[peaksAlignment] 18 matched.
[clusterAlignment] Aligning 0709_493 to 0709_496
[peaksAlignment] Comparing 27 peaks to 24 peaks -- gap= 0.5 D= 0.05 , metric= 1 , type= 1
[peaksAlignment] 22 matched.
[progressiveAlignment] Doing merge -4 -6
[progressiveAlignment] left.runs: 4 , right.runs: 6
[progressiveAlignment] Doing merge -5 1
[progressiveAlignment] left.runs: 5 , right.runs: 4 6
[progressiveAlignment] (dot=50) going to 27 :

Similarity= 0.2047329

Similarity= 0.2446219

used

(Mb) gc trigger

(Mb) max used

(Mb)

6

Similarity= 0.2891437

17271770 922.5 17271770 922.5
46840596 357.4 46840596 357.4

Ncells 11035876 589.4
Vcells 20773837 158.5
[clusterAlignment] Aligning 0709_470 to 0709_471
[peaksAlignment] Comparing 24 peaks to 25 peaks -- gap= 0.5 D= 0.05 , metric= 1 , type= 1
[peaksAlignment] 23 matched.
[clusterAlignment] Aligning 0709_470 to 0709_479
[peaksAlignment] Comparing 24 peaks to 21 peaks -- gap= 0.5 D= 0.05 , metric= 1 , type= 1
[peaksAlignment] 18 matched.
[clusterAlignment] Aligning 0709_471 to 0709_479
[peaksAlignment] Comparing 25 peaks to 21 peaks -- gap= 0.5 D= 0.05 , metric= 1 , type= 1
[peaksAlignment] 20 matched.
[progressiveAlignment] Doing merge -8 -9
[progressiveAlignment] left.runs: 8 , right.runs: 9
[progressiveAlignment] Doing merge -7 1
[progressiveAlignment] left.runs: 7 , right.runs: 8 9
[progressiveAlignment] (dot=50) going to 24 :

Similarity= 0.1674945

Similarity= 0.165173

used

(Mb) gc trigger

(Mb) max used

(Mb)
17271770 922.5 17271770 922.5
46840596 357.4 46840596 357.4

Similarity= 0.3217042

Ncells 11036013 589.4
Vcells 20776586 158.6
[clusterAlignment] Aligning to
[peaksAlignment] Comparing 31 peaks to 29 peaks -- gap= 0.6 D= 0.05 , metric= 1 , type= 1
[peaksAlignment] 26 matched.
[clusterAlignment] Aligning to
[peaksAlignment] Comparing 31 peaks to 28 peaks -- gap= 0.6 D= 0.05 , metric= 1 , type= 1
[peaksAlignment] 26 matched.
[clusterAlignment] Aligning to
[peaksAlignment] Comparing 29 peaks to 28 peaks -- gap= 0.6 D= 0.05 , metric= 1 , type= 1
[peaksAlignment] 26 matched.
[progressiveAlignment] Doing merge -1 -3
[progressiveAlignment] left.runs: 1 , right.runs: 3
[progressiveAlignment] Doing merge -2 1
[progressiveAlignment] left.runs: 2 , right.runs: 1 3
[progressiveAlignment] (dot=50) going to 29 :

Similarity= 0.2240976

Similarity= 0.2825078

used

(Mb) gc trigger

(Mb) max used

(Mb)
17271770 922.5 17271770 922.5
46840596 357.4 46840596 357.4

Ncells 11036254 589.4
Vcells 20825376 158.9

> ma

An object of class "multipleAlignment"
3 groups: 3 3 3 samples, respectively.
35 merged peaks

If you set verbose=TRUE, many nitty-gritty details of the alignment procedure are given. Next, we can take the

alignment results and overlay it onto the TICs, allowing a visual inspection.

> plotChrom(pd, rtrange=c(7.5,8.5), runs=ma@betweenAlignment@runs,
+
+
+

mind=ma@betweenAlignment@ind, plotPeaks=TRUE,
plotPeakLabels=TRUE, max.near=8, how.near=.5,
col=rep(c("blue","red","black"), each=3))

> mp <- correlationAlignment(object=pd.2, thr=0.85, D=20, penality=0.2,
+
> mp

normalize=TRUE, minFilter=1)

7

4.1 Gathering results

The alignment results can be extracted from the multipleAlignment object as:

> ma@betweenAlignment@runs

[1] 5 4 6 2 1 3 7 8 9

> ma@betweenAlignment@ind

[,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
1
NA
2
3
NA
4
NA
5
NA
6
7
8
NA
9
10
11
12
NA
NA
13
14
15
NA
16
17
NA
18
19
NA
NA
NA
NA
20
NA
21

1
2
3
4
5
6
NA
7
8
9
NA
10
11
12
13
14
15
16
17
18
19
20
NA
21
NA
22
23
NA
24
NA
25
NA
26
NA
27

1
2
3
4
5
6
NA
7
NA
NA
8
9
NA
NA
NA
10
11
12
NA
13
14
15
16
17
18
NA
19
NA
20
21
22
NA
23
NA
24

1
NA
2
3
4
5
NA
6
NA
7
NA
8
NA
NA
9
NA
10
11
12
13
14
15
NA
16
17
18
19
20
21
NA
22
NA
23
NA
24

1
2
3
4
5
6
7
8
9
10
NA
11
NA
12
13
14
15
16
NA
NA
NA
17
NA
18
19
NA
20
NA
NA
21
22
NA
23
NA
24

1
2
3
4
5
6
NA
7
NA
8
NA
9
NA
10
11
12
13
14
NA
15
16
17
NA
18
19
NA
20
21
22
NA
23
NA
24
NA
25

1
2
3
4
NA
5
NA
6
7
8
NA
NA
NA
9
NA
10
11
12
NA
13
14
15
NA
16
17
18
19
NA
20
21
22
23
24
25
26

1
2
3
4
NA
5
6
7
8
9
NA
10
NA
11
NA
12
13
NA
NA
14
NA
15
16
17
18
NA
19
NA
20
NA
21
NA
22
NA
23

1
NA
2
3
NA
4
NA
5
6
7
NA
8
NA
NA
9
10
11
NA
NA
12
NA
13
NA
14
15
NA
16
NA
17
NA
18
NA
19
NA
20

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]
[7,]
[8,]
[9,]
[10,]
[11,]
[12,]
[13,]
[14,]
[15,]
[16,]
[17,]
[18,]
[19,]
[20,]
[21,]
[22,]
[23,]
[24,]
[25,]
[26,]
[27,]
[28,]
[29,]
[30,]
[31,]
[32,]
[33,]
[34,]
[35,]

This table would suggest that matched peak 8 (see numbers below the TICs in the figure above) corresponds to
detected peaks 9, 12, 11 in runs 4, 5, 6 and so on, same as shown in the above plot.

In addition, you can gather a list of all the merged peaks with the gatherInfo function, giving elements for
the retention times, the detected fragment ions and their intensities. The example below also shows the how to
construct a table of retention times of the matched peaks (No attempt is made here to adjust retention times onto
a common scale. Instead, the peaks are matched to each other on their original scale). For example:

8

> outList <- gatherInfo(pd,ma)
> outList[[8]]

$rt

mmC.5

mmD.8
7.694983 7.716883 7.694267 7.713550 7.708567 7.648733 7.702967 7.701717

mmA.1

mmA.2

mmC.4

mmA.3

mmC.6

mmD.7

mmD.9
7.713933

$mz

[1]

58 59

66

72 73

74

75

79 89 104 116 133 147 148 188 204

$data

0

0

0

9000

8067 7367

0 16656
5699
5475
5123

5740 4717
5633 4824
4909 3931

mmC.5 mmC.4 mmC.6 mmA.2 mmA.1 mmA.3 mmD.7 mmD.8 mmD.9
0
0 14648
4557 4728
4855
0
3354 4783
4831
0
3427 3907
4051
0
0 65912 52848 61560
0
6235 7088
0 28016 26304 27184
0
0 38712
0
3946 5659
5173
0 12852 9816 12492
4504 5201
0
0
2436 3893
0 21904 17896 22400
0
3335 3851
0 14731 10680 14061
5149 6830
0

0
[1,]
5113 4425
[2,]
3926 5146
[3,]
3680 3910
[4,]
[5,] 75336 69832 77784 61816 65680
[6,]
6705 6185
[7,] 29936 27440 29256 26376 23328
0
[8,]
5617 5347
[9,]
[10,] 15490 14203 17408 13173 13808
5525
[11,]
[12,]
3730
[13,] 24600 24296 28672 21864 20016
[14,]
3430
[15,] 17208 16208 18224 14433 14751
6667
[16,]

0
6213 5886

6447 5440
3583 3334

4473 4299

8053 7692

0
7266

7809
4461

5577
3599

5417
3539

4918

3006

8977

6935

6642

4413

6878

0

0

0

> rtmat <- matrix(unlist(lapply(outList,.subset,"rt"), use.names=FALSE),
+
> colnames(rtmat) <- names(outList[[1]]$rt); rownames(rtmat) <- 1:nrow(rtmat)
> round(rtmat, 3)

nr=length(outList), byrow=TRUE)

NA

NA

NA 7.586

NA 7.600

NA 7.559 7.549 7.557 7.543 7.547

mmC.5 mmC.4 mmC.6 mmA.2 mmA.1 mmA.3 mmD.7 mmD.8 mmD.9
7.512 7.534 7.506 7.531 7.526 7.540 7.520 7.519 7.531
7.535
NA
7.558 7.580 7.551 7.576 7.566 7.574 7.560 7.565 7.577
7.575 7.597 7.569 7.588 7.583 7.592 7.577 7.582 7.594
7.586
NA
7.615 7.614 7.614 7.616 7.617 7.614 7.617 7.610 7.617
NA
7.695 7.717 7.694 7.714 7.709 7.649 7.703 7.702 7.714
NA
NA
7.741 7.728
NA
NA 7.805 7.805
NA 7.817
NA 7.806
NA 7.812 7.816 7.823
NA
NA
NA
NA
NA
NA 7.907 7.874
NA 7.942 7.880 7.826
NA 7.936 7.943
NA
NA 7.943

1
2
3
4
5
6
7
8
9
NA 7.736 7.783 7.712
10 7.804 7.803 7.711 7.799 7.800 7.803
NA
NA
11
12 7.809 7.825 7.803 7.828 7.823
13 7.849
NA
14 7.946
15 7.958 7.946 7.951

NA 7.594 7.599

NA 7.691 7.663

NA
NA

NA

NA

NA

NA

NA

NA

NA

NA

9

NA

NA

NA

NA 8.182

NA 8.100

NA 8.003
NA 8.043

NA 7.976 7.966 7.975 7.966 7.965 7.977
16 7.969 7.974
17 7.986 8.008 7.980 7.999 7.994 7.997 7.989 7.993 8.000
NA
NA 8.011 8.009 8.012 8.010
18 8.009
NA
19 8.049
NA
NA
NA
NA
NA
NA 8.077 8.069 8.068 8.080
20 8.061 8.077 8.060 8.079
21 8.107
NA 8.095 8.086 8.085 8.091
NA
22 8.204 8.111 8.111 8.114 8.109 8.112 8.109 8.108 8.114
23
NA
24 8.244 8.254 8.237 8.251 8.246 8.249 8.246 8.245 8.251
NA 8.266 8.254 8.285 8.263 8.283 8.280 8.262 8.263
25
26 8.301
NA
27 8.324 8.334 8.323 8.337 8.332 8.335 8.326 8.330 8.337
NA
NA 8.342 8.400
28
NA
NA 8.357 8.360 8.359
NA
29 8.352 8.363 8.352 8.359
NA
30
NA
NA
NA
31 8.392 8.403 8.386 8.399 8.394 8.403 8.395 8.393
32
NA
NA
NA
33 8.432 8.437 8.432 8.434 8.434 8.437 8.435 8.433 8.440
34
NA
35 8.461 8.477 8.460 8.474 8.469 8.472 8.469 8.468 8.474

NA 8.360 8.375 8.377

NA 8.443

NA 8.420

NA 8.312

NA 8.329

NA 8.294

NA 8.172

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

NA

5 Future improvements and extension

There are many procedures that we have implemented in our investigation of GC-MS data, but have not made part
of the package just yet. Some of the most useful procedures will be released, such as:

1. Parsers for other peak detection algorithms (e.g. MzMine) and parsers for other alignment procedures (e.g.

SpectConnect) and perhaps retention indices procedures.

2. More convenient access to the alignment information and abundance table.

3. Statistical analysis of differential metabolite abundance.

4. Fragment-level analysis, an alternative method to summarize abundance across all detected fragments of a

metabolite peak.

6 References

See the following for further details:

1. Robinson MD. Methods for the analysis of gas chromatography - mass spectrometry data. Ph.D. Thesis. Oc-
tober 2008. Department of Medical Biology (Walter and Eliza Hall Institute of Medical Research), University
of Melbourne.

2. Robinson MD, De Souza DP, Keen WW, Saunders EC, McConville MJ, Speed TP, Likić VA. (2007) A dynamic
programming approach for the alignment of signal peaks in multiple gas chromatography-mass spectrometry
experiments. BMC Bioinformatics. 8:419.

3. Prince JT, Marcotte EM (2006) Chromatographic alignment of ESI-LC-MS proteomics data sets by ordered

bijective interpolated warping. Anal Chem. 78(17):6140-52.

10

7 This vignette was built with/at ...

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats

graphics

grDevices utils

datasets

methods

base

other attached packages:
[1] flagme_1.66.0
[4] BiocGenerics_0.56.0 generics_0.1.4
[7] BiocParallel_1.44.0 gcspikelite_1.47.0

CAMERA_1.66.0

Biobase_2.70.0
xcms_4.8.0

loaded via a namespace (and not attached):

[1] bitops_1.0-9
[3] RBGL_1.86.0
[5] rlang_1.1.6
[7] clue_0.3-66
[9] matrixStats_1.5.0

DBI_1.2.3
gridExtra_2.3
magrittr_2.0.4
MassSpecWavelet_1.76.0
compiler_4.5.1
reshape2_1.4.4
ProtGenerics_1.42.0
pkgconfig_2.0.3
crayon_1.5.3
XVector_0.50.0
rmarkdown_2.30
preprocessCore_1.72.0
xfun_0.53

[11] vctrs_0.6.5
[13] stringr_1.5.2
[15] fastmap_1.2.0
[17] MetaboCoreUtils_1.18.0
[19] backports_1.5.0
[21] caTools_1.18.3
[23] graph_1.88.0
[25] purrr_1.1.0
[27] MultiAssayExperiment_1.36.0 progress_1.2.3
parallel_4.5.1
[29] DelayedArray_0.36.0
cluster_2.1.8.1
[31] prettyunits_1.2.0
stringi_1.8.7
[33] R6_2.6.1
limma_3.66.0
[35] RColorBrewer_1.1-3
GenomicRanges_1.62.0
[37] rpart_4.1.24

11

[39] knitr_1.50
[41] Seqinfo_1.0.0
[43] iterators_1.0.14
[45] IRanges_2.44.0
[47] nnet_7.3-20
[49] igraph_2.2.1
[51] rstudioapi_0.17.1
[53] abind_1.4-8
[55] doParallel_1.0.17
[57] affy_1.88.0
[59] tibble_3.3.0
[61] S7_0.2.0
[63] foreign_0.8-90
[65] pillar_1.11.1
[67] BiocManager_1.30.26
[69] KernSmooth_2.23-26
[71] foreach_1.5.2
[73] MSnbase_2.36.0
[75] ncdf4_1.24
[77] hms_1.1.4
[79] scales_1.4.0
[81] gtools_3.9.5
[83] MsFeatures_1.18.0
[85] lazyeval_0.2.2
[87] mzID_1.48.0
[89] SparseM_1.84-2
[91] vsn_3.78.0
[93] fs_1.6.6
[95] grid_4.5.1
[97] tidyr_1.3.1
[99] MsCoreUtils_1.22.0

[101] htmlTable_2.4.3
[103] cli_3.6.5
[105] dplyr_1.1.4
[107] pcaMethods_2.2.0
[109] digest_0.6.37
[111] htmlwidgets_1.6.4
[113] htmltools_0.5.8.1
[115] statmod_1.5.1

> date()

[1] "Thu Oct 30 00:01:08 2025"

Rcpp_1.1.0
SummarizedExperiment_1.40.0
base64enc_0.1-3
BiocBaseUtils_1.12.0
Matrix_1.7-4
tidyselect_1.2.1
dichromat_2.0-0.1
gplots_3.2.0
codetools_0.2-20
lattice_0.22-7
plyr_1.8.9
evaluate_1.0.5
Spectra_1.20.0
affyio_1.80.0
MatrixGenerics_1.22.0
checkmate_2.3.3
stats4_4.5.1
MALDIquant_1.22.3
S4Vectors_0.48.0
ggplot2_4.0.0
MsExperiment_1.12.0
glue_1.8.0
Hmisc_5.2-4
tools_4.5.1
data.table_1.17.8
QFeatures_1.20.0
mzR_2.44.0
XML_3.99-0.19
impute_1.84.0
colorspace_2.1-2
PSMatch_1.14.0
Formula_1.2-5
S4Arrays_1.10.0
AnnotationFilter_1.34.0
gtable_0.3.6
SparseArray_1.10.0
farver_2.1.2
lifecycle_1.0.4
MASS_7.3-65

12


SimBindProﬁles: Similar Binding Proﬁles, identiﬁes
common and unique regions in array genome tiling array
data

Bettina Fischer

April 24, 2017

Contents

1 Introduction

2 Reading data and normalisation

3 Determining a bound cut-oﬀ and a diﬀerence cut-oﬀ

4 Setting array speciﬁc parameters

5 Performing pairwise classiﬁcation

6 Performing three-way classiﬁcation

7 Performing increased binding classiﬁcation

8 Performing compensation classiﬁcation

9 Concluding Remarks

1 Introduction

1

2

3

5

6

8

9

11

13

SimBindProﬁles identiﬁes common and unique binding regions in genome tiling array
data. This package does not rely on peak calling, but directly compares binding proﬁles
processed on the same array platform. It implements a simple threshold approach, thus

1

allowing retrieval of commonly and diﬀerentially bound regions between datasets as well
as events of compensation and increased binding.

The tool requires each data set in SGR ﬁle format, which are tab-delimited ﬁles with
chromosome, position and signal value columns. We suggest preprocessing two-colour
microarray data with Ringo [3] and Aﬀymetrix cel ﬁles with Starr [4], which perform
smoothing of probe intensities across replicate arrays for each data set. It is important
that data are sorted by chromosomes and ascending positions along each chromosome.

> library("SimBindProfiles")

2 Reading data and normalisation

We provide three working example data sets in this vignette. These data have been
processed on NimbleGen Drosophila melanogaster DM5 Tiling Set HX1 in triplicates
and smoothed into window scores using Ringo.

In Drosophila melanogaster, SoxNeuro (SoxN) and Dichaete (D) belong to the SoxB
family of transcription factors. SoxN and Dichaete play essential roles in many aspects
of neurogenesis and exhibit some degree of functional redundancy in cells where they
are coexpressed. Here, we study the binding patterns of SoxN and Dichaete in wildtype
(wt) and SoxN mutant embryos via DamID. In this vignette, we only use the probes
located on chromosome X between 1-6000000 bp:
SoxNDam = SoxN binding in wt embryos
SoxN-DDam = Dichaete binding in SoxN mutants
DDam = Dichaete binding in wt embryos

> dataPath <- system.file("extdata",package="SimBindProfiles")
> list.files(dataPath, pattern=".txt")

[1] "DDam_trunc.txt"

"SoxN-DDam_trunc.txt" "SoxNDam_trunc.txt"

> head(read.delim(paste(dataPath, "SoxNDam_trunc.txt", sep="/"),
+

header=FALSE, nrows=5))

V1 V2

V3
1 chrX 116 -1.218227
2 chrX 181 -1.116333
3 chrX 236 -1.081980
4 chrX 276 -1.116333
5 chrX 331 -1.116333

2

To read data into an ExpressionSet object each ﬁle name is speciﬁed omitting the .txt
extension. While reading the ﬁles, data is quantile normalised as per limma [2]. For
more details on ExpressionSet please refer to ”An Introduction to Bioconductor’s Ex-
pressionSet Class” [1].

> readTestSGR <- readSgrFiles(X=c("SoxNDam_trunc", "SoxN-DDam_trunc",
+

"DDam_trunc"), dataPath)

We continue in this vignette using the larger chromosome X probe set data which was
previously saved as SGR.Rdata object and can be loaded and viewed.

> dataPath <- system.file("data",package="SimBindProfiles")
> load(paste(dataPath, "SGR.RData", sep="/"))
> print(SGR)

ExpressionSet (storageMode: lockedEnvironment)
assayData: 98715 features, 3 samples

element names: exprs

protocolData: none
phenoData

sampleNames: SoxNDam SoxN-DDam DDam
varLabels: FileName tiling array
varMetadata: varLabel labelDescription

featureData

featureNames: 1 2 ... 98715 (98715 total)
fvarLabels: PROBE_ID CHR START
fvarMetadata: labelDescription

’

experimentData(object)

’

experimentData: use
Annotation:

A useful plot comparing all the data sets and their correlation after normalisation can
be created with the eSetScatterPlot function (Figure 1).

> eSetScatterPlot(SGR)

3 Determining a bound cut-oﬀ and a diﬀerence cut-oﬀ

In order to identify probes or regions, which are bound similarly or diﬀerentially bound
between the data sets, bound.cutoff and diff.cutoff (diﬀerence cut-oﬀ) thresholds
have to be chosen.

We implemented two methods to set the bound cut-oﬀ, probes above this threshold are
considered ”bound”. The twoGaussiansNull method established in the Ringo package

3

Figure 1: Smoothed scatterplots of normalised signals and the corresponding correlations.

[3], in which data is assumed to follow a mixture of two Gaussian distributions. The
Gaussian with the lower mean value is assumed to be the null distribution and probe
levels are assigned p-values based on this null distribution. Alternatively the user can
select the normalNull method which assumes the null distribution is normal and sym-
metrical around the mode or zero. For both methods the user can decide if the resulting
p-values are to be adjusted for multiple testing (fdr) or select a p-value threshold.

In our example we use the twoGaussiansNull at 25% FDR, the function also provides a
QC plot of the two Gaussians curves and an optional p-value histogram (not shown).

> bound.cutoff <- findBoundCutoff(SGR, method="twoGaussiansNull", fdr=0.25)

Using bound.cutoff = 2.05

To show the bound.cutoff in relation to the data one can plot a histogram of the data
with the bound cutoﬀ (Figure 2).

> hist(exprs(SGR)[,1], breaks=1000, freq=FALSE, border="grey",
+
+
> abline(v=bound.cutoff, col="red", lty=3, lwd=2)

main=sampleNames(SGR)[1], xlab="signal",
sub=paste("bound.cutoff =", bound.cutoff, sep=" "))

A probe is considered uniquely bound in one data set if it is bound above the diff.cutoff
threshold to the other set. We propose that the diﬀerence cut-oﬀ should be smaller than
the bound cut-oﬀ, but for more stringent analysis criteria it can also be set to the same
value as the bound.cutoff.

In our example we used the diﬀ.cutoﬀ as 75% of the bound.cutoff

4

Figure 2: Histogram of the signal of SoxNDam. Probes with a signal above the
bound.cutoﬀ threshold are considered ”bound”.

> diff.cutoff <- round(bound.cutoff * 0.75,2)

We can plot the probe intensities along parts of the chromosome using the chipA-
longChrom function from Ringo, which can be called via the plot command. First we
create a probeAnno class object which contains the mapping between the probes and
their genomic positions and uses the information stored in the ExpressionSet object
and requires the probe length of the oligo on the array. In Figure 3 SoxNDam (green
curve) is uniquely bound at region 2324000 - 2326000 as the intensity is above the
bound.cutoﬀ. Whereas SoxN-DDam (orange) is also above the bound.cutoﬀ at region
2334000 - 2336000 but the diﬀerence in the intensity of SoxNDam is too small (below
diﬀ.cutoﬀ) to call this region uniquely bound.

> probeAnno <- probeAnnoFromESet(SGR, probeLength=50)

> plot(SGR, probeAnno, chrom="X", xlim=c(2323000,2337000), ylim=c(-3,4),
+

samples=c(1,2))

4 Setting array speciﬁc parameters

The user has to specify the probes and probe.max.spacing parameters. Both depend
on the array platform and how densely the probes are spaced across the genome on the
tiling array. The minimum number of probes speciﬁes how many probes have to be in
a valid region. The probe.max.spacing is the maximum distance in base pairs allowed
between probes before a region is split into separate regions.

5

Figure 3: Probe intensities along chromosome, green = SoxNDam, orange = SoxN-
DDam.

> probes <- 10
> probe.max.spacing <- 200

A frequency plot of number of probes per bound regions can be used to help determine
the probes parameter selection

> probeLengthPlot(SGR, sgrset=1, chr=NULL, bound.cutoff, probe.max.spacing=200,
+

xlim.max=25)

5 Performing pairwise classiﬁcation

In this section we identify regions that are uniquely or commonly bound in two data
sets. First the probes for each data set are ﬂagged as bound or not bound depending
on whether the signal is above the bound.cutoff. Then the probes are split into three
classes:
Class 1: uniquely bound in set 1 (bound in set 1, not bound in set 2, signal 1 minus
signal 2 above diﬀ.cutoﬀ).
Class 2: uniquely bound in set 2 (bound in set 2, not bound in set 1, signal 2 minus
signal 1 above diﬀ.cutoﬀ)
Class 3: bound in both data sets
Then the classiﬁed probes are ﬁltered into regions using the probes and probe.max.spacing
parameters. The regions for each class are exported to bed ﬁles, which provide the chro-
mosome, start and end positions, the name and a score for the region. For example the
score for class 1 is calculated as follows. First we subtract for each probe within a region

6

−3−2−101234Fold change [log]llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll232300023240002325000232600023270002328000232900023300002331000233200023330002334000233500023360002337000Chromosome X coordinate [bp]Figure 4: Frequency plot of number of probes per bound region.

signal set 1 minus signal set 2, and then we calculate the mean over the region. The tool
uses the names of each data set and the selected parameters as the resulting ﬁle names
(b = bound.cutoﬀ, d = diﬀ.cutoﬀ, v = probes, g = probe.max.spacing).

In our example we query SoxNDam vs. DDam, which correspond to data set 1 and 3 in
the ExpessionSet object.

> pairwiseR <- pairwiseRegions(SGR, sgrset=c(1,3), bound.cutoff,
+

diff.cutoff, probes, probe.max.spacing)

Pairwise comparison of SoxNDam vs DDam

Filter data into regions...
Writing SoxNDam.vs.DDam.unique_b2.05d1.54v10g200.bed ,regions = 67 ...
Writing DDam.vs.SoxNDam.unique_b2.05d1.54v10g200.bed ,regions = 51 ...
Writing SoxNDam.DDam.common_b2.05d1.54v10g200.bed ,regions = 43 ...

> head(pairwiseR)

name class.group chr start

end

1 SoxNDam.unique
2 SoxNDam.unique

1 chrX 424668 426418 3.142840
1 chrX 436708 437593 2.278542

score nProbes
33
17

7

05102030SoxNDam with bound.cutoff = 2.05nProbesFrequency1357911131517192123253 SoxNDam.unique
4 SoxNDam.unique
5 SoxNDam.unique
6 SoxNDam.unique

1 chrX 761106 762136 2.255283
1 chrX 789430 792565 3.177630
1 chrX 900082 900792 1.770974
1 chrX 901237 901727 1.896931

20
58
14
10

We also provide a ploting method to show the bound probes (before ﬁltering into regions)
in colour.

> plotBoundProbes(SGR, sgrset=c(1,2), method="pairwise", bound.cutoff,
+

diff.cutoff)

Figure 5: Scatterplot of pairwise classiﬁcation of SoxNDam vs. DDam. Red highlights
the unique SoxNDam probes, green unique in DDam and grey are probes common to
both.

6 Performing three-way classiﬁcation

This tool allows identiﬁcation of regions that are unique or common in three data sets.
The approach is the same as for the pairwise classiﬁcation. The probes are segregated
into seven classes:
Class = 1: unique probes in set 1
Class = 2: unique probes in set 2
Class = 3: unique probes in set 3
Class = 4: common probes in set 1+2
Class = 5: common probes in set 2+3
Class = 6: common probes in set 1+3
Class = 7: common probes in set 1+2+3
Then the probes are again ﬁltered into regions using the probes and probe.max.spacing

8

parameters. The regions for each class are exported to bed ﬁles. The score is calculated
similar to the pair-wise classiﬁcation.

In our example we query SoxNDam vs. SoxN-DDam vs. DDam (results not shown).

> threewayR <- threewayRegions(SGR, sgrset=c(1,2,3), bound.cutoff,
+

diff.cutoff, probes, probe.max.spacing)

7 Performing increased binding classiﬁcation

It might be of interest to identify regions showing increased binding, which are more
bound in one dataset compared to the other. In our example, Dichaete can bind at a
higher level in the SoxN mutant embryos (SoxN-DDam) compared to the wt embryos
(DDam) (Figure 6). If the signal of a bound probe in set 1 is higher than the diﬀ.cutoﬀ,
then these probes are ﬁltered into regions using the probes and probe.max.spacing
parameters and reported as bed ﬁle, which reports the chromosome, start, end, name
and score. The score is calculated similarly to the pairwise classiﬁcation.

Compare set SoxN-DDam vs. DDam

> increasedR <- increasedBindingRegions(SGR, sgrset=c(2,3), bound.cutoff, diff.cutoff,
+
> head(increasedR)

probes, probe.max.spacing)

1 SoxN-DDam.increasedBinding
2 SoxN-DDam.increasedBinding

name class.group chr

start

end

1 chrX 2217665 2218265 2.352285
1 chrX 4590918 4591908 1.671484

score nProbes
12
18

Visualise the second increased binding region in genomic context.

> plot(SGR, probeAnno, chrom="X", xlim=c(4589000,4593200), ylim=c(-0.5,5),
+

samples=c(2,3))

To plot the probes showing increased binding (before ﬁltering into regions) in colour
(Figure 7).

> plotBoundProbes(SGR, sgrset=c(2,3), method="increasedBinding", bound.cutoff,
+

diff.cutoff, pcex=4)

9

Figure 6: Probe intensities along chromosome at increased binding region, green = SoxN-
DDam, orange = DDam.

Figure 7: Scatterplot of increased binding classiﬁcation of SoxNDam vs. DDam, in-
creased binding probes are highlighted in blue

10

012345Fold change [log]llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll45890004590000459100045920004593000Chromosome X coordinate [bp]8 Performing compensation classiﬁcation

This is another special case in which we want to identify regions which are bound in
two sets but not in the third. In our example, in wt embryos Dichaete is not bound
(DDam) and SoxN is bound (SoxNDam). However, in SoxN mutants (SoxN-DDam)
Dichaete binds at this location to compensate for the loss of SoxN (Figure 8). Probes
above the bound.cutoﬀ for which the average bound signal of set 1 and set 2 are larger
than the diﬀ.cutoﬀ to the non-bound set 3 are identiﬁed. The probes are again ﬁltered
into regions using the probes and probe.max.spacing parameters and reported in a
bed ﬁle, which gives the chromosome, start, end, name and score.

Compare set SoxNDam + SoxN-DDam vs. DDam

> compR <- compensationRegions(SGR, sgrset=c(1,2,3), bound.cutoff,
+
> head(compR)

diff.cutoff, probes, probe.max.spacing)

name class.group chr

end
start
1 chrX 1512681 1513656
1 chrX 2411543 2413073
1 chrX 2456797 2457742
1 chrX 2944219 2945314
1 chrX 3616693 3617308

1 SoxNDam.SoxN-DDam.vs.DDam.compensation
2 SoxNDam.SoxN-DDam.vs.DDam.compensation
3 SoxNDam.SoxN-DDam.vs.DDam.compensation
4 SoxNDam.SoxN-DDam.vs.DDam.compensation
5 SoxNDam.SoxN-DDam.vs.DDam.compensation

score nProbes
19
29
18
21
12

1 1.900121
2 2.508937
3 2.880944
4 2.701074
5 2.243366

Visualise a compensation region in genomic context (Figure 8).

> plot(SGR, probeAnno, chrom="X", xlim=c(2943000,2947000), ylim=c(-1,4))

To plot the probes showing compensation (before ﬁltering into regions) in colour (Fig-
ure 9).

> plotBoundProbes(SGR, sgrset=c(1,2,3), method="compensation", bound.cutoff,
+

diff.cutoff, pcex=4)

11

Figure 8: Probe intensities along chromosome, green = SoxN-DDam, orange = SoxN-
DDam, blue = DDam.

Figure 9: Scatterplot of compensation classiﬁcation of SoxNDam + SoxN-DDam vs.
DDam. Probes which are bound in SoxNDam + SoxN-DDam but not in DDAm are
highlighted in orange.

12

−101234Fold change [log]lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllSoxNDamSoxN−DDamDDam29430002944000294500029460002947000Chromosome X coordinate [bp]9 Concluding Remarks

The package SimBindProﬁles facilitates the comparison of ChIP-chip or DamID proﬁles
generated on the same microarray platform.
It provides functions for data import,
normalization and analysis. High-level plots for quality assessment are available. While
this analysis approach worked well with our data, we do not claim it is the deﬁnite
algorithm for this task.

This vignette was generated using the following package versions:

(cid:136) R version 3.4.0 (2017-04-21), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8,
LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.2 LTS

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so

(cid:136) LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, grid, methods, parallel, stats,

utils

(cid:136) Other packages: Biobase 2.36.0, BiocGenerics 0.22.0, Matrix 1.2-9,

RColorBrewer 1.1-2, Ringo 1.40.0, SimBindProﬁles 1.14.0, lattice 0.20-35,
limma 3.32.0

(cid:136) Loaded via a namespace (and not attached): AnnotationDbi 1.38.0,
BiocInstaller 1.26.0, DBI 0.6-1, IRanges 2.10.0, KernSmooth 2.23-15,
RCurl 1.95-4.8, RSQLite 1.1-2, Rcpp 0.12.10, S4Vectors 0.14.0, XML 3.98-1.6,
aﬀy 1.54.0, aﬀyio 1.46.0, annotate 1.54.0, bitops 1.0-6, colorspace 1.3-2,
compiler 3.4.0, digest 0.6.12, geneﬁlter 1.58.0, ggplot2 2.2.1, gtable 0.2.0,
lazyeval 0.2.0, mclust 5.2.3, memoise 1.1.0, munsell 0.4.3, plyr 1.8.4,
preprocessCore 1.38.0, scales 0.4.1, splines 3.4.0, stats4 3.4.0, survival 2.41-3,
tibble 1.3.0, tools 3.4.0, vsn 3.44.0, xtable 1.8-2, zlibbioc 1.22.0

Acknowledgments

Many thanks to Enrico Ferrero who generated the data sets and our conductive discus-
sions about the analysis approach, Steven Russell for helpful suggestions and Robert
Stojnic for source code contributions to SimBindProﬁles.

13

References

[1] S. Falcon, M. Morgan, and R. Gentleman. An Introduction to Bioconductor’s
http://wiki.biostat.berkeley.edu/˜bullard/courses/Tmexico-

ExpressionSet Class.
08/resources/ExpressionSetIntroduction.pdf, February 2007.

[2] G. K. Smyth. Limma: linear models for microarray data. In R. Gentleman, V. Carey,
W. Huber, R. Irizarry, and S. Dudoit, editors, Bioinformatics and Computational
Biology Solutions Using R and Bioconductor, pages 397–420. Springer, 2005.

[3] J. Toedling, O. Sklyar, T. Krueger, J. J. Fischer, S. Sperling, and W. Huber. Ringo -
an R/Bioconductor package for analyzing ChIP-chip readouts. BMC Bioinformatics,
8:221, 2007.

[4] B. Zacher, J. Soeding, P. F. Kuan, M. Siebert, and A. Tresch. Starr: Simple tiling

array analysis of Aﬀymetrix ChIP-chip data, 2009. R package version 1.14.1.

14


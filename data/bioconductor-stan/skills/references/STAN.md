The genomic STate ANnotation package

Benedikt Zacher1,2,∗, Julia Ertl1, Julien Gagneur1, Achim
Tresch1,2,3

[1em] 1 Gene Center and Department of Biochemistry, LMU, Munich, Germany
2 Institute for Genetics, University of Cologne, Cologne, Germany
3 Max Planck Institute for Plant Breeding Research, Cologne, Germany

∗

zacher (at) genzentrum.lmu.de

October 30, 2017

If you use STAN in published research, please cite:

Zacher, B. and Lidschreiber, M. and Cramer, P. and Gagneur, J. and Tresch, A. (2014):
Annotation of genomics data using bidirectional hidden Markov models unveils
variations in Pol II transcription cycle Mol. Syst. Biol. 10:768

Contents

1

2

3

4

5

Quick start .

.

Introduction .

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

Genomic state annotation of Roadmap Epigenomics Sequenc-
ing data .
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

2

2

3

Integrating strand-speciﬁc and non-strand-speciﬁc data with STAN
11

Concluding Remarks .

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

14

The genomic STate ANnotation package

1

Quick start

## Loading library and data

library(STAN)

data(trainRegions)

data(pilot.hg19)

## Model initialization
hmm_nb = initHMM(trainRegions[1:3], nStates=10, "NegativeBinomial")

## Model fitting
hmm_fitted_nb = fitHMM(trainRegions[1:3], hmm_nb, maxIters=10)

## Calculate state path
viterbi_nb = getViterbi(hmm_fitted_nb, trainRegions[1:3])

## Convert state path to GRanges object
viterbi_nb_gm12878 = viterbi2GRanges(viterbi_nb, pilot.hg19, 200)

2

Introduction

Genome segmentation with hidden Markov models has become a useful tool to annotate
genomic elements, such as promoters and enhancers by data integration. STAN (genomic
STate ANnotation) implements (bidirectional) Hidden Markov Models (HMMs) using a va-
riety of diﬀerent probability distributions, which can be used to model a wide range of current
genomic data:

• Multivariate gaussian: e.g. conutinuous microarray and transformed sequencing data.

• Poisson: e.g. discrete count data from sequencing experiments.

• (Zero-Inﬂated) Negative Binomial: e.g. discrete count data from sequencing experi-

ments.

• Poisson Log-Normal: e.g. discrete count data from sequencing experiments.

• Negative Multinomial: e.g. discrete count data from sequencing experiments.

• Multinomial: e.g. methylation rates from bisulﬁte sequencing (in this case it reduces

to a Binomial) or binned nuceotide frequencies.

• Bernoulli:

Initially proposed by [1] to model presence/absence of chromatin marks

(another example: transcription factor binding).

• Nucleotide distribution: e.g. nucleotide frequencies in the DNA sequence.

The use of these distributions enables integrating a wide range of genomic data types (e.g.
continuous, discrete, binary) to de novo learn and annotate the genome into a given number
of ’genomic states’. The ’genomic states’ may for instance reﬂect distinct genome-associated
protein complexes or describe recurring patterns of chromatin features, i.e. the ’chromatin
state’. Unlike other tools, STAN also allows for the integration of strand-speciﬁc (e.g. RNA)
and non-strand-speciﬁc data (e.g. ChIP) [2]. In this vignette, we illustrate the use of STAN

2

The genomic STate ANnotation package

by inferring ’chromatin states’ from a small example data set of two Roadmap Epigenomics
cell lines. Moreover, we show how to use strand-speciﬁc RNA expression with non-strand-
speciﬁc ChIP data to infer ’transcription states’ in yeast. Before getting started the package
needs to be loaded:

library(STAN)

3

Genomic state annotation of Roadmap Epigenomics
Sequencing data

The data (or observations) provided to STAN may consist of one or more observation se-
quences (e.g. chromosomes), which are contained in a list of (position x experiment) matri-
ces. trainRegions is a list containing one three ENCODE pilot regions (stored in pilot.hg19
as GRanges object) with data for two cell types (K562: E123, Gm12878: E116) from the
Roadmap Epigenomics project. The data set contains ChIP-Seq experiments of seven his-
tone modiﬁcations (H3K4me1, H3K4me3, H3K36me3, H3K27me3, H3K27ac and H3K9ac),
as well as DNase-Seq and genomic input.

data(trainRegions)

names(trainRegions)

## [1] "E116.chr1.ENr231" "E116.chr10.ENr114" "E116.chr11.ENm011"

## [4] "E123.chr1.ENr231" "E123.chr10.ENr114" "E123.chr11.ENm011"

str(trainRegions[c(1,4)])

## List of 2

##

##

##

##

##

##

##

##

$ E116.chr1.ENr231: num [1:2500, 1:9] 2 4 2 0 1 1 4 4 2 14 ...

..- attr(*, "dimnames")=List of 2
.. ..$ : NULL

.. ..$ : chr [1:9] "H3K4me1" "H3K4me3" "H3K36me3" "H3K27me3" ...

$ E123.chr1.ENr231: num [1:2500, 1:9] 2 1 5 0 1 3 8 8 7 12 ...

..- attr(*, "dimnames")=List of 2
.. ..$ : NULL

.. ..$ : chr [1:9] "H3K4me1" "H3K4me3" "H3K36me3" "H3K27me3" ...

The genomic regions for each cell type in trainRegions are stored as a GRanges object in
pilot.hg19:

data(pilot.hg19)

pilot.hg19

## GRanges object with 3 ranges and 1 metadata column:

##

##

##

##

##

##

##

seqnames

<Rle>

ranges strand |

name

<IRanges>

<Rle> | <character>

[1]

[2]

[3]

chr1 [151158001, 151658000]

chr10 [ 55483801, 55983800]

chr11 [ 1743401,

2349400]

* |
* |
* |

ENr231

ENr114

ENm011

-------

seqinfo: 21 sequences from an unspecified genome; no seqlengths

3

The genomic STate ANnotation package

Before model ﬁtting, we calculate size factors to correct for the diﬀerent diﬀerent sequencing
depths between cell lines.

celltypes = list("E123"=grep("E123", names(trainRegions)),

"E116"=grep("E116", names(trainRegions)))

sizeFactors = getSizeFactors(trainRegions, celltypes)

sizeFactors

##

H3K4me1

H3K4me3 H3K36me3 H3K27me3

H3K9me3

H3K27ac

H3K9ac

## E123 1.055900 0.9104679 0.9397551 0.946867 1.2351436 1.112482 1.2326048

## E123 1.055900 0.9104679 0.9397551 0.946867 1.2351436 1.112482 1.2326048

## E123 1.055900 0.9104679 0.9397551 0.946867 1.2351436 1.112482 1.2326048

## E116 0.949721 1.1090610 1.0684983 1.059451 0.8400696 0.908175 0.8412481

## E116 0.949721 1.1090610 1.0684983 1.059451 0.8400696 0.908175 0.8412481

## E116 0.949721 1.1090610 1.0684983 1.059451 0.8400696 0.908175 0.8412481

##

DNase

Input

## E123 0.9252687 1.2844840

## E123 0.9252687 1.2844840

## E123 0.9252687 1.2844840

## E116 1.0878636 0.8186808

## E116 1.0878636 0.8186808

## E116 1.0878636 0.8186808

Genome segmentation is carried out in STAN using three functions: initHMM, fitHMM and
getViterbi. initHMM initializes a model with nStates states for a given probability/emission
distribution, which we set to ’PoissonLogNormal’ in this example. fitHMM then optimizes
model parameters using the Expectation-Maximization algorithm. Model parameters can be
accessed with the EmissionParams function. Note that in this example, we set the maximal
number of iteration to 10 in this case for speed reason. To ensure convergence this number
should be higher in real world applications. After HMM ﬁtting, the state annotation is
calculated using the getViterbi function.

nStates = 10
hmm_poilog = initHMM(trainRegions, nStates, "PoissonLogNormal", sizeFactors)
hmm_fitted_poilog = fitHMM(trainRegions, hmm_poilog, sizeFactors=sizeFactors, maxIters=10)
## [1] "I am in JointlyInd"

## [1] 6

## [[1]]

## An object of class "HMMEmission"

##

##

type: JointlyIndependent

dim: 9

nStates: 10

##
viterbi_poilog = getViterbi(hmm_fitted_poilog, trainRegions, sizeFactors)
str(viterbi_poilog)
## List of 6

##

##

##

##

##

##

$ E116.chr1.ENr231 : Factor w/ 10 levels "1","2","3","4",..: 6 6 6 6 6 6 1 1 1 1 ...

$ E116.chr10.ENr114: Factor w/ 10 levels "1","2","3","4",..: 10 10 10 10 10 10 10 10 10 10 ...

$ E116.chr11.ENm011: Factor w/ 10 levels "1","2","3","4",..: 10 10 10 10 10 10 10 10 10 10 ...

$ E123.chr1.ENr231 : Factor w/ 10 levels "1","2","3","4",..: 6 6 6 6 6 6 2 2 2 2 ...

$ E123.chr10.ENr114: Factor w/ 10 levels "1","2","3","4",..: 10 10 10 10 10 10 10 10 10 10 ...

$ E123.chr11.ENm011: Factor w/ 10 levels "1","2","3","4",..: 10 10 10 10 10 10 10 10 10 10 ...

4

The genomic STate ANnotation package

In order to ease the use of other genomic applications and Bioconductor packages, the viterbi
path can be converted into a GRanges object.

viterbi_poilog_gm12878 = viterbi2GRanges(viterbi_poilog[1:3], regions=pilot.hg19, binSize=200)
viterbi_poilog_gm12878
## GRanges object with 381 ranges and 1 metadata column:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames

<Rle>

ranges strand |

name

<IRanges>

<Rle> | <character>

[1]

[2]

[3]

[4]

[5]

...

[377]

[378]

[379]

[380]

[381]

-------

chr1 [151158001, 151159201]

chr1 [151159201, 151160801]

chr1 [151160801, 151161001]

chr1 [151161001, 151161601]

chr1 [151161601, 151162801]

...

chr11

chr11

chr11

chr11

chr11

...

[2324601, 2326601]

[2326601, 2327601]

[2327601, 2328001]

[2328001, 2328201]

[2328201, 2349401]

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

6

1

2

3

4

...

10

1

2

1

10

seqinfo: 3 sequences from an unspecified genome; no seqlengths

Before giving some more details about further analysis and visualization of the models we
repeat above segementations using the ’NegativeBinomial’ emission functions.

hmm_nb = initHMM(trainRegions, nStates, "NegativeBinomial", sizeFactors)
hmm_fitted_nb = fitHMM(trainRegions, hmm_nb, sizeFactors=sizeFactors, maxIters=10)
viterbi_nb = getViterbi(hmm_fitted_nb, trainRegions, sizeFactors=sizeFactors)
viterbi_nb_gm12878 = viterbi2GRanges(viterbi_nb[1:3], pilot.hg19, 200)

In order to assign biologically meaningful roles to the inferred states we calculate the mean
number of reads per 200 base pair bin for both segmentations.

avg_cov_nb = getAvgSignal(viterbi_nb, trainRegions)
avg_cov_poilog = getAvgSignal(viterbi_poilog, trainRegions)

These are then plotted using the heatmap.2 function (see Figure 1).

## specify color palette

library(gplots)

heat = c("dark blue", "dodgerblue4", "darkred", "red", "orange", "gold", "yellow")

colfct = colorRampPalette(heat)
colpal_statemeans = colfct(200)

## define state order and colors
ord_nb = order(apply(avg_cov_nb,1,max), decreasing=TRUE)
statecols_nb = rainbow(nStates)
names(statecols_nb) = ord_nb
heatmap.2(log(avg_cov_nb+1)[as.character(ord_nb),], margins=c(8,7), srtCol=45,

5

The genomic STate ANnotation package

RowSideColors=statecols_nb[as.character(ord_nb)], dendrogram="none",
Rowv=FALSE, Colv=FALSE, col=colpal_statemeans, trace="none",
cellnote=round(avg_cov_nb,1)[as.character(ord_nb),], notecol="black")

## define state order and colors
ord_poilog = order(apply(avg_cov_poilog,1,max), decreasing=TRUE)
statecols_poilog = rainbow(nStates)
names(statecols_poilog) = ord_poilog
heatmap.2(log(avg_cov_poilog+1)[as.character(ord_poilog),], margins=c(8,7), srtCol=45,

RowSideColors=statecols_poilog[as.character(ord_poilog)], dendrogram="none",
Rowv=FALSE, Colv=FALSE, col=colpal_statemeans, trace="none",
cellnote=round(avg_cov_poilog,1)[as.character(ord_poilog),], notecol="black")

In order to visualize both STAN segmentations, we convert the viterbi paths and the data to
Gviz objects.

library(Gviz)

from = start(pilot.hg19)[3]

to = from+300000
gvizViterbi_nb = viterbi2Gviz(viterbi_nb_gm12878, "chr11", "hg19", from, to, statecols_nb)
gvizViterbi_poilog = viterbi2Gviz(viterbi_poilog_gm12878, "chr11", "hg19", from, to,

statecols_poilog)

gvizData = data2Gviz(trainRegions[3], pilot.hg19[3], 200, "hg19", col="black")

Then, we use the plotTracks function to plot everything (see Figure 2).

gaxis = GenomeAxisTrack()

data(ucscGenes)

mySize = c(1,rep(1.2,9), 0.5,0.5,3)
plotTracks(c(list(gaxis), gvizData,gvizViterbi_nb,gvizViterbi_poilog,ucscGenes["chr11"]),

from=from, to=to, showFeatureId=FALSE, featureAnnotation="id", fontcolor.feature="black",

cex.feature=0.7, background.title="darkgrey", lwd=2, sizes=mySize)

Modeling Sequencing data using other emission functions

In this section we illustrate the use of other distributions to annotate the the Roadmap
Epigenomics example data set, namely the ’Poisson’, ’NegativeMultinomial’, ’Gaussian’ and
’Bernoulli’ models. The ’Poisson’ model is an obvious choice when dealing with count data.
However since the variance of the Poisson is equal to its mean it might not be an ideal choice
for modeling Sequencing experiments, which have been shown to be overdispersed [3].

hmm_pois = initHMM(trainRegions, nStates, "Poisson")
hmm_fitted_pois = fitHMM(trainRegions, hmm_pois, maxIters=10)
viterbi_pois = getViterbi(hmm_fitted_pois, trainRegions)

6

The genomic STate ANnotation package

(a)

(b)

Figure 1: Mean read counts of the (a) ’NegativeBinomial’ and (b) ’PoissonLogNormal’ state annota-
tion

The ’NegativeMultinomial’ distribution for genome segmentation with HMMs was ﬁrst pro-
posed in the EpicSeg model [4]. The Negative Multinomial can be understood as a Multino-
mial distribution, where its overdispersion of is modeled by a Negative Binomial distribution.
However, this assumes a shared overdispersion across data tracks within a state as opposed
to the ’NegativeBinomial’ and ’PoissonLogNormal’ models which model the variance for each
state and data track separately. In order to use the ’NegativeMultinomial’ in STAN an addi-

7

H3K4me1H3K4me3H3K36me3H3K27me3H3K9me3H3K27acH3K9acDNaseInput102489615730.80.90.71.81.90.40.71.313.81.61.22.82.11.21.62.81.41.91.35.50.91.511.42.21.29.74.13.21.72.433.27.91.621.27.942.32.76.55.95.71.713.321.43.21.42.41416.225.31.839.111.84.61.82.416.98.920.92.527.824.93.91.52.634.626.444.12.565.313.96.61.2471.733.412.72.92.940.31.31.42.241.251.673.81.71234Value01234Color Keyand HistogramCountH3K4me1H3K4me3H3K36me3H3K27me3H3K9me3H3K27acH3K9acDNaseInput101625374890.80.90.71.81.90.40.71.314.91.81.32.62.21.31.83.41.41.91.35.60.91.511.42.21.211.45.83.91.32.44.84.68.91.619.311.41.25.13.22.95.45.621921.44.21.22.417.318.624.32.131.610.14.41.82.416.68.340.32.44.943.21.71.42.545.353.673.71.77614.80.80.43.644.812.45.82.258.214.792.1482.743.617.63.71234Value01234Color Keyand HistogramCountThe genomic STate ANnotation package

Figure 2: Genome Browser showing the 10 data tracks used for model learning together with the
’Negativebinomial’ (top) and ’PoissonLogNormal’ (bottom) segmentations and known UCSC gene
annotations

tional data track - the sum of counts - for each bin needs to be added to the data. Internally
the ’NegativeMultinomial’ is modeled as a product of a ’NegativeBinomial’ and a ’Multino-
mial’ emission (see section ’Combining diﬀerent emission functions’ for further details):

simData_nmn = lapply(trainRegions, function(x) cbind(apply(x,1,sum), x))
hmm_nmn = initHMM(simData_nmn, nStates, "NegativeMultinomial")
hmm_fitted_nmn = fitHMM(simData_nmn, hmm_nmn, maxIters=10)
viterbi_nmn = getViterbi(hmm_fitted_nmn, simData_nmn)

In order to model the data using Gaussian distributions, it needs to be log-transformed
and smoothed. This approach is implementd in Segway, a method used by the ENCODE
Consortium for chromatin state annotation [5]. However, to overcome singularity of the
(diagonal) covariance matrix due to the zero-inﬂated distribution of the transformed read
counts, it uses a shared variance over states for each data track. To use gaussian distributions
with Sequencing data in STAN, we transform the data (with the hyperbole sine function [5])
and model it using the emission ’IndependentGaussian’ with a shared covariance, i.e. shared
Cov=TRUE.

8

1.75 mb1.8 mb1.85 mb1.9 mb1.95 mb2 mb020406080H3K4me10204060H3K4me3051015H3K36me30510H3K27me3051015H3K9me3020406080100H3K27ac020406080100120H3K9ac0100200300DNase012345InputUCSC GenesThe genomic STate ANnotation package

trainRegions_smooth = lapply(trainRegions, function(x)

apply(log(x+sqrt(x^2+1)), 2, runningMean, 2))

hmm_gauss = initHMM(trainRegions_smooth, nStates, "IndependentGaussian", sharedCov=TRUE)
hmm_fitted_gauss = fitHMM(trainRegions_smooth, hmm_gauss, maxIters=10)
viterbi_gauss = getViterbi(hmm_fitted_gauss, trainRegions_smooth)

Another approach was proposed in ChromHMM, which models binarized data using an in-
dependent Bernoulli model [1]. Note, that the performance of the model highly depends
on the non-trivial choice of a proper cutoﬀ and quantitative information is lost. The latter
is especially important when predicting promoters and enhancers since these elements are
both marked H3K4me1 and H3K4me3, but at diﬀerent ratios. The function binarizeData
binarizes the data using the default approach by ChromHMM [1]. The model can then be ﬁt
by specifying the ’Bernoulli’ model. Note however, that initialization and model ﬁtting are
carried out diﬀerently than in the ChromHMM implementation. In particular STAN uses the
EM algorithm while ChromHMM uses online EM. For details on the initialization, please see
the initHMM manual.

trainRegions_binary = binarizeData(trainRegions)
hmm_ber = initHMM(trainRegions_binary, nStates, "Bernoulli")
hmm_fitted_ber = fitHMM(trainRegions_binary, hmm_ber, maxIters=10)
viterbi_ber = getViterbi(hmm_fitted_ber, trainRegions_binary)

We calculate the mean read coverage for each method and segmentation:

avg_cov_gauss = getAvgSignal(viterbi_gauss, trainRegions)
avg_cov_nmn = getAvgSignal(viterbi_nmn, trainRegions)
avg_cov_ber = getAvgSignal(viterbi_ber, trainRegions)
avg_cov_pois = getAvgSignal(viterbi_pois, trainRegions)

These are again plotted using the heatmap.2 function (see Figure 3).

heatmap.2(log(avg_cov_gauss+1), margins=c(8,7),srtCol=45, dendrogram="row", Rowv=TRUE,

Colv=FALSE, col=colpal_statemeans, trace="none", notecex=0.7, cexRow=0.75, cexCol=1,
cellnote=round(avg_cov_gauss,1), notecol="black")

heatmap.2(log(avg_cov_nmn+1), margins=c(8,7),srtCol=45, dendrogram="row", Rowv=TRUE,

Colv=FALSE, col=colpal_statemeans, trace="none", notecex=0.7, cexRow=0.75, cexCol=1,
cellnote=round(avg_cov_nmn,1), notecol="black")

heatmap.2(log(avg_cov_ber+1), margins=c(8,7),srtCol=45, dendrogram="row", Rowv=TRUE,

Colv=FALSE, col=colpal_statemeans, trace="none", notecex=0.7, cexRow=0.75, cexCol=1,
cellnote=round(avg_cov_ber,1), notecol="black")

heatmap.2(log(avg_cov_pois+1), margins=c(8,7),srtCol=45, dendrogram="row", Rowv=TRUE,

Colv=FALSE, col=colpal_statemeans, trace="none", notecex=0.7, cexRow=0.75, cexCol=1,
cellnote=round(avg_cov_pois,1), notecol="black")

9

The genomic STate ANnotation package

(a)

(b)

(c)

(d)

Figure 3: Mean read counts of the (a) ’IndependentGaussian’ (b) ’NegativeMultinomial’ (c) ’Bernoulli’

and (d) ’Poisson’ state annotation

10

H3K4me1H3K4me3H3K36me3H3K27me3H3K9me3H3K27acH3K9acDNaseInput910724365180.40.40.40.50.80.20.30.70.30.610.80.83.70.40.91.41.40.910.61.81.20.40.61.60.81.210.73.92.10.60.91.41.14.21.51.12.21.91.11.62.91.41.30.93.20.81.10.71.11.412.71.77.311.71.41.63.11.3642.621.52.446.954.477.51.810.34.82.81.72.33.13.66.51.620.615.43.81.32.315.513.219.51.91234Value024Color Keyand HistogramCountH3K4me1H3K4me3H3K36me3H3K27me3H3K9me3H3K27acH3K9acDNaseInput9108725461321.35.50.91.51.11.32.21.10.90.90.71.920.40.81.414.71.61.12.51.81.11.92.51.56.31610.91.619.917.4183.72.22.736.40.91.21.756.854.272.41.35.451.62.21.72.842.564.715.31.612.64.32.91.52.33.73.53.61.410.64.11.51.723.63.624.61.912.723.13.21.72.38.913.48.71.824.6112.51.32.129.115.79.71.612345Value01234Color Keyand HistogramCountH3K4me1H3K4me3H3K36me3H3K27me3H3K9me3H3K27acH3K9acDNaseInput6912834571017.423.641.72.418.326.64.621812.13.71.72.516.75.859.21.412.434.82.41.42.441.743.170.222.51.812.71.121.51.83.11.61.31.11.21.71.90.60.91.512.51.41.210.32.71.11.42.21.414.33.32.71.62.33.43.43.31.71615.43.12.52.46.854.71.46.33.91.91.92.22.52.719.81.617.76.92.11.72.43.65.226.11.91234Value024Color Keyand HistogramCountH3K4me1H3K4me3H3K36me3H3K27me3H3K9me3H3K27acH3K9acDNaseInput610752983417.62.91.52.52.41.92.55.31.50.90.90.71.81.90.40.81.412.41.56.111.71.21.52.41.346.120.54.71.63.258.128.616.82.718.67.34.81.72.67.86.15.91.813.824.13.11.72.312.117.210.11.8139.71.51.4211.38.66627.725.41.40.91.638.130.6297.42.96.151.42.31.7334.452.520.11.63.357.31.81.62.784.497.859.31.912345Value024Color Keyand HistogramCountThe genomic STate ANnotation package

4

Integrating strand-speciﬁc and non-strand-speciﬁc
data with STAN

STAN also allows for the integration of strand-speciﬁc (e.g. RNA) and non-strand-speciﬁc
data (e.g. ChIP). This is donw using bidirectional hidden Markov models (bdHMMs) which
were proposed in [2]. A bdHMM models a directed process using the concept of twin states,
where each genomic state is split up into a pair of twin states, one for each direction (e.g.
sense and antisense in context of transcription). Those twin state pairs are identical
in
terms of their emissions (i.e. they model the same genomic state). Currently the following
models are available for bdHMMs:
’IndependentGaussian’, ’Gaussian’, ’NegativeBinomial’,
’ZINegativeBinomial’ and ’PoissonLogNormal’. We now illustrate the use of bdHMMs in
STAN at an example data set of yeast transcription factors measured by ChIP-chip and RNA
expression measured with a tiling array which was used to model the transcription cycle as a
sequence of ’transcription states’ in [2].
The initBdHMM function is used to initialize a bdHMM with 6 twin states. Note that the
overall number of states in the bdHMM is 12 (6 identical twin state pairs). dirobs deﬁnes
the directionality (or strand-speciﬁcity) of the data tracks. In dirobs, the ﬁrst 10 data tracks
are non-strand-speciﬁc ChIP-chip measurments, indicated by ’0’ and data track 11 and 12
are strand-speciﬁc RNA expression measurements, indicated by ’1’. Note that strand-speciﬁc
data tracks must be labeled as increasing pairs of integers. Thus and additional strand-
speciﬁc data track pair would be labeled as a pair of ’2’. Model ﬁtting and calculation of the
state annotation are carried out as for standard HMMs:

data(yeastTF_databychrom_ex)
dStates = 6

dirobs = as.integer(c(rep(0,10), 1, 1))
bdhmm_gauss = initBdHMM(yeastTF_databychrom_ex, dStates = dStates, method = "Gaussian", directedObs=dirobs)
bdhmm_fitted_gauss = fitHMM(yeastTF_databychrom_ex, bdhmm_gauss)
viterbi_bdhmm_gauss = getViterbi(bdhmm_fitted_gauss, yeastTF_databychrom_ex)

We plot the means of the multivariate gaussian distrbutions for each state (see Figure 4):

statecols_yeast = rep(rainbow(nStates), 2)
names(statecols_yeast) = StateNames(bdhmm_fitted_gauss)
means_fitted = EmissionParams(bdhmm_fitted_gauss)$mu
heatmap.2(means_fitted, col=colpal_statemeans,

RowSideColors=statecols_yeast[rownames(means_fitted)],
trace="none", cexCol=0.9, cexRow=0.9,
cellnote=round(means_fitted,1), notecol="black", dendrogram="row",
Rowv=TRUE, Colv=FALSE, notecex=0.9)

We convert the viterbi path into a GRanges object. Note that the directionaliy of bdHMM
states is indicated by ’F’ (forward) and ’R’ (reverse).

yeastGRanges = GRanges(IRanges(start=1214616, end=1225008), seqnames="chrIV")
names(viterbi_bdhmm_gauss) = "chrIV"
viterbi_bdhmm_gauss_gr = viterbi2GRanges(viterbi_bdhmm_gauss, yeastGRanges, 8)

11

The genomic STate ANnotation package

Figure 4: Mean signal 6 bdHMM twin state pairs
’F’ and ’R’ indicate forward and reverse direction of state pairs.

viterbi_bdhmm_gauss_gr
## GRanges object with 48 ranges and 1 metadata column:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames

<Rle>

ranges strand |

name

<IRanges>

<Rle> | <character>

[1]

[2]

[3]

[4]

[5]

...

[44]

[45]

[46]

[47]

[48]

-------

chrIV [1214616, 1215016]

chrIV [1215016, 1215088]

chrIV [1215088, 1215224]

chrIV [1215224, 1215264]

chrIV [1215264, 1216808]

...

...

chrIV [1224680, 1224696]

chrIV [1224696, 1224752]

chrIV [1224752, 1224880]

chrIV [1224880, 1224928]

chrIV [1224928, 1225008]

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

R3

F3

F4

R1

F4

...

F6

R6

R5

F1

R5

seqinfo: 1 sequence from an unspecified genome; no seqlengths

Next, we visualize the data, state annotation and together with SGD genes using Gviz (see
Figure 5):

12

NucleosomeRpb3S5PS2PTfiibCtk1Paf1Spt5Spt16Pcf11YPDexprWYPDexprCF6R6F4R4F2R2R5F1R3F5R1F30.50.100.10.20.30.10.10.20.40.10.10.50.100.10.20.30.10.10.20.40.10.10.70.10.10.30.10.10.20.10.10.20.10.60.70.10.10.30.10.10.20.10.10.20.60.10.40.70.801.10.50.20.50.50.40.50.10.40.70.801.10.50.20.50.50.40.10.50.70.60.70.30.70.50.60.70.60.50.80.10.60.30.40.30.30.50.50.40.30.40.70.10.60.50.40.60.30.50.50.50.40.50.70.10.70.60.70.30.70.50.60.70.60.50.10.80.60.30.40.30.30.50.50.40.30.40.10.70.60.50.40.60.30.50.50.50.40.50.10.70.20.61Value0246Color Keyand HistogramCountThe genomic STate ANnotation package

chr = "chrIV"

gen = "sacCer3"

gtrack <- GenomeAxisTrack()

from=1217060

to=1225000
forward_segments = grep("F", viterbi_bdhmm_gauss_gr$name)
reverse_segments = grep("R", viterbi_bdhmm_gauss_gr$name)
gvizViterbi_yeast = viterbi2Gviz(viterbi_bdhmm_gauss_gr[forward_segments],

"chrIV", "sacCer3", from, to, statecols_yeast)

gvizViterbi_yeast2 = viterbi2Gviz(viterbi_bdhmm_gauss_gr[reverse_segments],

"chrIV", "sacCer3", from, to, statecols_yeast)

gvizData_yeast = data2Gviz(yeastTF_databychrom_ex, yeastGRanges, 8, "sacCer3", col="black")
gaxis = GenomeAxisTrack()
data(yeastTF_SGDGenes)
mySize = c(1,rep(1,12), 0.5,0.5,3)

plotTracks(c(list(gaxis), gvizData_yeast,gvizViterbi_yeast,gvizViterbi_yeast2,

list(yeastTF_SGDGenes)), cex.feature=0.7, background.title="darkgrey", lwd=2,
sizes=mySize, from=from, to=to, showFeatureId=FALSE, featureAnnotation="id",

fontcolor.feature="black", cex.feature=0.7, background.title="darkgrey",

showId=TRUE)

13

The genomic STate ANnotation package

Figure 5: Genome Browser showing the 12 data tracks used for model learning together with the
segmentations and known SGD gene annotations

5

Concluding Remarks

This vignette was generated using the following package versions:

• R version 3.4.2 (2017-09-28), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Running under: Ubuntu 16.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so

• LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

• Base packages: base, datasets, grDevices, graphics, grid, methods, parallel, stats,

stats4, utils

14

1.218 mb1.219 mb1.22 mb1.221 mb1.222 mb1.223 mb1.224 mb−0.500.5100.40.8Rpb300.51S5P−0.20.20.6S2P00.511.5Tfiib00.40.8Ctk100.40.8Paf100.40.8Spt5−0.20.20.6Spt1600.20.40.60.8Pcf1100.5100.511.5SGD GenesYDR370CYDR371C−AYDR371WYDR372CYDR373WYDR374CYDR374W−AThe genomic STate ANnotation package

• Other packages: BiocGenerics 0.24.0, GenomeInfoDb 1.14.0, GenomicRanges 1.30.0,
Gviz 1.22.0, IRanges 2.12.0, S4Vectors 0.16.0, STAN 2.6.0, gplots 3.0.1, knitr 1.17,
poilog 0.4

• Loaded via a namespace (and not attached): AnnotationDbi 1.40.0,

AnnotationFilter 1.2.0, AnnotationHub 2.10.0, BSgenome 1.46.0, Biobase 2.38.0,
BiocInstaller 1.28.0, BiocParallel 1.12.0, BiocStyle 2.6.0, Biostrings 2.46.0, DBI 0.7,
DelayedArray 0.4.0, Formula 1.2-2, GenomeInfoDbData 0.99.1,
GenomicAlignments 1.14.0, GenomicFeatures 1.30.0, Hmisc 4.0-3,
KernSmooth 2.23-15, Matrix 1.2-11, ProtGenerics 1.10.0, R6 2.2.2,
RColorBrewer 1.1-2, RCurl 1.95-4.8, RMySQL 0.10.13, RSQLite 2.0, Rcpp 0.12.13,
Rsamtools 1.30.0, Rsolnp 1.16, SummarizedExperiment 1.8.0,
VariantAnnotation 1.24.0, XML 3.98-1.9, XVector 0.18.0, acepack 1.4.1,
assertthat 0.2.0, backports 1.1.1, base64enc 0.1-3, biomaRt 2.34.0, biovizBase 1.26.0,
bit 1.1-12, bit64 0.9-7, bitops 1.0-6, blob 1.1.0, caTools 1.17.1, checkmate 1.8.5,
cluster 2.0.6, colorspace 1.3-2, compiler 3.4.2, curl 3.0, data.table 1.10.4-3,
dichromat 2.0-0, digest 0.6.12, ensembldb 2.2.0, evaluate 0.10.1, foreign 0.8-69,
gdata 2.18.0, ggplot2 2.2.1, gridExtra 2.3, gtable 0.2.0, gtools 3.5.0, htmlTable 1.9,
htmltools 0.3.6, htmlwidgets 0.9, httpuv 1.3.5, httr 1.3.1,
interactiveDisplayBase 1.16.0, lattice 0.20-35, latticeExtra 0.6-28, lazyeval 0.2.1,
magrittr 1.5, matrixStats 0.52.2, memoise 1.1.0, mime 0.5, munsell 0.4.3,
nnet 7.3-12, plyr 1.8.4, prettyunits 1.0.2, progress 1.1.2, rlang 0.1.2, rmarkdown 1.6,
rpart 4.1-11, rprojroot 1.2, rtracklayer 1.38.0, scales 0.5.0, shiny 1.0.5, splines 3.4.2,
stringi 1.1.5, stringr 1.2.0, survival 2.41-3, tibble 1.3.4, tools 3.4.2, truncnorm 1.0-7,
xtable 1.8-2, yaml 2.1.14, zlibbioc 1.24.0

15

The genomic STate ANnotation package

References

[1] J. Ernst and M. Kellis. Discovery and characterization of chromatin states for systematic

annotation of the human genome. Nat. Biotechnol., 28(8):817–825, Aug 2010.

[2] B. Zacher, M. Lidschreiber, P. Cramer, J. Gagneur, and A. Tresch. Annotation of

genomics data using bidirectional hidden Markov models unveils variations in Pol II
transcription cycle. Mol. Syst. Biol., 10:768, 2014.

[3] S. Anders and W. Huber. Diﬀerential expression analysis for sequence count data.

Genome Biol., 11(10):R106, 2010.

[4] Alessandro Mammana and Ho-Ryun Chung. Chromatin segmentation based on a

probabilistic model for read counts explains a large portion of the epigenome. Genome
Biology, 16(1):151, 2015.

[5] Michael M Hoﬀman, Orion J Buske, Jie Wang, Zhiping Weng, Jeﬀ a Bilmes, and

William Staﬀord Noble. Unsupervised pattern discovery in human chromatin structure
through genomic segmentation. Nature Methods, 9(5):473–476, 2012.

16


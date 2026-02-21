An Introduction to the skewr Package

Ryan Putney

Steven Eschrich

Anders Berglund

October 30, 2025

1

Introduction

The skewr package is a tool for visualizing the output of the Illumina Human Methylation
450k BeadChip(450k) to aid in quality control. It creates a panel of nine plots. Six of the
plots represent the density of either the methylated intensity or the unmethylated intensity
given by one of three subsets of the 485,577 total probes. These subsets include Type I-red,
Type I-green, and Type II. The remaining three distributions give the density of the β-values
for these same three subsets. Each of the nine plots optionally displays the distributions of
the ”rs” SNP probes and the probes associated with imprinted genes[1] as a series of ’tick’
marks located above the x-axis.

Importance of the data

DNA methylation is an epigenetic modification of the genome believed to play a role in
gene expression. Hypermethylation and hypomethylation have the potential to either silence
or ’turn on’ specific genes, respectively. For this reason, the role that methylation plays in
disease processes, such as cancer, is of particular interest to researchers. The introduction of
450k which can efficiently query the methylation status of more than 450,000 CpG sites has
given rise to the need of being able to analyze the generated data in an equally efficient, as
well as accurate, manner.

450k Design

The 450k utilizes two separate assay methods on a single chip. Approximately 135,000 of the
total number of probes on the 450k are of the Infinium Type I technology, as used on the
preceding 27k BeadChip. The Type I probes have both a methylated and an unmethylated
probe type for each CpG site. The final base of these probe types are designed to match either
the methylated C or the T which results from bisulfite conversion of an unmethylated C. A
single base extension results in the addition of a colored dye. The color of the fluorescent
dye used to measure the intensities of these probes is the same for both the methylated and
unmethylated types. The Type II probes utilize one probe for both the methylated and

1

unmethylated CpG locus. The single base extension step itself determines the methylation
status of the locus. If the interrogated locus has a methylated C, then a green-labeled
G is added, while a red-labeled A is added if the locus has the converted T denoting an
unmethylated locus. For this reason, the level of methylation for the type II probes is always
measured in the green channel, while level of unmethylation in the red. These factors mean
that there are potentially six subsets of the total signal intensity: Type I-red methylated,
Type I-red unmethylated, Type I-green methylated, Type I-green unmethylated, Type II
methylated, and Type II unmethylated.

The preferred metric for evaluating the level of methylation for a given probe is usually the
β-value, which is calculated as a ratio of the methylated signal intensity over the sum of the
methylated and unmethylated signal intensities and a small offset value α, which is usually
100:

β =

M
M + U + α

The β-value has the advantages of being the Illumina recommended metric and of being
natural and straightforward[2].

Differences in the performance of the Type I and Type II probes[3, 4] and the existence of
dye bias introduced by the two-color design[5], however, have been observed. Much work has
been done to correct these confounding factors, but their efficacy is usually judged in β space.

Proposed Use of skewr

skewr is designed to visualize the array data in log2 intensity space. By analyzing the data in
this way, we believe that a more accurate understanding of the biological variation may be
attained.

As a step in that direction, we found that the log2 distributions of the intensities may be
modeled as a mixture of skew-normal distributions. A three-component model fits the Type I
intensity distributions well, while two components generally fit the Type II distributions the
best. We have observed a difficulty in fitting a Skew-normal mixture model to the Type II
intensity distributions, especially the unmethylated probes. We have verified, however, that
the two-component model works very well for samples that carry a reasonable assumption of
purity.

The location of the individual components themselves may give insight into the true signal-to-
noise ratio, as well as possible mechanisms of non-specific binding. The posterior probabilities
for the intensities of individual probes may prove useful in distinguishing the true biological
variability in the methylation levels.

2

Finite Mixture of Skew-normal Distributions

skewr utilizes the mixsmsn package to estimate the parameters for the Skew-normal components
that make up the finite mixture model for the intensity distributions[6]. mixsmsn deals with the
family of distributions known as the scale mixtures of the skew-normal distributions(SMSN)[7].

If a random variable Z has a skew-normal distribution with location parameter µ, scale
parameter σ2, and skewness, or shape, parameter λ, its density is given by:

ψ(z) = 2ϕ(z; µ, σ2)Φ

(cid:18) λ(z − µ)
σ

(cid:19)

,

(1)

where ϕ(·; µ, σ2) is the probability density function and Φ(·) is the cumulative distribution
function, both of the univariate normal distribution. Random variable Z is then denoted as
Z ∼ SN(µ, σ2, λ).

Y is a random variable with an SMSN distribution if:

Y = µ + U −1/2Z,

(2)

where µ is the location parameter, Z ∼ SN(0, σ2, λ), and U is a positive random variable given
by the distribution function H(·, ν). Then U becomes the scale factor, and its distribution
H(·, ν) is the mixing distribution indexed by the parameter ν which may be univariate or
multivariate. Since skewr is only dealing with the skew-normal distribution of the SMSN
family U always has the value 1, and the parameter ν has no significance. Therefore,

Y = µ + Z, Z ∼ SN(0, σ2, λ)

(3)

A finite mixture of skew-normal distributions for a random sample y = (y1, y2, . . . , Yn) with
g number of components is given by:

f (yi, Θ) =

g
(cid:88)

j=1

pjψ(yi; θj),

pj ≥ 0,

g
(cid:88)

j=1

pj = 1,

i = 1, . . . , n,

j = 1, . . . , g,

(4)

where θj = (µj, σ2
j , λj) are the parameters for the jth skew-normal component, p1, . . . , pg
are the mixing probabilities, or weights, for the components, and Θ is a vector of all the
parameters: Θ = ((p1, . . . , pg), θ1, . . . , θg).

Finally, the estimated posterior probability ˆzij is given by:

3

ˆzij =

j , ˆλj)
ˆpjSN(yi; ˆµj, ˆσ2
k=1 ˆpkSN(yi; ˆµk, ˆσ2

k, ˆλk)

(cid:80)g

,

i = 1, . . . , n,

j = 1, . . . , g,

(5)

which is essentially the probability of finding a given point in the jth component over the
probability of finding it in the mixture model.

2 Getting Started

Installation

skewr is a package that is designed to work with several preexisting packages. Therefore, a
fair number of dependencies are required. The following packages must be installed:
packages.install('mixsmsn')
if (!requireNamespace("BiocManager", quietly=TRUE))

install.packages("BiocManager")

BiocManager::install(c('skewr', 'methylumi', 'minfi', 'wateRmelon',

'IlluminaHumanMethylation450kmanifest', 'IRanges'))

And to run this vignette as written:
BiocManager::install('minfiData')

Load skewr
library(skewr)
library(minfiData)

4

3 Sample Session

skewr provides a convenience function for retrieving clean barcode names from all idat files
found in the path, or vector of paths, given as a parameter. getMethyLumiSet is a wrapper
function utilizing the methylumIDAT function provided by methylumi[8]. getMethyLumiSet
will process all idat files in the path to the directory given by the first argument, or default
to the working directory if none is given. A vector of barcodes may be provided if only
those specific idat files are to be processed. The default output will be a raw MethyLumiSet,
unless a normalization method is specified when calling getMethyLumiSet. It is unlikely that
preprocessing will be desired when calling getMethyLumiSet unless one is only interested in a
single normalization method. It is much more likely that getMethyLumiSet will be called to
assign the raw MethyLumiSet object to a label. Then the preprocess method provided by
the skewr may be called to return a number of objects with different normalization methods
applied[9, 1].

As an example of the use of the getBarcodes function provided by skewr, we will start by
retrieving the barcodes of some idat files provided by minfiData[10].
baseDir <- system.file("extdata/5723646052", package = "minfiData")
barcodes <- getBarcodes(path = baseDir)
barcodes

## [1] "5723646052_R02C02" "5723646052_R04C01" "5723646052_R05C02"

methylumiset.raw <- getMethyLumiSet(path = baseDir, barcodes =
methylumiset.illumina <- preprocess(methylumiset.raw, norm = 'illumina',

barcodes[1:2])

bg.corr = FALSE)

To allow for a more efficient demonstration, however, the rest of the vignette will utilize
a MethyLumiSet object that is supplied by the Bioconductor package wateRmelon. This
reduced data set only contains 3363 features out of the 485,577 total probes. We will only
use one sample, but skewr will plot panels for all samples contained within the MethyLumiSet
passed to it.
data(melon)
melon.raw <- melon[,11]

Additional normalization methods may be performed as follows:
melon.illumina <- preprocess(melon.raw, norm = 'illumina', bg.corr = TRUE)
melon.SWAN <- preprocess(melon.raw, norm = 'SWAN')
melon.dasen <- preprocess(melon.raw, norm = 'dasen')

5

getSNparams will subset the probes by either methylated, M, or unmethylated, U, and I-red,
I-green, or II. The subset of probes are then fitted to a skew-normal finite mixture model.
The mixture modelling is provided by the smsn.mix method of the mixsmsn package. Assign
the return value or each of the six getSNparams calls to a separate label.
sn.raw.meth.I.red <- getSNparams(melon.raw, 'M', 'I-red')
sn.raw.unmeth.I.red <- getSNparams(melon.raw, 'U', 'I-red')
sn.raw.meth.I.green <- getSNparams(melon.raw, 'M', 'I-green')
sn.raw.unmeth.I.green <- getSNparams(melon.raw, 'U', 'I-green')
sn.raw.meth.II <- getSNparams(melon.raw, 'M', 'II')
sn.raw.unmeth.II <- getSNparams(melon.raw, 'U', 'II')

If you want to compare the raw data for your experiment with the same data after a
normalization method has been performed, you would carry out the same steps for each of
your normalized MethyLumiSets. For example:
sn.dasen.meth.I.red <- getSNparams(melon.dasen, 'M', 'I-red')
sn.dasen.unmeth.I.red <- getSNparams(melon.dasen, 'U', 'I-red')
sn.dasen.meth.I.green <- getSNparams(melon.dasen, 'M', 'I-green')
sn.dasen.unmeth.I.green <- getSNparams(melon.dasen, 'U', 'I-green')
sn.dasen.meth.II <- getSNparams(melon.dasen, 'M', 'II')
sn.dasen.unmeth.II <- getSNparams(melon.dasen, 'U', 'II')

Before the panel plots can be made, the values returned by getSNparams must be put into a
list so that probes with the same assay and channel are in a separate list object with the
methylated probes listed first followed by the unmethylated. Note that skewr is designed to
create a series of panel plots for an entire experiment. It will not work if one attempts to index
a single sample and its accompanying skew-normal models. See section 4 for information on
how to better view a single sample within an experiment.
raw.I.red.mixes <- list(sn.raw.meth.I.red, sn.raw.unmeth.I.red)
raw.I.green.mixes <- list(sn.raw.meth.I.green, sn.raw.unmeth.I.green)
raw.II.mixes <- list(sn.raw.meth.II, sn.raw.unmeth.II)

The panelPlots method takes the original MethyLumiSet object as the first parameter. The
following parameters consist of the listed I-red, I-green, and II models, in that order.
panelPlots(melon.raw, raw.I.red.mixes, raw.I.green.mixes,

raw.II.mixes, norm = 'Raw')

The samp.num parameter of panelPlots, may also be specified if plots for only one sample
out of an experimenter is wanted. The samp.num is an integer indexing the sample column
within the MethyLumiSet object.

Of course, the listing of the Skew-normal objects may be done in the call to panelPlots.
panelPlots(melon.dasen,

list(sn.dasen.meth.I.red, sn.dasen.unmeth.I.red),
list(sn.dasen.meth.I.green, sn.dasen.unmeth.I.green),
list(sn.dasen.meth.II, sn.dasen.unmeth.II), norm = 'dasen')

panelPlots will produce a panel plot for each sample in your experiment, Figure 1. Producing
panel plots of the same experiment with different types of normalization applied may allow a
better understanding of what the normalization method is actually doing to the data.

6

Figure 1: Panel Plot for One Sample

7

4 Single Plots

It is possible to call panelPlots with the plot parameter as plot = ’frames’. In this case,
a sample number for a single sample contained within your experiment must also be passed
as a parameter. If panelPlots is called in this manner, nine separate, large plots will be
created. Each of these nine plots correspond to a single pane that would be found in the
panel plot for the selected sample. In addition, each of these separate plots, except for the
beta plots, will contain a legend with useful information, such as the means and modes for
each of the components of the mixture. The means and modes are also contained as part
of the Skew.normal object returned by getSNparams and may be accessed in the following
manner:
class(sn.raw.meth.I.red[[1]])

## [1] "Skew.normal"

names(sn.raw.meth.I.red[[1]])

## [1] "mu"
## [6] "aic"
## [11] "n"

"sigma2"
"bic"
"obs.prob"

"shape"
"edc"
"means"

"pii"
"icl"
"modes"

"nu"
"iter"
"dens.list"

sn.raw.meth.I.red[[1]]$means

## [1] 10.579297 12.860771 8.327793

sn.raw.meth.I.red[[1]]$modes

## [1] 10.588997 12.858871 8.168804

To generate each panel as a single plot, see examples ?? and ??:
panelPlots(melon.raw, raw.I.red.mixes, raw.I.green.mixes,

raw.II.mixes, plot='frames', frame.nums=c(1,3), norm='Raw')

The graph includes the histogram of the intensities expressed as probabilities as would
be produced by the generic hist function. The dotted line represents the kernel density
estimation. The colored curves are the probability distributions of the individual components
with the vertical solid and dotted lines being the mode and mean, respectively, for each
component. The legend identifies the mean and the mode and provides a floating point
value, rounded off to three decimal places, for each. The solid black line is the sum of the
components, representing the fit of the Skew-normal mixture model.

8

Figure 2: Single Frame Showing Skew-normal Components

9

Figure 3: Single Frame Showing Beta Distribution for Type I Red

10

5

sessionInfo

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu
• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,
LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Time zone: America/New_York
• TZcode source: system (glibc)
• Running under: Ubuntu 24.04.3 LTS
• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
• Base packages: base, datasets, grDevices, graphics, methods, parallel, stats, stats4, utils

• Other packages: AnnotationDbi 1.72.0, Biobase 2.70.0, BiocGenerics 0.56.0,

Biostrings 2.78.0, FDb.InfiniumMethylation.hg19 2.2.0, GenomicFeatures 1.62.0,
GenomicRanges 1.62.0, IRanges 2.44.0,
IlluminaHumanMethylation450kanno.ilmn12.hg19 0.6.1,
IlluminaHumanMethylation450kmanifest 0.4.0, MatrixGenerics 1.22.0, ROC 1.86.0,
S4Vectors 0.48.0, Seqinfo 1.0.0, SummarizedExperiment 1.40.0,
TxDb.Hsapiens.UCSC.hg19.knownGene 3.22.1, XVector 0.50.0, bumphunter 1.52.0,
foreach 1.5.2, generics 0.1.4, ggplot2 4.0.0, illuminaio 0.52.0, iterators 1.0.14, knitr 1.50,
limma 3.66.0, locfit 1.5-9.12, lumi 2.62.0, matrixStats 1.5.0, methylumi 2.56.0,
minfi 1.56.0, minfiData 0.55.0, mixsmsn 1.1-11, mvtnorm 1.3-3, org.Hs.eg.db 3.22.0,
reshape2 1.4.4, scales 1.4.0, skewr 1.42.0, wateRmelon 2.16.0

• Loaded via a namespace (and not attached): BiocIO 1.20.0, BiocManager 1.30.26,
BiocParallel 1.44.0, DBI 1.2.3, DelayedArray 0.36.0, DelayedMatrixStats 1.32.0,
GEOquery 2.78.0, GenomeInfoDb 1.46.0, GenomicAlignments 1.46.0,
HDF5Array 1.38.0, KEGGREST 1.50.0, KernSmooth 2.23-26, MASS 7.3-65,
Matrix 1.7-4, R6 2.6.1, RColorBrewer 1.1-3, RCurl 1.98-1.17, RSQLite 2.4.3,
Rcpp 1.1.0, Rhdf5lib 1.32.0, Rsamtools 2.26.0, S4Arrays 1.10.0, S7 0.2.0,
SparseArray 1.10.0, UCSC.utils 1.6.0, XML 3.99-0.19, abind 1.4-8, affy 1.88.0,
affyio 1.80.0, annotate 1.88.0, askpass 1.2.1, base64 2.0.2, beanplot 1.3.1, bit 4.6.0,
bit64 4.6.0-1, bitops 1.0-9, blob 1.2.4, cachem 1.1.0, cigarillo 1.0.0, cli 3.6.5,
codetools 0.2-20, compiler 4.5.1, crayon 1.5.3, curl 7.0.0, data.table 1.17.8,
dichromat 2.0-0.1, digest 0.6.37, doRNG 1.8.6.2, dplyr 1.1.4, evaluate 1.0.5, farver 2.1.2,
fastmap 1.2.0, genefilter 1.92.0, glue 1.8.0, grid 4.5.1, gtable 0.3.6, h5mread 1.2.0,
highr 0.11, hms 1.1.4, httr 1.4.7, jsonlite 2.0.0, lattice 0.22-7, lifecycle 1.0.4,

11

magrittr 2.0.4, mclust 6.1.1, memoise 2.0.1, mgcv 1.9-3, multtest 2.66.0, nleqslv 3.3.5,
nlme 3.1-168, nor1mix 1.3-3, openssl 2.3.4, pillar 1.11.1, pkgconfig 2.0.3, plyr 1.8.9,
png 0.1-8, preprocessCore 1.72.0, purrr 1.1.0, quadprog 1.5-8, readr 2.1.5, rentrez 1.2.4,
reshape 0.8.10, restfulr 0.0.16, rhdf5 2.54.0, rhdf5filters 1.22.0, rjson 0.2.23, rlang 1.1.6,
rngtools 1.5.2, rtracklayer 1.70.0, scrime 1.3.5, siggenes 1.84.0,
sparseMatrixStats 1.22.0, splines 4.5.1, statmod 1.5.1, stringi 1.8.7, stringr 1.5.2,
survival 3.8-3, tibble 3.3.0, tidyr 1.3.1, tidyselect 1.2.1, tools 4.5.1, tzdb 0.5.0,
vctrs 0.6.5, withr 3.0.2, xfun 0.53, xml2 1.4.1, xtable 1.8-4, yaml 2.3.10

References

[1] Ruth Pidsley, Chloe C Y Wong, Manuela Volta, Katie Lunnon, Jonathan Mill, and
Leonard C Schalkwyk. A data-driven approach to preprocessing illumina 450k methyla-
tion array data. BMC Genomics, 14:293, 2013. doi:10.1186/1471-2164-14-293.

[2] Pan Du, Xiao Zhang, Chiang-Ching Huang, Nadereh Jafari, Warren A Kibbe, Lifang
Hou, and Simon M Lin. Comparison of Beta-value and M-value methods for quantifying
methylation levels by microarray analysis. BMC Bioinformatics, 11:587, 2010. doi:
10.1186/1471-2105-11-587, PMID:21118553.

[3] Marina Bibikova, Bret Barnes, Chan Tsan, Vincent Ho, Brandy Klotzle, Jennie M Le,
David Delano, Lu Zhang, Gary P Schroth, Kevin L Gunderson, Jian-Bing Fan, and
Richard Shen. High density DNA methylation array with single CpG site resolution.
Genomics, 98(4):288–295, 2011. doi:10.1016/j.ygeno.2011.07.007, PMID:21839163.

[4] Sarah Dedeurwaerder, Matthieu Defrance, Emilie Calonne, H´el`ene Denis, Christos
Sotiriou, and Fran¸cois Fuks. Evaluation of the Infinium Methylation 450K technology.
Epigenomics, 3(6):771–784, 2011. doi:10.2217/epi.11.105, PMID:22126295.

[5] Sarah Dedeurwaerder, Matthieu Defrance, Martin Bizet, Emilie Calonne, Gianluca
Bontempi, and Fran¸cois Fuks. A comprehensive overview of infinium humanmethy-
lation450 data processing. Briefings in Bioinformatics, 15(6):929–941, 2014. doi:
10.1093/bib/bbt054, PMID:23990268.

[6] Marcos Oliveira Prates, Celso Rˆomulo Barbosa Cabral, and V´ıctor Hugo Lachos. mixsmsn:
Fitting finite mixture of scale mixture of skew-normal distributions. Journal of Statistical
Software, 54(12):1–20, 2013. URL: http://www.jstatsoft.org/v54/i12/.

[7] Rodrigo M. Basso, V´ıctor H. Lachos, Celso Rˆomulo Barbosa Cabral, and Pulkak
Ghosh. Robust mixture modeling based on scale mixtures of skew-normal distribu-
tions. Computational Statistics and Data Analysis, 54(12):2926–2941, 2010. doi:doi:
10.1016/j.csda.2009.09.031.

[8] Sean Davis, Pan Du, Sven Bilke, Tim Triche, Jr., and Moiz Bootwalla. methylumi:

Handle Illumina methylation data, 2014. R package version 2.12.0.

12

[9] Jovana Maksimovic, Lavinia Gordon, and Alicia Oshlack. SWAN: Subset quantile
Within-Array Normalization for Illumina Infinium HumanMethylation450 BeadChips.
Genome Biology, 13(6):R44, 2012. doi:10.1186/gb-2012-13-6-r44, PMID:22703947.

[10] Kasper Daniel Hansen, Martin Aryee, and Winston Timp. minfiData: Example data for

the Illumina Methylation 450k array. R package version 0.7.1.

[11] Leonard C Schalkwyk, Ruth Pidsley, Chloe CY Wong, Nizar Touleimat, Matthieu
Defrance, Andrew Teschendorff, and Jovana Maksimovic. wateRmelon: Illumina 450
methylation array normalization and metrics, 2013. R package version 1.5.1.

[12] Martin J Aryee, Andrew E Jaffe, Hector Corrada Bravo, Christine Ladd-Acosta, An-
drew P Feinberg, Kasper D Hansen, and Rafael A Irizarry. Minfi: a flexible and compre-
hensive Bioconductor package for the analysis of Infinium DNA methylation microar-
rays. Bioinformatics, 30(10):1363–1369, 2014. doi:10.1093/bioinformatics/btu049,
PMID:24478339.

[13] The Cancer Genome Atlas Research Network. Genomic and epigenomic landscapes of
adult de novo acute myeloid leukemia. New England Journal of Medicine, 368(22):2059–
74, May 30 2013. (data accessible at NCBI GEO database (Edgar et al., 2002), accession
GSE49618). doi:DOI:10.1056/NEJMoa1301689, PMID:23634996.

13


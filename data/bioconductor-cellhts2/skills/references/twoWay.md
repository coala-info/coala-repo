Analysis of screens with enhancer and suppressor
controls

L´ıgia Br´as, Michael Boutros and Wolfgang Huber

April 24, 2017

Contents

1 Introduction

2 Assembling the data

2.1 Reading the raw intensity ﬁles . . . . . . . . . . . . . . . . . .
2.2 Conﬁguring and annotating the cellHTS object . . . . . . . .

3 Data preprocessing and summarization of replicates

4 Session info

1

Introduction

1

2
2
3

5

8

This technical report is a supplement of the main vignette End-to-end anal-
ysis of cell-based screens: from raw intensity readings to the annotated hit
list that is given as part of the cellHTS2 package.

The report explains how the cellHTS2 package can be used to document
and analyse enhancer-suppressor screens (or two-way assays), where we can
have two types of eﬀectors: activators (or enhancers) and inhibitors (or
repressors). In such cases, both type of eﬀectors are used as positive controls,
and they need to be considered indivually by the cellHTS2 package.

This text has been produced as a reproducible document [1], containing
the actual computer instructions, given in the language R, to produce all
results, including the ﬁgures and tables that are depicted here. To reproduce
the computations shown here, you will need an installation of R (version 2.3
or greater) together with a recent version of the package cellHTS2 and of
some other add-on packages. Then, you can simply take the ﬁle twoWay.Rnw

1

Filename Plate Replicate Channel
1
...

DHA001LU1.CSV
...

1
...

1
...

Table 1: Selected lines from the example plate list ﬁle Platelist.txt.

in the doc directory of the package, open it in a text editor, run it using the
R command Sweave, and modify it according to your needs.

We start by loading the package.

> library("cellHTS2")

2 Assembling the data

The example data set corresponds to one 96-well plate of an enhancer-
suppressor screen performed with human cells. The screen was performed
in duplicate, and a luminescence-reporter was used in the assay.

2.1 Reading the raw intensity ﬁles

The set of available result ﬁles and the information about them (which plate,
which replicate) is given in the plate list ﬁle. The ﬁrst line of the plate list
ﬁle for this data set is shown in Table 1.

The path for the raw data is deﬁned below:

> experimentName <- "TwoWayAssay"
> dataPath <- system.file(experimentName, package="cellHTS2")

The input ﬁles are in the TwoWayAssay directory of the cellHTS2 package.
The function readPlateList of cellHTS2 package reads the plate list ﬁle,
and the intensity ﬁles, assembling the data into a single R object. In this
example, the raw intensity ﬁles correspond to csv ﬁles, in which the ﬁrst
part consists of data from the acquisition instrument, while the relevant
data values are in the 12 × 8 matrix at the end of the ﬁle. So, we need to
give as argument to readPlateList, a function suitable to import such data
ﬁle format. This function, which we named importData, is given in the same
directory as the data ﬁles, in a R ﬁle with the same name, and needs to be
sourced:

> source(file.path(dataPath, "importData.R"))

2

Finally, we call readPlateList:

> x <- readPlateList("Platelist.txt", name=experimentName,
+

importFun=importData, path=dataPath)

> x

cellHTS (storageMode: lockedEnvironment)
assayData: 96 features, 2 samples

element names: Channel 1

phenoData

sampleNames: 1 2
varLabels: replicate assay
varMetadata: labelDescription channel

featureData

featureNames: 1 2 ... 96 (96 total)
fvarLabels: plate well controlStatus
fvarMetadata: labelDescription

’

experimentData(object)

’

experimentData: use
state: configured = FALSE
normalized = FALSE
scored = FALSE
annotated = FALSE

Number of plates: 1
Plate dimension: nrow = 8, ncol = 12
Number of batches: 1

2.2 Conﬁguring and annotating the cellHTS object

The plate conﬁguration ﬁle gives the information about the content of the
plate wells, which is used by the software to annotate the measured data.
The content of this ﬁle is shown in Table 2. For the sample data, there
is no screen log ﬁle, meaning that no measurements were marked to be
ﬂagged during the assay. Another ﬁle necessary for the conﬁguration step
of the cellHTS object is the screen description ﬁle, which gives a general
description of the screen.

> x <- configure(x, descripFile = "Description.txt",
+

confFile="Plateconf.txt", path=dataPath)

3

Wells:
Plates:
Plate
*
*
*
*
*
*
*

96
1
Content Comment
Well
NA
sample
*
mock
mock
[A,H]0[1-2]|D02|E01
GFP
GFP
B01|G02
DDIT3
empty
B02|G01
up
C01|F02
AATK
down
C02|F01 MAP2K6
CD14
empty
D01|E02

Table 2: Selected lines from the example plate conﬁguration ﬁle Plate-
conf.txt.

Plate Well GeneID GeneSymbol
AAK1
AATK
CERK
RAPGEF4
...

22848
9625
64781
11069
...

A03
A04
A05
A06
...

1
1
1
1
...

Table 3: Selected lines from the example gene ID ﬁle GeneIDs.txt.

4

In this data set, instead of using the default names pos and neg for positive
and negative controls, respectively, we used the names of the target genes.
Thus, the well annotation in this sample plate looks like this 1:

> table(wellAnno(x))

sample
80

mock
6

gfp empty
4

2

aatk map2k6
2

2

Here, AATK, ATTK and MAP2K6 are positive controls, whereas GFP and
mock (mock transfection) correspond to negative controls. We shall return
to this issue in Section 3, but now, we proceed to the next step of data
assemble, whereby we add the annotation information to x. This information
is in the screen annotation ﬁle, and Table 3 shows the ﬁrst 5 lines of this ﬁle.
Besides the mandatory columns Plate, Well and GeneID, the ﬁle contains
the optional column GeneSymbol, whose content is used for the tooltips
display in the HTML quality reports that will be produced later on.

> x <- annotate(x, geneIDFile="GeneIDs.txt", path=dataPath)

3 Data preprocessing and summarization of repli-

cates

We can take a ﬁrst look at the data by constructing the HTML quality re-
ports using the writeReport function. For that, we must deﬁne the positive
and negative controls needed when calling this function.

For an enhancer-suppressor screen, the argument posControls of writeRe-
port should be deﬁned as a list with two components: act (for activator or
enhancers) and inh (for inhibitors or suppressors), which should be deﬁned
as vectors of regular expressions with the same length as the number of chan-
nels (in this case, length one). These arguments are passed to the regexpr
function for pattern matching within the well annotation (wellAnno(x)).

In the example presented here, in the positive controls, we have AATK
and ATTK as enhancers, and MAP2K6 as an inhibitor eﬀector. The nega-
tive controls are GFP and the mock transfection (indicated as mock in the

1Note that when reading the plate conﬁguration ﬁle, the conﬁgure function puts the
content of the column Content in lowercase. However, the orignal content of this column
(and the plate conﬁguration ﬁle) is stored in slot plateConf of the cellHTS object - see
plateConf(x)$Content.

5

plate conﬁguration ﬁle). Thus, we deﬁne the negative and positive controls
as follows:

> negCtr <- "(?i)^GFP$|^mock$"
> posCtr <- list(act = "(?i)^AATK$|^ATTK$", inh = "(?i)^MAP2K6$")

Finally, we construct the quality report pages for the raw data in a directory
called 2Wraw, in the working directory:

> setSettings(list(platelist=list(intensities=list(range=c(300, 4000),
+
> out <- writeReport(raw=x, outdir="2Wraw",
+

posControls=posCtr, negControls=negCtr)

include=TRUE))))

After this function has ﬁnished, we can view the index page of the report:

> browseURL(out)

As can be seen in the HTML reports, the dynamic range for each replicate
(and the respective average) was calculated separately for the activators and
inhibitors.

Next, we normalize the data using a simple approach. First we log2
transformed to make the data scale additive. Then, for each replicate, the
plate intensity values at the negative control wells are taken as a correction
factor, so that each plate measurement is subtracted by it.

> xn <- normalizePlates(x, scale="multiplicative", log=TRUE, method ="negatives",
+

varianceAdjust="none", negControls = negCtr)

The normalized intensities are stored in the slot assayData of xn. This
slot can be assessed as an array with dimensions equal to the total number
of features (product between the plate dimension and the total number of
plates) x number of samples (or replicates) x number of channels (in this
case, 1).

> xnorm <- Data(xn)
> dim(xnorm)

Features Samples Channels
1

96

2

6

Below, we call the function scoreReplicates to determine the z-score val-
ues for each replicate, and the function summarizeReplicates to summarize
the replicate score values by taking the average. A more conservative ap-
proach would be to consider the z-score value closest to zero between repli-
cates (summary=’closestToZero’).

> xsc <- scoreReplicates(xn, sign="+", method="zscore")
> xsc <- summarizeReplicates(xsc, summary="mean")

The resulting single z-score value per probe were stored again in the slot
assayData of xsc. Figure 1 shows the boxplots of the z-scores for the
diﬀerent types of probes (the ”empty” wells were excluded from the plot).

> ylim <- quantile(Data(xsc), c(0.001, 0.999), na.rm=TRUE)
> wa <- factor(as.character(wellAnno(xsc)), exclude="empty")
> boxplot(Data(xsc) ~ wa, col="lightblue", main="scores", outline=FALSE, ylim=ylim, xaxt="n")
> lab <- unique(plateConf(xsc)$Content)
> lab <- lab[match(levels(wa), tolower(lab))]
> axis(1, at=c(1:nlevels(wa)), labels=lab)

# to exclude "empty" wells

Now that the data have been normalized, scored and summarized between
replicates, we call again writeReport and use a web browser to view the
resulting report:

> setSettings(list(platelist=list(intensities=list(range=c(-1, 1), include=TRUE)),
+
> out <- writeReport(raw=x, normalized=xn, scored=xsc,
+

outdir="2Wnormalized", posControls=posCtr, negControls=negCtr)

screenSummary=list(scores=list(range=c(-2,3)))))

> browseURL(out)

The quality reports have been created in the folder 2Wnormalized in the
working directory. Now the report shows also controls-related plots, dis-
tinguishing the two types of positive controls (enhancers and suppressors).
Furthermore, the report shows the image plot with the ﬁnal scored and
summarized values for the whole data set. Finally, we save the scored and
summarized cellHTS object to a ﬁle.

> save(xsc, file=paste(experimentName, ".rda", sep=""))

7

Figure 1: Boxplots of z-scores for the diﬀerent types of probes.

4 Session info

This document was produced using:

> toLatex(sessionInfo())

(cid:136) R version 3.4.0 (2017-04-21), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C,

LC_TIME=en_US.UTF-8, LC_COLLATE=C, LC_MONETARY=en_US.UTF-8,
LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.2 LTS

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so

8

−4−2024scoresAATKGFPMAP2K6mocksample(cid:136) LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, grid, methods,

parallel, stats, stats4, utils

(cid:136) Other packages: AnnotationDbi 1.38.0, Biobase 2.36.0,
BiocGenerics 0.22.0, Category 2.42.0, GO.db 3.4.1,
GSEABase 1.38.0, IRanges 2.10.0, KEGG.db 3.2.3, Matrix 1.2-9,
RColorBrewer 1.1-2, S4Vectors 0.14.0, XML 3.98-1.6,
annotate 1.54.0, cellHTS2 2.40.0, geneﬁlter 1.58.0, graph 1.54.0,
hexbin 1.27.1, hwriter 1.3.2, locﬁt 1.5-9.1, splots 1.42.0, vsn 3.44.0

(cid:136) Loaded via a namespace (and not attached): BiocInstaller 1.26.0,
DBI 0.6-1, DEoptimR 1.0-8, KernSmooth 2.23-15, MASS 7.3-47,
RBGL 1.52.0, RCurl 1.95-4.8, RSQLite 1.1-2, Rcpp 0.12.10,
aﬀy 1.54.0, aﬀyio 1.46.0, bitops 1.0-6, cluster 2.0.6, colorspace 1.3-2,
compiler 3.4.0, digest 0.6.12, ggplot2 2.2.1, gtable 0.2.0, labeling 0.3,
lattice 0.20-35, lazyeval 0.2.0, limma 3.32.0, memoise 1.1.0,
munsell 0.4.3, mvtnorm 1.0-6, pcaPP 1.9-61, plyr 1.8.4, prada 1.52.0,
preprocessCore 1.38.0, robustbase 0.92-7, rrcov 1.4-3, scales 0.4.1,
splines 3.4.0, survival 2.41-3, tibble 1.3.0, tools 3.4.0, xtable 1.8-2,
zlibbioc 1.22.0

References

[1] Robert Gentleman. Reproducible research: A bioinformatics case study.
Statistical Applications in Genetics and Molecular Biology, 3, 2004. 1

9


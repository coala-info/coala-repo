Analysis of Pairwise Interaction Screens

Bernd Fischer

October 30, 2017

Contents

1 Introduction

2 Installation of the RNAinteract package

3 Creating an RNAinteract object

4 Single Perturbation eﬀects and pairwise interactions

5 Data Access

6 Graphical Output

7 A HTML-report

8 Session Info

1 Introduction

1

1

2

4

4

7

9

10

The package contains an analysis pipeline for data from quantitative interaction screens. The package is the
basis for the analysis of an RNAi interaction screen reported in

Thomas Horn, Thomas Sandmann, Bernd Fischer, Elin Axelsson, Wolfgang Huber,
and Michael Boutros (2011):Mapping of Signalling Networks through Synthetic Genetic
Interaction Analysis by RNAi, Nature Methods 8(4): 341-346.

This package provides the software that implements the methods used in this paper; these methods are further
described in the Supplemental Methods section of the paper.

2 Installation of the RNAinteract package

To install the package RNAinteract, you need a running version of R (www.r-project.org, version ≥ 2.13.0).
After installing R you can run the following commands from the R command shell to install RNAinteract and
all required packages.

> source("http://bioconductor.org/biocLite.R")
> biocLite("RNAinteract")

The R code of this vignette can be accessed in the Sweave ﬁle RNAinteract.Rnw. The R code is extracted from
the Sweave ﬁle and written to a ﬁle RNAinteract.R by

> Stangle(system.file("doc", "RNAinteract.Rnw", package="RNAinteract"))

1

3 Creating an RNAinteract object

The package RNAinteract is loaded by the following command.

> library("RNAinteract")

In the package included is an example for a small genetic interaction screen. Text ﬁles containing a description
of the design of the screen and the screen data are located in the following directory.

> inputpath = system.file("RNAinteractExample",package="RNAinteract")
> inputpath

The directory inputpath contains ﬁve text ﬁles:
Targets.txt, Reagents.txt, TemplateDesign.txt, QueryDesign.txt, Platelist.txt.
Open these ﬁles in a text editor to inspect the ﬁle format.
The ﬁrst ﬁle (Targets.txt) contains information about the targeted genes. The three columns TID, Symbol,
and group are required. Optionally other columns can be added. TID is a unique identiﬁer for the target
gene. Preferably, this is the ENSEMBL gene identiﬁer or the identiﬁer of another reference database. A short,
human-readable gene name is provided in the column Symbol. The column group should contain a grouping of
the genes into sample genes, negative (neg), or positive (pos) controls. The grouping is used later on, in quality
control plots, or in displays such as the heatmap where the control data need to be omitted.

> inputfile <- system.file("RNAinteractExample/Targets.txt",package="RNAinteract")
> T <- read.table(inputfile, sep="\t", stringsAsFactors=FALSE, header=TRUE)
> head(T)

TID Symbol group

bsk sample FBgn0000229
1 FBgn0000229
Jra sample FBgn0001291
2 FBgn0001291
kay sample FBgn0001297
3 FBgn0001297
Sos sample FBgn0001965
4 FBgn0001965
pyd sample FBgn0003177
5 FBgn0003177
6 FBgn0003205 Ras85D sample FBgn0003205

GID AnnotationSymbol
Name
basket
CG5680
CG2275 Jun-related antigen
kayak
Son of sevenless
polychaetoid
CG9375 Ras oncogene at 85D

CG33956
CG7793
CG31349

The ﬁle Reagents.txt contains the n : 1 mapping of reagents to target genes.
In the example screen each
gene is targeted by two independet dsRNA designs. The mandatory columns are RID (a unique identiﬁer of the
ragent) and TID (the target gene identiﬁer as deﬁned in the ﬁle Targets). Optionally, additional columns such
as RNA sequences can be added.

> inputfile <- system.file("RNAinteractExample/Reagents.txt",package="RNAinteract")
> T <- read.table(inputfile, sep="\t", stringsAsFactors=FALSE, header=TRUE)
> head(T[,c("RID", "TID", "PrimerSeqFor","PrimerSeqRev","Length")])

RID

TID

PrimerSeqFor

1 SGI00002 FBgn0000229 ATAGACTTTTCCCCGATGGC CCTCAGCATCATACCACACG
2 SGI00005 FBgn0001291 TCAACTCACCGGATCTGTCA TTGTGTAAGGCCTCCTCGAA
3 SGI00006 FBgn0001297 AAAGGTGCTACCCAATGCC AGTATCGGTCGTGTCCTGCT
4 SGI00007 FBgn0001965 CAGGACGACATCGAGAGCTT AGTGCTCCACCTTCATTTGG
5 SGI00010 FBgn0003177 CTGGGACGATGTGGTCTTCT ATCCTGCAGTGGAGTCGAAA
6 SGI00011 FBgn0003205 ATGGAGAGACCTGCCTGCT CTTTACGCGCTTGATCTGCT

PrimerSeqRev Length
174
175
175
175
175
173

The screen design is assumed to be a template-query design. A template plate contains in each well a diﬀerent
reagent. There may be multiple template plates to cover the whole set of reagents. Afterwards one query
reagent will be added to each well on the template plates. By this strategy a matrix of double RNAi treatments
is obtained. One can either choose to screen all selected genes against all selected genes, or some number of
template genes against another number of query genes. The ﬁle TemplateDesign.txt contains information
about the template plate design. TemplatePlate is the number of the template plate. Numbering starts with
1. In the example there is only one template plate; in other applications, there may be multiple template plates.
Well is a single letter followed by a number and identiﬁes the well coordinates within the plates. RID deﬁnes
the reagent in the respective well with the same identiﬁer as in the ﬁle Reagents.txt. In the example screen

2

there are 48 diﬀerent template reagents. These span the left hand side of the multiwell plate. The right hand
side is ﬁlled with the same reagents and will be covered with a diﬀerent query reagent from the left hand side.
To distinguish which query is spotted on each well the last column QueryNr denotes the number of the query.
In the example the left hand side gets the query number 1, the right hand side gets the query number 2.

> inputfile <- system.file("RNAinteractExample/TemplateDesign.txt",package="RNAinteract")
> T <- read.table(inputfile, sep="\t", stringsAsFactors=FALSE, header=TRUE)
> head(T)

TemplatePlate Well

1
2
3
4
5
6

1
1
1
1
1
1

A1 SGI00013
A2 SGI00017
A3 SGI00021
A4 SGI00109
A5 SGI00113
A6 SGI00117

RID QueryNr
1
1
1
1
1
1

The ﬁle QueryDesign.txt speciﬁes the query genes on each physical plate in the screen design. The plates are
numbered starting from 1. In the example there are two diﬀerent query reagents on the same physical plate:
One on the left half of the plate and one on the right half of the plate.

> inputfile <- system.file("RNAinteractExample/QueryDesign.txt",package="RNAinteract")
> T <- read.table(inputfile, sep="\t", stringsAsFactors=FALSE, header=TRUE)
> head(T)

Plate TemplatePlate QueryNr

1
2
3
4
5
6

1
1
2
2
3
3

1
1
1
1
1
1

RID
1 SGI00005
2 SGI00007
1 SGI00011
2 Ctrl_Fluc
1 SGI00089
2 SGI00101

In many cases a screen is repeated (as technical or biological replicates) or it is conducted under multiple
conditions (e.g. with an additional drug). In the following, we will refer to either replicates or diﬀerent conditions
as screens. Furthermore the plates are usually numbered with a platebarcode. The ﬁle Platelist.txt shows
in which ﬁle the readout data is stored (column Filename), and which Platebarcode is associated with which
Plate as deﬁned in the query design and which replicate it represents.

> inputfile <- system.file("RNAinteractExample/Platelist.txt",package="RNAinteract")
> T <- read.table(inputfile, sep="\t", stringsAsFactors=FALSE, header=TRUE)
> head(T)

1 DataRNAinteractExample_1.txt
2 DataRNAinteractExample_1.txt
3 DataRNAinteractExample_1.txt
4 DataRNAinteractExample_1.txt
5 DataRNAinteractExample_1.txt
6 DataRNAinteractExample_1.txt

Filename Platebarcode Plate Replicate
1
1
1
1
1
1

PLATE11001
PLATE11002
PLATE11003
PLATE11004
PLATE11005
PLATE11006

1
2
3
4
5
6

The platelist in the example says that the data is distributed in two ﬁles. The ﬁrst ﬁle is shown below. Beside
the mandatory columns Platebarcode and Well there is a column for each quantitative value (readout channel)
that is measured within each well.

> inputfile <- system.file("RNAinteractExample/DataRNAinteractExample_1.txt",package="RNAinteract")
> T <- read.table(inputfile, sep="\t", stringsAsFactors=FALSE, header=TRUE)

The data and annotation are loaded and an RNAinteract object is created with the following command.

3

> sgi = createRNAinteractFromFiles(name="RNAi interaction screen", path = inputpath)
> sgi

Multiple pairwise interaction screens with the same annotation can be stored in one RNAinteract object, e.g.
if the screen is replicated or if the screen is repeated under multiple conditions. Here, the object sgi contains
two replicate screens. Multiple readout channels can be captured in the same object as well. In this case we
have three channels.

> getChannelNames(sgi)

[1] "nrCells"

"area"

"intensity"

4 Single Perturbation eﬀects and pairwise interactions

The functions for manipulating the RNAinteract object are working as follows: the RNAinteract-object is given
as the ﬁrst argument of each function. The function performs some calculations and stores the result again in
the object that is returned by the functions.
First, the single perturbation eﬀects (called main eﬀects) are estimated from the data. For each template
position and for each query reagent a main eﬀect is estimated.

> sgi <- estimateMainEffect(sgi, use.query="Ctrl_Fluc")

If the main eﬀects contain time or plate dependent trends, these can be adjusted and removed (”normalized”).
The normalization of the main eﬀects does not inﬂuence the subsequent estimation of the pairwise interactions,
but it makes the main eﬀects better comparable between replicates and diﬀerent screens.
When the main eﬀects are available, the pairwise interaction term can be estimated.

> sgi <- computePI(sgi)

The object sgi contains two replicate screens. We summarize these two screens by taking the mean value for
each measurement and add the mean screen as a new screen to the original screen.

> sgim <- summarizeScreens(sgi, screens=c("1","2"))
> sgi3 <- bindscreens(sgi, sgim)

The p-values are computed by

> sgi3 <- computePValues(sgi3)
> sgi3limma <- computePValues(sgi3, method="limma")
> sgi3T2 <- computePValues(sgi3, method="HotellingT2")

independently for each screen and each channel. The genetic interaction scores for each gene pair are tested
against the null-hypothesis that the interaction term is zero. It is a two sided test. For sgi3, a conservatie test
is used, that regularizes the variance term in the t-statistic by taking the maximum of the empirical variance per
gene pair, and a global value obtained from a pooled within-group variance across all data. p-values are derived
from a t-statistics with n-1 degrees of freedom. sgi3limma contains p-values derived by limma (See R-package
limma). limma uses a more gradual moderation between the local and the global variance estimate. The object
sgi3T2 will contain p-values derived from a Hotelling T 2 test, where the deviation from the non-interactiong
model is tested in a multivariate manner in all channel dimensions.

5 Data Access

The main function for data access is getData. The raw data can be accessed in diﬀerent formats. The code
below shows the access of the raw data in plain format, in plate layout, and as a matrix of genes. Usually
the data stored in the RNAinteract object is log-transformed. Therefore the inverse transformation has to be
applied to obtain the raw input data.

4

> data("sgi")
> D <- getData(sgi, type="data", do.inv.trafo = TRUE)
> Dplatelayout <- getData(sgi, type="data",
+
> splots::plotScreen(Dplatelayout[["1"]][["nrCells"]],
nx=sgi@pdim[2], ny=sgi@pdim[1], ncol=3)
+
> Dmatrix <- getData(sgi, type="data",
+

format="platelist", do.inv.trafo = TRUE)

format="targetMatrix", do.inv.trafo = TRUE)

One can access the raw data of a single screen or single readout channel.

> data("sgi")
> D <- getData(sgi, screen="2", channel="nrCells",
+

type="data", do.inv.trafo = TRUE, format="targetMatrix")

The main eﬀects can be accessed in the same way and displayed in plate layout. In this case the main eﬀects
are returned in a log-transformed way.

> Mplatelayout <- getData(sgi, type="main", design="template",
+
> splots::plotScreen(Mplatelayout, nx=sgi@pdim[2], ny=sgi@pdim[1],
+

screen="1", channel="nrCells", format="platelist")

ncol=3)

5

13.51414.51515.51616.5Dplatelayout[["1"]][["nrCells"]]142536The expected values from the non-interacting model, pairwise interaction scores, p-values and q-values can be
accessed in the same way. p- and q-values can not be accessed in plain format or plate layout format, because
they are not values of a single experiment.

> NImatrix <- getData(sgi, type="ni.model", format="targetMatrix")
> PImatrix <- getData(sgi, type="pi", format="targetMatrix")
> PIplatelayout <- getData(sgi, type="main", design="query",
+
> splots::plotScreen(PIplatelayout, nx=sgi@pdim[2], ny=sgi@pdim[1],
+
> p.value <- getData(sgi, type="p.value", format="targetMatrix")
> q.value <- getData(sgi, type="q.value", format="targetMatrix")

screen="1", channel="nrCells", format="platelist")

ncol=3)

6

−2−1.5−1−0.500.511.52Mplatelayout1425366 Graphical Output

A heatmap is plotted with negative interactions colored blue and positive interactions colored yellow. To display
the heatmap, one has to select the screen and the channel to be displayed.

> plotHeatmap(sgi, screen="1", channel="nrCells")

7

−2−1.5−1−0.500.51PIplatelayout142536A double RNAi plot shows the interaction proﬁle for one gene. Each dot corresponds to one gene pair containing
the selected query gene (Ras85D) and one other gene. The x-axis depicts the single RNAi eﬀect of the other
gene. The y-axis shows the double RNAi eﬀect of the gene pair. If the gene pair is not interacting, the dot lies
on the orange, diagonal line. If the double RNAi eﬀect is equal to the single RNAi eﬀect of one of the genes
(Epistasis), the dot lies on one of the blue lines.

> plotDoublePerturbation(sgi, screen="1", channel="nrCells", target="Ras85D")

8

PvrGap1Rho1Ptp61FkaymsnbsksharkmbtPdpMkk4Gadd45CkaDsor1mskcdc14synjGef26CG10089pydCG9784Btk29ACG7115JrarlSosRas85D−0.40.4p−score7 A HTML-report

To generate a HTML report, ﬁrst, the outputpath has to be deﬁned. With startReport a HTML-page is opened
for writing. The function returns a report object report. This object is handed over to the report functions.
In the following example, the annotation (reportAnnotation) is written to the HTML-ﬁle, then a hit list for the
pooled variance t-test (reportGeneLists(sgi3, ...)) and the limma t-test (reportGeneLists(sgi3limma, ...))
is added.

> outputpath = "RNAinteractHTML"
> report = startReport(outputpath)
> reportAnnotation(sgi3, path = outputpath, report = report)
> reportStatistics(sgi3, path = outputpath, report = report)
> reportGeneLists(sgi3, path = outputpath, report = report)
> reportGeneLists(sgi3limma, path = outputpath, dir="hitlistlimma",
+

prefix = "hitlistlimma", report = report)

For further quality control, we compare the estimated main eﬀects by scatter plots. To check for plate and edge
eﬀects in the screen we generate screen plots for the input data as well as for the estimated pairwise interactions.

> reportMainEffects(sgi3, path = outputpath, report = report)
> reportScreenData(sgi3, plotScreen.args=list(ncol=3L, do.legend=TRUE,
+
+

path = outputpath, report = report)

fill = c("red","white","blue")),

Double perturbation plots are generated for each gene, each screen, and each channel to observe the genetic
interaction proﬁle of a single gene.

9

−2.5−2−1.5−1−0.50−2.5−2−1.5−1−0.50single perturbation leveldouble perturbation levellllllllllllllllllllllllDouble Perturbation Plot of Ras85D, screen 1 (nrCells)> reportDoublePerturbation(sgi3, path = outputpath, report = report,show.labels="p.value")

For each screen and each channel a heatmap is added to the report by

> reportHeatmap(sgi, path=outputpath, report=report)

The report is closed by a call to endReport.

> save(sgi, file=file.path(outputpath, "RNAinteractExample.rda"))
> endReport(report)

Finally the report can be opened in a browser.

> browseURL(file.path(outputpath, "index.html"))

8 Session Info

> sessionInfo()

R version 3.4.2 (2017-09-28)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] parallel stats
[8] base

graphics grDevices utils

datasets methods

other attached packages:
[1] RNAinteract_1.26.0 Biobase_2.38.0
[4] locfit_1.5-9.1

abind_1.4-5

BiocGenerics_0.24.0

loaded via a namespace (and not attached):

mvtnorm_1.0-6
digest_0.6.12
pcaPP_1.9-72
ggplot2_2.2.1
zlibbioc_1.24.0
annotate_1.56.0
S4Vectors_0.16.0

[1] Rcpp_0.12.13
[4] gtools_3.5.0
[7] stats4_3.4.2
[10] survey_3.32-1
[13] gplots_3.0.1
[16] lazyeval_0.2.1
[19] blob_1.1.0
[22] preprocessCore_1.40.0 splines_3.4.2
[25] RCurl_1.95-4.8
[28] compiler_3.4.2
[31] XML_3.98-1.9
[34] bitops_1.0-6
[37] ICSNP_1.1-0
[40] GSEABase_1.40.0
[43] DBI_0.7

bit_1.1-12
tibble_1.3.4
rrcov_1.4-3
RBGL_1.54.0
prada_1.54.0
gtable_0.2.0
scales_0.5.0

lattice_0.20-35
plyr_1.8.4
RSQLite_2.0
BiocInstaller_1.28.0
rlang_0.1.2
gdata_2.18.0
Matrix_1.2-11
geneplotter_1.56.0
munsell_0.4.3
IRanges_2.12.0
MASS_7.3-47
grid_3.4.2
xtable_1.8-2
affy_1.56.0
graph_1.56.0

10

[46] KernSmooth_2.23-15
[49] affyio_1.48.0
[52] robustbase_0.92-7
[55] ICS_1.3-0
[58] DEoptimR_1.0-8
[61] colorspace_1.3-2
[64] caTools_1.17.1
[67] splots_1.44.0

genefilter_1.60.0
limma_3.34.0
RColorBrewer_1.1-2
bit64_0.9-7
survival_2.41-3
cluster_2.0.6
memoise_1.1.0

hwriter_1.3.2
latticeExtra_0.6-28
tools_3.4.2
Category_2.44.0
AnnotationDbi_1.40.0
vsn_3.46.0
cellHTS2_2.42.0

11


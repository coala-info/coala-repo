Rcade: R-based analysis of ChIP-seq And Differ-
ential Expression data

Jonathan Cairns

October 30, 2018

Contents

1

2

3

4

5

6

7

8

Introduction .

Model

.

.

.

.

.

.

.

.

.

.

Simple workﬂow .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

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

.

.

.

Preliminary .
3.1.1
3.1.2
3.1.3
3.1.4

.
.
.
.
DE summary .
ChIP-seq data .
.
Annotation information .
.
Prior speciﬁcation .

.
.
.

.
.
.

.
.
.

.

3.2

Analysis function .

Plotting, QC .

Output .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Questions/Bug reports .

Session Info .

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
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

.

.

.
.
.
.
.

.

.

.

.

.

.

.

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
3
3
4
5

5

6

. 11

. 11

. 11

. 12

1

Introduction

Rcade is a tool that analyses ChIP-seq data and couples the results to an existing Diﬀerential Expression
(DE) analysis. A key application of Rcade is in inferring the direct targets of a transcription factor (TF) -
these targets should exhibit TF binding activity, and their expression levels should change in response to a
perturbation of the TF.

Rcade: R-based analysis of ChIP-seq And Differential Expression data

The ChIP-seq analysis element of Rcade is performed through methods from the baySeq package, with
respect to a user-deﬁned universe of potential binding sites. This means that Rcade avoids the noise issues
associated with peak-calling and focuses instead on robust quantiﬁcation of binding activity. Any universe
can be selected, and Rcade provides functionality to accommodate the common case where bins are deﬁned
relative to genomic annotation features.

In some situations, it may be appropriate to deﬁne the binding site universe based on a set of peak-calls from
other data sets. However, it is inappropriate to use peak-calls from the ChIP-seq data used in the Rcade
analysis - such an analysis would be prone to conﬁrmation bias.

Rcade uses a fully Bayesian modelling approach. In particular, it uses log-odds values, or B-values, in both
its input and output. The log-odds value is related to the posterior probability (P P ) of an event, as per the
formula B = log

. P P -values should not be confused with the frequentist concept of p-values.

(cid:17)

(cid:16) P P
1−P P

2

Model

Rcade perform analysis on any set of genes, with each gene uniquely identiﬁed by a gene ID. In the below
example, we use Ensembl gene IDs.

Each gene is assumed to have some number of associated binding sites, each of which can be active or
inactive as inferred from the ChIP-seq data. Additionally, every gene has one or more expression values, each
of which is either DE or not DE under some perturbation - for example, knockdown or stimulation of a TF
of interest. It is assumed that, conditional on a gene having both a ChIP-seq signal and a DE signature, the
ChIP-seq and expression data associated with that gene are independent. All pairwise interactions between
ChIP and DE data are considered for a given gene.

The “gene ID" need not literally refer to genes. For example, a user with transcript-speciﬁc expression data
could use transcript IDs instead.

3

Simple workﬂow

In this vignette, we will use the example data provided in the Rcade package. These data were obtained
from two sources, each pertaining to the transcription factor STAT1. All of the experiments were performed
with cells from the HeLa cell line. The two data sets are:

Diﬀerential Expression data from Array Express,

http://www.ebi.ac.uk/arrayexpress, under accession number E-GEOD-11299.
In this experiment,
HeLa cells were stimulated with IFNγ, and a time course microarray experiment was performed. We
have assessed DE status between the 0h and 6h time points.

STAT1 ChIP-seq data from the Snyder lab, as part of the ENCODE consortium

Input DCC accession numbers: wgEncodeEH000611 and wgEncodeEH000612
ChIP DCC accession number: wgEncodeEH000614
Here, HeLa cells were stimulated with IFNγ for 30 minutes, then cells were harvested and STAT1
ChIP-seq was performed.

To keep the size of the package down, all of these ﬁles have been truncated. Thus, they only contain data
pertinent to a handful of selected genes.

The location of these data ﬁles will vary from system to system. To ﬁnd the data directory on your computer,
use the following code:

2

Rcade: R-based analysis of ChIP-seq And Differential Expression data

> dir <- file.path(system.file("extdata", package="Rcade"), "STAT1")

> dir

3.1

Preliminary

Load the Rcade package:

> library(Rcade)

To perform an Rcade analysis, you will need the following input data:

3.1.1 DE summary

DE matrix: Bayesian information about the DE status of each gene. Any Bayesian source can be used for

this purpose:

• limma: Full DE results obtained with topTable(..., number=Inf)

• baySeq.

At time of writing, edgeR and DEseq do not supply Bayesian output.

The DE data must contain the following ﬁelds:

geneID - gene IDs used to link DE results to genes.

logFC - The log fold change associated with each gene.

B - B values (log-odds).

> DE <- read.csv(file.path(dir, "DE.csv"))

DElookup: We also need to tell Rcade which columns of the DE matrix are important. This is done using
an object of the form list(RcadeField1=DEdataField1, ...). You may omit the name RcadeField1
if it is the same as DEdataField1. Any ﬁelds that are speciﬁed in addition to the three required ﬁelds
above will not be manipulated in the analysis, but will be carried through and appear in the output.

> DElookup <- list(GeneID="ENSG", logFC="logFC", B="B",

+ "Genes.Location", "Symbol")

3.1.2 ChIP-seq data

.bam and .bai ﬁles: Sets of aligned reads. These reads should have already undergone sequence-level
pre-processing, such as any read trimming and adaptor removal that may be required. Moreover,
they should have appropriate index ﬁles - for example, using the indexBam function in the package
Rbamtools. Example .bam and .bai ﬁles are provided in the package:

> dir(dir, pattern = ".bam")

[1] "wgEncodeSydhTfbsHelas3InputIfng30StdAlnRep1.bam"

[2] "wgEncodeSydhTfbsHelas3InputIfng30StdAlnRep1.bam.bai"

3

Rcade: R-based analysis of ChIP-seq And Differential Expression data

[3] "wgEncodeSydhTfbsHelas3InputStdAlnRep1.bam"

[4] "wgEncodeSydhTfbsHelas3InputStdAlnRep1.bam.bai"

[5] "wgEncodeSydhTfbsHelas3Stat1Ifng30StdAlnRep1.bam"

[6] "wgEncodeSydhTfbsHelas3Stat1Ifng30StdAlnRep1.bam.bai"

[7] "wgEncodeSydhTfbsHelas3Stat1Ifng30StdAlnRep2.bam"

[8] "wgEncodeSydhTfbsHelas3Stat1Ifng30StdAlnRep2.bam.bai"

Targets information: A matrix containing information about the .Bam ﬁles to be used in the analysis.

Required ﬁelds:

ﬁleID – ID associated with the ﬁle.

sampleID – ID associated with the sample that was sequenced. Technical replicates of the same

population should have the same sampleID.

factor – The antibody used in the experiment. Control ﬁles should be labelled "Input".

ﬁlepath – The .bam ﬁle’s name/path.

Optional ﬁelds:

shift – Half of the fragment length. That is, before counting, Rcade will shift reads on the positive

strand forwards by shift, and reads on the negative strand backwards by shift.

> targets <- read.csv(file.path(dir, "targets.csv"), as.is = TRUE)

> targets

fileID sampleID factor

filepath shift

1 Input1

Input1 Input wgEncodeSydhTfbsHelas3InputIfng30StdAlnRep1.bam

2 Input2

Input2 Input

wgEncodeSydhTfbsHelas3InputStdAlnRep1.bam

3

4

ChIP1

ChIP2

ChIP1 Stat1 wgEncodeSydhTfbsHelas3Stat1Ifng30StdAlnRep1.bam

ChIP2 Stat1 wgEncodeSydhTfbsHelas3Stat1Ifng30StdAlnRep2.bam

0

0

0

0

3.1.3 Annotation information

In the ChIP-seq analysis, Rcade performs its analysis based on the counts in user-deﬁned bin regions. These
regions are speciﬁed with a GRanges object from the GenomicRanges package.

A common requirement is to deﬁne bins about genomic annotation features: Rcade provides simple func-
tionality to generate an appropriate GRanges object, through the defineBins() function. Since STAT1 is a
promoter-bound TF, we deﬁne bins about Ensembl-derived transcription start sites.

In this vignette, we use a very reduced annotation ﬁle as follows:

> anno <- read.csv(file.path(dir, "anno.csv"))
> anno <- anno[order(anno$chromosome_name),]
> colnames(anno) <- c("ENSG","chr","start","end","str")

Only use the preceding code to recreate the analysis in this vignette – do not use it at any other point!
When analysing genome-wide data, use full annotation information – for example, download full transcript
annotation information from Ensembl using biomaRt, as follows:

4

Rcade: R-based analysis of ChIP-seq And Differential Expression data

> library(biomaRt)

> anno <- getBM(

+

+

+

+

)

attributes= c("ensembl_gene_id", "chromosome_name",

"transcript_start", "transcript_end", "strand"),

mart= useDataset("hsapiens_gene_ensembl", useMart("ensembl"))

> ##order, to reduce size of ChIPannoZones object later
> anno <- anno[order(anno$chromosome_name),]
> ##use appropriate column names

> colnames(anno) <- c("ENSG","chr","start","end","str")

We deﬁne bins based on the annotation information through the defineBins() function, as follows:

> ChIPannoZones <- defineBins(anno, zone=c(-1500, 1500), geneID="ENSG")

The zone=c(-1500,1500) argument deﬁnes the zone of interest: it starts 1500bp 5(cid:48) of each TSS (-1500),
and ends 1500bp 3(cid:48) of each TSS (1500). This zone was chosen based on mapping peak-calls to TSSs using
the ChIPpeakAnno package, and plotting the positional distribution of these peak-calls.

The object ChIPannoZones can now be used in the Rcade analysis.

3.1.4 Prior speciﬁcation

By default, Rcade’s prior belief is that each gene’s DE and ChIP-seq statuses are independent. This is
unlikely to be true in real data, as genes with ChIP-seq signal are more likely to be DE than other genes.

Thus, we should give Rcade appropriate priors, if possible. For example, the prior dependency can be speciﬁed
as follows:

> DE.prior = 0.01

> prior.mode = "keepChIP"

> prior = c("D|C" = 0.05, "D|notC" = 0.005)

We specify DE.prior = 0.01 because that is the prior probability used by limma, the package that our DE
analysis was performed with. The remaining settings ensure that genes with ChIP-seq signal have a higher
than average probability of DE ("D|C" = 0.05), whereas genes without ChIP-seq signal have a lower that
average probability of DE ("D|notC" = 0.005).

(The values 0.05 and 0.005 were selected arbitrarily, before analysis. An advanced user might select prior
in a less arbitrary manner – for example, by looking at the overlap between ChIP-seq and DE in “similar"
datasets. We do not go into further details of such an analysis here.)

If you do not supply this information, you may get unreasonably small B values at the end of the analysis.

3.2

Analysis function

We can parallelize Rcade by supplying a compute cluster (though this is optional):

> library(parallel)

> cl <- makeCluster(4, "SOCK")

5

Rcade: R-based analysis of ChIP-seq And Differential Expression data

If you don’t have a compute cluster or a multicore machine, you can disable parallel processing:

> cl <- NULL

We now process the data with the RcadeAnalysis() function, obtaining an Rcade object:

> Rcade <- RcadeAnalysis(DE, ChIPannoZones, annoZoneGeneidName="ENSG",

ChIPtargets=targets, ChIPfileDir = dir,

cl=cl, DE.prior=DE.prior, prior.mode=prior.mode, prior=prior,

DElookup=DElookup)

+

+

+

.

> Rcade

Rcade: 57 rows, 15 columns.

DE: 59 rows, 13 columns.

ChIP: 1 track(s):

[[1]]

annoZones: GRanges with 48 ranges and 1 elementMetadata col.

shift:0

counts: 48 rows, 4 columns.

summary: 48 rows, 4 columns.

Metadata:

ChIPtargets: 4 rows, 5 columns.

fileDir:/tmp/RtmppFADKy/Rinst4963468bf65e/Rcade/extdata/STAT1

The Rcade object stores information from the DE analysis:

> x <- getDE(Rcade)

It also contains the ChIP-seq analysis:

> x <- getChIP(Rcade)

and the Rcade table obtained from linking the ChIP-seq analysis with the DE data:

> x <- getRcade(Rcade)

4

Plotting, QC

We can perform Principle Component Analysis on the counts with the plotPCA function. Usually, one would
expect similar samples to cluster together on this plot, and so we can identify samples that do not ﬁt this
assumption - further investigation is required to determine the signiﬁcance of such a ﬁnding. (Output is
shown in Figure 1.)

> plotPCA(Rcade)

The MM plot shows log-ratios from DE plotted against log-ratios from the ChIP-seq. The colour of each
point corresponds to the probability of both ChIP and DE being present. (Output is shown in Figure 2.)

6

Rcade: R-based analysis of ChIP-seq And Differential Expression data

> plotMM(Rcade)

The function plotBBB() plots log-odds values for ChIP-seq, DE, and combined ChIP-seq/DE analysis to-
gether. The package rgl is required for this 3D plot. (Output is shown in Figure 3.)

> library(rgl)

> plotBBB(Rcade)

7

Rcade: R-based analysis of ChIP-seq And Differential Expression data

Figure 1: Output from plotPCA(Rcade)

8

1234−0.15−0.10−0.050.000.050.100.15−0.02−0.010.000.010.02ChIP PCAPC1PC2Rcade: R-based analysis of ChIP-seq And Differential Expression data

Figure 2: Output from plotMM(Rcade)

9

llllllllllllllllllllllllllllllllllllllllllllllllllllllll01234501234ChIP against ExpressionDE Log RatioChIP Log RatioB = −8.9B = 0.1B = 9.1B = 18.1B = 27.1B = 36B = InfRcade: R-based analysis of ChIP-seq And Differential Expression data

Figure 3: Output from plotBBB(Rcade), subsequently saved to disk with the command
rgl.snapshot(filename="plotBBB.png")

10

Rcade: R-based analysis of ChIP-seq And Differential Expression data

5

Output

To export the Rcade results to disk in a user-friendly .csv format, use exportRcade() function as follows:

> exportRcade(Rcade, directory="RcadeOutput")

Usually, the ﬁle of interest is “DEandChIP.csv", which contains the genes most likely to have both DE and
ChIP signals. A full explanation of all of the ﬁles can be found in the help page:

> ?exportRcade

By default, Rcade outputs the top 1000 geneIDs for each hypothesis. To increase the number of geneIDs,
use a larger value for cutoﬀArg:

> exportRcade(Rcade, directory="RcadeOutput", cutoffArg=2000)

Alternative cutoﬀ methods are described in the exportRcade help page - for example,

> exportRcade(Rcade, directory="RcadeOutput", cutoffMode="B", cutoffArg=0)

6

Questions/Bug reports

If you have any questions about Rcade, or encounter a bug, please post a message on the Bioconductor
support site at https://support.bioconductor.org/. This will help anybody who later searches for help on the
same query.

7

Session Info

> sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default

BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:
[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

attached base packages:

11

Rcade: R-based analysis of ChIP-seq And Differential Expression data

[1] parallel stats4

stats

graphics

grDevices utils

datasets

[8] methods

base

other attached packages:
[1] Rcade_1.24.0
[4] Rsamtools_1.34.0
[7] GenomicRanges_1.34.0 GenomeInfoDb_1.18.0
BiocGenerics_0.28.0
[10] S4Vectors_0.20.0

baySeq_2.16.0
Biostrings_2.50.0

abind_1.4-5
XVector_0.22.0
IRanges_2.16.0

loaded via a namespace (and not attached):
[1] Rcpp_0.12.19
[3] BiocManager_1.30.3
[5] bitops_1.0-6
[7] zlibbioc_1.28.0
[9] jsonlite_1.5
[11] lattice_0.20-35
[13] DelayedArray_0.8.0
[15] crosstalk_1.0.0
[17] GenomeInfoDbData_1.2.0
[19] htmlwidgets_1.3
[21] manipulateWidget_0.10.0
[23] rprojroot_1.3-2
[25] Biobase_2.42.0
[27] plotrix_3.7-4
[29] BiocParallel_1.16.0
[31] limma_3.38.0
[33] magrittr_1.5
[35] GenomicAlignments_1.18.0
[37] promises_1.0.1
[39] SummarizedExperiment_1.12.0 xtable_1.8-3
[41] mime_0.6
[43] httpuv_1.4.5
[45] RCurl_1.95-4.11

compiler_3.5.1
later_0.7.5
tools_3.5.1
digest_0.6.18
evaluate_0.12
Matrix_1.2-14
shiny_1.1.0
yaml_2.2.0
knitr_1.20
webshot_0.5.1
locfit_1.5-9.1
grid_3.5.1
R6_2.3.0
rgl_0.99.16
rmarkdown_1.10
edgeR_3.24.0
matrixStats_0.54.0
backports_1.1.2
htmltools_0.3.6

BiocStyle_2.10.0
miniUI_0.1.1.1

8

Acknowledgements

Diﬀerential Expression data from Array Express, http://www.ebi.ac.uk/arrayexpress, under accession
number E-GEOD-11299.

STAT1 ChIP-seq data from the Snyder lab, as part of the ENCODE consortium
Input DCC accession numbers: wgEncodeEH000611 and wgEncodeEH000612
ChIP DCC accession number: wgEncodeEH000614

12


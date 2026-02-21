methyAnalysis: an R package for DNA methylation data
analysis and visualization

Pan Du‡*and Richard Bourgon‡

October 30, 2017

‡Department of Bioinformatics and Computational Biology
Genentech Inc., South San Francisco, CA, 94080, USA

Contents

1 Introduction

2 MethyGenoSet-class
2.1 Example dataset
2.2

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
Input methylation data from other packages . . . . . . . . . . . . . . . . . .

3 Identifying Diﬀerentially Methylated Regions (DMR)
3.1 DNA methylation correlation between nearby CpG-sites
. . . . . . . . . . .
3.2 Diﬀerential methylation test . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 Deﬁne diﬀerentially methylated regions . . . . . . . . . . . . . . . . . . . . .

4 Annotating DMRs

5 Visualizing DNA methylation data

5.1 Export data for external visualization . . . . . . . . . . . . . . . . . . . . . .
5.2 Plot methylation heatmap by chromosome location . . . . . . . . . . . . . .

6 sessionInfo

7 References

*dupan.mail (at) gmail.com

2

2
2
4

4
4
6
7

7

8
8
8

9

12

1

1 Introduction

The methyAnalysis package aims to provide functionalities of analyzing and visualizing the
DNA methylation data.

As most DNA-methylation data is still array-based, most public analysis tools use tradi-
tional probe-based analysis methods. However, with the increase of probe density, consider-
ing the probe spatial information becomes more and more important for better understanding
the data. To meet this need, we developed this package for chromosome location based DNA
methylation analysis. The current version of the package mainly focus on analyzing the
Illumina Inﬁnium methylation array data preprocessed by the lumi package [1], but most
methods can be generalized to other methylation array or sequencing data. Functions speci-
ﬁcly designed for DNA methylation sequencing data will be added in the near future.

The package mainly provides functions in the following aspects:
1. Deﬁnes a new class, MethyGenoSet, and related methods for the chromosome-location

based DNA methylation analysis.

2. Provides functions related with diﬀerential methylation analysis, slide-window smooth-
ing of DNA methylation levels, DMR (Diﬀerentially Methylation Region) detection and an-
notation.

3. Visualization of the DNA methylation data.

2 MethyGenoSet-class

In order to keep the chromosome location information together with the data, we deﬁned a
new MethyGenoSet class as a direct extension of the GenoSet class in the genoset package.
The GenoSet class is an extension of eSet class. It keeps the chromosome location information
in an additional rowRanges slot, a GRanges or RangedData object. For convenience of
retrieving the methylation data, we keeps the DNA methylation data (using M-value [2] by
default) in the exprs assayData element. Users can easily retrieve the methylation data by
using exprs method.

2.1 Example dataset

For better understanding the package, we created a small example dataset, exampleMethyGenoSet.
The exampleMethyGenoSet consists of eight random selected cancer cell line samples from
two tissues. To save space, only probes in chromosome 21 were included.

> library(methyAnalysis)
> ## load the example data
> data(exampleMethyGenoSet)
> ## show MethyGenoSet class
> slotNames(exampleMethyGenoSet)

2

[1] "history"
[3] "rowRanges"
[5] "assays"
[7] "elementMetadata" "metadata"

"annotation"
"colData"
"NAMES"

’

’

MethyGenoSet

> # showClass(
>
> ## get chromosome location information
> head(rowRanges(exampleMethyGenoSet))

)

GRanges object with 6 ranges and 1 metadata column:

seqnames
<Rle>
chr21 [10882029, 10882029]
chr21 [10883548, 10883548]
chr21 [10884748, 10884748]
chr21 [10884967, 10884967]
chr21 [10884969, 10884969]
chr21 [10885409, 10885409]

ranges strand
<IRanges> <Rle>
*
*
*
*
*
*

cg17035109
cg06187584
cg12459059
cg25450479
cg23347501
cg03661019

ID
|
<factor>
|
cg17035109 | cg17035109
cg06187584 | cg06187584
cg12459059 | cg12459059
cg25450479 | cg25450479
cg23347501 | cg23347501
cg03661019 | cg03661019
-------
seqinfo: 1 sequence from hg19 genome; no seqlengths

> ## retrieve methylation data
> dim(exprs(exampleMethyGenoSet))

[1] 4243

8

> ## Sample information
> colData(exampleMethyGenoSet)

DataFrame with 8 rows and 1 column

SampleType
<character>
Type1
Type1
Type1

Sample1
Sample2
Sample3

3

Sample4
Sample5
Sample6
Sample7
Sample8

Type1
Type2
Type2
Type2
Type2

2.2 Input methylation data from other packages

Lumi or methylumi package

3 Identifying Diﬀerentially Methylated Regions (DMR)

One common DNA methylation analysis task is to identify Diﬀerentially Methylated Regions
(DMR) between two comparison groups. Similar as the expression microarray analysis, many
existing diﬀerential test methods can be used here. However, most of these methods do not
consider the probe spatial information and assuming probe measurements are independent
to each other.

3.1 DNA methylation correlation between nearby CpG-sites

For DNA methylation data, we observed strong correlation between nearby CpG-sites. Figure
1 shows the correlation between nearby CpG-sites. The x-axis is the distance between nearby
CpG-sites and the y-axis is the Pearson correlation of the related methylation proﬁles of 49
cell line samples (data not shown). The red dots are the median correlation of the 5 percentile
cut (ranked by the distance between nearby CpG-sites (x-axis)). We can see the correlaiton
is very strong when the CpG-sites are close to each other.

On the other hand, due to the sequence variation across samples and ﬁxed probe designs,
the array-based DNA-methylation data also tends to be noisy. By considering the oberseved
strong correlation between nearby CpG-sites, we can reduce the measurement noise by using
sliding-window smoothing. smoothMethyData function is designed for this purpose. By
default, we set winSize (half-window size) as 250bp, which is selected based on Figure 1.

> methyGenoSet.sm <- smoothMethyData(exampleMethyGenoSet, winSize = 250)

Smoothing Chromosome chr21 ...

> ## winsize is kept as an attribute
’
> attr(methyGenoSet.sm,

windowSize

’

)

[1] 250

4

Figure 1: DNA methylation correlation between nearby CpG-sites

5

3.2 Diﬀerential methylation test

Function detectDMR.slideWin is designed to perform diﬀerential methylation test. The
function will automatically check whether the methylation data has been smoothed or not.
If not, slide window smoothing will be performed ﬁrst. The current version only implement
’t-test’ and wilcox test for the diﬀerential methylation test. A more ﬂexible (lm)-based
method will be added in the future version.

> ## get sample type information
> sampleType <- colData(exampleMethyGenoSet)$SampleType
> ## Do differential test
> allResult <- detectDMR.slideWin(exampleMethyGenoSet, sampleType=sampleType)

Smoothing Chromosome chr21 ...

> head(allResult)

GRanges object with 6 ranges and 11 metadata columns:

seqnames
<Rle>
chr21 [10882029, 10882029]
chr21 [10883548, 10883548]
chr21 [10884748, 10884748]
chr21 [10884967, 10884967]
chr21 [10884969, 10884969]
chr21 [10885409, 10885409]

ranges strand
<IRanges> <Rle>
*
*
*
*
*
*

cg17035109
cg06187584
cg12459059
cg25450479
cg23347501
cg03661019

|
|

PROBEID difference

p.value
<factor> <numeric> <numeric>
cg17035109 | cg17035109 -1.8411605 0.06276449
cg06187584 | cg06187584 -0.4566059 0.41601486
cg12459059 | cg12459059 -0.3591179 0.36542152
cg25450479 | cg25450479 -0.3591179 0.36542152
cg23347501 | cg23347501 -0.3591179 0.36542152
cg03661019 | cg03661019 -0.3532662 0.38065600
tscore startWinIndex
<numeric>
1
2
3
3
3
6

<numeric> <numeric>
cg17035109 0.1888488 -2.2804091
cg06187584 0.6149596 -0.8734252
cg12459059 0.5627904 -0.9789270
cg25450479 0.5627904 -0.9789270
cg23347501 0.5627904 -0.9789270
cg03661019 0.5782099 -0.9460314

p.adjust

endWinIndex startLocation
<integer>

<numeric>

6

cg17035109
cg06187584
cg12459059
cg25450479
cg23347501
cg03661019

1
2
5
5
5
6

10882029
10883548
10884748
10884748
10884748
10885409

<integer> <numeric>

endLocation mean_Type1 mean_Type2
<numeric>
10882029 -2.4183775 -0.57721699
10883548 -2.2297567 -1.77315084
10884969 0.2594151 0.61853304
10884969 0.2594151 0.61853304
10884969 0.2594151 0.61853304
10885409 -0.4170363 -0.06377013

cg17035109
cg06187584
cg12459059
cg25450479
cg23347501
cg03661019
-------
seqinfo: 1 sequence from hg19 genome; no seqlengths

3.3 Deﬁne diﬀerentially methylated regions

We deﬁne a diﬀerentially methylated region (DMR) as a region, in which most measured
CpG-sites are diﬀerentially methylated. To identify DMRs, we ﬁrst determine the diﬀer-
ential methylation status of each probe, then merge them as a continuous region. The
identifySigDMR function is a wrapper function for all of these. The getContinuousRegion
function is called by identifySigDMR to detection continous regions. Its input is a GRanges
object with a ”status” column to show whether the probe is diﬀerentially methylated or not.
Its output is also a GRanges object indicating the identiﬁed DMRs. The identifySigDMR
function returns a list of two GRanges objects. sigDMRInfo includes the identiﬁed DMRs,
and sigDataInfo includes all diﬀerentially methylated probe information.

> ## Identify the DMR (Differentially Methylated Region) by setting proper parameters.
> ## Here we just use default ones
> allDMRInfo = identifySigDMR(allResult)
> names(allDMRInfo)

[1] "sigDMRInfo" "sigDataInfo"

4 Annotating DMRs

To understand what genes or gene elements (promoters or exons) are overlapping with these
identiﬁed DMRs, we need to do annotate. The annotateDMRInfo is deﬁned for this pur-
pose. A TxDb annotation package is required for the annotation process. Here we use the
TxDb.Hsapiens.UCSC.hg19.knownGene package for the annotation. The TxDb.Hsapiens.UCSC.hg19.knownGene
package includes the Homo Sapiens data from UCSC build hg19 based on the knownGene

7

Track. Other TxDb annotation packages, TxDb or GRanges objects can also be used as anno-
tationDatabase. The export.DMRInfo function is to output the annotated DMR information
as .csv ﬁles.

> ## Annotate significant DMR info
> DMRInfo.ann <- annotateDMRInfo(allDMRInfo,
> ## output the DMR information
> export.DMRInfo(DMRInfo.ann, savePrefix=

’

’

testExample

)

’

TxDb.Hsapiens.UCSC.hg19.knownGene

)

’

5 Visualizing DNA methylation data

As the DNA methylation levels are chromose location dependent. The methylation patterns
can be pretty diﬀerent between diﬀerent gene elements, like promoter, exon1, intron and
exons. The methylation patterns within the CpG-islands usually are also diﬀerent from
other regions. In order to better understanding these diﬀerence, we need to visualize the DNA
methylation data. Two visualization options are supported in the methyAnalysis package.

5.1 Export data for external visualization

One easier option is to export the DNA methylation data in certain formats, and visualize
these ﬁles using some genome browser tools, like IGV (http://www.broadinstitute.org/igv/)
and IGB (http://bioviz.org/igb/index.html). Users can use export.methyGenoSet to output
the MethyGenoSet object. The current implementation supports two output formats: ”.gct”
and ”.bw” ﬁles. ”.gct” includes all samples in a single ﬁle.
It is only supported by IGV
genome browser. The BigWig format (”.bw”) is a more general format supported by many
visualization tools. Each BigWig ﬁle represents one single sample. So it is more ﬂexible for
the users only interested in a subset of samples.

> ## output in IGV supported "gct" file
> export.methyGenoSet(exampleMethyGenoSet, file.format=
> ## output in BigWig files
> export.methyGenoSet(exampleMethyGenoSet, file.format=

’

’

’

’

gct

, savePrefix=

’

’

test

)

bw

, savePrefix=

test

)

’

’

5.2 Plot methylation heatmap by chromosome location

Another visualization option is to show a focused regions, like DMRs, as a chomosome
location based heatmap. heatmapByChromosome is designed for this. It is adapted based
on the plotTracks function in Gviz package. The function is designed for diﬀerent types of
data with chromosome location information. Figure 2 shows an example plot of gene SIM2
(Entrez Gene ID:6493), which overlaps with the identiﬁed DMRs shown above. Users can
also provide a GRanges object to specify a plot region.

8

> ## plot the DNA methylation heatmap by chromosome location
> heatmapByChromosome(exampleMethyGenoSet, gene=

,

’

’

6493
’

’

genomicFeature=

TxDb.Hsapiens.UCSC.hg19.knownGene

, includeGeneBody=TRUE)

Another wrapper function, plotMethylationHeatmapByGene, is speciﬁcally designed for
the methylaiton data. Users can add phenotypes or matched gene expression data to the
right panel of the plot. Figure legends can be also added, as shown in Figure 3. By default,
the plotMethylationHeatmapByGene plots methylation Beta-values [2] (in the range of 0
to 1) instead of M-values. Users can set useBetaValue as FALSE if they want to change to
M-values.

> ## plot the DNA methylation heatmap by gene of selected GRanges
> plotMethylationHeatmapByGene(

6493
phenoData=colData(exampleMethyGenoSet), includeGeneBody=TRUE,
genomicFeature=

TxDb.Hsapiens.UCSC.hg19.knownGene

, methyGenoSet=exampleMethyGenoSet,

)

’

’

’

’

6 sessionInfo

> toLatex(sessionInfo())

(cid:136) R version 3.4.2 (2017-09-28), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8,
LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.3 LTS

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so

(cid:136) LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, grid, methods, parallel, stats,

stats4, utils

(cid:136) Other packages: AnnotationDbi 1.40.0, Biobase 2.38.0, BiocGenerics 0.24.0,
GenomeInfoDb 1.14.0, GenomicFeatures 1.30.0, GenomicRanges 1.30.0,
IRanges 2.12.0, S4Vectors 0.16.0, TxDb.Hsapiens.UCSC.hg19.knownGene 3.2.2,
methyAnalysis 1.20.0, org.Hs.eg.db 3.4.2

9

Figure 2: DNA methylation heatmap by chromosome location

10

Chromosome 2138.07 mb38.08 mb38.09 mb38.1 mb38.11 mb38.12 mbCpGIslandGeneModeluc002yvp.3uc002yvq.3uc002yvr.2−4−2024Methylation ProfileSample4Sample3Sample2Sample1Sample8Sample7Sample5Sample6Ploting SIM2 (GeneID:6493)

Figure 3: DNA methylation heatmap by chromosome location with phenotype information

11

SIM2 (GeneID:6493)Chromosome 2138.07 mb38.08 mb38.09 mb38.1 mb38.11 mb38.12 mbCpGIslandGeneModeluc002yvp.3uc002yvq.3uc002yvr.2Methylation ProfileSampleTypeSample1Sample2Sample3Sample4Sample5Sample6Sample7Sample800.250.50.751Methylation(Beta value)SampleTypeType1Type2(cid:136) Loaded via a namespace (and not attached): AnnotationFilter 1.2.0,

AnnotationHub 2.10.0, BSgenome 1.46.0, BiocInstaller 1.28.0, BiocParallel 1.12.0,
Biostrings 2.46.0, DBI 0.7, DelayedArray 0.4.0, Formula 1.2-2, GEOquery 2.46.0,
GenomeInfoDbData 0.99.1, GenomicAlignments 1.14.0, Gviz 1.22.0, Hmisc 4.0-3,
KernSmooth 2.23-15, MASS 7.3-47, Matrix 1.2-11, ProtGenerics 1.10.0, R6 2.2.2,
RColorBrewer 1.1-2, RCurl 1.95-4.8, RMySQL 0.10.13, RSQLite 2.0, Rcpp 0.12.13,
Rsamtools 1.30.0, SummarizedExperiment 1.8.0, VariantAnnotation 1.24.0,
XML 3.98-1.9, XVector 0.18.0, acepack 1.4.1, aﬀy 1.56.0, aﬀyio 1.48.0,
annotate 1.56.0, assertthat 0.2.0, backports 1.1.1, base64 2.0, base64enc 0.1-3,
beanplot 1.2, bindr 0.1, bindrcpp 0.2, biomaRt 2.34.0, biovizBase 1.26.0, bit 1.1-12,
bit64 0.9-7, bitops 1.0-6, blob 1.1.0, bumphunter 1.20.0, checkmate 1.8.5,
cluster 2.0.6, codetools 0.2-15, colorspace 1.3-2, compiler 3.4.2, curl 3.0,
data.table 1.10.4-3, dichromat 2.0-0, digest 0.6.12, doRNG 1.6.6, dplyr 0.7.4,
ensembldb 2.2.0, foreach 1.4.3, foreign 0.8-69, geneﬁlter 1.60.0, genoset 1.34.0,
ggplot2 2.2.1, glue 1.2.0, gridExtra 2.3, gtable 0.2.0, hms 0.3, htmlTable 1.9,
htmltools 0.3.6, htmlwidgets 0.9, httpuv 1.3.5, httr 1.3.1, illuminaio 0.20.0,
interactiveDisplayBase 1.16.0, iterators 1.0.8, knitr 1.17, lattice 0.20-35,
latticeExtra 0.6-28, lazyeval 0.2.1, limma 3.34.0, locﬁt 1.5-9.1, lumi 2.30.0,
magrittr 1.5, matrixStats 0.52.2, mclust 5.3, memoise 1.1.0, methylumi 2.24.0,
mgcv 1.8-22, mime 0.5, minﬁ 1.24.0, multtest 2.34.0, munsell 0.4.3, nleqslv 3.3.1,
nlme 3.1-131, nnet 7.3-12, nor1mix 1.2-3, openssl 0.9.7, pkgconﬁg 2.0.1,
pkgmaker 0.22, plyr 1.8.4, preprocessCore 1.40.0, prettyunits 1.0.2, progress 1.1.2,
purrr 0.2.4, quadprog 1.5-5, readr 1.1.1, registry 0.3, reshape 0.8.7, rlang 0.1.2,
rngtools 1.2.4, rpart 4.1-11, rtracklayer 1.38.0, scales 0.5.0, shiny 1.0.5,
siggenes 1.52.0, splines 3.4.2, stringi 1.1.5, stringr 1.2.0, survival 2.41-3, tibble 1.3.4,
tidyr 0.7.2, tools 3.4.2, xml2 1.1.1, xtable 1.8-2, yaml 2.1.14, zlibbioc 1.24.0

7 References

1. Du P, Kibbe WA and Lin SM: ”lumi: a Bioconductor package for processing Illumina
microarray” Bioinformatics 2008 24(13):1547-1548

2. Du P, Zhang X, Huang CC, Jafari N, Kibbe WA, Hou L, and Lin SM: ”Comparison of
Beta-value and M-value methods for quantifying methylation levels by microarray analysis”,
BMC Bioinformatics 2010, 11:587

12


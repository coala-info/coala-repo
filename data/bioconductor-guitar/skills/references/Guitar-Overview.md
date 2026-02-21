An Introduction to Guitar Package

Xiao Du

Modified: 26 April, 2019. Compiled: October 30, 2025

1 Quick Start with Guitar

This is a manual for Guitar package. The Guitar package is aimed for RNA landmark-guided transcrip-
tomic analysis of RNA-reated genomic features.

The Guitar package enables the comparison of multiple genomic features, which need to be stored in
a name list. Please see the following example, which reads 1000 RNA m6A methylation sites into R for
detection. Of course, in actual data analysis, features may come from multiple sets of resources.

library(Guitar)

’BiocGenerics’

IQR, mad, sd, var, xtabs

GenomicFeatures
BiocGenerics
generics

as.difftime, as.factor, as.ordered, intersect,
is.element, setdiff, setequal, union

## Loading required package:
## Loading required package:
## Loading required package:
##
## Attaching package:
’generics’
## The following objects are masked from ’package:base’:
##
##
##
##
## Attaching package:
## The following objects are masked from ’package:stats’:
##
##
## The following objects are masked from ’package:base’:
##
##
##
##
##
##
##
##
##
## Loading required package:
## Loading required package:
##
## Attaching package:
## The following object is masked from ’package:utils’:
##
##

Filter, Find, Map, Position, Reduce,
anyDuplicated, aperm, append, as.data.frame,
basename, cbind, colnames, dirname, do.call,
duplicated, eval, evalq, get, grep, grepl,
is.unsorted, lapply, mapply, match, mget, order,
paste, pmax, pmax.int, pmin, pmin.int, rank,
rbind, rownames, sapply, saveRDS, table, tapply,
unique, unsplit, which.max, which.min

S4Vectors
stats4

’S4Vectors’

findMatches

1

’dplyr’

subtract

’magrittr’

ggplot2
dplyr

I, expand.grid, unname

rtracklayer
magrittr

IRanges
Seqinfo
GenomicRanges
AnnotationDbi
Biobase

Vignettes contain introductory material; view
with ’browseVignettes()’. To cite Bioconductor,
see ’citation("Biobase")’, and for packages
’citation("pkgname")’.

## The following objects are masked from ’package:base’:
##
##
## Loading required package:
## Loading required package:
## Loading required package:
## Loading required package:
## Loading required package:
## Welcome to Bioconductor
##
##
##
##
##
## Loading required package:
## Loading required package:
##
## Attaching package:
## The following object is masked from ’package:GenomicRanges’:
##
##
## Loading required package:
## Loading required package:
##
## Attaching package:
## The following object is masked from ’package:AnnotationDbi’:
##
##
## The following object is masked from ’package:Biobase’:
##
##
## The following objects are masked from ’package:GenomicRanges’:
##
##
## The following object is masked from ’package:Seqinfo’:
##
##
## The following objects are masked from ’package:IRanges’:
##
##
collapse, desc, intersect, setdiff, slice, union
## The following objects are masked from ’package:S4Vectors’:
##
##
##
## The following objects are masked from ’package:BiocGenerics’:
##
##
combine, intersect, setdiff, setequal, union
## The following object is masked from ’package:generics’:
##
##
## The following objects are masked from ’package:stats’:
##
##

first, intersect, rename, setdiff, setequal,
union

intersect, setdiff, union

filter, lag

intersect

combine

explain

select

2

intersect, setdiff, setequal, union

## The following objects are masked from ’package:base’:
##
##
##
## Attaching package:
## The following object is masked from ’package:BiocGenerics’:
##
##

normalize

’Guitar’

# genomic features imported into named list
stBedFiles <- list(system.file("extdata", "m6A_mm10_exomePeak_1000peaks_bed12.bed",
package="Guitar"))

With the following script, we may generate the transcriptomic distribution of genomic features to
be tested, and the result will be automatically saved into a PDF file under the working directory with
prefix "example". With the GuitarPlot function, the gene annotation can be downloaded from internet
automatically with a genome assembly number provided; however, this feature requires working internet
and might take a longer time. The toy Guitar coordinates generated internally should never be re-used in
other real data analysis.

count <- GuitarPlot(txGenomeVer = "mm10",

stBedFiles = stBedFiles,
miscOutFilePrefix = NA)

In a more efficent protocol, in order to re-use the gene annotation and Guitar coordinates, you will have
to build Guitar Coordiantes from a txdb object in a separate step. The transcriptDb contains the gene anno-
tation information and can be obtained in a number of ways, .e.g, download the complete gene annotation
of species from UCSC automatically, which might takes a few minutes. In the following analysis, we load
the Txdb object from a toy dataset provided with the Guitar package. Please note that this is only a very
small part of the complete hg19 transcriptome, and the Txdb object provided with Guitar package should
not be used in real data analysis. With a TxDb object that contains gene annotation information, we in
the next build Guitar coordiantes, which is essentially a bridge connects the transcriptomic landmarks and
genomic coordinates.

txdb_file <- system.file("extdata", "mm10_toy.sqlite",

package="Guitar")

txdb <- loadDb(txdb_file)
guitarTxdb <- makeGuitarTxdb(txdb = txdb, txPrimaryOnly = FALSE)

## [1] "There are 2946 transcripts of 2946 genes in the genome."
## [1] "total 2946 transcripts extracted ..."
## [1] "total 2719 transcripts left after ambiguity filter ..."
## [1] "total 2719 transcripts left after check chromosome validity ..."
## [1] "total 1342 mRNAs left after component length filter ..."
## [1] "total 307 ncRNAs left after ncRNA length filter ..."
## [1] "generate components for all tx"
## [1] "generate components for mRNA"
## [1] "generate components for lncRNA"
## [1] "generate chiped transcriptome"
## [1] "generate coverage checking ranges for tx"
## [1] "generate coverage checking ranges for mrna"
## [1] "generate coverage checking ranges for ncrna"

# Or use gff. file to generate guitarTxdb
# Or use getTxdb() to download TxDb from internet:

3

# txdb <- getTxdb(txGenomeVer="hg19")
# guitarTxdb <- makeGuitarTxdb(txdb)

You may now generate the Guitar plot from the named list of genome-based features.

GuitarPlot(txTxdb =

txdb,
stBedFiles = stBedFiles,
miscOutFilePrefix = "example")

## [1] "20251030002249"
## [1] "There are 2946 transcripts of 2946 genes in the genome."
## [1] "total 2946 transcripts extracted ..."
## [1] "total 2719 transcripts left after ambiguity filter ..."
## [1] "total 2719 transcripts left after check chromosome validity ..."
## [1] "total 1342 mRNAs left after component length filter ..."
## [1] "total 307 ncRNAs left after ncRNA length filter ..."
## [1] "generate components for all tx"
## [1] "generate components for mRNA"
## [1] "generate components for lncRNA"
## [1] "generate chiped transcriptome"
## [1] "generate coverage checking ranges for tx"
## [1] "generate coverage checking ranges for mrna"
## [1] "generate coverage checking ranges for ncrna"
## [1] "20251030002300"
## [1] "import BED file /tmp/RtmpjmKl6X/Rinstd59fc3b7646d/Guitar/extdata/m6A_mm10_exomePeak_1000peaks_bed12.bed"
## [1] "sample 10 points for Group1"
## [1] "start figure plotting for tx ..."

## Warning: Using ‘size‘ aesthetic for lines was deprecated in ggplot2
## 3.4.0.
## i Please use ‘linewidth‘ instead.
## i The deprecated feature was likely used in the Guitar
package.
##
##
Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call ‘lifecycle::last_lifecycle_warnings()‘ to see where
## this warning was generated.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceDown‘ is discouraged.
## i Use ‘confidenceDown‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceUp‘ is discouraged.
## i Use ‘confidenceUp‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceDown‘ is discouraged.
## i Use ‘confidenceDown‘ instead.
## Warning: Use of ‘densityCI$confidenceUp‘ is discouraged.
## i Use ‘confidenceUp‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.

4

## Warning: Use of ‘vline_pos$x1‘ is discouraged.
## i Use ‘x1‘ instead.
## Warning: Use of ‘vline_pos$y1‘ is discouraged.
## i Use ‘y1‘ instead.
## Warning: Use of ‘vline_pos$x2‘ is discouraged.
## i Use ‘x2‘ instead.
## Warning: Use of ‘vline_pos$y2‘ is discouraged.
## i Use ‘y2‘ instead.

## [1] "start figure plotting for mrna ..."

## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceDown‘ is discouraged.
## i Use ‘confidenceDown‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceUp‘ is discouraged.
## i Use ‘confidenceUp‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceDown‘ is discouraged.
## i Use ‘confidenceDown‘ instead.
## Warning: Use of ‘densityCI$confidenceUp‘ is discouraged.
## i Use ‘confidenceUp‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘vline_pos$x1‘ is discouraged.
## i Use ‘x1‘ instead.
## Warning: Use of ‘vline_pos$y1‘ is discouraged.
## i Use ‘y1‘ instead.
## Warning: Use of ‘vline_pos$x2‘ is discouraged.
## i Use ‘x2‘ instead.
## Warning: Use of ‘vline_pos$y2‘ is discouraged.
## i Use ‘y2‘ instead.

## [1] "start figure plotting for ncrna ..."

## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceDown‘ is discouraged.
## i Use ‘confidenceDown‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceUp‘ is discouraged.
## i Use ‘confidenceUp‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceDown‘ is discouraged.
## i Use ‘confidenceDown‘ instead.

5

## Warning: Use of ‘densityCI$confidenceUp‘ is discouraged.
## i Use ‘confidenceUp‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘vline_pos$x1‘ is discouraged.
## i Use ‘x1‘ instead.
## Warning: Use of ‘vline_pos$y1‘ is discouraged.
## i Use ‘y1‘ instead.
## Warning: Use of ‘vline_pos$x2‘ is discouraged.
## i Use ‘x2‘ instead.
## Warning: Use of ‘vline_pos$y2‘ is discouraged.
## i Use ‘y2‘ instead.

Alternatively, you may also optionally include the promoter DNA region and tail DNA region on the

5’ and 3’ side of a transcript in the plot with parameter headOrtail =TRUE.

GuitarPlot(txTxdb = txdb,

stBedFiles = stBedFiles,
headOrtail = TRUE)

## [1] "20251030002324"
## [1] "There are 2946 transcripts of 2946 genes in the genome."
## [1] "total 2946 transcripts extracted ..."
## [1] "total 2719 transcripts left after ambiguity filter ..."
## [1] "total 2719 transcripts left after check chromosome validity ..."
## [1] "total 1342 mRNAs left after component length filter ..."
## [1] "total 307 ncRNAs left after ncRNA length filter ..."
## [1] "generate components for all tx"
## [1] "generate components for mRNA"
## [1] "generate components for lncRNA"
## [1] "generate chiped transcriptome"
## [1] "generate coverage checking ranges for tx"
## [1] "generate coverage checking ranges for mrna"
## [1] "generate coverage checking ranges for ncrna"
## [1] "20251030002335"
## [1] "import BED file /tmp/RtmpjmKl6X/Rinstd59fc3b7646d/Guitar/extdata/m6A_mm10_exomePeak_1000peaks_bed12.bed"
## [1] "sample 10 points for Group1"
## [1] "start figure plotting for tx ..."

## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceDown‘ is discouraged.
## i Use ‘confidenceDown‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceUp‘ is discouraged.
## i Use ‘confidenceUp‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceDown‘ is discouraged.
## i Use ‘confidenceDown‘ instead.
## Warning: Use of ‘densityCI$confidenceUp‘ is discouraged.
## i Use ‘confidenceUp‘ instead.

6

## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘vline_pos$x1‘ is discouraged.
## i Use ‘x1‘ instead.
## Warning: Use of ‘vline_pos$y1‘ is discouraged.
## i Use ‘y1‘ instead.
## Warning: Use of ‘vline_pos$x2‘ is discouraged.
## i Use ‘x2‘ instead.
## Warning: Use of ‘vline_pos$y2‘ is discouraged.
## i Use ‘y2‘ instead.

Alternatively, you may also optionally include the Confidence Interval for guitar plot with parameter

enableCI = FALSE.

GuitarPlot(txTxdb = txdb,

stBedFiles = stBedFiles,
headOrtail = TRUE,
enableCI = FALSE)

## [1] "20251030002349"
## [1] "There are 2946 transcripts of 2946 genes in the genome."
## [1] "total 2946 transcripts extracted ..."
## [1] "total 2719 transcripts left after ambiguity filter ..."
## [1] "total 2719 transcripts left after check chromosome validity ..."
## [1] "total 1342 mRNAs left after component length filter ..."
## [1] "total 307 ncRNAs left after ncRNA length filter ..."
## [1] "generate components for all tx"
## [1] "generate components for mRNA"
## [1] "generate components for lncRNA"
## [1] "generate chiped transcriptome"
## [1] "generate coverage checking ranges for tx"
## [1] "generate coverage checking ranges for mrna"
## [1] "generate coverage checking ranges for ncrna"

7

1kbRNA1kb012DensityGroup1## [1] "20251030002401"
## [1] "import BED file /tmp/RtmpjmKl6X/Rinstd59fc3b7646d/Guitar/extdata/m6A_mm10_exomePeak_1000peaks_bed12.bed"
## [1] "sample 10 points for Group1"
## [1] "start figure plotting for tx ..."

## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘vline_pos$x1‘ is discouraged.
## i Use ‘x1‘ instead.
## Warning: Use of ‘vline_pos$y1‘ is discouraged.
## i Use ‘y1‘ instead.
## Warning: Use of ‘vline_pos$x2‘ is discouraged.
## i Use ‘x2‘ instead.
## Warning: Use of ‘vline_pos$y2‘ is discouraged.
## i Use ‘y2‘ instead.

2 Supported Data Format

Besides BED file, Guitar package also supports GRangesList and GRanges data structures. Please see the
following examples.

# import different data formats into a named list object.
# These genomic features are using mm10 genome assembly
stBedFiles <- list(system.file("extdata", "m6A_mm10_exomePeak_1000peaks_bed12.bed",

package="Guitar"),
system.file("extdata", "m6A_mm10_exomePeak_1000peaks_bed6.bed",
package="Guitar"))

# Build Guitar Coordinates
txdb_file <- system.file("extdata", "mm10_toy.sqlite",

8

1kbRNA1kb0.00.51.01.52.0DensityGroup1txdb <- loadDb(txdb_file)

package="Guitar")

# Guitar Plot
GuitarPlot(txTxdb = txdb,

stBedFiles = stBedFiles,
headOrtail = TRUE,
enableCI = FALSE,
mapFilterTranscript = TRUE,
pltTxType = c("mrna"),
stGroupName = c("BED12","BED6"))

## [1] "20251030002403"
## [1] "There are 2946 transcripts of 2946 genes in the genome."
## [1] "total 2946 transcripts extracted ..."
## [1] "total 2719 transcripts left after ambiguity filter ..."
## [1] "total 2719 transcripts left after check chromosome validity ..."
## [1] "total 1342 mRNAs left after component length filter ..."
## [1] "total 307 ncRNAs left after ncRNA length filter ..."
## [1] "generate components for mRNA"
## [1] "generate chiped transcriptome"
## [1] "generate coverage checking ranges for mrna"
## [1] "20251030002414"
## [1] "import BED file /tmp/RtmpjmKl6X/Rinstd59fc3b7646d/Guitar/extdata/m6A_mm10_exomePeak_1000peaks_bed12.bed"
## [1] "import BED file /tmp/RtmpjmKl6X/Rinstd59fc3b7646d/Guitar/extdata/m6A_mm10_exomePeak_1000peaks_bed6.bed"
## [1] "sample 10 points for BED12"
## [1] "sample 10 points for BED6"
## [1] "start figure plotting for mrna ..."

## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘vline_pos$x1‘ is discouraged.
## i Use ‘x1‘ instead.
## Warning: Use of ‘vline_pos$y1‘ is discouraged.
## i Use ‘y1‘ instead.
## Warning: Use of ‘vline_pos$x2‘ is discouraged.
## i Use ‘x2‘ instead.
## Warning: Use of ‘vline_pos$y2‘ is discouraged.
## i Use ‘y2‘ instead.

9

3 Processing of sampling sites information

We can select parameters for site sampling.

stGRangeLists = vector("list", length(stBedFiles))
sitesPoints <- list()

for (i in seq_len(length(stBedFiles))) {

stGRangeLists[[i]] <-

blocks(import(stBedFiles[[i]]))

}
for (i in seq_len(length(stGRangeLists))) {

sitesPoints[[i]] <- samplePoints(stGRangeLists[i],

stSampleNum = 10,
stAmblguity = 5,
pltTxType = c("mrna"),
stSampleModle = "Equidistance",
mapFilterTranscript = FALSE,
guitarTxdb = guitarTxdb)

}

4 Guitar Coordinates - Transcriptomic Landmarks Projected on Genome

The guitarTxdb object contains the genome-projected transcriptome coordinates, which can be valuable
for evaluating transcriptomic information related applications, such as checking the quality of MeRIP-Seq
data. The Guitar coordinates are essentially the genomic projection of standardized transcript-based
coordiantes, making a viable bridge beween the landmarks on transcript and genome-based coordinates.
It is based on the txdb object input, extracts the transcript information in txdb, selects the transcripts
that match the parameters according to the component parameters set by the user, and saves according to
the transcript type (tx, mrna, ncrna).

10

1kb5'UTRCDS3'UTR1kb012DensityBED12BED6guitarTxdb <- makeGuitarTxdb(txdb = txdb,

txAmblguity = 5,
txMrnaComponentProp = c(0.1,0.15,0.6,0.05,0.1),
txLncrnaComponentProp = c(0.2,0.6,0.2),
pltTxType = c("tx","mrna","ncrna"),
txPrimaryOnly = FALSE)

## [1] "There are 2946 transcripts of 2946 genes in the genome."
## [1] "total 2946 transcripts extracted ..."
## [1] "total 2719 transcripts left after ambiguity filter ..."
## [1] "total 2719 transcripts left after check chromosome validity ..."
## [1] "total 1342 mRNAs left after component length filter ..."
## [1] "total 307 ncRNAs left after ncRNA length filter ..."
## [1] "generate components for all tx"
## [1] "generate components for mRNA"
## [1] "generate components for lncRNA"
## [1] "generate chiped transcriptome"
## [1] "generate coverage checking ranges for tx"
## [1] "generate coverage checking ranges for mrna"
## [1] "generate coverage checking ranges for ncrna"

5 Check the Overlapping between Different Components

We can also check the distribution of the Guitar coordinates built.

gcl <- list(guitarTxdb$tx$tx)
GuitarPlot(txTxdb = txdb,

stGRangeLists = gcl,
stSampleNum = 200,
enableCI = TRUE,
pltTxType = c("tx"),
txPrimaryOnly = FALSE
)

## [1] "20251030002434"
## [1] "There are 2946 transcripts of 2946 genes in the genome."
## [1] "total 2946 transcripts extracted ..."
## [1] "total 2719 transcripts left after ambiguity filter ..."
## [1] "total 2719 transcripts left after check chromosome validity ..."
## [1] "total 1342 mRNAs left after component length filter ..."
## [1] "total 307 ncRNAs left after ncRNA length filter ..."
## [1] "generate components for all tx"
## [1] "generate chiped transcriptome"
## [1] "generate coverage checking ranges for tx"
## [1] "20251030002445"
## [1] "sample 200 points for Group1"
## [1] "start figure plotting for tx ..."

## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.

11

## Warning: Use of ‘densityCI$confidenceDown‘ is discouraged.
## i Use ‘confidenceDown‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceUp‘ is discouraged.
## i Use ‘confidenceUp‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘densityCI$confidenceDown‘ is discouraged.
## i Use ‘confidenceDown‘ instead.
## Warning: Use of ‘densityCI$confidenceUp‘ is discouraged.
## i Use ‘confidenceUp‘ instead.
## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘vline_pos$x1‘ is discouraged.
## i Use ‘x1‘ instead.
## Warning: Use of ‘vline_pos$y1‘ is discouraged.
## i Use ‘y1‘ instead.
## Warning: Use of ‘vline_pos$x2‘ is discouraged.
## i Use ‘x2‘ instead.
## Warning: Use of ‘vline_pos$y2‘ is discouraged.
## i Use ‘y2‘ instead.

Alternatively, we can extract the RNA components, check the distribution of tx components in the

transcriptome

GuitarCoords <- guitarTxdb$tx$txComponentGRange
type <- paste(mcols(GuitarCoords)$componentType,mcols(GuitarCoords)$txType)
key <- unique(type)
landmark <- list(1,2,3,4,5,6,7,8,9,10,11)
names(landmark) <- key
for (i in 1:length(key)) {
landmark[[i]] <- GuitarCoords[type==key[i]]

12

1kbRNA1kb0.000.250.500.751.00DensityGroup1}
GuitarPlot(txTxdb = txdb ,

stGRangeLists = landmark[1:3],
pltTxType = c("tx"),
enableCI = FALSE

)

## [1] "20251030003006"
## [1] "There are 2946 transcripts of 2946 genes in the genome."
## [1] "total 2946 transcripts extracted ..."
## [1] "total 2719 transcripts left after ambiguity filter ..."
## [1] "total 2719 transcripts left after check chromosome validity ..."
## [1] "total 1342 mRNAs left after component length filter ..."
## [1] "total 307 ncRNAs left after ncRNA length filter ..."
## [1] "generate components for all tx"
## [1] "generate chiped transcriptome"
## [1] "generate coverage checking ranges for tx"
## [1] "20251030003017"
## [1] "sample 10 points for Group1"
## [1] "sample 10 points for Group2"
## [1] "sample 10 points for Group3"
## [1] "start figure plotting for tx ..."

## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘vline_pos$x1‘ is discouraged.
## i Use ‘x1‘ instead.
## Warning: Use of ‘vline_pos$y1‘ is discouraged.
## i Use ‘y1‘ instead.
## Warning: Use of ‘vline_pos$x2‘ is discouraged.
## i Use ‘x2‘ instead.
## Warning: Use of ‘vline_pos$y2‘ is discouraged.
## i Use ‘y2‘ instead.

13

Check the distribution of mRNA components in the transcriptome

GuitarPlot(txTxdb = txdb ,

stGRangeLists = landmark[4:8],
pltTxType = c("mrna"),
enableCI = FALSE

)

## [1] "20251030003037"
## [1] "There are 2946 transcripts of 2946 genes in the genome."
## [1] "total 2946 transcripts extracted ..."
## [1] "total 2719 transcripts left after ambiguity filter ..."
## [1] "total 2719 transcripts left after check chromosome validity ..."
## [1] "total 1342 mRNAs left after component length filter ..."

14

1kbRNA1kb0123DensityGroup1Group2Group3## [1] "total 307 ncRNAs left after ncRNA length filter ..."
## [1] "generate components for mRNA"
## [1] "generate chiped transcriptome"
## [1] "generate coverage checking ranges for mrna"
## [1] "20251030003047"
## [1] "sample 10 points for Group1"
## [1] "sample 10 points for Group2"
## [1] "sample 10 points for Group3"
## [1] "sample 10 points for Group4"
## [1] "sample 10 points for Group5"
## [1] "start figure plotting for mrna ..."

## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘vline_pos$x1‘ is discouraged.
## i Use ‘x1‘ instead.
## Warning: Use of ‘vline_pos$y1‘ is discouraged.
## i Use ‘y1‘ instead.
## Warning: Use of ‘vline_pos$x2‘ is discouraged.
## i Use ‘x2‘ instead.
## Warning: Use of ‘vline_pos$y2‘ is discouraged.
## i Use ‘y2‘ instead.

15

Check the distribution of lncRNA components in the transcriptome

GuitarPlot(txTxdb = txdb ,

stGRangeLists = landmark[9:11],
pltTxType = c("ncrna"),
enableCI = FALSE

)

## [1] "20251030003100"
## [1] "There are 2946 transcripts of 2946 genes in the genome."
## [1] "total 2946 transcripts extracted ..."
## [1] "total 2719 transcripts left after ambiguity filter ..."
## [1] "total 2719 transcripts left after check chromosome validity ..."
## [1] "total 1342 mRNAs left after component length filter ..."
## [1] "total 307 ncRNAs left after ncRNA length filter ..."

16

1kb5'UTRCDS3'UTR1kb051015DensityGroup1Group2Group3Group4Group5## [1] "generate components for lncRNA"
## [1] "generate chiped transcriptome"
## [1] "generate coverage checking ranges for ncrna"
## [1] "20251030003111"
## [1] "sample 10 points for Group1"
## [1] "sample 10 points for Group2"
## [1] "sample 10 points for Group3"
## [1] "start figure plotting for ncrna ..."

## Warning: Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Use of ‘densityCI$x‘ is discouraged.
## i Use ‘x‘ instead.
## Warning: Use of ‘vline_pos$x1‘ is discouraged.
## i Use ‘x1‘ instead.
## Warning: Use of ‘vline_pos$y1‘ is discouraged.
## i Use ‘y1‘ instead.
## Warning: Use of ‘vline_pos$x2‘ is discouraged.
## i Use ‘x2‘ instead.
## Warning: Use of ‘vline_pos$y2‘ is discouraged.
## i Use ‘y2‘ instead.

17

6 Session Information

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

18

1kbncRNA1kb0123DensityGroup1Group2Group3grDevices utils

stats
methods

graphics
base

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[1] Guitar_2.26.0
[3] ggplot2_4.0.0
[5] rtracklayer_1.70.0
[7] AnnotationDbi_1.72.0
[9] GenomicRanges_1.62.0

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

dplyr_1.1.4
magrittr_2.0.4
GenomicFeatures_1.62.0
Biobase_2.70.0
Seqinfo_1.0.0
S4Vectors_0.48.0
generics_0.1.4

##
## locale:
##
##
##
##
##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4
## [6] datasets
##
## other attached packages:
##
##
##
##
##
## [11] IRanges_2.44.0
## [13] BiocGenerics_0.56.0
## [15] knitr_1.50
##
## loaded via a namespace (and not attached):
##
##
##
##
##
## [11] parallel_4.5.1
## [13] RSQLite_2.4.3
## [15] blob_1.2.4
## [17] Matrix_1.7-4
## [19] S7_0.2.0
## [21] lifecycle_1.0.4
## [23] farver_2.1.2
## [25] Rsamtools_2.26.0
## [27] codetools_0.2-20
## [29] yaml_2.3.10
## [31] crayon_1.5.3
## [33] DelayedArray_0.36.0
## [35] abind_1.4-8
## [37] restfulr_0.0.16
## [39] fastmap_1.2.0
## [41] cli_3.6.5
## [43] S4Arrays_1.10.0
## [45] XML_3.99-0.19
## [47] scales_1.4.0
## [49] XVector_0.50.0
## [51] matrixStats_1.5.0
## [53] ragg_1.5.0

SummarizedExperiment_1.40.0
rjson_0.2.23
lattice_0.22-7
tools_4.5.1
curl_7.0.0
tibble_3.3.0
highr_0.11
pkgconfig_2.0.3
RColorBrewer_1.1-3
cigarillo_1.0.0
compiler_4.5.1
textshaping_1.0.4
Biostrings_2.78.0
RCurl_1.98-1.17
pillar_1.11.1
BiocParallel_1.44.0
cachem_1.1.0
tidyselect_1.2.1
labeling_0.4.3
grid_4.5.1
SparseArray_1.10.0
dichromat_2.0-0.1
withr_3.0.2
bit64_4.6.0-1
httr_1.4.7
bit_4.6.0
png_0.1-8

[1] KEGGREST_1.50.0
[3] gtable_0.3.6
[5] xfun_0.53
[7] vctrs_0.6.5
[9] bitops_1.0-9

19

## [55] memoise_2.0.1
## [57] BiocIO_1.20.0
## [59] glue_1.8.0
## [61] R6_2.6.1
## [63] MatrixGenerics_1.22.0

evaluate_1.0.5
rlang_1.1.6
DBI_1.2.3
systemfonts_1.3.1
GenomicAlignments_1.46.0

20


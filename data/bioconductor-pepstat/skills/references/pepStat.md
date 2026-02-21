A complete analysis of peptide microarray binding data using the
pepStat framework

Greg Imholte∗, Renan Sauteraud†, Mike Jiang‡and Raphael Gottardo§

October 30, 2025

This document present a full analysis, from reading the data to displaying the results that

makes use of all the packages we developped for peptide microarray.

Contents

1 Introduction

1.1 Requirements . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Generating a peptideSet

2.1 Reading in .gpr files . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Additional arguments
2.3 Visualize slides . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Adding peptide informations

3.1 Creating a custom peptide collection . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Summarize the information . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Normalization

5 Data smoothing

6 Making calls

7 Results
7.1
summary . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7.2 Plots . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

8 shinyApp

9 Quick analysis

∗gimholte@uw.edu
†rsautera@fhcrc.org
‡wjiang2@fhcrc.org
§rgottard@fhcrc.org

1

3
3

3
3
4
4

5
6
6

6

7

7

8
8
8

10

11

10 sessionInfo

12

2

1

Introduction

The pepStat package offers a complete analytical framework for the analysis of peptide microarray
data.
It includes a novel normalization method to remove non-specific peptide binding activity
of antibodies, a data smoothing reducing step to reduce background noise, and subject-specific
positivity calls.

1.1 Requirements

The pepStat package requires GSL, an open source scientific computing library. This library is
freely available at http://www.gnu.org/software/gsl/.

In this vignette, we make use of the samples and examples available in the data package pepDat.

2 Generating a peptideSet

library(pepDat)
library(pepStat)

2.1 Reading in .gpr files

The reading function, makePeptideSet, takes a path as its argument and parses all the .gpr files
in the given directory. Alternatively, one may specify a character vector of paths to individual .gpr
files.

By default channels F635 Median and B635 Median are collected, and the ’normexp’ method
of the backgroundCorrect function in the limma package corrects probe intensities for background
fluorescence. Other methods may be selected, see documentation.

mapFile <- system.file("extdata/mapping.csv", package = "pepDat")
dirToParse <- system.file("extdata/gpr_samples", package = "pepDat")
pSet <- makePeptideSet(files = NULL, path = dirToParse,

mapping.file = mapFile, log=TRUE)

While optional, it is strongly recommended to provide a mapping.file giving annotations data
for each slide, such as treatment status or patient information. If provided, the mapping.file should
be a .csv file. It must include columns labeled filename, ptid, and visit. Elements in column
filename must correspond to the filenames of slides to be read in, without the .gpr extension.
Column ptid is a subject or slide identifier. Column visit indicates a case or control condition,
such as pre/post vaccination, pre/post infection, or healthy/infected status. Control conditions
must be labelled pre, while case conditions must be labelled post. Alternatively, one may input a
data.frame satisfying the same requirements.

This minimal information is required by pepStat’s functions further in the analysis. Any

additional information (column) will be retained and can be used as a grouping variable.

If no mapping file is included, the information will have to be added later on to the peptideSet

object.

3

For our example, we use a toy dataset of 8 samples from 4 patients and we are interested in

comparing the antibody binding in placebo versus vaccinated subjects.

read.csv(mapFile)

##
## 1
## 2
## 3
## 4
## 5
## 6
## 7
## 8

filename ptid visit treatment
PLACEBO
PLACEBO
PLACEBO
PLACEBO
VACCINE
VACCINE
VACCINE
VACCINE

1
Pre
1 Post
2
Pre
2 Post
3
Pre
3 Post
4
Pre
4 Post

f1_1
f1_2
f2_1
f2_2
f3_1
f3_2
f4_1
f4_2

2.2 Additional arguments

The empty spots should be listed in order to background correct the intensities. It is also useful to
remove the controls when reading the data. Here we have the JPT controls, human Ig (A, E and
M) and dye controls.

pSetNoCtrl <- makePeptideSet(files = NULL, path = dirToParse,

mapping.file = mapFile, log = TRUE,
rm.control.list = c("JPT-control", "Ig", "Cy3"),
empty.control.list= c("empty", "blank control"))

2.3 Visualize slides

We include two plotting functions to detect possible spatial slide artifacts. Since the full plate is
needed for this visualization, the functions will work best with rm.contol.list and empty.control.list
set to NULL in makePeptideSet.

plotArrayImage(pSet, array.index = 1)

## Warning: ‘aes string()‘ was deprecated in ggplot2 3.0.0.
## i Please use tidy evaluation idioms with ‘aes()‘.
## i See also ‘vignette("ggplot2-in-packages")‘ for more information.
## i The deprecated feature was likely used in the pepStat package.
##
Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call ‘lifecycle::last lifecycle warnings()‘ to see where this warning was
## generated.

4

plotArrayResiduals(pSet, array.index = 1, smooth = TRUE)

3 Adding peptide informations

At this point, the peptideSet contain only the peptide sequences and the associated background
corrected intensities. To continue with the analysis, we need to add the position information, as
well as physicochemical properties of the peptides summarized by their z-scales.

The slides used in this example are the enveloppe of HIV-1 and peptide collections are available
for this in our pepDat package (please refere to the vignette and ?pep hxb2 for more information).
However, we will pretend that this is not the case to show an example of how to build a custom
peptide collection.

5

Intensity510Sample Name: f1_1Intensity−3−2−1012Smoothed Residuals for Sample Name f1_13.1 Creating a custom peptide collection

Here, we load a data.frame that contains the peptides used on the array as well as their start and
end coordinates, and clade information.

peps <- read.csv(system.file("extdata/pep_info.csv", package = "pepDat"))
head(peps)

##
## 1
## 2
## 3
## 4
## 5
## 6

start end

peptide clade
1 16 MRVKETQMNWPNLWK CRF01
1 16 MRVMGIQKNYPLLWR CRF02
A
1 16 MRVMGIQRNCQHLWR
B
1 16 MRVKGIRKNYQHLWR
C
1 16 MRVRGILRNWQQWWI
D
1 16 MRVRGIERNYQHLWR

Then we call the constructor that will create the appropriate collection.

pep_custom <- create_db(peps)

pep custom is a GRanges object with the required ”peptide” metadata column and the physio-

chemical properties of each peptide sequence summarized by z-scores.

Note that the function will also accept GRanges input.

pep_custom <- create_db(pep_custom)

3.2 Summarize the information

The function summarizePeptides summarizes within-slide replicates by either their mean or me-
dian. Additionaly, with the newly constructed peptide collection, peptides positions and annota-
tions can be passed on to the existing peptideSet. Alternately, the function could be callled directly
on the data.frame object. Internally, summarizePeptides will call create db to make sure the
input is formatte appropriately.

psSet <- summarizePeptides(pSet, summary = "mean", position = pep_custom)

## Some peptides have no match in the GRanges object rownames and are removed from
the peptideSet!

Now that all the required information is available, we can proceed with the analysis.

4 Normalization

The primary goal of the data normalization step is to remove non-biological source of bias and in-
crease the comparability of true positive signal intensities across slides. The method developped for
this package uses physiochemical properties of individual peptides to model non-specific antibody
binding to arrays.

6

pnSet <- normalizeArray(psSet)

An object of class peptideSet containing the corrected peptides intensities is returned.

5 Data smoothing

The optional data smoothing step takes advantage of the overlapping nature of the peptides on the
array to remove background noise caused by experimental variation. It is likely that two overlapping
peptides will share common binding signal, when present. pepStat use a sliding mean technique
technique to borrow strength across neighboring peptides and to reduce signal variability. This
statistic increases detection of binding hotspots that noisy signals might otherwise obscure. Peptides
are smoothed according to their sequence alignment position, taken from position(psSet).

From here on, two types of analyses are possible. The peptides can be aggregated by position or
split by clade. When aggregating by position, the sliding mean will get information from surround-
ing peptides as well as peptides located around their coordinates in other clades. This increase the
strength of calls but the clade specificity is lost.

It is common to do a first run with aggregated clades to detect binding hotspots and then do

a second run to look for clade specificity in the peaks found during the first run.

This is decided by the split.by.clade argument. By default it is set to TRUE for a clade

specific analysis.

psmSet <- slidingMean(pnSet, width = 9)

For the aggregated peptideSet we set it to FALSE.

psmSetAg <- slidingMean(pnSet, width = 9, split.by.clade = FALSE)

6 Making calls

The final step is to make the positivity calls. The function makeCalls automatically uses infor-
mation provided in the mapping file, accessed via pData(pSet). It detects whether samples are
paired or not. If samples are paired, POST intensities are subtracted from PRE intensities, then
thresholded. Otherwise, PRE samples are averaged, and then subtracted from POST intensities.
These corrected POST intensities are thresholded.

The freq argument controls whether we return the percentage of responders against each pep-
tide, or a matrix of subject specific call. When freq is TRUE, we may supply a group variable from
pData(psmSet) on which we split the frequency calculation.

calls <- makeCalls(psmSet, freq = TRUE, group = "treatment",

cutoff = .1, method = "FDR", verbose = TRUE)

## You have paired PRE/POST samples

## The selected threshold T is 1.100119

7

The function automatically selected an appropriate FDR threshold.

callsAg <- makeCalls(psmSetAg, freq = TRUE, group = "treatment",

cutoff = .1, method = "FDR")

7 Results

7.1

summary

To get a summary of the analysis, for each peptide, the package provides the function restab that
combines a peptideSet and the result of makeCalls into a single data.frame with one row per
peptide and per clade.

summary <- restab(psmSet, calls)
head(summary)

peptide position start end width clade PLACEBO
0
0
0
0
0
100

16 CRF01
B
16
16 CRF02
A
16
M
16
D
16

16
16
16
16
16
16

1
1
1
1
1
1

8
8
8
8
8
8

##
## MRVKETQMNWPNLWK_CRF01 MRVKETQMNWPNLWK
MRVKGIRKNYQHLWR
## MRVKGIRKNYQHLWR_B
## MRVMGIQKNYPLLWR_CRF02 MRVMGIQKNYPLLWR
MRVMGIQRNCQHLWR
## MRVMGIQRNCQHLWR_A
MRVMGIQRNWQHLWR
## MRVMGIQRNWQHLWR_M
MRVRGIERNYQHLWR
## MRVRGIERNYQHLWR_D
VACCINE
##
0
## MRVKETQMNWPNLWK_CRF01
0
## MRVKGIRKNYQHLWR_B
0
## MRVMGIQKNYPLLWR_CRF02
0
## MRVMGIQRNCQHLWR_A
0
## MRVMGIQRNWQHLWR_M
0
## MRVRGIERNYQHLWR_D

Note that if calls are made with a peptideSet that has been normalized with split.by.clade
set to FALSE, the table will have one row per peptide. Peptides that are identical accross clades
will only have one entry.

7.2 Plots

As part of the pipeline for the analysis of peptide microarray data, the Pviz package includes a
track that can use the result of an experiment to generate plots.

When analysing all clades at once, the plot inter function can be used to easily identify
binding peaks. It gives an overview of the differences between the selected groups. In this case,
comparing placebo and vaccine.

library(Pviz)
summaryAg <- restab(psmSetAg, callsAg)
plot_inter(summaryAg)

8

When clade specific calls have been made, it is more interesting to plot each clade on a separate

track.

plot_clade(summary, clade=c("A", "M", "CRF01"), from = 300, to = 520)

9

100200300400500600700800NHCOOH         FeaturesV1V2V3V4V5MPERTM020406080100FreqPLACEBOVACCINE350400450500NHCOOH         V3V4V5020406080100A020406080100M020406080100CRF01PLACEBOVACCINEMuch more complex plots can be made, custom tracks can be added and every graphical pa-
rameter can be tweaked. Refer to the Pviz documentation as well as the Gviz package for detailed
information on all tracks and display paramters.

8

shinyApp

As part of the package, a shinyApp provides a user interface for peptide microarray analysis. After
making the calls, the results can be downloaded and the app displays plots as shown in the previous
sections.

The app can be started from the command line using the shinyPepStat function.

shinyPepStat()

10

9 Quick analysis

Here we showcase a quick analysis of peptide microarray data for HIV-1 gp160. This displays the
minimal amount of code required to go from raw data file to antibody binding positivity call.

library(pepStat)
library(pepDat)
mapFile <- system.file("extdata/mapping.csv", package = "pepDat")
dirToParse <- system.file("extdata/gpr_samples", package = "pepDat")
ps <- makePeptideSet(files = NULL, path = dirToParse, mapping.file = mapFile)
data(pep_hxb2)
ps <- summarizePeptides(ps, summary = "mean", position = pep_hxb2)
ps <- normalizeArray(ps)
ps <- slidingMean(ps)
calls <- makeCalls(ps, group = "treatment")
summary <- restab(ps, calls)

11

LAPACK version 3.12.0

datasets

10

sessionInfo

sessionInfo()

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
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
## [1] grid
## [8] methods
##
## other attached packages:
##
##
##
## [10] generics_0.1.4
##
## loaded via a namespace (and not attached):
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

[1] RColorBrewer_1.1-3
[3] jsonlite_2.0.0
[5] GenomicFeatures_1.62.0
[7] rmarkdown_2.30
[9] fields_17.1
[11] memoise_2.0.1
[13] RCurl_1.98-1.17
[15] htmltools_0.5.8.1
[17] progress_1.2.3
[19] SparseArray_1.10.0
[21] htmlwidgets_1.6.4

rstudioapi_0.17.1
magrittr_2.0.4
farver_2.1.2
BiocIO_1.20.0
vctrs_0.6.5
Rsamtools_2.26.0
base64enc_0.1-3
S4Arrays_1.10.0
curl_7.0.0
Formula_1.2-5
plyr_1.8.9

[1] Pviz_1.44.0
[4] Seqinfo_1.0.0
[7] S4Vectors_0.48.0

Gviz_1.54.0
pepStat_1.44.0
Biobase_2.70.0
pepDat_1.29.0

grDevices utils

stats4
base

graphics

stats

12

GenomicRanges_1.62.0
IRanges_2.44.0
BiocGenerics_0.56.0
knitr_1.50

cachem_1.1.0
lifecycle_1.0.4
Matrix_1.7-4
fastmap_1.2.0
digest_0.6.37
AnnotationDbi_1.72.0
RSQLite_2.4.3
labeling_0.4.3
abind_1.4-8
bit64_4.6.0-1
htmlTable_2.4.3
backports_1.5.0
DBI_1.2.3
maps_3.4.3
rappdirs_0.3.3
rjson_0.2.23
foreign_0.8-90
glue_1.8.0
checkmate_2.3.3
gtable_0.3.6
ensembldb_2.34.0
hms_1.1.4
pillar_1.11.1
spam_2.11-1
dplyr_1.1.4
lattice_0.22-7
rtracklayer_1.70.0
biovizBase_1.58.0
Biostrings_2.78.0
ProtGenerics_1.42.0

[23] httr2_1.2.1
[25] GenomicAlignments_1.46.0
[27] pkgconfig_2.0.3
[29] R6_2.6.1
[31] MatrixGenerics_1.22.0
[33] colorspace_2.1-2
[35] Hmisc_5.2-4
[37] filelock_1.0.3
[39] httr_1.4.7
[41] compiler_4.5.1
[43] withr_3.0.2
[45] S7_0.2.0
[47] BiocParallel_1.44.0
[49] highr_0.11
[51] biomaRt_2.66.0
[53] DelayedArray_0.36.0
[55] tools_4.5.1
[57] nnet_7.3-20
[59] restfulr_0.0.16
[61] cluster_2.1.8.1
[63] BSgenome_1.78.0
[65] data.table_1.17.8
[67] XVector_0.50.0
[69] stringr_1.5.2
[71] limma_3.66.0
[73] BiocFileCache_3.0.0
[75] deldir_2.0-4
[77] bit_4.6.0
[79] tidyselect_1.2.1
[81] gridExtra_2.3
[83] SummarizedExperiment_1.40.0 xfun_0.53
[85] statmod_1.5.1
[87] stringi_1.8.7
[89] lazyeval_0.2.2
[91] evaluate_1.0.5
[93] cigarillo_1.0.0
[95] tibble_3.3.0
[97] rpart_4.1.24
[99] Rcpp_1.1.0

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
##
##
##
##
##
##
##
##
##
## [101] dbplyr_2.5.1
## [103] XML_3.99-0.19
## [105] ggplot2_4.0.0
## [107] prettyunits_1.2.0
## [109] jpeg_0.1-11
## [111] AnnotationFilter_1.34.0

matrixStats_1.5.0
UCSC.utils_1.6.0
yaml_2.3.10
codetools_0.2-20
interp_1.1-6
cli_3.6.5
dichromat_2.0-0.1
GenomeInfoDb_1.46.0
png_0.1-8
parallel_4.5.1
blob_1.2.4
dotCall64_1.2
latticeExtra_0.6-31
bitops_1.0-9

13

## [113] viridisLite_0.4.2
## [115] scales_1.4.0
## [117] rlang_1.1.6

VariantAnnotation_1.56.0
crayon_1.5.3
KEGGREST_1.50.0

14


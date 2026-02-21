The Pviz User Guide

Renan Sauteraud∗

October 30, 2025

Contents

1 Introduction

2 Gviz tracks

2.1 ATrack . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 DTrack . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Pviz new track types

3.1 ProteinAxisTrack . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 ProteinSequenceTrack . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 ProbeTrack . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 CladeTrack . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Example of plot

5 Summary plots
5.1 plot inter
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2 plot clade . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

6 sessionInfo

1

Introduction

1

2
2
2

3
3
4
5
6

7

8
8
9

10

Pviz is an R package inspired by and depending on Gviz. It introduces new types of track and extends
the existing ones in order to deal with amino-acid based data.

This package keeps most of the mechanics of Gviz, notably the use of DisplayParameters and the
same plotting function: plotTracks. Therefore, the user is invited to refer to Gviz help pages and
vignette for more information and examples.

As with any R package, it should first be loaded in the session

library(Pviz)

∗rsautera@fhcrc.org

1

2 Gviz tracks

Pviz extends and uses the most common classes of Gviz to make them easier to use with amino acid data.
We removed the requirement for a genome and a chromosome when creating these tracks. Moreover, they
support the functions defined in Pviz.

2.1 ATrack

ATrack extends Gviz’s AnnotationTrack and behaves the same way. However,
it does not require
to specify a chromosome and a genome. Please refer to Gviz documentation for more details about
AnnotationTrack and the available DisplayParameters.

at<-ATrack(start = c(250, 480), end = c(320, 520), id = c("Anno1", "Anno2"),

showFeatureId = TRUE, fontcolor = "black", name = "Annotations")

plotTracks(at, from = 1, to = 600)

2.2 DTrack

Naturally DTrack extends Gviz’s DataTrack. Here again, please refer to Gviz documentation for details
on how to use DataTrack.

Some example data are available in the data package pepDat. Frequency of antibody binding event

in hxb2 enveloppe peptides.

library(pepDat)
data(restab_aggregate)
dt <- DTrack(data = restab_aggregate$group2, start = restab_aggregate$start,

width=15, name="Freq", type = "l")

plotTracks(dt, from = 1, to = 850, type = "l")

2

AnnotationsAnno1Anno23 Pviz new track types

Pviz introduce some new track types to deal with amino-acid based data. The new tracks look can be
modified using the DisplayParameters and will most of the time offer the same options as the ones
available for Gviz tracks.

3.1 ProteinAxisTrack

This track acts as a replacement for the GenomeAxisTrack. I comes with the same coloration, transparency
and other customization options but loses the DNA representation for a simple segment.

pat<-ProteinAxisTrack()
plotTracks(pat, from = 1, to = 850)

Just like in GenomeAxisTrack, it is possible to use littleTicks to get a more precise scale. Moreover,
because Pviz, has been made to deal with peptides and protein, the option addNC can display indicators

3

0204060Freq100200300400500600700800for N-term and C-term ends on the axis.

pat<-ProteinAxisTrack(addNC = TRUE, littleTicks = TRUE)
plotTracks(pat, from = 1, to = 850)

3.2 ProteinSequenceTrack

This new track simply displays a selected sequence. It can takes both AAstring or regular character.

Note that the first amino acid of the sequence should correspond to the first position of any other

element you choose to display at the same time.

The previously loaded dataset also contains the sequence of the envelope of hxb2 to be used as an
example. The peptide collections in pepDat contain reference sequence as metadata. Here hxb2 sequence
is displayed.

data(pep_hxb2)
hxb2_seq <- metadata(pep_hxb2)$sequence
st <- ProteinSequenceTrack(sequence = hxb2_seq, name = "env")
plotTracks(trackList = c(pat, st), from = 1, to = 40)

The sequence track for proteins handles overplotting the same way it does it for nucleotides. If the
plotting range becomes wider, only the color code will be displayed. Once it becomes too big to even
show these colors, a straight line will be displaed. Naturally, the character size will also influence what
can be displayed in the graphic window.

st <- ProteinSequenceTrack(sequence = hxb2_seq, name = "env", cex = 0.5)
plotTracks(trackList = c(pat, st), from = 1, to = 850)

4

100200300400500600700800406080120140160180220240260280320340360380420440460480520540560580620640660680720740760780820NHCOOH         102030NHCOOH         envRVKEKYQHLWRWGWRWGTMLLGMLMICSATEKLWVTVYAlthough the character expansion has been set to less than 1. The ranges are still too wide for a

correct display and only a straight line will be displayed.

3.3 ProbeTrack

This track is designed to display peptide microarray data. It draws each peptide relative to its position
in the sequence and enclose them in rectangles colored depending on their frequency of binding event or
intensity. It is useful to spot differences between clades at a specific position or get an overview of the
regions with antibody binding activity, depending on the scale used while plotting.

To create this track, the sequence of the peptides, their intensity or frequency and their starting
position have to be passed as arguments. All three arguments should be of the same length. Here, the
result of a peptide microarray analysis is used. This time with clade specific calls.

data(restab)
pt<-ProbeTrack(sequence = restab$peptide, intensity = restab$group2,

plotTracks(pt, from = 460, to = 560)

probeStart = restab$start)

5

100200300400500600700800406080120140160180220240260280320340360380420440460480520540560580620640660680720740760780820NHCOOH         envProbeTrackNNNNTNETFRPGGGNNNNNTTETFRPGGGDNNNNTTETFRPGGGDNNNSQNETFRPGGGDNNNSTNETFRPGGGDNNNSTNETFRPGGGDNNNSTNETFRPGGGDNTNETFRPGGGNIKDNTTETFRPGGGDMKDNTTETFRPGGGDMRDSQNETFRPGGGDMRDSTNETFRPGGGDMRDSTNETFRPGGGDMRDSTNETFRPGGGDMRDETFRPGGGDMKDNWRETFRPGGGDMRDNWRETFRPGGGDMRDNWRETFRPGGGDMRDNWRETFRPGGGDMRDNWRETFRPGGGDMRDNWRETFRPGGGNIKDNWRRPGGGDMKDNWRSELRPGGGDMRDNWRSELRPGGGDMRDNWRSELRPGGGDMRDNWRSELRPGGGDMRDNWRSELRPGGGDMRDNWRSELRPGGGNIKDNWRSELGGDMKDNWRSELYKYGGDMRDNWRSELYKYGGDMRDNWRSELYKYGGDMRDNWRSELYKYGGDMRDNWRSELYKYGGDMRDNWRSELYKYGGNIKDNWRSELYKYIKDNWRSELYKYKVVMKDNWRSELYKYKVVMRDNWRSELYKYKVVMRDNWRSELYKYKVVMRDNWRSELYKYKVVMRDNWRSELYKYKVVMRDNWRSELYKYKVVNWRSELYKYKVVEIKNWRSELYKYKVVKIENWRSELYKYKVVKIENWRSELYKYKVVKIENWRSELYKYKVVKIENWRSELYKYKVVQIENWRSELYKYKVVRIESELYKYKVVEIKPLGSELYKYKVVKIEPLGSELYKYKVVKIEPLGSELYKYKVVKIEPLGSELYKYKVVKIEPLGSELYKYKVVQIEPLGSELYKYKVVRIEPLGYKYKVVEIKPLGIAPYKYKVVKIEPLGVAPYKYKVVKIEPLGVAPYKYKVVKIEPLGVAPYKYKVVKIEPLGVAPYKYKVVQIEPLGIAPYKYKVVRIEPLGLAPKVVEIKPLGIAPTKAKVVKIEPLGVAPTHAKVVKIEPLGVAPTKAKVVKIEPLGVAPTKAKVVKIEPLGVAPTRAKVVQIEPLGIAPTRAKVVRIEPLGLAPTKAEIKPLGIAPTKAKRRKIEPLGVAPTHAKRRKIEPLGVAPTKAKRRKIEPLGVAPTKAKRRKIEPLGVAPTRAKRRQIEPLGIAPTRAKRRRIEPLGLAPTKAKRRPLGIAPTKAKRRVVEPLGIAPTRAKRRVVEPLGLAPTKAKRRVVEPLGVAPTHAKRRVVEPLGVAPTKAKRRVVEPLGVAPTKAKRRVVQPLGVAPTRAKRRVVEIAPTKAKRRVVEREKIAPTRAKRRVVEREKLAPTKAKRRVVEREKVAPTHAKRRVVEREKVAPTKAKRRVVEREKVAPTKAKRRVVQREKVAPTRAKRRVVEREKTHAKRRVVEREKRAVTKAKRRVVEREKRAITKAKRRVVEREKRAVTKAKRRVVEREKRAVTKAKRRVVQREKRAVTRAKRRVVEREKRAVTRAKRRVVEREKRAVKRRVVEREKRAIGLGKRRVVEREKRAVGIGKRRVVEREKRAVGIGKRRVVEREKRAVGIGKRRVVEREKRAVGIGKRRVVEREKRAVGLGKRRVVQREKRAVGIGVVEREKRAIGLGAMFVVEREKRAVGIGAMIVVEREKRAVGIGAVFVVEREKRAVGIGAVFVVEREKRAVGIGAVFVVEREKRAVGLGAVFVVQREKRAVGIGAMFREKRAIGLGAMFLGFREKRAVGIGAMFLGFREKRAVGIGAMIFGFREKRAVGIGAVFLGFREKRAVGIGAVFLGFREKRAVGIGAVFLGFREKRAVGLGAVFLGFRAIGLGAMFLGFLGARAVGIGAMFLGFLGARAVGIGAMIFGFLGARAVGIGAVFLGFLGARAVGIGAVFLGFLGARAVGIGAVFLGFLGARAVGLGAVFLGFLGAGIGAMFLGFLGAAGSGIGAMIFGFLGAAGSGIGAVFLGFLGAAGSGIGAVFLGFLGAAGSGIGAVFLGFLGAAGSGLGAMFLGFLGAAGSGLGAVFLGFLGAAGSAMFLGFLGAAGSTMGAMFLGFLGAAGSTMGAMIFGFLGAAGSTMGAVFLGFLGAAGSTMGAVFLGFLGAAGSTMGAVFLGFLGAAGSTMGAVFLGFLGAAGSTMGFGFLGAAGSTMGAASLGFLGAAGSTMGAASLGFLGAAGSTMGAASLGFLGAAGSTMGAASLGFLGAAGSTMGAASLGFLGAAGSTMGAASLGFLGAAGSTMGAASLGAAGSTMGAASITLLGAAGSTMGAASITLLGAAGSTMGAASITLLGAAGSTMGAASITLLGAAGSTMGAASITLLGAAGSTMGAASLTLLGAAGSTMGAASMTLAGSTMGAASITLTVQAGSTMGAASITLTVQAGSTMGAASITLTVQAGSTMGAASITLTVQAGSTMGAASITLTVQAGSTMGAASLTLTVQAGSTMGAASMTLTVQTMGAASITLTVQARQTMGAASITLTVQARQTMGAASITLTVQARQTMGAASITLTVQARQTMGAASITLTVQARQTMGAASLTLTVQARQTMGAASMTLTVQARQAASITLTVQARQLLSAASITLTVQARQLLSAASITLTVQARQLLSAASITLTVQARQLLSAASITLTVQARQLLSAASLTLTVQARQLLSAASMTLTVQARQLLSITLTVQARQLLSGIVITLTVQARQLLSGIVITLTVQARQLLSGIVITLTVQARQLLSGIVITLTVQARQLLSGIVLTLTVQARQLLSGIVMTLTVQARQLLSGIVTVQARQLLSGIVQQQTVQARQLLSGIVQQQTVQARQLLSGIVQQQTVQARQLLSGIVQQQTVQARQLLSGIVQQQTVQARQLLSGIVQQQTVQARQLLSGIVQQQARQLLSGIVQQQNNLARQLLSGIVQQQNNLARQLLSGIVQQQSNLARQLLSGIVQQQSNLARQLLSGIVQQQSNLARQLLSGIVQQQSNLARQLLSGIVQQQSNLLLSGIVQQQNNLLRALLSGIVQQQNNLLRALLSGIVQQQSNLLRALLSGIVQQQSNLLRALLSGIVQQQSNLLRALLSGIVQQQSNLLRALLSGIVQQQSNLLRAGIVQQQNNLLRAIEGIVQQQNNLLRAIEGIVQQQSNLLRAIEGIVQQQSNLLRAIEGIVQQQSNLLRAIEGIVQQQSNLLRAIEGIVQQQSNLLRAIEQQQNNLLRAIEQQQNNLLRAIEQQQSNLLRAIEQQQSNLLRAIEQQQSNLLRAIEQQQSNLLRAIEQQQSNLLRAIENNLLRAIENNLLRAIESNLLRAIESNLLRAIESNLLRAIESNLLRAIESNLLRAIELRAIELRAIELRAIELRAIELRAIELRAIELRAIEIEIEIEIEIEIEIEUnlike in ProteinSequenceTrack, the size of the characters in each peptide sequence depends on
the plotting ranges (the user can still choose to change the size manually) and if the ranges become too
wide, the characters will appear as dots or completely disappear instead of stacking on top of each other.
While it loses the sequence information, it might be relevant to locate regions where peptides have high
intensity/frequency.

plotTracks(pt, legend = TRUE)

For a more explicit display, a legend has been implemented for this track and can be called during track
creation or in the plotting function. The legend displays the scale of frequencies.

3.4 CladeTrack

Finally, after displaying all peptides, it is possible to look at clades of interest or compare the binding
activity in different clades.

CladeTrack extends DTrack and adds a new constructor that can use the result of a peptide microarray
analysis from pepStat to create the track. The display parameters are the same as in DTrack and Gviz’s
DataTrack.

ctA <- CladeTrack(restab, clade = "A", type = "l")
ctM <- CladeTrack(restab, clade = "M", type = "l", legend = TRUE)
plotTracks(c(ctA, ctM), main = "Clades comparison", cex.main = 1.5)

6

ProbeTrack0.0083.754 Example of plot

Naturally, the interest of Pviz, just like its parent Gviz is the display of multiple tracks at once. Here is
an example of what Pviz can render, using the tracks previously created.

pt <- ProbeTrack(sequence = restab$peptide, intensity = restab$group2,

plotTracks(trackList=c(pat, st, at, pt, ctM), from=460, to=560,

probeStart = restab$start, cex=0, legend=TRUE)

type="l")

7

Clades comparison01020304050Agroup1group2020406080Mgroup1group25 Summary plots

As part of the pipeline for peptide microarray analysis, the package provides two function to quickly
dispplay the result of an experiment. These ploting functions come with a selected set of tracks as well
as hard coded annotations for hxb2 enveloppe landmarks. The function are used as a display in the
shinyApp that comes with pepStat.

More information regarding the plots and the analysis are available in the vignette of the pepStat

package. The additional display parameters are passed directly to the plotTracks function.

5.1 plot inter

First we can plot the result of an experiment:

plot_inter(restab_aggregate)

8

470480490500510520530540550464466468472474476478482484486488492494496498502504506508512514516518522524526528532534536538542544546548552554556NHCOOH         SNNESEIFRPGGGDMRDNWRSELYKYKVVKIEPLGVAPTKAKRRVVQREKRAVGIGALFLGFLGAAGSTMGAASMTLTVQARQLLSGIVQQQNNLLRAIAnnotationsAnno2ProbeTrack0.0081.25020406080Mgroup1group25.2 plot clade

Then redo a clade specific analysis and plot the results for clade of interest:

plot_clade(restab, clade = c("A", "B", "C"), sequence = hxb2_seq,

from = 100, to = 600)

9

100200300400500600700800NHCOOH         FeaturesV1V2V3V4V5MPERTM0204060Freqgroup1group2200300400500NHCOOH         V1V2V3V4V501020304050A020406080B0204060Cgroup1group2LAPACK version 3.12.0

datasets

6 sessionInfo

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
## [10] knitr_1.50
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

bitops_1.0-9
gridExtra_2.3
biomaRt_2.66.0
magrittr_2.0.4
matrixStats_1.5.0
RSQLite_2.4.3
png_0.1-8
ProtGenerics_1.42.0
pkgconfig_2.0.3
fastmap_1.2.0
dbplyr_2.5.1

[11] compiler_4.5.1
[13] GenomicFeatures_1.62.0
[15] vctrs_0.6.5
[17] stringr_1.5.2
[19] crayon_1.5.3
[21] backports_1.5.0

[1] pepDat_1.29.0
[4] GenomicRanges_1.62.0 Seqinfo_1.0.0
[7] S4Vectors_0.48.0

[1] DBI_1.2.3
[3] deldir_2.0-4
[5] httr2_1.2.1
[7] rlang_1.1.6
[9] biovizBase_1.58.0

graphics grDevices utils

BiocGenerics_0.56.0

stats4
base

Pviz_1.44.0

stats

Gviz_1.54.0
IRanges_2.44.0
generics_0.1.4

10

Rsamtools_2.26.0
UCSC.utils_1.6.0
xfun_0.53
cigarillo_1.0.0
jsonlite_2.0.0
blob_1.2.4
DelayedArray_0.36.0
jpeg_0.1-11
prettyunits_1.2.0
VariantAnnotation_1.56.0
stringi_1.8.7
rtracklayer_1.70.0
Rcpp_1.1.0

[23] XVector_0.50.0
[25] rmarkdown_2.30
[27] bit_4.6.0
[29] cachem_1.1.0
[31] GenomeInfoDb_1.46.0
[33] progress_1.2.3
[35] highr_0.11
[37] BiocParallel_1.44.0
[39] parallel_4.5.1
[41] cluster_2.1.8.1
[43] R6_2.6.1
[45] RColorBrewer_1.1-3
[47] rpart_4.1.24
[49] SummarizedExperiment_1.40.0 base64enc_0.1-3
[51] Matrix_1.7-4
[53] tidyselect_1.2.1
[55] dichromat_2.0-0.1
[57] yaml_2.3.10
[59] curl_7.0.0
[61] tibble_3.3.0
[63] KEGGREST_1.50.0
[65] evaluate_1.0.5
[67] BiocFileCache_3.0.0
[69] pillar_1.11.1
[71] MatrixGenerics_1.22.0
[73] RCurl_1.98-1.17
[75] hms_1.1.4
[77] scales_1.4.0
[79] Hmisc_5.2-4
[81] tools_4.5.1
[83] BiocIO_1.20.0
[85] BSgenome_1.78.0
[87] XML_3.99-0.19
[89] AnnotationDbi_1.72.0
[91] htmlTable_2.4.3
[93] Formula_1.2-5
[95] rappdirs_0.3.3
[97] dplyr_1.1.4
[99] gtable_0.3.6

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
## [101] SparseArray_1.10.0
## [103] htmlwidgets_1.6.4
## [105] memoise_2.0.1
## [107] lifecycle_1.0.4
## [109] bit64_4.6.0-1

nnet_7.3-20
rstudioapi_0.17.1
abind_1.4-8
codetools_0.2-20
lattice_0.22-7
Biobase_2.70.0
S7_0.2.0
foreign_0.8-90
Biostrings_2.78.0
filelock_1.0.3
checkmate_2.3.3
ensembldb_2.34.0
ggplot2_4.0.0
glue_1.8.0
lazyeval_0.2.2
interp_1.1-6
data.table_1.17.8
GenomicAlignments_1.46.0
latticeExtra_0.6-31
colorspace_2.1-2
restfulr_0.0.16
cli_3.6.5
S4Arrays_1.10.0
AnnotationFilter_1.34.0
digest_0.6.37
rjson_0.2.23
farver_2.1.2
htmltools_0.5.8.1
httr_1.4.7

11


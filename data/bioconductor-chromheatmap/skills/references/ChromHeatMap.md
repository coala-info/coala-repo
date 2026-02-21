ChromHeatMap

Tim F. Rayner

October 29, 2025

Cambridge Institute of Medical Research

1

Introduction

The ChromHeatMap package provides functions for visualising expression
data in a genomic context, by generating heat map images in which data is
plotted along a given chromosome for all the samples in a data matrix.

These functions rely on the existence of a suitable AnnotationDbi package
which provides chromosome location information for the probe- or gene-level
identifiers used in your data set. The data themselves must be in either an Ex-
pressionSet, or a data matrix with row names corresponding to probe or gene
identifiers and columns corresponding to samples. While the ChromHeatMap
package was originally designed for use with microarray data, given an appro-
priate AnnotationDbi package it can also be used to visualise data from next-
generation sequencing experiments.

The output heatmap can include sample clustering, and data can either be
plotted for each strand separately, or both strands combined onto a single heat
map. An idiogram showing the cytogenetic banding pattern of the chromosome
will be plotted for supported organisms (at the time of writing: Homo sapiens,
Mus musculus and Rattus norvegicus; please contact the maintainer to request
additions).

Once a heat map has been plotted, probes or genes of interest can be identi-
fied interactively. These identifiers may then be mapped back to gene symbols
and other annotation via the AnnotationDbi package.

2 Data preparation

Expression data in the form of a data matrix must initially be mapped onto its
corresponding chromosome coordinates. This is done using the makeChrStrandData:

> library('ALL')
> data('ALL')
> selSamples <- ALL$mol.biol %in% c('ALL1/AF4', 'E2A/PBX1')
> ALLs <- ALL[, selSamples]
> library('ChromHeatMap')
> chrdata<-makeChrStrandData(exprs(ALLs), lib='hgu95av2')

1

The output chrdata object here contains the expression data indexed by coor-
dinate. Note that the makeChrStrandData function is based on the Makesense
function in the geneplotter package, removing the internal call to lowess to
avoid smoothing the data (which is undesirable in this case). The makeChrStrandData
function is used specifically because it incorporates information on both the start
and end chromosome coordinates for each locus. This allows the plotChrMap
function to accurately represent target widths on the chromosome plot.

3 Plotting the heat map

Once the data has been prepared, a single call to plotChrMap will generate the
chromosome heat map. There are many options available for this plot, and only
a couple of them are illustrated here. Here we generate a whole-chromosome
plot (chromosome 19), with both strands combined into a single heat map:

> groupcol <- ifelse( ALLs$mol.biol == 'ALL1/AF4', 'red', 'green' )
> plotChrMap(chrdata, 19, strands='both', RowSideColors=groupcol)

ChrMapPlot
Number of features plotted: 157

Chromosomes can be subsetted by cytoband or start/end coordinates along
the chromosome. The following illustrates how one might plot the strands sep-
arately (this is the default behavior):

> plotmap<-plotChrMap(chrdata, 1, cytoband='q23', interval=50000, srtCyto=0, cexCyto=1.2)

2

c(1, boxwidth)c(1, 10)p13.3p13.2p13.13p13.12p13.11p12p11q11q12q13.11q13.12q13.13q13.2q13.31q13.32q13.33q13.41q13.42q13.43chromosome 19, both strands12930881586176287926431172352414654404175852852051616623447047263779272930880832239689351705703810145041032331439632124689409349824973527558545568673558617616630012803228028360012401904006260082400519005310071600415004LAL50801828003c(1, boxwidth)c(1, 10)p13.1p12p11.2p11.1q11q12q21.1q21.2q21.3q22q23.1q23.2q23.3q24.1q24.2q24.3q25.1q25.2q25.3q31.1q31.2q31.3q32.1chromosome 1, reverse strand154800000155250000155700000156150000156600000157050000157500000157950000158400000158850000159300000159750000160200000160650000161100000161550000162000000162450000162900000163350000163800000360011600404006260080801824019280286300124005LAL52800315004280321900531007chromosome 1, forward strand154800000155250000155700000156150000156600000157050000157500000157950000158400000158850000159300000159750000160200000160650000161100000161550000162000000162450000162900000163350000163800000360016300116004150043100728032LAL51900528003240050801828028240190400626008Other options include subsetting of samples, adding a color key to indicate
sample subsets, deactivating the sample-based clustering and so on. See the
help pages for plotChrMap and drawMapDendro for details.

Note that the default colors provided by the heat.colors function are not
especially attractive or informative; consider using custom-defined colors, for
example by using the RColorBrewer package.

The output of the plotChrMap function can be subsequently used with the
grabChrMapProbes function which enables the user to identify the probes or
genes responsible for heatmap bands of interest.

Note that the layout and par options for the current graphics device are not
reset following generation of the image. This is so that the grabChrMapProbes
function can accurately identify the region of interest when the user interactively
clicks on the diagram.

4

Interactive probe/gene identification

Often it will be of interest to determine exactly which probes or genes are shown
to be up- or down-regulated by the plotChrMap heat map. This can be done
using the grabChrMapProbes function. This takes the output of the plotChrMap
function, asks the user to mouse-click the heatmap on either side of the bands
of interest and returns a character vector of the locus identifiers in that region.
These can then be passed to the AnnotationDbi function mget to identify
which genes are being differentially expressed.

> probes <- grabChrMapProbes( plotmap )
> genes <- unlist(mget(probes, envir=hgu95av2SYMBOL, ifnotfound=NA))

Note that due to the way the expression values are plotted, genes which
lie very close to each other on the chromosome may have been averaged to
give a signal that could be usefully plotted at screen resolution. In such cases
the locus identifiers will be returned concatenated, separated by semicolons
(e.g. “37687_i_at;37688_f_at;37689_s_at”). Typically this is easily solved
by zooming in on a region of interest, using either the “cytoband” or “start”
and “end” options to plotChrMap. See also the “interval” option for another
approach to this problem.

5 Session information

The version number of R and packages loaded for generating the vignette were:

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

3

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4
[8] base

stats

graphics

grDevices utils

datasets methods

other attached packages:
[1] hgu95av2.db_3.13.0
[4] annotate_1.88.0
[7] IRanges_2.44.0
[10] Biobase_2.70.0

org.Hs.eg.db_3.22.0
XML_3.99-0.19
S4Vectors_0.48.0
BiocGenerics_0.56.0

ChromHeatMap_1.64.0
AnnotationDbi_1.72.0
ALL_1.51.0
generics_0.1.4

loaded via a namespace (and not attached):

[1] SparseArray_1.10.0
[3] RSQLite_2.4.3
[5] grid_4.5.1
[7] blob_1.2.4
[9] cigarillo_1.0.0

[11] DBI_1.2.3
[13] Biostrings_2.78.0
[15] abind_1.4-8
[17] rlang_1.1.6
[19] XVector_0.50.0
[21] cachem_1.1.0
[23] yaml_2.3.10
[25] tools_4.5.1
[27] BiocParallel_1.44.0
[29] Rsamtools_2.26.0
[31] curl_7.0.0
[33] R6_2.6.1
[35] BiocIO_1.20.0
[37] rtracklayer_1.70.0
[39] Seqinfo_1.0.0
[41] pkgconfig_2.0.3
[43] GenomicAlignments_1.46.0
[45] xtable_1.8-4
[47] compiler_4.5.1

bitops_1.0-9
lattice_0.22-7
fastmap_1.2.0
Matrix_1.7-4
restfulr_0.0.16
httr_1.4.7
codetools_0.2-20
cli_3.6.5
crayon_1.5.3
bit64_4.6.0-1
DelayedArray_0.36.0
S4Arrays_1.10.0
parallel_4.5.1
memoise_2.0.1
SummarizedExperiment_1.40.0
vctrs_0.6.5
png_0.1-8
matrixStats_1.5.0
KEGGREST_1.50.0
bit_4.6.0
GenomicRanges_1.62.0
MatrixGenerics_1.22.0
rjson_0.2.23
RCurl_1.98-1.17

4


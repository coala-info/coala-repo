MethylAid: Visual and Interactive qual-
ity control of Illumina Human DNA
Methylation array data

Maarten van Iterson, Davy Cats, Bas Heijmans

Molecular Epidemiology, Department of Biomedical Data Sciences,
Leiden University Medical Center, Leiden, The Netherlands

October 30, 2025

Contents

1

Introduction . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Quick start . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3

4

5

6

Example using presummarized DNA Methylation ar-
ray data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Example using 450k data downloaded from The Can-
cer Genome Atlas . . . . . . . . . . . . . . . . . . . . . . . .

Example using 450k data downloaded from GEO . .

Parallel summarization . . . . . . . . . . . . . . . . . . . . .

7 Customize MethylAid . . . . . . . . . . . . . . . . . . . . . .

7.1

User-defined thresholds . . . . . . . . . . . . . . . . . . .

7.2 Generating your own reference dataset . . . . . . . . . .

8

Session info . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

2

3

4

5

6

7

7

7

8

MethylAid: Visual and Interactive quality control of Illumina Human DNA Methylation array
data

1

Introduction

MethylAid is specially designed for quality control of large sets of Illumina Hu-
man DNA methylation array data sets e.g., epigenomewide association studies
(EWAS) using the 450k or 850k (EPIC) arrays. Extracting intensities from IDAT
files can be done in batches and/or in parallel to reduce memory load and/or
overcome long run-times. It requires two function calls in going from IDAT files
to launch the interactive web application; summarize and visualize. For more
information see van Iterson et al. [1].

To show the utility of MethylAid, we first show a quick example using a small
set of idat files taken from the minfiData package. A second example uses
presummarized data on 500 samples which can be used directly to launch the
web application. A third example shows how level 1 data downloaded from The
Cancer Genome Atlas can be used. Similar, in the fourth example we show
how data downloaded from GEO[2] can be used. For example, Liu et al.
[3]
studied genome-wide DNA methylation levels to determine whether Rheumatoid
arthritis patients has methylation differences comparing to normal controls in
peripheral blood leukocytes (PBLs) and deposit raw data on GEO. Furthermore,
we show how the summarization can be performed in batches or in parallel using
the BiocParallel package which provides a uniform idiom for parallel computing
resources.

MethylAid identifies poorly performing samples that are to be removed prior to
processing and further analysis of the data. Other R/Bioconductor -packages
such as, wateRmelon, minfi, methylumi, lumi, COHCAP, ChAMP, are available
for processing, i.e. background, dye-bias and probe correction or for further
analysis such as the detection of differentially methylated regions. Many of
these packages include quality control as well. The package shinyMethyl allows
quality control assessment and interactive exploration of 450k array data in a
similar way as MethylAid.

We have a demo running at http://shiny.bioexp.nl/MethylAid using the example-
data of the package.

2 Quick start

This example shows how to summarize a small set of idat files e.g. the summa-
rized data fits into the available RAM. The minfiData-package provides such
a set. The package contains 450k DNA methylation data on 6 samples across
2 groups. Since, MethylAid uses internally the function read.metharray.exp
from the minfi -package[4], target information should be provided in a similar
way as is done when using the minfi -package.

2

MethylAid: Visual and Interactive quality control of Illumina Human DNA Methylation array
data

library(MethylAid)

library(minfiData)

baseDir <- system.file("extdata", package = "minfiData")

targets <- read.metharray.sheet(baseDir)

## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/minfiData/extdata/SampleSheet.csv"

The function summarize performs the summarization of the the control probes
present on the array. The output produced by summarize is an object of class
summarizedData which should be passed on to the function visualize which
in turn will launch the interactive web application.

data <- summarize(targets)

visualize(data)

Comment: visualize can only be called interactively from within a R session.

Or in the same way using minfi ’s EPIC data set from the package minfi-
DataEPIC .

library(MethylAid)

library(minfiDataEPIC)

baseDir <- system.file("extdata", package = "minfiDataEPIC")

targets <- read.metharray.sheet(baseDir)

data <- summarize(targets)

visualize(data)

3

Example using presummarized DNA Methy-
lation array data

For those who directly want to explore the web application we have presumma-
rized 450k data on 500 samples. MethylAid will automatically detect whether
the data is from a 450k array or EPIC array. Therefore, using EPIC data can
be used in exactly the same way.

library(MethylAid)

data(exampleData)

visualize(exampleData)

Comment: visualize can only be called interactively from within a R session.

3

MethylAid: Visual and Interactive quality control of Illumina Human DNA Methylation array
data

When your webbrowser opens you should see something like Figure 1.
‘About‘ panel a description is given of what you see and can do.

In the

Figure 1: Screen shot MethylAid interactive web application: The web interface contains
three parts; a panel with widgets to control the appearance of the quality control plots,
tab-panels for chosing the quality control plot of interest and the interactive plotting area.
When the interactive web application is launched the rotated M versus U plot is shown.
Here using example data from the package on 500 450k human methylation samples with
selected “scan_batches” using the input selector widget “highlight metadata column”. The
different “scan_batches” are indicated with different colors. The dashed-vertical line indi-
cated the filter threshold, samples below the threshold should be removed.

4

Example using 450k data downloaded from
The Cancer Genome Atlas

The Cancer Genome Atlas (http://cancergenome.nih.gov/) provides a valuable
source of genomic data of various types of different cancers. Here all Breast
invasive carcinoma (BRCA) 450k level 1 DNA methylation data were download
from the TCGA Data Portal. A targets file can be constructed from the sdrf
file but some preprocessing is necessary. The following code chunk show how
to make a minimal targets file from a sdrf file. There is also a check to see if all
files are present otherwise these will be removed from the targets file. FixMe:
In the future this might be added as an internal check.

sdrfFile <- list.files(pattern="sdrf", full.name=TRUE)

targets <- read.table(sdrfFile, header=TRUE, sep="\t")
path <- "path_to_idat_files"
targets <- targets[file.exists(file.path(path, targets$Array.Data.File)),]

targets <- targets[grepl("Red", targets$Array.Data.File),]
targets$Basename <- gsub("_Red.*$", "", file.path(path, targets$Array.Data.File))
rownames(targets) <- basename(targets$Basename)

head(targets)

4

MethylAid: Visual and Interactive quality control of Illumina Human DNA Methylation array
data

Now the 2 × 137 idat files can be summarized. This could be too much to
read in at once therefore the option batchSize = 15 is used for summarization
of the data in batches of size 15. Furthermore, the summarized data is stored
as an RData-object for later use, using the option file = "tcgaBRCA". After
summarization the data can be loaded into R and passed to visualize for
interactive exploration of the data.

summarize(targets, batchSize = 15, file = "tcgaBRCA")

load("tcgaBRCA.RData")

visualize(tcgaBRCA)

Comment: visualize can only be called interactive from within a R session.

5

Example using 450k data downloaded from
GEO

Several 450k data sets are available from GEO some include raw idat files e.g.
the study of Liu et al. [3] with GEO series number: GSE42861. The idat files
of this study are available under GSE42861_RAW.tar. Target information was
extracted using the GEOquery package. Comment: To run the following code
chunk a considerable amount of RAM should be available.

library(GEOquery)

gse <- getGEO("GSE42861")

targets <- pData(phenoData(gse[[1]]))
path <- "path_to_idat_files"
targets$Basename <- file.path(path,
gsub("_Grn.*$", "", basename(targets$supplementary_file)))
rownames(targets) <- basename(targets$Basename)

Again we store the summarized data for later use and summarize the data in
batches of size 15.

summarize(targets, batchSize = 15, file="RA")

load("RA.RData")

visualize(RA)

Comment: visualize can only be called interactive from within a R session.

5

MethylAid: Visual and Interactive quality control of Illumina Human DNA Methylation array
data

6

Parallel summarization

MethylAid was specially designed for quality control of large set of DNA methy-
lation data e.g. EWAS studies. Summarization can be performed in batches
to overcome memory problems e.g. when too many idat files are read at once.
Just provide the option batchSize to the summarize function as we did in the
previous example. Too overcome long run-times summarization can be per-
formed in parallel as well using various computing resource facilitated by the
BiocParallel package.

The summarize accepts a bpparam argument e.g. MulticoreParam (Comment:
unfortunately this is not available on Windows). For example, perform summa-
rization on a multiple core machine with 8 cores requested is easy as this:

library(BiocParallel)

tcga <- summarize(targets, batchSize = 15, BPPARAM = MulticoreParam(workers = 8))

The BiocParallel also allows parallelization on a cluster of computers using
different job schedulers. For example, using the appropriate configuration file
a BatchJobsParam-object can be constructed and passed on to the summarize-
function.

library(BiocParallel)

conffile <- system.file("scripts/config.R", package="MethylAid")

BPPARAM <- BatchJobsParam(workers = 10,

progressbar = FALSE,

conffile = conffile)

summarize(targets, batchSize = 50, BPPARAM = BPPARAM)

The script folder of the package contains example files for parallel summarization
on a cluster computer using the Sun Grid Engine job scheduler. For more
information on how to setup a configuration file for other job schedulers see the
description of BatchJobs https://github.com/tudo-r/BatchJobs (BiocParallel
relies on the cran R package BatchJobs[5]). Probaly, you should at least set
your email address in scripts/summarize.sh and use the proper R executable
e.g change this in scripts/summarize.sh and scripts/sge.tmpl.

6

MethylAid: Visual and Interactive quality control of Illumina Human DNA Methylation array
data

7

Customize MethylAid

7.1 User-defined thresholds

MethylAid uses pre-defined thresholds in the filter control plots to determine
outlying samples. These thresholds are based on experience with several Methy-
lation Array data sets that were analysed in the Department of Molecular Epi-
demiology (Leiden University Medical Center), School of Biological Sciences
(University of Essex) and the Faculty of Medicine (University of Southhamp-
ton). The values of these thresholds are further supported by large reference
sets available from the MethylAidData-package. However, if one wished to use
customised thresholds, e.g. for hydroxymethylation data, these can be given as
arguments to the visualize-function.

visualize(exampleData,

thresholds = list(MU = 10.5, OP = 11.75,

BS = 12.75, HC = 13.25, DP = 0.95))

7.2 Generating your own reference dataset

The MethylAidData-package provides a reference dataset on 2800 samples and
a reference dataset on 2620 EPIC samples. A reference data set can be used to
compare with another data set. For example, call visualize with the argument
background as shown below.

library(MethylAid)

data(exampleData) ##500 samples

library(MethylAidData)

data(exampleDataLarge) ##2800 samples

outliers <- visualize(exampleData, background=exampleDataLarge)

head(outliers)

Every dataset that has been summarized by MethylAid can be used as a refer-
ence data set. Furthermore, different summarized data sets can be combined
to one bigger reference data set using the combine.

library(MethylAid)

data(exampleData)

exampleData

## summarizedData object with 500 samples.

## Containing: median Methylated and Unmethylation values,

##

detection P-values

7

MethylAid: Visual and Interactive quality control of Illumina Human DNA Methylation array
data

##

and all quality control probe intensities.

combine(exampleData, exampleData)

## combining summarizedData objects

## summarizedData object with 1000 samples.

## Containing: median Methylated and Unmethylation values,

##

##

detection P-values

and all quality control probe intensities.

8

Session info

Here is the output of sessionInfo on the system on which this document was
compiled:

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB,

LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, parallel,

stats, stats4, utils

• Other packages: Biobase 2.70.0, BiocGenerics 0.56.0, Biostrings 2.78.0,

GenomicRanges 1.62.0, IRanges 2.44.0,
IlluminaHumanMethylation450kanno.ilmn12.hg19 0.6.1,
IlluminaHumanMethylation450kmanifest 0.4.0, MatrixGenerics 1.22.0,
MethylAid 1.44.0, S4Vectors 0.48.0, Seqinfo 1.0.0,
SummarizedExperiment 1.40.0, XVector 0.50.0, bumphunter 1.52.0,
foreach 1.5.2, generics 0.1.4, iterators 1.0.14, knitr 1.50, locfit 1.5-9.12,
matrixStats 1.5.0, minfi 1.56.0, minfiData 0.55.0

8

MethylAid: Visual and Interactive quality control of Illumina Human DNA Methylation array
data

• Loaded via a namespace (and not attached): AnnotationDbi 1.72.0,

BiocIO 1.20.0, BiocManager 1.30.26, BiocParallel 1.44.0,
BiocStyle 2.38.0, DBI 1.2.3, DelayedArray 0.36.0,
DelayedMatrixStats 1.32.0, GEOquery 2.78.0,
GenomicAlignments 1.46.0, GenomicFeatures 1.62.0, HDF5Array 1.38.0,
KEGGREST 1.50.0, MASS 7.3-65, Matrix 1.7-4, R6 2.6.1,
RColorBrewer 1.1-3, RCurl 1.98-1.17, RSQLite 2.4.3, Rcpp 1.1.0,
Rhdf5lib 1.32.0, Rsamtools 2.26.0, S4Arrays 1.10.0, S7 0.2.0,
SparseArray 1.10.0, XML 3.99-0.19, abind 1.4-8, annotate 1.88.0,
askpass 1.2.1, base64 2.0.2, beanplot 1.3.1, bit 4.6.0, bit64 4.6.0-1,
bitops 1.0-9, blob 1.2.4, cachem 1.1.0, cigarillo 1.0.0, cli 3.6.5,
codetools 0.2-20, compiler 4.5.1, crayon 1.5.3, curl 7.0.0,
data.table 1.17.8, dichromat 2.0-0.1, digest 0.6.37, doRNG 1.8.6.2,
dplyr 1.1.4, evaluate 1.0.5, farver 2.1.2, fastmap 1.2.0, genefilter 1.92.0,
ggplot2 4.0.0, glue 1.8.0, grid 4.5.1, gridBase 0.4-7, gtable 0.3.6,
h5mread 1.2.0, hexbin 1.28.5, highr 0.11, hms 1.1.4, htmltools 0.5.8.1,
httpuv 1.6.16, httr 1.4.7, illuminaio 0.52.0, jsonlite 2.0.0, later 1.4.4,
lattice 0.22-7, lifecycle 1.0.4, limma 3.66.0, magrittr 2.0.4, mclust 6.1.1,
memoise 2.0.1, mime 0.13, multtest 2.66.0, nlme 3.1-168,
nor1mix 1.3-3, openssl 2.3.4, otel 0.2.0, pillar 1.11.1, pkgconfig 2.0.3,
plyr 1.8.9, png 0.1-8, preprocessCore 1.72.0, promises 1.4.0, purrr 1.1.0,
quadprog 1.5-8, readr 2.1.5, rentrez 1.2.4, reshape 0.8.10,
restfulr 0.0.16, rhdf5 2.54.0, rhdf5filters 1.22.0, rjson 0.2.23, rlang 1.1.6,
rmarkdown 2.30, rngtools 1.5.2, rtracklayer 1.70.0, scales 1.4.0,
scrime 1.3.5, shiny 1.11.1, siggenes 1.84.0, sparseMatrixStats 1.22.0,
splines 4.5.1, statmod 1.5.1, survival 3.8-3, tibble 3.3.0, tidyr 1.3.1,
tidyselect 1.2.1, tools 4.5.1, tzdb 0.5.0, vctrs 0.6.5, xfun 0.53,
xml2 1.4.1, xtable 1.8-4, yaml 2.3.10

References

[1] M. van Iterson, E. W. Tobi, R. C. Slieker, W. den Hollander, R. Luijk,

P. E. Slagboom, and B. T. Heijmans. MethylAid: visual and interactive
quality control of large Illumina 450k datasets. Bioinformatics,
30(23):3435–3437, 2014.

[2] R. Edgar, M. Domrachev, and A. E. Lash. Gene Expression Omnibus:
NCBI gene expression and hybridization array data repository. Nucleic
Acids Res., 30(1):207–210, Jan 2002.

[3] Y. Liu, M. J. Aryee, L. Padyukov, M. D. Fallin, E. Hesselberg,
A. Runarsson, L. Reinius, N. Acevedo, M. Taub, M. Ronninger,
K. Shchetynsky, A. Scheynius, J. Kere, L. Alfredsson, L. Klareskog, T. J.

9

MethylAid: Visual and Interactive quality control of Illumina Human DNA Methylation array
data

Ekstrom, and A. P. Feinberg. Epigenome-wide association data implicate
DNA methylation as an intermediary of genetic risk in rheumatoid
arthritis. Nat. Biotechnol., 31(2):142–147, Feb 2013.

[4] M. J. Aryee, A. E. Jaffe, H. Corrada-Bravo, C. Ladd-Acosta, A. P.
Feinberg, K. D. Hansen, and R. A. Irizarry. Minfi: a flexible and
comprehensive Bioconductor package for the analysis of Infinium DNA
methylation microarrays. Bioinformatics, 2014.

[5] Bernd Bischl, Michel Lang, Olaf Mersmann, Joerg Rahnenfuehrer, and

Claus Weihs. Computing on high performance clusters with r: Packages
batchjobs and batchexperiments. Technical Report 1, TU Dortmund,
2011. URL: http:
//sfb876.tu-dortmund.de/PublicPublicationFiles/bischl_etal_2012a.pdf.

10


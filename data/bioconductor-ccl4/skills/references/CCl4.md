From the Genepix data files to RGList to NChannelSet

Audrey Kauffmann, Wolfgang Huber

October 30, 2025

Load the required packages

> library("Biobase")
> library("limma")
> library("CCl4")

Read the data and convert them into an RGList

The Genepix (.gpr) data files are in the extdata directory of the CCl4 package.
If you have the
package installed, we can locate them on your filesystem with the function system.file. If the files are
somewhere else, please adapt the below assignment to datapath.

> datapath = system.file("extdata", package="CCl4")

> p = read.AnnotatedDataFrame("samplesInfo.txt", path=datapath)
> CCl4_RGList = read.maimages(files=sampleNames(p),
+
+
+
+

path = datapath,
source = "genepix",
columns = list(R = "F635 Median", Rb = "B635 Median",

G = "F532 Median", Gb = "B532 Median"))

If this code is run in the inst/doc directory of the CCl4 (source) package, the output data files will be
written directly into the data directory of the package. Otherwise, just write into a temporary directory.

> outdir = file.path("..", "..", "data")
> if(!isTRUE(file.info(outdir)$isdir))
+
> save(CCl4_RGList, file = file.path(outdir, "CCl4_RGList.RData"))

outdir = tempdir()

The function read.maimages from the limma package reads the .gpr files andbuilds an RGList

object from it.

The output is written to

> outdir

[1] "/tmp/RtmpthMhqD"

Build an NChannelSet from the RGList

Once the RGList object has been created, we can build an NChannelSet.

1

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

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
[1] stats

graphics grDevices utils

datasets

methods

base

other attached packages:
[1] CCl4_1.48.0
[4] BiocGenerics_0.56.0 generics_0.1.4

limma_3.66.0

Biobase_2.70.0

loaded via a namespace (and not attached):
[1] compiler_4.5.1 tools_4.5.1

statmod_1.5.1

Table 1: The output of sessionInfo on the build system after running this vignette.

> featureData = new("AnnotatedDataFrame", data = CCl4_RGList$genes)
> assayData = with(CCl4_RGList, assayDataNew(R=R, G=G, Rb=Rb, Gb=Gb))
> varMetadata(p)$channel=factor(c("G", "R", "G", "R"),
+
> CCl4 <- new("NChannelSet",
+
+
+
> save(CCl4, file = file.path(outdir, "CCl4.RData"))

assayData = assayData,
featureData = featureData,
phenoData = p)

levels=c(ls(assayData), "_ALL_"))

2


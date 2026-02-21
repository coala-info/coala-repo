RTCAtransformation: Discussion of transformation methods
of RTCA data

Jitao David Zhang

October 30, 2025

Abstract

The xCELLigence™System provides a dimentionless parameter Cell Index (CI) to reflect
the biological status of the monitored cells. In this vignette we discuss the concept of the cell
index briefly, and introduces several transformation approaches to allow statistical inferences
of the RTCA assays.

1 Introduction

To demonstrate different types of transformation algorithms implemented in the RTCA package,
we first load required Bioconductor packages.

> library(xtable)
> library(RTCA)

And we load a dataset (with its annotation) provided with the package as example:

system.file("extdata/testOutput.csv", package="RTCA")

> ofile <-
> pfile <- system.file("extdata/testOutputPhenoData.csv", package="RTCA")
> pData <- read.csv(pfile, sep="\t", row.names="Well")
> metaData <- data.frame(labelDescription=c(
+
+
+
+
+
+
> phData <- new("AnnotatedDataFrame", data=pData, varMetadata=metaData)
> x <- parseRTCA(ofile, phenoData=phData)

"Rack number",
"siRNA catalogue number",
"siRNA gene symbol",
"siRNA EntrezGene ID",
"siRNA targeting accession"
))

The object x is an instance of the RTCA class, which extends the ExpressionSet class structure

in the Biobase package. It contains the raw data of 96 samples in 242 time points.

1

2 Manipulation

2.1 Smooth Transformation

Smooth Transformation smoothes the RTCA curves by fitting a cubic smoothing spline. It provides
more ’flat’ data compared to the raw values due to the smoothing. While it is useful for visualiza-
tion, the smooth transformation must be used with care when modelling or statistical procedures
are performed later.

The transformation is performed with the following syntax:

> xSmooth <- smoothTransform(x)

2.2

Interpolation Transformation

The RTCA device can record the cell index at irregular time intervals. For example, two sampling
time points per hour at the first 48 hour and one time point per hour at the later 48 hour. Some
algorithms and time-series model, however, requires data points distributed with regular time in-
tervals. The interpolation transformation, as its name suggests, interpolates the RTCA-readout to
regular intervals specified by the user. Several methods could be chosen for the interpolation, with
the linear interpolation as the default method.

Similarly as the smooth transformation, the interpolation can be called as easily as the following

example shows:

> xInter <- interpolationTransform(x)

3 Methods

3.1 Derivative Transformation

The derivative transformation calculates the growth rate of the RTCA-readouts by its first deriva-
tive against time. As an alternative to the ratio normalization proposed by the device provider, the
derivative transformation is independent of the choice of the normalising time point, which has to
be given manually by the user and thereby introduces subjectivity in the analysis.

An example of the derivative transformation:

> xDeriv <- derivativeTransform(x)

3.2 Relative Growth Rate Transformation

The relative growth rate transformation is a derivative from the simple derivative transformation by
dividing the first derivative with the raw value at that time point. It is analogue to the relative growth
rate known in the population genetics where the mathematic model asummes that the growth rate
is proportional to the population size.

2

This feature is by now experimental and we refer interested users to the manual page of the

funtion:

> xRgr <- rgrTransform(x)

4 Session Info

The script runs within the following session:

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

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: Biobase 2.70.0, BiocGenerics 0.56.0, RColorBrewer 1.1-3, RTCA 1.62.0,

generics 0.1.4, gtools 3.9.5, xtable 1.8-4

• Loaded via a namespace (and not attached): compiler 4.5.1, tools 4.5.1

3


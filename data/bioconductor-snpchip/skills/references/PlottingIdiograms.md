Plotting Idiograms

Rob Scharpf

October 30, 2017

This package is no longer actively developed and maintained largely for historical reasons.

1 Simple Usage

> library(SNPchip)

Plot an idiogram for chromosome 1 with labels for the bands on the x-axis.

> plotIdiogram("1", build="hg19", cex=0.8)

Suppressing labels:

> plotIdiogram("1", build="hg19", cex=0.8, label.cytoband=FALSE)

With user-deﬁnded y-axis limits and y-coordinates for the idiogram:

> plotIdiogram("1", build="hg19", cex=0.8, label.cytoband=FALSE, ylim=c(0,1), cytoband.ycoords=c(0.1, 0.3))

Plot an idiogram for all chromosomes.

> library(oligoClasses)
> sl <- getSequenceLengths("hg19")[c(paste("chr", 1:22, sep=""), "chrX", "chrY")]
> ybottom <- seq(0, 1, length.out=length(sl)) - 0.01
> ytop <- seq(0, 1, length.out=length(sl)) + 0.01
> for(i in seq_along(sl)){
+
+
+

chr <- names(sl)[i]
if(i == 1){

plotIdiogram("1", build="hg19", cex=0.8, label.cytoband=FALSE, ylim=c(-0.05,1.05), cytoband.ycoords=c(ybottom[1], ytop[1]),

1

p36.33p36.32p36.31p36.23p36.22p36.21p36.13p36.12p36.11p35.3p35.2p35.1p34.3p34.2p34.1p33p32.3p32.2p32.1p31.3p31.2p31.1p22.3p22.2p22.1p21.3p21.2p21.1p13.3p13.2p13.1p12p11.2p11.1q11q12q21.1q21.2q21.3q22q23.1q23.2q23.3q24.1q24.2q24.3q25.1q25.2q25.3q31.1q31.2q31.3q32.1q32.2q32.3q41q42.11q42.12q42.13q42.2q42.3q43q44plotIdiogram(names(sl)[i], build="hg19", cex=0.8, label.cytoband=FALSE, cytoband.ycoords=c(ybottom[i], ytop[i]), new=FALSE)

xlim=c(0, max(sl)))

}
if(i > 1){

+
+
+
+
+
+ }
> axis(1, at=pretty(c(0, max(sl)), n=10), labels=pretty(c(0, max(sl)), n=10)/1e6, cex.axis=0.8)
> mtext("position (Mb)", 1, line=2)
> par(las=1)
> axis(2, at=ybottom+0.01, names(sl), cex.axis=0.6)

}

2 Session Information

The version number of R and packages loaded for generating the vignette were:

(cid:136) R version 3.4.2 (2017-09-28), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.3 LTS

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so

(cid:136) LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, methods, stats, utils

(cid:136) Other packages: SNPchip 2.24.0, oligoClasses 1.40.0

(cid:136) Loaded via a namespace (and not attached): Biobase 2.38.0, BiocGenerics 0.24.0,

BiocInstaller 1.28.0, Biostrings 2.46.0, DBI 0.7, DelayedArray 0.4.0, GenomeInfoDb 1.14.0,
GenomeInfoDbData 0.99.1, GenomicRanges 1.30.0, IRanges 2.12.0, Matrix 1.2-11, RCurl 1.95-4.8,
S4Vectors 0.16.0, SummarizedExperiment 1.8.0, XVector 0.18.0, aﬀyio 1.48.0, bit 1.1-12, bitops 1.0-6,

2

020406080100120140160180200220240position (Mb)codetools 0.2-15, compiler 3.4.2, ﬀ 2.2-13, foreach 1.4.3, grid 3.4.2, iterators 1.0.8, lattice 0.20-35,
matrixStats 0.52.2, parallel 3.4.2, stats4 3.4.2, tools 3.4.2, zlibbioc 1.24.0

3


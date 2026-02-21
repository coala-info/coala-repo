Genotyping with the crlmm Package

Benilton Carvalho

March, 2009

1 Quick intro to crlmm

The crlmm package contains a new implementation for the CRLMM algorithm
(Carvalho et. al. 2007). Our focus is on efficient genotyping of SNP 5.0 and 6.0
Affymetrix arrays, although extensions of the method are under development
for similar platforms.

This implementation, compared to the previous one (in oligo), offers im-
proved confidence scores, quality scores for SNP’s and batches, higher accuracy
on different datasets and better performance.

Additionally, this package does not use the pd.genomewidesnp packages cre-
ated via pdInfoBuilder for oligo. Instead, it uses different annotation packages
(genomewidesnp.5 and genomewidesnp.6), which use simple R objects to store
only the information needed for genotyping. This allowed us to improve the
speed of the method, as SQL queries are no longer performed here.

It is also our priority to make the package simple to use. Below we demon-
strate how to get genotype calls with the ’new’ CRLMM. We use 3 samples on
SNP 5.0 made available via the hapmapsnp5 package.

R> require(oligoClasses)
R> library(crlmm)
R> library(hapmapsnp6)
R> path <- system.file("celFiles", package="hapmapsnp6")
R> celFiles <- list.celfiles(path, full.names=TRUE)
R> system.time(crlmmResult <- crlmm(celFiles, verbose=FALSE))

user
92.499

system elapsed
94.419

1.907

The crlmmResult is a SnpSet (see Biobase) object.
• calls: genotype calls (1 - AA; 2 - AB; 3 - BB);

• confs: confidence scores, which can be translated to probabilities by us-

ing:

1 − 2−(confs/1000),
although we prefer this representation as it saves a significant amount of
memory;

1

• SNPQC: SNP quality score;

• SNR: Signal-to-noise ratio.

R> calls(crlmmResult)[1:10,]

SNP_A-2131660
SNP_A-1967418
SNP_A-1969580
SNP_A-4263484
SNP_A-1978185
SNP_A-4264431
SNP_A-1980898
SNP_A-1983139
SNP_A-4265735
SNP_A-1995832

SNP_A-2131660
SNP_A-1967418
SNP_A-1969580
SNP_A-4263484
SNP_A-1978185
SNP_A-4264431
SNP_A-1980898
SNP_A-1983139
SNP_A-4265735
SNP_A-1995832

NA06985_GW6_C.CEL NA06991_GW6_C.CEL
2
3
3
1
1
1
3
1
2
3

2
3
3
2
1
1
3
1
2
2
NA06993_GW6_C.CEL
3
3
3
1
1
1
3
1
1
3

R> confs(crlmmResult)[1:10,]

SNP_A-2131660
SNP_A-1967418
SNP_A-1969580
SNP_A-4263484
SNP_A-1978185
SNP_A-4264431
SNP_A-1980898
SNP_A-1983139
SNP_A-4265735
SNP_A-1995832

SNP_A-2131660
SNP_A-1967418
SNP_A-1969580
SNP_A-4263484

NA06985_GW6_C.CEL NA06991_GW6_C.CEL
0.9999996
0.9999997
0.9995139
1.0000000
1.0000000
1.0000000
0.9995206
0.9999878
0.9999863
1.0000000

0.9999963
0.9999969
0.9995187
0.9999999
1.0000000
1.0000000
0.9995192
1.0000000
0.9999827
0.9999762
NA06993_GW6_C.CEL
0.9999998
0.9999969
0.9995124
1.0000000

2

SNP_A-1978185
SNP_A-4264431
SNP_A-1980898
SNP_A-1983139
SNP_A-4265735
SNP_A-1995832

1.0000000
1.0000000
0.9995134
1.0000000
0.9999998
0.9999999

R> crlmmResult[["SNR"]]

[1] 8.481305 8.446096 7.379559

2 Details

This document was written using:

R> sessionInfo()

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
[6] methods

graphics
base

grDevices utils

datasets

other attached packages:
[1] genomewidesnp6Crlmm_1.0.7 hapmapsnp6_1.51.0
[3] crlmm_1.68.0
[5] oligoClasses_1.72.0

preprocessCore_1.72.0

loaded via a namespace (and not attached):

3

[1] Matrix_1.7-4
[3] limma_3.66.0
[5] BiocManager_1.30.26
[7] Rcpp_1.1.0
[9] ellipse_0.5.0

[11] GenomicRanges_1.62.0
[13] parallel_4.5.1
[15] splines_4.5.1
[17] Seqinfo_1.0.0
[19] lattice_0.22-7
[21] S4Arrays_1.10.0
[23] RcppEigen_0.3.4.0.2
[25] BiocGenerics_0.56.0
[27] DelayedArray_0.36.0
[29] openssl_2.3.4
[31] affyio_1.80.0
[33] base64_2.0.2
[35] foreach_1.5.2
[37] mvtnorm_1.3-3
[39] beanplot_1.3.1
[41] codetools_0.2-20
[43] stats4_4.5.1
[45] tools_4.5.1

bit_4.6.0
compiler_4.5.1
crayon_1.5.3
SummarizedExperiment_1.40.0
Biobase_2.70.0
Biostrings_2.78.0
VGAM_1.1-13
IRanges_2.44.0
statmod_1.5.1
XVector_0.50.0
generics_0.1.4
ff_4.5.2
iterators_1.0.14
MatrixGenerics_1.22.0
DBI_1.2.3
illuminaio_0.52.0
SparseArray_1.10.0
grid_4.5.1
askpass_1.2.1
S4Vectors_0.48.0
abind_1.4-8
matrixStats_1.5.0

4


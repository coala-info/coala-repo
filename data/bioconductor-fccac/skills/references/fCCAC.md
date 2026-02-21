fCCAC: functional Canonical Correlation Anal-
ysis to evaluate Covariance between nucleic
acid sequencing datasets

Pedro Madrigal

Last Modified: August, 2021. Compiled: October 29, 2025

Wellcome Trust Sanger Institute, Cellular Genetics Programme, Hinxton, Cambridge, UK
University of Cambridge, WT MRC Stem Cell Institute, Cambridge, UK

Contents

1

2

3

4

Introduction .

Example .

.

.

References .

Details .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

2

3

3

1

Introduction

Computational evaluation of variability across Next-generation sequencing (NGS) datasets
It allows both to evaluate the reproducibility across
is a crucial step in genomic science.
biological or technical replicates, and to compare different datasets to identify their potential
correlations.
fCCAC is an application of functional canonical correlation analysis to assess
covariance of NGS datasets such as chromatin immunoprecipitation followed by deep se-
quencing (ChIP-seq), ChIP-exo, RNA-seq, ATAC-seq, etc.

Basic processing of NGS data can be performed using Bioconductor packages such as CSAR,
csaw , ChIPseeker , ChIPQC , and others. Basic and advanced ChIP-seq workflows are available
at the Bioconductor website: https://www.bioconductor.org/help/workflows/sequencing/
and https://www.bioconductor.org/help/workflows/chipseqDB/. Once regions of interest,
such as peaks, exons, UTRs, etc. are obtained, bigwig data of the mapped reads are neces-
sary for using fCCAC , and can be obtained using rtracklayer .

Detailed information about the statistical methodology can be found in Madrigal (2016).

fCCAC: functional Canonical Correlation Analysis to evaluate Covariance between nucleic acid sequencing
datasets

2

Example

Data used in the example correspond to H3K4me3 triplicates (wild-type H9-hESCs) down-
loaded from ArrayExpress (E-ERAD-191) and processed as in (Bertero et al., 2015). Aggre-
gate sets of reproducible peaks from Bertero et al. were considered as genomic regions of
interest in the analysis. Region 40000000-48129895 in chromosome 21 was selected for the
illustrative example shown in this vignette.

R> options(width=50);

R> if (.Platform$OS.type == "windows") { print("...rtracklayer is unable to read bigWig format files in Windows...") }

R> if (.Platform$OS.type == "unix") {

## hg19. chr21:40000000-48129895 H3K4me3 data from Bertero et al. (2015)

owd <- setwd(tempdir());

library(fCCAC)

bigwig1 <- "chr21_H3K4me3_1.bw"
bigwig2 <- "chr21_H3K4me3_2.bw"
bigwig3 <- "chr21_H3K4me3_3.bw"
peakFile <- "chr21_merged_ACT_K4.bed"
labels <- c( "H3K4me3", "H3K4me3","H3K4me3" )

r1 <- system.file("extdata", bigwig1,

package="fCCAC",mustWork = TRUE)

r2 <- system.file("extdata", bigwig2,

package="fCCAC",mustWork = TRUE)

r3 <- system.file("extdata", bigwig3,

package="fCCAC",mustWork = TRUE)

r4 <- system.file("extdata", peakFile, package="fCCAC",mustWork = TRUE)

ti <- "H3K4me3 peaks (chr21)"

fc <- fccac(bar=NULL, main=ti, peaks=r4, bigwigs=c(r1,r2,r3), labels=labels, splines=15, nbins=100, ncan=15)

head(fc)

setwd(owd)

}

[1] "Reading peaks..."

[1] "Starting fCCAC..."

[1] "Reading bigWig file...1/3"

[1] "Reading bigWig file...2/3"

[1] "Reading bigWig file...3/3"

[1] "Performing fCCA in pair...1/3"
[1] "H3K4me3_Rep1...vs...H3K4me3_Rep2"
[1] "Performing fCCA in pair...2/3"
[1] "H3K4me3_Rep1...vs...H3K4me3_Rep3"
[1] "Performing fCCA in pair...3/3"
[1] "H3K4me3_Rep2...vs...H3K4me3_Rep3"

As we can observe, the triplicates present very high values both in first squared canonical
correlation (>0.99) and in their F values, which denotes high reproducibility of the experiment.

Finally, if all pairwise comparisons have been computed (’tf=c()’ by default), we can plot a
heatmap of F values:

R> options(width=50)

R> if (.Platform$OS.type == "windows") { print("...rtracklayer is unable to read bigWig format files in Windows...") }

2

fCCAC: functional Canonical Correlation Analysis to evaluate Covariance between nucleic acid sequencing
datasets

R> if (.Platform$OS.type == "unix" ){ heatmapfCCAC(fc) }

R>

Important notes:

• F is an overall measure of shared covariance.

It is expected that good replicates will

have F values close to 100 (such as in the example above).

• Because heavy smoothing is suggested for functional CCA (Ramsay and Silverman
(2005); Ramsay et al.
(2009)), a low number of splines (parameter splines) when
compared to the total length of the genomic regions is recommended. The parameter
’nbins’ can be low for narrow peaks (e.g., 50 for TFs and narrow chromatin marks) and
increased for broad domain chromatin marks. The number of canonical correlations to
compute (ncan) is limited by the number of splines used and the number of genomics
regions to analyse. More information about data approximations used can be found in
the Supplementary Information in Madrigal (2016).

3

References

• Madrigal P (2017) fCCAC: functional canonical correlation analysis to evaluate co-
variance between nucleic acid sequencing datasets. Bioinformatics, 33: 746-748.
http://doi.org/10.1093/bioinformatics/btw724.

• Bailey TL, et al. (2013) Practical Guidelines for the Comprehensive Analysis of ChIP-

seq Data. PLoS Comput Biol 9: e1003326.

• Bertero A, et al. (2015) Activin/nodal signaling and NANOG orchestrate human em-
bryonic stem cell fate decisions by controlling the H3K4me3 chromatin mark. Genes
Dev. 29: 702-17.

• Ramsay JO, Silverman BW (2005) Functional Data Analysis. Springer Verlag, New

York.

• Ramsay JO, et al. (2009) Functional Data Analysis with R and MATLAB. SpringerVer-

lag, New York.

4

Details

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
[2] LC_NUMERIC=C

3

fCCAC: functional Canonical Correlation Analysis to evaluate Covariance between nucleic acid sequencing
datasets

[3] LC_TIME=en_GB
[4] LC_COLLATE=C
[5] LC_MONETARY=en_US.UTF-8
[6] LC_MESSAGES=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[8] LC_NAME=C
[9] LC_ADDRESS=C
[10] LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8
[12] LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:

[1] grid

stats4

stats

graphics

[5] grDevices utils

datasets

methods

[9] base

other attached packages:
[1] fCCAC_1.36.0
[3] Seqinfo_1.0.0
[5] S4Vectors_0.48.0
[7] generics_0.1.4

GenomicRanges_1.62.0
IRanges_2.44.0
BiocGenerics_0.56.0

loaded via a namespace (and not attached):

[1] bitops_1.0-9
[2] rlang_1.1.6
[3] magrittr_2.0.4
[4] clue_0.3-66
[5] GetoptLong_1.0.5
[6] gridBase_0.4-7
[7] matrixStats_1.5.0
[8] compiler_4.5.1
[9] png_0.1-8
[10] vctrs_0.6.5
[11] reshape2_1.4.4
[12] stringr_1.5.2
[13] pkgconfig_2.0.3
[14] shape_1.4.6.1
[15] crayon_1.5.3
[16] fastmap_1.2.0
[17] magick_2.9.0
[18] XVector_0.50.0
[19] labeling_0.4.3
[20] Rsamtools_2.26.0
[21] deSolve_1.40
[22] rmarkdown_2.30
[23] tzdb_0.5.0
[24] pracma_2.4.6
[25] bit_4.6.0
[26] xfun_0.53
[27] cigarillo_1.0.0
[28] DelayedArray_0.36.0
[29] BiocParallel_1.44.0

4

fCCAC: functional Canonical Correlation Analysis to evaluate Covariance between nucleic acid sequencing
datasets

[30] parallel_4.5.1
[31] cluster_2.1.8.1
[32] R6_2.6.1
[33] stringi_1.8.7
[34] RColorBrewer_1.1-3
[35] rtracklayer_1.70.0
[36] rainbow_3.8
[37] Rcpp_1.1.0
[38] SummarizedExperiment_1.40.0
[39] iterators_1.0.14
[40] knitr_1.50
[41] hdrcde_3.4
[42] readr_2.1.5
[43] Matrix_1.7-4
[44] splines_4.5.1
[45] tidyselect_1.2.1
[46] dichromat_2.0-0.1
[47] abind_1.4-8
[48] yaml_2.3.10
[49] seqPattern_1.42.0
[50] doParallel_1.0.17
[51] codetools_0.2-20
[52] curl_7.0.0
[53] lattice_0.22-7
[54] tibble_3.3.0
[55] plyr_1.8.9
[56] withr_3.0.2
[57] Biobase_2.70.0
[58] ks_1.15.1
[59] S7_0.2.0
[60] evaluate_1.0.5
[61] archive_1.1.12
[62] circlize_0.4.16
[63] mclust_6.1.1
[64] Biostrings_2.78.0
[65] pillar_1.11.1
[66] BiocManager_1.30.26
[67] fda_6.3.0
[68] MatrixGenerics_1.22.0
[69] KernSmooth_2.23-26
[70] foreach_1.5.2
[71] pcaPP_2.0-5
[72] vroom_1.6.6
[73] RCurl_1.98-1.17
[74] hms_1.1.4
[75] ggplot2_4.0.0
[76] scales_1.4.0
[77] BiocStyle_2.38.0
[78] glue_1.8.0
[79] tools_4.5.1
[80] BiocIO_1.20.0
[81] fds_1.8
[82] data.table_1.17.8
[83] BSgenome_1.78.0
[84] GenomicAlignments_1.46.0

5

fCCAC: functional Canonical Correlation Analysis to evaluate Covariance between nucleic acid sequencing
datasets

[85] mvtnorm_1.3-3
[86] XML_3.99-0.19
[87] Cairo_1.7-0
[88] impute_1.84.0
[89] plotrix_3.8-4
[90] colorspace_2.1-2
[91] restfulr_0.0.16
[92] cli_3.6.5
[93] S4Arrays_1.10.0
[94] ComplexHeatmap_2.26.0
[95] genomation_1.42.0
[96] dplyr_1.1.4
[97] gtable_0.3.6
[98] digest_0.6.37
[99] SparseArray_1.10.0
[100] rjson_0.2.23
[101] farver_2.1.2
[102] htmltools_0.5.8.1
[103] lifecycle_1.0.4
[104] httr_1.4.7
[105] GlobalOptions_0.1.2
[106] bit64_4.6.0-1
[107] MASS_7.3-65

6


CexoR : An R package to uncover high-
resolution protein-DNA interactions in ChIP-
exo replicates

Pedro Madrigal

Last Modified: October, 2021. Compiled: October 29, 2025

EMBL-EBI, UK

Contents

1

2

3

4

5

6

7

Citation.

.

.

.

Introduction .

.

.

Methodology .

Example .

.

.

References .

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

1

2

2

5

5

5

1

2

Citation

Madrigal P (2015) CexoR: an R/Bioconductor package to uncover high-resolution protein-
DNA interactions in ChIP-exo replicates. EMBnet.journal 21, e837. http://dx.doi.org/10.14806/ej.21.0.837.

Introduction

For its unprecedented level of resolution, chromatin immunoprecipitation combined with
lambda exonuclease digestion followed by sequencing (ChIP-exo) is a potential candidate
to replace ChIP-seq as the standard approach for high-confidence mapping of protein-DNA
interactions. Numerous algorithms have been developed for peak calling in ChIP-seq data.
However, adjusting the statistical models to ChIP-exo making use of its strand-specificity can
improve the identification of protein-DNA binding sites. The midpoint between the strand-
specific paired peaks formed at its forward and reverse strands is delimited by the exonuclease
stop sites, within the protein binding event is located (Rhee and Pugh, 2011).

CexoR : An R package to uncover high-resolution protein-DNA interactions in ChIP-exo replicates

3

Methodology

Lambda exonuclease stop site (5’ end of the reads) counts are calculated separately for both
DNA strands from the alignment files in BAM format using the Bioconductor Rsamtools.
Counts are then normalized using linear scaling to the same sample depth of the smaller
dataset. Using the Skellam distribution (Skellam, 1946), CexoR models at each nucleotide
position the discrete signed difference of two Poisson counts at forward and reverse strands,
respectively. Then, detecting nearby located significant count differences of opposed sign
(peak-pairs) at both strands allows CexoR to delimit the flanks of the protein binding event
location at base pair resolution. A one-sided p-value is obtained for each peak using the
complementary cumulative Skellam distribution function, and a final p-value for the peak-
pair (default cut-off 1e − 12) is reported as the sum of the two p-values. To account for the
reproducibility of replicated peak-pairs, which central point must be located at a user-defined
maximum distance, p-values are submitted for irreproducible discovery rate estimation (Li et
al., 2011). Stouffer’s and Fisher’s combined p-values are given for the final peak-pair calls.
Finally, BED files containing reproducible binding event locations formed within peak-pairs
are reported, as well as their midpoints.

More information can be found in Madrigal (2015).

4

Example

We downloaded the 3 replicates of human CTCF ChIP-exo data from GEO (SRA044886)
(Rhee and Pugh, 2011), and aligned the reads to the human reference genome (hg19) using
Bowtie 1.0.0. Reads not mapping uniquely were discarded. We can search reproducible
binding events between peak-pairs in the first million bp of Chr2 in the 3 biological replicates
by:

R> options(width=60)

R> ## hg19. chr2:1-1,000,000

R>

R> owd <- setwd(tempdir())

R> library(CexoR)
R> rep1 <- "CTCF_rep1_chr2_1-1e6.bam"
R> rep2 <- "CTCF_rep2_chr2_1-1e6.bam"
R> rep3 <- "CTCF_rep3_chr2_1-1e6.bam"
R> r1 <- system.file("extdata", rep1, package="CexoR",mustWork = TRUE)

R> r2 <- system.file("extdata", rep2, package="CexoR",mustWork = TRUE)

R> r3 <- system.file("extdata", rep3, package="CexoR",mustWork = TRUE)
R> peak_pairs <- cexor(bam=c(r1,r2,r3), chrN="chr2", chrL=1e6, idr=0.01, N=3e4, p=1e-12)
R> peak_pairs$bindingEvents

GRanges object with 13 ranges and 6 metadata columns:

seqnames

ranges strand |

IDR

<Rle>

<IRanges>

<Rle> | <numeric>

[1]

[2]

[3]

[4]

[5]

...

[9]

chr2

chr2

11501-11701

18785-18886

chr2 142184-142371

chr2 172170-172354

chr2 332699-332870

...

...

chr2 662610-662783

[10]

chr2 667465-667634

* |
* |
* |
* |
* |
... .
* |
* |

0

0

0

0

0

...

0

0

2

CexoR : An R package to uncover high-resolution protein-DNA interactions in ChIP-exo replicates

[11]

[12]

[13]

[1]

[2]

[3]

[4]

[5]

...

[9]

[10]

[11]

[12]

[13]

[1]

[2]

[3]

[4]

[5]

...

[9]

[10]

[11]

[12]

[13]

chr2 714362-714545

chr2 715918-716096

chr2 850211-850402

* |
* |
* |

0

0

0

rep1.neg.log10pvalue rep2.neg.log10pvalue

<numeric>

<numeric>

30.4163

17.1723

14.0090

17.1729

13.7083

...

30.4174

30.4163

27.0319

17.1725

30.1158

23.8800

23.6215

14.1269

17.3140

20.3044

...

34.1026

44.8251

20.6463

30.6523

23.9693

rep3.neg.log10pvalue Stouffer.pvalue Fisher.pvalue

<numeric>

<numeric>

<numeric>

23.5194

23.5195

20.0154

23.5195

13.9014

...

26.8376

27.0159

26.6166

23.6777

13.9016

0

0

0

0

0

0

0

0

0

0

...

...

0

0

0

0

0

0

0

0

0

0

-------

seqinfo: 1 sequence from an unspecified genome

R> peak_pairs$bindingCentres

GRanges object with 13 ranges and 6 metadata columns:

seqnames

ranges strand |

IDR

<Rle>

<IRanges>

<Rle> | <numeric>

[1]

[2]

[3]

[4]

[5]

...

[9]

[10]

[11]

[12]

[13]

[1]

[2]

[3]

[4]

[5]

...

chr2

chr2

11601-11602

18836-18837

chr2 142278-142279

chr2 172262-172263

chr2 332784-332785

...

...

chr2 662696-662697

chr2 667550-667551

chr2 714454-714455

chr2 716007-716008

chr2 850306-850307

* |
* |
* |
* |
* |
... .
* |
* |
* |
* |
* |

0

0

0

0

0

...

0

0

0

0

0

rep1.neg.log10pvalue rep2.neg.log10pvalue

<numeric>

<numeric>

30.4163

17.1723

14.0090

17.1729

13.7083

...

23.8800

23.6215

14.1269

17.3140

20.3044

...

3

CexoR : An R package to uncover high-resolution protein-DNA interactions in ChIP-exo replicates

[9]

[10]

[11]

[12]

[13]

[1]

[2]

[3]

[4]

[5]

...

[9]

[10]

[11]

[12]

[13]

30.4174

30.4163

27.0319

17.1725

30.1158

34.1026

44.8251

20.6463

30.6523

23.9693

rep3.neg.log10pvalue Stouffer.pvalue Fisher.pvalue

<numeric>

<numeric>

<numeric>

23.5194

23.5195

20.0154

23.5195

13.9014

...

26.8376

27.0159

26.6166

23.6777

13.9016

0

0

0

0

0

0

0

0

0

0

...

...

0

0

0

0

0

0

0

0

0

0

-------

seqinfo: 1 sequence from an unspecified genome

R> setwd(owd)

R>

13 reproducible peak-pair events are reported for the established thresholds (p-value ≤ 1e−12,
IDR ≤ 0.01). We can now plot the mean profile of lambda exonuclease stop sites and reads,
500 bp around the central position of reproducible peak-pair locations, by running the func-
tion "plotcexor":

R> options(width=60)
R> plotcexor(bam=c(r1,r2,r3), peaks=peak_pairs, EXT=500)

Important notes:

• For the correct estimation of the IDR (Li et al., 2011) peak-pair calling should be
relaxed (e.g., p-value=1e-3, or smaller depending on the sequencing depth), enabling
the noise component be present in the data and therefore allowing the peak-pairs to
be separated into a reproducible and an irreproducible groups. In the example shown
above, as the dataset is very small and peaks are highly reproducible, IDR in the
overlapped peak-pairs across the 3 replicates is zero.

• IDR calculation could produce varying results depending on the choice of initial esti-
mates for four parameters needed by the algorithm (mu, sigma, rho, prop). Li et al.
(2011) recommend trying several choices, so that the parameter estimation does not
get trapped in a local maximum.

• For more information about using IDR in high-throughput sequencing datasets see Land
et al. (2012) and Bailey et al. (2013), or the mathematical description in Li et al.
(2011).

4

CexoR : An R package to uncover high-resolution protein-DNA interactions in ChIP-exo replicates

5

References

• Madrigal P (2015) CexoR: an R/Bioconductor package to uncover high-resolution

protein-DNA interactions in ChIP-exo replicates. EMBnet.journal 21: e837.

• Bailey TL, et al. (2013). Practical Guidelines for the Comprehensive Analysis of ChIP-

seq Data. PLoS Comput Biol 9: e1003326.

• Landt SG, et al.

(2012). ChIP-seq guidelines and practices of the ENCODE and

modENCODE consortia. Genome Res 22: 1813-1831.

• Skellam JG (1946) The frequency distribution of the difference between two Poisson

variates belonging to different populations. J R Stat Soc Ser A 109: 296.

• Li Q, Brown J, Huang H, Bickel P (2011) Measuring reproducibility of high-throughput

experiments. Ann Appl Stat 5: 1752-1779.

• Rhee HS, Pugh BF (2011) Comprehensive genome-wide protein-DNA interactions de-

tected at single-nucleotide resolution. Cell 147: 1408-1419.

References

The author wishes to acknowledge Christoph Sebastian Borlin, Md. Abul Hassan Samee,
Vivek Rexwal and Sudhir Jadhao for their feedback.

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

6

7

locale:
[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:

[1] stats4

stats

graphics

grDevices utils

[6] datasets

methods

base

5

CexoR : An R package to uncover high-resolution protein-DNA interactions in ChIP-exo replicates

other attached packages:
[1] CexoR_1.48.0
[3] S4Vectors_0.48.0
[5] generics_0.1.4

IRanges_2.44.0
BiocGenerics_0.56.0

loaded via a namespace (and not attached):
[1] SummarizedExperiment_1.40.0 impute_1.84.0
rjson_0.2.23
[3] gtable_0.3.6
ggplot2_4.0.0
[5] xfun_0.53
lattice_0.22-7
[7] Biobase_2.70.0
tzdb_0.5.0
[9] seqPattern_1.42.0
tools_4.5.1
[11] vctrs_0.6.5
curl_7.0.0
[13] bitops_1.0-9
tibble_3.3.0
[15] parallel_4.5.1
KernSmooth_2.23-26
[17] pkgconfig_2.0.3
data.table_1.17.8
[19] Matrix_1.7-4
RColorBrewer_1.1-3
[21] BSgenome_1.78.0
cigarillo_1.0.0
[23] S7_0.2.0
stringr_1.5.2
[25] lifecycle_1.0.4
idr_1.3
[27] compiler_4.5.1
Rsamtools_2.26.0
[29] farver_2.1.2
BiocStyle_2.38.0
[31] Biostrings_2.78.0
codetools_0.2-20
[33] Seqinfo_1.0.0
RCurl_1.98-1.17
[35] htmltools_0.5.8.1
pillar_1.11.1
[37] yaml_2.3.10
BiocParallel_1.44.0
[39] crayon_1.5.3
abind_1.4-8
[41] DelayedArray_0.36.0
digest_0.6.37
[43] tidyselect_1.2.1
reshape2_1.4.4
[45] stringi_1.8.7
genomation_1.42.0
[47] dplyr_1.1.4
fastmap_1.2.0
[49] restfulr_0.0.16
cli_3.6.5
[51] grid_4.5.1
magrittr_2.0.4
[53] SparseArray_1.10.0
dichromat_2.0-0.1
[55] S4Arrays_1.10.0
readr_2.1.5
[57] XML_3.99-0.19
plotrix_3.8-4
[59] scales_1.4.0
XVector_0.50.0
[61] rmarkdown_2.30
matrixStats_1.5.0
[63] httr_1.4.7
evaluate_1.0.5
[65] hms_1.1.4
GenomicRanges_1.62.0
[67] knitr_1.50
rtracklayer_1.70.0
[69] BiocIO_1.20.0
Rcpp_1.1.0
[71] rlang_1.1.6
glue_1.8.0
[73] gridBase_0.4-7
plyr_1.8.9
[75] BiocManager_1.30.26
MatrixGenerics_1.22.0
[77] R6_2.6.1
[79] GenomicAlignments_1.46.0

6


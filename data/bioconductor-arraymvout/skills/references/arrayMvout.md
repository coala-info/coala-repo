Affy array outlier detection via dimension reduction

A Asare, Z Gao, V Carey

October 29, 2025

Contents

1 Introduction

2 Illustration with MAQC data

3 Illustration with arrays from a clinical trial network

4 Manual work with the MAQC subset

4.1 QA diagnostics
4.2 Outlier detection using diagnostics

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . .

5 Intensity contamination in the spikein data

6 Appendix: Sources and text for statically computed sections with eval

set to false

1

Introduction

1

2

2

4
5
8

9

12

Clinical trials groups now routinely produce hundreds of microarrays to generate mea-
sures of clinical conditions and treatment responses at the level of mRNA abundance.
Objective, quantitative measures of array quality are important to support these projects.
Numerous packages in Bioconductor address quality assessment procedures. ArrayQual-
ityMetrics is a particularly attractive set of tools. We provide arrayMvout as a module
that performs parametric outlier detection after data reduction to support formal deci-
sionmaking about array acceptability. Ultimately the measures and procedures provided
by arrayMvout may be useful as components of other packages for quality assessment.
Another closely related package is mdqc, which employs a variety of robustifications of
Mahalanobis distance to help identify outlying arrays.

Suppose there are N affymetrix arrays to which N independent samples have been
hybridized. The arrayMvout package computes Q quality measures which constitute

1

array-specific features. These features are then analyzed in two steps. First, principal
components analysis is applied to the N × Q feature matrix. Second, parametric mul-
tivariate outlier detection with calibration for multiple testing is applied to a subset of
the resulting principal components. Arrays identified as outliers by this procedure are
then subject to additional inspection and/or exclusion as warranted.

In this vignette we illustrate application of the procedure for a ‘negative control’

(raw MAQC data) and several constructed quality defect situations.

2

Illustration with MAQC data

We have serialized sufficient information on the MAQC subset to allow a simple demon-
stration of a negative control set. The MAQC data should be free of outliers.

We will manually search for outliers in this data resource. We compute principal

components and take the first three.

> library(arrayMvout)
> data(maqcQA)
> mm = ArrayOutliers(maqcQA[, 3:11], alpha=.01)
> mm

ArrayOutliers result.
The call was:
.local(data = data, alpha = alpha, alphaSeq = alphaSeq)
No outliers. First row of QC features

avgBG

RLE_IQR
1 60.05505 1.17657 52.4225 1.245477 1.015217 1.057659 0.04185417 0.5516266

SF Present

HSACO7

GAPDH

NUSE

RLE

RNAslope
1 3.141527

There are no outliers found at a false labeling rate of 0.01.

3

Illustration with arrays from a clinical trial network

Another data resource with some problematic arrays is also included.

> data(itnQA)
> ii = ArrayOutliers(itnQA, alpha=.01)
> ii

ArrayOutliers result.
The call was:
.local(data = data, alpha = alpha, alphaSeq = alphaSeq)

2

There were
Coordinate-wise means of inlying arrays:

samples with

507

18

outliers detected.

avgBG

NUSE
4.498102e+01 1.731430e+00 4.162066e+01 2.187432e+00 1.770430e+00 1.000867e+00

Present

HSACO7

GAPDH

SF

RLE

RNAslope
6.050559e-05 2.976345e-01 3.427889e+00
Features of outlying arrays:

RLE_IQR

SF

GAPDH

avgBG

HSACO7
Present
1.433827
77.07796 0.4374264 47.55007
1.9288207 39.60311 12.647909
41.00919
37.26800 6.2588701 24.39140
4.131615
40.61447 1.9891220 39.39095 10.360385
5.930873
36.28049 9.1599338 25.08642
2.497312
54.36467 3.6423721 26.03567
40.36647 2.3888050 39.61957
8.852826
31.73768 5.6643255 32.43347 16.760480
50.32263 2.6636200 34.85871 23.990430
39.08553 2.9476038 36.66575 22.884391
1.432298
85.82265 1.8183446 34.61363
2.629898
30.14740 29.3554869 17.02423
1.073282
33.71813 15.6434771 17.80887
3.508757
95.45017 1.2115402 36.64563
1.5643922 23.87197
3.057225
2.907469
1.4429218 30.23137
25.37851 16.8069277 25.72474 56.917203
11.840316 1.1360326
38.11554 19.0772560 11.60677 67.021339 120.011952 1.1987268

RLE
NUSE
0.005285121
1.307327 0.9991413
0.021545990
4.707294 1.0097374
0.127501020
2.047267 1.0284928
0.036462661
6.718598 1.0103497
0.036035969
2.189993 1.1064651
0.108838227
1.893548 1.0438432
0.051526272
7.201938 1.0302444
0.052612806
11.955661 1.0507761
0.092065904
7.101770 1.0542473
0.087581891
12.036149 1.0457600
0.009663181
1.510193 1.0822086
0.132794452
1.718535 1.0874808
2.643669 1.1669600
0.321298991
2.479803 1.1128690 -0.000687765
1.810761 1.1098076
0.073777325
2.101054 1.1475918 -0.018917415
0.073802881
0.349949413

403
16
449
189
445
473
235
323
268
274
132
499
41
400
485 129.10624
188 142.44325
313
305

RNAslope
RLE_IQR
3.66807105
403 0.2197193
0.3299879 5.42259351
16
1.89557125
449 0.5672631
5.80774028
189 0.3305528
2.54468591
445 0.5465581
1.32173147
473 0.6448400
6.54325480
235 0.3657481
5.88500524
323 0.4407913
5.74973052
268 0.5755214
7.09471717
274 0.4367455
1.19952480
132 0.6664186
1.87786720
499 0.6250615
1.0754575 1.11521819
41
2.46627267
400 0.6759216
485 0.9486388 -0.04085089

3

188 0.8908112
313 0.6503561
305 1.3208768

1.76393357
6.13572050
6.96678147

We have a simple visualization.

> plot(ii, choices=c(1,3))

4 Manual work with the MAQC subset

The remaining text of this vignette is computed statically. The source code with
eval=FALSE is given as an appendix.

We consider an AffyBatch supplied with the Bioconductor MAQCsubset package.
Marginal boxplots of raw intensity data are provided in the next figure. Sample labels
are decoded AFX _ [lab] _ [type] [replicate] .CEL where [lab] ∈ (1, 2, 3), [type] denotes
mixture type (A = 100% USRNA, B = 100% Ambion brain, C = 75% USRNA, 25%
brain, D = 25% USRNA, 75% brain), and replicate ∈ (1, 2).

4

−0.20.00.20.4−0.20.00.20.4all QC statsPC1PC3123456789101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899100101102103104105106107108109110111112113114115116117118119120121122123124125126127128129130131132133134135136137138139140141142143144145146147148149150151152153154155156157158159160161162163164165166167168169170171172173174175176177178179180181182183184185186187188189190191192193194195196197198199200201202203204205206207208209210211212213214215216217218219220221222223224225226227228229230231232233234235236237238239240241242243244245246247248249250251252253254255256257258259260261262263264265266267268269270271272273274275276277278279280281282283284285286287288289290291292293294295296297298299300301302303304305306307308309310311312313314315316317318319320321322323324325326327328329330331332333334335336337338339340341342343344345346347348349350351352353354355356357358359360361362363364365366367368369370371372373374375376377378379380381382383384385386387388389390391392393394395396397398399400401402403404405406407408409410411412413414415416417418419420421422423424425426427428429430431432433434435436437438439440441442443444445446447448449450451452453454455456457458459460461462463464465466467468469470471472473474475476477478479480481482483484485486487488489490491492493494495496497498499500501502503504505506507−150−100−50050100150200−150−100−50050100150200avgBGSFPresentHSACO7GAPDHNUSERLERLE_IQRRNAslope> library(arrayMvout)
> library(MAQCsubset)
> if (!exists("afxsub")) data(afxsub)
> sn = sampleNames(afxsub)
> if (nchar(sn)[1] > 6) {
+
+
+ }

sn = substr(sn, 3, 8)
sampleNames(afxsub) = sn

> opar = par(no.readonly = TRUE)
> par(mar = c(10, 5, 5, 5), las = 2)
> boxplot(afxsub, main = "MAQC subset", col = rep(c("green", "blue",
+
> par(opar)

"orange"), c(8, 8, 8)))

4.1 QA diagnostics

Of interest are measures of RNA degradation:

5

X_1_A1X_1_A2X_1_B1X_1_B2X_1_C1X_1_C2X_1_D1X_1_D2X_2_A1X_2_A2X_2_B1X_2_B2X_2_C1X_2_C2X_2_D1X_2_D2X_3_A1X_3_A2X_3_B1X_3_B2X_3_C1X_3_C2X_3_D1X_3_D268101214MAQC subset> library(arrayMvout)
> data(afxsubDEG)
> plotAffyRNAdeg(afxsubDEG, col = rep(c("green", "blue", "orange"),
+

c(8, 8, 8)))

and the general ‘simpleaffy’ QC display:

> data(afxsubQC)
> plot(afxsubQC)

6

RNA degradation plot5' <−−−−−> 3' Probe Number Mean Intensity : shifted and scaled02468100102030405060The affyPLM package fits probe-level robust regressions to obtain probe-set sum-

maries.

> library(affyPLM)
> splm = fitPLM(afxsub)

> png(file = "doim.png")
> par(mar = c(7, 5, 5, 5), mfrow = c(2, 2), las = 2)
> NUSE(splm, ylim = c(0.85, 1.3))
> RLE(splm)
> image(splm, which = 2, type = "sign.resid")
> image(splm, which = 5, type = "sign.resid")

In the following graphic, we have the NUSE distributions (upper left), the RLE

distributions (upper right), and second and fifth chips in signed residuals displays.

7

00QC StatsX_1_A1X_1_A2X_1_B1X_1_B2X_1_C1X_1_C2X_1_D1X_1_D2X_2_A1X_2_A2X_2_B1X_2_B2X_2_C1X_2_C2X_2_D1X_2_D2X_3_A1X_3_A2X_3_B1X_3_B2X_3_C1X_3_C2X_3_D1X_3_D20321−3−2−10ll52.42%60.06ll54.63%52.42ll52.09%53.01ll51.11%66.66ll54.84%50.73ll56.64%51.54ll57.4%53.01ll57.87%53.66ll53.16%48.82ll53.09%47.16ll49.77%48.17ll52.06%51.69ll56.87%47.2ll55.43%46.69ll54.75%47.33ll55.22%47.18ll55.43%45.88ll54.22%44.59ll54.99%47.38ll53.03%47.98ll58.35%42.86ll56.33%49.36ll57.6%50.66ll56.27%46.450lgapdh3/gapdh5actin3/actin5These chips seem to have adequate quality, although there is some indication that

the first four are a bit different with respect to variability.

4.2 Outlier detection using diagnostics

Let’s apply the diagnostic-dimension reduction-multivariate outlier procedure ArrayOutliers.

> AO = ArrayOutliers(afxsub, alpha = 0.05, qcOut = afxsubQC, plmOut = splm,
+
> nrow(AO[["outl"]])

degOut = afxsubDEG)

[1] 0

We see that there are no outliers declared. This seems a reasonable result for arrays
that were hybridized in the context of a QC protocol. Let us apply the mdqc procedure.
As input this takes any matrix of quality indicators. The third component of our Ar-
rayOutliers result provides these as computed using simpleaffy qc(), affy AffyRNAdeg,
and affyPLM NUSE and RLE. The QC measures for the first two chips are:

8

> AO[[3]][1:2, ]

avgBG

RLE
X_1_A1 60.05505 1.1765695 52.42250 1.245477 1.065898 1.064069 0.04163564
X_1_A2 52.42248 0.9459093 54.63009 1.273977 1.094208 1.040718 0.03253112

Present

HSACO7

GAPDH

NUSE

SF

RLE_IQR RNAslope
X_1_A1 0.5626532 3.141527
X_1_A2 0.5459847 3.210157

We now use the mdqc package with MVE robust covariance estimation.

> library(mdqc)
> mdq = mdqc(AO[[3]], robust = "MVE")
> mdq

6 16 17 18 21 24

Number of groups: 1

Method used: nogroups
Robust estimator: MVEMDs exceeding the square root of the 90 % percentile of the Chi-Square distribution
[1]
MDs exceeding the square root of the 95 % percentile of the Chi-Square distribution
[1]
MDs exceeding the square root of the 99 % percentile of the Chi-Square distribution
[1]

6 16 17 18 21 24

6 16 17 18 21 24

We see that a number of the arrays are determined to be outlying by this procedure
according to several thresholds.

5 Intensity contamination in the spikein data

We begin with a simple demonstration of a contamination procedure that simulates
severe blobby interference with hybridization.

The code below is unevaluated to speed execution. Set eval=TRUE on all chunks to

see the actual process.

> require(mvoutData)
> data(s12c)

> image(s12c[, 1])

9

For this AffyBatch instance, we have contaminated the first two arrays in this way.

We now apply the ArrayOutliers procedure:

> aos12c = ArrayOutliers(s12c, alpha = 0.05)

> aos12c[[1]]

samp

avgBG

Present
1 12_13_02_U133A_Mer_Latin_Square_Expt1_R1 7205.48413 5.494978 19.05381
2 12_13_02_U133A_Mer_Latin_Square_Expt2_R1 7205.12544 5.801398 17.62332
8 12_13_02_U133A_Mer_Latin_Square_Expt8_R1
31.23121 1.181946 45.47982
RLE

RNAslope
1 9.488671 8.6364494 1.578471 -0.514913919 1.33150311 -0.05195296
2 8.517500 9.7475845 1.579164 -0.514617696 1.37213796 -0.07638096
8 1.042255 0.8965249 1.000006 0.001987620 0.09164597 1.53050152

RLE_IQR

HSACO7

GAPDH

NUSE

SF

We find three arrays declared to be outlying. At the different candidate significance
levels we have:

10

> aos12c[[4]]

[[1]]
[[1]]$inds
[1] 1 2

[[1]]$vals

PC3
PC1
[1,] -6.345625
0.08184738 0.05419247
[2,] -6.485447 -0.07281758 -0.05421514

PC2

[[1]]$k
[1] 5

[[1]]$alpha
[1] 0.01

[[2]]
[[2]]$inds
[1] 8 1 2

[[2]]$vals

PC1

PC3
1.104062 -0.18796407 -0.008319271
[1,]
[2,] -6.345625
0.08184738 0.054192469
[3,] -6.485447 -0.07281758 -0.054215145

PC2

[[2]]$k
[1] 5

[[2]]$alpha
[1] 0.05

[[3]]
[[3]]$inds
[1] 8 1 2

[[3]]$vals

PC1

PC3
1.104062 -0.18796407 -0.008319271
0.08184738 0.054192469

[1,]
[2,] -6.345625

PC2

11

[3,] -6.485447 -0.07281758 -0.054215145

[[3]]$k
[1] 5

[[3]]$alpha
[1] 0.1

So at the 0.01 level we have identified only the contaminated arrays.

We apply mdqc in the same manner.

> mdqc(aos12c[[3]], robust = "MVE")

Number of groups: 1

Method used: nogroups
Robust estimator: MVEMDs exceeding the square root of the 90 % percentile of the Chi-Square distribution
[1] 2
MDs exceeding the square root of the 95 % percentile of the Chi-Square distribution
[1] 2
MDs exceeding the square root of the 99 % percentile of the Chi-Square distribution
[1] 2

We see that only one of the contaminated arrays is identified by this procedure. This

may be an instance of masking.

6 Appendix: Sources and text for statically computed

sections with eval set to false

Manual work with the MAQC subset

All the code follwing has had evaluation turned off because execution times are slow.

We consider an AffyBatch supplied with the Bioconductor MAQCsubset package.
Marginal boxplots of raw intensity data are provided in the next figure. Sample labels
are decoded AFX _ [lab] _ [type] [replicate] .CEL where [lab] ∈ (1, 2, 3), [type] denotes
mixture type (A = 100% USRNA, B = 100% Ambion brain, C = 75% USRNA, 25%
brain, D = 25% USRNA, 75% brain), and replicate ∈ (1, 2).

> library(arrayMvout)
> library(MAQCsubset)
> if (!exists("afxsub")) data(afxsub)
> sn = sampleNames(afxsub)
> if (nchar(sn)[1] > 6) {
sn = substr(sn, 3, 8)
+

12

sampleNames(afxsub) = sn

+
+ }

> opar = par(no.readonly=TRUE)
> par(mar=c(10,5,5,5), las=2)
> boxplot(afxsub, main="MAQC subset",
+
> par(opar)

col=rep(c("green", "blue", "orange"), c(8,8,8)))

QA diagnostics

Of interest are measures of RNA degradation:

> #afxsubDEG = AffyRNAdeg(afxsub)
> #save(afxsubDEG, file="afxsubDEG.rda")
> library(arrayMvout)
> data(afxsubDEG)
> plotAffyRNAdeg(afxsubDEG,
+

col=rep(c("green", "blue", "orange"),c(8,8,8)))

and the general ‘simpleaffy’ QC display:

> #afxsubQC = qc(afxsub)
> #save(afxsubQC, file="afxsubQC.rda")
> data(afxsubQC)
> plot(afxsubQC)

The affyPLM package fits probe-level robust regressions to obtain probe-set sum-

maries.

> library(affyPLM)
> #if (file.exists("splm.rda")) load("splm.rda")
> #if (!exists("splm")) splm = fitPLM(afxsub)
> splm = fitPLM(afxsub)
> #save(splm, file="splm.rda")

> png(file="doim.png")
> par(mar=c(7,5,5,5),mfrow=c(2,2),las=2)
> NUSE(splm, ylim=c(.85,1.3))
> RLE(splm)
> image(splm, which=2, type="sign.resid")
> image(splm, which=5, type="sign.resid")

These chips seem to have adequate quality, although there is some indication that

the first four are a bit different with respect to variability.

13

Outlier detection using diagnostics

Let’s apply the diagnostic-dimension reduction-multivariate outlier procedure ArrayOutliers.

> AO = ArrayOutliers(afxsub, alpha=0.05, qcOut=afxsubQC,
+
> nrow(AO[["outl"]])

plmOut=splm, degOut=afxsubDEG)

We see that there are no outliers declared. This seems a reasonable result for arrays
that were hybridized in the context of a QC protocol. Let us apply the mdqc procedure.
As input this takes any matrix of quality indicators. The third component of our Ar-
rayOutliers result provides these as computed using simpleaffy qc(), affy AffyRNAdeg,
and affyPLM NUSE and RLE. The QC measures for the first two chips are:

> AO[[3]][1:2, ]

We now use the mdqc package with MVE robust covariance estimation.

> library(mdqc)
> mdq = mdqc( AO[[3]], robust="MVE" )
> mdq

We see that a number of the arrays are determined to be outlying by this procedure
according to several thresholds.

Intensity contamination in the spikein data

We begin with a simple demonstration of a contamination procedure that simulates
severe blobby interference with hybridization.

The code below is unevaluated to speed execution. Set eval=TRUE on all chunks to

see the actual process.

> require(mvoutData)
> data(s12c)

> image(s12c[,1])

For this AffyBatch instance, we have contaminated the first two arrays in this way.

We now apply the ArrayOutliers procedure:

> aos12c = ArrayOutliers(s12c, alpha=0.05)

> aos12c[[1]]

We find three arrays declared to be outlying. At the different candidate significance
levels we have:

14

> aos12c[[4]]

So at the 0.01 level we have identified only the contaminated arrays.

We apply mdqc in the same manner.

> mdqc(aos12c[[3]], robust="MVE")

We see that only one of the contaminated arrays is identified by this procedure. This

may be an instance of masking.

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
[1] tools
[8] base

stats

graphics

grDevices utils

datasets

methods

other attached packages:
[1] arrayMvout_1.68.0
[4] BiocGenerics_0.56.0 generics_0.1.4

affy_1.88.0

Biobase_2.70.0
parody_1.68.0

loaded via a namespace (and not attached):

[1] beanplot_1.3.1
[3] bitops_1.0-9
[5] magrittr_2.0.4
[7] scrime_1.3.5

DBI_1.2.3
mdqc_1.72.0
rlang_1.1.6
matrixStats_1.5.0

15

[9] compiler_4.5.1

RSQLite_2.4.3
GenomicFeatures_1.62.0
png_0.1-8
quadprog_1.5-8
pkgconfig_2.0.3
fastmap_1.2.0
Rsamtools_2.26.0
UCSC.utils_1.6.0
purrr_1.1.0
cachem_1.1.0
GenomeInfoDb_1.46.0
blob_1.2.4
DelayedArray_0.36.0
Rhdf5lib_1.32.0
parallel_4.5.1
R6_2.6.1
limma_3.66.0
genefilter_1.92.0
GenomicRanges_1.62.0
Seqinfo_1.0.0

[11] mgcv_1.9-3
[13] DelayedMatrixStats_1.32.0
[15] vctrs_0.6.5
[17] minfi_1.56.0
[19] crayon_1.5.3
[21] XVector_0.50.0
[23] tzdb_0.5.0
[25] preprocessCore_1.72.0
[27] bit_4.6.0
[29] cigarillo_1.0.0
[31] jsonlite_2.0.0
[33] rhdf5filters_1.22.0
[35] reshape_0.8.10
[37] BiocParallel_1.44.0
[39] cluster_2.1.8.1
[41] RColorBrewer_1.1-3
[43] rtracklayer_1.70.0
[45] affyContam_1.68.0
[47] Rcpp_1.1.0
[49] SummarizedExperiment_1.40.0 iterators_1.0.14
[51] readr_2.1.5
[53] tidyselect_1.2.1
[55] illuminaio_0.52.0
[57] splines_4.5.1
[59] yaml_2.3.10
[61] codetools_0.2-20
[63] doRNG_1.8.6.2
[65] lattice_0.22-7
[67] KEGGREST_1.50.0
[69] survival_3.8-3
[71] mclust_6.1.1
[73] pillar_1.11.1
[75] BiocManager_1.30.26
[77] rngtools_1.5.2
[79] foreach_1.5.2
[81] nleqslv_3.3.5
[83] methylumi_2.56.0
[85] S4Vectors_0.48.0
[87] bumphunter_1.52.0
[89] glue_1.8.0
[91] data.table_1.17.8

IRanges_2.44.0
rentrez_1.2.4
Matrix_1.7-4
abind_1.4-8
siggenes_1.84.0
curl_7.0.0
tibble_3.3.0
plyr_1.8.9
askpass_1.2.1
xml2_1.4.1
Biostrings_2.78.0
affyio_1.80.0
MatrixGenerics_1.22.0
KernSmooth_2.23-26
stats4_4.5.1
RCurl_1.98-1.17
hms_1.1.4
sparseMatrixStats_1.22.0
xtable_1.8-4
BiocIO_1.20.0
annotate_1.88.0

16

[93] locfit_1.5-9.12
[95] GEOquery_2.78.0
[97] rhdf5_2.54.0
[99] tidyr_1.3.1
[101] base64_2.0.2
[103] nlme_3.1-168
[105] HDF5Array_1.38.0
[107] cli_3.6.5
[109] dplyr_1.1.4
[111] SparseArray_1.10.0
[113] lifecycle_1.0.4
[115] multtest_2.66.0
[117] httr_1.4.7
[119] openssl_2.3.4
[121] MASS_7.3-65

GenomicAlignments_1.46.0
XML_3.99-0.19
grid_4.5.1
AnnotationDbi_1.72.0
lumi_2.62.0
nor1mix_1.3-3
restfulr_0.0.16
S4Arrays_1.10.0
digest_0.6.37
rjson_0.2.23
memoise_2.0.1
h5mread_1.2.0
statmod_1.5.1
bit64_4.6.0-1

17


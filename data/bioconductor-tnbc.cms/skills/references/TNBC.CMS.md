TNBC.CMS: prediction of TNBC consensus molecular subtype

Doyeong Yu1, Jihyun Kim1, In Hae Park2, and Charny Park1

1Clinical Genomics Analysis Branch, Research Institute, National Cancer Center,
Gyeonggi-do, Republic of Korea
2Center for Breast Cancer, Hospital, National Cancer Center, Gyeonggi-do, Republic of Korea

March 10, 2019

Contents

1 Introduction

2 Loading package and dataset for case studies

3 Case study: CMS classiﬁcation

4 Case study: summary of genomic and clinical characteristics

5 Case study: drug response investigation

6 Saving results

7 Session Info

8 References

2

2

3

3

8

9

9

10

1

1 Introduction

TNBC.CMS is a package for molecular subtype classiﬁcation of triple-negative breast cancer (TNBC). While
various classiﬁcation strategies have been proposed, absence of precise subtype classiﬁer was a limitation of
patient diagnosis and TNBC studies. Our machine learning-based classiﬁer model was derived from gene
expression proﬁles of 957 TNBC patients. The TNBC.CMS package classiﬁes patients into four consensus
molecular subtypes (CMS): mesenchymal-like (MSL), immunomodulatory (IM), luminal AR (LAR) and
stem-like (SL). It also provides a summary of genomic and clinical characteristics including survival, hazard
ratio, pathway activities and drug responses.

2 Loading package and dataset for case studies

In this vignette, we walk through a case study of the breast cancer microarray dataset GSE25055 [1] to demon-
strate the practical use of our package. The GSE25055 dataset was obtained from the curatedBreastData
package. We ﬁltered out samples which seemed to be positive for ER, PR, and HER2 based on immunohisto-
chemistry results and the distribution of gene expression.

First, we load the package and the processed expression data. The dataset is contained in a SummarizedExperiment

object, which includes expression proﬁles of 4,746 genes and 73 samples. Note that rows and columns correspond
to genes and samples, and row names must be gene symbols.

library(TNBC.CMS)
data("GSE25055")
dim(assays(GSE25055)[[1]])

## [1] 4746

73

assays(GSE25055)[[1]][1:5, 1:5]

##
## HBA1
## HBB
## B2M
## FTH1
## HLA-B

615397 615396 615394 615393 615392
13
12
12
12
11

15
15
13
12
12

15
15
13
13
12

16
16
14
13
15

16
16
14
12
14

2

3 Case study: CMS classiﬁcation

The predictCMS function assigns consensus molecular subtypes to TNBC samples based on input matrix or
SummarizedExperiment object. If input is a SummarizedExperiment object, the ﬁrst element in the assays
list should be a matrix of gene expression. In any case, gene expression proﬁles should neither be scaled nor
log-transformed. Class probabilities can be retrieved by accessing the probabilities attribute.

predictions <- predictCMS(GSE25055)
table(predictions)

## predictions
## MSL IM LAR
## 12 14 23

SL
24

head(attr(predictions, "probabilities"))

IM

LAR

MSL

##
SL
## 615397 0.0050 0.0035 0.0068 0.985
## 615396 0.0264 0.0141 0.9397 0.020
## 615394 0.0563 0.0202 0.0204 0.903
## 615393 0.0010 0.0017 0.9566 0.041
## 615392 0.0021 0.0388 0.7918 0.167
## 615390 0.0292 0.0089 0.0050 0.957

4 Case study: summary of genomic and clinical characteristics

The TNBC.CMS package includes several functions for studying genomic and clinical characteristics of the
consensus molecular subtypes. In this section, we apply these functions to the GSE25055 datasets of gene
expression and clinical features.

The computeGES function calculates signature scores for the following 7 gene expression signatures: EMT
(epithelial-mesencymal transition), stromal, immune, microenvironment, stemness, hormone, and CIN (chro-
mosomal instability) [2-6]. For more details about the gene expression signatures, please see the manual page
for computeGES function.

As shown in Figure 1, this function also draws boxplots of signature scores with p-values of comparison
among the subtypes. Stromal, immune, hormone, and stemness scores are signiﬁcantly higher in MSL, IM,
LAR, and SL subgroups than in other subgroups, respectively.

resultGES <- computeGES(expr = GSE25055, pred = predictions,

rnaseq = FALSE)

resultGES[,1:4]

##
## EMT
## Stromal
## Immune
## Microenvironment
## Stemness
## Hormone
## CIN

615397
6.04

615394
6.35

615396
6.19

615393
5.73
-605.49 -642.15 -552.41 -929.42
293.84 -141.40
0.22
0.61
5.45
7.52

167.10
0.30
0.55
4.96
7.39

282.41
0.26
0.30
4.95
6.76

0.34
0.40
5.59
7.23

3

Figure 1: Gene expression signature scores

The performGSVA function performs gene set variation analysis on gene sets and produces a heatmap
representing GSVA enrichment scores [7]. If gene sets are not given, the hallmark pathway gene sets are used
[8]. The user can also choose a kernel for estimating the cumulative distribution function of expression values
by setting the gsva.kcdf argument, which is set to "Gaussian" by default. If expression levels are integer
counts, the "Poisson" is recommended.

Figure 2 shows diﬀerential activation of the hallmark pathways across the subtypes. The MSL subtype
has high levels of EMT and P53 pathway activation, and the IM subtype shows the high interferon gamma
response. AR and ER response pathways are highly activated in the LAR subtpe, and the expression of cell
cycle associated pathway genes is up-regulated in the SL subtype.

resultGSVA <- performGSVA(expr = GSE25055, pred = predictions,

head(resultGSVA[,1:4])

gene.set = NULL)

615397 615396 615394 615393
##
-0.16
-0.021
## KRAS_SIGNALING
-0.33
## COAGULATION
-0.353
-0.18
## EPITHELIAL_MESENCHYMAL_TRANSITION -0.181
-0.26
## MYOGENESIS
-0.057
-0.31
## ANGIOGENESIS
-0.16
## APICAL_JUNCTION

0.178
0.217
0.039
0.110
0.039 -0.120
0.108

0.29
0.24
0.38
0.35
0.45
0.34

-0.127

4

llllllllllllll−1500−1000−5000500456789−5000500100015000.000.250.500.751.00Wilcoxon (MSL vs. others) p = 8.1e−07Wilcoxon (MSL vs. others) p = 0.016Wilcoxon (MSL vs. others) p = 3.6e−06Wilcoxon (MSL vs. others) p = 0.00034StromalHormoneImmuneStemFigure 2: GSVA enrichment scores

The TNBC.CMS package provides two functions for survival analysis: plotKM and plotHR. Here, we use the
survival data from the GSE25055 dataset to study the association between overall survival and the consensus
molecular subtypes. The survival data is also included in the SummarizedExperiment object and can be
accessed using the colData function.

The plotKM function produces a Kaplan-Meier curve for each consensus molecular subtype like Figure 3.

The SL group showed the worst prognosis, which is consistent with our previous study.

time <- colData(GSE25055)$DFS.month
event <- colData(GSE25055)$DFS.status
plotKM(pred = predictions, time = time, event = event)

5

KRAS_SIGNALINGCOAGULATIONEPITHELIAL_MESENCHYMAL_TRANSITIONMYOGENESISANGIOGENESISAPICAL_JUNCTIONTNFA_SIGNALING_VIA_NFKBAPOPTOSISTGF_BETA_SIGNALINGP53_PATHWAYHYPOXIAHEDGEHOG_SIGNALINGINTERFERON_GAMMA_RESPONSEIL6_JAK_STAT3_SIGNALINGIL2_STAT5_SIGNALINGINFLAMMATORY_RESPONSEINTERFERON_ALPHA_RESPONSEESTROGEN_RESPONSE_EARLYESTROGEN_RESPONSE_LATEANDROGEN_RESPONSEBILE_ACID_METABOLISMADIPOGENESISFATTY_ACID_METABOLISMPROTEIN_SECRETIONG2M_CHECKPOINTE2F_TARGETSMYC_TARGETS_V2MYC_TARGETS_V1MITOTIC_SPINDLEDNA_REPAIRWNT_BETA_CATENIN_SIGNALINGNOTCH_SIGNALINGGLYCOLYSISCMSMSLIMLARSL−2−1012Figure 3: Overall survival

The plotHR produces a forest plot of hazard ratios for genes that the user provides. For each input gene,
samples are divided into high and low groups based on its expression level and the 95% conﬁdence interval
for the hazard ratio is calculated. We selected 10 genes signiﬁcantly associated with overall survival and
generated a forest plot (Figure 4).

library(survival)

#Test for difference of survival between low and high expression groups
surv <- Surv(time, event)
GSE25055.exprs <- assays(GSE25055)[[1]]
chisq <- apply(GSE25055.exprs, 1, function(x) survdiff(surv ~ (x > median(x)))$chisq)
pval <- 1 - pchisq(chisq, 1)

#Select 10 genes with lowest p-values for the log-rank test
gs <- names(sort(pval)[1:10])
gs

## [1] "RECK"
## [8] "PRPF39" "OPHN1"

"RELN"

"EHD4"
"CPE"

"PRRX2"

"FOLR1"

"UGCG"

"GOT2"

plotHR(expr = GSE25055, gene.symbol = gs, pred = predictions, time = time,

event = event, by.subtype = FALSE)

6

0.000.250.500.751.000255075Follow−up timeEventless probabilityCMSMSLIMLARSLFigure 4: Forest plot of hazard ratios

Also, as shown in Figure 5, subtype-speciﬁc hazard ratios for genes of interest can be computed by setting

the by.subtype argument.

plotHR(expr = GSE25055, gene.symbol = gs[1:4], pred = predictions,

time = time, event = event, by.subtype = TRUE)

Figure 5: Forest plot of subtype-speciﬁc hazard ratios

7

GeneRECKRELNEHD4PRRX2FOLR1UGCGGOT2PRPF39OPHN1CPElog HR0.64[0.31, 0.98]0.86[0.40, 1.32]−0.80[−1.15, −0.45]0.51[0.23, 0.78]0.45[0.13, 0.76]−0.65[−0.95, −0.34]−0.62[−0.96, −0.28]0.52[0.15, 0.89]0.57[0.28, 0.86]−0.13[−0.44, 0.19]P−value1.8e−042.6e−047.1e−063.2e−045.8e−032.9e−053.2e−046.4e−031.0e−044.3e−01−2−1012log hazard ratioGeneRECKRELNEHD4PRRX2log HR−1.54[−3.75, 0.68]−1.20[−2.85, 0.45]−2.47[−4.09, −0.84]−2.00[−3.24, −0.75]−0.77[−2.56, 1.03]−2.12[−4.91, 0.66]−1.71[−3.16, −0.26]−1.19[−2.23, −0.15]−0.42[−2.08, 1.23]1.22[−0.32, 2.75]2.89[0.74, 5.04]0.33[−0.70, 1.37]−2.22[−4.46, 0.02]−1.27[−3.28, 0.75]−1.18[−2.30, −0.07]−0.55[−1.54, 0.45]P−value1.7e−011.5e−013.0e−031.7e−034.0e−011.3e−012.1e−022.5e−026.2e−011.2e−018.4e−035.3e−015.2e−022.2e−013.6e−022.8e−01−2−1012log hazard ratio5 Case study: drug response investigation

The TNBC.CMS package also provides a function for predicting drug responses. The computeDS function
computes drug signature scores for the corresponding gene sets in the MSigDB CGP (chemical and genetic
perturbations) collection [9] and draws a heatmap of the signature scores. Drug signature scores are calculated
as the diﬀerence between the average expression values of gene sets associated with drug response and
resistance. The higher a signature score is, the more likely a patient is to be responsive. The user can provide
their own gene sets via the gene.set argument. Note that names of gene sets must follow the format of
[DRUG NAME]_[RESPONSE/RESISTANCE]_[UP/DN] (e.g. CISPLATIN_RESISTANCE_UP).

Figure 6 shows a heatmap of drug signature scores for each sample. The MSL and SL subtypes appear to
be resistant to dasatinib and doxorubicin, respectively. Also, the IM and LAR subtypes show higher levels of
signature scores for androgen agonist and SB216763 (an inhibitor of GSK3B) than other subtypes, respectively.

resultDS <- computeDS(expr = GSE25055, pred = predictions)
head(resultDS[,1:4])

##
## APLIDIN
## CISPLATIN
## DASATINIB
## FORSKOLIN
## IMATINIB
## TROGLITAZONE

615397 615396 615394 615393
-0.85
0.25
0.72
6.68
-5.28
6.68

-0.89 -0.47
0.69
0.70
6.74
-6.35 -5.09
6.72

-0.81
1.26
-0.12
6.46
-5.48
6.72

0.96
0.55
6.48

6.88

Figure 6: Drug signature scores

8

APLIDINCISPLATINDASATINIBFORSKOLINIMATINIBTROGLITAZONETZDSB216763ANDROGENTAMOXIFENBEXAROTENEDOXORUBICINCMSMSLIMLARSL−4−20246 Saving results

For future analysis, it is useful to save the results of subtype assignment and characterization into a data
frame and save it into a text ﬁle.

dfCMS <- data.frame(row.names = colnames(GSE25055.exprs), CMS = predictions, t(resultGES),

t(resultDS), stringsAsFactors = FALSE)

head(dfCMS)

##
## 615397
SL 6.0
## 615396 LAR 6.2
## 615394
SL 6.4
## 615393 LAR 5.7
## 615392 LAR 5.6
## 615390
SL 6.2
##
## 615397
## 615396
## 615394
## 615393
## 615392
## 615390
##
## 615397
## 615396
## 615394
## 615393
## 615392
## 615390

CMS EMT Stromal Immune Microenvironment Stemness Hormone CIN
5.0 7.4
4.9 6.8
5.6 7.2
5.5 7.5
4.2 8.2
4.6 7.5

-605
-642
-552
-929
-1519
-607

167
282
294
-141
-560
32

0.55
0.30
0.40
0.61
1.00
0.59

0.30
0.26
0.34
0.22
0.17
0.27

6.5
6.7
6.5
6.7
6.7
6.8

0.96
0.69
1.26
0.25
0.36
0.77

-0.89
-0.47
-0.81
-0.85
-1.37
-0.87

APLIDIN CISPLATIN DASATINIB FORSKOLIN IMATINIB TROGLITAZONE TZD
6.9 7.2
6.7 5.3
6.7 6.4
6.7 6.3
7.0 5.5
6.9 7.5

0.55
0.70
-0.12
0.72
0.82
0.14
SB216763 ANDROGEN TAMOXIFEN BEXAROTENE DOXORUBICIN
-6.9
-6.0
-6.3
-6.3
-6.7
-6.3
-7.0
-5.9
-7.6
-6.1
-6.8
-6.2

0.33
0.14
-1.03
0.15
-0.13
-0.88

-6.4
-5.1
-5.5
-5.3
-4.9
-5.0

6.1
6.3
6.0
5.8
5.7
6.0

3.9
4.0
3.8
3.9
4.0
4.2

write.table(dfCMS, file = "GSE25055_CMS.txt")

7 Session Info

sessionInfo()

/home/biocbuild/bbs-3.9-bioc/R/lib/libRblas.so

## R version 3.6.0 (2019-04-26)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.2 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /home/biocbuild/bbs-3.9-bioc/R/lib/libRlapack.so
##
## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_US.UTF-8
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

9

graphics

grDevices utils

ggpubr_0.2
ggplot2_3.1.1
SummarizedExperiment_1.14.0
BiocParallel_1.18.0
Biobase_2.44.0
GenomeInfoDb_1.20.0
S4Vectors_0.22.0
quadprog_1.5-6
knitr_1.22

stats

stats4
base

##
## attached base packages:
## [1] grid
parallel
## [8] datasets methods
##
## other attached packages:
## [1] survival_2.44-1.1
## [3] magrittr_1.5
## [5] TNBC.CMS_1.0.0
## [7] DelayedArray_0.10.0
## [9] matrixStats_0.54.0
## [11] GenomicRanges_1.36.0
## [13] IRanges_2.18.0
## [15] BiocGenerics_0.30.0
## [17] e1071_1.7-1
##
## loaded via a namespace (and not attached):
## [1] splines_3.6.0
## [4] shiny_1.3.2
## [7] blob_1.1.1
## [10] RSQLite_2.1.1
## [13] glue_1.3.1
## [16] promises_1.0.1
## [19] colorspace_1.4-1
## [22] httpuv_1.5.1
## [25] GSEABase_1.46.0
## [28] pheatmap_1.0.12
## [31] xtable_1.8-4
## [34] pracma_2.2.5
## [37] annotate_1.62.0
## [40] crayon_1.3.4
## [43] evaluate_0.13
## [46] class_7.3-15
## [49] stringr_1.4.0
## [52] compiler_3.6.0
## [55] labeling_0.3
## [58] DBI_1.0.0
## [61] R6_2.4.0
## [64] shinythemes_1.1.2
## [67] geneplotter_1.62.0

R.utils_2.8.0
highr_0.8

bit64_0.9-7
assertthat_0.2.1
GenomeInfoDbData_1.2.1 pillar_1.3.1
backports_1.1.4
digest_0.6.18
XVector_0.24.0
R.oo_1.22.0
Matrix_1.2-17
XML_3.98-1.19
zlibbioc_1.30.0
scales_1.0.0
tibble_2.1.1
withr_2.1.2
mime_0.6
GGally_1.4.0
graph_1.62.0
munsell_0.5.0
rlang_0.3.4
bitops_1.0-6
reshape_0.8.8
dplyr_0.8.0.1
stringi_1.4.3
tidyselect_0.2.5

lattice_0.20-38
RColorBrewer_1.1-2
checkmate_1.9.1
htmltools_0.3.6
plyr_1.8.4
pkgconfig_2.0.2
purrr_0.3.2
later_0.8.0
GSVA_1.32.0
lazyeval_0.2.2
memoise_1.1.0
R.methodsS3_1.7.1
tools_3.6.0
AnnotationDbi_1.46.0
RCurl_1.95-4.12
gtable_0.3.0
forestplot_1.7.2
bit_1.1-14
Rcpp_1.0.1
xfun_0.6

8 References

[1] Hatzis, C. et al. (2011). A genomic predictor of response and survival following taxane-anthracycline

chemotherapy for invasive breast cancer JAMA, 305, 1873–81.

[2] Tan, T.Z. et al. (2014). Epithelial-mesenchymal transition spectrum quantiﬁcation and its eﬃcacy in
deciphering survival and drug responses of cancer patients. EMBO molecular medicine, 6, 1279–93.

10

[3] Yoshihara, K. et al. (2013).

Inferring tumour purity and stromal and immune cell admixture from

expression data. Nature communications, 4, 2612.

[4] Aran, D. et al. (2017). xCell: digitally portraying the tissue cellular heterogeneity landscape. Genome

biology, 18, 220.

[5] Malta, T.M. et al. (2018). Machine learning identiﬁes stemness features associated with oncogenic

dediﬀerentiation. Cell, 173, 338–354.

[6] Carter, S.L. et al. (2006). A signature of chromosomal instability inferred from gene expression proﬁles

predicts clinical outcome in multiple human cancers. Nature genetics, 38, 1043.

[7] Hanzelmann, S. et al. (2013). GSVA: gene set variation analysis for microarray and RNA-Seq data. BMC

Bioinformatics, 14, 7.

[8] Liberzon, A. et al. (2015). The molecular signatures database hallmark gene set collection. Cell systems,

1, 417–425.

[9] Liberzon, A. et al. (2011). Molecular signatures database (MSigDB) 3.0. Bioinformatics, 27, 1739–40.

11


Mirsynergy: detect synergistic miRNA regulatory
modules by overlapping neighbourhood expansion

Yue Li
yueli@cs.toronto.edu

April 24, 2017

1

Introduction

MicroRNAs (miRNAs) are ∼22 nucleotide small noncoding RNA that base-pair with mRNA pri-
marily at the 3(cid:48) untranslated region (UTR) to cause mRNA degradation or translational repression
[1]. Aberrant miRNA expression is implicated in tumorigenesis [4]. Construction of microRNA
regulatory modules (MiRM) will aid deciphering aberrant transcriptional regulatory network in
cancer but is computationally challenging. Existing methods are stochastic or require a ﬁxed num-
ber of regulatory modules. We propose Mirsynergy, a deterministic overlapping clustering algo-
rithm adapted from a recently developed framework. Brieﬂy, Mirsynergy operates in two stages
that ﬁrst forms MiRM based on co-occurring miRNAs and then expand the MiRM by greedily
including (excluding) mRNA into (from) the MiRM to maximize the synergy score, which is a
function of miRNA-mRNA and gene-gene interactions (manuscript in prep).

2 Demonstration

In the following example, we ﬁrst simulate 20 mRNA and 20 mRNA and the interactions among
them, and then apply mirsynergy to the simulated data to produce module assignments. We
then visualize the module assignments in Fig.1

> library(Mirsynergy)
> load(system.file("extdata/toy_modules.RData", package="Mirsynergy"))
> # run mirsynergy clustering
> V <- mirsynergy(W, H, verbose=FALSE)
> summary_modules(V)

$moduleSummaryInfo
miRNA mRNA total

1
2
3

4
2
6

4
2
10

synergy

density
12 0.1680051 0.04426190
6 0.1654560 0.09630038
22 0.1870070 0.02471431

1

4
5
6

8
2
3

7
3
4

23 0.1821842 0.02318249
7 0.1640842 0.08457176
10 0.1602223 0.04856618

$miRNA.internal
modules miRNA
2
2
3
1
4
1
6
1
8
1

1
2
3
4
5

$mRNA.internal
modules mRNA
2
1
3
1
4
2
7
1
10
1

1
2
3
4
5

Additionally, we can also export the module assignments in a Cytoscape-friendly format as two
separate ﬁles containing the edges and nodes using the function tabular_module (see function
manual for details).

3 Real test

In this section, we demonstrate the real utility of Mirsynergy in construct miRNA regulatory mod-
ules from real breast cancer tumor samples. Speciﬁcally, we downloaded the test data in the
units of RPKM (read per kilobase of exon per million mapped reads) and RPM (reads per million
miRNA mapped) of 13306 mRNA and 710 miRNA for the 15 individuals from TCGA (The Can-
cer Genome Atlas). We furhter log2-transformed and mean-centred the data. For demonstration
purpose, we used 20% of the expression data containing 2661 mRNA and 142 miRNA expression.
Moreover, the corresponding sequence-based miRNA-target site matrix W was downloaded from
TargetScanHuman 6.2 database [3] and the gene-gene interaction (GGI) data matrix H including
transcription factor binding sites (TFBS) and protein-protein interaction (PPI) data were processed
from TRANSFAC [6] and BioGrid [5], respectively.

> load(system.file("extdata/tcga_brca_testdata.RData", package="Mirsynergy"))

Given as input the 2661 × 15 mRNA and 142 × 15 miRNA expression matrix along with the
2661 × 142 target site matrix, we ﬁrst construct an expression-based miRNA-mRNA interaction
score (MMIS) matrix using LASSO from glmnet by treating mRNA as response and miRNA as
input variables [2].

2

> load(system.file("extdata/toy_modules.RData", package="Mirsynergy"))
> plot_modules(V,W,H)

Figure 1: Module assignment on a toy example.

3

mRNA1mRNA2mRNA3mRNA4mRNA5mRNA6mRNA7mRNA8mRNA9mRNA10mRNA11mRNA12mRNA13mRNA14mRNA15mRNA16mRNA17mRNA18mRNA19mRNA20miRNA1miRNA2miRNA3miRNA4miRNA5miRNA6miRNA7miRNA8miRNA9miRNA10miRNA11miRNA12miRNA13miRNA14miRNA15miRNA16miRNA17miRNA18miRNA19miRNA201,3,4,51,42,3,4,62,633,4456dimnames=list(rownames(X)[i], rownames(Z)))

c_i <- t(matrix(rep(C[i,,drop=FALSE], nrow(obs)), ncol=nrow(obs)))

c_i <- (c_i > 0) + 0 # convert to binary matrix

# use only miRNA with at least one non-zero entry across T samples
inp <- inp[, apply(abs(inp), 2, max)>0, drop=FALSE]

inp <- obs * c_i

pred <- matrix(rep(0, nrow(Z)), nrow=1,

> library(glmnet)
> ptm <- proc.time()
> # lasso across all samples
> # X: N x T (input variables)
> #
> obs <- t(Z) # T x M
> # run LASSO to construct W
> W <- lapply(1:nrow(X), function(i) {
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+ #
+
+
+
+
+
+
+
+
+
+
+ })
> W <- do.call("rbind", W)
> dimnames(W) <- dimnames(C)
> print(sprintf("Time elapsed for LASSO: %.3f (min)",
+

}
pred[pred>0] <- 0

(proc.time() - ptm)[3]/60))

if(ncol(inp) >= 2) {

pred[pred>1] <- 1

pred <- abs(pred)

pred

# NOTE: negative coef means potential parget (remove intercept)
x <- coef(cv.glmnet(inp, X[i,], nfolds=3), s="lambda.min")[-1]

x <- as.numeric(coef(glmnet(inp, X[i,]), s=0.1)[-1])
pred[, match(colnames(inp), colnames(pred))] <- x

[1] "Time elapsed for LASSO: 0.190 (min)"

Given the W and H, we can now apply mirsynergy to obtain MiRM assignments.

4

> V <- mirsynergy(W, H, verbose=FALSE)
> print_modules2(V)

M1 (density=3.31e-02; synergy=2.14e-01):
hsa-miR-302a hsa-miR-520b hsa-miR-302e hsa-miR-3134
MYBL1 LHX8 CLP1 GLS ACVR1 BAMBI TRHDE TSEN34 PRR16 FBXO41 MYCN TRPV6 LEFTY2 LRP8 FTSJD1 RGMA PHYHIPL BNC1 PRRG1 CLIP4 ZNF473
M2 (density=5.03e-02; synergy=2.02e-01):
hsa-miR-4311 hsa-miR-424 hsa-miR-1193
WDR43 LRRCC1 SEH1L PPM1L FAM60A SLC2A14 AKAP6 SIX3 PCDHA7 OTX1 TAF7L PCDHA6
M3 (density=3.53e-02; synergy=2.05e-01):
hsa-miR-3183 hsa-miR-3174 hsa-miR-764 hsa-miR-1273d hsa-miR-495 hsa-miR-519d
RASD2 ZC3HAV1L CACNA1B AQP4 AIF1L NKX2-1 GRHL1 RAP1GAP2 ZSCAN20 LPAR3 GABBR2 EFR3B RFX4 PCDHA11
M4 (density=2.94e-02; synergy=1.67e-01):
hsa-miR-4271 hsa-miR-181c hsa-miR-4313 hsa-miR-609 hsa-miR-518e
PTPRU EN1 ANKRD17 NOL4 TUB CD163 TRANK1 GALK2 GATA6 PLEK SMG5 KPNA3 KCNJ10 GCNT2 PEG3
M5 (density=3.01e-02; synergy=2.07e-01):
hsa-miR-676 hsa-miR-4311 hsa-miR-424 hsa-miR-1193 hsa-miR-608 hsa-miR-3161
WDR43 AMOTL1 LRRCC1 SEH1L PPM1L FAM107A FAM60A KCNQ4 SLC2A14 AKAP6 SIX3 PCDHA7 OTX1 RTN4R TAF7L PCDHA6
M6 (density=1.66e-02; synergy=2.3e-01):
hsa-miR-93 hsa-miR-676 hsa-miR-4311 hsa-miR-625 hsa-miR-424 hsa-miR-1193 hsa-miR-4257 hsa-miR-608 hsa-miR-552 hsa-miR-1301 hsa-miR-3161 hsa-miR-935 hsa-miR-4252
WDR43 AMOTL1 LRRCC1 SEH1L FAIM2 PPM1L KCNK10 FAM107A FAM60A GK NOL4 SLC40A1 KCNQ4 GPD1 UNC80 SLITRK3 ABCG8 RELN NBEAL1 AKAP6 SIX3 FOXP4 FOXP2 NFIX OTX1 RAB3A RTN4R RSPO4 RIMS2 TAF7L PCDHA6 PCDHA11
M7 (density=3.94e-02; synergy=1.76e-01):
hsa-miR-3201 hsa-miR-18b hsa-miR-335 hsa-let-7e
C10orf140 ATF1 HDLBP ODZ4 LOR ZNF641 SLC1A4 IGF2BP2 MYCN NTN1 TEAD1 FAM46A
M8 (density=3.1e-02; synergy=1.73e-01):
hsa-miR-3692 hsa-miR-4284 hsa-miR-122 hsa-miR-3915 hsa-miR-548s hsa-miR-448
CELF5 FOXM1 SLC4A10 TGIF2 TMEM194B RNF165 ABLIM3 SLC2A12 PIP5K1A RNGTT CMTM4 RFX4
M9 (density=6.71e-02; synergy=1.77e-01):
hsa-miR-891b hsa-miR-1322
NMNAT2 CBFB ZNF644 ITGA2 KCNJ10 PDS5B
M10 (density=5.79e-02; synergy=1.92e-01):
hsa-miR-586 hsa-miR-3165 hsa-miR-4276
ZNF384 ZNF879 ZFP1 SOAT1 ADAT2
M11 (density=3.31e-02; synergy=2.06e-01):
hsa-miR-208b hsa-miR-216a hsa-miR-4262
AFG3L2 EDAR EN1 DPP6 USP6NL CNKSR3 L1CAM ATP11C CD163 GATA6 HAND2 CELSR3 RYR3 KPNA3 LRRN1 SLC7A6OS ZFP82 LRP12 EDARADD ABTB2
M12 (density=5.43e-02; synergy=1.62e-01):
hsa-miR-541 hsa-miR-1229 hsa-miR-33a
VCAN CCL5 EMILIN3 SDC1 PCDH7 EPHA8
M13 (density=2.53e-02; synergy=2.06e-01):
hsa-miR-302a hsa-miR-520b hsa-miR-4293 hsa-miR-302e hsa-miR-106a hsa-miR-3134
MYBL1 LHX8 CLP1 GLS ACVR1 BAMBI TRHDE TSEN34 FRZB PRR16 FBXO41 MYCN TRPV6 LEFTY2 LRP8 FTSJD1 SNX22 RGMA PHYHIPL BNC1 PRRG1 B3GALT2 CLIP4 ZNF473 PCDHA6
M14 (density=2.49e-02; synergy=2.24e-01):
hsa-miR-4311 hsa-miR-625 hsa-miR-424 hsa-miR-1193 hsa-miR-4257 hsa-miR-552 hsa-miR-1301 hsa-miR-935 hsa-miR-4252
WDR43 LRRCC1 SEH1L PPM1L SCN3A FAM60A GK NOL4 GPD1 ABCG8 RELN AKAP6 SIX3 FOXP4 FOXP2 LRP8 NFIX OTX1 RSPO4 TAF7L PCDHA6

5

M15 (density=5.08e-02; synergy=2.25e-01):
hsa-miR-513b hsa-miR-1234
KIAA1161 C6orf170 GPR126 PAK6 BOLL ABCA13 NUPL1 INSM1 SEMA3B DMD FIGF KIF26A RIF1 RASGRF1
M16 (density=4.01e-02; synergy=1.72e-01):
hsa-miR-185 hsa-miR-1254 hsa-miR-661
STX1B CADM4 MFRP GEMIN8 GJB1 NFIX TET2 NPAS4 PLEKHG6 OCLN
M17 (density=1.58e-02; synergy=1.92e-01):
hsa-miR-4328 hsa-miR-3148 hsa-miR-208b hsa-miR-216a hsa-miR-4262 hsa-miR-605 hsa-miR-181d hsa-miR-31
AFG3L2 EDAR SARM1 FKBP1A EN1 DPP6 AGPAT9 POLD3 USP6NL CNKSR3 L1CAM ATP11C CD163 GATA6 HYOU1 PAPD7 HAND2 CALCR CELSR3 ISL1 RYR3 KPNA3 DEPDC1 LRRN1 SLC7A6OS ZFP82 DAZL PPPDE2 SEMA3B LRP12 EDARADD NUP210 RAB3IP ABTB2 NPAS4 NR2C1 ZBTB46
M18 (density=1.68e-02; synergy=2.09e-01):
hsa-miR-676 hsa-miR-4311 hsa-miR-519e hsa-miR-424 hsa-miR-1193 hsa-miR-608 hsa-miR-3161 hsa-miR-3135 hsa-miR-3934 hsa-miR-4290
WDR43 AMOTL1 LRRCC1 SEH1L PPM1L FAM107A FAM60A KCNQ4 GDAP1 SLC2A14 AKAP6 SIX3 FEZF1 IGSF10 PCDHA7 DNAJC11 OTX1 GJC1 PNOC RTN4R RGS9BP RHOV TAF7L PCDHA6 SIT1
M19 (density=2.06e-02; synergy=1.95e-01):
hsa-miR-208b hsa-miR-216a hsa-miR-3658 hsa-miR-4262 hsa-miR-601
AFG3L2 EDAR FKBP1A EN1 SNX16 DPP6 KIAA0947 USP6NL CNKSR3 L1CAM ATP11C CD163 GATA6 GGT7 HAND2 CELSR3 RYR3 KPNA3 EPHB4 PRKX LRRN1 SLC7A6OS ZFP82 CYTIP PLAGL1 LRP12 EDARADD ABTB2

> print(sprintf("Time elapsed (LASSO+Mirsynergy): %.3f (min)",
+

(proc.time() - ptm)[3]/60))

[1] "Time elapsed (LASSO+Mirsynergy): 0.330 (min)"

There are several convenience functions implemented in the package to generate summary
information such as Fig.2. In particular, the plot depicts the m/miRNA distribution across modules
(upper panels) as well as the synergy distribution by itself and as a function of the number of
miRNA (bottom panels).

For more details, please refer to our paper (manuscript in prep.).

4 Session Info

> sessionInfo()

R version 3.4.0 (2017-04-21)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.2 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

6

> plot_module_summary(V)

Figure 2: Summary information on MiRM using test data from TCGA-BRCA. Top panels:
m/miRNA distribution across modulesas; Bottom panels: the synergy distribution by itself and
as a function of the number of miRNA.

7

25224111101234523456891013Number of miRNAFrequency of modules0.00.51.01.52.0102030Number of mRNAFrequency of modules0510150.160.180.200.22Synergy scoreDensitylllllllllllllllllll0.160.180.200.22510Number of miRNASynergy score[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats

graphics grDevices utils

datasets

methods

base

other attached packages:
[1] glmnet_2.0-5
[5] ggplot2_2.2.1

foreach_1.4.3
igraph_1.0.1

Matrix_1.2-9

Mirsynergy_1.12.0

loaded via a namespace (and not attached):

[1] Rcpp_0.12.10
[5] grid_3.4.0
[9] scales_0.4.1

[13] iterators_1.0.8
[17] compiler_3.4.0
[21] tibble_1.3.0

References

codetools_0.2-15
plyr_1.8.4
lazyeval_0.2.0
tools_3.4.0
colorspace_1.3-2

lattice_0.20-35
gtable_0.2.0
labeling_0.3
munsell_0.4.3
knitr_1.15.1

reshape_0.8.6
magrittr_1.5
RColorBrewer_1.1-2
parallel_3.4.0
gridExtra_2.2.1

[1] David P Bartel. MicroRNAs: Target Recognition and Regulatory Functions. Cell, 136(2):215–

233, January 2009.

[2] Jerome Friedman, Trevor Hastie, and Rob Tibshirani. Regularization Paths for Generalized
Linear Models via Coordinate Descent. Journal of statistical software, 33(1):1–22, 2010.

[3] Robin C Friedman, Kyle Kai-How Farh, Christopher B Burge, and David P Bartel. Most
mammalian mRNAs are conserved targets of microRNAs. Genome Research, 19(1):92–105,
January 2009.

[4] Riccardo Spizzo, Milena S Nicoloso, Carlo M Croce, and George A Calin. SnapShot: Mi-

croRNAs in Cancer. Cell, 137(3):586–586.e1, May 2009.

[5] Chris Stark, Bobby-Joe Breitkreutz, Andrew Chatr-Aryamontri, Lorrie Boucher, Rose
Oughtred, Michael S Livstone, Julie Nixon, Kimberly Van Auken, Xiaodong Wang, Xiaoqi
Shi, Teresa Reguly, Jennifer M Rust, Andrew Winter, Kara Dolinski, and Mike Tyers. The Bi-
oGRID Interaction Database: 2011 update. Nucleic acids research, 39(Database issue):D698–
704, January 2011.

[6] E Wingender, X Chen, R Hehl, H Karas, I Liebich, V Matys, T Meinhardt, M Prüss, I Reuter,
and F Schacherer. TRANSFAC: an integrated system for gene expression regulation. Nucleic
acids research, 28(1):316–319, January 2000.

8


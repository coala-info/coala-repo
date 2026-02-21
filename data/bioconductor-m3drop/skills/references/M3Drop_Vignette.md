Dropout-based Feature Selection with M3Drop
and NBumi

Tallulah Andrews

October 30, 2025

Introduction

Feature selection is a key step in the analysis of single-cell RNASeq data. Feature
selection aims to identify and remove genes whose expression is dominated by
technical noise, thus reducing the effect of batch-effects and other technical
counfounders while also reducing the curse of dimensionality.

A common way to select features is to identify genes that follow a different
expression distribution than a set of control genes. These control genes may
be spike-ins but more commonly one assumes that the majority of genes don’t
differ from control genes and use all genes to approximate the expression pattern
of expression of controls.

Often the variance relative to the mean expression is used to characterize the
expression distribution of a gene, and feature selection proceeds by identifying
highly variable genes.
In contrast, this package provides two methods which
characterize the expression distribution of a gene using the dropout-rate and
mean expression. This takes advantage of the fact than at least 50% of entries
in a single-cell RNASeq expression matrix are dropouts, and that dropout rate
is less sensitive to sampling errors than variance.

M3Drop

Single-cell RNA sequencing is able to quantify the whole transcriptome from the
small amount of RNA present in individual cells. However, a consequence of
reverse-transcribing and amplifying small quantities of RNA is a large number
of dropouts, genes with zero expression in particular cells. The frequency of
dropout events is strongly non-linearly related to the measured expression levels
of the respective genes. M3Drop posits that these dropouts are due to failures of
reverse transcription, a simple enzyme reaction, thus should be modelled using
the Michaelis-Menten equation as follows:

Pi = 1 −

Si
Si + K

Where Pi is the proportion of cells where gene i dropouts out, Si is the mean
expression of gene i and K is the Michaelis constant. This model fits observed
single-cell RNASeq data which have been sequenced to near saturation (i.e.
>100,000 reads per cell).

1

Note: This model works well for Smartseq2 and other single-cell datasets
that do not use unique molecular identifiers (UMIs). For 10X Chromium data
or other UMI tagged data see the NBumi model below.

We’ll be using a portion of the Deng et al. (2014) dataset in this example.
You can download the R-package containing this data (M3DExampleData) from
Bioconductor using biocLite().

> library(M3Drop)
> library(M3DExampleData)

Prepare Data

The first step is to perform quality control on cells. Any existing tools can be
used for this. Here we will simply remove cells with fewer than 2000 detected
genes.

> counts <- Mmus_example_list$data
> labels <- Mmus_example_list$labels
> total_features <- colSums(counts >= 0)
> counts <- counts[,total_features >= 2000]
> labels <- labels[total_features >= 2000]

The second is to extract and correctly format data for M3Drop. To support
quality control tools in various other single-cell R packages, we have provided a
function to extract appropriate data from objects used by scater, monocle, and
Seurat. This function also removes undetected genes, and if necessary applies a
counts-per-million normalization to raw count data.

> norm <- M3DropConvertData(counts, is.counts=TRUE)

[1] "Removing 18 undetected genes."

M3Drop requires a normalized but not log-transformed expression matrix,
thus the above function can optionally de-log a log2-normalized expression ma-
trix from any normalization method.

> norm <- M3DropConvertData(log2(norm+1), is.log=TRUE, pseudocount=1)

[1] "Removing 0 undetected genes."

Any normalization method which preserves dropouts (i.e zeros) is compatible

with M3Drop.

Feature Selection

Since the Michaelis-Menten equation is convex, averaging across a mixed pop-
ulation forces differentially expressed genes to be shifted to the right of the
Michaelis-Menten curve (Figure 1).

> K <- 49
> S_sim <- 10^seq(from=-3, to=4, by=0.05)
> MM <- 1-S_sim/(K+S_sim)
> plot(S_sim, MM, type="l", lwd=3, xlab="Expression", ylab="Dropout Rate",

2

xlim=c(1,1000))

+
> S1 <- 10; P1 <- 1-S1/(K+S1);
> S2 <- 750; P2 <- 1-S2/(K+S2);
> points(c(S1,S2), c(P1,P2), pch=16, col="grey85", cex=3)
> lines(c(S1, S2), c(P1,P2), lwd=2.5, lty=2, col="grey35")
> mix <- 0.5;
> points(S1*mix+S2*(1-mix), P1*mix+P2*(1-mix), pch=16, col="grey35", cex=3)

Figure 1: Michaelis-Menten is convex which leads to DE genes being outliers
to the right/above the curve.

Feature selection for DE genes are identified by comparing the local K cal-
culated for a specific gene to the global K fitted across all genes using a Z-test
followed by multiple-testing correction. Here we find 1,248 DE genes at 1%
FDR.

> M3Drop_genes <- M3DropFeatureSelection(norm, mt_method="fdr", mt_threshold=0.01)

3

020040060080010000.00.20.40.60.81.0ExpressionDropout RateFigure 2: Differentially expressed genes at 1% FDR (purple).

NBumi

The Michaelis-Menten equation fits full-transcript single-cell RNASeq data well,
but often struggles to fit data tagged with unique molecular identifiers (UMIs).
This is a result of UMI datasets typically not being sequenced to saturation,
thus many dropouts are a result of low sequencing coverage rather than a failure
of reverse transcription.

To account for zeros resulting from insufficient sequencing depth, the M3Drop
packaged includes a depth-adjusted negative binomial model (DANB). DANB
models each observation as a negative binomial distribution with mean propor-
tional to the mean expression of the respective gene and the relative sequencing
depth of the respective cell. The dispersion parameter of the negative bino-
mial is fit to the variance of each gene. The equations for calculating these
parameters are:

Observation specific means:

µij =

(cid:80)
i

tij ∗ (cid:80)

tij

j
tij

(cid:80)
ij

Gene specific dispersion (solved for ri):

(tij − µij)2 =

(cid:88)

j

(µij + riµ2

ij)

(cid:88)

j

4

−20240.00.20.40.60.81.0Dropout Ratelog10(expression)Where µij is the observation specific mean for the negative binomial for the
observed molecule counts, tij of the ith gene in the jth of cell and ri is the
dispersion parameter (the "size" paramter of R’s nbinom functions) for gene i.
Functions relating to the DANB model are tagged with the "NBumi" prefix.
We will continue using the example data despite it not using UMIs for demon-
stration purposes. Similar to M3Drop we have provided a function to extract
the relevant expression matrix from objects used by popular single-cell RNASeq
analysis packages : scater, monocle, and Seurat. This is a separate function
because DANB requires raw counts as opposed to the normalized expression
matrix used by M3Drop.

> count_mat <- NBumiConvertData(Mmus_example_list$data, is.counts=TRUE)

[1] "Removing 18 undetected genes."

This function can also de-log and de-normalize a provided expression matrix,

but raw counts are preferable if they are available.

Next we fit the DANB model to this count matrix, and check it fits the data:

> DANB_fit <- NBumiFitModel(count_mat)
> # Smoothed gene-specific variances
> par(mfrow=c(1,2))
> stats <- NBumiCheckFitFS(count_mat, DANB_fit)
> print(c(stats$gene_error,stats$cell_error))

[1]

16981269 1313367011

Figure 3: Fits of the depth-adjusted negative binomial.

5

04080120020406080100120Gene−specific DropoutsObservedFit4000800012000550060006500700075008000Cell−specific DropoutsObservedExpectedSince this is a full-transcript dataset that we have converted from normalized
values the model doesn’t fit well as can be seen above. We will continue with
this data for demonstration purposes only.

We use a binomial test to evaluable the significance of features under the

DANB model:

> NBDropFS <- NBumiFeatureSelectionCombinedDrop(DANB_fit, method="fdr", qval.thres=0.01, suppress.plot=FALSE)

Dropout-based feature selection using DANB

Figure 4:

Pearson Residuals

Pearson residuals have recently been proposed as an alternative normalization
approach for UMI tagged single-cell RNAseq data. (https://genomebiology.biomedcentral.com/articles/10.1186/s13059-
021-02451-7)

We have added two option for calculating Pearson residuals using the DANB

model presented here:

> pearson1 <- NBumiPearsonResiduals(count_mat, DANB_fit)
> pearson2 <- NBumiPearsonResidualsApprox(count_mat, DANB_fit)

If you have not fit the DANB model to the data, you can run each of these
functions directly on the count matrix alone, and the required model fitting will
In this case the NBumiPearsonResid-
be performed as part of the function.
ualsApprox function will be much quicker since it does not fit the dispersion
parameter of the DANB model, only the mean, and approximates the Pearson
residuals as if the data was Poisson distributed:

6

−2−10123450.00.20.40.60.81.0Dropout Ratelog10(expression)papprox =

xij − muij
muij

√

Where xij is the observed umi counts.
Whereas the NBumiPearsonResiduals function calculates the Pearson resid-

uals using the full DANB model as:

pexact =

(cid:113)

xij − muij

muij +

mu2
ij
ri

√

We do not perform any trimming or clipping of the residuals. To perform
n clipping as per Hafemeister and Satija, simple run the following additional

steps:

> pearson1[pearson1 > sqrt(ncol(count_mat))] <- sqrt(ncol(count_mat))
> pearson1[pearson1 < -sqrt(ncol(count_mat))] <- -1*sqrt(ncol(count_mat))

Other Feature Selection Methods

For comparison purposes we have provided functions for other feature selection
methods, including: BrenneckeGetVariableGenes from Brennecke et al. (2013)
modified to optionally use all genes to fit the function between CV2 and mean
expression. giniFS based on GiniClust (REF) pcaFS based on monocle (REF)
using irlba and sparse-matricies. corFS which uses gene-gene correlations. and
ConsensusFS which uses all the available feature selection methods and takes
the average rank of genes across all methods.

Only the Brennecke highly variable gene method also provides a significance

test and runs in linear time, thus is the only one we will demostrate here.

> HVG <- BrenneckeGetVariableGenes(norm)

7

Brennecke highly variable genes.

Figure 5:

Examining Features and Identifying Subpopula-
tions of Cells

To check that the identified genes are truly differentially expressed we can plot
the normalised expression of the genes across cells.

> heat_out <- M3DropExpressionHeatmap(M3Drop_genes$Gene, norm,
+

cell_labels = labels)

8

average normalized read countsquared coefficient of variation (CV^2)0.010.111010010001041050.1110100Figure 6: Heatmap of expression of M3Drop features.

The heatmap (Figure 6) shows that the genes identified by M3Drop are
differentially expressed across timepoints. Furthermore, it shows that the blas-
tocysts cluster into two different groups based on the expression of these genes.
We can extract these groups and identify marker genes for them as follows:

> cell_populations <- M3DropGetHeatmapClusters(heat_out, k=4, type="cell")
> library("ROCR")
> marker_genes <- M3DropGetMarkers(norm, cell_populations)

The first function cuts the dendrogram from the heatmap to produce k clus-
ters of cells. These labels are stored in cell_populations. The second function
tests all genes as marker genes for the provided clusters.

Marker genes are ranked by the area-under the ROC curve (AUC) for pre-
dicting the population with the highest expression of the gene from the other
groups. Significance is calculated using a Wilcox-rank-sum test. Now we can
examine the marker genes of the two clusters of blastocyst cells more closely.

> head(marker_genes[marker_genes$Group==4,],20)

AUC Group

1600015I10Rik
4933411G11Rik
5033411D12Rik
A530032D15Rik
AA415398
AU015228

1
1
1
1
1
1

pval
4 1.322348e-26
4 3.387992e-25
4 7.122560e-26
4 1.448636e-13
4 3.972292e-20
4 1.276920e-15

9

GSM1112603_early2cell_0r.1_expressionGSM1112610_early2cell_3.2_expressionGSM1112608_early2cell_2.2_expressionGSM1112662_late2cell_9.1_expressionGSM1112660_late2cell_8.1_expressionGSM1112659_late2cell_7.2_expressionGSM1112697_mid2cell_3.2_expressionGSM1112698_mid2cell_4.1_expressionGSM1112701_mid2cell_5.2_expressionGSM1112703_mid2cell_6.2_expressionGSM1112730_midblast_2.11_expressionGSM1112738_midblast_2.2_expressionGSM1112652_earlyblast_4.8_expressionGSM1112629_earlyblast_3.13_expressionGSM1112624_earlyblast_2.7_expressionGSM1112643_earlyblast_4.13_expressionGSM1112638_earlyblast_3.7_expressionGSM1112751_midblast_3.12_expressionGSM1112713_midblast_1.16_expressionGSM1112731_midblast_2.12_expressionGSM1112749_midblast_3.10_expressionGSM1112762_midblast_3.6_expressionGSM1112760_midblast_3.4_expressionGSM1112627_earlyblast_3.10_expressionGSM1112648_earlyblast_4.2_expressionGSM1112614_earlyblast_2.15_expressionGSM1112748_midblast_3.1_expressionGSM1112754_midblast_3.15_expressionGSM1112634_earlyblast_3.2_expressionGSM1112637_earlyblast_3.6_expressionGSM1112745_midblast_2.7_expressionGSM1112741_midblast_2.3_expressionGSM1112733_midblast_2.14_expressionGSM1112714_midblast_1.17_expressionGSM1112725_midblast_1.6_expressionGSM1112718_midblast_1.20_expressionGSM1112710_midblast_1.13_expressionGSM1112706_midblast_1.1_expressionGSM1112716_midblast_1.19_expressionGSM1112639_earlyblast_3.8_expressionGSM1112632_earlyblast_3.16_expressionGSM1112615_earlyblast_2.16_expressionGSM1112739_midblast_2.23_expressionGSM1112734_midblast_2.15_expressionGSM1112644_earlyblast_4.14_expressionMep1bPpp1r14dGin1Cyp51Clic3Trpm6PigzNek6B3gnt5Aqp8Glipr2PepdTpm1Ptgr1Mfge8Serpini1AA415398Gm4340Zscan4dTmem56Slc26a1Gm16381ApomPip5k1aGm5662Atf7ip2Nlrp4aNanos1Mybl1Fam46bFam125bGdap1D6Ertd474eFbxw28Gm971700030J22RikDpf3Spag1Mllt11Mtus2Pgm2l1Cpeb1H1fooTxnipRb1DgkbSt6gal1Hsf5Prox1Dnahc10Txndc2Rfx52900026A02RikFbxw21Speer5−ps1Lsp1Ccdc92Stard5Nceh1Kbtbd8Calr4Eif4e1b2410089E03RikRimklaTtnMis12Emp2GykPcgf1Epn2Aldh18a1Cnot7Arhgap8Ccne1Phc2DeptorGltpd1Specc1lTtll4−2012Z−Scoreearly2cellearlyblastlate2cellmid2cellmidblastAbca13
Bex6
Card6
Dcdc2c
Dnajb9
Dub1a
Fbxo33
Fiz1
Gm10696
Gm10697|Tdpoz5
Gm11544
Gm13040|Gm13043|Gm13057
Gm13040|Gm13057
Gm13078

1
1
1
1
1
1
1
1
1
1
1
1
1
1

4 1.001830e-15
4 6.309915e-23
4 3.483869e-21
4 3.703031e-14
4 1.055742e-13
4 1.400339e-21
4 1.261562e-13
4 1.122001e-13
4 3.108289e-19
4 7.122560e-26
4 5.752433e-19
4 5.547325e-24
4 5.547325e-24
4 1.440336e-13

> marker_genes[rownames(marker_genes)=="Cdx2",]

Cdx2 0.8859793

AUC Group

pval
1 1.286591e-12

This shows that the inner cell mass (ICM) marker Sox2 is one of the top
20 markers for group 4 and that the trophectoderm (TE) marker Cdx2 is a
marker for group 3, suggesting these two clusters coorespond to ICM and TE
cells within each blastocyst.

Comparing to Other Methods

The DANB features look similar to M3Drop though identifies more genes due
to the simplified noise model it uses, which is appropriate for UMI-tagged data
but too permissive for data with high amplifcation noise.

> heat_out <- M3DropExpressionHeatmap(NBDropFS$Gene, norm,
cell_labels = labels)
+

10

Figure 7: Heatmap of expression of DANB features.

The HVG method is more sensitive to lowly expressed genes. In addition,
the quadratic model it uses frequenly over estimates the expected variability of
highly expressed genes. This is in contrast with M3Drop which recognizes the
low information available for lowly expressed genes.

This difference can be seen by comparing the heatmaps for the respective
genes. The highly variable genes contains many more genes exhibiting just noisy
expression, whereas nearly all genes detected by M3Drop are clearly differen-
tially expressed across the different cell populations.

> heat_out <- M3DropExpressionHeatmap(HVG, norm,
+

cell_labels = labels)

11

GSM1112606_early2cell_1.2_expressionGSM1112607_early2cell_2.1_expressionGSM1112608_early2cell_2.2_expressionGSM1112660_late2cell_8.1_expressionGSM1112655_late2cell_5.2_expressionGSM1112662_late2cell_9.1_expressionGSM1112697_mid2cell_3.2_expressionGSM1112698_mid2cell_4.1_expressionGSM1112701_mid2cell_5.2_expressionGSM1112705_mid2cell_7.2_expressionGSM1112628_earlyblast_3.12_expressionGSM1112648_earlyblast_4.2_expressionGSM1112650_earlyblast_4.5_expressionGSM1112748_midblast_3.1_expressionGSM1112751_midblast_3.12_expressionGSM1112630_earlyblast_3.14_expressionGSM1112714_midblast_1.17_expressionGSM1112723_midblast_1.4_expressionGSM1112639_earlyblast_3.8_expressionGSM1112631_earlyblast_3.15_expressionGSM1112642_earlyblast_4.12_expressionGSM1112739_midblast_2.23_expressionGSM1112619_earlyblast_2.22_expressionGSM1112718_midblast_1.20_expressionGSM1112721_midblast_1.24_expressionGSM1112752_midblast_3.13_expressionGSM1112734_midblast_2.15_expressionGSM1112729_midblast_2.10_expressionGSM1112732_midblast_2.13_expressionGSM1112762_midblast_3.6_expressionGSM1112758_midblast_3.23_expressionGSM1112653_earlyblast_4.9_expressionGSM1112761_midblast_3.5_expressionGSM1112759_midblast_3.3_expressionGSM1112731_midblast_2.12_expressionGSM1112632_earlyblast_3.16_expressionGSM1112652_earlyblast_4.8_expressionGSM1112611_earlyblast_2.1_expressionGSM1112626_earlyblast_3.1_expressionGSM1112728_midblast_2.1_expressionGSM1112742_midblast_2.4_expressionGSM1112708_midblast_1.11_expressionGSM1112709_midblast_1.12_expressionGSM1112733_midblast_2.14_expressionGSM1112616_earlyblast_2.17_expressionAlox12bMyh7Podnl1Zfp37Syt81700029J07RikIrs3CidecSlc25a37Rps6ka2Wdr78Sept9Acsl5Slc22a3Mef2cCalr3Kbtbd11CckarMarch3Fam115cLrp12D1Pas1Ankrd22Gramd4XpaEda2r1700113I22RikSt3gal4Folr2PhkbTmem141Rabep2Trim11DolkBtbd2Bcl2l10Bnc2Gm4340Zfp438LbhTmcc3Grip1Pard6gNpas2Fsd1lTrim32Pkp2Usp46Rnf146Bcl2l1Zfp408Smc1bTrim36Socs4Rnf31Frat1Gmeb2PmpcbPhpt1Sall1Gemin4Slc5a11Slc35b2PiguAbi2Ccdc163Terf21700037H04RikRapgef2Zfp318R3hdm2KalrnNle1Thumpd1Exoc3Reps1Dcp1aCdca4Pik3r1Taf12−2012Z−Scoreearly2cellearlyblastlate2cellmid2cellmidblastFigure 8: Heatmap of expression of highly variable genes across cells.

References

Tallulah Andrews, Martin Hemberg. Modelling dropouts allows for unbiased
identification of marker genes in scRNASeq experiments. bioRxiv, 2016. doi:10.1101/065094

Philip Brennecke, Simon Anders, Jong Kyoung Kim, Aleksandra A Kolodziejczyk,

Xiuwei Zhang, Valentina Proserpio, Bianka Baying, Vladimir Benes, Sarah A
Teichmann, John C Marioni and Marcus G Heisler. Accounting for technical
noise in single-cell RNA-seq experiments. Nature Methods, 10:1093-1095, 2013.
doi:10.1038/nmeth.2645, PMID: 24056876

12

GSM1112604_early2cell_0r.2_expressionGSM1112610_early2cell_3.2_expressionGSM1112608_early2cell_2.2_expressionGSM1112657_late2cell_6.2_expressionGSM1112655_late2cell_5.2_expressionGSM1112654_late2cell_5.1_expressionGSM1112696_mid2cell_3.1_expressionGSM1112704_mid2cell_7.1_expressionGSM1112703_mid2cell_6.2_expressionGSM1112695_mid2cell_0r.2_expressionGSM1112730_midblast_2.11_expressionGSM1112738_midblast_2.2_expressionGSM1112653_earlyblast_4.9_expressionGSM1112652_earlyblast_4.8_expressionGSM1112626_earlyblast_3.1_expressionGSM1112629_earlyblast_3.13_expressionGSM1112624_earlyblast_2.7_expressionGSM1112758_midblast_3.23_expressionGSM1112731_midblast_2.12_expressionGSM1112707_midblast_1.10_expressionGSM1112762_midblast_3.6_expressionGSM1112760_midblast_3.4_expressionGSM1112764_midblast_3.8_expressionGSM1112723_midblast_1.4_expressionGSM1112714_midblast_1.17_expressionGSM1112754_midblast_3.15_expressionGSM1112650_earlyblast_4.5_expressionGSM1112722_midblast_1.3_expressionGSM1112614_earlyblast_2.15_expressionGSM1112751_midblast_3.12_expressionGSM1112736_midblast_2.17_expressionGSM1112716_midblast_1.19_expressionGSM1112721_midblast_1.24_expressionGSM1112631_earlyblast_3.15_expressionGSM1112645_earlyblast_4.16_expressionGSM1112615_earlyblast_2.16_expressionGSM1112639_earlyblast_3.8_expressionGSM1112623_earlyblast_2.6_expressionGSM1112728_midblast_2.1_expressionGSM1112747_midblast_2.9_expressionGSM1112752_midblast_3.13_expressionGSM1112636_earlyblast_3.4_expressionGSM1112646_earlyblast_4.17_expressionGSM1112733_midblast_2.14_expressionGSM1112740_midblast_2.24_expression−2012Z−Scoreearly2cellearlyblastlate2cellmid2cellmidblast
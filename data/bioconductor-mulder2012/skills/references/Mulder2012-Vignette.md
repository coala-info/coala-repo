Vignette for Mulder2012 : Diverse epigenetic
strategies interact to control epidermal
diﬀerentiation.

Xin Wang, Mauro A. Castro,
Klaas W. Mulder and Florian Markowetz

November 1, 2018

Contents

1 Introduction

2 Package installation

3

3

3 Application I–Step-by-step analysis

3
4
3.1 Data preprocessing . . . . . . . . . . . . . . . . . . . . . . . .
5
3.2 Beta-mixture modelling . . . . . . . . . . . . . . . . . . . . . .
6
3.3 Enrichment analyses
. . . . . . . . . . . . . . . . . . . . . . .
Incorporating protein-protein interactions . . . . . . . . . . . .
3.4
9
Inferring a posterior association network . . . . . . . . . . . . 11
3.5
. . . . . . . . . . . 13
3.6 Searching for enriched functional modules

4 Application I–pipeline functions

17
4.1 Pipeline function to reproduce data . . . . . . . . . . . . . . . 17
4.2 Pipeline function to reproduce ﬁgures . . . . . . . . . . . . . . 18

5 Application II–Step-by-step analysis

19
5.1 Beta-mixture modelling . . . . . . . . . . . . . . . . . . . . . . 19
Inferring a posterior association network . . . . . . . . . . . . 20
5.2
5.3 Searching for enriched functional modules
. . . . . . . . . . . 23
5.4 Pathway analysis . . . . . . . . . . . . . . . . . . . . . . . . . 25

1

6 Application II–pipeline functions

25
6.1 Pipeline function to reproduce data . . . . . . . . . . . . . . . 27
6.2 Pipeline function to reproduce ﬁgures . . . . . . . . . . . . . . 28

7 Session info

8 References

28

30

2

1

Introduction

The vignette helps the user to reproduce main results and ﬁgures of two
applications of PANs (Posterior Association Networks) in [7]. In the ﬁrst ap-
plication, we predict a network of functional interactions between chromatin
factors regulating epidermal stem cells. In the second application, we identify
a gene module including many conﬁrmed and highly promising therapeutic
targets in Ewing’s sarcoma. Please refer to bioconductor package PANR for
detailed introduction about the methods, on which this package is dependent.
Please also refer to Mulder et al.
[4] for more details
about the biological background, experimental design and data processing of
the ﬁrst and second applications, respectively.

[5] and Arora et al.

2 Package installation

Please run all analyses in this vignette under version 2.14 of R. Prior to
installation of package Mulder2012, R packages HTSanalyzeR, org.Hs.eg.db,
KEGG.db (for enrichment analyses), pvclust (for hierarchical clustering with
bootstrap resampling), RedeR (for network visualization) and PANR (the
method package for inferring a posterior association network) should be in-
stalled. These packages can be installed directly from bioconductor:

install.packages("BiocManager")

> if (!requireNamespace("BiocManager", quietly=TRUE))
+
> BiocManager::install(c("PANR", "RedeR", "pvclust", "HTSanalyzeR",
+ "org.Hs.eg.db", "KEGG.db"))

The ‘snow’ package is recommended to be installed for module searching

by the PANR package more eﬃciently.

3 Application I–Step-by-step analysis

Mulder K. et al. studied the functions of known and predicted chromatin
factors in self-renewal and diﬀerentiation of human epidermal stem cells [5].
To predict interactions between these chromatin factors, we propose poste-
rior association networks (PANs) encoding gene functions on vertices and
their functional associations on edges. Here we introduce step by step the

3

computational workﬂow to perform mixture modelling, infer the functional
network, search for enriched gene modules, etc. starting from RNA interfer-
ence screening data under multiple conditions.

3.1 Data preprocessing

In total, RNAi-based gene silencing was performed on 332 chromatin factors
under ﬁve diﬀerent conditions: vehicle, AG1478, BMP2/7, AG1478 BMP2/7
and serum stimulation. To quantify each gene’s function in epidermal self-
renewal, we measured the endogenous levels of transglutaminase I (TG1)
protein, which is the key enzyme that mediates the assembly of the epidermal
corniﬁed envelope. First, we load the raw screening data:

> library(Mulder2012)
> library(HTSanalyzeR)
> library(PANR)

> data(Mulder2012.rawScreenData, package="Mulder2012")
> dim(rawScreenData)

[1] 680 18

> colnames(rawScreenData)

[1] "PLATE"
[4] "vehicle_1"
[7] "AG1478_1"
[10] "BMP2/7_1"
[13] "AG1478+BMP2/7_1" "AG1478+BMP2/7_2" "AG1478+BMP2/7_3"
"serum10%_2"
[16] "serum10%_1"

"CHANNEL"
"vehicle_3"
"AG1478_3"
"BMP2/7_3"

"WELL"
"vehicle_2"
"AG1478_2"
"BMP2/7_2"

"serum10%_3"

To correct for plate-to-plate variability, the raw screening measurement xT G1
for k-th well in plate i was normalized to DRAQ5 signal xDRAQ5
, which was
used as control, within the plate:

ki

ki

x(cid:48)
ki =

ki − x siT G1
xT G1
i
xDRAQ5
ki

,

(1)

4

where x siT G1
subsequently computed from the normalized data:

denotes the mean of control signals in plate i. Z-scores were

i

zki =

x(cid:48)
ki − µi
δi

(2)

where µi and δi are the mean and standard deviation of all measurements
within the ith plate.

This procedure is realised by function Mulder2012.RNAiPre:

> data(Mulder2012.rawScreenAnnotation, package="Mulder2012")
> Mulder2012<-Mulder2012.RNAiPre(rawScreenData, rawScreenAnnotation)

After the above preprocessing steps, we obtained a 332 (genes) × 15 (3

replicates × 5 conditions) matrix of z-scores.

> dim(Mulder2012)

[1] 332 15

> colnames(Mulder2012)

[1] "vehicle"
[5] "AG1478"
[9] "BMP2/7"
[13] "serum10%"

"vehicle"
"AG1478"
"AG1478+BMP2/7" "AG1478+BMP2/7" "AG1478+BMP2/7"
"serum10%"

"vehicle"
"BMP2/7"

"AG1478"
"BMP2/7"

"serum10%"

3.2 Beta-mixture modelling

Modelling lack of association From the z-score matrix, we compute as-
sociation scores between genes using uncentered correlation coeﬃcients (also
known as cosine similarities). The proposed Beta-mixture model is applied
to quantify the signiﬁcances of these associations. We ﬁrst permuted the
z-score matrix for 100 times, for each of which we compute cosine similarities
and ﬁt a null distribution to the density by maximum likelihood estimation
using the function ﬁtdistr in the R package MASS (Figure 1) [1]. The me-
dian values of the 100 ﬁtted parameters were selected for modelling the (×)
component representing lack of association of the mixture distribution.

The ﬁtting is done by the following codes:

5

> bm_Mulder2012<-new("BetaMixture", pheno=Mulder2012,
+ metric="cosine", order=1, model="global")
> bm_Mulder2012<-fitNULL(bm_Mulder2012, nPerm=100,
+ thetaNULL=c(alphaNULL=4, betaNULL=4), sumMethod="median",
+ permMethod="keepRep", verbose=TRUE)

To inspect the ﬁtting performance, we can compare the density plots of

the permuted screening data and ﬁtted beta distribution:

> view(bm_Mulder2012, what="fitNULL")

Fitting a beta-mixture model to the real RNAi screens Having
ﬁxed the parameters for the component representing lack of associations, we
do MLE to estimate the other parameters of the mixture model using EM
algorithm. This step is conducted by the function ﬁtBM :

> bm_Mulder2012<-fitBM(bm_Mulder2012, para=list(zInit=NULL,
+ thetaInit=c(alphaNeg=2, betaNeg=4,
+ alphaNULL=bm_Mulder2012@result$fitNULL$thetaNULL[["alphaNULL"]],
+ betaNULL=bm_Mulder2012@result$fitNULL$thetaNULL[["betaNULL"]],
+ alphaPos=4, betaPos=2), gamma=NULL),
+ ctrl=list(fitNULL=FALSE, tol=1e-3), verbose=TRUE)

Similarly, we can inspect the mixture modelling results (shown in Figure

2):

> view(bm_Mulder2012, what="fitBM")

Comparing the original histogram of cosine similarities, the ﬁtted three
beta distributions and the mixture of them, we found that the density of co-
sine similarities is successfully partitioned to three components capturing the
population of noise (lack of association) and signal (positive or negative asso-
ciation). The posterior probabilies for each association belonging to diﬀerent
populations in the mixture model were computed subsequently for inference
of the functional network.

3.3 Enrichment analyses

We hypothesize that genes interacting at the protein level may tend to have
higher functional interaction. To test the hypothesis in this application, we

6

Figure 1: Fit a beta distribution to association densities derived
from permutations. The screening data matrix is permuated for 100 times,
and for each permuted data association densities were computed and a beta
distribution was ﬁtted. Each ﬁtting result is plotted as a gray curve. The
median scores of the two shape parameters estimated from permutations were
selected to ﬁx the × component (blue dashed curve).

7

0.00.20.40.60.81.00.00.51.01.5Fitting NULL distributionTransformed cosine similarityDensityFigure 2: Fit a beta-mixture model to association scores computed
from the real screening data. The ﬁtting is conducted based on the EM
algorithm with the shape parameters of the × component ﬁxed by ﬁtting to
permuted screening data. The histogram and the dashed curves show the real
distribution of transformed association scores and the ﬁtting result, respec-
tively. Fitted densities for positive, negative and nonexistent associations are
illustrated by red, blue and green dashed curves, respectively.

8

Beta−Mixture Model Fitting (1)Transformed cosine similarityDensity0.00.20.40.60.81.00.00.20.40.60.81.01.2conducted GSEA (Gene Set Enrichment Analysis) for protein-protein interac-
tions (using PINdb [8]) in the posterior probabilities of associations following
the three diﬀerent components of the beta-mixture model. Not surprisingly,
we observe highly signiﬁcant enrichment of PPIs in the + and - components
(p-values are 0.0067 and 0.0004, respectively) but not in the × component
(p-value=1.0000) (Figure 3). Thus, protein-protein interactions can be po-
tentially incorporated as a priori belief to achieve a better performance.

To run the enrichment analyses:

> PPI<-Mulder2012.PPIPre()
> Mulder2012.PPIenrich(pheno=Mulder2012, PPI=PPI$PPI,
+ bm=bm_Mulder2012)

The enrichment results can be view by:

> labels<-c("A", "B", "C")
> names(labels)<-c("neg", "none", "pos")
> for(i in c("neg", "none", "pos")) {
+ pdf(file=file.path("rslt", paste("fig5", labels[i], ".pdf",sep="")),
+ width=8, height=6)
+ GSEARandomWalkFig(Mulder2012, PPI, bm_Mulder2012, i)
+ graphics.off()
+ }

3.4 Incorporating protein-protein interactions

Here we take the advantage of prior knowledge such as protein-protein inter-
actions to better predict functional connections using the extended model.
Similarly, we ﬁrst ﬁt a null beta distribution to each of 100 permuted data
sets, and used the median values of the ﬁtted parameters to ﬁx the × com-
ponent in the mixture model. According to protein-protein interactions ob-
tained from the PINdb database, we stratiﬁed the whole set of gene pairs
to PPI group and non-PPI group. During the ﬁtting to the extended model
using the EM algorithm, diﬀerent prior probabilities (mixture coeﬃcients)
for the three mixture components were used for these two groups.

> bm_ext<-new("BetaMixture", pheno=Mulder2012,
+ metric="cosine", order=1, model="stratified")

9

Figure 3: Enrichment of protein-protein interactions in posterior
probabilities. (A), (B) and (C) correspond to the enrichment of protein-
protein interactions (PPIs) in the posterior probabilities for associations be-
longing to the +, - and × component, respectively. In each one of the three
ﬁgures, the upper panel shows the ranked phenotypes by a pink curve and
10
the positions of PPIs in the ranked phenotypes, while the lower panel shows
the running sum scores of GSEA (Gene Set Enrichment Analysis) random
walks [3].

ABC0.00.40.80.00.20.40.6Running enrichment score0.00.40.80.00.20.40.60.00.40.8010000200003000040000500000.00.20.40.6p-value=0.0004p-value=1.0000p-value=0.0067> bm_ext<-fitNULL(bm_ext, nPerm=100,
+ thetaNULL=c(alphaNULL=4, betaNULL=4),
+ sumMethod="median", permMethod="keepRep", verbose=TRUE)
> bm_ext<-fitBM(bm_ext, para=list(zInit=NULL,
+ thetaInit=c(alphaNeg=2, betaNeg=4,
+ alphaNULL=bm@result$fitNULL$thetaNULL[["alphaNULL"]],
+ betaNULL=bm@result$fitNULL$thetaNULL[["betaNULL"]],
+ alphaPos=4, betaPos=2), gamma=NULL),
+ ctrl=list(fitNULL=FALSE, tol=1e-3), verbose=TRUE)

As expected, the ﬁtted mixture coeﬃcients of the + and − components for
the PPI group (30.4% and 30.9%) are signiﬁcantly higher than the non-PPI
group (18.2% and 17.9%) (Figure 4). The ﬁtting results suggest that gene
pairs in the PPI group are much more likely to be positively or negatively
associated.

> view(bm_ext, "fitBM")

3.5 Inferring a posterior association network

To infer a posterior association network, we compute signal-to-noise ratios
(SNR), which are posterior odds of gene pairs in favor of signal (association)
to noise (lack of association). Setting the cutoﬀ score for SNR at 10, we
ﬁltered out non-signiﬁcant gene associations and obtain a very sparse func-
tional network (Figure 5). This procedure is accomplished by the following
codes:

> pan_ext<-new("PAN", bm1=bm_ext)
> pan_ext<-infer(pan_ext, para=
+ list(type="SNR", log=TRUE, sign=TRUE,
+ cutoff=log(10)), filter=FALSE, verbose=TRUE)

PAN provides a function buildPAN to build an igraph object for visual-

ization:

> pan_ext<-buildPAN(pan_ext, engine="RedeR",
+ para=list(nodeSumCols=1:3, nodeSumMethod="average",
+ hideNeg=TRUE))

11

Figure 4: Fitting results of the extended beta-mixture model. The
whole set of gene pairs are stratiﬁed to PPI(protein-protein interaction) group
and non-PPI group. The extended beta-mixture model is ﬁtted to func-
tional associations, setting diﬀerent prior probabilities (mixture coeﬃcients)
to these two groups. The ﬁtting results for the PPI group is illustrated in (A),
and the non-PPI group in (B). The histogram and the dashed curves show
the real distribution of transformed association scores and the ﬁtting result,
respectively. Fitted distributions for positive, negative and lack of association
are illustrated by red, blue and green dashed curves, respectively. The ﬁtting
results suggest that gene pairs in the PPI group have higher probability to
be functionally connected than the non-PPI group.

12

Beta−Mixture Model Fitting (0)Transformed cosine similarityDensity0.00.20.40.60.81.00.00.20.40.60.81.01.2Beta−Mixture Model Fitting (1)Transformed cosine similarityDensity0.00.20.40.60.81.00.00.51.01.52.0To view the predicted network in RedeR, we can use the function view-

PAN :

> library(RedeR)
> viewPAN(pan_ext, what="graph")

As shown in Figure 5, the network is naturally splitted to two clusters
consisting of genes with positive and negative perturbation eﬀects, respec-
tively.

3.6 Searching for enriched functional modules

We next conduct second-order hierarchical clustering to search for enriched
functional modules. To assess the uncertainty of the clustering analysis,
we perform multiscale bootstrap resampling (more details in the R package
pvclust [2]).

To make it more eﬃcient, we recommend to use the ‘snow’ package for

parallel computing:

> library(snow)
> ##initiate a cluster
> options(cluster=makeCluster(4, "SOCK"))

Please note that to enable second-order clustering in package pvclust, we
have to modify function dist.pvclust and parPvclust using the following code:

> ns<-getNamespace("pvclust")
> en<-as.environment("package:pvclust")
> assignInNamespace("dist.pvclust", dist.pvclust4PAN,
+ ns="pvclust", envir=ns)
> dist.pvclust<-getFromNamespace("dist.pvclust",
+ ns=getNamespace("pvclust"))
> unlockBinding("parPvclust", ns)
> assignInNamespace("parPvclust", parPvclust4PAN,
+ ns="pvclust", envir=ns)
> lockBinding("parPvclust", ns)
> parPvclust<-getFromNamespace("parPvclust", ns)
> if(is(getOption("cluster"), "cluster") &&
+ "package:snow" %in% search()) {
+ clusterCall(getOption("cluster"), assignInNamespace,

13

Figure 5: Predicted association network of functional interactions.
This ﬁgure presents the predicted signiﬁcant possitive functional interactions
between 158 chromatin factors (SNR>10). Nodes with purple and orange
colors represent positive and negative perturbation eﬀects, respectively. Node
colors are scaled according to their averaged perturbation eﬀects under the
vehicle condition. Node sizes are scaled according to their degrees. Edge
widths are in proportion to log signal-to-noise ratios. Edges are colored in
green representing positive associations between genes.

14

ACACAAIREAKAP1AOF2ARID4AARID4BASH1LASXL1ATAD2ATAD2BATF7IPATF7IP2ATRXBAHCC1BAHD1BAZ1ABAZ1BBAZ2ABAZ2BBPTFBRCA1BRD1BRD2BRD3BRD4BRD7BRD8BRD9BRDTBRPF1BRPF3BRWD1BRWD3C14orf169C2orf60CARM1CBX1CBX2CBX3CBX4CBX5CBX6CBX7CBX8CDY1CDY2ACDYLCDYL2CECR2CHAF1ACHD1CHD2CHD3CHD4CHD5CHD6CHD7CHD8CHD9CREBBPCSNK2BCXXC1CYP11A1DHX9DIDO1DNMT1DNMT3ADNMT3BDOT1LDPF1DPF2DPF3ECAT8EHMT1EHMT2ELP3EP300EP400ERCC6LETV6EZH1EZH2FBXL10FBXL11FBXL19GATAD2AGATAD2BGCN5L2GTF3C4HAT1HDAC1HDAC10HDAC11HDAC2HDAC3HDAC4HDAC5HDAC6HDAC7HDAC8HDAC9HDGFHDGF2HDGFL1HDGFRP3HIF1ANHLTFHRHSPBAP1HTATIPING1ING2ING3ING4ING5INOC1INTS12JARID1AJARID1BJARID1CJARID1DJARID2JHDM1DJMJD1AJMJD1BJMJD1CJMJD2AJMJD2BJMJD2CJMJD2DJMJD3JMJD4JMJD5JMJD6KIAA1045KIAA1333KIAA1542L3MBTLL3MBTL2L3MBTL3L3MBTL4LBRLIN9LOC339123MBD1MBD2MBD3MBD3L1MBD3L2MBD4MBD5MBD6MBTD1MDC1MECP2MGEA5MINAMIZFMLH1MLLMLL2MLL3MLL4MLL5MLLT10MLLT6MORF4L1MPHOSPH8MSH6MSL3L1MST101MTA1MTA2MTA3MTF2MYST1MYST2MYST3MYST4NCOA1NCOA3NFX1N-PACNPTXRNSD1OGTORC1LPBRM1_r1PBRM1_r2PCAFPHF1PHF10PHF11PHF12PHF13PHF14PHF15PHF16PHF17PHF19PHF2PHF20PHF21APHF21BPHF23PHF3PHF6PHF7PHF8PHIPPLA2G4BPRDM1PRDM11PRDM12PRDM13PRDM14PRDM15PRDM16PRDM2PRDM4PRDM5PRDM7PRDM8PRDM9PRG4PRMT1PRMT2PRMT3PRMT5PRMT6PRMT7PRMT8PSIP1PWWP2BPYGO1PYGO2RAD54BRAD54LRAI1RARARBBP4RBBP7RERERNF17RNMTRNMTL1RSF1SCMH1SCML2SETD1ASETD2SETD3SETD4SETD5SETD6SETD7SETD8SETDB1SETDB2SETMARSFMBT1SFMBT2SHMT2SHPRHSIN3ASIRT1SIRT2SIRT3SIRT4SIRT5SIRT6SIRT7SMARCA1SMARCA2SMARCA4SMARCA5SMARCAL1SMARCC1SMARCC2SMNDC1SMYD1SMYD2SMYD3SMYD4SMYD5SND1SP100SP110SP140SPENSTK31SUPT7LSUV39H1SUV39H2SUV420H1SUV420H2TAF1TAF1LTAF3TARBP1TCF19TCF20TDRD1TDRD10TDRD3TDRD5TDRD6TDRD7TDRD9TDRKHTERF2IPTHUMPD2TNRC18TP53BP1TRDMT1TRIM24TRIM28TRIM33TRIM66TRMT11TTF2UHRF1UHRF2UTXUTYWHSC1WHSC1L1XRCC1ZCWPW1ZCWPW2ZMYND11ZMYND8+ x="dist.pvclust", value=dist.pvclust4PAN, ns=ns)
+ clusterCall(getOption("cluster"), unlockBinding,
+ sym="parPvclust", env=ns)
+ clusterCall(getOption("cluster"), assignInNamespace,
+ x="parPvclust", value=parPvclust4PAN, ns=ns)
+ clusterCall(getOption("cluster"), lockBinding,
+ sym="parPvclust", env=ns)
+ }

> pan_ext<-pvclustModule(pan=pan_ext, nboot=10000,
+ metric="cosine2", hclustMethod="average", filter=FALSE)
> ##stop the cluster
> stopCluster(getOption("cluster"))
> options(cluster=NULL)

In the code above, please ensure that the name of the cluster is ‘cluster’,

as it will be recognized inside the ‘PANR’ package.

With 10,000 times’ resampling we obtained 39 signiﬁcant clusters (p-
value < 0.05) including more than three genes. Mapping these gene clusters
to the inferred functional network, we identiﬁed 13 tightly connected modules
(density > 0.5). To view these modules in a compact way (Figure 6), the
user can use the following function:

’

’

MyPort

> rdp <- RedPort(
> calld(rdp)
> Mulder2012.module.visualize(rdp, pan_ext, mod.pval.cutoff=0.05,
+ mod.size.cutoff=4, avg.degree.cutoff=0.5)

)

Among these modules the one cosisting of ING5, UHRF1, EZH2, SMARCA5,
BPTF, SMARCC2 and PRMT1 is of particular interest, as it indicates a
functional connection between BPTF, EZH2, NURF and MORF complexes,
which have been independently implicated in epidermal self-renewal. Further
combinatorial knock-down experiments validated many genetic interactions
between ING5, BPTF, SMARCA5, EZH2 and UHRF1. These biological
validations demonstrate the power of the proposed integrative computational
approach for predicting association networks of functional gene interactions
and searching for enriched gene modules.

15

Figure 6: Top signiﬁcant modules predicted by PANs . Nodes with
purple colors represent positive perturbation eﬀects. Node colors are scaled
according to their averaged perturbation eﬀects under the vehicle condition.
Node sizes are scaled in proportion to their degrees. Edge widths are in
proportion to log signal-to-noise ratios. Edges colored in green and grey
represent positive interactions inside modules and summed interactions be-
tween modules, respectively. This ﬁgure illustrates top signiﬁcant modules
and their dense functional interactions. Genes colored in red were selected
for further experimental investigation.

16

Loss of function0.0000.0121.0051.9982.9913.9844.9775.9706.9637.9568.9499.942Node degree49141924293437Log(SNR)2.302.502.692.893.093.283.483.673.874.06p-value: 0.008p-value: 0.025p-value: 0.032p-value: 0.037p-value: 0.006p-value: 0.041p-value: 0.009p-value: 0.028p-value: 0.024EZH2PRMT1BPTFBRD1ING5SMARCA5SMARCC2UHRF1BRWD1DPF2BAZ2ABAZ2BCBX8MYST1PBRM1ELP3CBX5ATRXDOT1LJMJD4MYST4PHF17SHPRHARID4AEHMT1HDAC10PBRM1PRG4STK31CECR2MTA3PHF14SETD5TAF1L4 Application I–pipeline functions

We provide two pipeline functions for reproducing all the data and ﬁgures.
Please note that to enable second-order hierarchical clustering in pvclust,
function dist.pvclust and parPvclust must be modiﬁed using the code de-
scribed in section 3.6.

4.1 Pipeline function to reproduce data

All data can be recomputed by a pipeline function Mulder2011.pipeline:

> Mulder2012.pipeline(
+ par4BM=list(model="global", metric="cosine", nPerm=20),
+ par4PAN=list(type="SNR", log=TRUE, sign=TRUE,
+ cutoff=log(10), filter=FALSE),
+ par4ModuleSearch=list(nboot=10000, metric="cosine2",
+ hclustMethod="average", filter=FALSE)
+ )

This pipeline includes the following analysis procedures:

(cid:136) Data pre-processing including computing z-scores from the raw RNAi
screening data and extracting protein-protein interaction information
from the PINdb database [8] (details in section 3.1).

(cid:136) Fitting a beta distribution to association densities computed from per-
muted screening data. The ﬁtted shape parameters will be used to
model the component representing lack of association in the beta-
mixture model (details in section 3.2).

(cid:136) Fitting a beta-mixture model to association scores computed from the

real screening data (details in section 3.2).

(cid:136) Enrichment analyses of posterior probabilities of gene pairs belonging to
a positive, negative or lack of association in protein-protein interactions
in the nucleus (details in section 3.3).

(cid:136) Fitting a stratiﬁed beta-mixture model to incorporate protein-protein

interactions (details in section 3.4).

17

(cid:136) Inferring an association network of functional interactions between chro-
matin factors based on the beta-mixture modelling results (details in
section 3.5).

(cid:136) Searching for signiﬁcant gene modules based on hierarchical clustering

with multiscale resampling (details in section 3.6).

4.2 Pipeline function to reproduce ﬁgures

All ﬁgures can be regenerated, some of which need manual improvement,
using the following function:

> Mulder2012.fig(what="ALL")

in which what speciﬁes which ﬁgure to generate:

(cid:136) ‘NULLﬁtting’ (Fig. 4A in [7]): density curves of transformed cosine
similarities computed from permuted screening data and ﬁtted beta
distribution. This ﬁgure can be used to assess the ﬁtting of the ×
component in the beta-mixture model.

(cid:136) ‘BMﬁtting’ (Fig. 4B in [7]): a histogram of transformed cosine sim-
ilarities computed from the real screening data, ﬁtted beta-mixture
distribution as well as mixture coeﬃcient weighted beta distributions
ﬁtted for the three components. This ﬁgure is also used for assessing
the ﬁtting of the beta-mixture model to screening data.

(cid:136) ‘PPIenrich’ (Fig. 5 in [7]): ﬁgures of the enrichment analyses results.
Each ﬁgure shows the positions of the protein-protein interactions in the
ranked phenotypes (posterior probabilities) and the running enrichment
scores.

(cid:136) ‘sigMod’ (Fig.

7 in [7]): a ﬁgure of top signiﬁcant gene modules

searched by multiscale bootstrap resampling analyses using pvclust.

(cid:136) ‘selMod’ (Fig. 8A in [7]): a ﬁgure of the module selected for further

validation using combinatorial knock-down experiments.

18

5 Application II–Step-by-step analysis

In this application, we use RNAi phenotyping screens across multiple cell
lines to infer functional modules of kinases that are critical for growth and
proliferation of Ewing’s sarcoma. We demonstrate that our model can make
eﬃcient use of single gene perturbation data to predict robust functional
interactions. The data used in this case study is a matrix (572 × 8) of Z-
scores from high throughput RNAi screens run in duplicates targeting 572
human kinases in four Ewing’s sarcoma cell lines: TC-32, TC-71, SK-ES-1
and RD-ES [4]. In these phenotyping screens, viability was assessed using a
luminescence-based cell to quantify each gene’s function in cancer cell growth
and proliferation. The screening data was corrected for plate row variations
and normalized using Z-score method as described in [4]. Compared to other
RNAi screens in normal human ﬁbroblast cell line, the four Ewing’s sarcoma
cell lines exhibited signiﬁcant similarities, suggesting robust and consistent
functional interactions among perturbed genes across cell lines [4].

We ﬁrst load the screening data:

> data(Arora2010, package="Mulder2012")
> dim(Arora2010)

[1] 572

8

> colnames(Arora2010)

[1] "TC-32"
[7] "RD-ES"

"TC-32"
"RD-ES"

"TC-71"

"TC-71"

"SK-ES-1" "SK-ES-1"

5.1 Beta-mixture modelling

To predict the functional interactions between genes, a beta-mixture model
was applied to quantify the signiﬁcance of their associations, which are mea-
sured by cosine similarities computed from the Z-score matrix. We ﬁrst per-
muted the Z-score matrix 20 times, computing cosine similarities and ﬁtting
a null distribution by maximum likelihood estimation (Figure 7). The me-
dian values of the 20 ﬁtted parameters were selected to ﬁx the × component
representing lack of association in the mixture model.

19

> bm_Arora2010<-new("BetaMixture", pheno=Arora2010,
+ metric="cosine", order=1, model="global")
> bm_Arora2010<-fitNULL(bm_Arora2010, nPerm=20,
+ thetaNULL=c(alphaNULL=4, betaNULL=4), sumMethod="median",
+ permMethod="keepRep", verbose=TRUE)

> view(bm_Arora2010, what="fitNULL")

Having ﬁxed the parameters for the × component, we performed MAP
inference with an uninformative prior (uniform Dirichlet priors) to estimate
the other parameters of the global mixture model using the EM algorithm.

> bm_Arora2010<-fitBM(bm_Arora2010, para=list(zInit=NULL,
+ thetaInit=c(alphaNeg=2, betaNeg=4,
+ alphaNULL=bm_Arora2010@result$fitNULL$thetaNULL[["alphaNULL"]],
+ betaNULL=bm_Arora2010@result$fitNULL$thetaNULL[["betaNULL"]],
+ alphaPos=4, betaPos=2), gamma=NULL),
+ ctrl=list(fitNULL=FALSE, tol=1e-3), verbose=TRUE)

Comparing the original histogram of cosine similarities, the ﬁtted three
beta distributions and the mixture of them (Figure 8), we found that the
distribution of cosine similarities is successfully partitioned to three compo-
nents capturing the population of signal (positive or negative association)
and noise (lack of association).

> view(bm_Arora2010, what="fitBM")

The posterior probabilities for each association belonging to diﬀerent pop-
ulations in the mixture model were computed subsequently for inference of
the functional network.

5.2 Inferring a posterior association network

Having ﬁtted the global mixture model to data successfully, we inferred a
network of functional interactions between kinases based on the proposed
edge inference approach. Setting the cutoﬀ SNR score at 10, we ﬁltered out
non-signiﬁcant edges and obtained a very sparse network. This procedure is
accomplished by the following codes:

20

Figure 7: Fit a beta distribution to association densities derived
from permutations. The screening data matrix is permuated for 20 times,
and for each permuted data association densities were computed and a beta
distribution was ﬁtted. Each ﬁtting result is plotted as a gray curve. The
median scores of the two shape parameters estimated from permutations were
selected to ﬁx the × component (blue dashed curve).

21

0.00.20.40.60.81.00.00.20.40.60.81.01.2Fitting NULL distributionTransformed cosine similarityDensityFigure 8: Fit a beta-mixture model to association densities derived
from the real screening data. The ﬁtting is conducted based on the EM
algorithm with the shape parameters of the × component ﬁxed by ﬁtting to
permuted screening data. The histogram and the dashed curves show the real
distribution of transformed association scores and the ﬁtting result, respec-
tively. Fitted densities for positive, negative and nonexistent associations are
illustrated by red, blue and green dashed curves, respectively.

22

Beta−Mixture Model Fitting (1)Transformed cosine similarityDensity0.00.20.40.60.81.00.00.51.01.52.0> pan_Arora2010<-new("PAN", bm1=bm_Arora2010)
> pan_Arora2010<-infer(pan_Arora2010, para=
+ list(type="SNR", log=TRUE, sign=TRUE,
+ cutoff=log(10)), filter=FALSE, verbose=TRUE)

PAN provides a function buildPAN to build an igraph object for visual-

ization:

> pan_Arora2010<-buildPAN(pan_Arora2010, engine="RedeR",
+ para=list(nodeSumCols=1:2, nodeSumMethod="average",
+ hideNeg=TRUE))

To view the predicted network in RedeR, we can use the function view-

PAN :

> viewPAN(pan_Arora2010, what="graph")

As shown in Figure 9, the network is naturally splitted to two clusters
consisting of genes with positive and negative perturbation eﬀects, respec-
tively.

5.3 Searching for enriched functional modules

Hierarchical clustering with multiscale bootstrap resampling was conducted
subsequently using the R package pvclust [2]. With 10000 times’ resampling,
we obtained 65 signiﬁcant (p-value < 0.05) clusters with more than four
genes. Of all these signiﬁcant clusters, 30 clusters are enriched for functional
interactions (module density > 0.5).

> library(snow)
> ##initiate a cluster
> options(cluster=makeCluster(4, "SOCK"))
> pan_Arora2010<-pvclustModule(pan_Arora2010, nboot=10000,
+ metric="consine2", hclustMethod="average", filter=TRUE,
+ verbose=TRUE, r=c(6:12/8))
> ##stop the cluster
> stopCluster(getOption("cluster"))
> options(cluster=NULL)

These clusters are superimposed to predicted posterior association networks
to build functional modules. To visualize these modules in RedeR (Figure
10):

23

Figure 9: Predicted association network of functional interactions.
This ﬁgure presents the predicted signiﬁcant possitive functional interactions
between 158 chromatin factors (SNR>10). Nodes with purple and orange
colors represent positive and negative perturbation eﬀects, respectively. Node
colors are scaled according to their averaged perturbation eﬀects under the
vehicle condition. Node sizes are scaled according to their degrees. Edge
widths are in proportion to log signal-to-noise ratios. Edges are colored in
green representing positive associations between genes.

24

AAK1AATKABL1ABL2ACVR1ACVR1BACVR2ACVRL1ADCK1ADCK2ADCK4ADCK5ADKADRBK1ADRBK2AK1AK2AK3AK3L1AK5AK7AKAP1AKAP11AKAP12AKAP13AKAP28AKAP3AKAP4AKAP5AKAP6AKAP7AKAP8AKAP8LAKAP9AKIPAKT1AKT2AKT3ALS2CR2ALS2CR7ANKK1ANKRD3APEG1ARAFARK5ASKATMATRAURKBAURKCAXLBCKDKBCRBMP2KBMPR1ABMPR1BBMPR2BMXBUB1BUB1BCALM1CALM2CALM3CAMK1CAMK1DCAMK1GCAMK2DCAMK2GCAMK4CaMKIINalphaCAMKK1CAMKK2CARKLCASKCDC2CDC2L1CDC2L5CDC42BPACDC42BPBCDK11CDK2CDK3CDK4CDK5CDK5R1CDK5R2CDK6CDK7CDK9CDKL1CDKL2CDKL3CDKL5CDKN1ACDKN1BCDKN1CCDKN2ACDKN2BCDKN2CCDKN2DCERKCHEK1CHEK2CHKCHUKCIB3CINPCITCKBCKMCKMT1CKS1BCKS2CLK2CLK3CNKSR1CRK7CSKCSNK1A1CSNK1A1LCSNK1DCSNK1ECSNK1G1CSNK1G2CSNK1G3CSNK2A1CSNK2A2CSNK2BDAPK1DAPK2DAPK3DCAMKL1DCKDDR1DDR2DGKADGKBDGKDDGKGDGKQDGKZDGUOKDMPKDTYMKDYRK1ADYRK1BDYRK3DYRK4EEF2KEGFREIF2AK2EIF2AK3EIF2AK4EKI1EPHA1EPHA2EPHA3EPHA4EPHA5EPHA7EPHA8EPHB1EPHB2EPHB3EPHB4EPHB6ERBB2ERBB3ERBB4ERK8ERN1FASTKFERFESFGFR1FGFR2FGFR3FGFR4FLJ11149FLJ13052FLT1FLT3FLT3LGFLT4FN3KFRKFUKFYNGAKGIT1GIT2GKGKAP42GNEGRK4GRK5GRK6GSK3AGSK3BGUK1HAKHCKHGSHIPK1HIPK2HIPK3HK1HK2HK3HSMDPKINHSPB8HUNKIBTKICKIHPK1IHPK2IHPK3IKBKAPIKBKEIKBKGILKILKAPIRAK1IRAK2IRAK3IRAK4ITKITPK1ITPKAITPKBITPKCJAK1JAK2JAK3KDRKHKKIAA1446KIAA1804KIDINS220KIP2KISKITKSRKSR2LATS1LATS2LIMLIMK1LIMK2LMTK2LOC161635LOC375449LOC388226LOC55971LOC91807LTKLYK5LYNMADDMAGI1MAGI-3MAKMAP2K1MAP2K1IP1MAP2K2MAP2K3MAP2K4MAP2K5MAP2K6MAP2K7MAP3K1MAP3K10MAP3K11MAP3K13MAP3K2MAP3K3MAP3K4MAP3K5MAP3K6MAP3K7MAP3K7IP1MAP3K7IP2MAP3K9MAP4K1MAP4K2MAP4K3MAP4K4MAP4K5MAPK1MAPK10MAPK11MAPK12MAPK13MAPK14MAPK3MAPK4MAPK6MAPK7MAPK8MAPK8IP1MAPK8IP2MAPK9MAPKAP1MAPKAPK2MAPKAPK3MAPKBP1MARCKSMARK1MARK2MARK3MARK4MAST1MAST2MATKMELKMERTKMETMGC4796MKNK1MKNK2MK-STYXMOSMST1RMST4MVKMYLKMYLK2NAGKNEK1NEK11NEK2NEK3NEK4NEK6NEK7NEK8NEK9NIPANJMU-R1NLKNME1NME2NME3NME4NME5NME6NME7NRBPNRGNNTRK3NUCKSNYD-SP25PACSIN2PACSIN3PAK1PAK2PAK3PAK4PAK7PANK1PANK2PANK3PANK4PASKPBKPCTK1PCTK2PCTK3PDGFRAPDGFRBPDIK1LPDK1PDK2PDK3PDK4PDPK1PDXKPFKFB2PFKFB3PFKMPFTK1PGK1PHKA1PHKA2PHKBPHKG1PHKG2PI4K2BPI4KIIPIK3AP1PIK3C2APIK3C2BPIK3C2GPIK3C3PIK3CAPIK3CBPIK3CDPIK3CGPIK3R1PIK3R2PIK3R3PIK3R4PIK4CBPIM1PIM2PINK1PIP5K1APIP5K1BPIP5K1CPIP5K2APIP5K2BPIP5K2CPIP5K3PKEPKIAPKIBPKIGPKLRPKM2PKMYT1PLK1PLK2PLK3PLK4PMVKPNCKPNKPPRKAA1PRKAB1PRKAB2PRKACAPRKACBPRKACGPRKAG1PRKAG2PRKAG3PRKAR1APRKAR2APRKAR2BPRKCAPRKCABPPRKCB1PRKCBP1PRKCDPRKCDBPPRKCEPRKCHPRKCIPRKCL1PRKCL2PRKCNPRKCQPRKCZPRKD2PRKDCPRKG2PRKRAPRKRIRPRKXPRKYPRPF4BPSKH1PSKH2PTK2PTK2BPTK7PTK9PTK9LPXKRAF1RAGERBKSRETRIOK1RIOK2RIOK3RIPK1RIPK2ROCK1ROCK2ROR1ROR2ROS1RPS6KA1RPS6KA2RPS6KA3RPS6KA4RPS6KA5RPS6KA6RPS6KB2RPS6KC1RPS6KL1RYKSGKSGK2SGKLSH3KBP1SKP2SLKSMG1SNARKSNF1LKSNF1LK2SNRKSPEC2SPHK1SPHK2SRCSRPK1SRPK2STK10STK11STK11IPSTK16STK17ASTK17BSTK19STK22BSTK22DSTK24STK25STK29STK3STK31STK32BSTK33STK38STK38LSTK39STK4STK6SYKTAO1TAOK3TBK1TECTEKTESK1TESK2TGFBR1TGFBR2TK1TK2TLK1TNIKTNK1TNK2TNNI3KTPK1TRADTSKSTTBK1TTBK2TTKTYK2TYRO3UCK1UGP2ULK1ULK2UMP-CMPUMPKURKL1VRK1VRK2VRK3WNK1WNK3WNK4XYLBYES1ZAK’

’

MyPort

> rdp <- RedPort(
> calld(rdp)
> Arora2010.module.visualize(rdp, pan_Arora2010, mod.pval.cutoff=
+ 0.05, mod.size.cutoff=4, avg.degree.cutoff=0.5)

)

5.4 Pathway analysis

Previous RNAi screening studies such as [4] were dedicated to discovering sin-
gle genes that are pivotal for inhibiting Ewing’s sarcoma. In our predictions,
genes in the module are densely connected with highly siginiﬁcant functional
interactions, indicating possible genetic interactions may exist among them.
If the hypothesis is true, these genes may be involved in the same biological
processes. Focusing on genes in the second module, we further searched for
kinase pathways in which they are enriched. Hypergeometric tests were per-
formed on all genes in this module to test their overrepresentation in KEGG
pathways using R package HTSanalyzeR [6]. In total, we identiﬁed 15 signif-
icant KEGG pathways (Benjamini-Hochberg adjusted p-value < 0.05) with
more than two observed hits (Figure 11).

> pw.Arora2010<-Arora2010.hypergeo(pan_Arora2010, mod.pval.cutoff=0.05,
+ mod.size.cutoff=4, avg.degree.cutoff=0.5)
> pw.Arora2010<-pw.Arora2010[[1]]
> obs.exp<-as.numeric(pw.Arora2010[, 4])
> names(obs.exp)<-paste(as.character(pw.Arora2010[, 6]), " (",
+ format(pw.Arora2010[, 5], scientific=TRUE, digits=3), ")", sep="")
> par(mar=c(4, 16, 1, 1), cex=0.8)
> barplot((obs.exp), horiz=TRUE, las=2, xlab="Observed/Expected Hits",
+ cex.axis=0.8)

6 Application II–pipeline functions

Similar to the ﬁrst application, we provide two pipeline functions to repro-
duce all results and ﬁgures. Please note again that to enable second-order
hierarchical clustering in pvclust, function dist.pvclust and parPvclust must
be modiﬁed using the code described in section 3.6.

25

Figure 10: Top signiﬁcant modules predicted by PANs in Ewing’s
sarcoma. The signiﬁcant modules predicted by PAN are presented in a
nested structure. Each module is illustrated by a rounded rectangle includ-
ing sub-modules and/or individual genes. The p-value (on the top of each
module) computed by pvclust indicates the stability of genes being clustered
together. PRCKA (the gene colored in purple) is known to be a kinase target
for human sarcomas, and an inhibitor PKC412 targeting PRCKA has already
been tested in the clinic. STK10 and TNK2 (colored in red) in the upper
left module have been identiﬁed as potential therapeutic targets. Another
eight genes (colored in yellow) in the upper left and right modules were also
highly associated with apoptosis of Ewing’s sarcoma.

26

p-value: 0.033p-value: 0.002p-value: 0.001p-value: 0.028p-value: 0.035p-value: 0.003p-value: 0.004p-value: 0.021p-value: 0.001MAP2K1MAP2K2MAPK12NEK9PTK9STK11BMPR1BHK1STK10TAOK3TK2AKAP9FLT3GRK5LOC55971PKMYT1TNK2UCK1NME7CDK5R2GAKNAGKPRKCAPXKTSKSALS2CR7DAPK2ERBB2FGFR4MAPK11PHKA2CASKEPHB6IKBKGMAP4K4PDPK1CSNK1DDYRK1BPTK7SNF1LKTK1Figure 11: Signiﬁcantly overrepresented KEGG pathways. Hyperge-
ometric tests were performed to evaluate overrepresentation of genes included
in the upper right module in human KEGG pathways. Top signiﬁcant path-
ways (p-value < 0.05) are ranked by p-value increasingly, and their corre-
sponding ratios of the number of observed hits to expected hits are illustrated
by a bar plot.

6.1 Pipeline function to reproduce data

All data can be recomputed by a pipeline function Arora2010.pipeline:

> Arora2010.pipeline(
+ par4BM=list(model="global", metric="cosine", nPerm=20),
+ par4PAN=list(type="SNR", log=TRUE, sign=TRUE,
+ cutoff=log(10), filter=FALSE),
+ par4ModuleSearch=list(nboot=10000, metric="cosine2",
+ hclustMethod="average", filter=FALSE)
+ )

This pipeline includes the following analysis procedures:
(cid:136) Fitting a beta distribution to association scores computed from per-
muted screening data. The ﬁtted shape parameters will be used to
model the × component in the beta-mixture model (details in section
5.1).

(cid:136) Fitting a beta-mixture model to association scores computed from the

real screening data (details in section 5.1).

27

MAPK signaling pathway  (4.48e−02)ErbB signaling pathway  (3.92e−02)T cell receptor signaling pathway  (3.03e−02)Toll−like receptor signaling pathway  (2.61e−02)Glioma  (2.04e−02)Non−small cell lung cancer  (1.05e−02)Vascular smooth muscle contraction  (8.10e−03)Long−term potentiation  (7.38e−03)GnRH signaling pathway  (6.46e−03)Fc epsilon RI signaling pathway  (6.46e−03)Gap junction  (6.46e−03)Natural killer cell mediated cytotoxicity  (6.46e−03)Melanogenesis  (6.46e−03)VEGF signaling pathway  (4.67e−03)Long−term depression  (1.79e−03)Observed/Expected Hits02468101214(cid:136) Inferring a posterior association network for Ewing’s sarcoma based on

the beta-mixture modelling results (details in section 5.2).

(cid:136) Searching for signiﬁcant functional modules based on hierarchical clus-

tering with multiscale resampling (details in section 5.3).

(cid:136) Performing hypergeometric tests to evaluate overrepresentation of genes
included in the module of interest in human KEGG pathways (details
in section 5.4).

6.2 Pipeline function to reproduce ﬁgures

Most ﬁgures can be regenerated using the following function:

> Arora.fig(what="ALL")

in which what speciﬁes which ﬁgure to generate:

(cid:136) ‘NULLﬁtting’ (Fig. 3A in [7]): density curves of transformed cosine
similarities computed from permuted screening data and ﬁtted beta
distribution. This ﬁgure can be used to assess the ﬁtting of the ×
component in the beta-mixture model.

(cid:136) ‘BMﬁtting’ (Fig. 3B in [7]): a histogram of transformed cosine sim-
ilarities computed from the real screening data, ﬁtted beta-mixture
distribution as well as mixture coeﬃcient weighted beta distributions
ﬁtted for the three components. This ﬁgure is also used for assessing
the ﬁtting of beta-mixture model to screening data.

(cid:136) ‘sigMod’ (Fig. 3C in [7]): a ﬁgure of top signiﬁcant gene modules iden-
tiﬁed by hierarchical clustering with multiscale bootstrap resampling
using pvclust.

(cid:136) ‘pathway’ (Fig. 3D in [7]): a ﬁgure illustrating signiﬁcantly overrepre-

sented KEGG pathways.

7 Session info

This document was produced using:

28

> toLatex(sessionInfo())

(cid:136) R version 3.5.1 Patched (2018-07-12 r74967), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C,

LC_TIME=en_US.UTF-8, LC_COLLATE=C, LC_MONETARY=en_US.UTF-8,
LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.5 LTS

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

(cid:136) LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, methods, parallel,

stats, stats4, utils

(cid:136) Other packages: AnnotationDbi 1.44.0, Biobase 2.42.0,

BiocGenerics 0.28.0, HTSanalyzeR 2.34.0, IRanges 2.16.0,
KEGG.db 3.2.3, Mulder2012 0.22.0, PANR 1.28.0, S4Vectors 0.20.0,
igraph 1.2.2, org.Hs.eg.db 3.7.0

(cid:136) Loaded via a namespace (and not attached): BioNet 1.42.0,

BiocManager 1.30.3, Category 2.48.0, DBI 1.0.0, DEoptimR 1.0-8,
GSEABase 1.44.0, MASS 7.3-51, Matrix 1.2-14, R6 2.3.0,
RBGL 1.58.0, RColorBrewer 1.1-2, RCurl 1.95-4.11, RSQLite 2.1.1,
RankProd 3.8.0, Rcpp 0.12.19, RedeR 1.30.0, Rmpfr 0.7-1,
XML 3.98-1.16, aﬀy 1.60.0, aﬀyio 1.52.0, annotate 1.60.0,
assertthat 0.2.0, bindr 0.1.1, bindrcpp 0.2.2, biomaRt 2.38.0,
bit 1.1-14, bit64 0.9-7, bitops 1.0-6, blob 1.1.1, cellHTS2 2.46.0,
cluster 2.0.7-1, colorspace 1.3-2, compiler 3.5.1, crayon 1.3.4,
digest 0.6.18, dplyr 0.7.7, geneﬁlter 1.64.0, ggplot2 3.1.0, glue 1.3.0,
gmp 0.5-13.2, graph 1.60.0, grid 3.5.1, gtable 0.2.0, hms 0.4.2,
httr 1.3.1, hwriter 1.3.2, lattice 0.20-35, lazyeval 0.2.1, limma 3.38.0,
locﬁt 1.5-9.1, magrittr 1.5, memoise 1.1.0, munsell 0.5.0,
mvtnorm 1.0-8, pcaPP 1.9-73, pillar 1.3.0, pkgconﬁg 2.0.2, plyr 1.8.4,

29

prada 1.58.0, preprocessCore 1.44.0, prettyunits 1.0.2, progress 1.2.0,
purrr 0.2.5, pvclust 2.0-0, rlang 0.3.0.1, robustbase 0.93-3, rrcov 1.4-4,
scales 1.0.0, splines 3.5.1, splots 1.48.0, stringi 1.2.4, stringr 1.3.1,
survival 2.43-1, tibble 1.4.2, tidyselect 0.2.5, tools 3.5.1, vsn 3.50.0,
xtable 1.8-3, zlibbioc 1.28.0

8 References

[1] W. N. Venables and B. D. Ripley (2002). Modern Applied Statistics with

S (Fourth edition). Springer , ISBN 0-387-95457-0. 5

[2] Suzuki, R. and Shimodaira, H. (2006). Pvclust: an R package for assessing
the uncertainty in hierarchical clustering. Bioinformatics, 22(12), 1540.
13, 23

[3] Subramanian, A. and Tamayo, P. et al. (2005). Gene set enrichment
analysis: a knowledge-based approach for interpreting genome-wide ex-
pression proﬁles. PNAS , 102(43), 15545. 10

[4] Arora, S. and Gonzales, I.M. and Hagelstrom, R.T. and Beaudry, C. and
Choudhary, A. and Sima, C. and Tibes, R. and Mousses, S. and Azorsa,
D.O. and others (2010). RNAi phenotype proﬁling of kinases identiﬁes
potential therapeutic targets in Ewing’s sarcoma. Molecular Cancer , 9(1),
218. 3, 19, 25

[5] Klaas W. Mulder, Xin Wang, Carles Escriu, Yoko Ito, Roland F. Schwarz,
Jesse Gillis, Gabor Sirokmany, Giacomo Donati, Santiago Uribe-Lewis,
Paul Pavlidis, Adele Murrell, Florian Markowetz and Fiona M. Watt
(2012). Diverse epigenetic strategies interact to control epidermal diﬀer-
entiation. doi:10.1038/ncb2520 . 3

[6] Wang, X. and Terfve, C. and Rose, J.C. and Markowetz, F. (2011). HT-
SanalyzeR: an R/Bioconductor package for integrated network analysis
of high-throughput screens. Bioinformatics, 27(6), 879–880. 25

30

[7] Wang, X. and Castro, M.A. and Mulder, K. and Markowetz, F. (2012).
Posterior association networks and functional modules inferred from rich
phenotypes of gene perturbations. doi:10.1371/journal.pcbi.1002566 . 3,
18, 28

[8] Luc PV and Tempst P (2004). PINdb: a database of nuclear protein
complexes from human and yeast. Bioinformatics, 20(9), 1413. 9, 17

[9] Eisen, M.B. and Spellman, P.T. and Brown, P.O. and Botstein, D. (1998).
Cluster analysis and display of genome-wide expression patterns. Proceed-
ings of the National Academy of Sciences, 95(25), 14863.

[10] Dadgostar, H. and Zarnegar, B. and Hoﬀmann, A. and Qin, X.F. and
Truong, U. and Rao, G. and Baltimore, D. and Cheng, G. (2002). Cooper-
ation of multiple signaling pathways in CD40-regulated gene expression in
B lymphocytes. Proceedings of the National Academy of Sciences, 99(3),
1497.

[11] de Hoon, M. and Imoto, S. and Miyano, S. (2002). A comparison of
clustering techniques for gene expression data. in Proc. of the 10th Intl
Conf. on Intelligent Systems for Molecular Biology.

31


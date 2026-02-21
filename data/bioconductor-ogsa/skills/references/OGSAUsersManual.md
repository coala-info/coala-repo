OGSA Users Manual

Michael Ochs
email: ochsm@tcnj.edu

April 24, 2017

Outlier Gene Set Analysis (OGSA) provides a global estimate of pathway
deregulation in cancer subtypes by integrating the estimates of signiﬁcance
for individual pathway members that have been identiﬁed by outlier analysis.
OGSA integrates data from diﬀerent molecular domains using diﬀerent molec-
ular data types simultaneously. Two methods for performing outlier analysis
are included in this package: the method of Tibshirani and Hastie and a rank
sum outlier approach, modiﬁed from Ghosh. The latter method sets minimum
change levels for the calling of an outlier, eﬀectively eliminating many outliers
where the change was not biologically meaningful.

In this example we apply the outlier analysis to a set of measurements of
expression, promoter methylation, and copy number variation. The data is
processed prior to application of OGSA by any method to produce gene level
summaries of the data.

Basic Concept

The ﬁgure below illustrates how the analysis works. Diﬀerent molecular data
measurements, di, are preprocessed into gene level summaries. Analysis then
follows by determining outlier counts for each data type and each gene, which
are then used in rank-based statistical tests on pathways of interest. Pathways
can then be reﬁned as desired (e.g., removing pathways that are not of interest
either due to lack of features of interest such as druggable targets or due to
being well-known already).

1

Example

1. Load and format the data and set initial settings. Three data sets are
provided in this example. Here, they’re called ’expr’, ’cnv’, and ’meth’,
for the gene expression, copy number variation, and promoter methylation
measurements. Each data set is provided as a matrix with the genes in
the rows and diﬀerent samples in diﬀerent columns. The ’pheno’ in the
code below is a vector of numbers with as many elements as there are
samples (in this example, 69) with ”1” indicating a case and ”0” indicating
a control. In this analysis, the cases are individual tumors samples and
the controls normal tissue samples.

In order to encode reasonable molecular relationships, we look for right-tail
outliers for expression and copy number with left-tail outliers in methyla-
tion (tailRLR). This provides the proper biological relationships of ampli-
ﬁcation or loss of promoter methylation leading to increased expression.
Likewise we will also look for the reverse with left tail outliers in copy num-
ber and expression tied to right tail outliers in methylation (tailLRL).

When using the rank method to identify outliers, we will also set thresholds
on the minimum acceptable change to quality as an outlier, with a log
expression change of 1, a beta methylation level change of 0.1, and a copy
number change of 0.5. Only when an outlier exceeds a normal sample by
these amounts does it get counted into the statistic.

’

’

’

)

)

’
’

OGSA
ExampleData
’
KEGG_BC_GS

> library(
> data(
> data(
)
> phenotype <- pheno
> names(phenotype) <- colnames(cnv)
left
left
> tailLRL <- c(
right
right
> tailRLR <- c(
> offsets <- c(1.0, 0.1, 0.5)
> dataSet <- list(expr,meth,cnv)

right
’
left

,
,

’
’

’
’

’
’

,
’

,

’

’

’

)
’

)

2

>
>

2. Next, run the analysis using the functions copaInt() and testGScogps()
with both tail settings. The function copaInt is the wrapper function
for using any of the three outlier methods, while testGScogps generates
gene set statistics from the gene lists with outlier counts. The default
method in copaInt is the Tibshirani-Hastie method, so run copaInt again
with method=’Rank’. ’pathGS’ is the list of signiﬁcant pathways. Setting
the variable corr to TRUE corrects the count for normal outliers in the
Tibshirani-Hastie case and applies the threshold in the rank case.

> tibLRL <- copaInt(dataSet,phenotype,tails=tailLRL)
> gsTibLRL <- testGScogps(tibLRL,pathGS)
> tibLRLcorr <- copaInt(dataSet,phenotype,tails=tailLRL,corr=TRUE)
> gsTibLRLcorr <- testGScogps(tibLRLcorr,pathGS)
> tibRLR <- copaInt(dataSet,phenotype,tails=tailRLR)
> tibRLRcorr <- copaInt(dataSet,phenotype,tails=tailRLR,corr=TRUE)
> gsTibRLR <- testGScogps(tibRLR,pathGS)
> gsTibRLRcorr <- testGScogps(tibRLRcorr,pathGS)
> rankLRL <- copaInt(dataSet,phenotype,tails=tailLRL,method=

Rank

’

’

)

[1] 2000
[1] 2000
[1] 2000

69
69

> rankLRLcorr <- copaInt(dataSet,phenotype,tails=tailLRL,method=
+

offsets=offsets)

’

’

Rank

,corr=TRUE,

[1] 2000
[1] 2000
[1] 2000

69
69

> gsRankLRL <- testGScogps(rankLRL,pathGS)
> gsRankLRLcorr <- testGScogps(rankLRLcorr,pathGS)
> rankRLR <- copaInt(dataSet,phenotype,tails=tailRLR,method=

’

’

Rank

)

[1] 2000
[1] 2000
[1] 2000

69
69

> rankRLRcorr <- copaInt(dataSet,phenotype,tails=tailRLR,method=
+

offsets=offsets)

’

’

Rank

,corr=TRUE,

[1] 2000
[1] 2000
[1] 2000

69
69

3

> gsRankRLR <- testGScogps(rankRLR,pathGS)
> gsRankRLRcorr <- testGScogps(rankRLRcorr,pathGS)

3. Process and create the outlier maps to indicate where the tumor-speciﬁc
outliers have been called in pathways of interest. Here, we use KEGG
ECM Receptor Interaction and Biocarta PDGFB pathways to demon-
strate creating and plotting the outlier maps.

> outRankLRLcorr <- outCallRank(dataSet, phenotype, names=c(
+
> outRankRLRcorr <- outCallRank(dataSet, phenotype, names=c(
+
> print("Corrected Rank Outliers Calculated")

corr=TRUE,offsets=offsets)

corr=TRUE,offsets=offsets)

’

’

’

Expr

’

Expr

’

,

’

,

’

Meth

’

Meth

’

,

’

,

’

CNV

’

CNV

),tail=tailLRL,

),tail=tailRLR,

[1] "Corrected Rank Outliers Calculated"

> outTibLRL <- outCallTib(dataSet, phenotype, names=c(
> outTibRLR <- outCallTib(dataSet, phenotype, names=c(
> print("Tibshirani-Hastie Outliers Calculated")

’
’

’
’

Expr
Expr

’
’

,
,

’
’

Meth
Meth

’
’

,
,

’
’

CNV
CNV

),tail=tailLRL)
),tail=tailRLR)

[1] "Tibshirani-Hastie Outliers Calculated"

’

’
’

BIOCARTA_PDGF_PATHWAY
> pdgfB <- pathGS$
> map1 <- outMap(outTibLRL,pdgfB,hmName=
+
> ecmK <- pathGS$
> map4 <- outMap(outRankRLRcorr,ecmK,hmName=
+
plotName=
>

plotName=
’

KEGG_ECM_RECEPTOR_INTERACTION

’

’

’

’

PDGF Outlier T-H LRL Calls

)

BC_PDGF_TIB.pdf

,

’

’

ECM Outlier Corr Rank RLR Calls

)

KEGG_ECM_RANKcorr.pdf

,

’

’

4

MAPK8PIK3CGPIK3CAPIK3R1PRKCAMAPK3FOSGRB2SOS1SHC1MAP2K1MAP2K4RAF1PLCG1STAT5ASTAT5BSTAT6STAT4STAT1STAT3STAT2PDGFRASRFRASA1JAK1RangePANILVPASELFPARXBTPARLSWPARHJVPAREFMPARPWLPASWPTPASADGPANVGPPANNHBPATASTPAPVGEPALGKXPASZZEPASFEWPARFALPANTNAPAKGXNPARUNXPANXAFPAEEYPPASEFDPANNJIPARLVLPAEFHCPASECWPAKRZGPASRTPPASGGKPARKFBPADZYCPARFRNPARHVKPARWASPAPZIZPANZCUPANUUAPANUTBPADZKDPASFJBPARMZFPAPVCNPANYNR25 Genes with Outlier from 25 Total39 Patients with Outlier from 44 TotalPDGF Outlier T−H LRL Calls0246Value0400800Color Keyand HistogramCountCOL4A2COL4A1DAG1ITGB1ITGA1LAMA2LAMA4LAMA3ITGB3ITGAVITGA4CD44CD36ITGA2BITGA11ITGB4ITGA10ITGB5ITGB8ITGB7ITGB6ITGA2ITGA3ITGA9ITGA6ITGA5ITGA8ITGA7THBS1SDC4SDC2SDC3SDC1VWFCD47GP5SV2BSV2ACOL11A1LAMC3COL1A2RELNLAMC2LAMC1COL1A1IBSPTNCCOL3A1COL2A1LAMB3LAMB2TNRCOL6A3COL6A2GP1BALAMB1THBS2THBS3THBS4FN1SPP1HSPG2COL5A3COL5A2COL5A1LAMA1LAMA5RangePANILVPASELFPARXBTPARLSWPARHJVPAREFMPARPWLPASWPTPASADGPANVGPPANNHBPATASTPAPVGEPALGKXPASZZEPASFEWPARFALPANTNAPAKGXNPARUNXPANXAFPAEEYPPASEFDPANNJIPARLVLPAEFHCPASECWPAKRZGPASRTPPASGGKPARKFBPADZYCPARFRNPARHVKPARWASPAPZIZPANZCUPANUUAPANUTBPADZKDPASFJBPARMZFPAPVCNPANYNR58 Genes with Outlier from 67 Total44 Patients with Outlier from 44 TotalECM Outlier Corr Rank RLR Calls0246Value010002500Color Keyand HistogramCountReferences
Ochs, M. F., Farrar, J. E., Considine, M., Wei, Y., Meshinchi, S., & Arceci,
R. J. (n.d.). Outlier Analysis and Top Scoring Pair for Integrated Data Analysis
and Biomarker Discovery. IEEE/ACM Transactions on Computational Biology
and Bioinformatics, 1–1. doi:10.1109/tcbb.2013.153

R. Tibshirani and T. Hastie.

(2007) Outlier Sums for Diﬀerential Gene

Expression Analysis. Biostatistics, 8(1), 2-8.

5


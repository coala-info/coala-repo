GSReg: A Package for Gene Set Variability Analysis

Bahman Afsari1 and Elana J. Fertig1

1The Sidney Kimmel Comprehensive Cancer Center,
Johns Hopkins University School of Medicine

Modified: April 8, 2014. Compiled: October 30, 2025

Contents

1

2

Introduction

Input Data
2.1 Data structure .

.

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

2
2

3 Analysis of the pathways
.
3.1 DIRAC Analysis
3.2 EVA .
.
.
3.3 Comparison of DIRAC and EVA . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 Splice-EVA Analysis .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4
5
6
. 10
. 25

.
.

.
.

.
.

.
.

.

.

.

.

.

.

4

5

1

System Information

Literature Cited

Introduction

77

78

The GSReg package allows to analyze pathways based on the variability of the expression of
sets of genes that are targets of those pathways. Basing this set statistic on variability enables
inference of dysregulated pathways in diseases, including notably cancers. The first set statistic
for gene variability was in the work of Eddy and his colleagues (see [1]) which used a ranked
based methodology called DIRAC. DIRAC calculates a measure of variability of the ordering of

1

the expression of genes in a pathway for specific phenotype. The basic idea behind DIRAC is
to generate a template for the pair-wise comparisons of gene expressions of a pathway within a
phenotype. DIRAC calculates a measure of the variability of the ordering within the phenotype,
i.e. the expected distance of a sample from the phenotype and the template of the phenotype. In
mathematical terms, if we denote denote two i.i.d. samples from the same phenotypes by X and
X ′ and D Kendall-τ -distance on the specific pathways, then the EVA [?] statistic is E(D(X, X ′)).
It identifies significantly dysregulated pathways by estimating p-values from a permutation test.
Eddy et al. found that more pathological phenotypes usually have more pathways with higher
variability compared to less pathological phenotypes.

However, the permutation test in DIRAC is computationally intensive and reaching low p-values
may be impractical since they require a huge number of permutations. Low p-values are required
for multiple hypothesis correction. A similar measure of variability of the orderings of gene sets
was proposed in [2]. This method approximates the p-value theoretically, without a permutation
test. This method is based on Kendall-τ distance [3] and the theory of U-Statistics, thus we call this
method Gene Set Expression Variation Analysis (or in short EVA). Specifically, Kendall-τ distance
between two expression profiles counts the number of disagreeing pairwise comparisons between
two profiles. The EVA measures the variability of the gene expression of pathway genes from
a phenotype by calculating the expectation of Kendall-τ distance between two random samples
from the phenotype. EVA then identifies if the variability is significantly different across two
phenotypes. To approximate this p-value EVA applies a U-Statistic Theory approach.

The GReg package contains two following utilities:

1. Identifying the dysregulated pathways with DIRAC measure of variability. The significance
is calculated using permutation test. This is the first time that DIRAC analysis has been
implemented in R. It also is more adaptable to new datasets than the original Matlab code in
[1].

2. Identifying the dysregulated pathways with EVA measure of variability. The significance is
approximated through applying U-statistics theory. This is very time efficient and consistent
with both DIRAC and applying permutation test on EVA.

2

Input Data

2.1 Data structure

In short, the GSReg package requires the following data in the following format:

1. Gene Expression Data

2

(a) The expression be in the form of a matrix where rows represent genes (or probes) and

columns represent samples.

(b) The expression matrix cannot have NAs.

(c) The expression matrix rows must have names of genes or the probes.

2. Pathways

(a) The list of pathways must contain character vectors. Only the elements of the vectors

which appear in rownames of the expression matrix are considered for analysis.

(b) The list of the pathways must have names for each vectors.

3. Phenotypes

(a) A factor with binary levels.

We used the data provided in the GSBenchMark package to reproduce the results in Eddy et al.
[1]. The GSBenchMark contains data for the pathways as well as the gene expression and pheno-
type data from twelve studies. We load the information about the pathways from GSBenchMark:

> library(GSBenchMark)
> data(diracpathways)
> class(diracpathways)

[1] "list"

> names(diracpathways)[1:5]

[1] "DEATHPATHWAY"
[4] "NEUTROPHILPATHWAY" "ALTERNATIVEPATHWAY"

"TCAPOPTOSISPATHWAY" "CCR3PATHWAY"

> class(diracpathways[[1]])

[1] "character"

AS mentioned GSReg package requires the information of the pathways to be as a list of character
vectors. Also, GSReg requires the pathways to have names. The variable diracpathways con-
tains gene pathways. It is a list. Each element represents a pathway with its name. Each elements
contains a list of characters which represent the genes in the pathway. e.g. diracpathways[["DEATHPATHWAY"]].

Now, we load the datasets’ names:

> data(GSBenchMarkDatasets)
> print(GSBenchMark.Dataset.names)

3

[1] "leukemia_GSEA"
[4] "parkinsons_GDS2519"
[7] "prostate_GDS2545_p_nf" "sarcoma_data"

"marfan_GDS2960"
"prostate_GDS2545_m_nf" "prostate_GDS2545_m_p"

"melanoma_GDS2735"

"squamous_GDS2520"

[10] "breast_GDS807"

"bipolar_GDS2190"

The remaining examples in this vignette rely on one of the datasets, i.e. “squamous GDS2520.”
Similar analyses may be reproduces for other datasets by selecting a different element of “GS-
BenchMark.Dataset.names.”

> DataSetStudy = GSBenchMark.Dataset.names[[9]]
> print(DataSetStudy)

[1] "squamous_GDS2520"

> data(list=DataSetStudy)

The data consists of two variables: exprsdata and phenotypes. exprsdata consists of a
gene expression matrix where the rows and columns represent genes and the samples respectively.
GSReg requires the rownames of gene expression variable represent the gene names, i.e. they are
represented in the pathway information variable.

The GSReg does not allow any missing data. To comply with the requirements we remove genes
with NAs. The user may use any imputation to resolve this issue:

> if(sum(apply(is.nan(exprsdata),1,sum)>0))

exprsdata = exprsdata[-which(apply(is.nan(exprsdata),1,sum)>0),];

One can extract the gene names by:

> genenames = rownames(exprsdata);
> genenames[1:10]

[1] "MAPK3"
[9] "EIF2AK2" "HINT1"

"TIE1"

"CYP2C19" "CXCR5"

"CXCR5"

"DUSP1"

"MMP10"

"DDR1"

3 Analysis of the pathways

Here, we demonstrate how to use the GSReg package to compute DIRAC and EVA statistics.

4

3.1 DIRAC Analysis

First, we load the library:

> library(GSReg)

The package also implements the alternative EVA statistic in the function GSReg.GeneSets.DIRAC.
This function receives gene expression as geneexpres, the pathway information as pathways
and phenotypes of samples as a factor with two levels and length equal to column number of
geneexpres. DIRAC uses can use either a permutation test or normal approximation for p-
value calculation; so, GSReg.GeneSets.DIRAC receives the number of permutations through
(Nperm) with default value equal to 0 which indicates the normal approximation.

> Nperm = 10
> system.time({DIRACperm =GSReg.GeneSets.DIRAC(exprsdata,diracpathways,phenotypes,Nperm=Nperm)})

user system elapsed
0.286 10.145

9.339

> system.time({DIRACAn =GSReg.GeneSets.DIRAC(exprsdata,diracpathways,phenotypes)})

user system elapsed
0.604
0.008

0.596

>

Here is the histogram of the DIRAC p-values:

> hist(DIRACAn$pvalues,xlab="pvalue",main="Hist of pvalues applying DIRAC Analysis.")

5

To check if the approximations are reliable, we plot the z-scores calculated to approximate p-values
versus the p-values from the permutation tests.
Figure 2 shows the result of comparing p-value DIRAC computing from 1000 permutation test and
approximation using normal approximation (offline generated).

3.2 EVA

The package also implements the alternative EVA statistic in the function GSReg.GeneSets.EVA.
The function requires the similar inputs as GSReg.GeneSets.DIRAC (i.e. geneexpres,

6

Hist of pvalues applying DIRAC Analysis.pvalueFrequency0.00.20.40.60.81.0010203040506070> plot(x=abs(DIRACAn$zscores),y=DIRACperm$pvalues,xlab="|Z-score|",

ylab="p-value",col="red1",main="DIRAC p-value comparisons")

> zscorelin <- seq(min(abs(DIRACAn$zscores)),max(abs(DIRACAn$zscores)),by = 0.1)
> pvaltheoretic = (1-pnorm(zscorelin))*2
> lines(x=zscorelin,y=pvaltheoretic,type="l",pch=50,lty=5,col="darkblue")
> legend("topright",legend=c("permutation test","Normal Approx."),

col=c("red1","blue"),text.col=c("red1","blue"),
lty=c(NA,1),lwd=c(NA,2.5),pch=c(21,NA))

Figure 1: Comparing p-value from permutation test and normal approximation with only 10 per-
mutations.

7

012340.00.20.40.60.81.0DIRAC p−value comparisons|Z−score|p−valuepermutation testNormal Approx.Figure 2: Theoretical p-value versus empirical p-value using 1000 permutations.

8

lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll012340.00.20.40.60.81.0DIRAC p−value comparisons|Z−score|p−valuelpermutation testNormal Approx.pathways, phenotypes) except it does not need Nperm since the p-value is not calculated
through permutation test but through the mentioned U-statistic theory approach.

> #Calculating the variance for the pathways
> #Calculate how much it takes to calculate the statistics and their p-value for all pathways
>
> system.time({VarAnKendallV = GSReg.GeneSets.EVA(geneexpres=exprsdata,

pathways=diracpathways, phenotypes=as.factor(phenotypes)) })

user system elapsed
0.696
0.013

0.684

> names(VarAnKendallV)[[1]]

[1] "DEATHPATHWAY"

> VarAnKendallV[[1]]

$E1
[1] 0.09441352

$E2
[1] 0.1310383

$E12
[1] 0.1187962

$zscore
[1] -3.711215

$zscoreD12D1
[1] 3.693266

$zscoreD12D2
[1] -4.005794

$VarEta1
[1] 3.480369e-05

$VarEta2
[1] 6.248694e-05

$sdtotal
[1] 0.009863601

$CovD12D12p
[1] 3.345665e-05

$CovD12D1p2
[1] 0.0006611348

$CovD1D12

9

[1] 0.0001258984

$CovD1D12
[1] 0.0001258984

$vartotD12D1
[1] 4.34854e-05

$vartotD12D2
[1] 9.239714e-06

$pvalue
[1] 0.0002062669

$pvalueD12D1
[1] 0.0002213919

$pvalueD12D2
[1] 6.180938e-05

$pvalueTotal
[1] 0.0001854281

$mysdtotal
[1] 0.01159303

The output consists of a list. Each element of the list corresponds to a pathway. The element
itself is a list. E1 and E2 are two fields which contain the measure of variability for pheno-
type levels(phenotypes)[1] and levels(phenotypes)[2] respectively. Other list
elements are pvalue and zscore which are calculated through the theory of U-statistics and
indicate the statistical significance of the difference between E1 and E2.

3.3 Comparison of DIRAC and EVA

We ran the following code to compare statistics from DIRAC and from EVA.

> Nperm = 10;
> VarAnPerm = vector(mode="list",length=Nperm)
> for( i in seq_len(Nperm))

{

}

VarAnPerm[[i]] = GSReg.GeneSets.EVA(geneexpres=exprsdata, pathways=diracpathways,

phenotypes=sample(phenotypes))

> pvaluesperm = vector(mode="numeric",length=length(VarAnPerm[[1]]))
> for( i in seq_along(VarAnPerm[[1]]))

{

z = sapply(VarAnPerm,function(x) x[[i]]$E1 - x[[i]]$E2)

10

pvaluesperm[i] = mean(abs(VarAnKendallV[[i]]$E1-VarAnKendallV[[i]]$E2)<abs(z))

}

>
>

zscore = sapply(VarAnKendallV,function(x) x$zscore);
pvalustat = sapply(VarAnKendallV,function(x) x$pvalue);

The figure represents that the theoretical p-value and p-value calculated from permutation test in
EVA are very similar and we can use the theoretical p-value as a surrogate for p-value. Here is the
histogram.

> hist(x=pvalustat,breaks=20,main="P-value Hist of U-Stat",xlim=c(0,1))

11

P−value Hist of U−StatpvalustatFrequency0.00.20.40.60.81.00102030405060>

>
>
>
>

plot(x=abs(zscore),y=pvaluesperm,xlab="|Z-score|",
ylab="p-value",col="red1",main="p-value comparisons")
zscorelin = seq(0,6,0.1);
pvaltheoretic = (1-pnorm(zscorelin))*2
lines(x=zscorelin,y=pvaltheoretic,type="l",pch=50,lty=5,col="darkblue")

legend("topright",legend=c("permutation test","U-Stat Estimation"),

col=c("red","blue"),text.col=c("red","blue"),

lty=c(NA,1),lwd=c(NA,2.5),pch=c(21,NA))

Figure 3: Comparing p-value from permutation test and U-statistic theory with only 10 permuta-
tions.

12

0123450.00.20.40.60.81.0p−value comparisons|Z−score|p−valuepermutation testU−Stat EstimationFigure 4: Theoretical p-value versus empirical p-value using 1000 permutations.

13

0123450.00.20.40.60.81.0p−value comparisons|Z−score|p−valueperm test     U−Stat    Figure 4 shows the result of comparing p-value EVA computing from 1000 permutation test and
approximation using U-statistics theory (offline generated).
To compare with the p-value of the DIRAC analysis, we show the p-values of DIRAC versus
U-Statistic methodology:

> plot(x=DIRACAn$pvalues,y=pvalustat,xlab ="DIRAC",

ylab="EVA",main=sprintf("P-value Comparison corr=%2.2g",cor(x=DIRACAn$pvalues,y=pvalustat)))

> lmfit = lm(pvalustat~DIRACAn$pvalues-1)
> abline(lmfit)
> cor.test(x=DIRACAn$pvalues,y=pvalustat)

Pearson's product-moment correlation

data: DIRACAn$pvalues and pvalustat
t = 15.834, df = 238, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:

0.6484375 0.7727928

sample estimates:

cor
0.7162546

14

Also, the correlation of the p-values of DIRAC and U-Statistics is very high:

> cor(x=DIRACAn$pvalues,y=pvalustat)

[1] 0.7162546

If we use 1000 permutations instead of 10 permutations, we can see that the correlation is higher
(0.88) as seen in Figure (5). The dysregulated pathways identified by DIRAC are the following
pathways:

15

0.00.20.40.60.81.00.00.20.40.60.81.0P−value Comparison corr=0.72DIRACEVA[1] "DEATHPATHWAY"
[4] "RARRXRPATHWAY"
[7] "CHEMICALPATHWAY"

"NEUTROPHILPATHWAY"
"SKP2E2FPATHWAY"
"TGFBPATHWAY"
"PDGFPATHWAY"
"PYK2PATHWAY"

"PGC1APATHWAY"
"KERATINOCYTEPATHWAY"
"PROTEASOMEPATHWAY"
"BIOPEPTIDESPATHWAY"
"MYOSINPATHWAY"
"FMLPPATHWAY"
"CDC25PATHWAY"
"FBW7PATHWAY"
"HIVNEFPATHWAY"

[10] "MAPKPATHWAY"
[13] "SPPAPATHWAY"
[16] "BETAOXIDATIONPATHWAY" "IL7PATHWAY"
[19] "VITCBPATHWAY"
[22] "MTORPATHWAY"
[25] "LYMPHOCYTEPATHWAY"
[28] "ALKPATHWAY"
[31] "GSK3PATHWAY"
[34] "TNFR2PATHWAY"
[37] "ARAPPATHWAY"
[40] "IL18PATHWAY"
[43] "STAT3PATHWAY"
[46] "NKCELLSPATHWAY"

"CD40PATHWAY"
"RNAPATHWAY"
"LAIRPATHWAY"
"P35ALZHEIMERSPATHWAY" "MSPPATHWAY"
"METPATHWAY"
"RELAPATHWAY"
"FREEPATHWAY"
"AT1RPATHWAY"
"P53HYPOXIAPATHWAY"
"MRPPATHWAY"
"MEF2DPATHWAY"
"STRESSPATHWAY"
"EPONFKBPATHWAY"
"HSP27PATHWAY"
"CARM_ERPATHWAY"
"MONOCYTEPATHWAY"

DIRAC and EVA have been shown mathematically similar. The main advantages of the EVA is
efficiency in calculation as well as easier interpretation. Figure 5 a graphical example of such
comparison. One can see that the p-values generated by DIRAC and EVA have high correlation,
i.e. 0.88. Note that EVA is much faster than DIRAC. For example, in this case, we ran the compu-
tations on a Lenovo Thinkpad with Core(TM) i7-3720QM Intel CPU @2.6 GHz. For a thousand
permutation, the DIRAC analysis took 207.47 seconds while the latter only took 0.3 seconds. Note
that for multiple hypothesis adjustment, a thousand permutations may not be satisfactory and we
require hundreds of thousand or a million permutation which may not be feasible.

Note that it is possible that some of the genes in a pathway are not represented in the expression data
or are too short (e.g. less than 5 genes). Both GSReg.GeneSets.EVA and GSReg.GeneSets.DIRAC
may ignore such pathways through parameter minGeneNum. Please see the manual for more de-
tails. If we the user wants to compare the results of DIRAC and EVA, they can run the following

code for plot DIRAC diagram of significantly perturbed pathways:

> DIRACAn =GSReg.GeneSets.DIRAC(exprsdata,diracpathways,phenotypes,Nperm=1000)

> significantPathwaysDIRAC = names(DIRACAn$mu1)[which(DIRACAn$pvalues<0.05)];
> mu1 = DIRACAn$mu1[significantPathwaysDIRAC];
> mu2 = DIRACAn$mu2[significantPathwaysDIRAC];
> #The dysregulated pathways
> names(mu1)

[1] "DEATHPATHWAY"
[4] "RARRXRPATHWAY"
[7] "CHEMICALPATHWAY"

[10] "MAPKPATHWAY"
[13] "SPPAPATHWAY"

"NEUTROPHILPATHWAY"
"SKP2E2FPATHWAY"
"TGFBPATHWAY"
"PDGFPATHWAY"
"PYK2PATHWAY"

"PGC1APATHWAY"
"KERATINOCYTEPATHWAY"
"PROTEASOMEPATHWAY"
"BIOPEPTIDESPATHWAY"
"MYOSINPATHWAY"

16

Figure 5: Comparing p-values EVA versus DIRAC. The correlation is 0.88.

17

0.00.20.40.60.81.00.00.20.40.60.81.0P−value Comparison corr=0.88DIRACEVA[16] "BETAOXIDATIONPATHWAY" "IL7PATHWAY"
[19] "VITCBPATHWAY"
[22] "MTORPATHWAY"
[25] "LYMPHOCYTEPATHWAY"
[28] "ALKPATHWAY"
[31] "GSK3PATHWAY"
[34] "TNFR2PATHWAY"
[37] "ARAPPATHWAY"
[40] "IL18PATHWAY"
[43] "STAT3PATHWAY"
[46] "NKCELLSPATHWAY"

"CD40PATHWAY"
"RNAPATHWAY"
"LAIRPATHWAY"
"P35ALZHEIMERSPATHWAY" "MSPPATHWAY"
"METPATHWAY"
"RELAPATHWAY"
"FREEPATHWAY"
"AT1RPATHWAY"
"P53HYPOXIAPATHWAY"
"MRPPATHWAY"
"MEF2DPATHWAY"
"STRESSPATHWAY"
"EPONFKBPATHWAY"
"HSP27PATHWAY"
"CARM_ERPATHWAY"
"MONOCYTEPATHWAY"

"FMLPPATHWAY"
"CDC25PATHWAY"
"FBW7PATHWAY"
"HIVNEFPATHWAY"

> plot(x=mu1,y=mu2,

xlim=c(0,max(mu1,mu2)),ylim=c(0,max(mu1,mu2)),xlab="normal",ylab="disease",
main="(a) DIRAC significantly dysregulated pathways")

> lines(x=c(0,max(mu1,mu2)),y=c(0,max(mu1,mu2)))

18

Now, if we do the analysis using EVA, we have:

> significantPathwaysGSV = names(which(pvalustat<0.05));

[1] "DEATHPATHWAY"
[4] "PGC1APATHWAY"
[7] "SKP2E2FPATHWAY"

[10] "METHIONINEPATHWAY"
[13] "PROTEASOMEPATHWAY"
[16] "NTHIPATHWAY"
[19] "SPPAPATHWAY"

"TCAPOPTOSISPATHWAY"
"TERCPATHWAY"
"KERATINOCYTEPATHWAY"
"TGFBPATHWAY"
"CDK5PATHWAY"
"PDGFPATHWAY"
"PYK2PATHWAY"

"NEUTROPHILPATHWAY"
"RARRXRPATHWAY"
"CHEMICALPATHWAY"
"PS1PATHWAY"
"MAPKPATHWAY"
"BIOPEPTIDESPATHWAY"
"CDC42RACPATHWAY"

19

0.000.050.100.150.200.250.000.050.100.150.200.25(a)  DIRAC significantly dysregulated pathwaysnormaldisease[22] "MYOSINPATHWAY"
[25] "FMLPPATHWAY"
[28] "CD40PATHWAY"
[31] "MTORPATHWAY"
[34] "LYMPHOCYTEPATHWAY"
[37] "ALKPATHWAY"
[40] "EDG1PATHWAY"
[43] "METPATHWAY"
[46] "ATRBRCAPATHWAY"
[49] "EPOPATHWAY"
[52] "MRPPATHWAY"
[55] "IL18PATHWAY"
[58] "MITOCHONDRIAPATHWAY" "STAT3PATHWAY"
[61] "NKCELLSPATHWAY"
[64] "HCMVPATHWAY"

"BETAOXIDATIONPATHWAY" "IL7PATHWAY"
"FASPATHWAY"
"IGF1PATHWAY"
"RNAPATHWAY"
"LAIRPATHWAY"
"PEPIPATHWAY"
"GSK3PATHWAY"
"TNFR2PATHWAY"
"GLYCOLYSISPATHWAY"
"WNTPATHWAY"
"P53HYPOXIAPATHWAY"
"STRESSPATHWAY"

"VITCBPATHWAY"
"CDC25PATHWAY"
"FBW7PATHWAY"
"HIVNEFPATHWAY"
"MSPPATHWAY"
"RELAPATHWAY"
"AT1RPATHWAY"
"TIDPATHWAY"
"ARAPPATHWAY"
"PITX2PATHWAY"
"MEF2DPATHWAY"
"EPONFKBPATHWAY"
"CARM_ERPATHWAY"

"MONOCYTEPATHWAY"

> eta1 = sapply(VarAnKendallV,function(x) x$E1)[significantPathwaysGSV];

TCAPOPTOSISPATHWAY
0.08600289
RARRXRPATHWAY
0.06914038
METHIONINEPATHWAY
0.09913420
CDK5PATHWAY
0.07975863
BIOPEPTIDESPATHWAY
0.06767807

DEATHPATHWAY
0.09441352
TERCPATHWAY
0.07316017
CHEMICALPATHWAY
0.08521303
PROTEASOMEPATHWAY
0.09617180
PDGFPATHWAY
0.08698709
CDC42RACPATHWAY
0.08948195
FMLPPATHWAY
0.05736961
IGF1PATHWAY
0.09115972
FBW7PATHWAY
0.03174603
ALKPATHWAY
0.09130361
GSK3PATHWAY
0.11946928
AT1RPATHWAY
0.05943314
EPOPATHWAY
0.07319696
P53HYPOXIAPATHWAY
0.07708666

NEUTROPHILPATHWAY
0.35559678
SKP2E2FPATHWAY
0.03367003
TGFBPATHWAY
0.05028305
MAPKPATHWAY
0.08504987
SPPAPATHWAY
0.09690598
MYOSINPATHWAY BETAOXIDATIONPATHWAY
0.02683983
VITCBPATHWAY
0.07888408
MTORPATHWAY
0.04188827
LAIRPATHWAY
0.15222872
MSPPATHWAY
0.12150072
METPATHWAY
0.10561315
GLYCOLYSISPATHWAY
0.02308802
ARAPPATHWAY
0.05988456
IL18PATHWAY
0.13015873
STAT3PATHWAY
0.05179344
CARM_ERPATHWAY
0.06462137

0.09005280
FASPATHWAY
0.08676830
CDC25PATHWAY
0.06265031
LYMPHOCYTEPATHWAY
0.22390572
PEPIPATHWAY
0.05194805
RELAPATHWAY
0.06302309
ATRBRCAPATHWAY
0.07166907
WNTPATHWAY
0.10526414
PITX2PATHWAY
0.09375387
MEF2DPATHWAY MITOCHONDRIAPATHWAY
0.12572150
MONOCYTEPATHWAY
0.25171192

0.04399740
NKCELLSPATHWAY
0.07718643

PGC1APATHWAY
0.04477053
KERATINOCYTEPATHWAY
0.07404055
PS1PATHWAY
0.08080808
NTHIPATHWAY
0.08091115
PYK2PATHWAY
0.04711514
IL7PATHWAY
0.10609668
CD40PATHWAY
0.05294705
RNAPATHWAY
0.03009689
HIVNEFPATHWAY
0.09020600
EDG1PATHWAY
0.08801738
TNFR2PATHWAY
0.05051566
TIDPATHWAY
0.07331013
MRPPATHWAY
0.04877345
STRESSPATHWAY
0.05505364
EPONFKBPATHWAY
0.07910272
HCMVPATHWAY
0.07781385

> eta2 = sapply(VarAnKendallV,function(x) x$E2)[significantPathwaysGSV];

20

TCAPOPTOSISPATHWAY
0.04531025
RARRXRPATHWAY
0.09090909
METHIONINEPATHWAY
0.15454545
CDK5PATHWAY
0.10251869
BIOPEPTIDESPATHWAY
0.08559859

DEATHPATHWAY
0.13103827
TERCPATHWAY
0.12770563
CHEMICALPATHWAY
0.11832612
PROTEASOMEPATHWAY
0.13083213
PDGFPATHWAY
0.11066711
CDC42RACPATHWAY
0.11283954
FMLPPATHWAY
0.06840858
IGF1PATHWAY
0.12087036
FBW7PATHWAY
0.06307978
ALKPATHWAY
0.11181840
GSK3PATHWAY
0.16320909
AT1RPATHWAY
0.08115533
EPOPATHWAY
0.09569080
P53HYPOXIAPATHWAY
0.09759247

NEUTROPHILPATHWAY
0.23546691
SKP2E2FPATHWAY
0.05856181
TGFBPATHWAY
0.07165057
MAPKPATHWAY
0.10114801
SPPAPATHWAY
0.12604711
MYOSINPATHWAY BETAOXIDATIONPATHWAY
0.06147186
VITCBPATHWAY
0.04252044
MTORPATHWAY
0.05994640
LAIRPATHWAY
0.11574140
MSPPATHWAY
0.17344877
METPATHWAY
0.12858234
GLYCOLYSISPATHWAY
0.05112348
ARAPPATHWAY
0.07615440
IL18PATHWAY
0.18989899
STAT3PATHWAY
0.09647495
CARM_ERPATHWAY
0.08397641

0.11997526
FASPATHWAY
0.10725265
CDC25PATHWAY
0.04413179
LYMPHOCYTEPATHWAY
0.16065416
PEPIPATHWAY
0.13593074
RELAPATHWAY
0.08203463
ATRBRCAPATHWAY
0.08771185
WNTPATHWAY
0.12762130
PITX2PATHWAY
0.11618223
MEF2DPATHWAY MITOCHONDRIAPATHWAY
0.16778499
MONOCYTEPATHWAY
0.17662338

0.05508870
NKCELLSPATHWAY
0.09574739

PGC1APATHWAY
0.05588351
KERATINOCYTEPATHWAY
0.09013983
PS1PATHWAY
0.12332852
NTHIPATHWAY
0.09532055
PYK2PATHWAY
0.06023958
IL7PATHWAY
0.13455988
CD40PATHWAY
0.08041958
RNAPATHWAY
0.08719852
HIVNEFPATHWAY
0.11884884
EDG1PATHWAY
0.11010728
TNFR2PATHWAY
0.07308378
TIDPATHWAY
0.09458733
MRPPATHWAY
0.08571429
STRESSPATHWAY
0.07523998
EPONFKBPATHWAY
0.13372688
HCMVPATHWAY
0.08899711

> #The dysregulated pathways
> names(eta1)

[1] "DEATHPATHWAY"
[4] "PGC1APATHWAY"
[7] "SKP2E2FPATHWAY"

[10] "METHIONINEPATHWAY"
[13] "PROTEASOMEPATHWAY"
[16] "NTHIPATHWAY"
[19] "SPPAPATHWAY"
[22] "MYOSINPATHWAY"
[25] "FMLPPATHWAY"
[28] "CD40PATHWAY"
[31] "MTORPATHWAY"
[34] "LYMPHOCYTEPATHWAY"
[37] "ALKPATHWAY"
[40] "EDG1PATHWAY"
[43] "METPATHWAY"
[46] "ATRBRCAPATHWAY"

"NEUTROPHILPATHWAY"
"RARRXRPATHWAY"
"CHEMICALPATHWAY"
"PS1PATHWAY"
"MAPKPATHWAY"
"BIOPEPTIDESPATHWAY"
"CDC42RACPATHWAY"

"TCAPOPTOSISPATHWAY"
"TERCPATHWAY"
"KERATINOCYTEPATHWAY"
"TGFBPATHWAY"
"CDK5PATHWAY"
"PDGFPATHWAY"
"PYK2PATHWAY"
"BETAOXIDATIONPATHWAY" "IL7PATHWAY"
"FASPATHWAY"
"IGF1PATHWAY"
"RNAPATHWAY"
"LAIRPATHWAY"
"PEPIPATHWAY"
"GSK3PATHWAY"
"TNFR2PATHWAY"
"GLYCOLYSISPATHWAY"

"VITCBPATHWAY"
"CDC25PATHWAY"
"FBW7PATHWAY"
"HIVNEFPATHWAY"
"MSPPATHWAY"
"RELAPATHWAY"
"AT1RPATHWAY"
"TIDPATHWAY"

21

[49] "EPOPATHWAY"
[52] "MRPPATHWAY"
[55] "IL18PATHWAY"
[58] "MITOCHONDRIAPATHWAY" "STAT3PATHWAY"
[61] "NKCELLSPATHWAY"
[64] "HCMVPATHWAY"

"WNTPATHWAY"
"P53HYPOXIAPATHWAY"
"STRESSPATHWAY"

"MONOCYTEPATHWAY"

"ARAPPATHWAY"
"PITX2PATHWAY"
"MEF2DPATHWAY"
"EPONFKBPATHWAY"
"CARM_ERPATHWAY"

> plot(x=eta1,y=eta2,xlim=c(0,max(eta1,eta2)),ylim=c(0,max(eta1,eta2)),xlab="normal",ylab="disease",

main="(b) EVA: Dysregulated pathways")

NULL

> lines(x=c(0,max(eta1,eta2)),y=c(0,max(eta1,eta2)))

NULL

22

Although there is discrepancy in identified dysregulated pathways (p-value<0.05), the general
trend found in [1] holds still true. The trend is that usually the dysregulated pathways have higher
variability measure in more dangerous phenotypes. The figures reveal that both DIRAC and EVA
have this property. DIRAC found 48 dysregulatd pathways and EVA discovered 64 pathways, 45
pathways showed up in both analysis, and 67 pathways were discovered totally.

> print(significantPathwaysGSV)

[1] "DEATHPATHWAY"

"TCAPOPTOSISPATHWAY"

"NEUTROPHILPATHWAY"

23

0.000.050.100.150.200.250.300.350.000.050.100.150.200.250.300.35(b) EVA: Dysregulated pathwaysnormaldisease"RARRXRPATHWAY"
"CHEMICALPATHWAY"
"PS1PATHWAY"
"MAPKPATHWAY"
"BIOPEPTIDESPATHWAY"
"CDC42RACPATHWAY"

[4] "PGC1APATHWAY"
[7] "SKP2E2FPATHWAY"

"TERCPATHWAY"
"KERATINOCYTEPATHWAY"
"TGFBPATHWAY"
"CDK5PATHWAY"
"PDGFPATHWAY"
"PYK2PATHWAY"
"BETAOXIDATIONPATHWAY" "IL7PATHWAY"
"FASPATHWAY"
"IGF1PATHWAY"
"RNAPATHWAY"
"LAIRPATHWAY"
"PEPIPATHWAY"
"GSK3PATHWAY"
"TNFR2PATHWAY"
"GLYCOLYSISPATHWAY"
"WNTPATHWAY"
"P53HYPOXIAPATHWAY"
"STRESSPATHWAY"

[10] "METHIONINEPATHWAY"
[13] "PROTEASOMEPATHWAY"
[16] "NTHIPATHWAY"
[19] "SPPAPATHWAY"
[22] "MYOSINPATHWAY"
[25] "FMLPPATHWAY"
[28] "CD40PATHWAY"
[31] "MTORPATHWAY"
[34] "LYMPHOCYTEPATHWAY"
[37] "ALKPATHWAY"
[40] "EDG1PATHWAY"
[43] "METPATHWAY"
[46] "ATRBRCAPATHWAY"
[49] "EPOPATHWAY"
[52] "MRPPATHWAY"
[55] "IL18PATHWAY"
[58] "MITOCHONDRIAPATHWAY" "STAT3PATHWAY"
[61] "NKCELLSPATHWAY"
[64] "HCMVPATHWAY"

"VITCBPATHWAY"
"CDC25PATHWAY"
"FBW7PATHWAY"
"HIVNEFPATHWAY"
"MSPPATHWAY"
"RELAPATHWAY"
"AT1RPATHWAY"
"TIDPATHWAY"
"ARAPPATHWAY"
"PITX2PATHWAY"
"MEF2DPATHWAY"
"EPONFKBPATHWAY"
"CARM_ERPATHWAY"

"MONOCYTEPATHWAY"

"NEUTROPHILPATHWAY"
"RARRXRPATHWAY"
"CHEMICALPATHWAY"
"PS1PATHWAY"
"MAPKPATHWAY"
"BIOPEPTIDESPATHWAY"
"CDC42RACPATHWAY"

[1] "DEATHPATHWAY"
[4] "PGC1APATHWAY"
[7] "SKP2E2FPATHWAY"

"TCAPOPTOSISPATHWAY"
"TERCPATHWAY"
"KERATINOCYTEPATHWAY"
"TGFBPATHWAY"
"CDK5PATHWAY"
"PDGFPATHWAY"
"PYK2PATHWAY"
"BETAOXIDATIONPATHWAY" "IL7PATHWAY"
"FASPATHWAY"
"IGF1PATHWAY"
"RNAPATHWAY"
"LAIRPATHWAY"
"PEPIPATHWAY"
"GSK3PATHWAY"
"TNFR2PATHWAY"
"GLYCOLYSISPATHWAY"
"WNTPATHWAY"
"P53HYPOXIAPATHWAY"
"STRESSPATHWAY"

[10] "METHIONINEPATHWAY"
[13] "PROTEASOMEPATHWAY"
[16] "NTHIPATHWAY"
[19] "SPPAPATHWAY"
[22] "MYOSINPATHWAY"
[25] "FMLPPATHWAY"
[28] "CD40PATHWAY"
[31] "MTORPATHWAY"
[34] "LYMPHOCYTEPATHWAY"
[37] "ALKPATHWAY"
[40] "EDG1PATHWAY"
[43] "METPATHWAY"
[46] "ATRBRCAPATHWAY"
[49] "EPOPATHWAY"
[52] "MRPPATHWAY"
[55] "IL18PATHWAY"
[58] "MITOCHONDRIAPATHWAY" "STAT3PATHWAY"
[61] "NKCELLSPATHWAY"
[64] "HCMVPATHWAY"

"VITCBPATHWAY"
"CDC25PATHWAY"
"FBW7PATHWAY"
"HIVNEFPATHWAY"
"MSPPATHWAY"
"RELAPATHWAY"
"AT1RPATHWAY"
"TIDPATHWAY"
"ARAPPATHWAY"
"PITX2PATHWAY"
"MEF2DPATHWAY"
"EPONFKBPATHWAY"
"CARM_ERPATHWAY"

"MONOCYTEPATHWAY"

> print(significantPathwaysDIRAC)

[1] "DEATHPATHWAY"
[4] "RARRXRPATHWAY"
[7] "CHEMICALPATHWAY"

[10] "MAPKPATHWAY"
[13] "SPPAPATHWAY"
[16] "BETAOXIDATIONPATHWAY" "IL7PATHWAY"

"NEUTROPHILPATHWAY"
"SKP2E2FPATHWAY"
"TGFBPATHWAY"
"PDGFPATHWAY"
"PYK2PATHWAY"

"PGC1APATHWAY"
"KERATINOCYTEPATHWAY"
"PROTEASOMEPATHWAY"
"BIOPEPTIDESPATHWAY"
"MYOSINPATHWAY"
"FMLPPATHWAY"

24

[19] "VITCBPATHWAY"
[22] "MTORPATHWAY"
[25] "LYMPHOCYTEPATHWAY"
[28] "ALKPATHWAY"
[31] "GSK3PATHWAY"
[34] "TNFR2PATHWAY"
[37] "ARAPPATHWAY"
[40] "IL18PATHWAY"
[43] "STAT3PATHWAY"
[46] "NKCELLSPATHWAY"
[1] "DEATHPATHWAY"
[4] "RARRXRPATHWAY"
[7] "CHEMICALPATHWAY"

"CDC25PATHWAY"
"FBW7PATHWAY"
"HIVNEFPATHWAY"

"CD40PATHWAY"
"RNAPATHWAY"
"LAIRPATHWAY"
"P35ALZHEIMERSPATHWAY" "MSPPATHWAY"
"METPATHWAY"
"RELAPATHWAY"
"FREEPATHWAY"
"AT1RPATHWAY"
"P53HYPOXIAPATHWAY"
"MRPPATHWAY"
"MEF2DPATHWAY"
"STRESSPATHWAY"
"EPONFKBPATHWAY"
"HSP27PATHWAY"
"CARM_ERPATHWAY"
"MONOCYTEPATHWAY"
"PGC1APATHWAY"
"NEUTROPHILPATHWAY"
"KERATINOCYTEPATHWAY"
"SKP2E2FPATHWAY"
"PROTEASOMEPATHWAY"
"TGFBPATHWAY"
"BIOPEPTIDESPATHWAY"
"PDGFPATHWAY"
"MYOSINPATHWAY"
"PYK2PATHWAY"
"FMLPPATHWAY"
"CDC25PATHWAY"
"FBW7PATHWAY"
"HIVNEFPATHWAY"

"CD40PATHWAY"
"RNAPATHWAY"
"LAIRPATHWAY"
"P35ALZHEIMERSPATHWAY" "MSPPATHWAY"
"METPATHWAY"
"RELAPATHWAY"
"FREEPATHWAY"
"AT1RPATHWAY"
"P53HYPOXIAPATHWAY"
"MRPPATHWAY"
"MEF2DPATHWAY"
"STRESSPATHWAY"
"EPONFKBPATHWAY"
"HSP27PATHWAY"
"CARM_ERPATHWAY"
"MONOCYTEPATHWAY"

[10] "MAPKPATHWAY"
[13] "SPPAPATHWAY"
[16] "BETAOXIDATIONPATHWAY" "IL7PATHWAY"
[19] "VITCBPATHWAY"
[22] "MTORPATHWAY"
[25] "LYMPHOCYTEPATHWAY"
[28] "ALKPATHWAY"
[31] "GSK3PATHWAY"
[34] "TNFR2PATHWAY"
[37] "ARAPPATHWAY"
[40] "IL18PATHWAY"
[43] "STAT3PATHWAY"
[46] "NKCELLSPATHWAY"

3.4 Splice-EVA Analysis

SEVA needs junction overlap matrices. This can be done by function GSReg.overlapJunction.
Here is a piece of code which shows how to use this function.

> require('Homo.sapiens')

[1] TRUE

> require('org.Hs.eg.db')

[1] TRUE

> require('GenomicRanges')

[1] TRUE

> data(juncExprsSimulated)

[1] "juncExprsSimulated"

> overlapMat <- GSReg.overlapJunction(juncExprs =

junc.RPM.Simulated,

geneexpr = geneExrsGSReg)

25

$Rest
$Rest$CMPK1

chr1:47799788-47834141
chr1:47834287-47838627
chr1:47838779-47840581
chr1:47838779-47840869
chr1:47840657-47840869
chr1:47840965-47842376

chr1:47799788-47834141
chr1:47834287-47838627
chr1:47838779-47840581
chr1:47838779-47840869
chr1:47840657-47840869
chr1:47840965-47842376

chr1:47799788-47834141
chr1:47834287-47838627
chr1:47838779-47840581
chr1:47838779-47840869
chr1:47840657-47840869
chr1:47840965-47842376

$Rest$CSF1

1
0
0
0
0
0

chr1:47799788-47834141 chr1:47834287-47838627
0
1
0
0
0
0
chr1:47838779-47840581 chr1:47838779-47840869
0
0
1
1
1
0
chr1:47840657-47840869 chr1:47840965-47842376
0
0
0
0
0
1

0
0
1
1
0
0

0
0
0
1
1
0

chr1:110453684-110456881
chr1:110457003-110458256
chr1:110458318-110459915
chr1:110460085-110464469
chr1:110464616-110465788
chr1:110464616-110466682
chr1:110466812-110467398
chr1:110467450-110467769
chr1:110467824-110468685
chr1:110467824-110471474

chr1:110453684-110456881
chr1:110457003-110458256
chr1:110458318-110459915
chr1:110460085-110464469
chr1:110464616-110465788
chr1:110464616-110466682
chr1:110466812-110467398
chr1:110467450-110467769
chr1:110467824-110468685
chr1:110467824-110471474

chr1:110453684-110456881
chr1:110457003-110458256
chr1:110458318-110459915

1
0
0
0
0
0
0
0
0
0

chr1:110453684-110456881 chr1:110457003-110458256
0
1
0
0
0
0
0
0
0
0
chr1:110458318-110459915 chr1:110460085-110464469
0
0
0
1
0
0
0
0
0
0
chr1:110464616-110465788 chr1:110464616-110466682
0
0
0

0
0
1
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

26

chr1:110460085-110464469
chr1:110464616-110465788
chr1:110464616-110466682
chr1:110466812-110467398
chr1:110467450-110467769
chr1:110467824-110468685
chr1:110467824-110471474

chr1:110453684-110456881
chr1:110457003-110458256
chr1:110458318-110459915
chr1:110460085-110464469
chr1:110464616-110465788
chr1:110464616-110466682
chr1:110466812-110467398
chr1:110467450-110467769
chr1:110467824-110468685
chr1:110467824-110471474

chr1:110453684-110456881
chr1:110457003-110458256
chr1:110458318-110459915
chr1:110460085-110464469
chr1:110464616-110465788
chr1:110464616-110466682
chr1:110466812-110467398
chr1:110467450-110467769
chr1:110467824-110468685
chr1:110467824-110471474

$Rest$FAM72B

chr1:120839865-120841975
chr1:120839985-120841975
chr1:120842052-120845995
chr1:120846119-120854492

chr1:120839865-120841975
chr1:120839985-120841975
chr1:120842052-120845995
chr1:120846119-120854492

0
1
1
0
0
0
0

0
1
1
0
0
0
0
chr1:110466812-110467398 chr1:110467450-110467769
0
0
0
0
0
0
0
1
0
0
chr1:110467824-110468685 chr1:110467824-110471474
0
0
0
0
0
0
0
0
1
1

0
0
0
0
0
0
0
0
1
1

0
0
0
0
0
0
1
0
0
0

1
1
0
0

chr1:120839865-120841975 chr1:120839985-120841975
1
1
0
0
chr1:120842052-120845995 chr1:120846119-120854492
0
0
0
1

0
0
1
0

$Rest$KCNAB2

chr1:6046387-6052304

chr1:6046387-6052304
1

$Rest$KLHL12

chr1:202861787-202862367
chr1:202861787-202863312
chr1:202862553-202863312

chr1:202861787-202862367 chr1:202861787-202863312
1
1
1

1
1
0

27

chr1:202863410-202863719
chr1:202863877-202864650
chr1:202863877-202878138
chr1:202864845-202865982
chr1:202866088-202878138
chr1:202878252-202880182
chr1:202880331-202887299
chr1:202887516-202888883
chr1:202889036-202894096
chr1:202894335-202896217

chr1:202861787-202862367
chr1:202861787-202863312
chr1:202862553-202863312
chr1:202863410-202863719
chr1:202863877-202864650
chr1:202863877-202878138
chr1:202864845-202865982
chr1:202866088-202878138
chr1:202878252-202880182
chr1:202880331-202887299
chr1:202887516-202888883
chr1:202889036-202894096
chr1:202894335-202896217

chr1:202861787-202862367
chr1:202861787-202863312
chr1:202862553-202863312
chr1:202863410-202863719
chr1:202863877-202864650
chr1:202863877-202878138
chr1:202864845-202865982
chr1:202866088-202878138
chr1:202878252-202880182
chr1:202880331-202887299
chr1:202887516-202888883
chr1:202889036-202894096
chr1:202894335-202896217

chr1:202861787-202862367
chr1:202861787-202863312
chr1:202862553-202863312
chr1:202863410-202863719
chr1:202863877-202864650
chr1:202863877-202878138
chr1:202864845-202865982
chr1:202866088-202878138
chr1:202878252-202880182
chr1:202880331-202887299
chr1:202887516-202888883
chr1:202889036-202894096

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

0
1
1
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
chr1:202862553-202863312 chr1:202863410-202863719
0
0
0
1
0
0
0
0
0
0
0
0
0
chr1:202863877-202864650 chr1:202863877-202878138
0
0
0
0
1
1
1
1
0
0
0
0
0
chr1:202864845-202865982 chr1:202866088-202878138
0
0
0
0
0
1
0
1
0
0
0
0

0
0
0
0
1
1
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
0
0
1
1
0
0
0
0
0

28

chr1:202894335-202896217

chr1:202861787-202862367
chr1:202861787-202863312
chr1:202862553-202863312
chr1:202863410-202863719
chr1:202863877-202864650
chr1:202863877-202878138
chr1:202864845-202865982
chr1:202866088-202878138
chr1:202878252-202880182
chr1:202880331-202887299
chr1:202887516-202888883
chr1:202889036-202894096
chr1:202894335-202896217

chr1:202861787-202862367
chr1:202861787-202863312
chr1:202862553-202863312
chr1:202863410-202863719
chr1:202863877-202864650
chr1:202863877-202878138
chr1:202864845-202865982
chr1:202866088-202878138
chr1:202878252-202880182
chr1:202880331-202887299
chr1:202887516-202888883
chr1:202889036-202894096
chr1:202894335-202896217

chr1:202861787-202862367
chr1:202861787-202863312
chr1:202862553-202863312
chr1:202863410-202863719
chr1:202863877-202864650
chr1:202863877-202878138
chr1:202864845-202865982
chr1:202866088-202878138
chr1:202878252-202880182
chr1:202880331-202887299
chr1:202887516-202888883
chr1:202889036-202894096
chr1:202894335-202896217

0

0
0
0
0
0
0
0
0
1
0
0
0
0

0
chr1:202878252-202880182 chr1:202880331-202887299
0
0
0
0
0
0
0
0
0
1
0
0
0
chr1:202887516-202888883 chr1:202889036-202894096
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
0
1
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
0
1
0
0
chr1:202894335-202896217
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
0
0
1

$Rest$KLHL21

chr1:6653718-6655545
chr1:6655617-6659107
chr1:6659512-6659810
chr1:6659512-6661857

chr1:6653718-6655545 chr1:6655617-6659107 chr1:6659512-6659810
0
0
1
1

1
0
0
0
chr1:6659512-6661857

0
1
0
0

29

chr1:6653718-6655545
chr1:6655617-6659107
chr1:6659512-6659810
chr1:6659512-6661857

$Rest$LOC105371470

chr1:160709146-160717984
chr1:160709146-160719611
chr1:160718304-160719611
chr1:160719883-160720094
chr1:160719922-160720094
chr1:160720213-160721135
chr1:160720213-160721976
chr1:160721238-160721976
chr1:160722038-160722896

chr1:160709146-160717984
chr1:160709146-160719611
chr1:160718304-160719611
chr1:160719883-160720094
chr1:160719922-160720094
chr1:160720213-160721135
chr1:160720213-160721976
chr1:160721238-160721976
chr1:160722038-160722896

chr1:160709146-160717984
chr1:160709146-160719611
chr1:160718304-160719611
chr1:160719883-160720094
chr1:160719922-160720094
chr1:160720213-160721135
chr1:160720213-160721976
chr1:160721238-160721976
chr1:160722038-160722896

chr1:160709146-160717984
chr1:160709146-160719611
chr1:160718304-160719611
chr1:160719883-160720094
chr1:160719922-160720094
chr1:160720213-160721135
chr1:160720213-160721976
chr1:160721238-160721976
chr1:160722038-160722896

chr1:160709146-160717984
chr1:160709146-160719611
chr1:160718304-160719611
chr1:160719883-160720094

0
0
1
1

0
1
1
0
0
0
0
0
0

1
1
0
0
0
0
0
0
0

chr1:160709146-160717984 chr1:160709146-160719611
1
1
1
0
0
0
0
0
0
chr1:160718304-160719611 chr1:160719883-160720094
0
0
0
1
1
0
0
0
0
chr1:160719922-160720094 chr1:160720213-160721135
0
0
0
0
0
1
1
0
0
chr1:160720213-160721976 chr1:160721238-160721976
0
0
0
0
0
0
1
1
0

0
0
0
0
0
1
1
1
0
chr1:160722038-160722896
0
0
0
0

0
0
0
1
1
0
0
0
0

30

chr1:160719922-160720094
chr1:160720213-160721135
chr1:160720213-160721976
chr1:160721238-160721976
chr1:160722038-160722896

0
0
0
0
1

$Rest$MIR4632

chr1:12251142-12251831

chr1:12251142-12251831
1

$Rest$MYSM1

chr1:59125827-59126842
chr1:59126899-59127078
chr1:59127183-59131171
chr1:59131303-59132710
chr1:59132898-59133519
chr1:59133593-59134102
chr1:59133593-59134304
chr1:59134238-59134656
chr1:59134354-59134656
chr1:59134710-59137542
chr1:59137630-59139245
chr1:59139322-59141149
chr1:59141252-59142598
chr1:59142728-59147457
chr1:59148217-59150825
chr1:59150923-59154710
chr1:59154788-59155898
chr1:59155921-59156012
chr1:59156089-59158533
chr1:59158603-59160801
chr1:59160879-59165657

chr1:59125827-59126842
chr1:59126899-59127078
chr1:59127183-59131171
chr1:59131303-59132710
chr1:59132898-59133519
chr1:59133593-59134102
chr1:59133593-59134304
chr1:59134238-59134656
chr1:59134354-59134656
chr1:59134710-59137542
chr1:59137630-59139245
chr1:59139322-59141149
chr1:59141252-59142598
chr1:59142728-59147457
chr1:59148217-59150825
chr1:59150923-59154710
chr1:59154788-59155898

1
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

chr1:59125827-59126842 chr1:59126899-59127078
0
1
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
0
0
0
0
0
0
0
0
0
chr1:59127183-59131171 chr1:59131303-59132710
0
0
0
1
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
0
0
0

0
0
1
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
0
0
0
0

31

chr1:59155921-59156012
chr1:59156089-59158533
chr1:59158603-59160801
chr1:59160879-59165657

chr1:59125827-59126842
chr1:59126899-59127078
chr1:59127183-59131171
chr1:59131303-59132710
chr1:59132898-59133519
chr1:59133593-59134102
chr1:59133593-59134304
chr1:59134238-59134656
chr1:59134354-59134656
chr1:59134710-59137542
chr1:59137630-59139245
chr1:59139322-59141149
chr1:59141252-59142598
chr1:59142728-59147457
chr1:59148217-59150825
chr1:59150923-59154710
chr1:59154788-59155898
chr1:59155921-59156012
chr1:59156089-59158533
chr1:59158603-59160801
chr1:59160879-59165657

chr1:59125827-59126842
chr1:59126899-59127078
chr1:59127183-59131171
chr1:59131303-59132710
chr1:59132898-59133519
chr1:59133593-59134102
chr1:59133593-59134304
chr1:59134238-59134656
chr1:59134354-59134656
chr1:59134710-59137542
chr1:59137630-59139245
chr1:59139322-59141149
chr1:59141252-59142598
chr1:59142728-59147457
chr1:59148217-59150825
chr1:59150923-59154710
chr1:59154788-59155898
chr1:59155921-59156012
chr1:59156089-59158533
chr1:59158603-59160801
chr1:59160879-59165657

chr1:59125827-59126842
chr1:59126899-59127078

0
0
0
0

0
0
0
0
1
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
chr1:59132898-59133519 chr1:59133593-59134102
0
0
0
0
0
1
1
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
0
0
0
0
chr1:59133593-59134304 chr1:59134238-59134656
0
0
0
0
0
0
1
1
1
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
0
0
chr1:59134354-59134656 chr1:59134710-59137542
0
0

0
0
0
0
0
1
1
1
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
0
0
0

0
0

32

chr1:59127183-59131171
chr1:59131303-59132710
chr1:59132898-59133519
chr1:59133593-59134102
chr1:59133593-59134304
chr1:59134238-59134656
chr1:59134354-59134656
chr1:59134710-59137542
chr1:59137630-59139245
chr1:59139322-59141149
chr1:59141252-59142598
chr1:59142728-59147457
chr1:59148217-59150825
chr1:59150923-59154710
chr1:59154788-59155898
chr1:59155921-59156012
chr1:59156089-59158533
chr1:59158603-59160801
chr1:59160879-59165657

chr1:59125827-59126842
chr1:59126899-59127078
chr1:59127183-59131171
chr1:59131303-59132710
chr1:59132898-59133519
chr1:59133593-59134102
chr1:59133593-59134304
chr1:59134238-59134656
chr1:59134354-59134656
chr1:59134710-59137542
chr1:59137630-59139245
chr1:59139322-59141149
chr1:59141252-59142598
chr1:59142728-59147457
chr1:59148217-59150825
chr1:59150923-59154710
chr1:59154788-59155898
chr1:59155921-59156012
chr1:59156089-59158533
chr1:59158603-59160801
chr1:59160879-59165657

chr1:59125827-59126842
chr1:59126899-59127078
chr1:59127183-59131171
chr1:59131303-59132710
chr1:59132898-59133519
chr1:59133593-59134102
chr1:59133593-59134304
chr1:59134238-59134656
chr1:59134354-59134656

0
0
0
0
0
1
1
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
0
0

0
0
0
0
0
0
0
1
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
0
chr1:59137630-59139245 chr1:59139322-59141149
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
0
1
0
0
0
0
0
0
0
0
0
chr1:59141252-59142598 chr1:59142728-59147457
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
0
0
0
0
0
0
0
0
0
1
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

0
0
0
0
0
0
0
0
0

33

chr1:59134710-59137542
chr1:59137630-59139245
chr1:59139322-59141149
chr1:59141252-59142598
chr1:59142728-59147457
chr1:59148217-59150825
chr1:59150923-59154710
chr1:59154788-59155898
chr1:59155921-59156012
chr1:59156089-59158533
chr1:59158603-59160801
chr1:59160879-59165657

chr1:59125827-59126842
chr1:59126899-59127078
chr1:59127183-59131171
chr1:59131303-59132710
chr1:59132898-59133519
chr1:59133593-59134102
chr1:59133593-59134304
chr1:59134238-59134656
chr1:59134354-59134656
chr1:59134710-59137542
chr1:59137630-59139245
chr1:59139322-59141149
chr1:59141252-59142598
chr1:59142728-59147457
chr1:59148217-59150825
chr1:59150923-59154710
chr1:59154788-59155898
chr1:59155921-59156012
chr1:59156089-59158533
chr1:59158603-59160801
chr1:59160879-59165657

chr1:59125827-59126842
chr1:59126899-59127078
chr1:59127183-59131171
chr1:59131303-59132710
chr1:59132898-59133519
chr1:59133593-59134102
chr1:59133593-59134304
chr1:59134238-59134656
chr1:59134354-59134656
chr1:59134710-59137542
chr1:59137630-59139245
chr1:59139322-59141149
chr1:59141252-59142598
chr1:59142728-59147457
chr1:59148217-59150825
chr1:59150923-59154710

0
0
0
1
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
0
0
1
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
1
0
0
0
0
0
0
0
chr1:59148217-59150825 chr1:59150923-59154710
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
0
0
0
0
0
1
0
0
0
0
0
chr1:59154788-59155898 chr1:59155921-59156012
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
0
0

34

chr1:59154788-59155898
chr1:59155921-59156012
chr1:59156089-59158533
chr1:59158603-59160801
chr1:59160879-59165657

chr1:59125827-59126842
chr1:59126899-59127078
chr1:59127183-59131171
chr1:59131303-59132710
chr1:59132898-59133519
chr1:59133593-59134102
chr1:59133593-59134304
chr1:59134238-59134656
chr1:59134354-59134656
chr1:59134710-59137542
chr1:59137630-59139245
chr1:59139322-59141149
chr1:59141252-59142598
chr1:59142728-59147457
chr1:59148217-59150825
chr1:59150923-59154710
chr1:59154788-59155898
chr1:59155921-59156012
chr1:59156089-59158533
chr1:59158603-59160801
chr1:59160879-59165657

chr1:59125827-59126842
chr1:59126899-59127078
chr1:59127183-59131171
chr1:59131303-59132710
chr1:59132898-59133519
chr1:59133593-59134102
chr1:59133593-59134304
chr1:59134238-59134656
chr1:59134354-59134656
chr1:59134710-59137542
chr1:59137630-59139245
chr1:59139322-59141149
chr1:59141252-59142598
chr1:59142728-59147457
chr1:59148217-59150825
chr1:59150923-59154710
chr1:59154788-59155898
chr1:59155921-59156012
chr1:59156089-59158533
chr1:59158603-59160801
chr1:59160879-59165657

$Rest$NPHP4

1
0
0
0
0

0
1
0
0
0
chr1:59156089-59158533 chr1:59158603-59160801
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
0
0
0
0
0
0
0
0
0
1
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
0
0
0
0
0
0
0
0
0
1
0
0
chr1:59160879-59165657
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
1

35

chr1:5923465-5923950
chr1:5924093-5924398
chr1:5924577-5925162
chr1:5925333-5926433
chr1:5926518-5927090
chr1:5927175-5927800
chr1:5927956-5933312
chr1:5933395-5934531
chr1:5937358-5940174
chr1:5940299-5947346
chr1:5947526-5950928
chr1:5951088-5964677
chr1:5964864-5965352
chr1:5965543-5965692
chr1:5965843-5967175
chr1:5967282-5969212
chr1:5969273-5987709
chr1:5987847-5993207
chr1:5993389-6007164
chr1:6007290-6008130
chr1:6008311-6012760
chr1:6012896-6021854
chr1:6022009-6027359
chr1:6027423-6029147
chr1:6029319-6038330
chr1:6038473-6046215
chr1:6046387-6052304
chr1:5934717-5934934
chr1:5965840-5967175
chr1:5936583-5937153
chr1:5937358-5939406
chr1:5939692-5940174

chr1:5923465-5923950
chr1:5924093-5924398
chr1:5924577-5925162
chr1:5925333-5926433
chr1:5926518-5927090
chr1:5927175-5927800
chr1:5927956-5933312
chr1:5933395-5934531
chr1:5937358-5940174
chr1:5940299-5947346
chr1:5947526-5950928
chr1:5951088-5964677
chr1:5964864-5965352
chr1:5965543-5965692
chr1:5965843-5967175
chr1:5967282-5969212
chr1:5969273-5987709

0
1
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

1
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
0

chr1:5923465-5923950 chr1:5924093-5924398 chr1:5924577-5925162
0
0
1
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
0
0
0
0
0
0
0
0
0
chr1:5925333-5926433 chr1:5926518-5927090 chr1:5927175-5927800
0
0
0
0
0
1
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
0

0
0
0
0
1
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
0
0

0
0
0
1
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
0
0
0

36

chr1:5987847-5993207
chr1:5993389-6007164
chr1:6007290-6008130
chr1:6008311-6012760
chr1:6012896-6021854
chr1:6022009-6027359
chr1:6027423-6029147
chr1:6029319-6038330
chr1:6038473-6046215
chr1:6046387-6052304
chr1:5934717-5934934
chr1:5965840-5967175
chr1:5936583-5937153
chr1:5937358-5939406
chr1:5939692-5940174

chr1:5923465-5923950
chr1:5924093-5924398
chr1:5924577-5925162
chr1:5925333-5926433
chr1:5926518-5927090
chr1:5927175-5927800
chr1:5927956-5933312
chr1:5933395-5934531
chr1:5937358-5940174
chr1:5940299-5947346
chr1:5947526-5950928
chr1:5951088-5964677
chr1:5964864-5965352
chr1:5965543-5965692
chr1:5965843-5967175
chr1:5967282-5969212
chr1:5969273-5987709
chr1:5987847-5993207
chr1:5993389-6007164
chr1:6007290-6008130
chr1:6008311-6012760
chr1:6012896-6021854
chr1:6022009-6027359
chr1:6027423-6029147
chr1:6029319-6038330
chr1:6038473-6046215
chr1:6046387-6052304
chr1:5934717-5934934
chr1:5965840-5967175
chr1:5936583-5937153
chr1:5937358-5939406
chr1:5939692-5940174

chr1:5923465-5923950
chr1:5924093-5924398

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
0
0
0
0
0
chr1:5927956-5933312 chr1:5933395-5934531 chr1:5937358-5940174
0
0
0
0
0
0
0
0
1
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
0
1
1
chr1:5940299-5947346 chr1:5947526-5950928 chr1:5951088-5964677
0
0

0
0
0
0
0
0
0
1
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
1
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
0
0
0
0
0

0
0

0
0

37

chr1:5924577-5925162
chr1:5925333-5926433
chr1:5926518-5927090
chr1:5927175-5927800
chr1:5927956-5933312
chr1:5933395-5934531
chr1:5937358-5940174
chr1:5940299-5947346
chr1:5947526-5950928
chr1:5951088-5964677
chr1:5964864-5965352
chr1:5965543-5965692
chr1:5965843-5967175
chr1:5967282-5969212
chr1:5969273-5987709
chr1:5987847-5993207
chr1:5993389-6007164
chr1:6007290-6008130
chr1:6008311-6012760
chr1:6012896-6021854
chr1:6022009-6027359
chr1:6027423-6029147
chr1:6029319-6038330
chr1:6038473-6046215
chr1:6046387-6052304
chr1:5934717-5934934
chr1:5965840-5967175
chr1:5936583-5937153
chr1:5937358-5939406
chr1:5939692-5940174

chr1:5923465-5923950
chr1:5924093-5924398
chr1:5924577-5925162
chr1:5925333-5926433
chr1:5926518-5927090
chr1:5927175-5927800
chr1:5927956-5933312
chr1:5933395-5934531
chr1:5937358-5940174
chr1:5940299-5947346
chr1:5947526-5950928
chr1:5951088-5964677
chr1:5964864-5965352
chr1:5965543-5965692
chr1:5965843-5967175
chr1:5967282-5969212
chr1:5969273-5987709
chr1:5987847-5993207
chr1:5993389-6007164
chr1:6007290-6008130

0
0
0
0
0
0
0
0
1
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
0

0
0
0
0
0
0
0
1
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
0
1
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
chr1:5964864-5965352 chr1:5965543-5965692 chr1:5965843-5967175
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
0
0
0
0
1
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
0
0
0
0
0
0
0
0
1
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
0
0
0
0
0
0
0
0
1
0
0
0
0
0
0
0

38

chr1:6008311-6012760
chr1:6012896-6021854
chr1:6022009-6027359
chr1:6027423-6029147
chr1:6029319-6038330
chr1:6038473-6046215
chr1:6046387-6052304
chr1:5934717-5934934
chr1:5965840-5967175
chr1:5936583-5937153
chr1:5937358-5939406
chr1:5939692-5940174

chr1:5923465-5923950
chr1:5924093-5924398
chr1:5924577-5925162
chr1:5925333-5926433
chr1:5926518-5927090
chr1:5927175-5927800
chr1:5927956-5933312
chr1:5933395-5934531
chr1:5937358-5940174
chr1:5940299-5947346
chr1:5947526-5950928
chr1:5951088-5964677
chr1:5964864-5965352
chr1:5965543-5965692
chr1:5965843-5967175
chr1:5967282-5969212
chr1:5969273-5987709
chr1:5987847-5993207
chr1:5993389-6007164
chr1:6007290-6008130
chr1:6008311-6012760
chr1:6012896-6021854
chr1:6022009-6027359
chr1:6027423-6029147
chr1:6029319-6038330
chr1:6038473-6046215
chr1:6046387-6052304
chr1:5934717-5934934
chr1:5965840-5967175
chr1:5936583-5937153
chr1:5937358-5939406
chr1:5939692-5940174

chr1:5923465-5923950
chr1:5924093-5924398
chr1:5924577-5925162
chr1:5925333-5926433
chr1:5926518-5927090

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
0
0
1
0
0
0
chr1:5967282-5969212 chr1:5969273-5987709 chr1:5987847-5993207
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
0
0
0
0
0
0
0
1
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
0
0
0
0
chr1:5993389-6007164 chr1:6007290-6008130 chr1:6008311-6012760
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
0
1
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
1
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
0

0
0
0
0
0

39

chr1:5927175-5927800
chr1:5927956-5933312
chr1:5933395-5934531
chr1:5937358-5940174
chr1:5940299-5947346
chr1:5947526-5950928
chr1:5951088-5964677
chr1:5964864-5965352
chr1:5965543-5965692
chr1:5965843-5967175
chr1:5967282-5969212
chr1:5969273-5987709
chr1:5987847-5993207
chr1:5993389-6007164
chr1:6007290-6008130
chr1:6008311-6012760
chr1:6012896-6021854
chr1:6022009-6027359
chr1:6027423-6029147
chr1:6029319-6038330
chr1:6038473-6046215
chr1:6046387-6052304
chr1:5934717-5934934
chr1:5965840-5967175
chr1:5936583-5937153
chr1:5937358-5939406
chr1:5939692-5940174

chr1:5923465-5923950
chr1:5924093-5924398
chr1:5924577-5925162
chr1:5925333-5926433
chr1:5926518-5927090
chr1:5927175-5927800
chr1:5927956-5933312
chr1:5933395-5934531
chr1:5937358-5940174
chr1:5940299-5947346
chr1:5947526-5950928
chr1:5951088-5964677
chr1:5964864-5965352
chr1:5965543-5965692
chr1:5965843-5967175
chr1:5967282-5969212
chr1:5969273-5987709
chr1:5987847-5993207
chr1:5993389-6007164
chr1:6007290-6008130
chr1:6008311-6012760
chr1:6012896-6021854
chr1:6022009-6027359

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
0
0
0
1
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
0
0
0
0
0
0
0
1
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
0
0
0
0
0
0
0
1
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
0
chr1:6012896-6021854 chr1:6022009-6027359 chr1:6027423-6029147
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
0
0
0
0
1
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
0
0
0
1

40

chr1:6027423-6029147
chr1:6029319-6038330
chr1:6038473-6046215
chr1:6046387-6052304
chr1:5934717-5934934
chr1:5965840-5967175
chr1:5936583-5937153
chr1:5937358-5939406
chr1:5939692-5940174

chr1:5923465-5923950
chr1:5924093-5924398
chr1:5924577-5925162
chr1:5925333-5926433
chr1:5926518-5927090
chr1:5927175-5927800
chr1:5927956-5933312
chr1:5933395-5934531
chr1:5937358-5940174
chr1:5940299-5947346
chr1:5947526-5950928
chr1:5951088-5964677
chr1:5964864-5965352
chr1:5965543-5965692
chr1:5965843-5967175
chr1:5967282-5969212
chr1:5969273-5987709
chr1:5987847-5993207
chr1:5993389-6007164
chr1:6007290-6008130
chr1:6008311-6012760
chr1:6012896-6021854
chr1:6022009-6027359
chr1:6027423-6029147
chr1:6029319-6038330
chr1:6038473-6046215
chr1:6046387-6052304
chr1:5934717-5934934
chr1:5965840-5967175
chr1:5936583-5937153
chr1:5937358-5939406
chr1:5939692-5940174

chr1:5923465-5923950
chr1:5924093-5924398
chr1:5924577-5925162
chr1:5925333-5926433
chr1:5926518-5927090
chr1:5927175-5927800
chr1:5927956-5933312
chr1:5933395-5934531

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
0
0
0
0
0
0
0
0

1
0
0
0
0
0
0
0
0
chr1:6029319-6038330 chr1:6038473-6046215 chr1:6046387-6052304
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
0
0
0
0
0
0
1
0
0
0
0
0
chr1:5934717-5934934 chr1:5965840-5967175 chr1:5936583-5937153
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
0
0
1
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
0
0
1
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
0
0

41

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
0
1
0
0

chr1:5937358-5940174
chr1:5940299-5947346
chr1:5947526-5950928
chr1:5951088-5964677
chr1:5964864-5965352
chr1:5965543-5965692
chr1:5965843-5967175
chr1:5967282-5969212
chr1:5969273-5987709
chr1:5987847-5993207
chr1:5993389-6007164
chr1:6007290-6008130
chr1:6008311-6012760
chr1:6012896-6021854
chr1:6022009-6027359
chr1:6027423-6029147
chr1:6029319-6038330
chr1:6038473-6046215
chr1:6046387-6052304
chr1:5934717-5934934
chr1:5965840-5967175
chr1:5936583-5937153
chr1:5937358-5939406
chr1:5939692-5940174

chr1:5923465-5923950
chr1:5924093-5924398
chr1:5924577-5925162
chr1:5925333-5926433
chr1:5926518-5927090
chr1:5927175-5927800
chr1:5927956-5933312
chr1:5933395-5934531
chr1:5937358-5940174
chr1:5940299-5947346
chr1:5947526-5950928
chr1:5951088-5964677
chr1:5964864-5965352
chr1:5965543-5965692
chr1:5965843-5967175
chr1:5967282-5969212
chr1:5969273-5987709
chr1:5987847-5993207
chr1:5993389-6007164
chr1:6007290-6008130
chr1:6008311-6012760
chr1:6012896-6021854
chr1:6022009-6027359
chr1:6027423-6029147
chr1:6029319-6038330
chr1:6038473-6046215

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
0
0
0
0
0
0
0
0
0
1
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
1
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
0
0
0
1
0
0
0
chr1:5937358-5939406 chr1:5939692-5940174
0
0
0
0
0
0
0
0
1
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
0
0
0
0
0
1
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
0
0
0
0
0
0
0

42

chr1:6046387-6052304
chr1:5934717-5934934
chr1:5965840-5967175
chr1:5936583-5937153
chr1:5937358-5939406
chr1:5939692-5940174

$Rest$PEX14

chr1:10637247-10637871
chr1:10659423-10678389
chr1:10678474-10683076
chr1:10683178-10684397
chr1:10684494-10687329
chr1:10687420-10689588
chr1:10596354-10659295
chr1:10596354-10678389

chr1:10637247-10637871
chr1:10659423-10678389
chr1:10678474-10683076
chr1:10683178-10684397
chr1:10684494-10687329
chr1:10687420-10689588
chr1:10596354-10659295
chr1:10596354-10678389

chr1:10637247-10637871
chr1:10659423-10678389
chr1:10678474-10683076
chr1:10683178-10684397
chr1:10684494-10687329
chr1:10687420-10689588
chr1:10596354-10659295
chr1:10596354-10678389

chr1:10637247-10637871
chr1:10659423-10678389
chr1:10678474-10683076
chr1:10683178-10684397
chr1:10684494-10687329
chr1:10687420-10689588
chr1:10596354-10659295
chr1:10596354-10678389

$Rest$PIP5K1A

0
0
0
0
1
0

0
0
0
0
0
1

1
0
0
0
0
0
1
1

0
0
1
0
0
0
0
0

chr1:10637247-10637871 chr1:10659423-10678389
0
1
0
0
0
0
0
1
chr1:10678474-10683076 chr1:10683178-10684397
0
0
0
1
0
0
0
0
chr1:10684494-10687329 chr1:10687420-10689588
0
0
0
0
0
1
0
0
chr1:10596354-10659295 chr1:10596354-10678389
1
1
0
0
0
0
1
1

1
0
0
0
0
0
1
1

0
0
0
0
1
0
0
0

chr1:151171557-151196721
chr1:151171557-151196724
chr1:151196755-151199796
chr1:151199876-151204147

chr1:151171557-151196721 chr1:151171557-151196724
1
1
0
0

1
1
0
0

43

chr1:151204277-151204724
chr1:151204841-151205027
chr1:151205179-151206673
chr1:151206972-151209034
chr1:151209239-151210658
chr1:151209239-151211606
chr1:151210741-151211606
chr1:151211654-151212431
chr1:151212515-151214599
chr1:151212515-151219396
chr1:151214745-151214914
chr1:151215043-151219396
chr1:151219441-151220339
chr1:151196755-151196847
chr1:151196882-151199796
chr1:151212515-151214914

chr1:151171557-151196721
chr1:151171557-151196724
chr1:151196755-151199796
chr1:151199876-151204147
chr1:151204277-151204724
chr1:151204841-151205027
chr1:151205179-151206673
chr1:151206972-151209034
chr1:151209239-151210658
chr1:151209239-151211606
chr1:151210741-151211606
chr1:151211654-151212431
chr1:151212515-151214599
chr1:151212515-151219396
chr1:151214745-151214914
chr1:151215043-151219396
chr1:151219441-151220339
chr1:151196755-151196847
chr1:151196882-151199796
chr1:151212515-151214914

chr1:151171557-151196721
chr1:151171557-151196724
chr1:151196755-151199796
chr1:151199876-151204147
chr1:151204277-151204724
chr1:151204841-151205027
chr1:151205179-151206673
chr1:151206972-151209034
chr1:151209239-151210658
chr1:151209239-151211606
chr1:151210741-151211606
chr1:151211654-151212431
chr1:151212515-151214599

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
0
0
chr1:151196755-151199796 chr1:151199876-151204147
0
0
0
1
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
0
0
0
0
0
0
chr1:151204277-151204724 chr1:151204841-151205027
0
0
0
0
0
1
0
0
0
0
0
0
0

0
0
1
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
0
0
0
0
1
1
0

0
0
0
0
1
0
0
0
0
0
0
0
0

44

chr1:151212515-151219396
chr1:151214745-151214914
chr1:151215043-151219396
chr1:151219441-151220339
chr1:151196755-151196847
chr1:151196882-151199796
chr1:151212515-151214914

chr1:151171557-151196721
chr1:151171557-151196724
chr1:151196755-151199796
chr1:151199876-151204147
chr1:151204277-151204724
chr1:151204841-151205027
chr1:151205179-151206673
chr1:151206972-151209034
chr1:151209239-151210658
chr1:151209239-151211606
chr1:151210741-151211606
chr1:151211654-151212431
chr1:151212515-151214599
chr1:151212515-151219396
chr1:151214745-151214914
chr1:151215043-151219396
chr1:151219441-151220339
chr1:151196755-151196847
chr1:151196882-151199796
chr1:151212515-151214914

chr1:151171557-151196721
chr1:151171557-151196724
chr1:151196755-151199796
chr1:151199876-151204147
chr1:151204277-151204724
chr1:151204841-151205027
chr1:151205179-151206673
chr1:151206972-151209034
chr1:151209239-151210658
chr1:151209239-151211606
chr1:151210741-151211606
chr1:151211654-151212431
chr1:151212515-151214599
chr1:151212515-151219396
chr1:151214745-151214914
chr1:151215043-151219396
chr1:151219441-151220339
chr1:151196755-151196847
chr1:151196882-151199796
chr1:151212515-151214914

chr1:151171557-151196721

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
0
0
0
1
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
chr1:151205179-151206673 chr1:151206972-151209034
0
0
0
0
0
0
0
1
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
0
0
chr1:151209239-151210658 chr1:151209239-151211606
0
0
0
0
0
0
0
0
1
1
1
0
0
0
0
0
0
0
0
0
chr1:151210741-151211606 chr1:151211654-151212431
0

0
0
0
0
0
0
0
0
1
1
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

0

45

chr1:151171557-151196724
chr1:151196755-151199796
chr1:151199876-151204147
chr1:151204277-151204724
chr1:151204841-151205027
chr1:151205179-151206673
chr1:151206972-151209034
chr1:151209239-151210658
chr1:151209239-151211606
chr1:151210741-151211606
chr1:151211654-151212431
chr1:151212515-151214599
chr1:151212515-151219396
chr1:151214745-151214914
chr1:151215043-151219396
chr1:151219441-151220339
chr1:151196755-151196847
chr1:151196882-151199796
chr1:151212515-151214914

chr1:151171557-151196721
chr1:151171557-151196724
chr1:151196755-151199796
chr1:151199876-151204147
chr1:151204277-151204724
chr1:151204841-151205027
chr1:151205179-151206673
chr1:151206972-151209034
chr1:151209239-151210658
chr1:151209239-151211606
chr1:151210741-151211606
chr1:151211654-151212431
chr1:151212515-151214599
chr1:151212515-151219396
chr1:151214745-151214914
chr1:151215043-151219396
chr1:151219441-151220339
chr1:151196755-151196847
chr1:151196882-151199796
chr1:151212515-151214914

chr1:151171557-151196721
chr1:151171557-151196724
chr1:151196755-151199796
chr1:151199876-151204147
chr1:151204277-151204724
chr1:151204841-151205027
chr1:151205179-151206673
chr1:151206972-151209034
chr1:151209239-151210658
chr1:151209239-151211606

0
0
0
0
0
0
0
0
1
1
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
0
0
0
0
0
0
0
0
0
1
0
0
0
0
0
0
0
0
chr1:151212515-151214599 chr1:151212515-151219396
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
0
0
1
1
1
1
0
0
0
1
chr1:151214745-151214914 chr1:151215043-151219396
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
0
0
1
1
0
0
0
0
0
1

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

46

chr1:151210741-151211606
chr1:151211654-151212431
chr1:151212515-151214599
chr1:151212515-151219396
chr1:151214745-151214914
chr1:151215043-151219396
chr1:151219441-151220339
chr1:151196755-151196847
chr1:151196882-151199796
chr1:151212515-151214914

chr1:151171557-151196721
chr1:151171557-151196724
chr1:151196755-151199796
chr1:151199876-151204147
chr1:151204277-151204724
chr1:151204841-151205027
chr1:151205179-151206673
chr1:151206972-151209034
chr1:151209239-151210658
chr1:151209239-151211606
chr1:151210741-151211606
chr1:151211654-151212431
chr1:151212515-151214599
chr1:151212515-151219396
chr1:151214745-151214914
chr1:151215043-151219396
chr1:151219441-151220339
chr1:151196755-151196847
chr1:151196882-151199796
chr1:151212515-151214914

chr1:151171557-151196721
chr1:151171557-151196724
chr1:151196755-151199796
chr1:151199876-151204147
chr1:151204277-151204724
chr1:151204841-151205027
chr1:151205179-151206673
chr1:151206972-151209034
chr1:151209239-151210658
chr1:151209239-151211606
chr1:151210741-151211606
chr1:151211654-151212431
chr1:151212515-151214599
chr1:151212515-151219396
chr1:151214745-151214914
chr1:151215043-151219396
chr1:151219441-151220339
chr1:151196755-151196847
chr1:151196882-151199796

0
0
0
1
1
0
0
0
0
1

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
0
0
0
0
0
0
1
0
0
0

0
0
0
1
0
1
0
0
0
0
chr1:151219441-151220339 chr1:151196755-151196847
0
0
1
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
0
0
0
0
1
0
0
chr1:151196882-151199796 chr1:151212515-151214914
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
0
0
1
1
1
0
0
0
0

0
0
1
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
0
0
0
0
0
1

47

chr1:151212515-151214914

0

1

$Rest$PSMB2

chr1:36068975-36070834
chr1:36070883-36074847
chr1:36075009-36096875
chr1:36096945-36101911
chr1:36102033-36106943
chr1:36043093-36070834

chr1:36068975-36070834
chr1:36070883-36074847
chr1:36075009-36096875
chr1:36096945-36101911
chr1:36102033-36106943
chr1:36043093-36070834

chr1:36068975-36070834
chr1:36070883-36074847
chr1:36075009-36096875
chr1:36096945-36101911
chr1:36102033-36106943
chr1:36043093-36070834

$Rest$RBBP4

chr1:33116923-33117515
chr1:33117662-33123028
chr1:33123173-33133826
chr1:33133999-33134340
chr1:33134455-33134573
chr1:33134733-33134832
chr1:33134958-33135087
chr1:33135164-33138051
chr1:33138127-33138243
chr1:33138300-33138392
chr1:33138502-33145241
chr1:33116923-33117518

chr1:33116923-33117515
chr1:33117662-33123028
chr1:33123173-33133826
chr1:33133999-33134340
chr1:33134455-33134573
chr1:33134733-33134832
chr1:33134958-33135087
chr1:33135164-33138051
chr1:33138127-33138243
chr1:33138300-33138392
chr1:33138502-33145241

1
0
0
0
0
1

chr1:36068975-36070834 chr1:36070883-36074847
0
1
0
0
0
0
chr1:36075009-36096875 chr1:36096945-36101911
0
0
0
1
0
0
chr1:36102033-36106943 chr1:36043093-36070834
1
0
0
0
0
1

0
0
1
0
0
0

0
0
0
0
1
0

1
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
1

chr1:33116923-33117515 chr1:33117662-33123028
0
1
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
chr1:33123173-33133826 chr1:33133999-33134340
0
0
0
1
0
0
0
0
0
0
0

0
0
1
0
0
0
0
0
0
0
0

48

chr1:33116923-33117518

chr1:33116923-33117515
chr1:33117662-33123028
chr1:33123173-33133826
chr1:33133999-33134340
chr1:33134455-33134573
chr1:33134733-33134832
chr1:33134958-33135087
chr1:33135164-33138051
chr1:33138127-33138243
chr1:33138300-33138392
chr1:33138502-33145241
chr1:33116923-33117518

chr1:33116923-33117515
chr1:33117662-33123028
chr1:33123173-33133826
chr1:33133999-33134340
chr1:33134455-33134573
chr1:33134733-33134832
chr1:33134958-33135087
chr1:33135164-33138051
chr1:33138127-33138243
chr1:33138300-33138392
chr1:33138502-33145241
chr1:33116923-33117518

chr1:33116923-33117515
chr1:33117662-33123028
chr1:33123173-33133826
chr1:33133999-33134340
chr1:33134455-33134573
chr1:33134733-33134832
chr1:33134958-33135087
chr1:33135164-33138051
chr1:33138127-33138243
chr1:33138300-33138392
chr1:33138502-33145241
chr1:33116923-33117518

chr1:33116923-33117515
chr1:33117662-33123028
chr1:33123173-33133826
chr1:33133999-33134340
chr1:33134455-33134573
chr1:33134733-33134832
chr1:33134958-33135087
chr1:33135164-33138051
chr1:33138127-33138243
chr1:33138300-33138392

0

0
0
0
0
1
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
0
0
0
1
0
0
0
0
0

0
chr1:33134455-33134573 chr1:33134733-33134832
0
0
0
0
0
1
0
0
0
0
0
0
chr1:33134958-33135087 chr1:33135164-33138051
0
0
0
0
0
0
0
1
0
0
0
0
chr1:33138127-33138243 chr1:33138300-33138392
0
0
0
0
0
0
0
0
0
1
0
0
chr1:33138502-33145241 chr1:33116923-33117518
1
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
0
0
0
0
0
0
0
1
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
0
0
0

49

chr1:33138502-33145241
chr1:33116923-33117518

$Rest$RBBP5

chr1:205057943-205064001
chr1:205057943-205064115
chr1:205064192-205065810
chr1:205066039-205066454
chr1:205066523-205068117
chr1:205068234-205068869
chr1:205068940-205069039
chr1:205069192-205069280
chr1:205069399-205070728
chr1:205070837-205072985
chr1:205073147-205074156
chr1:205074296-205083917
chr1:205084033-205084986
chr1:205084089-205084986
chr1:205085011-205090983
chr1:205057940-205064001

chr1:205057943-205064001
chr1:205057943-205064115
chr1:205064192-205065810
chr1:205066039-205066454
chr1:205066523-205068117
chr1:205068234-205068869
chr1:205068940-205069039
chr1:205069192-205069280
chr1:205069399-205070728
chr1:205070837-205072985
chr1:205073147-205074156
chr1:205074296-205083917
chr1:205084033-205084986
chr1:205084089-205084986
chr1:205085011-205090983
chr1:205057940-205064001

chr1:205057943-205064001
chr1:205057943-205064115
chr1:205064192-205065810
chr1:205066039-205066454
chr1:205066523-205068117
chr1:205068234-205068869
chr1:205068940-205069039
chr1:205069192-205069280
chr1:205069399-205070728
chr1:205070837-205072985
chr1:205073147-205074156
chr1:205074296-205083917

1
0

0
1

1
1
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
0
0
0
1

chr1:205057943-205064001 chr1:205057943-205064115
1
1
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
0
0
0
1
chr1:205064192-205065810 chr1:205066039-205066454
0
0
0
1
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
0
0
chr1:205066523-205068117 chr1:205068234-205068869
0
0
0
0
0
1
0
0
0
0
0
0

0
0
1
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
0
0
0

0
0
0
0
1
0
0
0
0
0
0
0

50

chr1:205084033-205084986
chr1:205084089-205084986
chr1:205085011-205090983
chr1:205057940-205064001

chr1:205057943-205064001
chr1:205057943-205064115
chr1:205064192-205065810
chr1:205066039-205066454
chr1:205066523-205068117
chr1:205068234-205068869
chr1:205068940-205069039
chr1:205069192-205069280
chr1:205069399-205070728
chr1:205070837-205072985
chr1:205073147-205074156
chr1:205074296-205083917
chr1:205084033-205084986
chr1:205084089-205084986
chr1:205085011-205090983
chr1:205057940-205064001

chr1:205057943-205064001
chr1:205057943-205064115
chr1:205064192-205065810
chr1:205066039-205066454
chr1:205066523-205068117
chr1:205068234-205068869
chr1:205068940-205069039
chr1:205069192-205069280
chr1:205069399-205070728
chr1:205070837-205072985
chr1:205073147-205074156
chr1:205074296-205083917
chr1:205084033-205084986
chr1:205084089-205084986
chr1:205085011-205090983
chr1:205057940-205064001

chr1:205057943-205064001
chr1:205057943-205064115
chr1:205064192-205065810
chr1:205066039-205066454
chr1:205066523-205068117
chr1:205068234-205068869
chr1:205068940-205069039
chr1:205069192-205069280
chr1:205069399-205070728
chr1:205070837-205072985
chr1:205073147-205074156
chr1:205074296-205083917

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
1
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
0
0
0
chr1:205068940-205069039 chr1:205069192-205069280
0
0
0
0
0
0
0
1
0
0
0
0
0
0
0
0
chr1:205069399-205070728 chr1:205070837-205072985
0
0
0
0
0
0
0
0
0
1
0
0
0
0
0
0
chr1:205073147-205074156 chr1:205074296-205083917
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
0
1

0
0
0
0
0
0
0
0
1
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
0
0
0
0
0
0
0
1
0

51

chr1:205084033-205084986
chr1:205084089-205084986
chr1:205085011-205090983
chr1:205057940-205064001

chr1:205057943-205064001
chr1:205057943-205064115
chr1:205064192-205065810
chr1:205066039-205066454
chr1:205066523-205068117
chr1:205068234-205068869
chr1:205068940-205069039
chr1:205069192-205069280
chr1:205069399-205070728
chr1:205070837-205072985
chr1:205073147-205074156
chr1:205074296-205083917
chr1:205084033-205084986
chr1:205084089-205084986
chr1:205085011-205090983
chr1:205057940-205064001

chr1:205057943-205064001
chr1:205057943-205064115
chr1:205064192-205065810
chr1:205066039-205066454
chr1:205066523-205068117
chr1:205068234-205068869
chr1:205068940-205069039
chr1:205069192-205069280
chr1:205069399-205070728
chr1:205070837-205072985
chr1:205073147-205074156
chr1:205074296-205083917
chr1:205084033-205084986
chr1:205084089-205084986
chr1:205085011-205090983
chr1:205057940-205064001

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
0
0
0
0
0
0
1
1
0
0

0
0
0
0
chr1:205084033-205084986 chr1:205084089-205084986
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
0
0
1
1
0
0
chr1:205085011-205090983 chr1:205057940-205064001
1
1
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
0
0
0
1

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
0
0
0
0
1
0

$Rest$RERE

chr1:8415180-8415479
chr1:8415659-8416160
chr1:8416306-8418256
chr1:8418976-8419824
chr1:8420046-8420172
chr1:8421550-8421823
chr1:8421936-8422743
chr1:8422904-8424116
chr1:8424315-8424806
chr1:8424898-8425872

chr1:8415180-8415479 chr1:8415659-8416160 chr1:8416306-8418256
0
0
1
0
0
0
0
0
0
0

0
1
0
0
0
0
0
0
0
0

1
0
0
0
0
0
0
0
0
0

52

chr1:8426034-8482787
chr1:8482867-8525985
chr1:8526083-8555123
chr1:8555222-8557465
chr1:8557589-8568686
chr1:8568734-8601273
chr1:8601377-8616534
chr1:8616630-8617477
chr1:8617582-8674620
chr1:8674745-8684369
chr1:8684439-8716032
chr1:8716500-8813490
chr1:8716500-8877219
chr1:8482867-8483621
chr1:8852647-8877219
chr1:8716500-8852463

chr1:8415180-8415479
chr1:8415659-8416160
chr1:8416306-8418256
chr1:8418976-8419824
chr1:8420046-8420172
chr1:8421550-8421823
chr1:8421936-8422743
chr1:8422904-8424116
chr1:8424315-8424806
chr1:8424898-8425872
chr1:8426034-8482787
chr1:8482867-8525985
chr1:8526083-8555123
chr1:8555222-8557465
chr1:8557589-8568686
chr1:8568734-8601273
chr1:8601377-8616534
chr1:8616630-8617477
chr1:8617582-8674620
chr1:8674745-8684369
chr1:8684439-8716032
chr1:8716500-8813490
chr1:8716500-8877219
chr1:8482867-8483621
chr1:8852647-8877219
chr1:8716500-8852463

chr1:8415180-8415479
chr1:8415659-8416160
chr1:8416306-8418256
chr1:8418976-8419824
chr1:8420046-8420172
chr1:8421550-8421823
chr1:8421936-8422743

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
0
0
0
0
0
0
0
0
chr1:8418976-8419824 chr1:8420046-8420172 chr1:8421550-8421823
0
0
0
0
0
1
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
chr1:8421936-8422743 chr1:8422904-8424116 chr1:8424315-8424806
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
1
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
0
0

0
0
0
0
1
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
0
0
0
0
1

53

chr1:8422904-8424116
chr1:8424315-8424806
chr1:8424898-8425872
chr1:8426034-8482787
chr1:8482867-8525985
chr1:8526083-8555123
chr1:8555222-8557465
chr1:8557589-8568686
chr1:8568734-8601273
chr1:8601377-8616534
chr1:8616630-8617477
chr1:8617582-8674620
chr1:8674745-8684369
chr1:8684439-8716032
chr1:8716500-8813490
chr1:8716500-8877219
chr1:8482867-8483621
chr1:8852647-8877219
chr1:8716500-8852463

chr1:8415180-8415479
chr1:8415659-8416160
chr1:8416306-8418256
chr1:8418976-8419824
chr1:8420046-8420172
chr1:8421550-8421823
chr1:8421936-8422743
chr1:8422904-8424116
chr1:8424315-8424806
chr1:8424898-8425872
chr1:8426034-8482787
chr1:8482867-8525985
chr1:8526083-8555123
chr1:8555222-8557465
chr1:8557589-8568686
chr1:8568734-8601273
chr1:8601377-8616534
chr1:8616630-8617477
chr1:8617582-8674620
chr1:8674745-8684369
chr1:8684439-8716032
chr1:8716500-8813490
chr1:8716500-8877219
chr1:8482867-8483621
chr1:8852647-8877219
chr1:8716500-8852463

chr1:8415180-8415479
chr1:8415659-8416160
chr1:8416306-8418256
chr1:8418976-8419824

1
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
0
0
0
0
0
0
0

0
1
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
0
0
0
0
0
0
0
chr1:8424898-8425872 chr1:8426034-8482787 chr1:8482867-8525985
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
0
1
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
0
1
0
0
chr1:8526083-8555123 chr1:8555222-8557465 chr1:8557589-8568686
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
0
0
0
1
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
0
0
0
0
0
0
1
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
0
0
0

54

chr1:8420046-8420172
chr1:8421550-8421823
chr1:8421936-8422743
chr1:8422904-8424116
chr1:8424315-8424806
chr1:8424898-8425872
chr1:8426034-8482787
chr1:8482867-8525985
chr1:8526083-8555123
chr1:8555222-8557465
chr1:8557589-8568686
chr1:8568734-8601273
chr1:8601377-8616534
chr1:8616630-8617477
chr1:8617582-8674620
chr1:8674745-8684369
chr1:8684439-8716032
chr1:8716500-8813490
chr1:8716500-8877219
chr1:8482867-8483621
chr1:8852647-8877219
chr1:8716500-8852463

chr1:8415180-8415479
chr1:8415659-8416160
chr1:8416306-8418256
chr1:8418976-8419824
chr1:8420046-8420172
chr1:8421550-8421823
chr1:8421936-8422743
chr1:8422904-8424116
chr1:8424315-8424806
chr1:8424898-8425872
chr1:8426034-8482787
chr1:8482867-8525985
chr1:8526083-8555123
chr1:8555222-8557465
chr1:8557589-8568686
chr1:8568734-8601273
chr1:8601377-8616534
chr1:8616630-8617477
chr1:8617582-8674620
chr1:8674745-8684369
chr1:8684439-8716032
chr1:8716500-8813490
chr1:8716500-8877219
chr1:8482867-8483621
chr1:8852647-8877219
chr1:8716500-8852463

chr1:8415180-8415479

0
0
0
0
0
0
0
0
1
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
0
0
1
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
0
0
1
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
0
chr1:8568734-8601273 chr1:8601377-8616534 chr1:8616630-8617477
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
0
0
0
0
0
0
0
1
0
0
0
0
0
0
0
0
chr1:8617582-8674620 chr1:8674745-8684369 chr1:8684439-8716032
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
0
0
0
0
0
0
1
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
0
0
0
0
0
0
1
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

0

55

chr1:8415659-8416160
chr1:8416306-8418256
chr1:8418976-8419824
chr1:8420046-8420172
chr1:8421550-8421823
chr1:8421936-8422743
chr1:8422904-8424116
chr1:8424315-8424806
chr1:8424898-8425872
chr1:8426034-8482787
chr1:8482867-8525985
chr1:8526083-8555123
chr1:8555222-8557465
chr1:8557589-8568686
chr1:8568734-8601273
chr1:8601377-8616534
chr1:8616630-8617477
chr1:8617582-8674620
chr1:8674745-8684369
chr1:8684439-8716032
chr1:8716500-8813490
chr1:8716500-8877219
chr1:8482867-8483621
chr1:8852647-8877219
chr1:8716500-8852463

chr1:8415180-8415479
chr1:8415659-8416160
chr1:8416306-8418256
chr1:8418976-8419824
chr1:8420046-8420172
chr1:8421550-8421823
chr1:8421936-8422743
chr1:8422904-8424116
chr1:8424315-8424806
chr1:8424898-8425872
chr1:8426034-8482787
chr1:8482867-8525985
chr1:8526083-8555123
chr1:8555222-8557465
chr1:8557589-8568686
chr1:8568734-8601273
chr1:8601377-8616534
chr1:8616630-8617477
chr1:8617582-8674620
chr1:8674745-8684369
chr1:8684439-8716032
chr1:8716500-8813490
chr1:8716500-8877219
chr1:8482867-8483621
chr1:8852647-8877219

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
0
0
0
0
0
0
0
0
1
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
0
0
0
1
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
0
0
0
0
0
0
1
0
0
0
0
0
chr1:8716500-8813490 chr1:8716500-8877219 chr1:8482867-8483621
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
0
1
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
0
1
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
0
0
1
1
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
0
0
0
1
1
0
1

56

0

chr1:8716500-8852463

chr1:8415180-8415479
chr1:8415659-8416160
chr1:8416306-8418256
chr1:8418976-8419824
chr1:8420046-8420172
chr1:8421550-8421823
chr1:8421936-8422743
chr1:8422904-8424116
chr1:8424315-8424806
chr1:8424898-8425872
chr1:8426034-8482787
chr1:8482867-8525985
chr1:8526083-8555123
chr1:8555222-8557465
chr1:8557589-8568686
chr1:8568734-8601273
chr1:8601377-8616534
chr1:8616630-8617477
chr1:8617582-8674620
chr1:8674745-8684369
chr1:8684439-8716032
chr1:8716500-8813490
chr1:8716500-8877219
chr1:8482867-8483621
chr1:8852647-8877219
chr1:8716500-8852463

$Rest$`RERE-AS1`

1

1
chr1:8852647-8877219 chr1:8716500-8852463
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
0
1
1
0
0
1

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
0
0
1
0
1
0

chr1:8482867-8525985

chr1:8482867-8525985
1

$Rest$SLAMF7

chr1:160709146-160717984
chr1:160709146-160719611
chr1:160718304-160719611
chr1:160719883-160720094
chr1:160719922-160720094
chr1:160720213-160721135
chr1:160720213-160721976
chr1:160721238-160721976
chr1:160722038-160722896

chr1:160709146-160717984
chr1:160709146-160719611
chr1:160718304-160719611
chr1:160719883-160720094
chr1:160719922-160720094
chr1:160720213-160721135

1
1
0
0
0
0
0
0
0

chr1:160709146-160717984 chr1:160709146-160719611
1
1
1
0
0
0
0
0
0
chr1:160718304-160719611 chr1:160719883-160720094
0
0
0
1
1
0

0
1
1
0
0
0

57

chr1:160720213-160721976
chr1:160721238-160721976
chr1:160722038-160722896

chr1:160709146-160717984
chr1:160709146-160719611
chr1:160718304-160719611
chr1:160719883-160720094
chr1:160719922-160720094
chr1:160720213-160721135
chr1:160720213-160721976
chr1:160721238-160721976
chr1:160722038-160722896

chr1:160709146-160717984
chr1:160709146-160719611
chr1:160718304-160719611
chr1:160719883-160720094
chr1:160719922-160720094
chr1:160720213-160721135
chr1:160720213-160721976
chr1:160721238-160721976
chr1:160722038-160722896

chr1:160709146-160717984
chr1:160709146-160719611
chr1:160718304-160719611
chr1:160719883-160720094
chr1:160719922-160720094
chr1:160720213-160721135
chr1:160720213-160721976
chr1:160721238-160721976
chr1:160722038-160722896

$Rest$SLC41A1

chr1:205760846-205763998
chr1:205764146-205764472
chr1:205764606-205766052
chr1:205766131-205767032
chr1:205767179-205767797
chr1:205767943-205768085
chr1:205768229-205768887
chr1:205768958-205770081
chr1:205770188-205779198
chr1:205780215-205781936

chr1:205760846-205763998
chr1:205764146-205764472
chr1:205764606-205766052
chr1:205766131-205767032

0
0
0

0
0
0
1
1
0
0
0
0

0
0
0
chr1:160719922-160720094 chr1:160720213-160721135
0
0
0
0
0
1
1
0
0
chr1:160720213-160721976 chr1:160721238-160721976
0
0
0
0
0
0
1
1
0

0
0
0
0
0
1
1
1
0
chr1:160722038-160722896
0
0
0
0
0
0
0
0
1

1
0
0
0
0
0
0
0
0
0

chr1:205760846-205763998 chr1:205764146-205764472
0
1
0
0
0
0
0
0
0
0
chr1:205764606-205766052 chr1:205766131-205767032
0
0
0
1

0
0
1
0

58

chr1:205767179-205767797
chr1:205767943-205768085
chr1:205768229-205768887
chr1:205768958-205770081
chr1:205770188-205779198
chr1:205780215-205781936

chr1:205760846-205763998
chr1:205764146-205764472
chr1:205764606-205766052
chr1:205766131-205767032
chr1:205767179-205767797
chr1:205767943-205768085
chr1:205768229-205768887
chr1:205768958-205770081
chr1:205770188-205779198
chr1:205780215-205781936

chr1:205760846-205763998
chr1:205764146-205764472
chr1:205764606-205766052
chr1:205766131-205767032
chr1:205767179-205767797
chr1:205767943-205768085
chr1:205768229-205768887
chr1:205768958-205770081
chr1:205770188-205779198
chr1:205780215-205781936

chr1:205760846-205763998
chr1:205764146-205764472
chr1:205764606-205766052
chr1:205766131-205767032
chr1:205767179-205767797
chr1:205767943-205768085
chr1:205768229-205768887
chr1:205768958-205770081
chr1:205770188-205779198
chr1:205780215-205781936

$Rest$TFAP2E

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
1
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
0
chr1:205767179-205767797 chr1:205767943-205768085
0
0
0
0
0
1
0
0
0
0
chr1:205768229-205768887 chr1:205768958-205770081
0
0
0
0
0
0
0
1
0
0
chr1:205770188-205779198 chr1:205780215-205781936
0
0
0
0
0
0
0
0
0
1

0
0
0
0
0
0
1
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
0
1
0

chr1:36040299-36042923
chr1:36043093-36070834

chr1:36040299-36042923 chr1:36043093-36070834
0
1

1
0

$Rest$`TFAP2E-AS1`

chr1:36040299-36042923
chr1:36043093-36070834

chr1:36040299-36042923 chr1:36043093-36070834
0
1

1
0

$Rest$TMEM51

59

chr1:15479280-15541391
chr1:15480450-15541391
chr1:15541927-15545822
chr1:15480450-15536986
chr1:15537058-15541391

chr1:15479280-15541391
chr1:15480450-15541391
chr1:15541927-15545822
chr1:15480450-15536986
chr1:15537058-15541391

chr1:15479280-15541391
chr1:15480450-15541391
chr1:15541927-15545822
chr1:15480450-15536986
chr1:15537058-15541391

$Rest$`TMEM51-AS1`

1
1
0
1
1

chr1:15479280-15541391 chr1:15480450-15541391
1
1
0
1
1
chr1:15541927-15545822 chr1:15480450-15536986
1
1
0
1
0

0
0
1
0
0
chr1:15537058-15541391
1
1
0
0
1

chr1:15479280-15541391

chr1:15479280-15541391
1

$Rest$`TMEM51-AS2`

chr1:15479280-15541391
chr1:15480450-15541391
chr1:15480450-15536986

chr1:15479280-15541391
chr1:15480450-15541391
chr1:15480450-15536986

$Rest$TMEM63A

chr1:15479280-15541391 chr1:15480450-15541391
1
1
1

1
1
1
chr1:15480450-15536986
1
1
1

chr1:226034633-226034735
chr1:226034914-226036193
chr1:226036255-226036598
chr1:226036713-226037613
chr1:226037780-226040365
chr1:226040470-226041330
chr1:226041492-226043579
chr1:226043641-226044353
chr1:226044439-226044611
chr1:226044717-226046896
chr1:226047049-226048560
chr1:226048697-226049918
chr1:226050051-226050155
chr1:226050278-226050471
chr1:226050551-226053597
chr1:226053667-226054274

chr1:226034633-226034735 chr1:226034914-226036193
0
1
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
0
0
0
0

1
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
0
0
0
0
0

60

chr1:226054382-226054812
chr1:226054863-226055588
chr1:226055730-226058776
chr1:226058813-226059687
chr1:226059753-226061988
chr1:226062067-226065095
chr1:226065294-226066920
chr1:226067110-226070004

chr1:226034633-226034735
chr1:226034914-226036193
chr1:226036255-226036598
chr1:226036713-226037613
chr1:226037780-226040365
chr1:226040470-226041330
chr1:226041492-226043579
chr1:226043641-226044353
chr1:226044439-226044611
chr1:226044717-226046896
chr1:226047049-226048560
chr1:226048697-226049918
chr1:226050051-226050155
chr1:226050278-226050471
chr1:226050551-226053597
chr1:226053667-226054274
chr1:226054382-226054812
chr1:226054863-226055588
chr1:226055730-226058776
chr1:226058813-226059687
chr1:226059753-226061988
chr1:226062067-226065095
chr1:226065294-226066920
chr1:226067110-226070004

chr1:226034633-226034735
chr1:226034914-226036193
chr1:226036255-226036598
chr1:226036713-226037613
chr1:226037780-226040365
chr1:226040470-226041330
chr1:226041492-226043579
chr1:226043641-226044353
chr1:226044439-226044611
chr1:226044717-226046896
chr1:226047049-226048560
chr1:226048697-226049918
chr1:226050051-226050155
chr1:226050278-226050471
chr1:226050551-226053597
chr1:226053667-226054274
chr1:226054382-226054812

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
1
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
0

0
0
0
0
0
0
0
0
chr1:226036255-226036598 chr1:226036713-226037613
0
0
0
1
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
chr1:226037780-226040365 chr1:226040470-226041330
0
0
0
0
0
1
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
0

0
0
0
0
1
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
0
0

61

chr1:226054863-226055588
chr1:226055730-226058776
chr1:226058813-226059687
chr1:226059753-226061988
chr1:226062067-226065095
chr1:226065294-226066920
chr1:226067110-226070004

chr1:226034633-226034735
chr1:226034914-226036193
chr1:226036255-226036598
chr1:226036713-226037613
chr1:226037780-226040365
chr1:226040470-226041330
chr1:226041492-226043579
chr1:226043641-226044353
chr1:226044439-226044611
chr1:226044717-226046896
chr1:226047049-226048560
chr1:226048697-226049918
chr1:226050051-226050155
chr1:226050278-226050471
chr1:226050551-226053597
chr1:226053667-226054274
chr1:226054382-226054812
chr1:226054863-226055588
chr1:226055730-226058776
chr1:226058813-226059687
chr1:226059753-226061988
chr1:226062067-226065095
chr1:226065294-226066920
chr1:226067110-226070004

chr1:226034633-226034735
chr1:226034914-226036193
chr1:226036255-226036598
chr1:226036713-226037613
chr1:226037780-226040365
chr1:226040470-226041330
chr1:226041492-226043579
chr1:226043641-226044353
chr1:226044439-226044611
chr1:226044717-226046896
chr1:226047049-226048560
chr1:226048697-226049918
chr1:226050051-226050155
chr1:226050278-226050471
chr1:226050551-226053597
chr1:226053667-226054274
chr1:226054382-226054812
chr1:226054863-226055588

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
0
0
0
1
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
0
0
0
0
chr1:226041492-226043579 chr1:226043641-226044353
0
0
0
0
0
0
0
1
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
0
0
0
0
0
0
chr1:226044439-226044611 chr1:226044717-226046896
0
0
0
0
0
0
0
0
0
1
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
0
0
0
0
0
0
1
0
0
0
0
0
0
0
0
0

62

chr1:226055730-226058776
chr1:226058813-226059687
chr1:226059753-226061988
chr1:226062067-226065095
chr1:226065294-226066920
chr1:226067110-226070004

chr1:226034633-226034735
chr1:226034914-226036193
chr1:226036255-226036598
chr1:226036713-226037613
chr1:226037780-226040365
chr1:226040470-226041330
chr1:226041492-226043579
chr1:226043641-226044353
chr1:226044439-226044611
chr1:226044717-226046896
chr1:226047049-226048560
chr1:226048697-226049918
chr1:226050051-226050155
chr1:226050278-226050471
chr1:226050551-226053597
chr1:226053667-226054274
chr1:226054382-226054812
chr1:226054863-226055588
chr1:226055730-226058776
chr1:226058813-226059687
chr1:226059753-226061988
chr1:226062067-226065095
chr1:226065294-226066920
chr1:226067110-226070004

chr1:226034633-226034735
chr1:226034914-226036193
chr1:226036255-226036598
chr1:226036713-226037613
chr1:226037780-226040365
chr1:226040470-226041330
chr1:226041492-226043579
chr1:226043641-226044353
chr1:226044439-226044611
chr1:226044717-226046896
chr1:226047049-226048560
chr1:226048697-226049918
chr1:226050051-226050155
chr1:226050278-226050471
chr1:226050551-226053597
chr1:226053667-226054274
chr1:226054382-226054812
chr1:226054863-226055588
chr1:226055730-226058776

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
0
0
0
0
0
0
1
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
0
0
0

0
0
0
0
0
0
chr1:226047049-226048560 chr1:226048697-226049918
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
0
1
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
0
0
chr1:226050051-226050155 chr1:226050278-226050471
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
0
0
0
1
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
0
0
0
0
0
0
0
1
0
0
0
0
0
0

63

chr1:226058813-226059687
chr1:226059753-226061988
chr1:226062067-226065095
chr1:226065294-226066920
chr1:226067110-226070004

chr1:226034633-226034735
chr1:226034914-226036193
chr1:226036255-226036598
chr1:226036713-226037613
chr1:226037780-226040365
chr1:226040470-226041330
chr1:226041492-226043579
chr1:226043641-226044353
chr1:226044439-226044611
chr1:226044717-226046896
chr1:226047049-226048560
chr1:226048697-226049918
chr1:226050051-226050155
chr1:226050278-226050471
chr1:226050551-226053597
chr1:226053667-226054274
chr1:226054382-226054812
chr1:226054863-226055588
chr1:226055730-226058776
chr1:226058813-226059687
chr1:226059753-226061988
chr1:226062067-226065095
chr1:226065294-226066920
chr1:226067110-226070004

chr1:226034633-226034735
chr1:226034914-226036193
chr1:226036255-226036598
chr1:226036713-226037613
chr1:226037780-226040365
chr1:226040470-226041330
chr1:226041492-226043579
chr1:226043641-226044353
chr1:226044439-226044611
chr1:226044717-226046896
chr1:226047049-226048560
chr1:226048697-226049918
chr1:226050051-226050155
chr1:226050278-226050471
chr1:226050551-226053597
chr1:226053667-226054274
chr1:226054382-226054812
chr1:226054863-226055588
chr1:226055730-226058776
chr1:226058813-226059687

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
0
0
0
0
0
0
0
0
0
1
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
0
0
0
0
chr1:226050551-226053597 chr1:226053667-226054274
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
0
0
0
0
0
1
0
0
0
0
0
0
0
0
chr1:226054382-226054812 chr1:226054863-226055588
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
0
0
0
0
0
0
0
1
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
0
0
0
0
0
0
0
0
1
0
0
0

64

chr1:226059753-226061988
chr1:226062067-226065095
chr1:226065294-226066920
chr1:226067110-226070004

chr1:226034633-226034735
chr1:226034914-226036193
chr1:226036255-226036598
chr1:226036713-226037613
chr1:226037780-226040365
chr1:226040470-226041330
chr1:226041492-226043579
chr1:226043641-226044353
chr1:226044439-226044611
chr1:226044717-226046896
chr1:226047049-226048560
chr1:226048697-226049918
chr1:226050051-226050155
chr1:226050278-226050471
chr1:226050551-226053597
chr1:226053667-226054274
chr1:226054382-226054812
chr1:226054863-226055588
chr1:226055730-226058776
chr1:226058813-226059687
chr1:226059753-226061988
chr1:226062067-226065095
chr1:226065294-226066920
chr1:226067110-226070004

chr1:226034633-226034735
chr1:226034914-226036193
chr1:226036255-226036598
chr1:226036713-226037613
chr1:226037780-226040365
chr1:226040470-226041330
chr1:226041492-226043579
chr1:226043641-226044353
chr1:226044439-226044611
chr1:226044717-226046896
chr1:226047049-226048560
chr1:226048697-226049918
chr1:226050051-226050155
chr1:226050278-226050471
chr1:226050551-226053597
chr1:226053667-226054274
chr1:226054382-226054812
chr1:226054863-226055588
chr1:226055730-226058776
chr1:226058813-226059687
chr1:226059753-226061988

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
0
0
1
0
0
0
0
0

0
0
0
0
chr1:226055730-226058776 chr1:226058813-226059687
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
0
0
0
0
0
0
0
0
0
1
0
0
0
0
chr1:226059753-226061988 chr1:226062067-226065095
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
0
1

65

chr1:226062067-226065095
chr1:226065294-226066920
chr1:226067110-226070004

chr1:226034633-226034735
chr1:226034914-226036193
chr1:226036255-226036598
chr1:226036713-226037613
chr1:226037780-226040365
chr1:226040470-226041330
chr1:226041492-226043579
chr1:226043641-226044353
chr1:226044439-226044611
chr1:226044717-226046896
chr1:226047049-226048560
chr1:226048697-226049918
chr1:226050051-226050155
chr1:226050278-226050471
chr1:226050551-226053597
chr1:226053667-226054274
chr1:226054382-226054812
chr1:226054863-226055588
chr1:226055730-226058776
chr1:226058813-226059687
chr1:226059753-226061988
chr1:226062067-226065095
chr1:226065294-226066920
chr1:226067110-226070004

0
0
0

1
0
0
chr1:226065294-226066920 chr1:226067110-226070004
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
0
0
0
1

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
0
0
1
0

$Rest$TNFRSF1B

chr1:12227226-12248853
chr1:12248952-12251014
chr1:12251142-12251831
chr1:12251980-12252488
chr1:12252581-12252920
chr1:12253155-12254012
chr1:12254089-12254641
chr1:12254675-12262024
chr1:12262228-12266797
chr1:12227226-12251014

chr1:12227226-12248853
chr1:12248952-12251014
chr1:12251142-12251831
chr1:12251980-12252488
chr1:12252581-12252920
chr1:12253155-12254012
chr1:12254089-12254641
chr1:12254675-12262024
chr1:12262228-12266797

1
0
0
0
0
0
0
0
0
1

chr1:12227226-12248853 chr1:12248952-12251014
0
1
0
0
0
0
0
0
0
1
chr1:12251142-12251831 chr1:12251980-12252488
0
0
0
1
0
0
0
0
0

0
0
1
0
0
0
0
0
0

66

chr1:12227226-12251014

chr1:12227226-12248853
chr1:12248952-12251014
chr1:12251142-12251831
chr1:12251980-12252488
chr1:12252581-12252920
chr1:12253155-12254012
chr1:12254089-12254641
chr1:12254675-12262024
chr1:12262228-12266797
chr1:12227226-12251014

chr1:12227226-12248853
chr1:12248952-12251014
chr1:12251142-12251831
chr1:12251980-12252488
chr1:12252581-12252920
chr1:12253155-12254012
chr1:12254089-12254641
chr1:12254675-12262024
chr1:12262228-12266797
chr1:12227226-12251014

chr1:12227226-12248853
chr1:12248952-12251014
chr1:12251142-12251831
chr1:12251980-12252488
chr1:12252581-12252920
chr1:12253155-12254012
chr1:12254089-12254641
chr1:12254675-12262024
chr1:12262228-12266797
chr1:12227226-12251014

$Rest$UQCRH

chr1:46769492-46774773
chr1:46774799-46775827
chr1:46775716-46775827
chr1:46775988-46782224
chr1:46774799-46775569

chr1:46769492-46774773
chr1:46774799-46775827
chr1:46775716-46775827
chr1:46775988-46782224
chr1:46774799-46775569

chr1:46769492-46774773
chr1:46774799-46775827

0

0
0
0
0
1
0
0
0
0
0

0
chr1:12252581-12252920 chr1:12253155-12254012
0
0
0
0
0
1
0
0
0
0
chr1:12254089-12254641 chr1:12254675-12262024
0
0
0
0
0
0
0
1
0
0
chr1:12262228-12266797 chr1:12227226-12251014
1
1
0
0
0
0
0
0
0
1

0
0
0
0
0
0
1
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
0
1
0

1
0
0
0
0

chr1:46769492-46774773 chr1:46774799-46775827
0
1
1
0
1
chr1:46775716-46775827 chr1:46775988-46782224
0
0
0
1
0

0
1
1
0
0
chr1:46774799-46775569
0
1

67

chr1:46775716-46775827
chr1:46775988-46782224
chr1:46774799-46775569

0
0
1

$genesJunction
$genesJunction$CMPK1
[1] "chr1:47799788-47834141" "chr1:47834287-47838627" "chr1:47838779-47840581"
[4] "chr1:47838779-47840869" "chr1:47840657-47840869" "chr1:47840965-47842376"

$genesJunction$CSF1

[1] "chr1:110453684-110456881" "chr1:110457003-110458256" "chr1:110458318-110459915"
[4] "chr1:110460085-110464469" "chr1:110464616-110465788" "chr1:110464616-110466682"
[7] "chr1:110466812-110467398" "chr1:110467450-110467769" "chr1:110467824-110468685"

[10] "chr1:110467824-110471474"

$genesJunction$FAM72B
[1] "chr1:120839865-120841975" "chr1:120839985-120841975" "chr1:120842052-120845995"
[4] "chr1:120846119-120854492"

$genesJunction$KCNAB2
[1] "chr1:6046387-6052304"

$genesJunction$KLHL12

[1] "chr1:202861787-202862367" "chr1:202861787-202863312" "chr1:202862553-202863312"
[4] "chr1:202863410-202863719" "chr1:202863877-202864650" "chr1:202863877-202878138"
[7] "chr1:202864845-202865982" "chr1:202866088-202878138" "chr1:202878252-202880182"
[10] "chr1:202880331-202887299" "chr1:202887516-202888883" "chr1:202889036-202894096"
[13] "chr1:202894335-202896217"

$genesJunction$KLHL21
[1] "chr1:6653718-6655545" "chr1:6655617-6659107" "chr1:6659512-6659810"
[4] "chr1:6659512-6661857"

$genesJunction$LOC105371470
[1] "chr1:160709146-160717984" "chr1:160709146-160719611" "chr1:160718304-160719611"
[4] "chr1:160719883-160720094" "chr1:160719922-160720094" "chr1:160720213-160721135"
[7] "chr1:160720213-160721976" "chr1:160721238-160721976" "chr1:160722038-160722896"

$genesJunction$MIR4632
[1] "chr1:12251142-12251831"

$genesJunction$MYSM1

[1] "chr1:59125827-59126842" "chr1:59126899-59127078" "chr1:59127183-59131171"
[4] "chr1:59131303-59132710" "chr1:59132898-59133519" "chr1:59133593-59134102"
[7] "chr1:59133593-59134304" "chr1:59134238-59134656" "chr1:59134354-59134656"
[10] "chr1:59134710-59137542" "chr1:59137630-59139245" "chr1:59139322-59141149"
[13] "chr1:59141252-59142598" "chr1:59142728-59147457" "chr1:59148217-59150825"
[16] "chr1:59150923-59154710" "chr1:59154788-59155898" "chr1:59155921-59156012"
[19] "chr1:59156089-59158533" "chr1:59158603-59160801" "chr1:59160879-59165657"

68

$genesJunction$NPHP4

[1] "chr1:5923465-5923950" "chr1:5924093-5924398" "chr1:5924577-5925162"
[4] "chr1:5925333-5926433" "chr1:5926518-5927090" "chr1:5927175-5927800"
[7] "chr1:5927956-5933312" "chr1:5933395-5934531" "chr1:5937358-5940174"
[10] "chr1:5940299-5947346" "chr1:5947526-5950928" "chr1:5951088-5964677"
[13] "chr1:5964864-5965352" "chr1:5965543-5965692" "chr1:5965843-5967175"
[16] "chr1:5967282-5969212" "chr1:5969273-5987709" "chr1:5987847-5993207"
[19] "chr1:5993389-6007164" "chr1:6007290-6008130" "chr1:6008311-6012760"
[22] "chr1:6012896-6021854" "chr1:6022009-6027359" "chr1:6027423-6029147"
[25] "chr1:6029319-6038330" "chr1:6038473-6046215" "chr1:6046387-6052304"
[28] "chr1:5934717-5934934" "chr1:5965840-5967175" "chr1:5936583-5937153"
[31] "chr1:5937358-5939406" "chr1:5939692-5940174"

$genesJunction$PEX14
[1] "chr1:10637247-10637871" "chr1:10659423-10678389" "chr1:10678474-10683076"
[4] "chr1:10683178-10684397" "chr1:10684494-10687329" "chr1:10687420-10689588"
[7] "chr1:10596354-10659295" "chr1:10596354-10678389"

$genesJunction$PIP5K1A

[1] "chr1:151171557-151196721" "chr1:151171557-151196724" "chr1:151196755-151199796"
[4] "chr1:151199876-151204147" "chr1:151204277-151204724" "chr1:151204841-151205027"
[7] "chr1:151205179-151206673" "chr1:151206972-151209034" "chr1:151209239-151210658"
[10] "chr1:151209239-151211606" "chr1:151210741-151211606" "chr1:151211654-151212431"
[13] "chr1:151212515-151214599" "chr1:151212515-151219396" "chr1:151214745-151214914"
[16] "chr1:151215043-151219396" "chr1:151219441-151220339" "chr1:151196755-151196847"
[19] "chr1:151196882-151199796" "chr1:151212515-151214914"

$genesJunction$PSMB2
[1] "chr1:36068975-36070834" "chr1:36070883-36074847" "chr1:36075009-36096875"
[4] "chr1:36096945-36101911" "chr1:36102033-36106943" "chr1:36043093-36070834"

$genesJunction$RBBP4

[1] "chr1:33116923-33117515" "chr1:33117662-33123028" "chr1:33123173-33133826"
[4] "chr1:33133999-33134340" "chr1:33134455-33134573" "chr1:33134733-33134832"
[7] "chr1:33134958-33135087" "chr1:33135164-33138051" "chr1:33138127-33138243"
[10] "chr1:33138300-33138392" "chr1:33138502-33145241" "chr1:33116923-33117518"

$genesJunction$RBBP5

[1] "chr1:205057943-205064001" "chr1:205057943-205064115" "chr1:205064192-205065810"
[4] "chr1:205066039-205066454" "chr1:205066523-205068117" "chr1:205068234-205068869"
[7] "chr1:205068940-205069039" "chr1:205069192-205069280" "chr1:205069399-205070728"
[10] "chr1:205070837-205072985" "chr1:205073147-205074156" "chr1:205074296-205083917"
[13] "chr1:205084033-205084986" "chr1:205084089-205084986" "chr1:205085011-205090983"
[16] "chr1:205057940-205064001"

$genesJunction$RERE

[1] "chr1:8415180-8415479" "chr1:8415659-8416160" "chr1:8416306-8418256"
[4] "chr1:8418976-8419824" "chr1:8420046-8420172" "chr1:8421550-8421823"
[7] "chr1:8421936-8422743" "chr1:8422904-8424116" "chr1:8424315-8424806"
[10] "chr1:8424898-8425872" "chr1:8426034-8482787" "chr1:8482867-8525985"
[13] "chr1:8526083-8555123" "chr1:8555222-8557465" "chr1:8557589-8568686"

69

[16] "chr1:8568734-8601273" "chr1:8601377-8616534" "chr1:8616630-8617477"
[19] "chr1:8617582-8674620" "chr1:8674745-8684369" "chr1:8684439-8716032"
[22] "chr1:8716500-8813490" "chr1:8716500-8877219" "chr1:8482867-8483621"
[25] "chr1:8852647-8877219" "chr1:8716500-8852463"

$genesJunction$`RERE-AS1`
[1] "chr1:8482867-8525985"

$genesJunction$SLAMF7
[1] "chr1:160709146-160717984" "chr1:160709146-160719611" "chr1:160718304-160719611"
[4] "chr1:160719883-160720094" "chr1:160719922-160720094" "chr1:160720213-160721135"
[7] "chr1:160720213-160721976" "chr1:160721238-160721976" "chr1:160722038-160722896"

$genesJunction$SLC41A1

[1] "chr1:205760846-205763998" "chr1:205764146-205764472" "chr1:205764606-205766052"
[4] "chr1:205766131-205767032" "chr1:205767179-205767797" "chr1:205767943-205768085"
[7] "chr1:205768229-205768887" "chr1:205768958-205770081" "chr1:205770188-205779198"

[10] "chr1:205780215-205781936"

$genesJunction$TFAP2E
[1] "chr1:36040299-36042923" "chr1:36043093-36070834"

$genesJunction$`TFAP2E-AS1`
[1] "chr1:36040299-36042923" "chr1:36043093-36070834"

$genesJunction$TMEM51
[1] "chr1:15479280-15541391" "chr1:15480450-15541391" "chr1:15541927-15545822"
[4] "chr1:15480450-15536986" "chr1:15537058-15541391"

$genesJunction$`TMEM51-AS1`
[1] "chr1:15479280-15541391"

$genesJunction$`TMEM51-AS2`
[1] "chr1:15479280-15541391" "chr1:15480450-15541391" "chr1:15480450-15536986"

$genesJunction$TMEM63A

[1] "chr1:226034633-226034735" "chr1:226034914-226036193" "chr1:226036255-226036598"
[4] "chr1:226036713-226037613" "chr1:226037780-226040365" "chr1:226040470-226041330"
[7] "chr1:226041492-226043579" "chr1:226043641-226044353" "chr1:226044439-226044611"
[10] "chr1:226044717-226046896" "chr1:226047049-226048560" "chr1:226048697-226049918"
[13] "chr1:226050051-226050155" "chr1:226050278-226050471" "chr1:226050551-226053597"
[16] "chr1:226053667-226054274" "chr1:226054382-226054812" "chr1:226054863-226055588"
[19] "chr1:226055730-226058776" "chr1:226058813-226059687" "chr1:226059753-226061988"
[22] "chr1:226062067-226065095" "chr1:226065294-226066920" "chr1:226067110-226070004"

$genesJunction$TNFRSF1B

[1] "chr1:12227226-12248853" "chr1:12248952-12251014" "chr1:12251142-12251831"
[4] "chr1:12251980-12252488" "chr1:12252581-12252920" "chr1:12253155-12254012"
[7] "chr1:12254089-12254641" "chr1:12254675-12262024" "chr1:12262228-12266797"

[10] "chr1:12227226-12251014"

70

$genesJunction$UQCRH
[1] "chr1:46769492-46774773" "chr1:46774799-46775827" "chr1:46775716-46775827"
[4] "chr1:46775988-46782224" "chr1:46774799-46775569"

$juncexpressed

"chr1:47834287-47838627"
"chr1:47838779-47840869"
"chr1:47840965-47842376"

[1] "chr1:47799788-47834141"
[3] "chr1:47838779-47840581"
[5] "chr1:47840657-47840869"
[7] "chr1:110453684-110456881" "chr1:110457003-110458256"
[9] "chr1:110458318-110459915" "chr1:110460085-110464469"
[11] "chr1:110464616-110465788" "chr1:110464616-110466682"
[13] "chr1:110466812-110467398" "chr1:110467450-110467769"
[15] "chr1:110467824-110468685" "chr1:110467824-110471474"
[17] "chr1:120839865-120841975" "chr1:120839985-120841975"
[19] "chr1:120842052-120845995" "chr1:120846119-120854492"
[21] "chr1:202861787-202862367" "chr1:202861787-202863312"
[23] "chr1:202862553-202863312" "chr1:202863410-202863719"
[25] "chr1:202863877-202864650" "chr1:202863877-202878138"
[27] "chr1:202864845-202865982" "chr1:202866088-202878138"
[29] "chr1:202878252-202880182" "chr1:202880331-202887299"
[31] "chr1:202887516-202888883" "chr1:202889036-202894096"
[33] "chr1:202894335-202896217" "chr1:6653718-6655545"
"chr1:6659512-6659810"
[35] "chr1:6655617-6659107"
"chr1:59125827-59126842"
[37] "chr1:6659512-6661857"
"chr1:59127183-59131171"
[39] "chr1:59126899-59127078"
"chr1:59132898-59133519"
[41] "chr1:59131303-59132710"
"chr1:59133593-59134304"
[43] "chr1:59133593-59134102"
"chr1:59134354-59134656"
[45] "chr1:59134238-59134656"
"chr1:59137630-59139245"
[47] "chr1:59134710-59137542"
"chr1:59141252-59142598"
[49] "chr1:59139322-59141149"
"chr1:59148217-59150825"
[51] "chr1:59142728-59147457"
"chr1:59154788-59155898"
[53] "chr1:59150923-59154710"
"chr1:59156089-59158533"
[55] "chr1:59155921-59156012"
"chr1:59160879-59165657"
[57] "chr1:59158603-59160801"
"chr1:5924093-5924398"
[59] "chr1:5923465-5923950"
"chr1:5925333-5926433"
[61] "chr1:5924577-5925162"
"chr1:5927175-5927800"
[63] "chr1:5926518-5927090"
"chr1:5933395-5934531"
[65] "chr1:5927956-5933312"
"chr1:5940299-5947346"
[67] "chr1:5937358-5940174"
"chr1:5951088-5964677"
[69] "chr1:5947526-5950928"
"chr1:5965543-5965692"
[71] "chr1:5964864-5965352"
"chr1:5967282-5969212"
[73] "chr1:5965843-5967175"
"chr1:5987847-5993207"
[75] "chr1:5969273-5987709"
"chr1:6007290-6008130"
[77] "chr1:5993389-6007164"
"chr1:6012896-6021854"
[79] "chr1:6008311-6012760"
"chr1:6027423-6029147"
[81] "chr1:6022009-6027359"
"chr1:6038473-6046215"
[83] "chr1:6029319-6038330"
"chr1:5934717-5934934"
[85] "chr1:6046387-6052304"
"chr1:5936583-5937153"
[87] "chr1:5965840-5967175"
"chr1:5939692-5940174"
[89] "chr1:5937358-5939406"

71

"chr1:10659423-10678389"
"chr1:10683178-10684397"
"chr1:10687420-10689588"
"chr1:10596354-10678389"

[91] "chr1:10637247-10637871"
[93] "chr1:10678474-10683076"
[95] "chr1:10684494-10687329"
[97] "chr1:10596354-10659295"
[99] "chr1:151171557-151196721" "chr1:151171557-151196724"
[101] "chr1:151196755-151199796" "chr1:151199876-151204147"
[103] "chr1:151204277-151204724" "chr1:151204841-151205027"
[105] "chr1:151205179-151206673" "chr1:151206972-151209034"
[107] "chr1:151209239-151210658" "chr1:151209239-151211606"
[109] "chr1:151210741-151211606" "chr1:151211654-151212431"
[111] "chr1:151212515-151214599" "chr1:151212515-151219396"
[113] "chr1:151214745-151214914" "chr1:151215043-151219396"
[115] "chr1:151219441-151220339" "chr1:151196755-151196847"
[117] "chr1:151196882-151199796" "chr1:151212515-151214914"
"chr1:36068975-36070834"
[119] "chr1:36040299-36042923"
"chr1:36075009-36096875"
[121] "chr1:36070883-36074847"
"chr1:36102033-36106943"
[123] "chr1:36096945-36101911"
"chr1:33116923-33117515"
[125] "chr1:36043093-36070834"
"chr1:33123173-33133826"
[127] "chr1:33117662-33123028"
"chr1:33134455-33134573"
[129] "chr1:33133999-33134340"
"chr1:33134958-33135087"
[131] "chr1:33134733-33134832"
"chr1:33138127-33138243"
[133] "chr1:33135164-33138051"
"chr1:33138502-33145241"
[135] "chr1:33138300-33138392"
[137] "chr1:33116923-33117518"
"chr1:205057943-205064001"
[139] "chr1:205057943-205064115" "chr1:205064192-205065810"
[141] "chr1:205066039-205066454" "chr1:205066523-205068117"
[143] "chr1:205068234-205068869" "chr1:205068940-205069039"
[145] "chr1:205069192-205069280" "chr1:205069399-205070728"
[147] "chr1:205070837-205072985" "chr1:205073147-205074156"
[149] "chr1:205074296-205083917" "chr1:205084033-205084986"
[151] "chr1:205084089-205084986" "chr1:205085011-205090983"
[153] "chr1:205057940-205064001" "chr1:8415180-8415479"
"chr1:8416306-8418256"
[155] "chr1:8415659-8416160"
"chr1:8420046-8420172"
[157] "chr1:8418976-8419824"
"chr1:8421936-8422743"
[159] "chr1:8421550-8421823"
"chr1:8424315-8424806"
[161] "chr1:8422904-8424116"
"chr1:8426034-8482787"
[163] "chr1:8424898-8425872"
"chr1:8526083-8555123"
[165] "chr1:8482867-8525985"
"chr1:8557589-8568686"
[167] "chr1:8555222-8557465"
"chr1:8601377-8616534"
[169] "chr1:8568734-8601273"
"chr1:8617582-8674620"
[171] "chr1:8616630-8617477"
"chr1:8684439-8716032"
[173] "chr1:8674745-8684369"
"chr1:8716500-8877219"
[175] "chr1:8716500-8813490"
"chr1:8852647-8877219"
[177] "chr1:8482867-8483621"
[179] "chr1:8716500-8852463"
"chr1:160709146-160717984"
[181] "chr1:160709146-160719611" "chr1:160718304-160719611"
[183] "chr1:160719883-160720094" "chr1:160719922-160720094"
[185] "chr1:160720213-160721135" "chr1:160720213-160721976"
[187] "chr1:160721238-160721976" "chr1:160722038-160722896"
[189] "chr1:205760846-205763998" "chr1:205764146-205764472"
[191] "chr1:205764606-205766052" "chr1:205766131-205767032"

72

[193] "chr1:205767179-205767797" "chr1:205767943-205768085"
[195] "chr1:205768229-205768887" "chr1:205768958-205770081"
[197] "chr1:205770188-205779198" "chr1:205780215-205781936"
"chr1:15480450-15541391"
[199] "chr1:15479280-15541391"
"chr1:15480450-15536986"
[201] "chr1:15541927-15545822"
[203] "chr1:15537058-15541391"
"chr1:226034633-226034735"
[205] "chr1:226034914-226036193" "chr1:226036255-226036598"
[207] "chr1:226036713-226037613" "chr1:226037780-226040365"
[209] "chr1:226040470-226041330" "chr1:226041492-226043579"
[211] "chr1:226043641-226044353" "chr1:226044439-226044611"
[213] "chr1:226044717-226046896" "chr1:226047049-226048560"
[215] "chr1:226048697-226049918" "chr1:226050051-226050155"
[217] "chr1:226050278-226050471" "chr1:226050551-226053597"
[219] "chr1:226053667-226054274" "chr1:226054382-226054812"
[221] "chr1:226054863-226055588" "chr1:226055730-226058776"
[223] "chr1:226058813-226059687" "chr1:226059753-226061988"
[225] "chr1:226062067-226065095" "chr1:226065294-226066920"
[227] "chr1:226067110-226070004" "chr1:12227226-12248853"
"chr1:12251142-12251831"
[229] "chr1:12248952-12251014"
"chr1:12252581-12252920"
[231] "chr1:12251980-12252488"
"chr1:12254089-12254641"
[233] "chr1:12253155-12254012"
"chr1:12262228-12266797"
[235] "chr1:12254675-12262024"
"chr1:46769492-46774773"
[237] "chr1:12227226-12251014"
"chr1:46775716-46775827"
[239] "chr1:46774799-46775827"
"chr1:46774799-46775569"
[241] "chr1:46775988-46782224"

> print(overlapMat[["Rest"]][["CMPK1"]])

chr1:47799788-47834141
chr1:47834287-47838627
chr1:47838779-47840581
chr1:47838779-47840869
chr1:47840657-47840869
chr1:47840965-47842376

chr1:47799788-47834141
chr1:47834287-47838627
chr1:47838779-47840581
chr1:47838779-47840869
chr1:47840657-47840869
chr1:47840965-47842376

chr1:47799788-47834141
chr1:47834287-47838627
chr1:47838779-47840581
chr1:47838779-47840869
chr1:47840657-47840869
chr1:47840965-47842376

chr1:47799788-47834141
chr1:47834287-47838627

1
0
0
0
0
0

chr1:47799788-47834141 chr1:47834287-47838627
0
1
0
0
0
0
chr1:47838779-47840581 chr1:47838779-47840869
0
0
1
1
1
0
chr1:47840657-47840869 chr1:47840965-47842376
0
0
0
0
0
1
chr1:47799788-47834141 chr1:47834287-47838627
0
1

0
0
0
1
1
0

0
0
1
1
0
0

1
0

73

chr1:47838779-47840581
chr1:47838779-47840869
chr1:47840657-47840869
chr1:47840965-47842376

chr1:47799788-47834141
chr1:47834287-47838627
chr1:47838779-47840581
chr1:47838779-47840869
chr1:47840657-47840869
chr1:47840965-47842376

chr1:47799788-47834141
chr1:47834287-47838627
chr1:47838779-47840581
chr1:47838779-47840869
chr1:47840657-47840869
chr1:47840965-47842376

>

0
0
0
0

0
0
0
0
chr1:47838779-47840581 chr1:47838779-47840869
0
0
1
1
1
0
chr1:47840657-47840869 chr1:47840965-47842376
0
0
0
0
0
1

0
0
1
1
0
0

0
0
0
1
1
0

Another important function is kendall-τ restricted.

> V <- cbind(c(1,5,3),c(3,2,1))

[,1] [,2]
3
2
1

1
5
3

[1,]
[2,]
[3,]

> rownames(V) <- c("F1","F2","F3")

[1] "F1" "F2" "F3"

> colnames(V) <- c("S1","S2")

[1] "S1" "S2"

> GSReg.kendall.tau.distance(V)

S2
S1
S1 0.0000000 0.6666667
S2 0.6666667 0.0000000

> myRest1 <- cbind(c(0,1,1),c(1,0,1),c(1,1,0))

[,1] [,2] [,3]
1
1
0

1
0
1

0
1
1

[1,]
[2,]
[3,]

> rownames(myRest1) <- rownames(V)

[1] "F1" "F2" "F3"

74

> colnames(myRest1) <- rownames(V)

[1] "F1" "F2" "F3"

> GSReg.kendall.tau.distance.restricted(V,myRest1)

S2
S1
S1 0.0000000 0.6666666
S2 0.6666666 0.0000000

> GSReg.kendall.tau.distance(V)

S2
S1
S1 0.0000000 0.6666667
S2 0.6666667 0.0000000

> myRest2 <- cbind(c(0,0,1),c(0,0,1),c(1,1,0))

[,1] [,2] [,3]
1
1
0

0
0
1

0
0
1

[1,]
[2,]
[3,]

> rownames(myRest2) <- rownames(V)

[1] "F1" "F2" "F3"

> colnames(myRest2) <- rownames(V)

[1] "F1" "F2" "F3"

> GSReg.kendall.tau.distance.restricted(V,myRest2)

S2
S1
S1 0.0000000 0.4999999
S2 0.4999999 0.0000000

> Temp1 <- cbind(c(0,1,1),c(0,0,0),c(0,1,0))

[,1] [,2] [,3]
0
1
0

0
0
0

0
1
1

[1,]
[2,]
[3,]

> rownames(Temp1) <- rownames(V)

[1] "F1" "F2" "F3"

> colnames(Temp1) <- rownames(V)

[1] "F1" "F2" "F3"

> GSReg.kendall.tau.distance.template(V,Temp = Temp1)

S2
1.0000000 0.3333333

S1

75

Now, we can use SEVA function and use the data from the paper [?].

> data(juncExprsSimulated)
> SEVAjunc <- GSReg.SEVA(juncExprs = junc.RPM.Simulated,

> print(sapply(SEVAjunc,function(x) x$pvalue))

phenoVect = phenotypes,
geneexpr = geneExrsGSReg)

CMPK1
1.00000000
MYSM1
0.00000000
RBBP5
0.07123363
TMEM63A
1.00000000

CSF1
1.00000000
NPHP4
0.53048443
RERE
0.29801755
TNFRSF1B
1.00000000

FAM72B
0.00000000
PEX14
0.81734872
SLAMF7
0.00000000
UQCRH
0.00000000

KLHL12
0.00000000
PIP5K1A
0.00000000
SLC41A1
1.00000000

KLHL21 LOC105371470
0.00000000
RBBP4
0.00000000
TMEM51-AS2
0.06777388

0.19089848
PSMB2
1.00000000
TMEM51
0.09424228

> #if you want to check Translational as well you can use 2 other p-values
> print(sapply(SEVAjunc,function(x) x$pvalueTotal))

CMPK1
1.00000000
MYSM1
0.00000000
RBBP5
0.02343778
TMEM63A
1.00000000

CSF1
1.00000000
NPHP4
1.00000000
RERE
0.89405265
TNFRSF1B
1.00000000

FAM72B
0.00000000
PEX14
1.00000000
SLAMF7
0.00000000
UQCRH
0.00000000

>

KLHL12
0.00000000
PIP5K1A
0.00000000
SLC41A1
1.00000000

KLHL21 LOC105371470
0.00000000
RBBP4
0.00000000
TMEM51-AS2
0.14516649

0.26032517
PSMB2
1.00000000
TMEM51
0.17473402

76

4

System Information

Session information:

> toLatex(sessionInfo())

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB,

LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, stats4, utils

• Other packages: AnnotationDbi 1.72.0, Biobase 2.70.0, BiocGenerics 0.56.0,
GO.db 3.22.0, GSBenchMark 1.29.0, GSReg 1.44.0, GenomicFeatures 1.62.0,
GenomicRanges 1.62.0, Homo.sapiens 1.3.1, IRanges 2.44.0, OrganismDbi 1.52.0,
S4Vectors 0.48.0, Seqinfo 1.0.0, TxDb.Hsapiens.UCSC.hg19.knownGene 3.22.1,
generics 0.1.4, org.Hs.eg.db 3.22.0

• Loaded via a namespace (and not attached): BiocIO 1.20.0, BiocManager 1.30.26,

BiocParallel 1.44.0, Biostrings 2.78.0, DBI 1.2.3, DelayedArray 0.36.0,
GenomicAlignments 1.46.0, KEGGREST 1.50.0, Matrix 1.7-4, MatrixGenerics 1.22.0,
R6 2.6.1, RBGL 1.86.0, RCurl 1.98-1.17, RSQLite 2.4.3, Rsamtools 2.26.0,
S4Arrays 1.10.0, SparseArray 1.10.0, SummarizedExperiment 1.40.0, XML 3.99-0.19,
XVector 0.50.0, abind 1.4-8, bit 4.6.0, bit64 4.6.0-1, bitops 1.0-9, blob 1.2.4, cachem 1.1.0,
cigarillo 1.0.0, cli 3.6.5, codetools 0.2-20, compiler 4.5.1, crayon 1.5.3, curl 7.0.0,
fastmap 1.2.0, graph 1.88.0, grid 4.5.1, httr 1.4.7, lattice 0.22-7, matrixStats 1.5.0,
memoise 2.0.1, parallel 4.5.1, pkgconfig 2.0.3, png 0.1-8, restfulr 0.0.16, rjson 0.2.23,
rlang 1.1.6, rtracklayer 1.70.0, tools 4.5.1, vctrs 0.6.5, yaml 2.3.10

77

5

Literature Cited

References

[1] James A Eddy, Leroy Hood, Nathan D Price, and Donald Geman. Identifying tightly regulated
and variably expressed networks by differential rank conservation (dirac). PLoS computational
biology, 6(5):e1000792, 2010.

[2] Bahman Afsari. Modeling cancer phenotypes with order statistics of transcript data. PhD

thesis, Johns Hopkins University, 2013.

[3] Maurice G Kendall. A new measure of rank correlation. Biometrika, 1938.

78


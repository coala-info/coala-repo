Bioconductor’s PADOG package

Adi L. Tarca1,2,3

October 30, 2025

1Center for Molecular Medicine and Genetics, Wayne State University
2Department of Obstetrics and Gynecology, Wayne State University
3Department of Computer Science, Wayne State University

1 Overview

This package implements the Pathway Analysis with Down-weighting of Overlapping Genes (PAD-
OG) algorithm described in Tarca et al. (2012). The method can be applied to analyze any type
of gene sets yet in here it is illustarted using KEGG pathways. The method computes a gene set
score as the mean of absolute values of weighted moderated gene t-scores. The gene weights are
chosen to favor genes appearing in few pathways versus genes that appear in many pathways. The
significance of pathway scores is evaluated using sample/array labels permutation that preserve the
gene-gene correlation structure. The package also contains a benchmark for gene set analysis in
general and allows a new gene set analysis method to be benchmarked against PADOG or other
exsisting methods (e.g. GSA). The benchmark uses 24 different data sets, each involving a disease
(e.g. Colorectal Cancer) for which there is a KEGG pathway with the same name. The only
assumption we make (proven to hold in Tarca et al. (2012)) is that the KEGG’s pathway with the
same name as the disease under the study should be found significant and/or ranked near the top by
gene set analysis methods when analyzing a dataset that compares normal with diseased samples.

2 Pathway / gene set analysis with PADOG package

This document provides basic introduction on how to use the PADOG package. For extended descrip-
tion of the methods used by this package please consult Tarca et al. (2012) and Tarca et al. (2013).

We demonstrate the functionality of this package using a colorectal cancer dataset obtained using
Affymetrix GeneChip technology and available through GEO (GSE9348) and incorporated in the
KEGGdzPathwaysGEO package. This experiment contains 12 normal samples and 70 colorectal cancer
samples and is described in Hong et al. (2010). The RMA preprocessed data using the affy package
is the entry point for the padog function:

> library(PADOG)
> set = "GSE9348"
> data(list = set, package = "KEGGdzPathwaysGEO")

1

return(list)

"targetGeneSets")

x = get(x)
exp = experimentData(x)
dataset = exp@name
disease = notes(exp)$disease
dat.m = exprs(x)
ano = pData(x)
design = notes(exp)$design
annotation = paste(x@annotation, ".db", sep = "")
targetGeneSets = notes(exp)$targetGeneSets
list = list(dataset, disease, dat.m, ano, design, annotation, targetGeneSets)
names(list) = c("dataset", "disease", "dat.m", "ano", "design", "annotation",

> #write a function to extract required info into a list
> getdataaslist = function(x) {
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
+ }
> dlist = getdataaslist(set)
> #run padog function on KEGG pathways
> #use NI=1000 for accurate results and run in parallel to speed up (see below)
> myr = padog(
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
+ )
> myr[1:15,-c(4,5)]

esetm = dlist$dat.m,
group = dlist$ano$Group,
paired = dlist$design == "Paired",
block = dlist$ano$Block,
targetgs = dlist$targetGeneSets,
annotation = dlist$annotation,
gslist = "KEGGRESTpathway",
organism = "hsa",
verbose = FALSE,
Nmin = 3,
NI = 50,
plots = TRUE,
dseed = 1

Name
03008 <NA> 03008
04976 <NA> 04976
00670 <NA> 00670
00601 <NA> 00601
01523 <NA> 01523
04981 <NA> 04981
04923 <NA> 04923
00450 <NA> 00450
01521 <NA> 01521

ID Size PmeanAbsT Ppadog
0.0200 2e-04
0.0002 2e-04
0.0400 2e-04
0.0400 2e-04
0.0600 2e-04
0.1000 2e-04
0.0400 2e-04
0.1200 2e-04
0.1000 2e-04

73
77
34
28
30
28
57
17
78

2

03013 <NA> 03013
05206 <NA> 05206
00920 <NA> 00920
00910 <NA> 00910
00500 <NA> 00500
05222 <NA> 05222

101
159
10
17
31
92

2e-02
0.0400
0.0200
2e-02
0.0600 2e-02
0.1000 2e-02
0.1600 2e-02
0.1200 2e-02

Note that for this colorectal cancer dataset it is reasonbale to expect that the KEGG’s Colorectal
cancer pathway will be found significant and/or ranked close to the top. PmeanAbsT corresponds
to the p-value obtained without using gene weights and hence the result is worse (higher p-value)
compared to Ppadog obtained by using the gene weights that are inversly related to how often the
genes apear accross all gene sets to be analyzed. The plot created when plots=TRUE in the call
to padog shows how gene weighting improves the gene set analysis for the traget pathway set via
the targetgs argument. Figure above shows the distribution of pathway/gene set scores (y axis)
for PADOG and ABSmT (which is PADOG without weights) after the first standardization (row
randomization) and after second standardization (between gene sets standardization). The x axis
represents the number of iterations. Iteration 0 uses true class labels, all others used randomly per-
muted labels. The target pathway (set via the targetgs argument) in this dataset is the Colorectal

3

0246811141720−50510ABSmT scores after first standardizationcol(MSabsT_raw[, 1:plotIte])MSabsT_raw[, 1:plotIte]02468111417200510152025PADOG after first standardizationcol(MSTop_raw[, 1:plotIte])MSTop_raw[, 1:plotIte]0246811141720−4−2024ABSmT scores second standardizationcol(MSabsT[, 1:plotIte])MSabsT[, 1:plotIte]0246811141720−202468PADOG after second standardizationcol(MSTop[, 1:plotIte])MSTop[, 1:plotIte]Cancer pathway (KEGG ID 05210). Its score is shown with a red bullet throughout all 4 panels, and
a red horizontal line marks its level when obtained with the true class labels (ite = 0, x-axis). The
box plots of scores obtained with the true class labels are also highlighted in blue. With PADOG,
after the second standardization, the target pathway scores obtained from permutations are less
frequently above the red line (0/20) (more extreme) than for ABSmT (5/20). Over 1,000 iterations,
pP ADOG was estimated to be 0.018 while pABSmT worse, i.e. 0.138.

To run PADOG in parallel, you need to have package doParallel installed, and set parallel =
TRUE in the call to padog:

esetm = dlist$dat.m,
group = dlist$ano$Group,
paired = dlist$design == "Paired",
block = dlist$ano$Block,
targetgs = dlist$targetGeneSets,
annotation = dlist$annotation,
gslist = "KEGGRESTpathway",
organism = "hsa",
verbose = FALSE,
Nmin = 3,
NI = 50,
plots = TRUE,
dseed = 1,
parallel = TRUE

> #you can control the number of cores to use via argument 'ncr'
> myr2 = padog(
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
+ )
> # verify that the result is the same which is a built-in feature
> all.equal(myr, myr2)

[1] TRUE

3 Benchmark of gene set analysis methods

The entire collection of 24 datasets available in KEGGdzPathwaysGEO package that can be used to
benchmark PADOG against existing approaches is given in Table 1:
To illustrate how to compare PADOG against a user defined gene set analysis method we create
a function called randomF that assignes random uniform P-values to gene sets. The user defined
function has to take in 3 arguments:

1. set: the name of a dataset available in from the KEGGdzPathwaysGEO package;

2. mygslist: a list with elements being vectors of gene ids for a given geneset

3. minsize: minimum number of genes in a geneset to be considered for analysis

The output should be a dataframe with columns: ID, P, Rank, Dataset, Method for the geneset(s)
considered to be relevant in that dataset (targetGeneSets).

4

Table 1: The 24 datasets used in the benchmark of pathway analysis methods

GEOID Pubmed

Ref.

GSE1297
GSE5281
GSE5281
GSE5281
GSE20153
GSE20291
GSE8762
GSE4107
GSE8671
GSE9348
GSE14762
GSE781
GSE15471
GSE16515
GSE19728
GSE21354
GSE6956
GSE6956
GSE3467
GSE3678
GSE9476
GSE18842
GSE19188
GSE3585

14769913 Blalock et al. (2004)
17077275 Liang et al. (2007)
17077275 Liang et al. (2007)
17077275 Liang et al. (2007)
20926834 Zheng et al. (2010)
15965975 Zhang et al. (2005)
17724341 Runne et al. (2007)
17317818 Hong et al. (2007)
18171984
20143136 Hong et al. (2010)
19252501 Wang et al. (2009)
14641932 Lenburg et al. (2003)
19260470 Badea et al. (2008)
19732725 Pei et al. (2009)

Sabates-Bellver et al. (2007)

-
-

18245496 Wallace et al. (2008)
18245496 Wallace et al. (2008)
16365291 He et al. (2005)

Disease/Target pathway
Alzheimer’s Disease
Alzheimer’s Disease
Alzheimer’s Disease
Alzheimer’s Disease
Parkinson’s disease
Parkinson’s disease
Huntington’s disease
Colorectal Cancer
Colorectal Cancer
Colorectal Cancer
Renal Cancer
Renal Cancer
Pancreatic Cancer
Pancreatic Cancer
Glioma
Glioma
Prostate Cancer
Prostate Cancer
Thyroid Cancer
Thyroid Cancer
Acute myeloid leukemia

17910043
20878980
20421987 Hou et al. (2010)
17045896 Barth et al. (2006)

-
Stirewalt et al. (2008)
Sanchez-Palencia et al. (2010) Non-Small Cell Lung Cancer
Non-Small Cell Lung Cancer
Dilated cardiomyopathy

Lymphoblasts
Postmortem brain putamen
Lymphocytes (blood)

KEGGID Tissue
hsa05010 Hippocampal CA1
hsa05010 Brain, Entorhinal Cortex
hsa05010 Brain, hippocampus
hsa05010 Brain, Primary visual cortex
hsa05012
hsa05012
hsa05016
hsa05210 Mucosa
hsa05210 Colon
hsa05210 Colon
hsa05211 Kidney
hsa05211 Kidney
hsa05212
hsa05212
hsa05214 Brain
hsa05214 Brain, Spine
Prostate
hsa05215
hsa05215
Prostate
hsa05216 Thyroid
hsa05216 Thyroid
hsa05221 Blood, Bone marrow
Lung
hsa05223
hsa05223
Lung
hsa05414 Heart

Pancreas
Pancreas

The 24 datasets used to compare the pathway analysis methods were obtained from GEO.

#a helper function to pass additional variables to your method
getdataaslist = getdataaslist
return(function(set, mygslist, minsize) {#your method function

set.seed(dseed)
#this loads the dataset
data(list = set, package = "KEGGdzPathwaysGEO")
#extract the required info using the function defined earlier
dlist = getdataaslist(set)
#get rid of duplicates probesets per ENTREZ ID by keeping the probeset
#with smallest p-value (computed using limma)
aT1 = filteranot(esetm = dlist$dat.m, group = dlist$ano$Group,

> randFun = function(dseed, mname = "myRand") {
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
+

length(intersect(aT1$ENTREZID, x))

}))

paired = dlist$design == "Paired", block = dlist$ano$Block,
annotation = dlist$annotation)

#create an output dataframe for this toy method with random gene set p-values
mygslistSize = unlist(lapply(mygslist, function(x) {

5

)

Size = mygslistSize, stringsAsFactors = FALSE)

res = data.frame(ID = names(mygslist), P = runif(length(mygslist)),

res$FDR = p.adjust(res$P,"fdr")
#drop genesets with less than minsize genes in the current dataset
res = res[res$Size >= minsize,]
#compute ranks
res$Rank = rank(res$P) / dim(res)[1]*100
#needed to compare ranks between methods; must be the same as given
#in mymethods argument "list(myRand="
res$Method = mname
#needed because comparisons of ranks between methods is paired at dataset level
res$Dataset = dlist$dataset
#output only result for the targetGeneSets
#which are gene sets expected to be relevant in this dataset
return(res[res$ID %in% dlist$targetGeneSets,])
}

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
+
+ }
> randomF = randFun(1)
> #run the analysis on all 24 datasets and compare the new method "myRand" with
> #PADOG and GSA (if installed) (chosen as reference since is listed first in the
> #existingMethods)
> #if the package doParallel is installed datasets are analyzed in parallel.
> #out = compPADOG(datasets = NULL, existingMethods = c("GSA","PADOG"),
> #
> #
> #
>
> #compare myRand against PADOG on 3 datasets only
> #mysets = data(package = "KEGGdzPathwaysGEO")$results[,"Item"]
> mysets = c("GSE9348","GSE8671","GSE1297")
> out = compPADOG(datasets = mysets, existingMethods = c("PADOG"),
+
+
+
> print(out)

mymethods = list(myRand = randomF), gslist = "KEGGRESTpathway",
Nmin = 3, NI = 1000, plots = TRUE, verbose=FALSE,
parallel = TRUE, dseed = 1, pkgs = NULL)

mymethods = list(myRand = randomF),
gslist = "KEGGRESTpathway", Nmin = 3, NI = 40, plots = TRUE,
verbose=FALSE, parallel = TRUE, dseed = 1, pkgs = NULL)

$summary

Method

p med % p.value<0.05 % q.value<0.05
33.33
66.67
PADOG
0.025
0
33.33
myRand myRand 0.316257.... 0.812131....

p geomean
PADOG 0.009787....

rank mean

rank med p Wilcox.

p LME coef. LME
1.000 1.0000000
0.00000
0.875 0.9346295 48.63388

PADOG
7.012750.... 5.737704....
myRand 55.64663.... 82.51366....

$ranks

6

$ranks$PADOG
[1] 10.928962

4.371585

5.737705

$ranks$myRand
[1]

1.912568 82.513661 82.513661

$pvalues
$pvalues$PADOG
[1] 0.15000 0.00025 0.02500

$pvalues$myRand
[1] 0.04795913 0.81213152 0.81213152

$qvalues
$qvalues$PADOG
[1] 0.94847561 0.00571875 0.39782609

$qvalues$myRand
[1] 0.9151963 0.9782489 0.9782489

>

7

Details about the meaning of the columns in the out table are given in Tarca et al. (2012). The
better the method, the smaller the p-values and ranks for the target pathways, since these are
supposted to be significant to their respective datasets.

References

L. Badea, V. Herlea, S. O. Dima, T. Dumitrascu, and I. Popescu. Combined gene expression analysis
of whole-tissue and microdissected pancreatic ductal adenocarcinoma identifies genes specifically
overexpressed in tumor epithelia. Hepatogastroenterology, 55:2016–2027, 2008.

A. S. Barth, R. Kuner, A. Buness, M. Ruschhaupt, S. Merk, L. Zwermann, S. Kaab, E. Kreuzer,
G. Steinbeck, U. Mansmann, A. Poustka, M. Nabauer, and H. Sultmann. Identification of a com-
mon gene expression signature in dilated cardiomyopathy across independent microarray studies.
J. Am. Coll. Cardiol., 48:1610–1617, Oct 2006.

E. M. Blalock, J. W. Geddes, K. C. Chen, N. M. Porter, W. R. Markesbery, and P. W. Landfield.
Incipient Alzheimer’s disease: microarray correlation analyses reveal major transcriptional and
tumor suppressor responses. Proc. Natl. Acad. Sci. U.S.A., 101:2173–2178, Feb 2004.

8

PADOGmyRand0.00.20.40.60.8p−valuePADOGmyRand020406080Rank(%)020406080myRandRank(%)−Rank  PADOG  (%)H. He, K. Jazdzewski, W. Li, S. Liyanarachchi, R. Nagy, S. Volinia, G. A. Calin, C. G. Liu,
K. Franssila, S. Suster, R. T. Kloos, C. M. Croce, and A. de la Chapelle. The role of microRNA
genes in papillary thyroid carcinoma. Proc. Natl. Acad. Sci. U.S.A., 102:19075–19080, Dec 2005.

Y. Hong, K. S. Ho, K. W. Eu, and P. Y. Cheah. A susceptibility gene set for early onset colorectal
implication for tumorigenesis. Clin. Cancer

cancer that integrates diverse signaling pathways:
Res., 13:1107–1114, Feb 2007.

Y. Hong, T. Downey, K. W. Eu, P. K. Koh, and P. Y. Cheah. A ’metastasis-prone’ signature for
early-stage mismatch-repair proficient sporadic colorectal cancer patients and its implications for
possible therapeutics. Clin. Exp. Metastasis, 27:83–90, Feb 2010.

J. Hou, J. Aerts, B. den Hamer, W. van Ijcken, M. den Bakker, P. Riegman, C. van der Leest,
P. van der Spek, J. A. Foekens, H. C. Hoogsteden, F. Grosveld, and S. Philipsen. Gene expression-
based classification of non-small cell lung carcinomas and survival prediction. PLoS ONE, 5:
e10312, 2010.

M. E. Lenburg, L. S. Liou, N. P. Gerry, G. M. Frampton, H. T. Cohen, and M. F. Christman.
Previously unidentified changes in renal cell carcinoma gene expression identified by parametric
analysis of microarray data. BMC Cancer, 3:31, Nov 2003.

W. S. Liang, T. Dunckley, T. G. Beach, A. Grover, D. Mastroeni, D. G. Walker, R. J. Caselli,
W. A. Kukull, D. McKeel, J. C. Morris, C. Hulette, D. Schmechel, G. E. Alexander, E. M.
Reiman, J. Rogers, and D. A. Stephan. Gene expression profiles in anatomically and functionally
distinct regions of the normal aged human brain. Physiol. Genomics, 28:311–322, Feb 2007.

H. Pei, L. Li, B. L. Fridley, G. D. Jenkins, K. R. Kalari, W. Lingle, G. Petersen, Z. Lou, and
L. Wang. FKBP51 affects cancer cell response to chemotherapy by negatively regulating Akt.
Cancer Cell, 16:259–266, Sep 2009.

H. Runne, A. Kuhn, E. J. Wild, W. Pratyaksha, M. Kristiansen, J. D. Isaacs, E. Regulier, M. De-
lorenzi, S. J. Tabrizi, and R. Luthi-Carter. Analysis of potential transcriptomic biomarkers for
Huntington’s disease in peripheral blood. Proc. Natl. Acad. Sci. U.S.A., 104:14424–14429, Sep
2007.

J. Sabates-Bellver, L. G. Van der Flier, M. de Palo, E. Cattaneo, C. Maake, H. Rehrauer, E. Laczko,
M. A. Kurowski, J. M. Bujnicki, M. Menigatti, J. Luz, T. V. Ranalli, V. Gomes, A. Pastorelli,
R. Faggiani, M. Anti, J. Jiricny, H. Clevers, and G. Marra. Transcriptome profile of human
colorectal adenomas. Mol. Cancer Res., 5:1263–1275, Dec 2007.

A. Sanchez-Palencia, M. Gomez-Morales, J. A. Gomez-Capilla, V. Pedraza, L. Boyero, R. Rosell,
and M. E. Farez-Vidal. Gene expression profiling reveals novel biomarkers in nonsmall cell lung
cancer. Int. J. Cancer, Sep 2010.

D. L. Stirewalt, S. Meshinchi, K. J. Kopecky, W. Fan, E. L. Pogosova-Agadjanyan, J. H. Engel,
M. R. Cronk, K. S. Dorcy, A. R. McQuary, D. Hockenbery, B. Wood, S. Heimfeld, and J. P.
Radich.
Identification of genes with abnormal expression changes in acute myeloid leukemia.
Genes Chromosomes Cancer, 47:8–20, Jan 2008.

9

A. L. Tarca, S. Draghici, G. Bhatti, and R. Romero. Down-weighting overlapping genes improves

gene set analysis. BMC Bionformatics, 13(136), 2012.

A. L. Tarca, G. Bhatti, and R. Romero. A comparison of gene set analysis methods in terms of

sensitivity, prioritization and specificity. Plos One, 8(11), 2013.

T. A. Wallace, R. L. Prueitt, M. Yi, T. M. Howe, J. W. Gillespie, H. G. Yfantis, R. M. Stephens,
N. E. Caporaso, C. A. Loffredo, and S. Ambs. Tumor immunobiological differences in prostate
cancer between African-American and European-American men. Cancer Res., 68:927–936, Feb
2008.

Y. Wang, O. Roche, M. S. Yan, G. Finak, A. J. Evans, J. L. Metcalf, B. E. Hast, S. C. Hanna,
B. Wondergem, K. A. Furge, M. S. Irwin, W. Y. Kim, B. T. Teh, S. Grinstein, M. Park, P. A.
Marsden, and M. Ohh. Regulation of endocytosis via the oxygen-sensing pathway. Nat. Med.,
15:319–324, Mar 2009.

Y. Zhang, M. James, F. A. Middleton, and R. L. Davis. Transcriptional analysis of multiple brain
regions in Parkinson’s disease supports the involvement of specific protein processing, energy
metabolism, and signaling pathways, and suggests novel disease mechanisms. Am. J. Med. Genet.
B Neuropsychiatr. Genet., 137B:5–16, Aug 2005.

B. Zheng, Z. Liao, J. J. Locascio, K. A. Lesniak, S. S. Roderick, M. L. Watt, A. C. Eklund, Y. Zhang-
James, P. D. Kim, M. A. Hauser, E. Grunblatt, L. B. Moran, S. A. Mandel, P. Riederer, R. M.
Miller, H. J. Federoff, U. Wullner, S. Papapetropoulos, M. B. Youdim, I. Cantuti-Castelvetri,
A. B. Young, J. M. Vance, R. L. Davis, J. C. Hedreen, C. H. Adler, T. G. Beach, M. B. Graeber,
F. A. Middleton, J. C. Rochet, and C. R. Scherzer. PGC-1?, a potential therapeutic target for
early intervention in Parkinson’s disease. Sci Transl Med, 2:52ra73, Oct 2010.

10


Using the a4 package

Willem Talloen, Tobias Verbeke

October 29, 2025

Contents

1 Introduction

2 Preparation of the Data

2.1 ExpressionSet object . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Some data manipulation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Unsupervised data exploration

4 Filtering

5 Detecting differential expression

5.1 T-test
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2 Limma for comparing two groups . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.3 Limma for linear relations with a continuous variable . . . . . . . . . . . . . . . . .

6 Class prediction

6.1 PAM . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.2 Random forest
6.3 Forward filtering with various classifiers
. . . . . . . . . . . . . . . . . . . . . . . .
6.4 Penalized regression . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.5 Logistic regression . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.6 Receiver operating curve . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

7 Visualization of interesting genes

7.1 Plot the expression levels of one gene . . . . . . . . . . . . . . . . . . . . . . . . . .
7.2 Plot the expression levels of two genes versus each other . . . . . . . . . . . . . . .
7.3 Plot expression line profiles of multiple genes/probesets across samples . . . . . . .
7.4 Smoothscatter plots
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7.5 Gene lists of log ratios . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

8 Pathway analysis

8.1 Minus log p . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

9 Software used

2

2
2
2

3

4

5
5
6
7

8
8
8
9
11
13
15

16
16
20
21
23
26

28
28

29

1

1

Introduction

The a4 suite of packages is a suite for convenient analysis of Affymetrix microarray experiments
which supplements Goehlmann and Talloen (2010). The suite currently consists of several packages
which are centered around particular tasks:

• a4Preproc: package for preprocessing of microarray data. Currently the only function in
the package adds complementary annotation information to the ExpressionSet objects (in
function addGeneInfo). Many of the subsequent analysis functions rely on the presence of
such information.

• a4Core: package made to allow for easy interoperability with the nlcv package which is
currently being developed on R-Forge at http://r-forge.r-project.org/projects/nlcv.

• a4Base: all basic functionality of the a4 suite

• a4Classif: functionality for classification work that has been split off a.o. in order to reduce

a4Base loading time

• a4Reporting: a package which provides reporting functionality and defines xtable-methods

that are foreseen for tables with hyperlinks to public gene annotation resources.

This document provides an overview of the typical analysis workflow for such microarray ex-

periments using functionality of all of the mentioned packages.

2 Preparation of the Data

First we load the package a4 and the example real-life data set ALL.

R> library(a4)
R> require(ALL)
R> data(ALL, package = "ALL")

For illustrative purposes, simulated data sets can also be very valuable (but not used here).

R> require(nlcv)
R> esSim <- simulateData(nEffectRows=50, betweenClassDifference = 5,

nNoEffectCols = 5, withinClassSd = 0.2)

2.1 ExpressionSet object

The data are assumed to be in an expressionSet object. Such an object structure combines different
sources of information into a single structure, allowing easy data manipulation (e.g., subsetting,
copying) and data modelling.

The textttfeatureData slot is typically not yet containing all relevant information about the

genes. This interesting extra gene information can be added using addGeneInfo.

R> library("hgu95av2.db")
R> ALL <- addGeneInfo(ALL)

2.2 Some data manipulation

The ALL data consists out of samples obtained from two types of cells with very distinct expression
profiles; B-cells and T-cells. To have a more subtle signal, gene expression will also be compared
between the BCR/ABL and the NEG group within B-cells only. To this end, we create the
expressionSet bcrAblOrNeg containing only B-cells with BCR/ABL or NEG.

R> Bcell <- grep("^B", as.character(ALL$BT)) # create B-Cell subset for ALL
R> subsetType <- "BCR/ABL"
R> bcrAblOrNegIdx <- which(as.character(ALL$mol) %in% c("NEG", subsetType))
R> bcrAblOrNeg <- ALL[, intersect(Bcell, bcrAblOrNegIdx)]
R> bcrAblOrNeg$mol.biol <- factor(bcrAblOrNeg$mol.biol)

# other subsetType can be "ALL/AF4"

2

3 Unsupervised data exploration

Spectral maps are very powerful techniques to get an unsupervised picture of how the data look
like. A spectral map of the ALL data set shows that the B- and the T-subtypes cluster together
along the x-axis (the first principal component). The plot also indicates which genes contribute in
which way to this clustering. For example, the genes located in the same direction as the T-cell
samples are higher expressed in these T-cells. Indeed, the two genes at the left (TCF7 and CD3D)
are well known to be specifically expressed by T-cells (Wetering 1992, Krissansen 1986).

R> spectralMap(object = ALL, groups = "BT")
R>
R>
R>
R>

# optional argument settings
#
#

plot.mpm.args=list(label.tol = 12, zoom = c(1,2), do.smoothScatter = TRUE),
probe2gene = TRUE)

A spectral map of the bcrAblOrNeg data subset does not show a clustering of BCR/ABL or

NEG cells.

R> spectralMap(object = bcrAblOrNeg, groups = "mol.biol", probe2gene = TRUE)

3

PC1 16%PC2 12%TCF7CD74CCN2HLA−DRAHLA−DPB1HLA−DPB1CD3DCD9YBX301005010100400706002080010802411005120071201912026140161500516009200022201122013240012400824010240112401724018250032500626001260052700327004360023701348001490066400164002650056800303002240192402226003280032801936001430074301262001620026200304006040080401004016150011500416004190052400526008280242802828031280323100733005430016300168001080110801208018090081200612012280012800528006280072802128023280352803628037280422804328044280473000131011430045700109017220092201084004LAL501003110021700326009LAL4010070900216002160071900228009440014900456007650030202004018100051500618001190081901419017280083101537001430064301564005830011200824006200054 Filtering

The data can be filtered, for instance based on variance and intensity, in order to reduce the
high-dimensionality.

R> selBcrAblOrNeg <- filterVarInt(object = bcrAblOrNeg)
R> propSelGenes <- round((dim(selBcrAblOrNeg)[1]/dim(bcrAblOrNeg)[1])*100,1)

This filter selected 18.9 % of the genes (2391 of the in total 12625 genes).

4

PC1 15%PC2 12%HBBHBBHBDMAFFIGLL1TCL1AKLF9SNRK01005030020800108011090081100512006120071201212026140161500520002220102201324001240102401124017240222600327003270042801928021280363000131011370134300149006620016200262003650056800384004010100400704008040100401606002080120802409017120191500116009220092201124008240182500325006260012800128005280062800728023280242803128035280372804228043280442804733005360024300443007430124800157001640016400268001BCR/ABLNEG5 Detecting differential expression

5.1 T-test

R> tTestResult <- tTest(selBcrAblOrNeg, "mol.biol")

R> histPvalue(tTestResult[,"p"], addLegend = TRUE)
R> propDEgenesRes <- propDEgenes(tTestResult[,"p"])

Using an ordinary t-test, there are 171 genes significant at a FDR of 10%. The proportion of

genes that are trully differentially expressed is estimated to be around 32.7.

The toptable and the volcano plot show that three most significant probe sets all target ABL1.
This makes sense as the main difference between BCR/ABL and NEG cells is a mutation in this
particular ABL gene.

R> tabTTest <- topTable(tTestResult, n = 10)
R> print(xtable(tabTTest,

caption="The top 5 features selected by an ordinary t-test.",

label ="tablassoClass"))

R> volcanoPlot(tTestResult, topPValues = 5, topLogRatios = 5)

5

0.00.20.40.60.81.005010015020025032.7% DE genesgSymbol

1636_g_at ABL1
39730_at ABL1
1635_at ABL1
40202_at KLF9
37027_at AHNAK
39837_s_at ZNF467
40480_s_at FYN

p
0.00
0.00
0.00
0.00
0.00
0.00
0.00
33774_at CASP8
0.00
36591_at TUBA4A 0.00
0.00
37014_at MX1

logRatio
-1.10
-1.15
-1.20
-1.78
-1.35
-0.48
-0.87
-1.00
-1.15
1.41

pBH tStat
9.26
0.00
8.69
0.00
7.28
0.00
6.18
0.00
5.65
0.00
5.50
0.00
5.30
0.00
5.26
0.00
5.25
0.00
-5.04
0.00

Table 1: The top 5 features selected by an ordinary t-test.

5.2 Limma for comparing two groups

In this particular data set, the modified t-test using limmaTwoLevels provides very similar results.
This is because the sample size is relatively large.

R> limmaResult <- limmaTwoLevels(selBcrAblOrNeg, "mol.biol")
R> volcanoPlot(limmaResult)
R> # histPvalue(limmaResult)
R> # propDEgenes(limmaResult)

6

14e−14−3−2−10123ABL1ABL1ABL1KLF9AHNAKJCHAINCCN2IGLL1MX1It is very useful to put lists of genes in annotated tables where the genes get hyperlinks to

EntrezGene.

R> tabLimma <- topTable(limmaResult, n = 10, coef = 2) # 1st is (Intercept)

Gene
ABL1
ABL1
ABL1
KLF9
AHNAK
TUBA4A
FYN
CASP8
ZNF467
MX1

logFC AveExpr P.Value
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00
0.00

-1.10
-1.15
-1.20
-1.78
-1.35
-1.15
-0.87
-1.00
-0.48
1.41

9.20
9.00
7.90
8.62
8.44
9.23
7.76
8.04
7.14
6.73

adj.P.Val GENENAME

0.00 ABL proto-oncogene 1, non-receptor tyr
0.00 ABL proto-oncogene 1, non-receptor tyr
0.00 ABL proto-oncogene 1, non-receptor tyr
0.00 KLF transcription factor 9
0.00 AHNAK nucleoprotein
0.00
tubulin alpha 4a
0.00 FYN proto-oncogene, Src family tyrosin
caspase 8
0.00
zinc finger protein 467
0.00
0.00 MX dynamin like GTPase 1

5.3 Limma for linear relations with a continuous variable

Testing for (linear) relations of gene expression with a (continuous) variable is typically done
using regression. A modified t-test approach improves the results by penalizing small slopes. The
modified regressions can be applied using limmaReg.

R>

7

13e−14−3−2−10123ABL1ABL1ABL1KLF9AHNAKTUBA4AFYNCASP8ZNF467MX1JCHAINCCN2IGLL1CRIP1ZEB1CNN36 Class prediction

There are many classification algorithms with profound conceptual and methodological differences.
Given the differences between the methods,there’s probably no single classification method that
always works best, but that certain methods perform better depending on the characteristics of
the data.

On the other hand, these methods are all designed for the same purpose, namely maximizing
classification accuracy. They should consequently all pick up (the same) strong biological signal
when present, resulting in similar outcomes.

Personally, we like to apply four different approaches; PAM, RandomForest, forward filtering

in combination with various classifiers, and LASSO.

All four methods have the property that they search for the smallest set of genes while having
the highest classification accuracy. The underlying rationale and algorithm is very different between
the four approaches, making their combined use potentially complementary.

6.1 PAM

PAM (Tibshirani 2002) applies univariate and dependent feature selection.

R> resultPam <- pamClass(selBcrAblOrNeg, "mol.biol")
R> plot(resultPam)
R> featResultPam <- topTable(resultPam, n = 15)
R> xtable(head(featResultPam$listGenes),

caption = "Top 5 features selected by PAM.")

6.2 Random forest

Random forest with variable importance filtering (Breiman 2001, Diaz-Uriarte 2006) applies multi-
variate and dependent feature selection. Be cautious when interpreting its outcome, as the obtained
results are unstable and sometimes overoptimistic.

8

0.10.20.30.40.5number of genesMisclassification error03344556814151823334358769811615921329439055375210451340166320212391xR> resultRF <- rfClass(selBcrAblOrNeg, "mol.biol")
R> plot(resultRF, which = 2)
R> featResultRF <- topTable(resultRF, n = 15)
R> xtable(head(featResultRF$topList),

caption = "Features selected by Random Forest variable importance.")

GeneSymbol

1635_at ABL1
1636_g_at ABL1
33284_at MPO
34216_at KLF7
37043_at
37351_at UPP1

ID3

Table 2: Features selected by Random Forest variable importance.

R>

6.3 Forward filtering with various classifiers

Forward filtering in combination with various classifiers (like DLDA, SVM, random forest, etc.)
apply an independent feature selection. The selection can be either univariate or multivariate
depending on the chosen selection algorithm; we usually choose Limma as a univariate although
random forest variable importance could also be used as a multivariate selection criterium.

R> mcrPlot_TT <- mcrPlot(nlcvTT, plot = TRUE, optimalDots = TRUE,

layout = TRUE, main = "t-test selection")

9

0.050.100.150.200.25number of genesMisclassification error2469142234548513220632150178312241913xdlda
randomForest
bagg
pam
svm

nFeat_optim mean_MCR sd_MCR
0.05
0.05
0.05
0.07
0.07

7.00
3.00
25.00
2.00
2.00

0.14
0.15
0.16
0.16
0.13

Table 3: Optimal number of genes per classification method together with the respective misclas-
sification error rate (mean and standard deviation across all CV loops).

R> scoresPlot(nlcvTT, tech = "svm", nfeat = 2)

10

t−test selectionMisclassification RateNumber of features2571015202530350.00.20.40.60.81.0dldarandomForestbaggpamsvmIndex6.4 Penalized regression

LASSO (Tibshirani 2002) or elastic net (Zou 2005) apply multivariate and dependent feature
selection.

R> resultLasso <- lassoClass(object = bcrAblOrNeg, groups = "mol.biol")
R> plot(resultLasso, label = TRUE,

main = "Lasso coefficients in relation to degree of penalization.")

R> featResultLasso <- topTable(resultLasso, n = 15)

11

0100508011120061202620002240012401727003280213101149006620038400404008060020901716009240082500628005280232803528043330054300757001680010.00.20.40.60.81.0proportionFreq. of being correctly classified (svm, 2 feat.)BCR/ABLNEG0.5 <= score <=   1   0 <= score <  0.5Gene
ITGA7
ABL1
TCL1B
RAB32
CHD3
SERPINE2
NFATC1
ZNF467
YES1
ANXA1
PTDSS1
PTPRJ
F13A1
DSTN
ALDH1A1

Coefficient
-3.80
-2.76
-2.26
-1.01
-0.77
-0.65
-0.64
-0.60
-0.58
-0.58
0.53
-0.51
-0.49
0.47
-0.46

Table 4: Features selected by Lasso, ranked from largest to smallest penalized coefficient.

12

12345−3−2−10Lasso coefficients in relation to degree of penalization.-Log(l)Coefficients0112129333897147569571173245627723006323633933437372440344184425045684723475248405132521154635887630365656958708270947352739074748129819084659230982399301060410683109761135311632119276.5 Logistic regression

Logistic regression is used for predicting the probability to belong to a certain class in binary
classification problems.

R> logRegRes <- logReg(geneSymbol = "ABL1", object = bcrAblOrNeg, groups = "mol.biol")

The obtained probabilities can be plotted with ProbabilitiesPlot. A horizontal line indicates
the 50% threshold, and samples that have a higher probability than 50% are indicated with blue
dots. Apparently, using the expression of the gene ABL1, quite a lot of samples predicted to with
a high probability to be NEG, are indeed known to be NEG.

R> probabilitiesPlot(proportions = logRegRes$fit, classVar = logRegRes$y,

sampleNames = rownames(logRegRes), main = "Probability of being NEG")

13

ABL1 (1635_at)log2 intensityProbability of being NEG67890.00.20.40.60.81.0BCR/ABLNEGR> probabilitiesPlot(proportions = logRegRes$fit, classVar = logRegRes$y, barPlot= TRUE,

sampleNames = rownames(logRegRes), main = "Probability of being NEG")

14

220102400127003120228036120064300128021280103003000490015005620026200101001200784006500280241600680012400815001040102804228043280052800708022800643007220028035040160801228023280443600260010.00.20.40.60.81.0Probability of being NEG6.6 Receiver operating curve

A ROC curve plots the fraction of true positives (TPR = true positive rate) versus the fraction of
false positives (FPR = false positive rate) for a binary classifier when the discrimination threshold
is varied. Equivalently, one can also plot sensitivity versus (1 - specificity).

R> ROCres <- ROCcurve(geneSymbol = "ABL1", object = bcrAblOrNeg, groups = "mol.biol")

15

2201068003120262402243001080010300227004150056200301005200026500564001680012500604010120192800533005280065700128035280472802328031260010.00.20.40.60.87 Visualization of interesting genes

7.1 Plot the expression levels of one gene

Some potentially interesting genes can be visualized using plot1gene. Here the most significant
gene is plotted.

R> plot1gene(probesetId = rownames(tTestResult)[1],

object = selBcrAblOrNeg, groups = "mol.biol", legendPos = "topright")

16

ABL1 (1635_at)Average false positive rateAverage true positive rate0.00.20.40.60.81.00.00.20.40.60.81.06.096.847.598.349.099.84There are some variations possible on the default plot1gene function. For example, the labels

of x-axis can be changed or omitted.

R> plot1gene(probesetId = rownames(tTestResult)[1], object = selBcrAblOrNeg,

groups = "mol.biol", sampleIDs = "mol.biol", legendPos = "topright")

17

ABL1 (1636_g_at)log2 intensity7.58.08.59.09.510.010.501005080010900812006120121401620002220132401024017260032700428021300013701349006620026500584004040070401006002080241201916009220112401825006280012800628023280312803728043280473600243007480016400168001labels MeansBCR/ABLNEGAnother option is to color the samples by another categorical variable than used for ordering.

R> plot1gene(probesetId = rownames(tTestResult)[1], object = selBcrAblOrNeg,

groups = "mol.biol", colgroups = 'BT', legendPos = "topright")

18

ABL1 (1636_g_at)log2 intensity7.58.08.59.09.510.010.5BCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLBCR/ABLNEGNEGNEGNEGNEGNEGNEGNEGNEGNEGNEGNEGNEGNEGNEGNEGNEGNEGNEGNEGNEGlabels MeansBCR/ABLNEGThe above graphs plot one sample per tickmark in the x-axis. This is very useful to explore the
data as one can directly identify interesting samples. If it is not interesting to know which sample
has which expression level, one may want to plot in the x-axis not the samples but the groups of
interest. It is possible to pass arguments to the boxplot function to custopmize the graph. For
example the boxwex argument allows to reduce the width of the boxes in the plot.

R> boxPlot(probesetId = rownames(tTestResult)[1], object = selBcrAblOrNeg, boxwex = 0.3,

groups = "mol.biol", colgroups = "BT", legendPos = "topright")

19

ABL1 (1636_g_at)log2 intensity7.58.08.59.09.510.010.501005080010900812006120121401620002220132401024017260032700428021300013701349006620026500584004040070401006002080241201916009220112401825006280012800628023280312803728043280473600243007480016400168001labels MeansBB1B2B3B47.2 Plot the expression levels of two genes versus each other

R> plotCombination2genes(geneSymbol1 = featResultLasso$topList[1, 1],

geneSymbol2 = featResultLasso$topList[2, 1],
object = bcrAblOrNeg, groups = "mol.biol",
main = "Combination of\nfirst and second gene", addLegend = TRUE,
legendPos = "topright")

20

BCR/ABLNEG7.58.08.59.09.510.010.5ABL1 (1636_g_at)groupslog2 concentrationBB1B2B3B47.3 Plot expression line profiles of multiple genes/probesets across sam-

ples

Multiple genes can be plotted simultaneously on a graph using line profiles. Each line reflects one
gene and are colored differenly. As an example, here three probesets that measure the gene LCK,
found to be differentially expressed between B- and T-cells. Apparently, one probeset does not
measure the gene appropriately.

R> myGeneSymbol <- "LCK"
R> probesetPos <- which(myGeneSymbol == featureData(ALL)$SYMBOL)
R> myProbesetIds <- featureNames(ALL)[probesetPos]
R> profilesPlot(object = ALL, probesetIds = myProbesetIds,

orderGroups = "BT", sampleIDs = "BT")

21

6.06.57.06789Combination offirst and second geneITGA7ABL1BCR/ABLNEG22

log2 concentration567891011BBB1B1B1B1B1B1B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3B3B3B3B3B3B4B4B4B4TTT2T2T2T2T2T3T3T3T41266_s_at2059_s_at33238_at7.4 Smoothscatter plots

It may be of interest to look at correlations between samples. As each dot represents a gene, there
are typically many dots. It is therefore wise to color the dots in a density dependent way.

R> plotComb2Samples(ALL, "11002", "01003",

xlab = "a T-cell", ylab = "another T-cell")

Figure 1: Correlations in gene expression profiles between two T-cell samples (samples 11002 and
01003).

23

If there are outlying genes, one can label them by their gene symbol by specifying the expression
intervals (X- or Y- axis or both) that contain the genes to be highlighted using trsholdX and
trsholdY.

R> plotComb2Samples(ALL, "84004", "01003",

trsholdX = c(10,12), trsholdY = c(4,6),
xlab = "a B-cell", ylab = "a T-cell")

Figure 2: Correlations in gene expression profiles between a B-cell and a T-cell (samples 84004
and 01003). Some potentially interesting genes are indicated by their gene symbol.

24

One can also show multiple pairwise comparisons in a pairwise scatterplot matrix.

R> plotCombMultSamples(exprs(ALL)[,c("84004", "11002", "01003")])
R> # text.panel= function(x){x, labels = c("a B-cell", "a T-cell", "another T-cell")})

Figure 3: Correlations in gene expression profiles between a B-cell and two T-cell samples (respec-
tively samples 84004, 11002 and 01003).

25

7.5 Gene lists of log ratios

When analyzing treatments that are primarily interesting relative to a control treatment, it may
be of value to look at the log ratios of several treatments (in columns) for a selected list of genes
(in rows).

# omit subtype T1 as it only contains one sample

R> ALL$BTtype <- as.factor(substr(ALL$BT,0,1))
R> ALL2 <- ALL[,ALL$BT != 'T1']
R> ALL2$BTtype <- as.factor(substr(ALL2$BT,0,1)) # create a vector with only T and B
R> # Test for differential expression between B and T cells
R> tTestResult <- tTest(ALL, "BTtype", probe2gene = FALSE)
R> topGenes <- rownames(tTestResult)[1:20]
R> # plot the log ratios versus subtype B of the top genes
R> LogRatioALL <- computeLogRatio(ALL2, reference = list(var="BT", level="B"))
R> a <- plotLogRatio(e = LogRatioALL[topGenes,], openFile = FALSE, tooltipvalues = FALSE,

device = "pdf", filename = "GeneLRlist",
colorsColumnsBy = "BTtype",
main = 'Top 20 genes most differentially between T- and B-cells',
orderBy = list(rows = "hclust"), probe2gene = TRUE)

Figure 4: Log ratios of the 20 genes that are most differentially expressed between B-cell and two
T-cells.

The following example demonstrates how to display log ratios for four compounds for which

gene expression was measured on four timepoints.

R>
R>

R>
R>
R>
R>
R>
R>
R>
R>
R>

load(system.file("extdata", "esetExampleTimeCourse.rda", package = "a4"))
logRatioEset <- computeLogRatio(esetExampleTimeCourse, within = "hours",
reference = list(var = "compound", level = "DMSO"))
# re-order
idx <- order(pData(logRatioEset)$compound, pData(logRatioEset)$hours)
logRatioEset <- logRatioEset[,idx]
# plot LogRatioEset across all
cl <- "TEST"
compound <- "COMPOUND"
shortvarnames <- unique(interaction(pData(logRatioEset)$compound, pData(logRatioEset)$hours))
shortvarnames <- shortvarnames[-grep("DMSO", shortvarnames), drop=TRUE]
plotLogRatio(e = logRatioEset, mx = 1, filename = "logRatioOverallTimeCourse.pdf",

gene.fontsize = 8,
orderBy = list(rows = "hclust", cols = NULL), colorsColumnsBy = c('compound'),
within = "hours", shortvarnames = shortvarnames, exp.width = 1,
main = paste("Differential Expression (trend at early time points) in",

cl, "upon treatment with", compound),

reference = list(var = "compound", level = "DMSO"), device = 'pdf')

26

Top 20 genes most differentially between T− and B−cellsB1B2B3B4TT2T3T4HLA−DPB1 − major histocompatibility complex, classHLA−DPB1 − major histocompatibility complex, classCD19 − CD19 moleculeBLNK − B cell linkerCD79B − CD79b moleculeCD9 − CD9 moleculeNA − NACD74 − CD74 moleculeHLA−DRA − major histocompatibility complex, class IGHM − immunoglobulin heavy constant muHLA−DPA1 − major histocompatibility complex, classHLA−DMA − major histocompatibility complex, class LCK − LCK proto−oncogene, Src family tyrosine kinaLCK − LCK proto−oncogene, Src family tyrosine kinaTRAT1 − T cell receptor associated transmembrane aPRKCQ − protein kinase C thetaCD3G − CD3 gamma subunit of T−cell receptor compleCD3D − CD3 delta subunit of T−cell receptor compleSH2D1A − SH2 domain containing 1ATRDC − T cell receptor delta constantError bars show the pooled standard deviationWed Oct 29 22:27:46 2025 ; R version 4.5.1 Patched (2025−08−23 r88802) ; Biobase version  2.70.0Figure 5: Log ratios for four compounds at four time points (for 20 genes).

27

Differential Expression (trend at early time points) in TEST upon treatment with COMPOUNDA.2A.4A.6A.22B.2B.4B.6B.22C.2C.4C.6C.22D.2D.4D.6D.22ARRDC4 − arrestin domain containing 4EGR1 − early growth response 1SPRY4 − sprouty homolog 4 (Drosophila)BHLHE40 − basic helix−loop−helix family, member e4ZFP36 − zinc finger protein 36, C3H type, homolog DUSP5 − dual specificity phosphatase 5PLAUR − plasminogen activator, urokinase receptorSERPINE1 − serpin peptidase inhibitor, clade E (neINSIG1 − insulin induced gene 1IER3 − immediate early response 3NPC1 − Niemann−Pick disease, type C1LDLR − low density lipoprotein receptorHMGCS1 − 3−hydroxy−3−methylglutaryl−Coenzyme A synSC4MOL − sterol−C4−methyl oxidase−likeLPIN1 − lipin 1HMGCR − 3−hydroxy−3−methylglutaryl−Coenzyme A reduFDFT1 − farnesyl−diphosphate farnesyltransferase 1DHCR7 − 7−dehydrocholesterol reductaseIDI1 − isopentenyl−diphosphate delta isomerase 1PCSK9 − proprotein convertase subtilisin/kexin typError bars show the pooled standard deviationWed Oct 29 22:27:46 2025 ; R version 4.5.1 Patched (2025−08−23 r88802) ; Biobase version  2.70.08 Pathway analysis

8.1 Minus log p

The MLP method is one method of pathway analysis that is commonly used by the a4 suite user
base. Although the method is explained in detail in the MLP package vignette we briefly walk
throught the analysis steps using the same example dataset used in the preceding parts of the
analysis. In order to detect whether certain gene sets are enriched in genes with low p values, we
obtain the vector of p values for the genes and the corresponding relevant gene sets:

R> require(MLP)
R> # create groups
R> labels <- as.factor(ifelse(regexpr("^B", as.character(pData(ALL)$BT))==1, "B", "T"))
R> pData(ALL)$BT2 <- labels
R> # generate p-values
R> limmaResult <- limmaTwoLevels(object = ALL, group = "BT2")
R> pValues <- limmaResult@MArrayLM$p.value
R> pValueNames <- fData(ALL)[rownames(pValues), 'ENTREZID']
R> pValues <- pValues[,2]
R> names(pValues) <- pValueNames
R> pValues <- pValues[!is.na(pValueNames)]

R> geneSet <- getGeneSets(species = "Human",

geneSetSource = "GOBP",
entrezIdentifiers = names(pValues)

)

R> tail(geneSet, 3)

$`GO:2001303`
[1] "239" "246" "247"

$`GO:2001304`
[1] "239" "4051"

$`GO:2001306`
[1] "239"

Next, we run the MLP analysis:

R> mlpOut <- MLP(

geneSet = geneSet,
geneStatistic = pValues,
minGenes = 5,
maxGenes = 100,
rowPermutations = TRUE,
nPermutations = 50,
smoothPValues = TRUE,
probabilityVector = c(0.5, 0.9, 0.95, 0.99, 0.999, 0.9999, 0.99999),
df = 9)

The results can be visualized in many ways, but for Gene Ontology based gene set definitions,

the following graph may be useful:

R> library(Rgraphviz)
R> library(GOstats)
R>
R>
R>

dev.off()

pdf(file = "GOgraph.pdf")

plot(mlpOut, type = "GOgraph", nRow = 25)

28

9 Software used

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, stats4, utils

• Other packages: ALL 1.51.0, AnnotationDbi 1.72.0, Biobase 2.70.0, BiocGenerics 0.56.0,

IRanges 2.44.0, MLInterfaces 1.90.0, MLP 1.58.0, Rcpp 1.1.0, S4Vectors 0.48.0,
XML 3.99-0.19, a4 1.58.0, a4Base 1.58.0, a4Classif 1.58.0, a4Core 1.58.0, a4Preproc 1.58.0,
a4Reporting 1.58.0, annotate 1.88.0, cluster 2.1.8.1, generics 0.1.4, hgu95av2.db 3.13.0,
nlcv 0.3.6, org.Hs.eg.db 3.22.0, xtable 1.8-4

• Loaded via a namespace (and not attached): Biostrings 2.78.0, DBI 1.2.3,

DelayedArray 0.36.0, GO.db 3.22.0, GenomicRanges 1.62.0, KEGGREST 1.50.0,
KernSmooth 2.23-26, MASS 7.3-65, Matrix 1.7-4, MatrixGenerics 1.22.0, R6 2.6.1,
RColorBrewer 1.1-3, ROCR 1.0-11, RSQLite 2.4.3, S4Arrays 1.10.0, Seqinfo 1.0.0,
SparseArray 1.10.0, SummarizedExperiment 1.40.0, XVector 0.50.0, abind 1.4-8,
annaffy 1.82.0, bit 4.6.0, bit64 4.6.0-1, bitops 1.0-9, blob 1.2.4, caTools 1.18.3, cachem 1.1.0,
class 7.3-23, cli 3.6.5, codetools 0.2-20, compiler 4.5.1, crayon 1.5.3, data.table 1.17.8,
digest 0.6.37, e1071 1.7-16, fastmap 1.2.0, foreach 1.5.2, future 1.67.0, future.apply 1.20.0,
genefilter 1.92.0, glmnet 4.1-10, globals 0.18.0, gplots 3.2.0, grid 4.5.1, gtools 3.9.5,
httr 1.4.7, ipred 0.9-15, iterators 1.0.14, kernlab 0.9-33, lattice 0.22-7, lava 1.8.1,
limma 3.66.0, listenv 0.9.1, magrittr 2.0.4, matrixStats 1.5.0, memoise 2.0.1, mpm 1.0-23,
multtest 2.66.0, nnet 7.3-20, pamr 1.57, parallel 4.5.1, parallelly 1.45.1, pkgconfig 2.0.3,
png 0.1-8, prodlim 2025.04.28, proxy 0.4-27, randomForest 4.7-1.2, rlang 1.1.6, rpart 4.1.24,
shape 1.4.6.1, splines 4.5.1, statmod 1.5.1, survival 3.8-3, tools 4.5.1, varSelRF 0.7-8,
vctrs 0.6.5

29


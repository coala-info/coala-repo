Using Categories defined by Chromosome Bands

D. Sarkar, S. Falcon, R. Gentleman

August 7, 2008

1 Chromosome bands

Typically, in higher organisms, each chromosome has a centromere and two arms. The short arm is
called the p arm and the longer arm the q arm. Chromosome bands (see Figure 1) are identified by
differential staining, usually with Giemsa-based stains, and many disease-related defects have been
mapped to these bands; such mappings have played an important role in classical cytogenetics. With
the availability of complete sequences for several genomes, there have been efforts to link these bands
with specific sequence locations (Furey and Haussler, 2003). The estimated location of the bands
in the reference genomes can be obtained from the UCSC genome browser, and data linking genes to
particular bands can be obtained from a variety of sources such as the NCBI. This vignette demonstrates
tools that allow the use of categories derived from chromosome bands, that is, the relevant categories
are determined a priori by a mapping of genes to chromosome bands.

Figure 1 shows an ideogram of human chromosome 12, with the band 12q21 shaded. As shown in
the figure, 12q21 can be divided into more granular levels 12q21.1, 12q21.2, and 12q21.3. 12q21.3 can
itself be divided at an even finer level of resolution into 12q21.31, 12q21.32, and 12q21.33. Moving
towards less granular bands, 12q21 is a part of 12q2 which is again a part of 12q. We take advantage
of this nested structure of the bands in our analysis.

> library("Category")
> library("ALL")
> library("hgu95av2.db")
> library("annotate")
> library("genefilter")
> ##library("SNPchip")
> library("karyoploteR")
> library("geneplotter")
> library("limma")
> library("lattice")
> library("graph")

2 Data Preparation

For illustration, we use a microarray dataset (Chiaretti et al., 2005) from a clinical trial in acute lym-
phoblastic leukemia (ALL). The data are described in Chapter 2 of Hahne et al. (2008). For the

1

Figure 1: Ideogram for human chromosome 12. The p arm is on the left, the q arm is on the right,
and the centromere is indicated by a notch. The shaded bands together represent 12q21. This band
is composed of three sub-bands: 12q21.1, 12q21.2, and 12q21.3. The last of these is composed of
sub-sub-bands 12q21.31, 12q21.32, and 12q21.33.

analysis presented here, we consider the comparison of two subsets: patients identified as having a
BCR/ABL gene fusion present, typically as a result of a translocation of chromosomes 9 and 22 (la-
beled BCR/ABL), and those that have no observed cytogenetic abnormalities (labeled NEG). The full
dataset is available in the ALL package, and the relevant subset of the data can be obtained by

> data(ALL, package="ALL")
> subsetType <- "BCR/ABL"
> Bcell <- grep("^B", as.character(ALL$BT))
> bcrAblOrNegIdx <- which(as.character(ALL$mol.biol) %in% c("NEG", subsetType))
> bcrAblOrNeg <- ALL[, intersect(Bcell, bcrAblOrNegIdx)]
> bcrAblOrNeg$mol.biol <- factor(bcrAblOrNeg$mol.biol)

We also create relevant annotation maps to go from feature names to Entrez ID, gene symbol, and
chromosome band.

> annType <- c("db", "env")
> entrezMap <- getAnnMap("ENTREZID", annotation(bcrAblOrNeg),
+
> symbolMap <- getAnnMap("SYMBOL", annotation(bcrAblOrNeg),
+
> bandMap <- getAnnMap("MAP", annotation(bcrAblOrNeg),
+

type=annType, load=TRUE)

type=annType, load=TRUE)

type=annType, load=TRUE)

We applied a non-specific filter to the dataset to remove probesets lacking the desired annotation as
well as those with an interquartile range (IQR) below the median IQR, as probesets with little variation
across samples are uninformative. We also ensured that each Entrez Gene identifier maps to exactly
one probeset by selecting the probeset with the largest IQR when two or more probesets map to the
same Entrez Gene ID.

2

chr12Human chromosome 12> filterAns <- nsFilter(bcrAblOrNeg,
+
+
+
> nsFiltered <- filterAns$eset

require.entrez = TRUE,
remove.dupEntrez = TRUE,
var.func = IQR, var.cutoff = 0.5)

We also remove probesets with no gene symbol, as well as those with no mapping to a chromosome
band.

> hasSYM <- sapply(mget(featureNames(nsFiltered), symbolMap, ifnotfound=NA),
+
> hasMAP <- sapply(mget(featureNames(nsFiltered), bandMap, ifnotfound=NA),
+
> nsFiltered <- nsFiltered[hasSYM & hasMAP, ]

function(x) length(x) > 0 && !is.na(x[1]))

function(x) length(x) > 0 && !is.na(x[1]))

We define the gene universe to be the subset of genes that remain after this filtering.

> affyUniverse <- featureNames(nsFiltered)
> entrezUniverse <- unlist(mget(affyUniverse, entrezMap))
> names(affyUniverse) <- entrezUniverse
> if (any(duplicated(entrezUniverse)))
+

stop("error in gene universe: can't have duplicate Entrez Gene Ids")

We assessed differential expression between the BCR/ABL and NEG groups using an empirical
Bayes approach, as implemented in the software package limma (Smyth, 2005), yielding an attenuated
t-statistic for each gene.

> design <- model.matrix(~ 0 + nsFiltered$mol.biol)
> colnames(design) <- c("BCR/ABL", "NEG")
> contr <- c(1, -1) ## NOTE: we thus have BCR/ABL w.r.t NEG
> fm1 <- lmFit(nsFiltered, design)
> fm2 <- contrasts.fit(fm1, contr)
> fm3 <- eBayes(fm2)
> ttestLimma <- topTable(fm3, number = nrow(fm3), adjust.method = "none")
> ttestLimma <- ttestLimma[featureNames(nsFiltered), ]
> tstats <- ttestLimma$t
> names(tstats) <- entrezUniverse[rownames(ttestLimma)]
> ##

We used a p-value cutoff of 0.01 to identify a list of potentially differentially expressed genes.

> ttestCutoff <- 0.01
> smPV <- ttestLimma$P.Value < ttestCutoff
> pvalFiltered <- nsFiltered[smPV, ]
> selectedEntrezIds <- unlist(mget(featureNames(pvalFiltered), entrezMap))
> ##

3

3 Methods

There are two important features of gene sets based on chromosome bands: (1) the bands are nested
hierarchically, and (2) they almost form a partition (for most species almost all genes appear in only one
location in the genome). This naturally leads to two different dichotomies in approaches to testing: one
is a top-down versus a bottom-up approach, and the other contrasts local tests with global tests. We use
human chromosome 12 as an example to describe these approaches. Users will need to identify which
of the approaches best align with their objectives and then make use of the software appropriately.

Conceptually one can start a sequential testing approach either at the most coarse level of organi-
zation (probably the level of the arm: p or q), or the most specific level (that of sub-sub-bands). In the
top-down approach, one first tests the hypothesis of interest on a coarse level of organization, and if
rejected, the next level of organization is considered. For example, we might first consider the band
12q21, and if that hypothesis is rejected, test each of the sub-bands 12q21.1, 12q21.2, and 12q21.3. If
the hypothesis for 12q21.3 is rejected, then we may subsequently examine each of 12q21.31, 12q21.32,
and 12q21.33.

The bottom-up approach differs in that we begin at the most granular level and move upward,
amalgamating adjacent bands at each level. The bottom-up approach is easier to put into a conditional
hypothesis testing framework. Our initial null hypotheses involve the smallest, or most granular bands,
and if there is evidence that these are unusual (i.e., we reject the null hypothesis) then moving to a larger,
or less granular, band requires additional information to declare it significant, over and above what we
have used to identify the smaller band. In our example, we would first test 12q21.31, 12q21.32, and
12q21.33, and then move up and test 12q21.3. If one or more of the three sub-bands had been declared
significant, we would exclude the evidence from genes annotated in those sub-bands when testing the
coarser band.

It is important to note that the top-down versus bottom-up approaches represent a fundamental
trade-off between false positive and false negative errors. The bottom-up approach necessarily involves
performing a larger number of tests, yielding a correspondingly larger absolute number of false posi-
tives for a given false positive rate at which each individual test is controlled. The top-down approach
cuts down on the number of false positives by starting with fewer top-level tests, and performing further
tests at sublevels only when a top-level test is rejected. The disadvantage to this approach is loss of
power to detect real departures that are localized to a sub-level, a phenomenon commonly illustrated
using Simpson’s paradox (see, e.g., Wagner, 1982).

Whether a test is local or global is a different question, orthogonal to that of top-down or bottom-
up. There are two distinct but potentially relevant questions that may be of interest. The first is whether
genes in a particular gene set are “different” relative to all other genes under consideration. For a
Hypergeometric test, this question may be formalized as whether the proportion of interesting genes in
12q21 is different from the proportion of interesting genes in the rest of the genome, or equivalently,
whether membership in 12q21 is independent of being selected. Such tests are global in the sense that
all genes in the gene universe are used to determine whether or not genes at a location are unusual or
not. An alternative is to ask whether genes in a genomic location are different relative to other genes in
some meaningfully defined neighbourhood. Such a test can be performed simply by restricting the gene
universe to a suitable subset; for example, when testing 12q21, we may only consider genes in 12q. A
more natural approach is to use a 2 × 3 contingency table to test the hypothesis that the proportion of
interesting genes is the same in 12q21, 12q22, and 12q23. Both these tests are local in the sense that
only nearby genes are used.

4

Contingency table tests are inherently local and although they do not naturally extend to conditional
testing, we can use a top-down approach to test at various resolutions. Such tests can be performed by
the cb_contingency() function, which we do not discuss in this vignette. Instead, we focus on
the bottom-up approach, which allows for conditional testing.

4 Utility functions

We first define a few utility functions that we subsequently use in presentation. The chrSortOrder()
function reorders rows of data frame for display in a natural order.

chrs <- sub("([^pq]+).*$", "\\1", rownames(df))
xyIdx <- chrs %in% c("X", "Y")
xydf <- NULL
if (any(xyIdx)) {

chrs <- chrs[!xyIdx]
xydf <- df[xyIdx, ]
df <- df[!xyIdx, ]

> chrSortOrder <- function(df) {
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

df <- rbind(df, xydf)

df

}
ord <- order(as.integer(chrs), rownames(df))
df <- df[ord, ]
if (!is.null(xydf))

The gseaTstatStripplot() function creates a comparative strip plot of the t-statistics for spec-
ified bands.

chroms <- c(1:22, "X", "Y")
chromArms <- c(paste(chroms, "p", sep=""), paste(chroms, "q", sep=""))
egid <- lapply(nodeData(g, bands), "[[", "geneIds")
if (include.all) {
egid$All <-

> gseaTstatStripplot <- function(bands, g, ..., include.all = FALSE)
+ {
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
>
>

}
tdf <- do.call(make.groups, lapply(egid, function(x) tstats[x]))
stripplot(which ~ data, tdf, jitter = TRUE, ...)

unique(unlist(lapply(nodeData(g)[chromArms], "[[", "geneIds")))

The esetBWPlot() function creates box-and-whisker plots for every gene in an “Expression-

Set”.

5

function(x) if (all(is.na(x))) "NA" else as.character(x)[1])

pdat <-

paste(syms,

selectedAffy <-

cbind(exprs=as.vector(emat),

probes %in% affyUniverse[selectedEntrezIds]

sapply(mget(probes, hgu95av2SYMBOL, ifnotfound=NA),

ifelse(selectedAffy, "*", ""),
sep = "")

symsSelected <- syms[selectedAffy]
symsWithStatus <-

emat <- exprs(tmpSet)
pd <- pData(tmpSet)
probes <- rownames(emat)
syms <-

genes=factor(probes, levels = probes, labels = syms),
pd[rep(seq_len(nrow(pd)), each=nrow(emat)), ])

pdat <- transform(pdat, genes = reorder(genes, exprs))
panels.to.shade <- levels(pdat$genes) %in% symsSelected
bwplot(mol.biol ~ exprs | genes, data=pdat,

> esetBWPlot <- function(tmpSet, ..., layout=c(1, nrow(emat)))
+ {
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
> g1 <- makeChrBandGraph(annotation(nsFiltered), univ=entrezUniverse)
> ct <- ChrBandTreeFromGraph(g1)
> subsetByBand <- function(eset, ct, band) {
+
+
+
+
+ }
>

layout = layout,
auto.key=TRUE,
scales=list(x=list(log=2L)),
xlab="Log2 Expression",
panels.to.shade = panels.to.shade,
panel = function(..., panels.to.shade) {

wantedProbes <- affyUniverse[as.character(egIDs)]
eset[intersect(wantedProbes, featureNames(eset)), ]

if (panels.to.shade[packet.number()])
panel.fill(col = "lightgrey")

},
strip=FALSE,
strip.left=TRUE, ...)

egIDs <- unlist(nodeData(ct@toChildGraph, n=band,

attr="geneIds"), use.names=FALSE)

panel.bwplot(...)

6

5 Hypergeometric Testing

We use a method similar to that described in Falcon and Gentleman (2007) to conditionally test for
over-representation of chromosome bands in the selected gene list. A test is set up by creating a
suitable object of class “ChrMapHyperGParams”. We first create an object to perform a standard
Hypergeometric analysis, treating each chromosome band independently, and then modify a copy to
represent a conditional Hypergeometric computation.

> params <- new("ChrMapHyperGParams",
+
+
+
+
+
+
> paramsCond <- params
> paramsCond@conditional <- TRUE

conditional=FALSE,
testDirection="over",
universeGeneIds=entrezUniverse,
geneIds=selectedEntrezIds,
annotation="hgu95av2",
pvalueCutoff=0.05)

The test computations are performed by

> hgans <- hyperGTest(params)
> hgansCond <- hyperGTest(paramsCond)

The results can be summarized by

> sumUn <- summary(hgans, categorySize=1)
> chrSortOrder(sumUn)

ChrMapID

Pvalue OddsRatio
14q22.2 0.0005784156 22.692958
1
7q31.2 0.0047908084 16.971910
2
7.556808
9q21.1 0.0062117150
3
Inf
13q31 0.0066733711
4
Inf
13q31.1 0.0066733711
5
Inf
6p23 0.0066733711
6
9q33.2 0.0090032012 11.311798
7
8
8.481742
2p22.2 0.0148085762
9 12q21.33 0.0189339982 22.571429
2q31.3 0.0189339982 22.571429
10
4q22.1 0.0189339982 22.571429
11
3.780603
12
6.783708
13
14
2.164685
15 12q21.3 0.0358280017 11.282913
16
4q22 0.0358280017 11.282913
17 10p11.22 0.0358280017 11.282913
18 12q13.11 0.0358280017 11.282913

14q22 0.0197575131
12q14 0.0222758094
6q2 0.0229391129

ExpCount Count Size
6
5
10
2
2
2
6
7
3
3
3
20
8
69
4
4
4
4

0.4907724
0.4089770
0.8179540
0.1635908
0.1635908
0.1635908
0.4907724
0.5725678
0.2453862
0.2453862
0.2453862
1.6359080
0.6543632
5.6438824
0.3271816
0.3271816
0.3271816
0.3271816

4
3
4
2
2
2
3
3
2
2
2
5
3
11
2
2
2
2

7

6q24.2 0.0358280017 11.282913

19
9 0.0419943288
20
1p21 0.0422279373
21
22
20p12 0.0422279373
23 22q11.23 0.0422279373
24
6q 0.0439995864
25 1p36.11 0.0446151403

0.3271816
1.624759 12.5146958
0.8179540
4.843098
0.8179540
4.843098
0.8179540
4.843098
7.7705628
1.808967
1.3905218
3.481690

2
19
3
3
3
13
4

4
153
10
10
10
95
17

> sumCond <- summary(hgansCond, categorySize=1)
> chrSortOrder(sumCond)

ChrMapID

Pvalue OddsRatio
14q22.2 0.0005784156 22.692958
1
7q31.2 0.0047908084 16.971910
2
7.556808
9q21.1 0.0062117150
3
Inf
13q31.1 0.0066733711
4
Inf
6p23 0.0066733711
5
9q33.2 0.0090032012 11.311798
6
7
8.481742
2p22.2 0.0148085762
8 12q21.33 0.0189339982 22.571429
2q31.3 0.0189339982 22.571429
9
4q22.1 0.0189339982 22.571429
10
6.783708
11
12
2.164685
13 10p11.22 0.0358280017 11.282913
14 12q13.11 0.0358280017 11.282913
15
6q24.2 0.0358280017 11.282913
9 0.0419943288
16
1p21 0.0422279373
17
18
20p12 0.0422279373
19 22q11.23 0.0422279373
20 1p36.11 0.0446151403

0.4907724
0.4089770
0.8179540
0.1635908
0.1635908
0.4907724
0.5725678
0.2453862
0.2453862
0.2453862
0.6543632
5.6438824
0.3271816
0.3271816
0.3271816
1.624759 12.5146958
0.8179540
4.843098
0.8179540
4.843098
0.8179540
4.843098
1.3905218
3.481690

ExpCount Count Size
6
5
10
2
2
6
7
3
3
3
8
69
4
4
4
153
10
10
10
17

4
3
4
2
2
3
3
2
2
2
3
11
2
2
2
19
3
3
3
4

12q14 0.0222758094
6q2 0.0229391129

For the standard test, the structure of the chromosome band graph is ignored and a Hypergeomet-
ric test is applied to each band independently. For the conditional test, the hierarchical relationship
among the bands as represented by the graph is used in the computation. The highest-resolution bands
(those with no children in the graph) are tested first. Testing proceeds with the bands whose children
(sub-bands) have already been tested. For these bands, the gene annotations that are inherited from
significant child nodes (children with p-value smaller than the specified cutoff) are removed prior to
testing to yield a conditional test.

The effect of the conditional test is illustrated by examining the results for 14q and its sub-bands.
In the standard test, we see that 14q22 and 14q22.2 both have a significant p-value. In the conditional
test, only 14q22.2 remains. The conclusion is that there is not enough additional evidence beyond that
provided by 14q22.2 to mark 14q22 as significant.

8

6 GSEA using linear models

GSEA is a popular method that can be used to assess whether or not particular gene sets are associated
with a phenotype of interest (Subramanian et al., 2005; Tian et al., 2005; Jiang and Gentleman, 2007).
Most applications of this method do not explicitly deal with structure of the gene sets, but when ana-
lyzing chromosomal location such methods are desirable. We present a simple approach that is similar
in spirit to traditional GSEA, and generalizes nicely to accommodate nested categories. Consider the
situation where gene i has an associated measure of differential expression yi; for example, an attenu-
ated t-statistic derived from a differential expression analysis such as limma (Smyth, 2005). Given a
particular category, GSEA asks whether the distribution of yi-s restricted to the category of interest is
“unusual”. Thus, in Figure 2, we might be interested in knowing whether the distribution of yi values
for genes in 12q21 is different from that of the genes in 12q (for a local test) or of all genes in the gene
universe (for a global test). Figure 2 is produced by

include.all = TRUE,
g = g1,
xlab = "Per-gene t-statistics",
panel = function(...) {

> gseaTstatStripplot(c("12q21.1", "12q21", "12q2", "12q"),
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

require(grid, quietly = TRUE)
grid.rect(y = unit(2, "native"),

panel.grid(v = -1, h = 0)
panel.stripplot(...)
panel.average(..., fun = mean, lwd = 3)

height = unit(1, "native"),
gp =
gpar(fill = "lightgrey",

col = "transparent"))

})

We fit a factorial model to see whether the distribution of yi is associated with category membership.

Specifically, for category j, we fit the model

yi = β0 + β1aij + εi

(1)

where aij = 1 if gene i belongs to category j, and 0 otherwise. The index i may range over the full
gene universe, or a subset, depending on whether one wishes to perform global or local tests. The null
hypothesis of no association is represented by H0 : β1 = 0. The model nominally assumes that the
yi-s are Normally distributed with equal variance, but in practice the results are robust against mild
deviations. The presence of an intercept term allows nonzero overall mean, which can be important in
many situations, especially for local tests. We expect the test to be fairly insensitive to distributional
assumptions on the yi-s.

We can fit (1) by least squares and test H0 : β1 = 0 to obtain a marginal test for each category j; in
this case, each chromosome band. The procedure also generalizes to incorporate the nesting structure
of chromosome bands. Specifically, if band j2 (e.g., 12q21.1) is nested within a coarser band j1 (e.g.,
12q21) and the more granular band j2 is significant, then the effect of membership in j1 over and above

9

Figure 2: Per-gene t-statistics, as computed by limma, for selected chromosome bands. The points
are jittered vertically to alleviate overlap. A thick grey line joins the mean value within each group. A
GSEA test would compare the genes in 12q21 with those in 12q, or the entire gene universe, by fitting
a linear model with per-gene t-statistics as the response, and a term indicating membership in 12q21 as
the predictor. If 12q21.1 is declared as significant, a conditional GSEA test would include an additional
term for 12q21.1.

the effect attributable to membership in j2 can be tested by fitting the model

yi = β0 + β1aij1 + β2aij2 + εi

(2)

and testing the null hypothesis H0 : β1 = 0. Multiple significant sub-bands and multiple levels of
nesting can be incorporated by including further terms in the model. The complete process can be
summarized as follows: Start by marginally testing each band which has no sub-bands. For all other
bands, first test all sub-bands, then test the current band using a linear model that includes a term for
each significant sub-band.

We apply this procedure to perform global tests using per-gene t-statistics as a measure of differ-
ential expression in BCR/ABL relative to NEG samples. As with the Hypergeometric tests, we start by
creating objects of class “ChrMapLinearMParams”.

> params <- new("ChrMapLinearMParams",
+
+
+
+
+
+
+
> params@graph <- makeChrBandGraph(params@annotation, params@universeGeneIds)
> params@gsc <- makeChrBandGSC(params@graph)

conditional = FALSE,
testDirection = "up",
universeGeneIds = entrezUniverse,
geneStats = tstats,
annotation = "hgu95av2",
pvalueCutoff = 0.01,
minSize = 4L)

10

Per−gene t−statistics12q21.112q2112q212qAll−505> paramsCond <- params
> paramsCond@conditional <- TRUE

The tests are performed, and the results summarized by

> lmans <- linearMTest(params)
> lmansCond <- linearMTest(paramsCond)
> chrSortOrder(summary(lmans))

ChrMapID

Pvalue

12q21 1.226213e-03 1.1250647
12q21.3 7.675013e-03 1.8539775
14 6.053485e-03 0.3117778
14q 6.053485e-03 0.3117778
14q2 2.305207e-04 0.6152527
14q22 1.153599e-04 1.2608760
15q21 7.864796e-03 0.8721684
18p 1.034270e-03 0.8925126
18p1 1.034270e-03 0.8925126
18p11 1.034270e-03 0.8925126
18p11.3 5.687826e-03 1.0748058
1p2 3.768696e-03 0.7247847
1p21 8.355225e-04 1.5208019
2 4.064842e-04 0.3060445
2q 1.249084e-04 0.4364493
2q1 9.527008e-03 0.5694083
2q3 4.820761e-03 0.4063168
2q33 7.529350e-03 0.9032265
3 1.402517e-03 0.3008901
3q 1.919247e-04 0.4981449
3q2 2.371159e-03 0.4366903
3q25 3.809785e-04 1.2148855
4 9.538389e-04 0.3844196
4q 4.601941e-03 0.3844843
4q13 6.143774e-03 0.9302421
5 1.089529e-03 0.3350615
5q 5.954123e-03 0.2982655
5q2 5.551978e-03 0.8926298
5q23 3.555656e-03 1.6809836
6 1.584787e-04 0.3432447
6q 6.962197e-06 0.6880899
6q2 5.900992e-06 0.8116250
6q24 3.202752e-03 1.5764875
7q21.1 9.147762e-03 1.1422131
9q 6.018718e-03 0.3690938
9q21 2.799870e-04 1.2451339

Effect Size Conditional TestDirection
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up

FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE

17
4
157
157
77
20
18
28
28
28
13
32
10
300
171
40
97
17
244
122
100
18
158
110
17
205
173
19
6
274
95
69
7
10
111
18

53
54
76
77
81
83
98
133
134
135
137
161
162
216
227
228
237
240
243
256
263
266
271
277
279
291
297
303
306
311
322
326
330
348
385
387

11

388
9q21.1 4.282873e-06 2.1509042
1113 10p11.22 8.053864e-03 1.8405737
1245 14q22.2 9.092615e-06 2.6734149
1276 15q24.3 8.504394e-03 1.6328169
1290 16q12.1 7.610085e-03 1.4037361
1324 18p11.22 1.003528e-03 1.6707653
1p21.3 2.500404e-03 1.7529252
1363
4q13.3 8.388741e-03 1.0570420
1573
6p22.3 2.989781e-03 1.1672122
1647
6q21 1.292155e-03 1.1191866
1664
6q23.3 3.192526e-03 1.5770967
1668
6q24.2 7.434128e-03 1.8628060
1670
1701
7q31.2 4.049223e-05 2.6936729
1756 9q21.13 7.571655e-04 1.9803350
9q33.2 3.825568e-04 2.1006502
1770

> chrSortOrder(summary(lmansCond))

10
4
6
5
7
8
6
12
13
17
7
4
5
6
6

FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE

up
up
up
up
up
up
up
up
up
up
up
up
up
up
up

ChrMapID

Pvalue

12q21.3 7.675013e-03 1.8539775
54
14q2 7.893819e-03 0.4407200
81
15q21 7.864796e-03 0.8721684
98
18p11.3 5.687826e-03 1.0748058
137
2q1 9.527008e-03 0.5694083
228
2q33 7.529350e-03 0.9032265
240
3q 6.983745e-03 0.3725591
256
3q25 3.809785e-04 1.2148855
266
4 5.357453e-03 0.3282355
271
5 3.987179e-03 0.2940783
291
5q23 3.555656e-03 1.6809836
306
7q21.1 9.147762e-03 1.1422131
348
388
9q21.1 8.243858e-04 2.4034672
1113 10p11.22 8.053864e-03 1.8405737
1245 14q22.2 9.092615e-06 2.6734149
1276 15q24.3 8.504394e-03 1.6328169
1290 16q12.1 7.610085e-03 1.4037361
1324 18p11.22 1.003528e-03 1.6707653
1p21.3 2.500404e-03 1.7529252
1363
4q13.3 8.388741e-03 1.0570420
1573
6p22.3 2.989781e-03 1.1672122
1647
6q21 1.292155e-03 1.1191866
1664
6q23.3 3.192526e-03 1.5770967
1668
6q24.2 7.434128e-03 1.8628060
1670
7q31.2 4.049223e-05 2.6936729
1701
1756 9q21.13 7.571655e-04 1.9803350
9q33.2 3.825568e-04 2.1006502
1770

Effect Size Conditional TestDirection
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up
up

TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE
TRUE

4
77
18
13
40
17
122
18
158
205
6
10
10
4
6
5
7
8
6
12
13
17
7
4
5
6
6

12

Figure 3: Expression values for the BCR/ABL and NEG samples for the genes located within 1p36.2,
which is declared as significant by the Hypergeometric test, but not by GSEA. Genes in the selected list
are highlighted with a shaded background. For these genes, The NEG samples, those with no known
cytogenetic abnormalities, have significantly lower expression than the BCR/ABL samples. However,
the direction is reversed (albeit mildly) for many of the other genes.

>
> ##

These examples only test for consistently upregulated categories; similar calls with testDirection
= "down" can be used to test for downregulation. As we see, the GSEA approach picks out many
more bands as significant, but there is some concordance with the Hypergeometric approach. For
example, 7q31, 8p22, and 14q22.2 come up in both analyses. Figure 3 shows box-and-whisker plots
of genes in one category (1p36.2) that is declared as significant by the Hypergeometric test, but not by
GSEA. It is produced by

> tmpSet <- subsetByBand(nsFiltered, ct, "1p36.2")
> esetBWPlot(tmpSet, ylab="1p36.2", layout = c(2, 8),
+

par.strip.text = list(cex = 0.8))

13

Log2 Expression1p36.2BCR/ABLNEG2^1.52^2.02^2.52^3.02^3.5CA6CENPSBCR/ABLNEGMTORVPS13DBCR/ABLNEGPIK3CDEXOSC10BCR/ABLNEGCASP9CTNNBIP1BCR/ABLNEGPRDM2MFN2BCR/ABLNEGTNFRSF1BCLCN6BCR/ABLNEGDHRS3SLC2A5BCR/ABLNEGVAMP32^1.52^2.02^2.52^3.02^3.5CLSTN1References

S. Chiaretti, X. Li, R. Gentleman, A. Vitale, K. S. Wang, F. Mandelli, R. Foa, and J. Ritz. Gene
expression profiles of b-lineage adult acute lymphocytic leukemia reveal genetic patterns that identify
lineage derivation and distinct mechanisms of transformation. Clinical Cancer Research, 11:7209–
7219, 2005.

S Falcon and R Gentleman. Using GOstats to test gene lists for GO term association. Bioinformatics,

23(2):257–8, 2007.

T. S. Furey and D. Haussler. Integration of the cytogenetic map with the draft human genome sequence.

Human Molecular Genetics, 12:1037–1044, 2003. URL DOI:10.1093/hmg/ddg113.

F. Hahne, W. Huber, R. Gentleman, and S. Falcon. Bioconductor Case Studies. Springer, New York,

2008.

Z. Jiang and R. Gentleman. Extensions to gene set enrichment. Bioinformatics, 23:306–313, 2007.

Gordon K. Smyth. Limma: linear models for microarray data. In R. Gentleman, V. Carey, S. Dudoit,
R. Irizarry, and W. Huber, editors, Bioinformatics and Computational Biology Solutions using R and
Bioconductor, pages 397–420. Springer, New York, 2005.

A. Subramanian, P. Tamayo, V. K. Mootha, et al. Gene set enrichment analysis: A knowledge-based
approach for interpreting genome-wide expression profiles. Proceedings of the National Academy of
Sciences, 102(43):15545–15550, 2005.

L. Tian, S. A. Greenberg, S. W. Kong, et al. Discovering statistically significant pathways in expression
profiling studies. Proceedings of the National Academy of Sciences, 102(38):13544–13549, 2005.

Clifford H. Wagner. Simpson’s paradox in real life. The American Statistician, 36(1):46–48, 1982.

ISSN 00031305.

14


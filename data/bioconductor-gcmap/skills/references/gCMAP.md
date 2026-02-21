Gene set analyses with the gCMAP package

Thomas Sandmann and Richard Bourgon

October 30, 2018

This document exempliﬁes the structure and use of the classes and (some of) the methods oﬀered by
the gCMAP package. For information on performing queries via an R-only, custom web application and to
access a tutorial with examples using real biological datasets available from public databases, please refer to
the documentation of the gCMAPWeb companion package.

Contents

1 Introduction

2 CMAPCollection, SignedGeneSet and CMAPResults classes

2.1 CMAPCollections . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Comparing GeneSets

3.1 CMAPResults . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Diﬀerential expression analysis with gene sets

5 Analysis of individual score proﬁles

6 Overview plots

7 Retrieving gene-level information

2

2
2

4
4

6

8

10

11

1

1 Introduction

The gCMAP package oﬀers uniﬁed access to a number of diﬀerent algorithms to compare a sets of genes across
It extends the functionality of the GSEABase package, which provides
expression proﬁling experiments.
functions to generate and combine GeneSets from various sources.

2 CMAPCollection, SignedGeneSet and CMAPResults classes

Them gCMAPpackage introduces three new classes:

(cid:136) SignedGeneSet: Extends the GeneSet class, with an additional geneSign slot to distinguish up- and

downregulated set members.

(cid:136) CMAPCollection:

Is derived from the eSet class for eﬃcient storage of large numbers of gene sets

and related annotations.

(cid:136) CMAPResults: Provides a uniﬁed output class for diﬀerent gene set enrichment analysis methods.

2.1 CMAPCollections

To evaluate large gene sets collections containing thousands of gene sets, the gCMAP package introduces
a new class CMAPCollections , to store gene sets and their relationships with each other in the form
of a (sparse) incidence matrix. A derivative of the eSet class, a CMAPCollection also stores gene and
gene set annotations in its featureData and phenoData slots.

CMAPCollections can be created de novo, e.g. with the newCMAPCollection function, or by coerc-
ing existing GeneSet, SignedGeneSet or GeneSetCollection objects. Often, large data matrices
e.g. containing diﬀerential expression data from many diﬀerent experiments, are available. The in-
duceCMAPCollection function can be used to deﬁne gene sets from any eSet object by applying a
user-deﬁned threshold.

The gCMAPData NChannelSet object stores the results of three perturbation experiments, stimulation
of tissue culture cells with drug1, drug2 or drug3. For each experiment, log2 fold change, z-scores and
p-values (from diﬀerential expression analysis with the limma package) are available.

> library(gCMAP)
> data( gCMAPData ) ## example NChannelSet
> sampleNames( gCMAPData )

[1] "drug1" "drug2" "drug3"

> channelNames( gCMAPData )

[1] "log_fc" "p"

"z"

To induce gene sets of interest, a data slot and thresholds must be chosen.

> ## select all genes with z-scores > 2 or < -2
> cmap <- induceCMAPCollection( gCMAPData, element="z", lower=-2, higher=2)
> cmap

2

CMAPCollection (storageMode: lockedEnvironment)
assayData: 1000 features, 3 samples

element names: members

protocolData: none
phenoData

sampleNames: drug1 drug2 drug3
varLabels: UID signed
varMetadata: labelDescription

featureData: none
experimentData: use
Annotation:

’

experimentData(object)

’

> pData( cmap )

UID signed
TRUE
TRUE
TRUE

1
2
3

drug1
drug2
drug3

The sign of the diﬀerential expression (e.g. the sign of the z-score or log2 fold change) is stored in
the sparseMatrix stored as assayData in the CMAPCollection . Up-regulated gene set members are
indicated by +1, down-regulated members by -1.

> head( members( cmap ) )

6 x 3 sparse Matrix of class "dgCMatrix"

gene.1
gene.2
gene.3
gene.4
gene.5
gene.6

drug1 drug2 drug3
.
.
.
.
.
.

.
.
.
-1
.
.

.
.
.
.
.
-1

Sometimes, e.g. when selecting gene sets based on p-values, no sign information is available and all set
members will simply be indicated with +1. To distinguish sets without sign information from those
only containing up-regulated members, the signed column of the phenoData slot indicates how the
information should be interpreted.

> signed( cmap )

drug1 drug2 drug3
TRUE TRUE TRUE

As for other eSet-like objects, CMAPCollections can be subset to extract speciﬁc genes or gene sets.

> dim( cmap )

Features Samples
3

1000

> cmap[,1] ## the first gene set

3

CMAPCollection (storageMode: lockedEnvironment)
assayData: 1000 features, 1 samples

element names: members

protocolData: none
phenoData

sampleNames: drug1
varLabels: UID signed
varMetadata: labelDescription

featureData: none
experimentData: use
Annotation:

’

experimentData(object)

’

3 Comparing GeneSets

To compare the list of geneIds present in diﬀerent CMAPCollections , GeneSets or GeneSetCollec-
tions , the Fisher test can be used. In addition to the GeneSets of interest, we also need to provide
information about the gene ’universe’, the complete ensemble of genes that could potentially be in-
cluded in any set, e.g. all genes for which probes are available on a microarray, etc. Here, we will use
all identiﬁers present in the gCMAPData dataset to deﬁne the gene identiﬁer universe.
The following example compares the ﬁrst gene set in our CMAPCollecttion to all three included
sets. (In this vignette, we will refer to ’query’ and ’target’ objects. Every query object is compared
individually to all targets and the results are returned in a single object.)

> universe <- featureNames( gCMAPData )
> results <- fisher_score(cmap[,1], cmap, universe)
> results

CMAPResults object with the following data slots:
set, trend, pval, padj, effect, LOR, nSet, nFound, geneScores, UID, signed
for 3 gene sets.
1 test(s) obtained an adjusted p-value < 0.05

Results from Fisher exact tests.
P-values were adjusted using the

’

p.adjust

’

function with method

’

’

BH

.

set trend

padj effect
1 drug1 over 2.132837e-210 6.398511e-210 30.96
2 drug2 over 2.415470e-01 3.623206e-01
3 drug3 over 6.880119e-01 6.880119e-01

pval

1.17 0.3328643
0.40 0.1576603

LOR nSet nFound UID
1
Inf 190
2
83
3
42

190
20
9

signed
1 FALSE
2 FALSE
3 FALSE
... (only top 5 results shown, use

’

cmapTable

’

function to see all) ...

The ﬁsher score method returns a CMAPResults object, used by all analysis methods supported by the
gCMAP package.

3.1 CMAPResults

Each CMAPResults object contains three elements

4

– An AnnotatedDataFrame called ’table’, storing the results of comparing one query to all of the
targets. Additional columns can be used to store information about the target gene sets. The
supported gene set enrichment analysis methods return various scores, eﬀect sizes and p-values,
documented in the varMetadata slot of the ’table’. They can be accessed with the labels
method.

– A ’docs’ character vector to record information about the analysis run as a whole.

– A list ’errors’, where potential warnings and error messages can be stored.

To cmapTable method returns the full result table, including annotation columns (if present) and
labels. Individual accessors have been to return the p-value columns (pval or padj ), eﬀect size
(effect ) or to transform the adjusted p-values to z-scores on a standard normal scale (zscores
).

> cmapTable( results )

set trend

padj effect
1 drug1 over 2.132837e-210 6.398511e-210 30.96
2 drug2 over 2.415470e-01 3.623206e-01
3 drug3 over 6.880119e-01 6.880119e-01

pval

1.17 0.3328643
0.40 0.1576603

LOR nSet nFound UID
1
Inf 190
2
83
3
42

190
20
9

signed
1 FALSE
2 FALSE
3 FALSE

> labels( results )

labelDescription
SetName
set
Deviation from random expectation
trend
s exact test p-value
pval
Adjusted p-value (BH)
padj
z-score based on the standard normal distribution
effect
Log Odds Ratio
LOR
Number of genes annotated in the reference set
nSet
nFound
Number of genes found in query and target sets
geneScores Identifiers of genes found in query and target sets
UID
UID
signed
signed

Fisher

’

> pval( results )

drug3
2.132837e-210 2.415470e-01 6.880119e-01

drug2

drug1

> zscores( results )

drug1

drug3
30.9201734 0.9109522 0.4015545

drug2

Several gene set enrichment analyses support many-to-many comparisons, including ﬁsher score.
In this case, we receive a list of multiple CMAPResults objects, one for each element of the query.
Each CMAPResults object contains the results for all query gene sets ordered by p-value. To
extract individual slots from all CMAPResult objects in the list, e.g. with sapply , we must
ensure that all results are returned in the same order, e.g. ordered by sampleNames.

> result.list <- fisher_score( cmap, cmap, universe )
> class( result.list )

5

[1] "list"

> length( result.list )

[1] 3

> class( result.list[[1]] )

[1] "CMAPResults"
attr(,"package")
[1] "gCMAP"

> ## all pairwise adjusted p-values
> sapply(result.list, function( x ) {
+
+

padj( x )[ sampleNames( cmap )]
})

drug1

drug3
drug1 6.398511e-210 2.415470e-01 6.880119e-01
drug2 3.623206e-01 3.922263e-123 2.271885e-01
drug3 6.880119e-01 2.271885e-01 1.009276e-74

drug2

4 Diﬀerential expression analysis with gene sets

Frequently, we are interested in diﬀerential expression of gene sets across two or more conditions.
The gCMAP package currently provides uniﬁed access to the sample-label permutation strategy
implemented in the GSEAlm package, as well as multiple functions from the limma package: cam-
era , romer and mroast . (For a detailed explanation oft the diﬀerent methods, please consult
the help entries of the original packages directly.)
For all methods, pre-processed expression data can be supplied as a data matrix, an Expression-
Set or any other eSet derivative. To perform a diﬀerential expression analysis, the experimental
design must be speciﬁed, either by providing a design matrix directly or, for eSet or Expres-
sionSet objects, as a character string matching a phenoData column name.
Let’s generate an matrix with random expression values, three treated and three control samples:

> ## random score matrix
> y <- matrix(rnorm(1000*6),1000,6,
+
> predictor <- c( rep("Control", 3), rep("Case", 3))

dimnames=list( featureNames( gCMAPData ), 1:6 ))

along with a CMAPCollection containg four unsigned gene sets, the ﬁrst of which is actually
diﬀerentially up-regulated in the ’Case’ group.

> m <-replicate(4, {
s <- rep(0,1000)
+
s[ sample(1:1000, 20)] <- 1
+
s[ sample(1:1000, 20)] <- -1
+
s
+
+
})
> dimnames(m) <- list(row.names( y ),
+
> ## Set1 is up-regulated
> y[,c(4:6)] <- y[,c(4:6)] + m[,1]*2
> ## create CMAPCollection
> cmap <- CMAPCollection(m, signed=rep(TRUE,4))

paste("set", 1:4, sep=""))

6

The gCMAP package oﬀers four diﬀerent algorithms to test for diﬀerential expression between
the ’control’ and ’treatment’ samples:

> gsealm_score(y, cmap, predictor=predictor, nPerm=100)

CMAPResults object with the following data slots:
set, trend, pval, padj, effect, nSet, nFound, geneScores, signed
for 4 gene sets.
0 test(s) obtained an adjusted p-value < 0.05

GSEAlm analysis with formula ~predictor using 100 sample label permutations.
P-values were adjusted with the

function using method

p-adjust

BH

.

’

’

’

’

set

trend

pval

padj

correlated 0.10891089 0.2178218

1 set1 anticorrelated 0.04950495 0.1980198 -20.43122144
2 set3
2.70354234
3 set4 anticorrelated 0.22772277 0.3036304 -1.83425784
4 set2 anticorrelated 0.43564356 0.4356436 -0.04400188
... (only top 5 results shown, use

cmapTable

’

’

effect nSet nFound signed
TRUE
TRUE
TRUE
TRUE

40
39
40
39
function to see all) ...

40
39
40
39

> mroast_score(y, cmap, predictor=predictor)

CMAPResults object with the following data slots:
set, trend, pval, padj, nSet, geneScores, signed
for 4 gene sets.
0 test(s) obtained an adjusted p-value < 0.05

All results, including adjusted p-values, were obtained
with the

function from the

package..

mroast

limma

’

’

’

’

set trend pval

Up 0.022 0.0860000
1 set4
2 set2
Up 0.110 0.2190000
3 set3 Down 0.328 0.4366667
4 set1 Down 0.758 0.7580000
... (only top 5 results shown, use

padj nSet signed
40 FALSE
39 FALSE
39 FALSE
40 FALSE
’

cmapTable

function to see all) ...

’

Both gsealm score and mroast perform self-contained test.
(Goeman and Buhlmann, 2007).
(Please note that we only run 100 gsealm_score permutations to obtain a p-value in this example
- in a real analysis, increasing this number, e.g. to 1000, is recommended.) In case a competitive
hypothesis needs to be tested, the camera score and romer score methods (calling the romer and
camera functions from the limma package, respectively) can be used instead.

> camera_score(y, cmap, predictor=predictor)

CMAPResults object with the following data slots:
set, trend, pval, padj, effect, nSet, nFound, geneScores, signed
for 4 gene sets.
0 test(s) obtained an adjusted p-value < 0.05

Results were obtained with the

’

’

camera

function from the

’

’

limma

package.

set trend

pval

padj

Up 0.04003827 0.1601531 0.001950711
1 set4
2 set2
Up 0.22253604 0.4450721 -0.005601161
3 set3 Down 0.46405430 0.6187391 -0.017038706

effect nSet nFound signed
40 FALSE
39 FALSE
39 FALSE

40
39
39

7

4 set1 Down 0.83458180 0.8345818 -0.020638303
’
... (only top 5 results shown, use

cmapTable

’

40

40 FALSE

function to see all) ...

> romer_score(y, cmap, predictor=predictor)

CMAPResults object with the following data slots:
set, trend, pval, padj, nSet, nFound, geneScores, signed
for 12 gene sets.
1 test(s) obtained an adjusted p-value < 0.05
nResults obtained with the
P-values were adjusted with the

function from the

romer
’

p-adjust

’

’

’

’

’

limma

package.
’
’

function using method

BH

.

set trend

pval

1 set1 Mixed 0.0001 0.00120
2 set4
Up 0.0195 0.11700
3 set3 Down 0.1501 0.59310
Up 0.1977 0.59310
4 set2
5 set1 Down 0.3138 0.75312
... (only top 5 results shown, use

padj nSet nFound signed
40 FALSE
40 FALSE
39 FALSE
39 FALSE
40 FALSE
’

40
40
39
39
40

cmapTable

’

function to see all) ...

Currently, only gsealm score takes the sign of the gene set members (indicating whether a gene
had originally be identiﬁed as up- or down-regulated) into account.

5 Analysis of individual score proﬁles

In addition to analyzing complete experiments, other approaches to gene set enrichment testing
evaluate whether a given statistic for the members of a gene set ranked highly relative to random
sets.
The wilcox score method calculates the Wilcox-rank sum statistic, assessing whether the ranked
scores of a gene set are enriched at the top or bottom of the complete list of scores.
The gsealm jg score calculates the mean score for all gene set members and provides a p-value
based on the standard normal distribution (Jiang and Gentleman, 2007).
The connectivity score is calculated according to Lamb, J. et al. (2006) and corresponds to the
scaled score described in this publication. (It does not provide a p-value.)
For illustration, we compare the ﬁrst column of z-scores stored in the gCMAPData NChannelSet
to the three gene sets induced from the same dataset in the ﬁrst section of this vignette..

> profile <- assayDataElement(gCMAPData[,1], "z") ## extract first column
> head(profile)

drug1
gene.1 -0.4600253
gene.2 -1.8756099
gene.3 -0.7766186
gene.4 -2.9651795
gene.5 -1.2265235
gene.6 -0.1037107

> sampleNames(cmap) ## three gene sets

[1] "set1" "set2" "set3" "set4"

> gsealm_jg_score(profile, cmap)

8

CMAPResults object with the following data slots:
set, trend, pval, padj, effect, nSet, nFound, geneScores, signed
for 4 gene sets.
1 test(s) obtained an adjusted p-value < 0.05

’

’

Parametric
P-values were adjusted with the

score summary.

JG

’

p-adjust

’

function using method

’

’

BH

.

pval

trend

set
correlated 0.0000876562 0.0003506248 3.9224415
1 set3
correlated 0.1362445453 0.2724890906 1.4899228
2 set1
correlated 0.2202631146 0.2936841528 1.2258288
3 set4
4 set2 anticorrelated 0.7151943940 0.7151943940 -0.3648888
... (only top 5 results shown, use

effect nSet nFound signed
TRUE
TRUE
TRUE
TRUE

function to see all) ...

39
40
40
39

39
40
40
39

cmapTable

padj

’

’

As expected the ﬁrst gene set, which was derived from the same experiment as the proﬁle, receives
highly signiﬁcant p-values.
Alternatively, the Wilcox Rank sum test or the original Connectivity Score can be calculated.
(Please note that the connectivity_score does not return a p-value and is hard to interpret for
a single proﬁle.)

> wilcox_score(profile, cmap)

CMAPResults object with the following data slots:
set, trend, pval, padj, effect, nSet, nFound, geneScores, signed
for 4 gene sets.
0 test(s) obtained an adjusted p-value < 0.05

Results from a two-tailed Wilcox-Rank Sum test
p-values were adjusted using the

p.adjust

’

’

function with method

’

’

BH

.

pval

trend

set
correlated 0.01691948 0.06767791 2.1219855
1 set3
2 set1
correlated 0.18424955 0.27469067 0.8992883
3 set2 anticorrelated 0.25881533 0.27469067 -0.6470020
4 set4
correlated 0.27469067 0.27469067 0.5986874
... (only top 5 results shown, use

effect nSet nFound signed
TRUE
TRUE
TRUE
TRUE

function to see all) ...

39
40
39
40

39
40
39
40

cmapTable

padj

’

’

> connectivity_score(profile, cmap)

CMAPResults object with the following data slots:
set, trend, effect, nSet, nFound, geneScores, signed
for 4 gene sets.
Scores were calculated and scaled according to Lamb, J. et al. (2006).

set trend

1 set2 down -1.0000000
up 1.0000000
2 set3
up 0.7930686
3 set1
4 set4
up 0.7450038
... (only top 5 results shown, use

effect nSet nFound signed
TRUE
TRUE
TRUE
TRUE
cmapTable

39
39
40
40

39
39
40
40

’

’

function to see all) ...

9

6 Overview plots

When comparing a set of genes, a proﬁle or a complete experiment to a large gene set collection,
e.g. induced from the original Connectivity map data generated at the Broad institute (Lamb et
al, Science, 2006), high level diagnostic plots can provide a ﬁrst overview of the results.
For illustration purposes, we generate a random proﬁle of z-scores for 1000 genes as well as
CMAPCollection with a random set of 1000 gene sets. One of them, set1, is actually diﬀerentially
regulated.

> ## create random score profile
> set.seed(123)
> z <- rnorm(1000)
> names(z) <- paste("g", 1:1000, sep="")
> ## generate random incidence matrix of gene sets
> n <-replicate(1000, {
s <- rep(0,1000)
+
s[ sample(1:1000, 20)] <- 1
+
s[ sample(1:1000, 20)] <- -1
+
s
+
+
})
> dimnames(n) <- list(names(z), paste("set",
+
+
> ## Set1 is up-regulated
> z <- z + n[,1]*2
> ## create CMAPCollection
> cmap.2 <- CMAPCollection(n, signed=rep(TRUE,1000))

1:1000,
sep=""))

> ## gene-set enrichment test
> res <- gsealm_jg_score(z, cmap.2)
> class(res)

[1] "CMAPResults"
attr(,"package")
[1] "gCMAP"

> res

CMAPResults object with the following data slots:
set, trend, pval, padj, effect, nSet, nFound, geneScores, signed
for 1000 gene sets.
1 test(s) obtained an adjusted p-value < 0.05

’

’

Parametric
P-values were adjusted with the

score summary.

JG

’

p-adjust

’

function using method

’

’

BH

.

pval

trend

set
1
set1
correlated 1.534819e-47 1.534819e-44 14.483753
correlated 3.470647e-04 1.735323e-01 3.577373
2 set405
3 set632 anticorrelated 6.603058e-04 2.201019e-01 -3.405551
4 set599 anticorrelated 8.892471e-04 2.223118e-01 -3.323408
5 set672 anticorrelated 2.063107e-03 3.723693e-01 -3.080994
... (only top 5 results shown, use

effect nSet nFound signed
TRUE
TRUE
TRUE
TRUE
TRUE

40
40
39
40
40
function to see all) ...

40
40
39
40
40

cmapTable

padj

’

’

> plot(res)

10

A call to the plot method on a CMAPResults object yields two graphical overviews: on the left,
a density of all 1000 reported eﬀect sizes, in this case JG-scores, is shown.
In the absence of
correlation between genes, this distribution follows a normal distribution. ( While this is true for
this set of randomly generated scores, the distribution of JG scores observed in practice is actually
broader than expected, testament to the non-random patterns of gene expression.)
On the right, a heatmap of the rank-ordered scores is displayed, with low and high scores displayed
as blue and red stripes, respectively. By default, scores between -3 and 3 are hidden. To display
scores above 3 or below -3, a color gradient from white to red or from white to blue is applied,
respectively. (Both the choice of colors and thresholds of the color gradients can be conﬁgured,
please see the CMAPResults help page for details.)

> sets.down <- effect( res ) < -3
> plot(res)

7 Retrieving gene-level information

Once signiﬁcantly enriched gene sets have been identiﬁed, we may want to take a closer look at
the behavior of individual genes. Are expression changes associated with many gene set members
or do speciﬁc genes respond particularly strongly ?

11

0510150.00.10.20.30.4Distribution of similarity scoresSummarized t−statisticDensityAll scoresCorrelated instanceAnti−correlated instanceNormal distr.0510150.00.10.20.30.4Distribution of similarity scoresSummarized t−statisticDensityAll scoresCorrelated instanceAnti−correlated instanceNormal distr.All methods implemented in the gCMAP package, with the exception of fisher_score , return
gene-level scores when the optional ’keep.scores’ parameter is set to ’TRUE’. To demonstrate, we
repeat the gsealm_score call from above.

> res <- gsealm_score(y, cmap, predictor=predictor, nPerm=100, keep.scores=TRUE)
> res

CMAPResults object with the following data slots:
set, trend, pval, padj, effect, nSet, nFound, geneScores, signed
for 4 gene sets.
0 test(s) obtained an adjusted p-value < 0.05

GSEAlm analysis with formula ~predictor using 100 sample label permutations.
P-values were adjusted with the

function using method

p-adjust

BH

.

’

’

’

’

set

trend

pval

padj

1 set1 anticorrelated 0.03960396 0.1584158 -20.43122144
2 set3
2.70354234
3 set4 anticorrelated 0.14851485 0.1980198 -1.83425784
4 set2 anticorrelated 0.40594059 0.4059406 -0.04400188

correlated 0.08910891 0.1782178

effect nSet nFound signed
TRUE
TRUE
TRUE
TRUE

40
39
40
39

40
39
40
39

geneScores
1 40 x 6 matrix
2 39 x 6 matrix
3 40 x 6 matrix
4 39 x 6 matrix
... (only top 5 results shown, use

’

cmapTable

’

function to see all) ...

> set1.expr <- geneScores(res)[["set1"]]
> head(set1.expr)

1

2

6
3
-0.68996932 -0.9836994 0.3998640 2.7788371 0.314569 1.8665243
gene.5
0.65027279 -0.6462995 1.3528323 -0.1589035 -3.433760 -1.8378734
gene.47
gene.58
0.06942784 -0.9216440 -1.2380811 3.6208384 1.178123 2.5396171
gene.111 -2.37830696 -0.3649821 0.9656168 0.8433821 1.128249 1.4554369
gene.119 0.17681966 -0.8594510 -0.1899342 1.5264597 2.414035 0.9451387
gene.219 0.61767349 -1.4858271 -1.7799156 3.2343891 2.059271 1.1006959

4

5

Expression scores for each gene set are now available in the geneScores cmapResults colum,
which can be accessed through a method with the same name. Each matrix of expression scores
is accompanied by an additional ’sign’ attribute to remind us whether gene set members were
annotated as up- or down-regulated.
For example, we can now visualize the expression scores of set1 member genes in a heatmap. As
expected, genes annotated as ’up-regulated’ (red sidebar) show higher expression in Cases than
Controls and the reverse is true for genes annotated as ’down-regulated’ (blue sidebar).

RowSideColors=ifelse( attr(set1.expr, "sign") == "up", "red", "blue"),
margin=c(7,5))

> heatmap(set1.expr, scale="none", Colv=NA, labCol=predictor,
+
+
> legend(0.35,0,legend=c("up", "down"),
fill=c("red", "blue"),
+
title="Annotated sign", horiz=TRUE, xpd=TRUE)
+

12

Each row in the CMAPResults objects features an subset of the original query ExpressionSet. As
genes can be part of many diﬀerent genes sets, querying large gene set collections may result in
storing duplicate data rows over and over again, considerably increasing the memory footprint of
the CMAPResults object.
Alternatively, we can extract the scores from the original data source. For example, we can obtain
a nested list of scores for all sets and data columns by passing the CMAPCollection (cmap) and
the score matrix (y) to the featureScores method. The element for ’set1’ corresponds to the
score matrix we obtained above.

> res <- featureScores(cmap, y)
> class(res)

[1] "list"

> names(res)

[1] "set1" "set2" "set3" "set4"

> identical( res[["set1"]], set1.expr )

[1] TRUE

>

sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:

13

ControlControlControlCaseCaseCasegene.556gene.268gene.733gene.47gene.609gene.857gene.316gene.957gene.278gene.617gene.396gene.611gene.360gene.854gene.746gene.463gene.684gene.685gene.441gene.848gene.5gene.919gene.219gene.58gene.829gene.111gene.886gene.942gene.303gene.936gene.694gene.906gene.356gene.593gene.389gene.642gene.119gene.680gene.281gene.959Annotated signupdown[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats4
[8] methods

parallel stats
base

graphics grDevices utils

datasets

other attached packages:

[1] bigmemory_4.5.33
[4] locfit_1.5-9.1
[7] GSEABase_1.44.0

[10] XML_3.98-1.16
[13] S4Vectors_0.20.0

DESeq_1.34.0
gCMAP_1.26.0
graph_1.60.0
AnnotationDbi_1.44.0 IRanges_2.16.0
Biobase_2.42.0

lattice_0.20-35
limma_3.38.0
annotate_1.60.0

BiocGenerics_0.28.0

loaded via a namespace (and not attached):
compiler_3.5.1

[1] Rcpp_0.12.19
[4] bigmemoryExtras_1.30.0 bitops_1.0-6
[7] digest_0.6.18
[10] memoise_1.1.0
[13] Category_2.48.0
[16] bit64_0.9-7
[19] RBGL_1.58.0
[22] blob_1.1.1
[25] RCurl_1.95-4.11

bit_1.1-14
Matrix_1.2-14
GSEAlm_1.42.0
grid_3.5.1
survival_2.43-1
splines_3.5.1

RColorBrewer_1.1-2
tools_3.5.1
RSQLite_2.1.1
DBI_1.0.0
genefilter_1.64.0
bigmemory.sri_0.1.3
geneplotter_1.60.0
xtable_1.8-3

14


Description of MergeMaid

Xiaogang Zhong, Leslie Cope, Elizabeth Garrett-Mayer, Giovanni Parmigiani

April 24, 2017

1

Introduction

MergeMaid is designed to facilitate multi-study analysis. The merging function gener-
ates objects that can eﬃciently support a variety of joint analyses. Visualization tools
allow for exploration of the data without requiring normalization across platforms. We
have updated the package by adding a quick approximate calculation of the integrative
correlation.

Version 2.1.6 of MergeMaid includes the following primary functions, with corre-

sponding data classes

mergeExprs
intCor

Merge Datasets into an object of class mergeExpressionSet.
Compute integrative correlation coeﬃcients,
returns an object of class mergeCor.

modelOutcome Fit various models to the data,

models currently available include linear and logistic regression, and
Cox hazards,
returns an object of class mergeCoeﬀ.

In addition, there are a number of functions for the manipulation, retrieval and
visualization of data. These functions depend on the data class for which they are
deﬁned and will be discussed below.

The mergeExprs function and the mergeExpressionSet class The primary data
class in the MergeMaid package is the mergeExpressionSet, based on the Expres-
sionSet class deﬁned in Bioconductor.
’mergeExprs’ returns an object of class
mergeExpressionSet, required for all analytic functions included in the package.
A mergeExpressionSet object contains the following slots

data
geneStudy
notes

a list of ExpressionSet objects, one per study
incidence matrix indicating which genes are measured in each study.

1

The standard way to build a mergeExpressionSet object is with the function
mergeExprs. This function accepts expression data in a variety of formats, in-
cluding ExpressionSet objects, simple matrices of expression values and other
mergeExpressionSets. Any combination of these is acceptable. Merging is based
on user-supplied gene ids (e.g. Genbank, Unigene, or LocusLink ID’s). These
IDs should make up the rownames for each expression data matrix. Frequently
an expression array will include multiple probesets for some genes, and these may
be assigned the same geneid. This presents a special problem for the merging of
data across platforms, becoming important when carrying out an analysis on the
merged data, (e.g. regression or survival analysis) for which genes need to be un-
ambiguously matched. In general, appropriate measures are left up to the user at
ID assignment. To prevent potential problems, replicates within a dataset which
still share the same ID are averaged during the merging process.

There are a number of functions to access and manipulate the data in a mergeExpressionSet.

exprs
geneStudy
notes
names
geneNames
phenoData
[

intersection

notes<-
names<-
geneNames<-
plot

returns the contents of the data slot
returns the contents of the data slot
returns the contents of the data slot
returns study names
returns the entire list of gene IDs
returns a list containing the phenodata (if any) included for each study
returns a mergeExpressionSet object containing only the indicated
studies
returns a single ExpressionSet containing all studies and all common
genes
replaces the contents of the data slot
replaces the study names
replaces gene IDs.
Draw scatterplots to compare integrative correlations for genes.

The two main analytic functions in the package are deﬁned for mergeExpressionSet
objects as well, but are discussed in separate sections, as each has an associated
class.

The intCor function and the mergeCor class When working with data from dif-
ferent sources is important to identify those genes which are measured in similar
ways in the various datasets, and can be used in joint analyses.

MergeMaid includes a gene reproducibility index called the integrative correla-
tion coeﬃcient and calculated using the function intCor. Within each study,
and for each pair of genes, we calculate the correlation coeﬃcient of expression val-
ues across subjects. By examining whether, for a speciﬁc gene, these correlations

2

agree across studies we can quantify the reproducibility of results without relying
on direct comparison of expression across platforms. The integrative correlations
provides a reproducibility score for each gene. This analysis is unsupervised in
that consistency is measured without using information about sample phenotypes.

The output from the intCor function is an object of class mergeCor, containing
integrative correlation coeﬃcients for a single mergeExpressionSet object. Such
an object contains the following slots

pairwise.cors matrix containing the integrative correlation for each pair of studies.
max.cors

vector representing maximal canonical correlation (pairwise canonical
correlations) for each pair of studies.

If n is the number of studies then for i < j ≤ n, the pairwise correlation of
correlations for studies i and j is stored in column (i − 1) ∗ (n − 1) − (i − 2) ∗ (i −
1)/2 + j − i of the pairwise.cors slot.

The total integrative correlation for each gene is obtained by averaging the n(n −
1)/2 pairwise integrative correlations.

The methods available for this class are:

pairwise.cors
max.cors

Accessor function for the pairwise.cors slot
Accessor function for the maximal canonical correlation (pairwise
canonical correlations) for each pair of studies.

integrative.cors Accessor function, returns total integrative correlation for each gene.

In addition, there is a function called intcorDens, which plots a smooth density
curve for the true distribution of integrative correlation coeﬃcients as well as the
null distribution density curve obtained by permuting expression values. These
plots can be used to help identify a useful threshold of reproducibility. Since
the permutation required the original expression data, this function is deﬁned for
mergeExpressionSet objects rather than for mergeCor objects, but in spirit belongs
here.

The modelOutcome function and the mergeCoeﬀ class The function modelOutcome
calculates gene/study speciﬁc coeﬃcients for a variety of models. The output from
the modelOutcome function is an object of class mergeCoeff Such an object con-
tains the following slots

a matrix of coeﬃcients, rows=genes, columns=studies

coeﬀs
coeﬀ.std matrix of standardized coeﬃcients
zscore

matrix of zscores for the coeﬃcients

3

Only 3 models are implemented in the ﬁrst version of MergeMaid: linear regression,
logistic regression and cox hazard rate.

Methods for this class include:

Accessor function for the coeﬀ slot.

coeﬀ
coeﬀstd Accessor function for the coeﬀ.std slot.
zscore
plot

Accessor function for the zscore slot.
Draw scatterplots to compare coeﬃcients from diﬀerent studies.

The plot function is actually deﬁned for the matrix class, rather than for the
mergeCoeﬀ class. The usual syntax is plot(coeff(mergeCoeff)) so that the
coeﬃcients are selected.

4


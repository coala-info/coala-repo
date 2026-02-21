Package ‘EGAD’

February 9, 2026

Type Package

Title Extending guilt by association by degree

Version 1.38.0

Date 2016-04-20

Description The package implements a series of highly efficient tools
to calculate functional properties of networks based on guilt
by association methods.

License GPL-2

Depends R(>= 3.5)

Imports gplots, Biobase, GEOquery, limma, impute, RColorBrewer, zoo,

igraph, plyr, MASS, RCurl, methods

Suggests knitr, testthat, rmarkdown, markdown

VignetteBuilder rmarkdown

RoxygenNote 7.1.1

LazyData true

LazyDataCompression gzip

Encoding UTF-8

biocViews Software, FunctionalGenomics, SystemsBiology,

GenePrediction, FunctionalPrediction, NetworkEnrichment,
GraphAndNetwork, Network

Author Sara Ballouz [aut, cre], Melanie Weber
[aut, ctb], Paul Pavlidis [aut], Jesse Gillis
[aut, ctb]

Maintainer Sara Ballouz <sarahballouz@gmail.com>

git_url https://git.bioconductor.org/packages/EGAD

git_branch RELEASE_3_22

git_last_commit e4b84b7

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-09

1

2

Contents

Contents

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
assortativity .
3
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
attr.human .
3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
attr.mouse .
.
.
4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
auc_multifunc .
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
.
auprc
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
auroc_analytic .
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
biogrid .
.
.
.
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
build_binary_network .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
build_coexp_expressionSet .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
build_coexp_GEOID .
8
build_coexp_network .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
9
build_semantic_similarity_network . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
build_weighted_network .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
.
.
calculate_multifunc .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
conv_smoother
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
example_annotations .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
example_binary_network .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
.
.
example_coexpression .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
example_neighbor_voting .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
.
.
extend_network .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
.
filter_network .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
.
filter_network_cols .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
. .
filter_network_rows .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
.
filter_orthologs
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
.
.
fmeasure .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
.
.
.
genes
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
.
get_auc .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
.
get_biogrid .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
.
.
get_counts .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
.
.
get_density .
get_expression_data_gemma . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
get_expression_matrix_from_GEO . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
get_phenocarta .
.
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
.
.
get_prc
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
.
get_roc
.
.
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
.
GO.human .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
.
.
GO.mouse .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
.
.
.
GO.voc .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
.
make_annotations .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
make_genelist .
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
make_gene_network .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
.
make_transparent
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
.
neighbor_voting .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
.
.
node_degree .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
.
.
.
.
ortho .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
.
.
.
.
pheno .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
plot_densities .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
.
.
plot_density_compare .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
.
plot_distribution .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
.
plot_network_heatmap .

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

assortativity

3

.
.

.
.

.
.

.
.

.
plot_prc .
.
plot_roc .
.
.
.
plot_roc_overlay .
plot_value_compare .
.
predictions .
.
repmat .
.
.
run_GBA .

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35

Index

36

assortativity

Calculating network assortativity

Description

The function calculates the assortativity of a network, that measures the preference of interactions
between similar nodes. As in most literature, ’similarity’ is here defined in terms of node degrees.

Usage

assortativity(network)

matrix indicating network structure (symmetric)

Arguments

network

Value

Numeric value

Examples

network <- matrix( sample(c(0,1),36, replace=TRUE), nrow=6,byrow=TRUE)
assort_value <- assortativity(network)

attr.human

Human GENCODE annotations (v22)

Description

A dataset containing identifiers for gene transcripts

attr.mouse

4

Format

A data frame with 60483 rows and 10 variables:

chr chromosome

start chromosomal start position, in base pairs

end chromosomal end position, in base pairs

strand chromosomal strand, + or -

un unknown

ensemblID ENSEMBL identifier

type type of transcript

stat status of transcript

name HUGO identifier

entrezID Entrez identifier

@source ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_22/

attr.mouse

Mouse GENCODE annotations (M7)

Description

A dataset containing identifiers for gene transcripts

Format

A data frame with 46517 rows and 10 variables:

chr chromosome

start chromosomal start position, in base pairs

end chromosomal end position, in base pairs

strand chromosomal strand, + or -

un unknown

ensemblID ENSEMBL identifier

type type of transcript

stat status of transcript

name HUGO identifier

entrezID Entrez identifier

@source ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_mouse/release_M7/

auc_multifunc

5

auc_multifunc

Calculating AUC for functional groups from ranked lists

Description

The function calculates the AUC for a functional group analytically using an optimal ranked list of
genes that indicates association between genes and groups.

Usage

auc_multifunc(annotations, optimallist)

Arguments

annotations

optimallist

Value

binary matrix indicating which list elements are in which functional groups.
Ranked list (multifunctionality analysis, see calculate_multifunc).

aucs array of aucs for each group in annotations

Examples

annotations <- c(rep(0,10))
annotations[c(1,3,5)] <- 1
optimallist <- 10:1
aurocs_mf <- auc_multifunc(annotations, optimallist)

auprc

Area under the precision recall curve

Description

The function calculates the area under the precision-recall curve

Usage

auprc(scores, labels)

Arguments

scores

labels

Value

numeric array

binary array

auprc Numeric value

6

Examples

labels <- c(rep(0,10))
labels[c(1,3,5)] <- 1
scores <- 10:1
auprc <- auprc(scores, labels)

biogrid

auroc_analytic

Area under the receiver operating characteristic curve

Description

The function calculates the area under the receiver operating characteristic (ROC) curve analytically

Usage

auroc_analytic(ranks, labels)

Arguments

ranks

labels

Value

numeric array

binary array

auroc Numeric value

Examples

labels <- c(rep(0,10))
labels[c(1,3,5)] <- 1
scores <- 10:1
auroc <- auroc_analytic(scores, labels)

biogrid

BIOGRID v3.4.126

Description

A data frame containing protein-protein interactions

Format

A data frame with 211506 rows and 2 variables:

entrezID_A List of Entrez identifiers, interactor A

entrezID_B List of Entrez identifiers, interactor B

@source http://thebiogrid.org/

build_binary_network

7

build_binary_network

Builds a binary network

Description

The function creates a gene-by-gene matrix with binary entries indicating interaction (1) or no
interaction (0) between the genes.

Usage

build_binary_network(data, list)

Arguments

data

list

Value

2-column matrix, each row a pair indicating a relationship or interaction

string array of genes/labels/ids

net matrix binary characterizing interactions

Examples

data <- cbind(edgeA=c('gene1','gene2'),edgeB=c('gene3','gene3'))
list <- c('gene1','gene2','gene3')
network <- build_binary_network(data,list)

build_coexp_expressionSet

Builds a coexpression network from an expressionSet

Description

The function generates a dense coexpression network from expression data stored in the expres-
sionSet data type. Correlation coefficicents are used as to weight the edges of the nodes (genes).
Calls build_coexp_network.

Usage

build_coexp_expressionSet(

exprsSet,
gene.list,
method = "spearman",
flag = "rank"

)

8

Arguments

exprsSet

gene.list

method

flag

data class ExpressionSet

array of gene labels

correlation method to use, default Spearman’s rho

string to indicate if the network should be ranked

build_coexp_GEOID

Value

net Matrix symmetric

Examples

exprs <- matrix( rnorm(1000), ncol=10,byrow=TRUE)
gene.list <- paste('gene',1:100, sep='')
sample.list <- paste('sample',1:10, sep='')
rownames(exprs) <- gene.list
colnames(exprs) <- sample.list
network <- build_coexp_expressionSet(exprs, gene.list, method='pearson')

build_coexp_GEOID

Builds a coexpression network given a GEO ID

Description

The function generates a dense coexpression network from expression data stored in GEO. The
expression data is downloaded from GEO. Correlation coefficicents are used as to weight the edges
of the nodes (genes). Calls get_expression_matrix_from_GEO and build_coexp_network.

Usage

build_coexp_GEOID(gseid, gene.list, method = "spearman", flag = "rank")

Arguments

gseid

gene.list

method

flag

Value

string GEO ID of expression experiment

array of gene labels

correlation method to use, default Spearman’s rho

string to indicate if the network should be ranked

net Matrix symmetric

build_coexp_network

9

build_coexp_network

Builds a coexpression network from an expressionSet

Description

The function generates a dense coexpression network from expression data stored as a matrix, with
the genes as row labels, and samples as column labels. Correlation coefficicents are used as to
weight the edges of the nodes (genes). Calls cor.

Usage

build_coexp_network(exprs, gene.list, method = "spearman", flag = "rank")

Arguments

exprs

gene.list

method

flag

Value

matrix of expression data

array of gene labels

correlation method to use, default Spearman’s rho

string to indicate if the network should be ranked

net Matrix symmetric

Examples

exprs <- matrix( rnorm(1000), ncol=10,byrow=TRUE)
gene.list <- paste('gene',1:100, sep='')
sample.list <- paste('sample',1:10, sep='')
rownames(exprs) <- gene.list
colnames(exprs) <- sample.list
network <- build_coexp_network(exprs, gene.list)

build_semantic_similarity_network

Builds a semantic similarity network

Description

The function builds a semantic similarity network given a data and labels

Usage

build_semantic_similarity_network(genes.labels, genes)

Arguments

genes.labels

genes

matrix with rows as genes and columns as a function/label

array of gene IDs

10

Value

net Numeric value

Examples

build_weighted_network

genes.labels <- matrix( sample(c(0,1), 100, replace=TRUE),ncol=10,nrow=10)
rownames(genes.labels) <- 1:10
genes <- 1:10
net <- build_semantic_similarity_network(genes.labels, genes)

build_weighted_network

Builds a weighted network

Description

The function creates a gene-by-gene matrix with binary entries indicating interaction (1) or no
interaction (0) between the genes.

Usage

build_weighted_network(data, list)

Arguments

data

list

Value

3-column matrix, each row a pair indicating a relationship or interaction, and
the last column the weight

string array of genes/labels/ids

net matrix characterizing interactions

Examples

data <- cbind(edgeA=c('gene1','gene2'),edgeB=c('gene3','gene3'), weight=c(0.5, 0.9))
list <- c('gene1','gene2','gene3')
network <- build_weighted_network(data,list)

calculate_multifunc

11

calculate_multifunc

Performing multifunctionality analysis

Description

The function performs multifunctionality analysis ([1]) for a set of annotated genes and creates a
rank based optimallist. For annotations use an ontology that is large enough to serve as a prior (e.g.
GO, Phenocarta).

Usage

calculate_multifunc(genes.labels)

Arguments

genes.labels

Annotation matrix

Value

gene.mfs Returns matrix with evaluation of gene function prediction by given labels:

Examples

genes.labels <- matrix( sample(c(0,1), 100, replace=TRUE),ncol=10,nrow=10)
rownames(genes.labels) = paste('gene', 1:10, sep='')
colnames(genes.labels) = paste('label', 1:10, sep='')
mf <- calculate_multifunc(genes.labels)

conv_smoother

Plot smoothed curve

Description

The function plots a smoothed curve using the convolve function.

Usage

conv_smoother(X, Y, window, raw = FALSE, output = FALSE, ...)

Arguments

X

Y

window

raw

output

...

numeric array

numeric array

numeric value indicating size of window to use

boolean

boolean

other input into the plot function

example_coexpression

12

Value

smoothed X,Y and std Y matrix

Examples

x <- 1:1000
y <- rnorm(1000)
conv <- conv_smoother(x,y,10)

example_annotations

Example of annotations

Description

This dataset includes

example_binary_network

Example of binary network

Description

This dataset includes

Format

Matrices and vectors

example_coexpression

Example of binary network

Description

This dataset includes

Format

Matrices and vectors

example_neighbor_voting

13

example_neighbor_voting

Example of binary network

Description

This dataset includes

Format

entrezID chromosomal start position, in base pairs

name HUGO gene identifier

species species

disease disease

extend_network

Builds an extended network from a binary network

Description

The function extends a binary network by using the inverse of the path length between nodes as a
weighted edge

Usage

extend_network(net, max = 6)

Arguments

net

max

Value

matrix binary and symmetric

numeric maximum number of jumps

ext_net matrix dense and symmetric

Examples

net <- matrix( sample(c(0,1),36, replace=TRUE), nrow=6,byrow=TRUE)
ext_net <- extend_network(net)

14

filter_network_cols

filter_network

Filter on matrix

Description

The function filters out the rows or columns of a matrix such that the size of the group is exclusively
between given min and max values

Usage

filter_network(network, flag = 1, min = 0, max = 1, ids = NA)

Arguments

network

flag

min

max

ids

Value

numeric matrix

numeric 1 for row filtering, 2 for column filtering

numeric value

numeric value

array to filter on

network numeric matrix

Examples

net <- matrix( rnorm(10000), nrow=100)
filt_net <- filter_network(net,1,10,100)

filter_network_cols

Filter on columns

Description

The function filters out the columns of a matrix such that the size of the group is exclusively between
given min and max values

Usage

filter_network_cols(network, min = 0, max = 1, ids = NA)

Arguments

network

min

max

ids

numeric matrix

numeric value

numeric value

array

filter_network_rows

Value

network numeric matrix

Examples

15

genes.labels <- matrix( sample( c(0,1), 10000, replace=TRUE), nrow=100)
rownames(genes.labels) = paste('gene', 1:100, sep='')
colnames(genes.labels) = paste('function', 1:100, sep='')
genes.labels <- filter_network_cols(genes.labels,50,200)

genes.labels <- matrix( sample( c(0,1), 10000, replace=TRUE), nrow=100)
rownames(genes.labels) = paste('gene', 1:100, sep='')
colnames(genes.labels) = paste('function', 1:100, sep='')
genes.labels <- filter_network_cols(genes.labels,ids = paste('function', 1:20, sep=''))

filter_network_rows

Filter on rows

Description

The function filters out the rows of a matrix such that the size of the group is exclusively between
given min and max values

Usage

filter_network_rows(network, min = 0, max = 1, ids = NA)

Arguments

network
min
max
ids

Value

numeric matrix
numeric value
numeric value
array to filter on

network numeric matrix

Examples

genes.labels <- matrix( sample( c(0,1), 10000, replace=TRUE), nrow=100)
rownames(genes.labels) = paste('gene', 1:100, sep='')
colnames(genes.labels) = paste('function', 1:100, sep='')
genes.labels <- filter_network_rows(genes.labels,50,200)

genes.labels <- matrix( sample( c(0,1), 10000, replace=TRUE), nrow=100)
rownames(genes.labels) = paste('gene', 1:100, sep='')
colnames(genes.labels) = paste('function', 1:100, sep='')
genes.labels <- filter_network_rows(genes.labels,ids = paste('gene', 1:20, sep=''))

16

fmeasure

filter_orthologs

Filter on orthologs

Description

The function filters away the labels for the genes that are not in the orthologs list

Usage

filter_orthologs(annotations, genelist, orthologs)

Arguments

annotations

binary matrix

genelist

orthologs

array of gene ids

array to filter on

Value

annotations_filtered binary matrix

Examples

genes.labels <- matrix( sample( c(0,1), 1000, replace=TRUE), nrow=100)
rownames(genes.labels) = paste('gene', 1:100, sep='')
colnames(genes.labels) = paste('function', 1:10, sep='')
gene.list <- paste('gene', 1:100, sep='')
orthologs <- paste('gene', (1:50)*2, sep='')
genes.labels.filt <- filter_orthologs(genes.labels, gene.list, orthologs)

fmeasure

Fmeasure of precision-recall

Description

The function calculates fmeasure for a given beta of a precision-recall curve

Usage

fmeasure(recall, precis, beta = 1)

Arguments

recall

precis

beta

numeric array

numeric array

numeric value, default is 1

17

genes

Value

fmeasure Numeric value

Examples

labels <- c(rep(0,10))
labels[c(1,3,5)] <- 1
scores <- 10:1
prc <- get_prc(scores, labels)
fm <- fmeasure(prc[,1], prc[,2])

genes

Genes from BIOGRID v3.4.126

Description

An array containing identifiers for genes in biogrid

Format

Array

genes List of Entrez identifiers

@source http://thebiogrid.org/

get_auc

Calculates the area under a curve

Description

The function calculates the area under the curve defined by x and y

Usage

get_auc(x, y)

Arguments

x
y

Value

numeric array
numeric array

auc numeric value

Examples

x <- 1:100
y <- 1:100
auc <- get_auc(x,y)

18

get_counts

get_biogrid

Downloading and filtering BIOGRID

Description

The function downloads the specifed version of biogrid for a particular taxon

Usage

get_biogrid(species = "9606", version = "3.5.181", interactions = "physical")

Arguments

species

version

numeric taxon of species

string of biogrid version

interactions

string stating either physical or genetic interactions

Value

biogrid data.frame with interactions

get_counts

Get counts

Description

The function formats the count distribution from the histogram function

Usage

get_counts(hist)

histogram

Arguments

hist

Value

x,y

Examples

x <- runif(1000)
counts <- get_counts( hist(x, plot=FALSE))

get_density

19

get_density

Get density

Description

The function formats the density distribution from the histogram function

Usage

get_density(hist)

histogram

Arguments

hist

Value

array

Examples

x <- runif(1000)
density <- get_density( hist(x, plot=FALSE))

get_expression_data_gemma

Obtain expression matrix from the GEMMA database

Description

The function downloads and parses the expression matrix from the GEMMA database, specified by
the GEO ID

Usage

get_expression_data_gemma(gseid, filtered = "true")

Arguments

gseid

filtered

Value

GEO ID of the expression experiment

flag to indicate whether or not the data is QC

list of genes and the expression matrix

20

get_phenocarta

get_expression_matrix_from_GEO

Obtain expression matrix from GEO database

Description

The function downloads and parses the expression matrix from the GEO file specified by the GEO
ID

Usage

get_expression_matrix_from_GEO(gseid)

Arguments

gseid

Value

GEO ID of the expression experiment

list of genes and the expression matrix

get_phenocarta

Downloading and filtering Phenocarta

Description

The function downloads the latest version of phenocarta

Usage

get_phenocarta(species = "human", type = "all")

Arguments

species

type

Value

string

string

data data.frame with phenocarta data

get_prc

21

get_prc

Build precision-recall curve

Description

The function calculates the recall and precision

Usage

get_prc(ranks, labels)

Arguments

ranks

labels

Value

numeric array

binary array

recall,precision numeric arrays

Examples

labels <- c(rep(0,10))
labels[c(1,3,5)] <- 1
scores <- 10:1
ranks <- rank(scores)
prc <- get_prc(ranks, labels)

get_roc

Build receiver operating characteristic curve

Description

The function calculates the FPR and TRPR for the receiver operating characteristic (ROC)

Usage

get_roc(ranks, labels)

Arguments

ranks

labels

Value

numeric array

binary array

FPR,TPR numeric arrays

GO.mouse

22

Examples

labels <- c(rep(0,10))
labels[c(1,3,5)] <- 1
scores <- 10:1
ranks <- rank(scores)
roc <- get_roc(ranks, labels)

GO.human

GO - human

Description

A dataset of the gene GO associations

Format

A data frame with 2511938 rows and 4 variables:

name gene symbol

entrezID entrez identifier

GO gene ontology term ID

evidence evidence code

@source http://geneontology.org/

GO.mouse

GO - mouse

Description

A dataset of the gene GO associations

Format

A data frame with 2086086 rows and 4 variables:

name gene symbol

entrezID entrez identifier

GO gene ontology term ID

evidence evidence code

@source http://geneontology.org/

GO.voc

23

GO.voc

Gene ontology vocabulary

Description

A dataset of the gene ontology vocabulary

Format

A data frame with 42266 rows and 3 variables:

GOID GO identifier

term GO description

domain GO domain

@source http://geneontology.org/

make_annotations

Creating gene annotations

Description

The function annotates a list of genes according to a given ontology. It creates a binary matrix
associating genes (rows) with labels (columns).

Usage

make_annotations(data, listA, listB)

2-column matrix, each row a pair indicating a relationship or interaction

string array of genes

string array of labels/functions

Arguments

data

listA

listB

Value

net matrix binary

Examples

gene.list <- paste('gene', 1:100, sep='')
labels.list <- paste('labels', 1:10, sep='')
data <- matrix(0,nrow=100, ncol=2)
data[,1] <- sample(gene.list, 100, replace=TRUE)
data[,2] <- sample(labels.list, 100, replace=TRUE)
net <- make_annotations(data, gene.list, labels.list)

24

make_gene_network

make_genelist

Creating list of all genes in the data set.

Description

The function extracts the list of all genes in the data set

Usage

make_genelist(gene_data_interacting)

Arguments

gene_data_interacting

2-column matrix, each row a pair indicating a relationship or interaction

Value

list array of data labels

Examples

gene.list <- paste('gene', 1:100, sep='')
data <- matrix(0,nrow=100, ncol=2)
data[,1] <- sample(gene.list, 50, replace=TRUE)
data[,2] <- sample(gene.list, 50, replace=TRUE)
genes <- make_genelist(data)

make_gene_network

Creating gene-by-gene network

Description

The function creates a gene-by-gene matrix with binary entries indicating interaction (1) or no
interaction (0) between the genes.

Usage

make_gene_network(data, list)

Arguments

data

list

Value

2-column matrix, each row a pair indicating a relationship or interaction

string array of genes

net matrix binary characterizing interactions

make_transparent

Examples

gene.list <- paste('gene', 1:100, sep='')
data <- matrix(0,nrow=100, ncol=2)
data[,1] <- sample(gene.list, 100)
data[,2] <- sample(gene.list, 100)
net <- make_gene_network(data, gene.list)

25

make_transparent

Make a color transparent (Taken from an answer on StackOverflow by
Nick Sabbe)

Description

Make a color transparent (Taken from an answer on StackOverflow by Nick Sabbe)

Usage

make_transparent(color, alpha = 100)

Arguments

color

alpha

Value

someColor rgb

color number, string or hexidecimal code

numeric transparency

neighbor_voting

Evaluating Gene Function Prediction

Description

The function performs gene function prediction based on ’guilt by association’ using cross valida-
tion ([1]). Performance and significance are evaluated by calculating the AUROC or AUPRC of
each functional group.

Usage

neighbor_voting(
genes.labels,
network,
nFold = 3,
output = "AUROC",
FLAG_DRAW = FALSE

)

26

Arguments

genes.labels

numeric array

network

nFold

output

numeric array symmetric, gene-by-gene matrix

numeric value, default is 3

string, default is AUROC

FLAG_DRAW

binary flag to draw roc plot

node_degree

Value

scores numeric matrix with a row for each gene label and columns auc: the average area under the
ROC or PR curve for the neighbor voting predictor across cross validation replicates avg_node_degree:
the average node degree degree_null_auc: the area the ROC or PR curve for the node degree pre-
dictor

Examples

genes.labels <- matrix( sample( c(0,1), 1000, replace=TRUE), nrow=100)
rownames(genes.labels) = paste('gene', 1:100, sep='')
colnames(genes.labels) = paste('function', 1:10, sep='')
net <- cor( matrix( rnorm(10000), ncol=100), method='spearman')
rownames(net) <- paste('gene', 1:100, sep='')
colnames(net) <- paste('gene', 1:100, sep='')

aurocs <- neighbor_voting(genes.labels, net, output = 'AUROC')

avgprcs <- neighbor_voting(genes.labels, net, output = 'PR')

node_degree

Calculate node degree

Description

The function calculates the node degree of a network

Usage

node_degree(net)

Arguments

net

Value

numeric matrix

node_degree numeric array

ortho

Examples

27

net <- cor( matrix(rnorm(1000), ncol=10))
n <- 10
net <- matrix(rank(net, na.last = 'keep', ties.method = 'average'), nrow = n, ncol = n)
net <- net/max(net, na.rm=TRUE)
nd <- node_degree(net)

ortho

Gene orthologs

Description

A list containing identifiers for the subsets of gene orthologs

Format

List orthologs for 5 species

dros List of Entrez identifiers, Drosophila

celeg List of Entrez identifiers, C. elegans

yeast List of Entrez identifiers, Yeast

mouse List of Entrez identifiers, Mouse

zf List of Entrez identifiers, Zebrafish

@source http://useast.ensembl.org/index.html/

pheno

Phenocarta

Description

A dataset of gene disease associations

Format

A data frame with 142272 rows and 4 variables:

entrezID chromosomal start position, in base pairs

name HUGO gene identifier

species species

disease disease

@source http://www.chibi.ubc.ca/Gemma/phenotypes.html

28

plot_densities

plot_densities

Plot densities

Description

The function plots multiple density curves and compares their modes

Usage

plot_densities(

hists,
id,
col = c("lightgrey"),
xlab = "",
ylab = "Density",
mode = "hist"

)

list of histogram objects or density objects

string

color for shading

string x-axis label

string y-axis label

flag indicating histogram or density

Arguments

hists

id

col

xlab

ylab

mode

Value

null

Examples

aurocsA <- density((runif(1000)+runif(1000)+runif(1000)+runif(1000))/4)
aurocsB <- density((runif(1000)+runif(1000)+runif(1000))/3)
aurocsC <- density(runif(1000))
hists <- list(aurocsA, aurocsB, aurocsC)
temp <- plot_densities(hists,'', mode='density')

plot_density_compare

29

plot_density_compare

Plot density comparisons

Description

The function plots two density curves and compares their modes

Usage

plot_density_compare(

aucA,
aucB,
col = "lightgrey",
xlab = "AUROC (neighbor voting)",
ylab = "Density",
mode = TRUE

)

Arguments

aucA

aucB

col

xlab

ylab

mode

Value

null

Examples

numeric array of aurocs

numeric array of aurocs

color of lines

string label

string label

boolean to plot mode or mean

aurocsA <- (runif(1000)+runif(1000)+runif(1000)+runif(1000))/4
aurocsB <- runif(1000)
plot_density_compare(aurocsA, aurocsB)

plot_distribution

Plot distribution histogram

Description

The function plots a the distribution of AUROCs

plot_network_heatmap

30

Usage

plot_distribution(

auc,
b = 20,
col = "lightgrey",
xlab = "",
ylab = "Density",
xlim = c(0.4, 1),
ylim = c(0, 5),
med = TRUE,
avg = TRUE,
density = TRUE,
bars = FALSE

)

Arguments

auc

b

col

xlab

ylab

xlim

ylim

med

avg

numeric aucs

array of breaks

color of line

string label

string label

range of values for xaxis

range of values for yaxis

boolean to plot median auc

boolean to plot average auc

density

bars

boolean

boolena for barplot

Value

auc list and quartiles

Examples

aurocs <- (runif(1000)+runif(1000)+runif(1000)+runif(1000))/4
d <- plot_distribution(aurocs)

plot_network_heatmap

Plot network heatmap

Description

The function draws a heatmap to visualize a network

Usage

plot_network_heatmap(net, colrs)

31

a numeric matrix of edge weights

a range of colors to plot the network

plot_prc

Arguments

net

colrs

Value

null

Examples

network <- cor(matrix( rnorm(10000), nrow=100))
plot_network_heatmap(network)

plot_prc

Plot precision recall curve

Description

The function calculates the precision and recall and plots the curve

Usage

plot_prc(scores, labels)

numeric array

binary array

Arguments

scores

labels

Value

prc numeric arrays

Examples

labels <- c(rep(0,10))
labels[c(1,3,5)] <- 1
scores <- 10:1
roc <- plot_prc(scores, labels)

32

plot_roc_overlay

plot_roc

Plot receiver operating characteristic curve

Description

The function calculates the FPR and TRPR for the receiver operating characteristic (ROC) and plots
the curve

Usage

plot_roc(scores, labels)

Arguments

scores

labels

Value

numeric array

binary array

FPR,TPR numeric arrays

Examples

labels <- c(rep(0,10))
labels[c(1,3,5)] <- 1
scores <- 10:1
roc <- plot_roc(scores, labels)

plot_roc_overlay

Plot ROC overlay

Description

The function plots a density overlay of ROCs given the scores and labels

Usage

plot_roc_overlay(scores.mat, labels.mat, nbins = 100)

Arguments

scores.mat

labels.mat

nbins

Value

numeric array

numeric array

numeric value

list of Z(matrix) and roc_sum (average ROC curve)

plot_value_compare

Examples

33

genes.labels <- matrix( c(rep(1, 1000), rep(0,9000)), nrow=1000, byrow=TRUE)
rownames(genes.labels) = paste('gene', 1:1000, sep='')
colnames(genes.labels) = paste('function', 1:10, sep='')

scores <- matrix( rnorm(10000), nrow=1000)
scores <- apply(scores, 2, rank)
rownames(scores) = paste('gene', 1:1000, sep='')
colnames(scores) = paste('function', 1:10, sep='')

z <- plot_roc_overlay(scores, genes.labels)

plot_value_compare

Plot value comparisons

Description

The function plots a scatter

Usage

plot_value_compare(

aucA,
aucB,
xlab = "AUROC",
ylab = "AUROC",
xlim = c(0, 1),
ylim = c(0, 1)

)

Arguments

aucA

aucB

xlab

ylab

xlim

ylim

Value

null

numeric array of aucs

numeric array of aucs

string label

string label

range of values for xaxis

range of values for yaxis

34

repmat

predictions

Performing Gene Function Prediction

Description

The function performs gene function prediction on the whole data set using the ’guilt by association’-
principle ([1]).

Usage

predictions(genes.labels, network)

Arguments

genes.labels

numeric array

network

numeric array symmetric, gene-by-gene matrix

Value

scores numeric matrix

Examples

genes.labels <- matrix( sample( c(0,1), 1000, replace=TRUE), nrow=100)
rownames(genes.labels) = paste('gene', 1:100, sep='')
colnames(genes.labels) = paste('function', 1:10, sep='')
net <- cor( matrix( rnorm(10000), ncol=100), method='spearman')
rownames(net) <- paste('gene', 1:100, sep='')
colnames(net) <- paste('gene', 1:100, sep='')

preds <- predictions(genes.labels, net)

repmat

Rep function for matrices

Description

The function generates a matrix by binding the columns and rows

Usage

repmat(X, m, n)

Arguments

X

m

n

numeric matrix

numeric value, repeat rows m times

numeric value, repeat columns n times

run_GBA

Value

list of genes and the expression matrix

Examples

genes.labels <- matrix( sample( c(0,1), 1000, replace=TRUE), nrow=100)
expand <- repmat( genes.labels, 1,2)

35

run_GBA

Performing ’Guilt by Association’ Analysis

Description

The function runs and evaluates gene function prediction based on the ’guilt by association’-principle
using neighbor voting (neighbor_voting) [1]. As a measure of performance and significance of
results, AUCs of all evaluated functional groups are calculated.

Usage

run_GBA(network, labels, min = 20, max = 1000, nfold = 3)

Arguments

network

labels

min

max

nfold

Value

numeric array symmetric, gene-by-gene matrix

numeric array

numeric value to limit gene function size

numeric value to limit gene function size

numeric value, default is 3

list roc.sub, genes, auroc

Examples

genes.labels <- matrix( sample( c(0,1), 1000, replace=TRUE), nrow=100)
rownames(genes.labels) = paste('gene', 1:100, sep='')
colnames(genes.labels) = paste('function', 1:10, sep='')
net <- cor( matrix( rnorm(10000), ncol=100), method='spearman')
rownames(net) <- paste('gene', 1:100, sep='')
colnames(net) <- paste('gene', 1:100, sep='')

gba <- run_GBA(net, genes.labels, min=10)

Index

∗ AUC

auc_multifunc, 5

∗ AUROC

plot_distribution, 29

∗ ExpressionSet

build_coexp_expressionSet, 7
build_coexp_network, 9

∗ FPR

get_roc, 21
plot_roc, 32

∗ GEMMA

get_expression_data_gemma, 19

∗ GEO

build_coexp_GEOID, 8
get_expression_data_gemma, 19
get_expression_matrix_from_GEO, 20

∗ GSE

build_coexp_GEOID, 8
get_expression_data_gemma, 19
get_expression_matrix_from_GEO, 20

∗ PRC

plot_prc, 31

∗ ROC

auroc_analytic, 6
get_roc, 21
plot_distribution, 29
plot_roc, 32
plot_roc_overlay, 32

∗ TPR

get_roc, 21
plot_roc, 32

∗ analytic

auroc_analytic, 6

∗ annotations

filter_orthologs, 16
make_annotations, 23

∗ area

auprc, 5
auroc_analytic, 6
get_auc, 17

∗ association

neighbor_voting, 25
predictions, 34

run_GBA, 35

∗ assortativity

assortativity, 3

∗ a

get_auc, 17

∗ biogrid

get_biogrid, 18

∗ by

neighbor_voting, 25
predictions, 34
run_GBA, 35
∗ characteristic

auroc_analytic, 6
get_roc, 21
plot_roc, 32

∗ coexpression

build_coexp_expressionSet, 7
build_coexp_GEOID, 8
build_coexp_network, 9

∗ cross

neighbor_voting, 25
run_GBA, 35

∗ curve

get_auc, 17

∗ degree

node_degree, 26

∗ dense

build_coexp_expressionSet, 7
build_coexp_GEOID, 8
build_coexp_network, 9

∗ density

plot_densities, 28

∗ distribution

plot_distribution, 29

∗ download

get_biogrid, 18
get_phenocarta, 20

∗ evaluation

calculate_multifunc, 11
neighbor_voting, 25
run_GBA, 35

∗ evalutation

auc_multifunc, 5

36

INDEX

∗ experiment

get_expression_data_gemma, 19
get_expression_matrix_from_GEO, 20

∗ expressionSet

build_coexp_expressionSet, 7
build_coexp_network, 9

∗ expression

get_expression_data_gemma, 19
get_expression_matrix_from_GEO, 20

∗ extended

extend_network, 13

∗ extract

make_genelist, 24

∗ filter

filter_network, 14
filter_network_cols, 14
filter_network_rows, 15
filter_orthologs, 16

∗ fmeasure

fmeasure, 16

∗ function

calculate_multifunc, 11
make_annotations, 23
neighbor_voting, 25
predictions, 34
run_GBA, 35

∗ gene-by-gene

build_binary_network, 7
build_weighted_network, 10
make_gene_network, 24

∗ gene

calculate_multifunc, 11
make_annotations, 23
make_genelist, 24
neighbor_voting, 25
predictions, 34
run_GBA, 35

∗ guilt

neighbor_voting, 25
predictions, 34
run_GBA, 35

∗ heatmap

plot_network_heatmap, 30

∗ histogram

get_counts, 18
get_density, 19

∗ igraph

extend_network, 13

∗ image

plot_network_heatmap, 30

∗ interaction

build_binary_network, 7

37

build_weighted_network, 10
make_gene_network, 24

∗ jaccard

build_semantic_similarity_network,

9

∗ labels

make_annotations, 23

∗ length

extend_network, 13

∗ list

make_genelist, 24

∗ matrix

repmat, 34

∗ mean

get_auc, 17

∗ metric

auprc, 5
auroc_analytic, 6
get_roc, 21
node_degree, 26
plot_prc, 31
plot_roc, 32
∗ multifunctionality

auc_multifunc, 5

∗ neighbor

neighbor_voting, 25
predictions, 34
run_GBA, 35

∗ network

assortativity, 3
build_binary_network, 7
build_coexp_expressionSet, 7
build_coexp_GEOID, 8
build_coexp_network, 9
build_semantic_similarity_network,

9

build_weighted_network, 10
extend_network, 13
filter_network, 14
filter_network_cols, 14
filter_network_rows, 15
make_gene_network, 24
node_degree, 26
plot_network_heatmap, 30

∗ node

node_degree, 26

∗ ontology

calculate_multifunc, 11
make_annotations, 23

∗ operating

auroc_analytic, 6
get_roc, 21

38

plot_roc, 32

∗ orthologs

filter_orthologs, 16

∗ overlay

plot_roc_overlay, 32

∗ path

extend_network, 13

∗ phenocarta

get_phenocarta, 20

∗ plot

conv_smoother, 11
get_density, 19
plot_densities, 28
plot_density_compare, 29
plot_distribution, 29
plot_network_heatmap, 30
plot_prc, 31
plot_roc_overlay, 32
plot_value_compare, 33

∗ precision-recall
auprc, 5
fmeasure, 16

∗ precision

get_prc, 21
plot_prc, 31
∗ precsion-recall
get_prc, 21

∗ prediction

calculate_multifunc, 11
neighbor_voting, 25
predictions, 34
run_GBA, 35

∗ properties

assortativity, 3

∗ recall

get_prc, 21
plot_prc, 31

∗ receiver

auroc_analytic, 6
get_roc, 21
plot_roc, 32

∗ repeat

repmat, 34

∗ repmat

repmat, 34

∗ rolling

get_auc, 17

∗ rows

filter_network, 14
filter_network_cols, 14
filter_network_rows, 15

∗ semantic

INDEX

build_semantic_similarity_network,

9
∗ shortest

extend_network, 13

∗ similarity

build_semantic_similarity_network,

9

∗ smooth

conv_smoother, 11

∗ topology

assortativity, 3
node_degree, 26

∗ to

make_annotations, 23

∗ under

get_auc, 17

∗ validation

neighbor_voting, 25
run_GBA, 35

∗ voting

neighbor_voting, 25
predictions, 34
run_GBA, 35

assortativity, 3
attr.human, 3
attr.mouse, 4
auc_multifunc, 5
auprc, 5
auroc_analytic, 6

biogrid, 6
build_binary_network, 7
build_coexp_expressionSet, 7
build_coexp_GEOID, 8
build_coexp_network, 7, 8, 9
build_semantic_similarity_network, 9
build_weighted_network, 10

calculate_multifunc, 5, 11
conv_smoother, 11
convolve, 11
cor, 9

example_annotations, 12
example_binary_network, 12
example_coexpression, 12
example_neighbor_voting, 13
extend_network, 13

filter_network, 14
filter_network_cols, 14
filter_network_rows, 15

39

INDEX

filter_orthologs, 16
fmeasure, 16

genes, 17
get_auc, 17
get_biogrid, 18
get_counts, 18
get_density, 19
get_expression_data_gemma, 19
get_expression_matrix_from_GEO, 8, 20
get_phenocarta, 20
get_prc, 21
get_roc, 21
GO.human, 22
GO.mouse, 22
GO.voc, 23

make_annotations, 23
make_gene_network, 24
make_genelist, 24
make_transparent, 25

neighbor_voting, 25, 35
node_degree, 26

ortho, 27

pheno, 27
plot_densities, 28
plot_density_compare, 29
plot_distribution, 29
plot_network_heatmap, 30
plot_prc, 31
plot_roc, 32
plot_roc_overlay, 32
plot_value_compare, 33
predictions, 34

repmat, 34
run_GBA, 35


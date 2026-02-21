Package ‘ABAEnrichment’

Type Package

Title Gene expression enrichment in human brain regions

April 11, 2018

Version 1.8.0

Date 2017-10-19

Author Stefﬁ Grote
Maintainer Stefﬁ Grote <steffi_grote@eva.mpg.de>
Description The package ABAEnrichment is designed to test for
enrichment of user deﬁned candidate genes in the set of
expressed genes in different human brain regions. The core
function 'aba_enrich' integrates the expression of the
candidate gene set (averaged across donors) and the structural
information of the brain using an ontology, both provided by
the Allen Brain Atlas project. 'aba_enrich' interfaces the
ontology enrichment software FUNC to perform the statistical
analyses. Additional functions provided in this package like
'get_expression' and 'plot_expression' facilitate exploring the
expression data. From version 1.3.5 onwards genomic regions
can be provided as input, too; and from version 1.5.9 onwards
the function 'get_annotated_genes' offers an easy way to obtain
annotations of genes to enriched or user-deﬁned brain regions.

License GPL (>= 2)

Imports Rcpp (>= 0.11.5), gplots (>= 2.14.2), gtools (>= 3.5.0),

ABAData (>= 0.99.2), data.table (>= 1.10.4), grDevices, stats,
utils

Depends R (>= 3.4)

LinkingTo Rcpp

Suggests BiocStyle, knitr, testthat

VignetteBuilder knitr

biocViews GeneSetEnrichment, GeneExpression

NeedsCompilation yes

R topics documented:

aba_enrich .
.
get_annotated_genes

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
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
4

1

2

Index

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
get_expression .
.
.
.
.
get_id .
.
.
.
.
.
.
get_name .
get_sampled_substructures .
.
get_superstructures .
.
.
plot_expression .

.
.

.
.

.
.

.

aba_enrich

7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12

15

aba_enrich

Test genes for expression enrichment in human brain regions

Description

Tests for enrichment of user deﬁned candidate genes in the set of expressed protein-coding genes
in different human brain regions. It integrates the expression of the candidate gene set (averaged
across donors) and the structural information of the brain using an ontology, both provided by the
Allen Brain Atlas project [1-4]. The statistical analysis is performed using the ontology enrichment
software FUNC [5].

Usage

aba_enrich(genes, dataset = 'adult', test = 'hyper',

cutoff_quantiles = seq(0.1, 0.9, 0.1), n_randsets = 1000,
gene_len = FALSE, circ_chrom = FALSE, ref_genome = 'grch37', silent = FALSE)

Arguments

genes

dataset

test

A dataframe with gene-identiﬁers (Entrez-ID, Ensembl-ID or gene-symbol) in
the ﬁrst column and test-dependent additional columns:
If test='hyper' (default) a second column with 1 for candidate genes and 0
for background genes. If no background genes are deﬁned, all remaining pro-
tein coding genes are used as background.
If test='wilcoxon' a second column with the score that is associated with each
gene.
If test='binomial' two additional columns with two gene-associated integers.
If test='contingency' four additional columns with four gene-associated in-
tegers.
For test='hyper' the ﬁrst column can also describe chromosomal regions
(’chr:start-stop’, e.g. ’9:0-39200000’).

’adult’ for the microarray dataset of adult human brains; ’5_stages’ for RNA-
seq expression data for different stages of the developing human brain, grouped
into 5 developmental stages; ’dev_effect’ for a developmental effect score. For
details see browseVignettes("ABAData").
’hyper’ (default) for the hypergeometric test, ’wilcoxon’ for the Wilcoxon rank
test, ’binomial’ for the binomial test and ’contingency’ for the 2x2-contingency
table test (ﬁsher’s exact test or chi-square).

cutoff_quantiles

the FUNC enrichment analyses will be performed for the sets of expressed genes
at given expression quantiles deﬁned in this vector [0,1].

n_randsets

integer deﬁning the number of random sets created to compute the FWER.

aba_enrich

gene_len

circ_chrom

ref_genome

silent

Details

3

logical. If test='hyper' the probability of a background gene to be chosen as
a candidate gene in a random set is dependent on the gene length.
logical. When genes deﬁnes chromosomal regions, circ_chrom=TRUE uses
background regions from the same chromosome and allows randomly chosen
blocks to overlap multiple background regions. Only if test='hyper'.

’grch37’ (default) or ’grch38’. Deﬁnes the reference genome used when ge-
nomic regions are provided as input or when gene_len=TRUE.

logical. If TRUE all output to the screen except for warnings and errors is sup-
pressed.

For details please refer to browseVignettes("ABAEnrichment").

Value

A list with components

a dataframe with the FWERs from the enrichment analyses per brain region
and age category, ordered by ’age_category’, ’n_signiﬁcant’,’min_FWER’ and
’mean_FWER’. ’min_FWER’ for example denotes the minimum FWER for ex-
pression enrichment of the candidate genes in this brain region across all expres-
sion cutoffs. ’n_signiﬁcant’ reports the number of cutoffs at which the FWER
was below 0.05. ’FWERs’ is a semicolon separated string with the single FW-
ERs for all cutoffs. ’equivalent_structures’ is a semicolon separated string that
lists structures with identical expression data due to lack of independent expres-
sion measurements in all regions.

a dataframe of the input genes, excluding those genes for which no expression
data is available and which therefore were not included in the enrichment anal-
ysis.

a dataframe with the expression values that correspond to the requested cutoff
quantiles.

results

genes

cutoffs

Author(s)

Stefﬁ Grote

References

[1] Hawrylycz, M.J. et al. (2012) An anatomically comprehensive atlas of the adult human brain
transcriptome, Nature 489: 391-399. doi: 10.1038/nature11405
[2] Miller, J.A. et al. (2014) Transcriptional landscape of the prenatal human brain, Nature 508:
199-206. doi: 10.1038/nature13185
[3] Allen Institute for Brain Science. Allen Human Brain Atlas [Internet]. Available from: http:
//human.brain-map.org/
[4] Allen Institute for Brain Science. BrainSpan Atlas of the Developing Human Brain [Internet].
Available from: http://brainspan.org/
[5] Pruefer, K. et al. (2007) FUNC: A package for detecting signiﬁcant associations between gene
sets and ontological, BMC Bioinformatics 8: 41. doi: 10.1186/14712105841

get_annotated_genes

4

See Also

browseVignettes("ABAEnrichment")
browseVignettes("ABAData")
get_expression
plot_expression
get_name
get_id
get_sampled_substructures
get_superstructures
get_annotated_genes

Examples

#### Note that arguments 'cutoff_quantiles' and 'n_randsets' are reduced
#### to lower computational time in the examples.
#### Using the default values is recommended.

#### Perform an enrichment analysis for the developing brain
#### with defined background genes
#### and with random sets dependent on gene length
gene_ids = c('PENK', 'COCH', 'PDYN', 'CA12', 'SYNDIG1L', 'MME',

'ANO3', 'KCNJ6', 'ELAVL4', 'BEAN1', 'PVALB', 'EPN3', 'PAX2', 'FAB12')

is_candidate = rep(c(1,0),each=7)
genes = data.frame(gene_ids, is_candidate)
res = aba_enrich(genes, dataset='5_stages', cutoff_quantiles=c(0.5,0.9),

n_randsets=100, gene_len=TRUE)

## see results for the brain regions with highest enrichment
## for children (age_category 3)
fwers = res[[1]]
head(fwers[fwers$age_category==3,])
## see the input genes dataframe (only genes with expression data available)
res[2]
## see the expression values that correspond to the requested cutoff quantiles
res[3]

# For more examples please refer to the package vignette.

get_annotated_genes

Get genes that are expressed in enriched or user-deﬁned brain regions

Description

Uses an object returned from aba_enrich as input and returns the brain regions that are signiﬁcantly
(given a FWER-threshold) enriched in expressed candidate genes (or genes with high scores if
test='wilcoxon' in aba_enrich) together with the genes that are expressed in those brain regions
(i.e. are ’annotated’ to the brain regions). Alternatively, also user-deﬁned brain regions, dataset and
expression cutoffs can be used as input.

get_annotated_genes

Usage

5

get_annotated_genes(res, fwer_threshold = 0.05, background = FALSE,

structure_ids = NULL, dataset = NULL, cutoff_quantiles = NULL, genes = NULL)

Arguments

res

an object returned from aba_enrich (list of 3 elements). If not deﬁned, structure_ids,
dataset and cutoff_quantiles have to be speciﬁed.

fwer_threshold numeric deﬁning the FWER-threshold. Given res as input, get_annotated_genes

extracts all brain-region/expression-cutoff combinations from res that have a
FWER < fwer_threshold and adds the (candidate) genes that are annotated to
those brain regions at the given expression cutoffs.

background

structure_ids

dataset

cutoff_quantiles

logical indicating whether background genes should be included. Only used
when res is deﬁned and contains the results from a hypergeometric test (which
is the default in aba_enrich).
vector of brain structure IDs, e.g. ’Allen:10208’. If res is not deﬁned, structure_ids
speciﬁes the brain regions for which annotated genes at the given cutoff_quantiles
will be returned.

’adult’ for the microarray dataset of adult human brains; ’5_stages’ for RNA-seq
expression data of the developing human brain, grouped into 5 developmental
stages; ’dev_effect’ for a developmental effect score. Only used when res is not
deﬁned.

vector of numeric values between 0 and 1. They deﬁne the expression quantiles
(across all genes) which are used as cutoffs to decide whether a gene counts as
expressed (and gets annotated to a brain region) or not. Only used when res is
not deﬁned.

optional vector of gene identiﬁers, either Entrez-ID, Ensembl-ID or gene-symbol.
If deﬁned, only annotations of those genes are returned. If not deﬁned, all ex-
pressed genes from Allen Brain Atlas are returned. Only used when res is not
deﬁned.

genes

Details

Genes get annotated to a brain region when their expression value in that brain region, which is
provided by the Allen Brain Atlas, exceeds a certain cutoff. Multiple cutoffs can be used. They are
deﬁned as quantiles of gene expression across all genes and brain regions. An expression cutoff of
e.g. 0.8 means that only genes with expression levels higher than 80% of all measured values count
as ’expressed’ and get annotated to the corresponding brain region. Note that those annotations are
inherited by all superstructures (parent nodes).
When the ’dev_effect’ dataset is used as dataset-argument, the expression value is replaced by
a measure of how much a gene’s expression changes during the development (prenatal to adult).
Genes with a developmental score higher than the cutoff then get annotated to the brain regions.

Value

A data frame with the age category, the brain region ID, the expression cutoff quantile and the anno-
tated genes for signiﬁcantly enriched or user-deﬁned brain-region/expression-cutoff combinations.
If res was given as input, two additional columns are added: the FWER and the score which was
used for the genes in the aba_enrich input (1/0 for candidate and background genes for the hyper-
geometric test or scores for the wilcoxon rank sum test). Given res as input, the output is ordered

6

get_annotated_genes

by the FWER, else it is ordered by the expression cutoff.

Author(s)

Stefﬁ Grote

References

[1] Hawrylycz, M.J. et al. (2012) An anatomically comprehensive atlas of the adult human brain
transcriptome, Nature 489: 391-399. doi: 10.1038/nature11405
[2] Miller, J.A. et al. (2014) Transcriptional landscape of the prenatal human brain, Nature 508:
199-206. doi: 10.1038/nature13185
[3] Allen Institute for Brain Science. Allen Human Brain Atlas [Internet]. Available from: http:
//human.brain-map.org/
[4] Allen Institute for Brain Science. BrainSpan Atlas of the Developing Human Brain [Internet].
Available from: http://brainspan.org/

See Also

browseVignettes("ABAEnrichment")
browseVignettes("ABAData")
aba_enrich
get_name
get_id

Examples

#### Note that arguments 'cutoff_quantiles' and 'n_randsets' are reduced
#### to lower computational time in the examples.

## perform an enrichment analysis
## for expression of 7 candidate and 7 background genes
## and get candidate genes annotated to brain regions that have a FWER < 0.05
set.seed(123)
gene_ids = c('PENK', 'COCH', 'PDYN', 'CA12', 'SYNDIG1L', 'MME',

'ANO3', 'KCNJ6', 'ELAVL4', 'BEAN1', 'PVALB', 'EPN3', 'PAX2', 'FAB12')

is_candidate = rep(c(1,0), each=7)
genes = data.frame(gene_ids, is_candidate)
res = aba_enrich(genes, dataset='5_stages', cutoff_quantiles=c(0.3,0.5,0.7,0.9),

n_randset=100)

anno = get_annotated_genes(res, fwer_threshold=0.05)
head(anno)

## find out which of the above genes have expression above
## the 50% and 70% expression-cutoff, respectively,
## in the Cerebellar Cortex of the developing human brain (Allen:10657)
get_annotated_genes(structure_ids="Allen:10657", dataset="5_stages",

cutoff_quantiles=c(0.5,0.7), genes=gene_ids)

get_expression

7

get_expression

Get expression data for given genes and brain structure IDs

Description

Expression data obtained from the Allen Brain Atlas project [1-4].

Usage

get_expression(structure_ids, gene_ids = NA, dataset = NA, background = FALSE)

Arguments

structure_ids

vector of brain structure IDs, e.g. ’Allen:10208’.

gene_ids

dataset

background

Details

vector of gene identiﬁers, either Entrez-ID, Ensembl-ID or gene-symbol. If not
deﬁned, genes from previous enrichment analysis with aba_enrich are used.

’adult’ for the microarray dataset of adult human brains; ’5_stages’ for RNA-seq
expression data of the developing human brain, grouped into 5 developmental
stages; ’dev_effect’ for a developmental effect score. If not deﬁned, dataset from
last enrichment analysis with aba_enrich are used.

logical indicating whether expression from background genes should be in-
cluded. Only used when gene_ids and dataset are NA and test from pre-
ceding aba_enrich call is ’hyper’.

Get gene expression in deﬁned brain regions from adult or developing humans, or a developmental
effect score for the developing human brain. Expression data is obtained from the Allen Brain Atlas
project [1-4], averaged across donors, and for the developing human brain divided into ﬁve major
age categories. The developmental effect score is based on expression data of the developing human
brain. If gene_ids and dataset are not speciﬁed, the genes and dataset from the last enrichment
analysis with aba_enrich are used, since it may be a common case to ﬁrst run the enrichment
analysis and then look at the expression data. If a requested brain region has no expression data
annotated, data from sampled substructures of this region is returned.
Please refer to the ABAData package vignette for details on the datasets.

Value

A matrix with expression values or developmental effect scores per brain region (rows) and gene
(columns).
For expression data from the developing human brain (’5_stages’) it is a list with an expression
matrix for each of the 5 developmental stages.

Author(s)

Stefﬁ Grote

8

References

get_id

[1] Hawrylycz, M.J. et al. (2012) An anatomically comprehensive atlas of the adult human brain
transcriptome, Nature 489: 391-399. doi: 10.1038/nature11405
[2] Miller, J.A. et al. (2014) Transcriptional landscape of the prenatal human brain, Nature 508:
199-206. doi: 10.1038/nature13185
[3] Allen Institute for Brain Science. Allen Human Brain Atlas [Internet]. Available from: http:
//human.brain-map.org/
[4] Allen Institute for Brain Science. BrainSpan Atlas of the Developing Human Brain [Internet].
Available from: http://brainspan.org/

See Also

browseVignettes("ABAEnrichment")
browseVignettes("ABAData")
plot_expression
aba_enrich
get_name
get_id
get_sampled_substructures
get_annotated_genes

Examples

## get expression data of six genes in two brain regions
## from the developing human brain,
## each of the five list elements corresponds to an age category
get_expression(structure_ids=c('Allen:10657','Allen:10208'),

gene_ids=c('ENSG00000168036','ENSG00000157764','ENSG00000182158',
'ENSG00000147889'), dataset='5_stages')

## see the package vignette for more examples

get_id

Get the structure ID of a brain region given its name

Description

Returns brain regions given (part of) their name, together with their structure IDs from the on-
tologies for the adult and for the developing brain (e.g.
’Allen:10657’ as used throughout the
ABAEnrichment package).

Usage

get_id(structure_name)

Arguments

structure_name (partial) name of a brain structure, e.g. ’telencephalon’

get_name

Value

9

a data frame with the full names of the brain structures that contain structure_name; together with
the ontology (’developmental’ or ’adult’) and the structure IDs.

Author(s)

Stefﬁ Grote

References

[1] Allen Institute for Brain Science. Allen Human Brain Atlas [Internet]. Available from: http:
//human.brain-map.org/
[2] Allen Institute for Brain Science. BrainSpan Atlas of the Developing Human Brain [Internet].
Available from: http://brainspan.org/

See Also

get_name
get_sampled_substructures
get_superstructures
browseVignettes("ABAData")

Examples

## get structure IDs of brain regions that contain 'accumbens' in their names
get_id('accumbens')
## get structure IDs of brain regions that contain 'telencephalon' in their name
get_id('telencephalon')
## get all brain regions that have direct or indirect expression data
all_regions = get_id('')
head(all_regions)

get_name

Get the full name of a brain region given structure IDs

Description

Returns the full name of brain regions given the structure IDs, e.g. ’Allen:10657’ as used throughout
the ABAEnrichment package. The full name is composed of an acronym and the name as used by
the Allen Brain Atlas project [1-2].

Usage

get_name(structure_ids)

Arguments

structure_ids

a vector of brain structure IDs, e.g. c(’Allen:10657’,’Allen:10173’) or c(10657,10173)

Value

vector of the full names of the brain structures; composed of acronym, underscore and name.

10

Note

The acronym is added because the names alone are not unique.

get_sampled_substructures

Author(s)

Stefﬁ Grote

References

[1] Allen Institute for Brain Science. Allen Human Brain Atlas [Internet]. Available from: http:
//human.brain-map.org/
[2] Allen Institute for Brain Science. BrainSpan Atlas of the Developing Human Brain [Internet].
Available from: http://brainspan.org/

See Also

get_id
get_sampled_substructures
get_superstructures

Examples

## get the full names of the brain structures 'Allen:10657' and 'Allen:10225'
get_name(c('Allen:10657','Allen:10225'))

get_sampled_substructures

Return sampled substructures of a given brain region

Description

The function returns for a given brain structure ID all its substructures with available expression
data, potentially including the structure itself.

Usage

get_sampled_substructures(structure_id)

Arguments

structure_id

a brain structure ID, e.g. ’Allen:10657’ or ’10657’

Details

The ontology enrichment analysis in aba_enrich tests all brain regions for which data is available,
although the region might not have been sampled directly. In this case the region inherits the expres-
sion data from its substructures with available expression data. The function get_sampled_substructures
helps to explore where the expression data for a brain region came from.

get_superstructures

Value

11

vector of brain structure IDs that contains all substructures of the requested brain region that were
sampled.

Author(s)

Stefﬁ Grote

References

[1] Allen Institute for Brain Science. Allen Human Brain Atlas [Internet]. Available from: http:
//human.brain-map.org/
[2] Allen Institute for Brain Science. BrainSpan Atlas of the Developing Human Brain [Internet].
Available from: http://brainspan.org/

See Also

browseVignettes("ABAEnrichment")
browseVignettes("ABAData")
aba_enrich
get_name
get_superstructures

Examples

## get the brain structures from which the brain structures
## 'Allen:4010' and 'Allen:10208' inherit their expression data
get_sampled_substructures('Allen:4010')
get_sampled_substructures('Allen:10208')

get_superstructures

Returns all superstructures of a brain region using the Allen Brain
Atlas ontology

Description

Returns all superstructures of a brain region and the brain region itself given a structure ID, e.g.
’Allen:10657’ as used throughout the ABAEnrichment package. The output vector contains the su-
perstructures according to the hierarchy provided by the Allen Brain Atlas ontology [1,2] beginning
with the root (’brain’ or ’neural plate’) and ending with the requested brain region.

Usage

get_superstructures(structure_id)

Arguments

structure_id

a brain structure ID, e.g. ’Allen:10657’ or ’10657’

12

Value

plot_expression

vector of brain structure IDs that contains all superstructures of the requested brain region and the
brain region itself. The order of the brain regions follows the hierarchical organization of the brain.

Note

The ontologies for the adult and the developing human brain are different.

Author(s)

Stefﬁ Grote

References

[1] Allen Institute for Brain Science. Allen Human Brain Atlas [Internet]. Available from: http:
//human.brain-map.org/
[2] Allen Institute for Brain Science. BrainSpan Atlas of the Developing Human Brain [Internet].
Available from: http://brainspan.org/

See Also

get_name
get_id
get_sampled_substructures

Examples

## Get the IDs of the superstructures of the precentral gyrus
## (adult brain ontology)
get_superstructures('Allen:4010')

## Get the IDs and the names of the superstructures
## of the dorsolateral prefrontal cortex
## (developing brain ontology)
data.frame(superstructure=get_name(get_superstructures("Allen:10173")))

plot_expression

Plot expression data for given genes and brain structure IDs

Description

The function produces a heatmap (heatmap.2 from package gplots) of gene expression in deﬁned
brain regions from adult or developing humans, or a developmental effect score for the developing
human brain. Expression data is obtained from the Allen Brain Atlas project [1-4], averaged across
donors, and for the developing human brain divided into ﬁve major age categories. If gene_ids and
dataset are not speciﬁed, the genes and dataset from the last enrichment analysis with aba_enrich
are used, since it may be a common case to ﬁrst run the enrichment analysis and then look at the
expression data. If a requested brain region has no expression data annotated, data from sampled
substructures of this region is returned.

plot_expression

Usage

13

plot_expression(structure_ids, gene_ids = NA, dataset = NA, background = FALSE,

dendro = TRUE, age_category = 1)

Arguments

structure_ids

gene_ids

dataset

background

dendro

age_category

Value

vector of brain structure ids, e.g. "Allen:10208".

vector of gene identiﬁers, either Entrez-ID, Ensembl-ID or gene-symbol. If not
deﬁned, genes from previous enrichment analysis with aba_enrich are used.

’adult’ for the microarray dataset of adult human brains; ’5_stages’ for RNA-seq
expression data of the developing human brain, grouped into 5 developmental
stages; ’dev_effect’ for a developmental effect score. If not deﬁned, dataset from
last enrichment analysis with aba_enrich are used.

logical indicating whether expression from background genes should be in-
cluded. Only used when gene_ids and dataset are NA so that genes from the
last enrichment analysis with aba_enrich are used and when this analysis was
performed using the hypergeometric test.

logical indicating whether rows and columns should be rearranged with a den-
drodram based on row/column means (using hclust). If FALSE and if gene_ids
and dataset are NA so that genes from the last enrichment analysis with aba_enrich
are used, a side bar indicates the gene-associated variables from the enrichment
analysis: for a hypergeometric test the genes are grouped into candidate (red)
and background genes (black); for the Wilcoxon rank-sum test, the side bar indi-
cates the user-deﬁned scores; for the binomial test the side bar shows *A/(A+B)*
and for the 2x2 contingency table test *((A+1)/(B+1)) / ((C+1)/(D+1))* (+1
added to prevent division by 0, this is just a visual indication of the proportion
of the ratios and not the real odds ratio from the 2x2 contingency table test)
an integer between 1 and 5 indicating the age category if dataset='5_stages'.

Invisibly, a list with components

rowInd

colInd

call

carpet

row index permutation vector as returned by order.dendrogram

column index permutation vector.

the matched call

reordered ’x’ values used to generate the main ’carpet’

rowDendrogram

colDendrogram

row dendrogram, if present

column dendrogram, if present

values used for color break points

colors used

A three-column data frame providing the lower and upper bound and color for
each bin

breaks

col

colorTable

Author(s)

Stefﬁ Grote

14

References

plot_expression

[1] Hawrylycz, M.J. et al. (2012) An anatomically comprehensive atlas of the adult human brain
transcriptome, Nature 489: 391-399. doi: 10.1038/nature11405
[2] Miller, J.A. et al. (2014) Transcriptional landscape of the prenatal human brain, Nature 508:
199-206. doi: 10.1038/nature13185
[3] Allen Institute for Brain Science. Allen Human Brain Atlas [Internet]. Available from: http:
//human.brain-map.org/
[4] Allen Institute for Brain Science. BrainSpan Atlas of the Developing Human Brain [Internet].
Available from: http://brainspan.org/

See Also

browseVignettes("ABAEnrichment")
browseVignettes("ABAData")
get_expression
aba_enrich
get_name
get_id
get_sampled_substructures
get_annotated_genes
heatmap.2
hclust

Examples

## plot expression data of six genes in two brain regions
## from children (age_category 3) without dendrogram
plot_expression(structure_ids=c("Allen:10657","Allen:10208"),

gene_ids=c("ENSG00000168036","ENSG00000157764","ENSG00000182158",
"ENSG00000147889"), dataset="5_stages", dendro=FALSE, age_category=3)

## see the package vignette for more examples

Index

∗Topic htest

aba_enrich, 2

aba_enrich, 2, 4–8, 10–14
ABAData, 7

get_annotated_genes, 4, 4, 8, 14
get_expression, 4, 7, 14
get_id, 4, 6, 8, 8, 10, 12, 14
get_name, 4, 6, 8, 9, 9, 11, 12, 14
get_sampled_substructures, 4, 8–10, 10,

12, 14

get_superstructures, 4, 9–11, 11

hclust, 13, 14
heatmap.2, 12, 14

order.dendrogram, 13

plot_expression, 4, 8, 12

15


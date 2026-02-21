Package ‘stjudem’
April 9, 2019
Title Microarray Data from Yeoh et al. in MACAT format

Version 1.22.0

Date 2006-9-15

Depends R (>= 2.10), utils

Author Benjamin Georgi, Matthias Heinig, Sebastian Schmeier, Joern Toedling

Description This is a microarray data set on acute lymphoblastic leukemia, pub-

lished in 2002 (Yeoh et al.Cancer Cell 2002). The experiments were conducted in the St.Jude Chil-
dren's Research Hospital, Memphis, Tenessee, USA. The raw data was preprocessed by vari-
ance stabilizing normalization (Huber et al.) on probe and subsequent summariza-
tion of probe expression values into probe set expression values using median polish.

Maintainer Joern Toedling <toedling@ebi.ac.uk>

License LGPL (>= 2)

biocViews ExperimentData, CancerData, LeukemiaCancerData,

MicroarrayData, ChipOnChipData

git_url https://git.bioconductor.org/packages/stjudem

git_branch RELEASE_3_8

git_last_commit d7f70a5

git_last_commit_date 2018-10-30

Date/Publication 2019-04-09

R topics documented:

stjude .

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

1

3

Index

stjude

Microarry Data from St.Jude Children Research Hospital (USA)

Description

Example for list-structure used by many functions in MACAT. It’s based on the gene expression
data published by Yeoh et al. in 2002.[Yeoh et al. Classiﬁcation, subtype discovery, and prediction
of outcome in pediatric acute lymphoblastic leukemia by gene expression proﬁling. Cancer Cell.
March 2002. 1: 133-143. The data has been preprocessed using ’vsn’ on probe level and the probes
have been summed up using ’median polish’.

1

2

Usage

data(stjude)

Format

stjude

List of class ’MACATData’ with 6 components:

geneName: Identiﬁers of genes/probe sets in expression data

geneLocation: Location of genes on their chromosome as distance from 5’end in base pairs Neg-

ative numbers denote genes on the antisense strand.

chromosome: Chromosome of the respective gene. Components ’geneName’, ’geneLocation’,

and ’chromosome’ are in the same order.

expr: expression matrix with rows = genes and columns = samples/patients

labels: (disease) subtype of each sample, has length = number of columns of expression matrix

chip: Identiﬁer for Microarray used for the experiments (here for the Affymetrix HG-U95av2

Oligonucleotide GeneChip)

Source

Yeoh et al. Classiﬁcation, subtype discovery, and prediction of outcome in pediatric acute lym-
phoblastic leukemia by gene expression proﬁling. Cancer Cell. March 2002. 1: 133-143.

Examples

data(stjude)
summary(stjude)

Index

∗Topic datasets
stjude, 1

stjude, 1

3


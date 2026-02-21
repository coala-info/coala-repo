Package ‘ABAData’

April 12, 2018

Type Package

Title Averaged gene expression in human brain regions from Allen Brain

Atlas

Version 1.8.0

Date 2015-08-06

Author Stefﬁ Grote

Maintainer Stefﬁ Grote <steffi_grote@eva.mpg.de>

Description Provides the data for the gene expression enrichment

analysis conducted in the package 'ABAEnrichment'. The package
includes three datasets which are derived from the Allen Brain
Atlas: (1) Gene expression data from Human Brain (adults)
averaged across donors, (2) Gene expression data from the
Developing Human Brain pooled into ﬁve age categories and
averaged across donors and (3) a developmental effect score
based on the Developing Human Brain expression data. All
datasets are restricted to protein coding genes.

License GPL (>= 2)

Depends R (>= 3.2)

Suggests BiocStyle, knitr, ABAEnrichment

VignetteBuilder knitr

biocViews ExpressionData, Homo_sapiens_Data, MicroarrayData,

RNASeqData

NeedsCompilation no

R topics documented:

ABAData-package .
datasets_ABAData .

.
.

.
.

.
.

. .
. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
3

5

Index

1

2

ABAData-package

ABAData-package

Gene expression data from Allen Brain Atlas to use with enrichment
analysis package ABAEnrichment

Description

This package provides the data used in the gene expression enrichment package ’ABAEnrichment’.
It contains three datasets on gene expression in adult and developing human brains which base on
data provided by the Allen Brain Atlas project [1-4]. The data and its processing is described in the
package vignette. For usage of the data for gene expression enrichment analyses please refer to the
’ABAEnrichment’ vignette.

Details

Package: ABAData
Package
Type:
0.99.3
Version:
Date:
2015-08-06
License: GPL (>= 2)

For details see vignette("ABAData",package="ABAData").

Author(s)

Stefﬁ Grote
Maintainer: Stefﬁ Grote <stefﬁ_grote@eva.mpg.de>

References

[1] Hawrylycz, M.J. et al. (2012) An anatomically comprehensive atlas of the adult human brain
transcriptome, Nature 489: 391-399. doi:10.1038/nature11405
[2] Miller, J.A. et al. (2014) Transcriptional landscape of the prenatal human brain, Nature 508:
199-206. doi:10.1038/nature13185
[3] Allen Institute for Brain Science. Allen Human Brain Atlas [Internet]. Available from: http:
//human.brain-map.org/
[4] Allen Institute for Brain Science. BrainSpan Atlas of the Developing Human Brain [Internet].
Available from: http://brainspan.org/

See Also

vignette("ABAData",package="ABAData")
vignette("ABAEnrichment",package="ABAEnrichment")
datasets_ABAData

Examples

## require averaged gene expression data (microarray) from adult human brain regions
data(dataset_adult)
## look at first lines

datasets_ABAData

head(dataset_adult)

3

datasets_ABAData

Gene expression data from Allen Brain Atlas to use with enrichment
analysis package ABAEnrichment

Description

These datasets are used in the enrichment analysis package ’ABAEnrichment’. They contain data
on gene expression in human brain regions which base on datasets provided by the Allen Brain
Atlas project[1-4].
’dataset_adult’ contains microarray expression data from six adult individu-
als, ’dataset_5_stages’ contains RNA-seq data from 42 individuals grouped into ﬁve developmental
stages (prenatal to adult) and ’dataset_dev_effect’ contains scores measuring the age effect on ex-
pression per gene and brain region. The expression data in ’dataset_adult’ and ’dataset_5_stages’
are averaged across donors.

Usage

data(dataset_adult)
data(dataset_5_stages)
data(dataset_dev_effect)

Details

For details on the data and its processing see the package vignette.

Value

All three datasets in the package are represented in a data frame with the following columns:

hgnc_symbol HGNC-symbols
entrezgene Entrez-IDs
ensembl_gene_id Ensembl-IDs
structure brain region ID as used in the ontology from Allen Brain Atlas
signal normalized microarray data, RNA-seq data or developmental effect score
age_category developmental stage. 0: all stages, 1: prenatal, 2: infant (0-2 yrs), 3: child (3-11),

4: adolescent (12-19 yrs), 5: adult (>19 yrs)

Source

[1] Allen Institute for Brain Science. Allen Human Brain Atlas [Internet]. Available from: http:
//human.brain-map.org/
[2] Allen Institute for Brain Science. BrainSpan Atlas of the Developing Human Brain [Internet].
Available from: http://brainspan.org/

References

[3] Hawrylycz, M.J. et al. (2012) An anatomically comprehensive atlas of the adult human brain
transcriptome, Nature 489: 391-399. doi:10.1038/nature11405
[4] Miller, J.A. et al. (2014) Transcriptional landscape of the prenatal human brain, Nature 508:
199-206. doi:10.1038/nature13185

4

See Also

vignette("ABAData",package="ABAData")
vignette("ABAEnrichment",package="ABAEnrichment")

datasets_ABAData

Examples

data(dataset_adult)
head(dataset_adult)

data(dataset_5_stages)
head(dataset_5_stages)

data(dataset_dev_effect)
head(dataset_dev_effect)

Index

∗Topic datasets

datasets_ABAData, 3

∗Topic package

ABAData-package, 2

ABAData (ABAData-package), 2
ABAData-package, 2

dataset_5_stages (datasets_ABAData), 3
dataset_adult (datasets_ABAData), 3
dataset_dev_effect (datasets_ABAData), 3
datasets_ABAData, 2, 3

5


Package ‘sampleClassifier’

February 13, 2026

Type Package

Title Sample Classifier

Version 1.34.0

Description The package is designed to classify microarray RNA-seq gene expression

profiles.

Depends R (>= 4.0), MGFM, MGFR, annotate

Imports e1071, ggplot2, stats, utils

Suggests sampleClassifierData, BiocStyle, hgu133a.db, hgu133plus2.db

biocViews ImmunoOncology, Classification, Microarray, RNASeq,

GeneExpression

License Artistic-2.0

LazyData yes

NeedsCompilation no

git_url https://git.bioconductor.org/packages/sampleClassifier

git_branch RELEASE_3_22

git_last_commit e61a2eb

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Author Khadija El Amrani [aut, cre]

Maintainer Khadija El Amrani <a.khadija@gmx.de>

Contents

.

.

.

.
.

.
sampleClassifier-package .
. .
.
classifyProfile .
.
classifyProfile.rnaseq .
. .
.
classifyProfile.rnaseq.svm . .
. .
classifyProfile.svm .
. .
.
get.heatmap .
. .
.
grid-internal .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

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

Index

1

2
2
4
5
6
7
7

8

2

classifyProfile

sampleClassifier-package

Sample Classifier

Description

The package is designed to classify samples from microarray and RNA-seq gene expression datasets.

Package:
Type:
Version:
License: GPL-3

sampleClassifier
Package
1.0.0

Details

Author(s)

Khadija El Amrani Maintainer: Khadija El Amrani <khadija.el-amrani@charite.de>

Examples

## Not run:
library(sampleClassifierData)
data("se_micro_refmat")
micro_refmat <- assay(se_micro_refmat)
data("se_micro_testmat")
micro_testmat <- assay(se_micro_testmat)
res1.list <- classifyProfile(ref_matrix=micro_refmat, query_mat=micro_testmat,
chip1="hgu133plus2",chip2="hgu133a", write2File=FALSE)
res1.list

## End(Not run)

classifyProfile

Expression profile classification

Description

Function to classify microarray gene expression profiles

Usage

classifyProfile(ref_matrix, query_mat, chip1 = "hgu133plus2", chip2 = "hgu133a", fun1 = median, fun2 = mean, write2File=FALSE, out.dir=getwd())

classifyProfile

Arguments

ref_matrix

query_mat

chip1

chip2

fun1

fun2

3

Normalized microarray data matrix to be used as reference, with probe sets cor-
responding to rows and samples corresponding to columns.

Normalized microarray query matrix to be classified, with probe sets corre-
sponding to rows and samples corresponding to columns.

Chip name of the reference matrix.

Chip name of the query matrix. This parameter can be ignored if the reference
and query matrix are from the same chip.

mean or median. This will specify the number of marker genes that will be used
for classification. Default is median.

mean or median. This will be used to summarize the expression values of probe
sets that belong to the same gene. This parameter can be ignored if the reference
and query matrix are from the same chip. Default is mean.

write2File

If TRUE, the classification results for each query profile will be written to a file.

out.dir

Path to a directory to write the classification results, default is the current work-
ing directory.

Details

Each query profile is compared to all sample types in the reference matrix and a similarity score is
calculated. The similarity score is based on the number of marker genes that are shared between the
query and the reference. These marker genes are given in a file if write2File is TRUE.

Value

A list with top hits for each query profile, sorted according to a similarity score.

Author(s)

Khadija El Amrani <khadija.el-amrani@charite.de>

See Also

see also getMarkerGenes.

Examples

library(sampleClassifierData)
data("se_micro_refmat")
micro_refmat <- assay(se_micro_refmat)
data("se_micro_testmat")
micro_testmat <- assay(se_micro_testmat)
res1.list <- classifyProfile(ref_matrix=micro_refmat, query_mat=micro_testmat,
chip1="hgu133plus2",chip2="hgu133a", write2File=FALSE)
res1.list

4

classifyProfile.rnaseq

classifyProfile.rnaseq

Expression profile classification

Description

Function to classify RNA-seq gene expression profiles

Usage

classifyProfile.rnaseq(ref_matrix, query_mat, gene.ids.type="ensembl", fun1 = median, write2File=FALSE, out.dir=getwd())

Arguments

ref_matrix

query_mat

gene.ids.type

fun1

write2File
out.dir

Details

RNA-seq data matrix to be used as reference, with genes corresponding to rows
and samples corresponding to columns.
RNA-seq query matrix to be classified, with genes corresponding to rows and
samples corresponding to columns.
Type of the used gene identifiers, the following gene identifiers are supported:
ensembl, refseq and ucsc gene ids. Default is ensembl.
mean or median. This will specify the number of marker genes that will be used
for classification. Default is median.
A logical value. If TRUE the classification results will be written to a file.
Path to the directory, in which to write the results. Default is the actual working
directory.

Each query profile is compared to all sample types in the reference matrix and a similarity score is
calculated. The similarity score is based on the number of marker genes that are shared between the
query and the reference. These marker genes are given in a file if write2File is TRUE.

Value

A list with top hits for each query profile, sorted according to a similarity score.

Author(s)

Khadija El Amrani <khadija.el-amrani@charite.de>

Examples

library(sampleClassifierData)
data("se_rnaseq_refmat")
rnaseq_refmat <- assay(se_rnaseq_refmat)
data("se_rnaseq_testmat")
rnaseq_testmat <- assay(se_rnaseq_testmat)
res2.list <- classifyProfile.rnaseq(ref_matrix=rnaseq_refmat, query_mat=rnaseq_testmat,
gene.ids.type="ensembl",write2File=FALSE)
res2.list

classifyProfile.rnaseq.svm

5

classifyProfile.rnaseq.svm

Expression profile classification

Description

Function to classify RNA-seq gene expression profiles using support vector machines (SVM)

Usage

classifyProfile.rnaseq.svm(ref_matrix, query_mat, gene.ids.type="ensembl", fun1 = median)

Arguments

ref_matrix

query_mat

RNA-seq data matrix to be used as reference, with genes corresponding to rows
and samples corresponding to columns.

RNA-seq query matrix to be classified, with genes corresponding to rows and
samples corresponding to columns.

gene.ids.type

Type of the used gene identifiers, the following gene identifiers are supported:
ensembl, refseq and ucsc gene ids. Default is ensembl.

fun1

Details

mean or median. This will specify the number of marker genes that will be used
for classification. Default is median.

This function is based on the function svm from the R-package ’e1071’.

Value

A data frame with the predicted classes for each query profile.

Author(s)

Khadija El Amrani <khadija.el-amrani@charite.de>

Examples

library(sampleClassifierData)
data("se_rnaseq_refmat")
rnaseq_refmat <- assay(se_rnaseq_refmat)
data("se_rnaseq_testmat")
rnaseq_testmat <- assay(se_rnaseq_testmat)
res2.svm.df <- classifyProfile.rnaseq.svm(ref_matrix=rnaseq_refmat, query_mat=rnaseq_testmat,
gene.ids.type="ensembl")
res2.svm.df

6

classifyProfile.svm

classifyProfile.svm

Expression profile classification

Description

Function to classify microarray gene expression profiles using support vector machines (SVM)

Usage

classifyProfile.svm(ref_matrix, query_mat, chip1 = "hgu133plus2", chip2 = "hgu133a", fun1 = median, fun2 = mean)

Arguments

ref_matrix

query_mat

chip1

chip2

fun1

fun2

Details

Normalized microarray data matrix to be used as reference, with probe sets cor-
responding to rows and samples corresponding to columns.

Normalized microarray query matrix to be classified, with probe sets corre-
sponding to rows and samples corresponding to columns.

Chip name of the reference matrix.

Chip name of the query matrix. This parameter can be ignored if the reference
and query matrix are from the same chip.

mean or median. This will specify the number of marker genes that will be used
for classification. Default is median.

mean or median. This will be used to summarize the expression values of probe
sets that belong to the same gene. This parameter can be ignored if the reference
and query matrix are from the same chip. Default is mean.

This function is based on the function svm from the R-package ’e1071’.

Value

A data frame with the predicted classes for each query profile.

Author(s)

Khadija El Amrani <khadija.el-amrani@charite.de>

See Also

see also getMarkerGenes.

Examples

library(sampleClassifierData)
data("se_micro_refmat")
micro_refmat <- assay(se_micro_refmat)
data("se_micro_testmat")
micro_testmat <- assay(se_micro_testmat)
res1.svm.df <- classifyProfile.svm(ref_matrix=micro_refmat, query_mat=micro_testmat,
chip1="hgu133plus2",chip2="hgu133a")

get.heatmap

res1.svm.df

7

get.heatmap

display classification results as heatmap

Description

Function to display the classification predictions as a heatmap

Usage

get.heatmap(res.list)

Arguments

res.list

the result list returned by the function classifyProfile or classifyProfile.rnaseq

Details

This function is based on the function ggplot from the R-package ’ggplot2’.

Value

This function is used only for the side effect of creating a heatmap.

Author(s)

Khadija El Amrani <khadija.el-amrani@charite.de>

Examples

library(sampleClassifierData)
data("se_micro_refmat")
micro_refmat <- assay(se_micro_refmat)
data("se_micro_testmat")
micro_testmat <- assay(se_micro_testmat)
res1.list <- classifyProfile(ref_matrix=micro_refmat, query_mat=micro_testmat,
chip1="hgu133plus2",chip2="hgu133a", write2File=FALSE)
get.heatmap(res1.list)

grid-internal

Internal sampleClassifier Functions

Description

Internal sampleClassifier functions

Details

These are not intended to be called by the user.

Index

∗ RNA-seq data

classifyProfile.rnaseq, 4
classifyProfile.rnaseq.svm, 5

∗ SVM

classifyProfile.rnaseq.svm, 5
classifyProfile.svm, 6

∗ classification

classifyProfile, 2
classifyProfile.rnaseq, 4
classifyProfile.rnaseq.svm, 5
classifyProfile.svm, 6
get.heatmap, 7

∗ heatmap

get.heatmap, 7

∗ internal

grid-internal, 7

∗ microarray data

classifyProfile, 2
classifyProfile.svm, 6

∗ package

sampleClassifier-package, 2
.classify_sample (grid-internal), 7
.collapseRows (grid-internal), 7
.get.genes (grid-internal), 7
.get_mpsmat (grid-internal), 7
.getmarker_ps (grid-internal), 7

classifyProfile, 2, 7
classifyProfile.rnaseq, 4, 7
classifyProfile.rnaseq.svm, 5
classifyProfile.svm, 6

get.heatmap, 7
getMarkerGenes, 3, 6
ggplot, 7
grid-internal, 7

mean, 3–6
median, 3–6

sampleClassifier

(sampleClassifier-package), 2

sampleClassifier-package, 2
svm, 5, 6

8


Package ‘KEGGdzPathwaysGEO’

February 12, 2026

Type Package

Title KEGG Disease Datasets from GEO

Version 1.48.0

Date 2012-08-13

Author Gaurav Bhatti, Adi L. Tarca

Maintainer Gaurav Bhatti <gbhatti@med.wayne.edu>

Description This is a collection of 24 data sets for which the phenotype is a disease with a corre-
sponding pathway in the KEGG database.This collection of datasets were used as gold stan-
dard in comparing gene set analysis methods by the PADOG package.

Depends R (>= 2.13.0)

Imports Biobase, BiocGenerics

License GPL-2

biocViews MicroarrayData, GEO, ExperimentData

git_url https://git.bioconductor.org/packages/KEGGdzPathwaysGEO

git_branch RELEASE_3_22

git_last_commit ff167f3

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

2
KEGGdzPathwaysGEO-package . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
GSE1297 .
4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
GSE14762 .
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
GSE15471 .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
GSE16515 .
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
GSE18842 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
GSE19188 .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
GSE19728 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
GSE20153 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
GSE20291 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
GSE21354 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
GSE3467 .

. .
. .
. .
. .
. .
. .
. .
. .
. .
. .
. .

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

1

2

KEGGdzPathwaysGEO-package

.
.
.

.
.
GSE3585 .
.
.
GSE3678 .
.
.
GSE4107 .
GSE5281_EC .
.
GSE5281_HIP .
GSE5281_VCX .
.
GSE6956AA .
.
.
GSE6956C .
.
.
.
GSE781 .
.
.
.
.
GSE8671 .
.
.
.
GSE8762 .
.
.
.
GSE9348 .
.
.
.
GSE9476 .

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28

Index

30

KEGGdzPathwaysGEO-package

GEO Data Sets used to compare gene set analysis methods by PADOG
package

Description

This is a collection of 24 data sets for which the phenotype is a disease with a corresponding
pathway in the KEGG database. This collection of datasets were used as gold standard in comparing
gene set analysis methods by the PADOG package.

GEOID Pubmed

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

14769913
17077275
17077275
17077275
20926834
15965975
17724341
17317818
18171984
20143136
19252501
14641932
19260470
19732725

18245496
18245496
16365291

17910043
20878980
20421987

Disease/Target pathway

Ref.
pmid14769913 Alzheimer’s Disease
pmid17077275 Alzheimer’s Disease
pmid17077275 Alzheimer’s Disease
pmid17077275 Alzheimer’s Disease
Parkinson’s disease
pmid20926834
pmid15965975
Parkinson’s disease
pmid17724341 Huntington’s disease
pmid17317818 Colorectal Cancer
pmid18171984 Colorectal Cancer
pmid20143136 Colorectal Cancer
pmid19252501 Renal Cancer
pmid14641932 Renal Cancer
pmid19260470
pmid19732725
-
-
pmid18245496
pmid18245496
pmid16365291
-
pmid17910043 Acute myeloid leukemia
pmid20878980 Non-Small Cell Lung Cancer
pmid20421987 Non-Small Cell Lung Cancer

Pancreatic Cancer
Pancreatic Cancer
Glioma
Glioma
Prostate Cancer
Prostate Cancer
Thyroid Cancer
Thyroid Cancer

Postmortem brain putamen

KEGGID Tissue
hsa05010 Hippocampal CA1
hsa05010 Brain, Entorhinal Cortex
hsa05010 Brain, hippocampus
hsa05010 Brain, Primary visual cortex
hsa05012 Lymphoblasts
hsa05012
hsa05016 Lymphocytes (blood)
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
hsa05223 Lung
hsa05223 Lung

Pancreas
Pancreas

GSE1297

3

GSE3585

17045896

pmid17045896 Dilated cardiomyopathy

hsa05414 Heart

Details

Package: KEGGdzPathwaysGEO
Type:
Version:
Date:
License: GPL-2

Package
1.0
2012-07-23

Author(s)

Gaurav Bhatti <gbhatti@med.wayne.edu>

References

Tarca AL, Draghici S, Bhatti G, Romero R (2012) Down-weighting overlapping genes improves
gene set analysis.BMC Bioinformatics 13:136.

Examples

mysets=data(package="KEGGdzPathwaysGEO")$results[,"Item"]
mysets
data(GSE8671)

set=mysets[1]
data(list=set,package="KEGGdzPathwaysGEO")

GSE1297

Gene Expression Omnibus (GEO) Data Set Id: GSE1297

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE1297

Usage

data(GSE1297)

Format

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
..
:Formal class ’MIAME’ [package "Biobase"] with 13 slots ..
..@ lab : chr "Landfield" .. .. ..@ contact : chr "emblal@uky.edu" .. .. ..@ title : chr "Incipient
Alzheimer’s Disease: Microarray Correlation Analyses" ..
..@ url
..@ pubMedIds : chr
: chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE1297" ..
..@ normControls :
..
"14769913" ..

..@ abstract : chr "" ..
..

..@ name : chr "GSE1297" ..

..@ hybridizations : list() ..

..@ samples : list() ..

..

..

..

..

..

4

GSE14762

..

..

..

..

..

..

..

..$ targetGeneSets: chr "05010" ..

..$ disease : chr "Alzheimer’s Disease" ..

list() .. .. ..@ preprocessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design : chr "Not Paired"
..
..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List
of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment:
0x3f9e5268> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:2] "GEO
Sample ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 16 obs. of 2 variables: .. .. .. ..$
Sample: chr [1:16] "GSM21215" "GSM21217" "GSM21218" "GSM21219" ...
..$ Group
: chr [1:16] "c" "c" "c" "c" ...
..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@
.Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots ..
..
..
..@
..
..$ labelDescription: chr(0) ..
dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots ..
..$ : int
..
[1:3] 1 1 0 ..@ annotation : chr "hgu133a" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 16 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

..
..@ data :’data.frame’: 22283 obs. of 0 variables ..

..@ varMetadata :’data.frame’: 0 obs. of 1 variable: ..

..@ .Data:List of 1 ..

..

..

..

..

..

..

..

..

..

..

Details

Samples belonging to the Severe and Control groups are included.The sample, GSM21207, was
excluded during Quality Control.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE1297

Examples

data(GSE1297)

GSE14762

Gene Expression Omnibus (GEO) Data Set Id: GSE14762

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE14762

Usage

data(GSE14762)

GSE15471

Format

5

..

..

..

..

..

..

..

..
..

..
..

list() ..
list() ..

..@ contact : chr "NA" ..

..$ targetGeneSets: chr "05211" ..

..@ hybridizations :
..@ other :List of 3 ..

..@ lab : chr "Lab of Computational Biology" ..

..
..@ abstract : chr "" ..

..@ samples :
..@ preprocessing :
..

list() ..
..
..
..$ disease : chr "Renal Cancer" ..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
..@ name : chr "GSE14762" ..
:Formal class ’MIAME’ [package "Biobase"] with 13 slots ..
..@ title :
..
chr "Renal Cell Carcinoma: Hypoxia and Endocytosis" ..
..@ url
..
: chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE14762" .. .. ..@ pubMedIds : chr
..@ normControls
..
"19252501" ..
..$ design : chr "Not
:
list() ..
Paired" ..
..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List
of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment:
0x3f9eaa60> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:2] "GEO
Sample ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 21 obs. of 2 variables: .. .. .. ..$
Sample: chr [1:21] "GSM368649" "GSM368650" "GSM368651" "GSM368652" ... .. .. .. ..$ Group
: chr [1:21] "c" "c" "c" "c" ...
..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@
.Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’
..
[package "Biobase"] with 4 slots ..
..
..@
..
..$ labelDescription: chr(0) ..
dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3]
1 1 0 ..@ annotation : chr "hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 21 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

..
..@ data :’data.frame’: 54675 obs. of 0 variables ..

..@ varMetadata :’data.frame’: 0 obs. of 1 variable: ..

..

..

..

Details

The sample, GSM368647, was excluded during Quality Control.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE14762

Examples

data(GSE14762)

GSE15471

Gene Expression Omnibus (GEO) Data Set Id: GSE15471

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE15471

6

Usage

data(GSE15471)

Format

GSE15471

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..
..

..@ .Data:List of 2 ..

..@ other :List of 3 ..

..@ samples : list() ..

..$ : int [1:3] 1 0 0 ..

..@ contact : chr "badea.liviu@gmail.com" ..

..@ pubMedIds : chr "19260470" ..
..@ normControls : list() ..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE15471" .. ..
..@ lab : chr "AI and Bioinformatics" ..
..@
title : chr "Whole-Tissue Gene Expression Study of Pancreatic Ductal Adenocarcinoma" .. .. ..@
abstract : chr "" .. .. ..@ url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE15471"
..@ hybridizations : list()
..
..
..$
..@ preprocessing : list() ..
design : chr "Paired" .. .. .. ..$ targetGeneSets: chr "05212" .. .. .. ..$ disease : chr "Pancreatic
Cancer" ..
..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots ..
..$ : int [1:3] 1 1 0
..
..
..@ assayData :<environment: 0x3f9f19b8> ..@ phenoData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 3 obs. of 1 variable: .. .. ..
..$ labelDescription: chr [1:3] "GEO Sample ID" "Control/Disease status" "Pair ID" .. .. ..@ data
:’data.frame’: 70 obs. of 3 variables: .. .. .. ..$ Sample: chr [1:70] "GSM388076" "GSM388078"
"GSM388080" "GSM388082" ... .. .. .. ..$ Group : chr [1:70] "c" "c" "c" "c" ... .. .. .. ..$ Block
: chr [1:70] "30162" "40728" "41027" "30057" ... .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
..$ : int [1:3] 1 1 0 ..@ featureData :Formal class
slots ..
’AnnotatedDataFrame’ [package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs.
of 1 variable: .. .. .. ..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 54675 obs. of 0 variables
.. .. ..@ dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3]
1 1 0 ..@ annotation : chr "hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 70 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

..@ .Data:List of 1 ..

..

..

..

..

..

..

..

Details

Samples, GSM388077, GSM388079, GSM388081, GSM388116, GSM388118, GSM388120 were
excluded because they were replicates. Samples, GSM388111 and GSM388150, were excluded
during Quality Control.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE15471

Examples

data(GSE15471)

GSE16515

7

GSE16515

Gene Expression Omnibus (GEO) Data Set Id: GSE16515

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE16515

Usage

data(GSE16515)

Format

..

..

..

..

..

..
..

..
..@ other :List of 3 ..
..

..
..$ disease : chr "Pancreatic Cancer" ..

..@ samples : list() ..
..@ preprocessing : list() ..
..
..$ targetGeneSets: chr "05212" ..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE16515" .. ..
..@ lab : chr "NA" .. .. ..@ contact : chr "wang.liewei@mayo.edu" .. .. ..@ title : chr "Expression
data from Mayo Clinic Pancreatic Tumor and Normal samples" .. .. ..@ abstract : chr "" .. .. ..@
..@ pubMedIds :
url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE16515" ..
..@ normControls
chr "19732725" ..
..@ hybridizations : list() ..
..$ design : chr "Paired"
: list() ..
..
..@
..
..
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List
of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment:
0x3f9f8150> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 3 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:3] "GEO
Sample ID" "Control/Disease status" "Pair ID" .. .. ..@ data :’data.frame’: 30 obs. of 3 variables:
.. .. .. ..$ Sample: chr [1:30] "GSM414928" "GSM414930" "GSM414934" "GSM414938" ... .. ..
.. ..$ Group : chr [1:30] "c" "c" "c" "c" ... .. .. .. ..$ Block : chr [1:30] "16" "53" "11" "54" ... ..
.. ..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int
[1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0) .. ..
..@ data :’data.frame’: 54675 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "featureNames"
..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with
"featureColumns" ..
1 slots ..
int [1:3] 1 1 0 ..@ annotation : chr
..
"hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4
slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0)
.. .. ..@ data :’data.frame’: 30 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4 .. .. .. ..$ : int [1:3] 2 15 0 .. .. ..
..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1 0 0

..@ .Data:List of 1 ..

..$ :

..

..

..

..

..

..

..

Details

Only those samples that consisted of both tumor and normal expression data were included. Sam-
ples, GSM414931 and GSM414932, were excluded during Quality Control.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE16515

8

Examples

data(GSE16515)

GSE18842

GSE18842

Gene Expression Omnibus (GEO) Data Set Id: GSE18842

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE18842

Usage

data(GSE18842)

Format

..

..

..

..

..

..

..

..

..

..

..

..@ abstract : chr "" ..

..$ design : chr "Paired" ..

..@ preprocessing : list() ..

..@ contact : chr "efarez@ugr.es" ..

..$ Sample: chr [1:88] "GSM466948" "GSM466950" "GSM466953" "GSM466955" ...

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE18842" .. ..
..@ title : chr "Gene expression
..@ lab : chr "NA" ..
..@ url :
analysis of human lung cancer and control samples" ..
..
chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE18842" ..
..@ pubMedIds : chr
"20878980" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@ normControls : list()
..
..
..@ other :List of 3 ..
..$ targetGeneSets: chr "05223" .. .. .. ..$ disease : chr "Non Small Cell Lung Cancer" .. .. ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List
of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment:
0x3f9fe140> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 3 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:3] "GEO
Sample ID" "Control/Disease status" "Pair ID" .. .. ..@ data :’data.frame’: 88 obs. of 3 variables:
..
..
.. .. ..$ Group : chr [1:88] "c" "c" "c" "c" ... .. .. .. ..$ Block : chr [1:88] "2" "3" "9" "10" ... ..
.. ..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int
[1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0) .. ..
..@ data :’data.frame’: 54675 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "featureNames"
..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with
"featureColumns" ..
1 slots ..
int [1:3] 1 1 0 ..@ annotation : chr
..
"hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4
slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0)
.. .. ..@ data :’data.frame’: 88 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4 .. .. .. ..$ : int [1:3] 2 15 0 .. .. ..
..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1 0 0

..@ .Data:List of 1 ..

..$ :

..

..

..

..

..

..

..

Details

Only those samples were included that were paired.

GSE19188

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE18842

Examples

data(GSE18842)

9

GSE19188

Gene Expression Omnibus (GEO) Data Set Id: GSE19188

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE19188

Usage

data(GSE19188)

Format

..

..

..

..

..

..

..

..

..

..

..

..@ lab : chr "NA" ..

..@ abstract : chr "" ..

..@ contact : chr "j.philipsen@erasmusmc.nl" ..

..@ preprocessing : list() ..
..$ targetGeneSets: chr "05223" ..

..
..
..
..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots ..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
..@ name : chr "GSE19188"
:Formal class ’MIAME’ [package "Biobase"] with 13 slots ..
..
..
..@ ti-
..
..@ url :
tle : chr "Expression data for early stage NSCLC" ..
..
chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE19188" ..
..@ pubMedIds : chr
"20421987" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@ normControls : list()
..
..$ design : chr "Not Paired" ..
..@ other :List of 3 ..
..$ disease : chr "Non Small Cell Lung Cancer" ..
..
..
..@
.Data:List of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environ-
ment: 0x3fa048d8> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with
4 slots .. .. ..@ varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:2]
..@ data :’data.frame’: 153 obs. of 2 variables:
..
"GEO Sample ID" "Control/Disease status" ..
.. .. .. ..$ Sample: chr [1:153] "GSM475657" "GSM475658" "GSM475660" "GSM475663" ... ..
..
..@ dimLabels : chr [1:2] "sampleNames"
..
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’Anno-
tatedDataFrame’ [package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1
variable: .. .. .. ..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 54675 obs. of 0 variables ..
.. ..@ dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3]
1 1 0 ..@ annotation : chr "hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 153 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

..$ Group : chr [1:153] "c" "c" "c" "c" ...

..

..

10

Details

GSE19728

Samples, GSM475659, GSM475666 and GSM475781, were excluded during Quality Control.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE19188

Examples

data(GSE19188)

GSE19728

Gene Expression Omnibus (GEO) Data Set Id: GSE19728

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE19728

Usage

data(GSE19728)

Format

..

..

..

..

..

..

..

..

..

..

..

..

..

..@ .Data:List of 2 ..

..@ samples : list() ..

..@ normControls : list() ..

..@ hybridizations : list() ..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE19728" .. ..
..@ lab : chr "NA" .. .. ..@ contact : chr "yaozhq11@hotmail.com" .. .. ..@ title : chr "Expression
data from different grades (WHO) of astrocytomas (ACM)" .. .. ..@ abstract : chr "" .. .. ..@ url
: chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE19728" .. .. ..@ pubMedIds : chr
"NA" ..
..
..@ preprocessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design : chr "Not Paired" .. .. .. ..$
targetGeneSets: chr "05214" .. .. .. ..$ disease : chr "Glioma" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots ..
..$
..$ : int [1:3] 1 1 0 ..@ assayData :<environment: 0x3fa0a8c8>
: int [1:3] 1 0 0 ..
..
..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots ..
..@
varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:2] "GEO Sample
ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 21 obs. of 2 variables: .. .. .. ..$ Sample:
chr [1:21] "GSM492649" "GSM525014" "GSM525015" "GSM525016" ... .. .. .. ..$ Group : chr
[1:21] "c" "c" "c" "c" ...
..
..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots ..
..@
.Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots ..
..
..
..@
..
..$ labelDescription: chr(0) ..
dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3]
1 1 0 ..@ annotation : chr "hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 21 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

..
..@ data :’data.frame’: 54675 obs. of 0 variables ..

..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns" ..

..@ varMetadata :’data.frame’: 0 obs. of 1 variable: ..

..

..

..

..

..

..

..

GSE20153

Details

11

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE19728

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE19728

Examples

data(GSE19728)

GSE20153

Gene Expression Omnibus (GEO) Data Set Id: GSE20153

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE20153

Usage

data(GSE20153)

Format

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..
..

..@ .Data:List of 2 ..

..$ : int [1:3] 1 0 0 ..

..@ lab : chr "NA" ..

..@ samples : list() ..
..

..
..@ other :List of 3 ..

..@ varMetadata :’data.frame’: 2 obs. of 1 variable:

..@ preprocessing : list() ..
..$ targetGeneSets: chr "05012" ..

..$ labelDescription: chr [1:2] "GEO Sample ID" "Control/Disease status" ..

..@ contact : chr "middletf@upstate.edu" ..
..

..@ url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE20153" ..
..@ hybridizations : list() ..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
..@ name : chr "GSE20153"
:Formal class ’MIAME’ [package "Biobase"] with 13 slots ..
..
..
..@ title : chr
..
..@ abstract : chr
"Expression analysis of lymphoblast cells lines in Parkinson’s disease" ..
..@
"" ..
..
..
pubMedIds : chr "20926834" ..
..@
normControls : list() ..
..$ design
..
..$ disease : chr "Parkinson’s
..
: chr "Not Paired" ..
..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots ..
disease" ..
..
..$ : int [1:3] 1 1 0
..
..@ assayData :<environment: 0x2cb8a330> ..@ phenoData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots ..
..
..@ data
..
:’data.frame’: 16 obs. of 2 variables: .. .. .. ..$ Sample: chr [1:16] "GSM505297" "GSM505298"
"GSM505299" "GSM505300" ...
..@
dimLabels : chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class
..$ : int
..
’Versions’ [package "Biobase"] with 1 slots ..
[1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0) .. ..
..@ data :’data.frame’: 54675 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "featureNames"
..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with
"featureColumns" ..
1 slots ..
int [1:3] 1 1 0 ..@ annotation : chr
..
"hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4
slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0)
.. .. ..@ data :’data.frame’: 16 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4 .. .. .. ..$ : int [1:3] 2 15 0 .. .. ..
..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1 0 0

..$ Group : chr [1:16] "c" "c" "c" "c" ...

..@ .Data:List of 1 ..

..@ .Data:List of 1 ..

..$ :

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

12

Details

GSE20291

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE20153

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE20153

Examples

data(GSE20153)

GSE20291

Gene Expression Omnibus (GEO) Data Set Id: GSE20291

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE20291

Usage

data(GSE20291)

Format

..

..

..

..@ lab : chr "NA" ..

..@ contact : chr "middletf@upstate.edu" ..

..
..@ abstract : chr "" ..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
..@ name : chr "GSE20291" ..
:Formal class ’MIAME’ [package "Biobase"] with 13 slots ..
..@ title : chr "Tran-
..
scriptional analysis of putamen in Parkinson’s disease" ..
..@ url
..
: chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE20291" .. .. ..@ pubMedIds : chr
"15965975" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@ normControls : list()
.. .. ..@ preprocessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design : chr "Not Paired" .. .. ..
..$ targetGeneSets: chr "05012" .. .. .. ..$ disease : chr "Parkinson’s disease" .. .. ..@ .__classVer-
sion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 2 .. .. ..
.. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment: 0x2cb9b7d8>
..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots ..
..@
varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:2] "GEO Sample
ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 33 obs. of 2 variables: .. .. .. ..$ Sample:
chr [1:33] "GSM508594" "GSM508683" "GSM508686" "GSM508687" ... .. .. .. ..$ Group : chr
[1:33] "c" "c" "c" "c" ... .. .. ..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns" .. .. ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List
of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’ [package
"Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDe-
scription: chr(0) .. .. ..@ data :’data.frame’: 22283 obs. of 0 variables .. .. ..@ dimLabels : chr
[1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [pack-
age "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ annotation
: chr "hgu133a" ..@ protocolData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with
4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0)
.. .. ..@ data :’data.frame’: 33 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4 .. .. .. ..$ : int [1:3] 2 15 0 .. .. ..
..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1 0 0

..

GSE21354

Details

13

Samples, GSM508611 and GSM606622, were excluded during Quality Control.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE20291

Examples

data(GSE20291)

GSE21354

Gene Expression Omnibus (GEO) Data Set Id: GSE21354

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE21354

Usage

data(GSE21354)

Format

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..
..

..@ .Data:List of 2 ..

..@ hybridizations : list() ..

..$ design : chr "Not Paired" ..

..@ samples : list() ..
..

..
..@ other :List of 3 ..

..@ normControls : list() ..
..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE21354" .. ..
..@ lab : chr "NA" ..
..@ title : chr "gene
..@ contact : chr "yaozhq11@hotmail.com" ..
expression profiling of three type of grade II gliomas" .. .. ..@ abstract : chr "" .. .. ..@ url : chr
"http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE21354" .. .. ..@ pubMedIds : chr "NA"
..@
..
preprocessing : list() ..
..$
targetGeneSets: chr "05214" .. .. .. ..$ disease : chr "Glioma" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots ..
..$
..$ : int [1:3] 1 1 0 ..@ assayData :<environment: 0x2cba1008>
: int [1:3] 1 0 0 ..
..
..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots ..
..@
varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:2] "GEO Sample
ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 17 obs. of 2 variables: .. .. .. ..$ Sample:
chr [1:17] "GSM492649" "GSM525014" "GSM525015" "GSM525016" ... .. .. .. ..$ Group : chr
[1:17] "c" "c" "c" "c" ...
..
..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots ..
..@
.Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots ..
..
..
..@
..
..$ labelDescription: chr(0) ..
dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3]
1 1 0 ..@ annotation : chr "hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 17 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

..
..@ data :’data.frame’: 54675 obs. of 0 variables ..

..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns" ..

..@ varMetadata :’data.frame’: 0 obs. of 1 variable: ..

..

..

..

..

..

..

..

GSE3467

14

Details

Sample, GSM492652, was excluded during Quality Control.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE21354

Examples

data(GSE21354)

GSE3467

Gene Expression Omnibus (GEO) Data Set Id: GSE3467

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3467

Usage

data(GSE3467)

Format

..

..

..

..

..

..

..

..

..@ samples : list() ..

..@ hybridizations : list() ..

..@ lab : chr "Davuluri Lab" ..

..@ contact : chr "sandya.liyanarachchi@osumc.edu" ..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
..@ name : chr "GSE3467" ..
:Formal class ’MIAME’ [package "Biobase"] with 13 slots ..
..
..
..@ abstract :
..@ title : chr "The role of micro-RNA genes in papillary thyroid carcinoma" ..
chr "" .. .. ..@ url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3467" .. .. ..@
pubMedIds : chr "16365291" ..
..@
normControls : list() .. .. ..@ preprocessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design : chr
"Paired" .. .. .. ..$ targetGeneSets: chr "05216" .. .. .. ..$ disease : chr "Thyroid Cancer" .. .. ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List
of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment:
0x2cba7f60> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 3 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:3] "GEO
Sample ID" "Control/Disease status" "Pair ID" .. .. ..@ data :’data.frame’: 18 obs. of 3 variables:
..
..
..$ Sample: chr [1:18] "GSM77362" "GSM77364" "GSM77366" "GSM77368" ...
..$ Group : chr [1:18] "c" "c" "c" "c" ...
..
.. ..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int
[1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0) .. ..
..@ data :’data.frame’: 54675 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "featureNames"
..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with
"featureColumns" ..
1 slots ..
int [1:3] 1 1 0 ..@ annotation : chr
..
"hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4
slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0)
.. .. ..@ data :’data.frame’: 18 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4 .. .. .. ..$ : int [1:3] 2 15 0 .. .. ..
..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1 0 0

..
..$ Block : chr [1:18] "14" "26" "50" "69" ...

..@ .Data:List of 1 ..

..$ :

..

..

..

..

..

..

..

..

..

..

..

GSE3585

Details

15

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3467

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3467

Examples

data(GSE3467)

GSE3585

Gene Expression Omnibus (GEO) Data Set Id: GSE3585

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3585

Usage

data(GSE3585)

Format

..

..

..

..

..

..

..

..
..

..@ name : chr "GSE3585" ..

..$ disease : chr "Dilated cardiomyopathy" ..

..@ preprocessing : list() ..
..$ targetGeneSets: chr "05414" ..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots ..
..
..@ lab : chr "Unit Cancer Genome Research" .. .. ..@ contact : chr "r.kuner@dkfz.de" .. .. ..@
title : chr "Dilated Cardiomyopathy and Non Failing Biopsies" .. .. ..@ abstract : chr "" .. .. ..@
url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3585" .. .. ..@ pubMedIds : chr
"17045896" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@ normControls : list()
..$ design : chr "Not Paired" ..
..
..@ other :List of 3 ..
..@
..
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List
of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment:
0x2cbaeeb8> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:2] "GEO
Sample ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 12 obs. of 2 variables: .. .. .. ..$
Sample: chr [1:12] "GSM82381" "GSM82382" "GSM82383" "GSM82384" ...
..$ Group
: chr [1:12] "c" "c" "c" "c" ...
..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@
.Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots ..
..
..
..@
..
..$ labelDescription: chr(0) ..
dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal class
..$ : int
..
’Versions’ [package "Biobase"] with 1 slots ..
[1:3] 1 1 0 ..@ annotation : chr "hgu133a" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 12 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

..
..@ data :’data.frame’: 22283 obs. of 0 variables ..

..@ varMetadata :’data.frame’: 0 obs. of 1 variable: ..

..@ .Data:List of 1 ..

..

..

..

..

..

..

..

..

..

..

..

..

16

Details

GSE3678

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3585

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3585

Examples

data(GSE3585)

GSE3678

Gene Expression Omnibus (GEO) Data Set Id: GSE3678

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3678

Usage

data(GSE3678)

Format

..

..

..

..

..

..

..

..

..

..@ lab : chr "NA" ..

..@ abstract : chr "" ..

..$ disease : chr "Thyroid Cancer" ..

..@ contact : chr "ismael_reyes@nymc.edu" ..
..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experiment-
Data :Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE3678"
..@ title
..
..@ url : chr
: chr "PTC versus paired normal thyroid tissue" ..
"http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3678" .. .. ..@ pubMedIds : chr "NA" ..
.. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@ normControls : list() .. .. ..@ prepro-
cessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design : chr "Paired" .. .. .. ..$ targetGeneSets:
..@ .__classVersion__:Formal class
chr "05216" ..
’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 2 .. .. .. .. .. ..$ : int [1:3] 1 0
0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment: 0x2cbb46e8> ..@ phenoData :Formal
class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’:
3 obs. of 1 variable: ..
..$ labelDescription: chr [1:3] "GEO Sample ID" "Control/Disease
status" "Pair ID" .. .. ..@ data :’data.frame’: 14 obs. of 3 variables: .. .. .. ..$ Sample: chr [1:14]
"GSM85215" "GSM85216" "GSM85217" "GSM85218" ... .. .. .. ..$ Group : chr [1:14] "c" "c" "c"
"c" ... .. .. .. ..$ Block : chr [1:14] "1" "2" "3" "4" ... .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’Anno-
tatedDataFrame’ [package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1
variable: .. .. .. ..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 54675 obs. of 0 variables ..
.. ..@ dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3]
1 1 0 ..@ annotation : chr "hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 14 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

GSE4107

Details

17

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3678

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3678

Examples

data(GSE3678)

GSE4107

Gene Expression Omnibus (GEO) Data Set Id: GSE4107

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE4107

Usage

data(GSE4107)

Format

..

..

..

..

..$ targetGeneSets: chr "05210" ..

..$ disease : chr "Colorectal Cancer" ..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE4107" .. .. ..@
lab : chr "CRC research lab" .. .. ..@ contact : chr "hong.yi@sgh.com.sg;fbap8570@yahoo.com" ..
.. ..@ title : chr "Expression profiling in early onset colorectal cancer" .. .. ..@ abstract : chr "" .. ..
..@ url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE4107" .. .. ..@ pubMedIds
: chr "17317818" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@ normControls :
list() .. .. ..@ preprocessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design : chr "Not Paired"
..@
..
..
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List
of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment:
0x41550490> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4
slots .. .. ..@ varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:2]
"GEO Sample ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 22 obs. of 2 variables: .. .. ..
..$ Sample: chr [1:22] "GSM93938" "GSM93939" "GSM93941" "GSM93943" ... .. .. .. ..$ Group
: chr [1:22] "c" "c" "c" "c" ...
..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@
.Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots ..
..
..
..@
..
..$ labelDescription: chr(0) ..
dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3]
1 1 0 ..@ annotation : chr "hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 22 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

..
..@ data :’data.frame’: 54675 obs. of 0 variables ..

..@ varMetadata :’data.frame’: 0 obs. of 1 variable: ..

..

..

..

18

Details

GSE5281_EC

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE4107

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE4107

Examples

data(GSE4107)

GSE5281_EC

Description

Gene Expression Omnibus
GSE5281.
GSE5281_EC contains data for Entorhinal cortex samples from the
data set GSE5281.

(GEO) Data Set

Id:

GSE5281_EC contains data for Entorhinal cortex samples from the data set GSE5281. For detailed
description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5281

Usage

data(GSE5281_EC)

Format

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE5281_EC" .. ..
..@ lab : chr "NIH Neuroscience Microarray Consortium" .. .. ..@ contact : chr "bhamill@mednet.ucla.edu"
.. .. ..@ title : chr "Alzheimer’s disease and the normal aged brain (steph-affy-human-433773)" .. ..
..@ abstract : chr "" .. .. ..@ url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5281"
.. .. ..@ pubMedIds : chr "17077275" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@
normControls : list() .. .. ..@ preprocessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design : chr
"Not Paired" .. .. .. ..$ targetGeneSets: chr "05010" .. .. .. ..$ disease : chr "Alzheimer’s Disease"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@
.Data:List of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<envi-
ronment: 0x415573e8> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"]
with 4 slots .. .. ..@ varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription:
chr [1:2] "GEO Sample ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 21 obs. of 2 vari-
ables: .. .. .. ..$ Sample: chr [1:21] "GSM119615" "GSM119616" "GSM119617" "GSM119618"
... .. .. .. ..$ Group : chr [1:21] "c" "c" "c" "c" ... .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’Anno-
tatedDataFrame’ [package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1
variable: .. .. .. ..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 54675 obs. of 0 variables ..
.. ..@ dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3]
1 1 0 ..@ annotation : chr "hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 21 obs. of 0 variables .. .. ..@ dimLabels

GSE5281_HIP

19

: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

Details

GSE5281_EC contains data for Entorhinal cortex samples from the data set GSE5281. The samples,
GSM119626 and GSM238763, were excluded during Quality Control.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5281

Examples

data(GSE5281_EC)

GSE5281_HIP

Description

Expression

Gene
Set
GSE5281.GSE5281_HIP contains data for hippocampus
ples from the data set GSE5281.

Omnibus

(GEO)

Data

Id:
sam-

GSE5281_HIP contains data for hippocampus samples from the data set GSE5281. For detailed
description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5281

Usage

data(GSE5281_HIP)

Format

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE5281_HIP" .. ..
..@ lab : chr "NIH Neuroscience Microarray Consortium" .. .. ..@ contact : chr "bhamill@mednet.ucla.edu"
.. .. ..@ title : chr "Alzheimer’s disease and the normal aged brain (steph-affy-human-433773)" .. ..
..@ abstract : chr "" .. .. ..@ url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5281"
.. .. ..@ pubMedIds : chr "17077275" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@
normControls : list() .. .. ..@ preprocessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design : chr
"Not Paired" .. .. .. ..$ targetGeneSets: chr "05010" .. .. .. ..$ disease : chr "Alzheimer’s Disease"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@
.Data:List of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<envi-
ronment: 0x4155cc18> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"]
with 4 slots .. .. ..@ varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription:
chr [1:2] "GEO Sample ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 23 obs. of 2 vari-
ables: .. .. .. ..$ Sample: chr [1:23] "GSM119628" "GSM119629" "GSM119630" "GSM119631"
... .. .. .. ..$ Group : chr [1:23] "c" "c" "c" "c" ... .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1

20

GSE5281_VCX

slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’Anno-
tatedDataFrame’ [package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1
variable: .. .. .. ..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 54675 obs. of 0 variables ..
.. ..@ dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3]
1 1 0 ..@ annotation : chr "hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 23 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

Details

GSE5281_HIP contains data for hippocampus samples from the data set GSE5281.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5281

Examples

data(GSE5281_HIP)

GSE5281_VCX

Description

Gene Expression Omnibus
GSE5281.
GSE5281_VCX contains data for Visual Cortex samples from the data
set GSE5281.

(GEO) Data Set

Id:

GSE5281_VCX contains data for Visual Cortex samples from the data set GSE5281. For detailed
description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5281

Usage

data(GSE5281_VCX)

Format

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE5281_VCX" ..
.. ..@ lab : chr "NIH Neuroscience Microarray Consortium" .. .. ..@ contact : chr "bhamill@mednet.ucla.edu"
.. .. ..@ title : chr "Alzheimer’s disease and the normal aged brain (steph-affy-human-433773)" .. ..
..@ abstract : chr "" .. .. ..@ url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5281"
.. .. ..@ pubMedIds : chr "17077275" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@
normControls : list() .. .. ..@ preprocessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design : chr
"Not Paired" .. .. .. ..$ targetGeneSets: chr "05010" .. .. .. ..$ disease : chr "Alzheimer’s Disease"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@

GSE6956AA

21

.Data:List of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<envi-
ronment: 0x2cbb3168> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"]
with 4 slots .. .. ..@ varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription:
chr [1:2] "GEO Sample ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 31 obs. of 2 vari-
ables: .. .. .. ..$ Sample: chr [1:31] "GSM119677" "GSM119678" "GSM119679" "GSM119680"
... .. .. .. ..$ Group : chr [1:31] "c" "c" "c" "c" ... .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’Anno-
tatedDataFrame’ [package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1
variable: .. .. .. ..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 54675 obs. of 0 variables ..
.. ..@ dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3]
1 1 0 ..@ annotation : chr "hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 31 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

Details

GSE5281_VCX contains data for Visual Cortex samples from the data set GSE5281.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5281

Examples

data(GSE5281_VCX)

GSE6956AA

Description

Gene Expression Omnibus
GSE6956.
GSE6956AA contains data for African-American Men from the data
set GSE6956

(GEO) Data Set

Id:

GSE6956AA contains data for African-American Men from the data set GSE6956. For detailed
description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE6956

Usage

data(GSE6956AA)

22

Format

GSE6956C

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..@ .Data:List of 2 ..

..@ samples : list() ..

..$ : int [1:3] 1 0 0 ..

..@ pubMedIds : chr "18245496" ..

..
..@ normControls : list() ..

..
..@ other :List of 3 ..
..

..
..@ preprocessing : list() ..
..$ targetGeneSets: chr "05215" ..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE6956AA" ..
.. ..@ lab : chr "The Laboratory of Human Carcinogenesis" .. .. ..@ contact : chr "NA" .. .. ..@
title : chr "Tumor Immunobiological Differences in Prostate Cancer between African-American and
European-American Men" .. .. ..@ abstract : chr "" .. .. ..@ url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE6956"
..
..@ hybridizations : list() ..
..
..$
design : chr "Paired" ..
..$ disease : chr "Prostate
Cancer" ..
..
..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots ..
..$ : int [1:3] 1 1 0
..
..
..@ assayData :<environment: 0x2cb95870> ..@ phenoData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 3 obs. of 1 variable: .. .. ..
..$ labelDescription: chr [1:3] "GEO Sample ID" "Control/Disease status" "Pair ID" .. .. ..@ data
:’data.frame’: 10 obs. of 3 variables: .. .. .. ..$ Sample: chr [1:10] "GSM160404" "GSM160424"
"GSM160427" "GSM160428" ... .. .. .. ..$ Group : chr [1:10] "c" "c" "c" "c" ... .. .. .. ..$ Block :
chr [1:10] "65" "51" "16" "11" ... .. .. ..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@
.Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots ..
..
..
..@
..
..$ labelDescription: chr(0) ..
dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal class
..$ : int
..
’Versions’ [package "Biobase"] with 1 slots ..
[1:3] 1 1 0 ..@ annotation : chr "hgu133a" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 10 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

..
..@ data :’data.frame’: 22277 obs. of 0 variables ..

..@ varMetadata :’data.frame’: 0 obs. of 1 variable: ..

..@ .Data:List of 1 ..

..

..

..

..

..

..

..

Details

GSE6956AA contains data for African-American Men from the data set GSE6956.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE6956

Examples

data(GSE6956AA)

GSE6956C

Gene Expression Omnibus (GEO) Data Set Id: GSE6956. GSE6956C
contains data for European-American Men from the data set
GSE6956.

GSE6956C

Description

23

GSE6956C contains data for European-American Men from the data set GSE6956. For detailed
description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE6956

Usage

data(GSE6956C)

Format

..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots ..
..@ name : chr "GSE6956C" ..
.. ..@ lab : chr "The Laboratory of Human Carcinogenesis" .. .. ..@ contact : chr "NA" .. .. ..@
title : chr "Tumor Immunobiological Differences in Prostate Cancer between African-American and
European-American Men" .. .. ..@ abstract : chr "" .. .. ..@ url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE6956"
.. .. ..@ pubMedIds : chr "18245496" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@
normControls : list() .. .. ..@ preprocessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design : chr
"Paired" .. .. .. ..$ targetGeneSets: chr "05215" .. .. .. ..$ disease : chr "Prostate Cancer" .. .. ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List
of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment:
0x3f9f5cd8> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 3 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:3] "GEO
Sample ID" "Control/Disease status" "Pair ID" .. .. ..@ data :’data.frame’: 16 obs. of 3 variables:
.. .. .. ..$ Sample: chr [1:16] "GSM160402" "GSM160407" "GSM160409" "GSM160411" ... .. ..
.. ..$ Group : chr [1:16] "c" "c" "c" "c" ... .. .. .. ..$ Block : chr [1:16] "63" "68" "70" "72" ... ..
.. ..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int
[1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0) .. ..
..@ data :’data.frame’: 22277 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "featureNames"
"featureColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ annotation : chr "hgu133a"
..@ protocolData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots .. .. ..@
varMetadata :’data.frame’: 0 obs. of 1 variable: ..
..@
data :’data.frame’: 16 obs. of 0 variables ..
..@ dimLabels : chr [1:2] "sampleNames" "sam-
pleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots
..
..$ : int [1:3] 1 1 0 ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4 .. .. .. ..$ : int [1:3] 2 15 0 .. .. ..
..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1 0 0

..$ labelDescription: chr(0) ..

..@ .Data:List of 1 ..

..

..

..

..

..

..

..

..

..

..

..

Details

GSE6956C contains data for European-American Men from the data set GSE6956.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE6956

Examples

data(GSE6956C)

24

GSE781

GSE781

Gene Expression Omnibus (GEO) Data Set Id: GSE781

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE781

Usage

data(GSE781)

Format

..

..

..

..

..

..

..

..@ other :List of 3 ..

..@ lab : chr "NA" ..

..@ contact : chr "mlenburg@bu.edu" ..

..$ design : chr "Not Paired" ..
..

..
..@ preprocessing : list() ..
..$ targetGeneSets: chr "05211" ..

..
..$ disease : chr "Renal Cancer" ..

..
..@ abstract : chr "" ..
..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experiment-
..@ name : chr "GSE781"
Data :Formal class ’MIAME’ [package "Biobase"] with 13 slots ..
..@ title : chr "Nor-
..
..
mal and Renal Cell Carcinoma Kidney Tissue, Human" ..
..@ url
..
: chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE781" ..
..@ pubMedIds : chr
"14641932" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@ normControls : list()
..
..
..@ .__classVer-
..
sion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 2 .. .. ..
.. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment: 0x2a6cbd18>
..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots ..
..@
varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:2] "GEO Sample
ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 17 obs. of 2 variables: .. .. .. ..$ Sam-
ple: chr [1:17] "GSM11805" "GSM11823" "GSM12075" "GSM12098" ... .. .. .. ..$ Group : chr
[1:17] "c" "c" "c" "c" ... .. .. ..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns" .. .. ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List
of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’ [package
"Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDe-
scription: chr(0) .. .. ..@ data :’data.frame’: 22283 obs. of 0 variables .. .. ..@ dimLabels : chr
[1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [pack-
age "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ annotation
: chr "hgu133a" ..@ protocolData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with
4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0)
.. .. ..@ data :’data.frame’: 17 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4 .. .. .. ..$ : int [1:3] 2 15 0 .. .. ..
..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1 0 0

..

Details

Samples run on the chip, hgu133a, are included.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE781

GSE8671

Examples

data(GSE781)

25

GSE8671

Gene Expression Omnibus (GEO) Data Set Id: GSE8671

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE8671

Usage

data(GSE8671)

Format

..

..

..

..

..

..

..

..

..

..

..@ lab : chr "NA" ..

..$ design : chr "Paired" ..

..@ preprocessing : list() ..

..@ contact : chr "marra@imcr.uzh.ch" ..

..@ abstract : chr "" ..
..

..$ Sample: chr [1:64] "GSM215051" "GSM215052" "GSM215053" "GSM215054" ...
..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experiment-
Data :Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE8671"
..@ title : chr
..
..@ url
"Transcriptome profile of human colorectal adenomas." ..
: chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE8671" ..
..@ pubMedIds : chr
"18171984" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@ normControls : list()
..
..
..@ other :List of 3 ..
..$ targetGeneSets: chr "05210" .. .. .. ..$ disease : chr "Colorectal Cancer" .. .. ..@ .__classVer-
sion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 2 .. .. ..
.. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment: 0x383c9608>
..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots ..
..@
varMetadata :’data.frame’: 3 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:3] "GEO Sample
..
ID" "Control/Disease status" "Pair ID" ..
..
..
..$ Group : chr [1:64] "c" "c" "c" "c" ...
..
..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns" ..
..@ .__classVersion__:Formal
..$ :
class ’Versions’ [package "Biobase"] with 1 slots ..
int [1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4
slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0)
..
..@ dimLabels : chr [1:2] "feature-
Names" "featureColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"]
with 1 slots ..
..$ : int [1:3] 1 1 0 ..@ annotation : chr
..
"hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4
slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0)
.. .. ..@ data :’data.frame’: 64 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4 .. .. .. ..$ : int [1:3] 2 15 0 .. .. ..
..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1 0 0

..@ data :’data.frame’: 64 obs. of 3 variables: ..
..
..

..
..$ Block : chr [1:64] "1" "2" "3" "4" ...

..@ data :’data.frame’: 54675 obs. of 0 variables ..

..@ .Data:List of 1 ..

..@ .Data:List of 1 ..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

..

Details

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE8671

26

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE8671

Examples

data(GSE8671)

GSE8762

GSE8762

Gene Expression Omnibus (GEO) Data Set Id: GSE8762

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE8762

Usage

data(GSE8762)

Format

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE8762" .. .. ..@
lab : chr "Laboratory of Neurogenetics" .. .. ..@ contact : chr "kuhnam@mail.nih.gov" .. .. ..@ title
: chr "Lymphocyte gene expression data from moderate stage HD patients and controls" .. .. ..@
abstract : chr "" .. .. ..@ url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE8762"
.. .. ..@ pubMedIds : chr "17724341" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@
normControls : list() .. .. ..@ preprocessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design : chr "Not
Paired" .. .. .. ..$ targetGeneSets: chr "05016" .. .. .. ..$ disease : chr "Huntington’s disease" .. .. ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List
of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment:
0x7e09e1f0> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:2] "GEO
Sample ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 22 obs. of 2 variables: .. .. .. ..$
Sample: chr [1:22] "GSM217766" "GSM217767" "GSM217768" "GSM217769" ... .. .. .. ..$ Group
: chr [1:22] "c" "c" "c" "c" ...
..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@
.Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots ..
..
..
..@
..
..$ labelDescription: chr(0) ..
dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3]
1 1 0 ..@ annotation : chr "hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 22 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

..
..@ data :’data.frame’: 54675 obs. of 0 variables ..

..@ varMetadata :’data.frame’: 0 obs. of 1 variable: ..

..

..

..

GSE9348

Details

27

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE8762

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE8762

Examples

data(GSE8762)

GSE9348

Gene Expression Omnibus (GEO) Data Set Id: GSE9348

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE9348

Usage

data(GSE9348)

Format

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experimentData
:Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE9348" .. .. ..@
lab : chr "CRC research lab" .. .. ..@ contact : chr "hong.yi@sgh.com.sg;fbap8570@yahoo.com"
.. .. ..@ title : chr "Expression data from healthy controls and early stage CRC patient’s tumor" .. ..
..@ abstract : chr "" .. .. ..@ url : chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE9348"
.. .. ..@ pubMedIds : chr "20143136" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. ..
..@ normControls : list() .. .. ..@ preprocessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design :
chr "Not Paired" .. .. .. ..$ targetGeneSets: chr "05210" .. .. .. ..$ disease : chr "Colorectal Cancer"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@
.Data:List of 2 .. .. .. .. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<envi-
ronment: 0x6239b018> ..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"]
with 4 slots .. .. ..@ varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription:
chr [1:2] "GEO Sample ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 82 obs. of 2 vari-
ables: .. .. .. ..$ Sample: chr [1:82] "GSM237984" "GSM237985" "GSM237986" "GSM237987"
... .. .. .. ..$ Group : chr [1:82] "c" "c" "c" "c" ... .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’Anno-
tatedDataFrame’ [package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1
variable: .. .. .. ..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 54675 obs. of 0 variables ..
.. ..@ dimLabels : chr [1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal
class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3]
1 1 0 ..@ annotation : chr "hgu133plus2" ..@ protocolData :Formal class ’AnnotatedDataFrame’
[package "Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. ..
..$ labelDescription: chr(0) .. .. ..@ data :’data.frame’: 82 obs. of 0 variables .. .. ..@ dimLabels
: chr [1:2] "sampleNames" "sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’
[package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 15 0 .. .. .. ..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1
0 0

28

Details

GSE9476

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE9348

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE9348

Examples

data(GSE9348)

GSE9476

Gene Expression Omnibus (GEO) Data Set Id: GSE9476

Description

For detailed description visit: http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE9476

Usage

data(GSE9476)

Format

..

..

..

..@ lab : chr "Stirewalt Lab" ..

..@ contact : chr "dstirewa@fhcrc.org" ..
..@ abstract : chr "" ..
..

The format is: Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots ..@ experiment-
Data :Formal class ’MIAME’ [package "Biobase"] with 13 slots .. .. ..@ name : chr "GSE9476"
..@ ti-
..
..
tle : chr "Abnormal Expression Changes in AML" ..
..@ url
..
: chr "http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE9476" ..
..@ pubMedIds : chr
"17910043" .. .. ..@ samples : list() .. .. ..@ hybridizations : list() .. .. ..@ normControls : list() ..
.. ..@ preprocessing : list() .. .. ..@ other :List of 3 .. .. .. ..$ design : chr "Not Paired" .. .. .. ..$
targetGeneSets: chr "05221" .. .. .. ..$ disease : chr "Acute myeloid leukemia" .. .. ..@ .__classVer-
sion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 2 .. .. ..
.. .. ..$ : int [1:3] 1 0 0 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ assayData :<environment: 0x6a5d4cd0>
..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots ..
..@
varMetadata :’data.frame’: 2 obs. of 1 variable: .. .. .. ..$ labelDescription: chr [1:2] "GEO Sample
ID" "Control/Disease status" .. .. ..@ data :’data.frame’: 63 obs. of 2 variables: .. .. .. ..$ Sample:
chr [1:63] "GSM239170" "GSM239323" "GSM239324" "GSM239326" ... .. .. .. ..$ Group : chr
[1:63] "c" "c" "c" "c" ... .. .. ..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns" .. .. ..@
.__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List
of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ featureData :Formal class ’AnnotatedDataFrame’ [package
"Biobase"] with 4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDe-
scription: chr(0) .. .. ..@ data :’data.frame’: 22283 obs. of 0 variables .. .. ..@ dimLabels : chr
[1:2] "featureNames" "featureColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [pack-
age "Biobase"] with 1 slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ annotation
: chr "hgu133a" ..@ protocolData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with
4 slots .. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable: .. .. .. ..$ labelDescription: chr(0)
.. .. ..@ data :’data.frame’: 63 obs. of 0 variables .. .. ..@ dimLabels : chr [1:2] "sampleNames"
"sampleColumns" .. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1
slots .. .. .. .. ..@ .Data:List of 1 .. .. .. .. .. ..$ : int [1:3] 1 1 0 ..@ .__classVersion__:Formal class
’Versions’ [package "Biobase"] with 1 slots .. .. ..@ .Data:List of 4 .. .. .. ..$ : int [1:3] 2 15 0 .. .. ..
..$ : int [1:3] 2 16 0 .. .. .. ..$ : int [1:3] 1 3 0 .. .. .. ..$ : int [1:3] 1 0 0

..

29

GSE9476

Details

The sample, GSM240433, was excluded during Quality Control.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE9476

Examples

data(GSE9476)

GSE6956C, 22
GSE781, 24
GSE8671, 25
GSE8762, 26
GSE9348, 27
GSE9476, 28

KEGGdzPathwaysGEO

(KEGGdzPathwaysGEO-package), 2

KEGGdzPathwaysGEO-package, 2

Index

∗ datasets

GSE1297, 3
GSE14762, 4
GSE15471, 5
GSE16515, 7
GSE18842, 8
GSE19188, 9
GSE19728, 10
GSE20153, 11
GSE20291, 12
GSE21354, 13
GSE3467, 14
GSE3585, 15
GSE3678, 16
GSE4107, 17
GSE5281_EC, 18
GSE5281_HIP, 19
GSE5281_VCX, 20
GSE6956AA, 21
GSE6956C, 22
GSE781, 24
GSE8671, 25
GSE8762, 26
GSE9348, 27
GSE9476, 28

GSE1297, 3
GSE14762, 4
GSE15471, 5
GSE16515, 7
GSE18842, 8
GSE19188, 9
GSE19728, 10
GSE20153, 11
GSE20291, 12
GSE21354, 13
GSE3467, 14
GSE3585, 15
GSE3678, 16
GSE4107, 17
GSE5281_EC, 18
GSE5281_HIP, 19
GSE5281_VCX, 20
GSE6956AA, 21

30


GGBase: infrastructure for genetics of gene expression

October 30, 2017

Contents

1 Introduction

2 Primary class structure, and associated methods

3 Example data structure

4 Visualizing a speciﬁc gene-SNP relationship

5 Genotype representations

6 Reducing memory footprint of integrative data structures

1

1

3

3

4

5

1

Introduction

The GGBase package deﬁnes infrastructure for analysis of data on the genetics of gene
expression. This document is primarily of concern to developers; for information on
conducting analyses in genetics of expression, please see the vignette for the GGtools
package.

2 Primary class structure, and associated methods

smlSet is used to denote “SNP matrix list” integrative container for expression plus
genotype data. The SnpMatrix class is deﬁned in Clayton’s snpStats package.

> library(GGBase)
> getClass("smlSet")

Class "smlSet" [package "GGBase"]

1

Slots:

Name:
Class:

Name:
Class:

Name:
Class:

smlEnv
environment

annotation
character

organism
character

featureData
phenoData
assayData
AssayData AnnotatedDataFrame AnnotatedDataFrame

experimentData

MIAxE AnnotatedDataFrame

protocolData .__classVersion__
Versions

Extends:
Class "eSet", directly
Class "VersionedBiobase", by class "eSet", distance 2
Class "Versioned", by class "eSet", distance 3

> showMethods(class="smlSet", where="package:GGBase")

Function: [ (package base)
x="smlSet", i="ANY", j="ANY", drop="ANY"

Function: clipPCs (package GGBase)
x="smlSet", inds2drop="numeric", center="logical"
x="smlSet", inds2drop="numeric", center="missing"

Function: combine (package BiocGenerics)
x="smlSet", y="smlSet"

Function: exprs (package Biobase)
object="smlSet"

Function: nsFilter (package genefilter)
eset="smlSet"

Function: permEx (package GGBase)
sms="smlSet"

Function: plot_EvG (package GGBase)
gsym="genesym", rsid="rsid", sms="smlSet"
gsym="probeId", rsid="rsid", sms="smlSet"

Function: smList (package GGBase)
x="smlSet"

2

Genotype data are stored in a list in the smlEnv environment to diminish copying as
functions are called on the smlSet instance.

3 Example data structure

Expression data were published by the Wellcome Trust GENEVAR project in 2007.
Genotype data are from HapMap phase II.

> if ("GGtools" %in% installed.packages()[,1]) {
+ library(GGtools)
+ s20 = getSS("GGtools", "20")
+ s20
+ }

SnpMatrix-based genotype set:
number of samples: 90
number of chromosomes present: 1
annotation: illuminaHumanv1.db
Expression data dims: 47293 x 90
Total number of SNP: 119921
Phenodata: An object of class

’

AnnotatedDataFrame

’

sampleNames: NA06985 NA06991 ... NA12892 (90 total)
varLabels: famid persid ... male (7 total)
varMetadata: labelDescription

4 Visualizing a speciﬁc gene-SNP relationship

The SNP rs6060535 was reported as an eQTL for CPNE1 by Cheung et al in a Nature
paper of 2005.

> if (exists("s20")) {
+ plot_EvG(genesym("CPNE1"), rsid("rs6060535"), s20)
+ } else plot(1) # pdf must exist....

3

5 Genotype representations

The SnpMatrix class of the snpStats package is used to represent genotypes. Imputed
genotypes and their uncertainties can be represented in this scheme, but the example
does not depict this.

> if (exists("s20")) {
+ # raw bytes
+ as(smList(s20)[[1]], "matrix")[1:5,1:5]
+ # generic calls
+ as(smList(s20)[[1]], "character")[1:5,1:5]
+ # risk allele (alphabetically later nucleotide) counts
+ as(smList(s20)[[1]], "numeric")[1:5,1:5]
+ }

NA06985

rs4814683 rs6076506 rs6139074 rs1418258 rs7274499
2

2

2

2

2

4

lA/AA/BB/B8.08.59.09.510.0rs6060535CPNE1llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllNA06991
NA06993
NA06994
NA07000

1
0
0
2

2
2
2
2

1
0
0
2

1
0
0
2

2
2
2
2

6 Reducing memory footprint of integrative data

structures

When millions of genotypes are recorded, it can be cumbersome to work with all si-
multaneously in memory, and it is seldom scientiﬁcally relevant to do so. Thus a pack-
aging protocol has been established in conjunction with the getSS function to allow
chromosome-at-a-time loading of genotype data in conjunction with expression data.

To deploy the packaging protocol, use the externalize function on a “one-time” full
smlSet representation of the data, or mimic the behavior of this function by creating a
new package folder structure and populating the inst/parts with rda ﬁles representing a
partition (usually by chromosome) of the genotype SnpMatrix instances.

5


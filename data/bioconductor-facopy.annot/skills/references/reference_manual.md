Package ‘facopy.annot’

April 11, 2019

Type Package

Title Annotation for the copy number alteration association and

enrichment analyses with facopy

Version 1.2.0

Date 2014-08-27

Author David Mosen-Ansorena

Maintainer David Mosen-Ansorena <dmosen.gn@cicbiogune.es>

Import

Depends R (>= 2.10)

Description Provides facopy with genome annotation on chromosome arms,

genomic features and copy number alterations.

License GPL-3

biocViews Genome

git_url https://git.bioconductor.org/packages/facopy.annot

git_branch RELEASE_3_8

git_last_commit 63b7b0e

git_last_commit_date 2018-10-30

Date/Publication 2019-04-11

R topics documented:

.

.
.
.

.
.
.

facopy.annot-package .
.
facopy_biocarta .
.
facopy_kegg .
.
facopy_msigdb .
.
facopy_msigdbNames .
.
facopy_reactome .
hg18_armLimits .
.
.
hg18_db_gsk_bladder .
.
hg18_db_gsk_blood .
.
hg18_db_gsk_bone .
.
hg18_db_gsk_brain .
hg18_db_gsk_breast
.
hg18_db_gsk_cervix .

.
.

.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.

4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10

1

2

R topics documented:

.

.
.

.
.

.
.

.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
hg18_db_gsk_cns .
.
hg18_db_gsk_colon .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
hg18_db_gsk_connective_tissue . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
hg18_db_gsk_esophagus .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
.
hg18_db_gsk_eye .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
hg18_db_gsk_kidney .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
.
.
hg18_db_gsk_liver
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
.
hg18_db_gsk_lung .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
.
.
hg18_db_gsk_muscle .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
.
hg18_db_gsk_ovary .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
.
hg18_db_gsk_pancreas .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
.
hg18_db_gsk_pharynx .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
.
hg18_db_gsk_placenta .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
.
.
hg18_db_gsk_prostate
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
.
.
hg18_db_gsk_rectum .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
.
hg18_db_gsk_sarcoma .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
hg18_db_gsk_stomach .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
hg18_db_gsk_synovium .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
.
hg18_db_gsk_thyroid .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
.
.
hg18_db_gsk_uterus
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
.
.
hg18_db_nci60 .
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
.
.
hg18_db_tcga_blca .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
.
.
hg18_db_tcga_brca .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
.
.
hg18_db_tcga_cesc .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
.
.
hg18_db_tcga_coad .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
.
.
hg18_db_tcga_gbm .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
.
.
hg18_db_tcga_hnsc .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
.
.
hg18_db_tcga_kirc .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
.
.
hg18_db_tcga_kirp .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
.
.
hg18_db_tcga_lgg .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
.
.
hg18_db_tcga_lihc .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
.
.
hg18_db_tcga_luad .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
.
.
hg18_db_tcga_lusc .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
.
.
hg18_db_tcga_ov .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
.
.
hg18_db_tcga_prad .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
.
.
hg18_db_tcga_read .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
.
.
hg18_db_tcga_stad .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
.
.
hg18_db_tcga_thca .
.
.
hg18_db_tcga_ucec .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
hg18_feature_cancergene .
.
.
hg18_feature_ensembl
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
.
hg18_feature_lincRNA .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
.
.
hg18_feature_mirnas .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
.
.
hg18_feature_oncogene .
hg18_feature_tumorsupressor . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
hg19_armLimits .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 47
hg19_db_gsk_bladder .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
.
hg19_db_gsk_blood .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
.
hg19_db_gsk_bone .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
.
hg19_db_gsk_brain .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
hg19_db_gsk_breast
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
hg19_db_gsk_cervix .

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.

.
.
.
.
.
.
.

.
.
.
.
.
.
.

.

.

R topics documented:

3

.

.
.

.
.

.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
hg19_db_gsk_cns .
.
hg19_db_gsk_colon .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
hg19_db_gsk_connective_tissue . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
hg19_db_gsk_esophagus .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
.
hg19_db_gsk_eye .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
.
hg19_db_gsk_kidney .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56
.
.
.
.
hg19_db_gsk_liver
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
.
.
hg19_db_gsk_lung .
.
.
.
.
hg19_db_gsk_muscle .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 58
.
hg19_db_gsk_ovary .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59
.
.
hg19_db_gsk_pancreas .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60
.
hg19_db_gsk_pharynx .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60
.
hg19_db_gsk_placenta .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 61
.
.
hg19_db_gsk_prostate
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62
.
.
hg19_db_gsk_rectum .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
.
.
hg19_db_gsk_sarcoma .
.
hg19_db_gsk_stomach .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64
hg19_db_gsk_synovium .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 65
.
.
hg19_db_gsk_thyroid .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
.
.
hg19_db_gsk_uterus
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
.
.
hg19_db_nci60 .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67
.
.
hg19_db_tcga_blca .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 68
.
.
.
hg19_db_tcga_brca .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 69
.
.
.
hg19_db_tcga_cesc .
.
.
.
hg19_db_tcga_coad .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 69
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 70
.
.
hg19_db_tcga_gbm .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 71
.
.
hg19_db_tcga_hnsc .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72
.
.
hg19_db_tcga_kirc .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72
.
.
hg19_db_tcga_kirp .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73
.
.
hg19_db_tcga_lgg .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74
.
.
hg19_db_tcga_lihc .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 75
.
.
hg19_db_tcga_luad .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 75
.
.
hg19_db_tcga_lusc .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 76
.
.
hg19_db_tcga_ov .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 77
.
.
hg19_db_tcga_prad .
.
.
.
hg19_db_tcga_read .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 78
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 78
.
.
hg19_db_tcga_stad .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 79
.
.
hg19_db_tcga_thca .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 80
.
.
.
hg19_db_tcga_ucec .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 81
hg19_feature_cancergene .
.
.
hg19_feature_ensembl
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 82
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 83
.
hg19_feature_lincRNA .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 84
.
.
.
hg19_feature_mirnas .
hg19_feature_oncogene .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 85
.
.
hg19_feature_tumorsupressor . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 86
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 87
mm8_armLimits
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 87
mm8_feature_ensembl
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 88
mm8_feature_mirnas .

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
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

90

4

facopy_biocarta

facopy.annot-package

Companion annotation package for facopy

Description

Provides facopy with genome annotation on chromosome arms, genomic features and copy number
alterations.

Details

Package:
Type:
Version:
Date:
License: GPL-3

facopy.annot
Package
0.99.0
2014-08-27

Author(s)

David Mosen-Ansorena

facopy_biocarta

Biocarta Pathways with symbol identiﬁers

Description

Modiﬁcation of the biocarta object in graphite package, in order to list gene symbols instead of
the native identiﬁers.

Source

graphite R package.

References

Sales, G., Calura, E., Cavalieri, D. & Romualdi, C. graphite - a Bioconductor package to convert
pathway topology to gene network. BMC Bioinformatics 13, 20 (2012).

facopy_kegg

5

facopy_kegg

kegg Pathways with symbol identiﬁers

Description

Modiﬁcation of the kegg object in graphite package, in order to list gene symbols instead of the
native identiﬁers.

Source

graphite R package.

References

Sales, G., Calura, E., Cavalieri, D. & Romualdi, C. graphite - a Bioconductor package to convert
pathway topology to gene network. BMC Bioinformatics 13, 20 (2012).

facopy_msigdb

facopy MSigDB Data

Description

Contains gene sets, classiﬁed into collections.

Source

MSigDB

References

Liberzon, A. et al. Molecular signatures database (MSigDB) 3.0. Bioinformatics 27, 1739-40
(2011).

facopy_msigdbNames

facopy MSigDB Data Names

Description

Contains the names of gene sets, classiﬁed into collections.

Source

MSigDB

References

Liberzon, A. et al. Molecular signatures database (MSigDB) 3.0. Bioinformatics 27, 1739-40
(2011).

6

hg18_armLimits

facopy_reactome

reactome Pathways with symbol identiﬁers

Description

Modiﬁcation of the reactome object in graphite package, in order to list gene symbols instead of
the native identiﬁers.

Source

graphite R package.

References

Sales, G., Calura, E., Cavalieri, D. & Romualdi, C. graphite - a Bioconductor package to convert
pathway topology to gene network. BMC Bioinformatics 13, 20 (2012).

hg18_armLimits

hg18_armLimits

Description

Chromosome arm upper limits (in base pairs) for the hg18 genome build.

Usage

data(hg18_armLimits)

Format

A data frame with 48 observations on the following 2 variables.

chr_q_arm A factor with levels 1p 1q 2p 2q 3p 3q 4p 4q 5p 5q 6p 6q 7p 7q 8p 8q 9p 9q 10p 10q
11p 11q 12p 12q 13p 13q 14p 14q 15p 15q 16p 16q 17p 17q 18p 18q 19p 19q 20p 20q 21p
21q 22p 22q Xp Xq Yp Yq

limit A numeric vector

Examples

data(hg18_armLimits)

hg18_db_gsk_bladder

7

hg18_db_gsk_bladder

hg18_db_gsk_bladder

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_bladder)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_bladder)

hg18_db_gsk_blood

hg18_db_gsk_blood

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_blood)

8

Format

hg18_db_gsk_bone

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_blood)

hg18_db_gsk_bone

hg18_db_gsk_bone

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_bone)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

hg18_db_gsk_brain

References

9

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_bone)

hg18_db_gsk_brain

hg18_db_gsk_brain

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_brain)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_brain)

10

hg18_db_gsk_cervix

hg18_db_gsk_breast

hg18_db_gsk_breast

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_breast)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_breast)

hg18_db_gsk_cervix

hg18_db_gsk_cervix

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_cervix)

hg18_db_gsk_cns

Format

11

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_cervix)

hg18_db_gsk_cns

hg18_db_gsk_cns

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_cns)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

12

References

hg18_db_gsk_colon

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_cns)

hg18_db_gsk_colon

hg18_db_gsk_colon

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_colon)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_colon)

hg18_db_gsk_connective_tissue

13

hg18_db_gsk_connective_tissue

hg18_db_gsk_connective_tissue

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_connective_tissue)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_connective_tissue)

hg18_db_gsk_esophagus hg18_db_gsk_esophagus

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_esophagus)

14

Format

hg18_db_gsk_eye

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_esophagus)

hg18_db_gsk_eye

hg18_db_gsk_eye

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_eye)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

hg18_db_gsk_kidney

References

15

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_eye)

hg18_db_gsk_kidney

hg18_db_gsk_kidney

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_kidney)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_kidney)

16

hg18_db_gsk_lung

hg18_db_gsk_liver

hg18_db_gsk_liver

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_liver)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_liver)

hg18_db_gsk_lung

hg18_db_gsk_lung

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_lung)

hg18_db_gsk_muscle

Format

17

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_lung)

hg18_db_gsk_muscle

hg18_db_gsk_muscle

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_muscle)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

18

References

hg18_db_gsk_ovary

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_muscle)

hg18_db_gsk_ovary

hg18_db_gsk_ovary

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_ovary)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_ovary)

hg18_db_gsk_pancreas

19

hg18_db_gsk_pancreas

hg18_db_gsk_pancreas

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_pancreas)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_pancreas)

hg18_db_gsk_pharynx

hg18_db_gsk_pharynx

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_pharynx)

20

Format

hg18_db_gsk_placenta

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_pharynx)

hg18_db_gsk_placenta

hg18_db_gsk_placenta

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_placenta)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

hg18_db_gsk_prostate

References

21

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_placenta)

hg18_db_gsk_prostate

hg18_db_gsk_prostate

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_prostate)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_prostate)

22

hg18_db_gsk_sarcoma

hg18_db_gsk_rectum

hg18_db_gsk_rectum

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_rectum)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_rectum)

hg18_db_gsk_sarcoma

hg18_db_gsk_sarcoma

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_sarcoma)

hg18_db_gsk_stomach

Format

23

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_sarcoma)

hg18_db_gsk_stomach

hg18_db_gsk_stomach

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_stomach)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

24

References

hg18_db_gsk_synovium

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_stomach)

hg18_db_gsk_synovium

hg18_db_gsk_synovium

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_synovium)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_synovium)

hg18_db_gsk_thyroid

25

hg18_db_gsk_thyroid

hg18_db_gsk_thyroid

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_thyroid)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_thyroid)

hg18_db_gsk_uterus

hg18_db_gsk_uterus

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_gsk_uterus)

26

Format

hg18_db_nci60

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_gsk_uterus)

hg18_db_nci60

hg18_db_nci60

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_nci60)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

hg18_db_tcga_blca

References

27

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_nci60)

hg18_db_tcga_blca

hg18_db_tcga_blca

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_blca)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_blca)

28

hg18_db_tcga_cesc

hg18_db_tcga_brca

hg18_db_tcga_brca

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_brca)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_brca)

hg18_db_tcga_cesc

hg18_db_tcga_cesc

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_cesc)

hg18_db_tcga_coad

Format

29

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_cesc)

hg18_db_tcga_coad

hg18_db_tcga_coad

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_coad)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

30

References

hg18_db_tcga_gbm

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_coad)

hg18_db_tcga_gbm

hg18_db_tcga_gbm

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_gbm)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_gbm)

hg18_db_tcga_hnsc

31

hg18_db_tcga_hnsc

hg18_db_tcga_hnsc

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_hnsc)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_hnsc)

hg18_db_tcga_kirc

hg18_db_tcga_kirc

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_kirc)

32

Format

hg18_db_tcga_kirp

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_kirc)

hg18_db_tcga_kirp

hg18_db_tcga_kirp

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_kirp)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

hg18_db_tcga_lgg

References

33

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_kirp)

hg18_db_tcga_lgg

hg18_db_tcga_lgg

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_lgg)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_lgg)

34

hg18_db_tcga_luad

hg18_db_tcga_lihc

hg18_db_tcga_lihc

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_lihc)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_lihc)

hg18_db_tcga_luad

hg18_db_tcga_luad

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_luad)

hg18_db_tcga_lusc

Format

35

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_luad)

hg18_db_tcga_lusc

hg18_db_tcga_lusc

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_lusc)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

36

References

hg18_db_tcga_ov

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_lusc)

hg18_db_tcga_ov

hg18_db_tcga_ov

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_ov)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_ov)

hg18_db_tcga_prad

37

hg18_db_tcga_prad

hg18_db_tcga_prad

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_prad)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_prad)

hg18_db_tcga_read

hg18_db_tcga_read

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_read)

38

Format

hg18_db_tcga_stad

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_read)

hg18_db_tcga_stad

hg18_db_tcga_stad

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_stad)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

hg18_db_tcga_thca

References

39

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_stad)

hg18_db_tcga_thca

hg18_db_tcga_thca

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_thca)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_thca)

40

hg18_feature_cancergene

hg18_db_tcga_ucec

hg18_db_tcga_ucec

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg18_db_tcga_ucec)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg18_db_tcga_ucec)

hg18_feature_cancergene

hg18_feature_cancergene

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(hg18_feature_cancergene)

hg18_feature_ensembl

Format

41

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

Source

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(hg18_feature_cancergene)

hg18_feature_ensembl

hg18_feature_ensembl

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(hg18_feature_ensembl)

42

Format

hg18_feature_lincRNA

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

Source

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(hg18_feature_ensembl)

hg18_feature_lincRNA

hg18_feature_lincRNA

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(hg18_feature_lincRNA)

hg18_feature_mirnas

Format

43

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

Source

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(hg18_feature_lincRNA)

hg18_feature_mirnas

hg18_feature_mirnas

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(hg18_feature_mirnas)

44

Format

hg18_feature_oncogene

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

Source

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(hg18_feature_mirnas)

hg18_feature_oncogene hg18_feature_oncogene

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(hg18_feature_oncogene)

hg18_feature_tumorsupressor

45

Format

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

Source

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(hg18_feature_oncogene)

hg18_feature_tumorsupressor

hg18_feature_tumorsupressor

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(hg18_feature_tumorsupressor)

46

Format

hg19_armLimits

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

Source

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(hg18_feature_tumorsupressor)

hg19_armLimits

hg19_armLimits

Description

Chromosome arm upper limits (in base pairs) for the hg19 genome build.

Usage

data(hg19_armLimits)

hg19_db_gsk_bladder

Format

47

A data frame with 48 observations on the following 2 variables.

chr_q_arm A factor with levels 1p 1q 2p 2q 3p 3q 4p 4q 5p 5q 6p 6q 7p 7q 8p 8q 9p 9q 10p 10q
11p 11q 12p 12q 13p 13q 14p 14q 15p 15q 16p 16q 17p 17q 18p 18q 19p 19q 20p 20q 21p
21q 22p 22q Xp Xq Yp Yq

limit A numeric vector

Examples

data(hg19_armLimits)

hg19_db_gsk_bladder

hg19_db_gsk_bladder

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_bladder)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_bladder)

48

hg19_db_gsk_bone

hg19_db_gsk_blood

hg19_db_gsk_blood

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_blood)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_blood)

hg19_db_gsk_bone

hg19_db_gsk_bone

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_bone)

hg19_db_gsk_brain

Format

49

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_bone)

hg19_db_gsk_brain

hg19_db_gsk_brain

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_brain)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

50

References

hg19_db_gsk_breast

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_brain)

hg19_db_gsk_breast

hg19_db_gsk_breast

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_breast)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_breast)

hg19_db_gsk_cervix

51

hg19_db_gsk_cervix

hg19_db_gsk_cervix

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_cervix)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_cervix)

hg19_db_gsk_cns

hg19_db_gsk_cns

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_cns)

52

Format

hg19_db_gsk_colon

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_cns)

hg19_db_gsk_colon

hg19_db_gsk_colon

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_colon)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

hg19_db_gsk_connective_tissue

53

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_colon)

hg19_db_gsk_connective_tissue

hg19_db_gsk_connective_tissue

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_connective_tissue)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_connective_tissue)

54

hg19_db_gsk_eye

hg19_db_gsk_esophagus hg19_db_gsk_esophagus

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_esophagus)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_esophagus)

hg19_db_gsk_eye

hg19_db_gsk_eye

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_eye)

hg19_db_gsk_kidney

Format

55

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_eye)

hg19_db_gsk_kidney

hg19_db_gsk_kidney

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_kidney)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

56

References

hg19_db_gsk_liver

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_kidney)

hg19_db_gsk_liver

hg19_db_gsk_liver

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_liver)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_liver)

hg19_db_gsk_lung

57

hg19_db_gsk_lung

hg19_db_gsk_lung

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_lung)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_lung)

hg19_db_gsk_muscle

hg19_db_gsk_muscle

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_muscle)

58

Format

hg19_db_gsk_ovary

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_muscle)

hg19_db_gsk_ovary

hg19_db_gsk_ovary

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_ovary)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

hg19_db_gsk_pancreas

References

59

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_ovary)

hg19_db_gsk_pancreas

hg19_db_gsk_pancreas

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_pancreas)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_pancreas)

60

hg19_db_gsk_placenta

hg19_db_gsk_pharynx

hg19_db_gsk_pharynx

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_pharynx)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_pharynx)

hg19_db_gsk_placenta

hg19_db_gsk_placenta

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_placenta)

hg19_db_gsk_prostate

Format

61

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_placenta)

hg19_db_gsk_prostate

hg19_db_gsk_prostate

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_prostate)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

62

References

hg19_db_gsk_rectum

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_prostate)

hg19_db_gsk_rectum

hg19_db_gsk_rectum

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_rectum)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_rectum)

hg19_db_gsk_sarcoma

63

hg19_db_gsk_sarcoma

hg19_db_gsk_sarcoma

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_sarcoma)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_sarcoma)

hg19_db_gsk_stomach

hg19_db_gsk_stomach

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_stomach)

64

Format

hg19_db_gsk_synovium

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_stomach)

hg19_db_gsk_synovium

hg19_db_gsk_synovium

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_synovium)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

hg19_db_gsk_thyroid

References

65

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_synovium)

hg19_db_gsk_thyroid

hg19_db_gsk_thyroid

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_thyroid)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_thyroid)

66

hg19_db_nci60

hg19_db_gsk_uterus

hg19_db_gsk_uterus

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_gsk_uterus)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_gsk_uterus)

hg19_db_nci60

hg19_db_nci60

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_nci60)

hg19_db_tcga_blca

Format

67

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_nci60)

hg19_db_tcga_blca

hg19_db_tcga_blca

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_blca)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

68

References

hg19_db_tcga_brca

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_blca)

hg19_db_tcga_brca

hg19_db_tcga_brca

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_brca)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_brca)

hg19_db_tcga_cesc

69

hg19_db_tcga_cesc

hg19_db_tcga_cesc

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_cesc)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_cesc)

hg19_db_tcga_coad

hg19_db_tcga_coad

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_coad)

70

Format

hg19_db_tcga_gbm

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_coad)

hg19_db_tcga_gbm

hg19_db_tcga_gbm

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_gbm)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

hg19_db_tcga_hnsc

References

71

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_gbm)

hg19_db_tcga_hnsc

hg19_db_tcga_hnsc

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_hnsc)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_hnsc)

72

hg19_db_tcga_kirp

hg19_db_tcga_kirc

hg19_db_tcga_kirc

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_kirc)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_kirc)

hg19_db_tcga_kirp

hg19_db_tcga_kirp

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_kirp)

hg19_db_tcga_lgg

Format

73

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_kirp)

hg19_db_tcga_lgg

hg19_db_tcga_lgg

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_lgg)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

74

References

hg19_db_tcga_lihc

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_lgg)

hg19_db_tcga_lihc

hg19_db_tcga_lihc

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_lihc)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_lihc)

hg19_db_tcga_luad

75

hg19_db_tcga_luad

hg19_db_tcga_luad

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_luad)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_luad)

hg19_db_tcga_lusc

hg19_db_tcga_lusc

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_lusc)

76

Format

hg19_db_tcga_ov

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_lusc)

hg19_db_tcga_ov

hg19_db_tcga_ov

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_ov)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

hg19_db_tcga_prad

References

77

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_ov)

hg19_db_tcga_prad

hg19_db_tcga_prad

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_prad)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_prad)

78

hg19_db_tcga_stad

hg19_db_tcga_read

hg19_db_tcga_read

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_read)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_read)

hg19_db_tcga_stad

hg19_db_tcga_stad

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_stad)

hg19_db_tcga_thca

Format

79

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_stad)

hg19_db_tcga_thca

hg19_db_tcga_thca

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_thca)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

80

References

hg19_db_tcga_ucec

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_thca)

hg19_db_tcga_ucec

hg19_db_tcga_ucec

Description

Copy number alteration frequencies for the corresponding genome build, database and dataset.
Naming format: [genome][build]_db_[database]_[dataset].

Usage

data(hg19_db_tcga_ucec)

Format

A data frame with ampliﬁcation and/or deletion frequencies for different genomic regions.

chr A factor with levels 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X

pos_st A numeric vector

pos_en A numeric vector

type A factor that comprises levels amp del or just one of them

freq A numeric vector

Source

Source: Cancer Genome WorkBench. Reformatted, summarized and possibly lifted to another
genome build.

References

Zhang, J. et al. Systematic analysis of genetic alterations in tumors using Cancer Genome Work-
Bench (CGWB). Genome Res. 17, 1111-7 (2007).

Examples

data(hg19_db_tcga_ucec)

hg19_feature_cancergene

81

hg19_feature_cancergene

hg19_feature_cancergene

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(hg19_feature_cancergene)

Format

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

Source

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(hg19_feature_cancergene)

82

hg19_feature_ensembl

hg19_feature_ensembl

hg19_feature_ensembl

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(hg19_feature_ensembl)

Format

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

Source

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(hg19_feature_ensembl)

hg19_feature_lincRNA

83

hg19_feature_lincRNA

hg19_feature_lincRNA

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(hg19_feature_lincRNA)

Format

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

Source

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(hg19_feature_lincRNA)

84

hg19_feature_mirnas

hg19_feature_mirnas

hg19_feature_mirnas

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(hg19_feature_mirnas)

Format

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

Source

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(hg19_feature_mirnas)

hg19_feature_oncogene

85

hg19_feature_oncogene hg19_feature_oncogene

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(hg19_feature_oncogene)

Format

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

Source

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(hg19_feature_oncogene)

86

hg19_feature_tumorsupressor

hg19_feature_tumorsupressor

hg19_feature_tumorsupressor

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(hg19_feature_tumorsupressor)

Format

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

Source

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(hg19_feature_tumorsupressor)

mm8_armLimits

87

mm8_armLimits

mm8_armLimits

Description

Chromosome arm upper limits (in base pairs) for the mm8 genome build.

Usage

data(mm8_armLimits)

Format

A data frame with 21 observations on the following 2 variables.

chr_q_arm A factor with levels 1q 2q 3q 4q 5q 6q 7q 8q 9q 10q 11q 12q 13q 14q 15q 16q 17q 18q

19q Xq Yq

limit A numeric vector

Examples

data(mm8_armLimits)

mm8_feature_ensembl

mm8_feature_ensembl

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(mm8_feature_ensembl)

Format

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

88

Source

mm8_feature_mirnas

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(mm8_feature_ensembl)

mm8_feature_mirnas

mm8_feature_mirnas

Description

Position of a collection of genomic features for the corresponding genome build.
Naming format: [genome][build]_feature_[collection].

Usage

data(mm8_feature_mirnas)

Format

A data frame with positional information on a set of genomic features.

chr Chromosome harboring the genomic feature.

bp_st Starting genomic position of the feature within the chromosome.

bp_en Ending genomic position of the feature within the chromosome.

feature Name of the genomic feature.

chr_q_arm Chromosome arm in which the genomic feature lies.

mm8_feature_mirnas

Source

89

Collections ensembl, mirna:
- Extracted from Ensembl through BioMart. In the case of mirna, the collection was ﬁlter to keep
only miRNAs.
- http://may2009.archive.ensembl.org/biomart/martview/
- http://www.ensembl.org/biomart/martview/

Collections oncogene, tumorsuppressor, cancergene, lincRNA:
- Gathered from CaSNP website’s BED ﬁles and reformatted.
- http://cistrome.dfci.harvard.edu/CaSNP/gscore/

References

Hubbard, T. The Ensembl genome database project. Nucleic Acids Res. 30, 38-41 (2002).

Durinck, S. et al. BioMart and Bioconductor: a powerful link between biological databases and
microarray data analysis. Bioinformatics 21, 3439-40 (2005).

Cao, Q. et al. CaSNP: a database for interrogating copy number alterations of cancer genome from
SNP array data. Nucleic Acids Res. 39, D968-74 (2011).

Examples

data(mm8_feature_mirnas)

Index

∗Topic datasets

facopy_biocarta, 4
facopy_kegg, 5
facopy_msigdb, 5
facopy_msigdbNames, 5
facopy_reactome, 6
hg18_armLimits, 6
hg18_db_gsk_bladder, 7
hg18_db_gsk_blood, 7
hg18_db_gsk_bone, 8
hg18_db_gsk_brain, 9
hg18_db_gsk_breast, 10
hg18_db_gsk_cervix, 10
hg18_db_gsk_cns, 11
hg18_db_gsk_colon, 12
hg18_db_gsk_connective_tissue, 13
hg18_db_gsk_esophagus, 13
hg18_db_gsk_eye, 14
hg18_db_gsk_kidney, 15
hg18_db_gsk_liver, 16
hg18_db_gsk_lung, 16
hg18_db_gsk_muscle, 17
hg18_db_gsk_ovary, 18
hg18_db_gsk_pancreas, 19
hg18_db_gsk_pharynx, 19
hg18_db_gsk_placenta, 20
hg18_db_gsk_prostate, 21
hg18_db_gsk_rectum, 22
hg18_db_gsk_sarcoma, 22
hg18_db_gsk_stomach, 23
hg18_db_gsk_synovium, 24
hg18_db_gsk_thyroid, 25
hg18_db_gsk_uterus, 25
hg18_db_nci60, 26
hg18_db_tcga_blca, 27
hg18_db_tcga_brca, 28
hg18_db_tcga_cesc, 28
hg18_db_tcga_coad, 29
hg18_db_tcga_gbm, 30
hg18_db_tcga_hnsc, 31
hg18_db_tcga_kirc, 31
hg18_db_tcga_kirp, 32
hg18_db_tcga_lgg, 33

90

hg18_db_tcga_lihc, 34
hg18_db_tcga_luad, 34
hg18_db_tcga_lusc, 35
hg18_db_tcga_ov, 36
hg18_db_tcga_prad, 37
hg18_db_tcga_read, 37
hg18_db_tcga_stad, 38
hg18_db_tcga_thca, 39
hg18_db_tcga_ucec, 40
hg18_feature_cancergene, 40
hg18_feature_ensembl, 41
hg18_feature_lincRNA, 42
hg18_feature_mirnas, 43
hg18_feature_oncogene, 44
hg18_feature_tumorsupressor, 45
hg19_armLimits, 46
hg19_db_gsk_bladder, 47
hg19_db_gsk_blood, 48
hg19_db_gsk_bone, 48
hg19_db_gsk_brain, 49
hg19_db_gsk_breast, 50
hg19_db_gsk_cervix, 51
hg19_db_gsk_cns, 51
hg19_db_gsk_colon, 52
hg19_db_gsk_connective_tissue, 53
hg19_db_gsk_esophagus, 54
hg19_db_gsk_eye, 54
hg19_db_gsk_kidney, 55
hg19_db_gsk_liver, 56
hg19_db_gsk_lung, 57
hg19_db_gsk_muscle, 57
hg19_db_gsk_ovary, 58
hg19_db_gsk_pancreas, 59
hg19_db_gsk_pharynx, 60
hg19_db_gsk_placenta, 60
hg19_db_gsk_prostate, 61
hg19_db_gsk_rectum, 62
hg19_db_gsk_sarcoma, 63
hg19_db_gsk_stomach, 63
hg19_db_gsk_synovium, 64
hg19_db_gsk_thyroid, 65
hg19_db_gsk_uterus, 66
hg19_db_nci60, 66

INDEX

91

hg19_db_tcga_blca, 67
hg19_db_tcga_brca, 68
hg19_db_tcga_cesc, 69
hg19_db_tcga_coad, 69
hg19_db_tcga_gbm, 70
hg19_db_tcga_hnsc, 71
hg19_db_tcga_kirc, 72
hg19_db_tcga_kirp, 72
hg19_db_tcga_lgg, 73
hg19_db_tcga_lihc, 74
hg19_db_tcga_luad, 75
hg19_db_tcga_lusc, 75
hg19_db_tcga_ov, 76
hg19_db_tcga_prad, 77
hg19_db_tcga_read, 78
hg19_db_tcga_stad, 78
hg19_db_tcga_thca, 79
hg19_db_tcga_ucec, 80
hg19_feature_cancergene, 81
hg19_feature_ensembl, 82
hg19_feature_lincRNA, 83
hg19_feature_mirnas, 84
hg19_feature_oncogene, 85
hg19_feature_tumorsupressor, 86
mm8_armLimits, 87
mm8_feature_ensembl, 87
mm8_feature_mirnas, 88

∗Topic package

facopy.annot-package, 4

facopy.annot-package, 4
facopy_biocarta, 4
facopy_kegg, 5
facopy_msigdb, 5
facopy_msigdbNames, 5
facopy_reactome, 6

hg18_armLimits, 6
hg18_db_gsk_bladder, 7
hg18_db_gsk_blood, 7
hg18_db_gsk_bone, 8
hg18_db_gsk_brain, 9
hg18_db_gsk_breast, 10
hg18_db_gsk_cervix, 10
hg18_db_gsk_cns, 11
hg18_db_gsk_colon, 12
hg18_db_gsk_connective_tissue, 13
hg18_db_gsk_esophagus, 13
hg18_db_gsk_eye, 14
hg18_db_gsk_kidney, 15
hg18_db_gsk_liver, 16
hg18_db_gsk_lung, 16
hg18_db_gsk_muscle, 17

hg18_db_gsk_ovary, 18
hg18_db_gsk_pancreas, 19
hg18_db_gsk_pharynx, 19
hg18_db_gsk_placenta, 20
hg18_db_gsk_prostate, 21
hg18_db_gsk_rectum, 22
hg18_db_gsk_sarcoma, 22
hg18_db_gsk_stomach, 23
hg18_db_gsk_synovium, 24
hg18_db_gsk_thyroid, 25
hg18_db_gsk_uterus, 25
hg18_db_nci60, 26
hg18_db_tcga_blca, 27
hg18_db_tcga_brca, 28
hg18_db_tcga_cesc, 28
hg18_db_tcga_coad, 29
hg18_db_tcga_gbm, 30
hg18_db_tcga_hnsc, 31
hg18_db_tcga_kirc, 31
hg18_db_tcga_kirp, 32
hg18_db_tcga_lgg, 33
hg18_db_tcga_lihc, 34
hg18_db_tcga_luad, 34
hg18_db_tcga_lusc, 35
hg18_db_tcga_ov, 36
hg18_db_tcga_prad, 37
hg18_db_tcga_read, 37
hg18_db_tcga_stad, 38
hg18_db_tcga_thca, 39
hg18_db_tcga_ucec, 40
hg18_feature_cancergene, 40
hg18_feature_ensembl, 41
hg18_feature_lincRNA, 42
hg18_feature_mirnas, 43
hg18_feature_oncogene, 44
hg18_feature_tumorsupressor, 45
hg19_armLimits, 46
hg19_db_gsk_bladder, 47
hg19_db_gsk_blood, 48
hg19_db_gsk_bone, 48
hg19_db_gsk_brain, 49
hg19_db_gsk_breast, 50
hg19_db_gsk_cervix, 51
hg19_db_gsk_cns, 51
hg19_db_gsk_colon, 52
hg19_db_gsk_connective_tissue, 53
hg19_db_gsk_esophagus, 54
hg19_db_gsk_eye, 54
hg19_db_gsk_kidney, 55
hg19_db_gsk_liver, 56
hg19_db_gsk_lung, 57
hg19_db_gsk_muscle, 57

92

INDEX

hg19_db_gsk_ovary, 58
hg19_db_gsk_pancreas, 59
hg19_db_gsk_pharynx, 60
hg19_db_gsk_placenta, 60
hg19_db_gsk_prostate, 61
hg19_db_gsk_rectum, 62
hg19_db_gsk_sarcoma, 63
hg19_db_gsk_stomach, 63
hg19_db_gsk_synovium, 64
hg19_db_gsk_thyroid, 65
hg19_db_gsk_uterus, 66
hg19_db_nci60, 66
hg19_db_tcga_blca, 67
hg19_db_tcga_brca, 68
hg19_db_tcga_cesc, 69
hg19_db_tcga_coad, 69
hg19_db_tcga_gbm, 70
hg19_db_tcga_hnsc, 71
hg19_db_tcga_kirc, 72
hg19_db_tcga_kirp, 72
hg19_db_tcga_lgg, 73
hg19_db_tcga_lihc, 74
hg19_db_tcga_luad, 75
hg19_db_tcga_lusc, 75
hg19_db_tcga_ov, 76
hg19_db_tcga_prad, 77
hg19_db_tcga_read, 78
hg19_db_tcga_stad, 78
hg19_db_tcga_thca, 79
hg19_db_tcga_ucec, 80
hg19_feature_cancergene, 81
hg19_feature_ensembl, 82
hg19_feature_lincRNA, 83
hg19_feature_mirnas, 84
hg19_feature_oncogene, 85
hg19_feature_tumorsupressor, 86

mm8_armLimits, 87
mm8_feature_ensembl, 87
mm8_feature_mirnas, 88


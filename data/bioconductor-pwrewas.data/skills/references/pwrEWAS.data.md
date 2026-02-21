pwrEWAS.data: Reference data accompa-
nying pwrEWAS

Stefan Graw, Devin C. Koestler

5 November 2019

Abstract

Package

This package provides reference data required for pwrEWAS. pwrEWAS is a user-friendly tool
to estimate power in EWAS as a function of sample and eﬀect size for two-group comparisons
of DNAm (e.g., case vs control, exposed vs non-exposed, etc.).

pwrEWAS.data 1.0.0

Contents

Data .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2

pwrEWAS.data: Reference data accompanying pwrEWAS

Data

The following data sets were used to create the reference data. Therefore, for each tissue
type CpG-speciﬁc means and variances were estimated (ˆµj = 1/N PN
j =
1/(N − 1) PN
i=1(βi,j − ˆµj)2), where βi,j represents the methylation β-value for CpG j={1,.,J}
in subject i={1,.,N}.

i=1 βi,j and σ2

Accession Number
Tissue Type
GSE92767
Saliva
GSE42372
Lymphoma
GSE62733
Placenta
GSE61258
Liver
GSE77718
Colon
GSE42861
Blood (Adults)
GSE83334
Blood (Children)
Blood (Newborns)
GSE82273
Cord-blood (whole blood) GSE69176
GSE110128
Cord-blood (PBMC)
GSE67170
Adult (PBMC)
GSE114753
Sperm

Subjects within GSE-ID limited to Reference

disease state: non-HIV lymphoma
health state: Normal
diseasestatus: Control
disease state: Normal
subject: Normal
age: 5 years

(Hong et al., 2017)
(Matsunaga et al., 2014)
(Kawai et al., 2015)
(Horvath et al., 2014)
(McInnes et al., 2017)
(Kular et al., 2018; Y. Liu et al., 2013)
(Urdinguio et al., 2016)
(Markunas et al., 2016)

cord blood
disease state: control
control

(Langie et al., 2018)
(Y. H. Zhang et al., 2018)
(Jenkins et al., 2017)

2


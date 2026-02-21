Package ‘geneLenDataBase’

Title Lengths of mRNA transcripts for a number of genomes

February 12, 2026

Version 1.46.0

Date 2024-06-08

Description Length of mRNA transcripts for a number of genomes and gene ID

formats, largely based on UCSC table browser. Data objects are provided as
individual pieces of information to be retrieved and loaded. A variety of
different gene identifiers and genomes is supported to ensure wide
applicability.

Depends R (>= 2.11.0)

Imports utils, rtracklayer, GenomicFeatures, txdbmaker

URL https://github.com/federicomarini/geneLenDataBase

BugReports https://github.com/federicomarini/geneLenDataBase/issues
License LGPL (>= 2)

biocViews ExperimentData, Genome

RoxygenNote 7.3.1

Encoding UTF-8

git_url https://git.bioconductor.org/packages/geneLenDataBase

git_branch RELEASE_3_22

git_last_commit 0bae7f6

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Author Matthew Young [aut],

Nadia Davidson [aut],
Federico Marini [ctb, cre] (ORCID:
<https://orcid.org/0000-0003-3252-7758>)
Maintainer Federico Marini <marinif@uni-mainz.de>

Contents

anoCar1.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
anoCar1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
anoCar1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

8
9
9

1

2

Contents

anoGam1.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
anoGam1.geneid.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
anoGam1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
apiMel1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
apiMel2.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
apiMel2.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
apiMel2.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
aplCal1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
bosTau2.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
bosTau2.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
bosTau2.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
bosTau2.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
bosTau2.sgpGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
bosTau3.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
bosTau3.geneid.LENGTH .
bosTau3.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
bosTau3.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
bosTau3.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
bosTau3.sgpGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
bosTau4.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
bosTau4.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
bosTau4.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
bosTau4.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
bosTau4.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
braFlo1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
caeJap1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
caePb1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
caePb2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
caeRem2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
caeRem3.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
calJac1.genscan.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
calJac1.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
calJac1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
canFam1.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
canFam1.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
canFam1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
canFam1.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
canFam1.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
canFam1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
canFam2.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
canFam2.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
canFam2.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
canFam2.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
canFam2.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
canFam2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
cavPor3.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
cavPor3.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
cavPor3.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
cavPor3.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
cb1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
cb3.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
ce2.geneid.LENGTH .

.

.

Contents

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

ce2.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
ce2.refGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
ce4.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
ce4.refGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
ce4.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
ce6.ensGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
ce6.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
ce6.refGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
ce6.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
ci1.geneSymbol.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
ci1.refGene.LENGTH .
ci1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
ci2.ensGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
ci2.geneSymbol.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
ci2.refGene.LENGTH .
ci2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
danRer3.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
danRer3.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
danRer3.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
danRer4.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
danRer4.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
danRer4.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
danRer4.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 47
danRer4.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 47
danRer5.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
danRer5.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
danRer5.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
danRer5.vegaGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
danRer5.vegaPseudoGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
danRer6.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
danRer6.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
danRer6.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
danRer6.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
dm1.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
dm1.genscan.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
dm1.refGene.LENGTH .
dm2.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
. .
.
dm2.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
dm2.genscan.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
dm2.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
dm2.refGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56
dm3.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56
dm3.nscanPasaGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
dm3.refGene.LENGTH .
downloadLengthFromUCSC . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 58
dp2.genscan.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59
dp2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60
.
dp3.geneid.LENGTH .
. .
dp3.genscan.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60
dp3.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 61
droAna1.geneid.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 61
droAna1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62

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

Contents

droAna1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62
droAna2.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
droAna2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
droEre1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64
droEre1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64
droGri1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 65
droGri1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 65
droMoj1.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
droMoj1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
droMoj1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67
droMoj2.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67
droMoj2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 68
droPer1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 68
droPer1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 69
droSec1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 69
droSec1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 70
droSim1.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 70
droSim1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 71
droSim1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 71
droVir1.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72
droVir1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72
droVir1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73
droVir2.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73
droVir2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74
droYak1.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74
droYak1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 75
droYak1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 75
droYak2.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 76
droYak2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 76
equCab1.geneid.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 77
equCab1.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 77
equCab1.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 78
equCab1.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 78
equCab1.sgpGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 79
equCab2.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 79
equCab2.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 80
equCab2.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 80
equCab2.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 81
equCab2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 81
felCat3.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 82
felCat3.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 82
felCat3.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 83
felCat3.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 83
felCat3.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 84
felCat3.refGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 84
felCat3.sgpGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 85
felCat3.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 85
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 86
fr1.ensGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 86
fr1.genscan.LENGTH .
.
fr2.ensGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 87
galGal2.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 87
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 88
galGal2.geneid.LENGTH .

.
.
.

Contents

5

.

galGal2.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 88
galGal2.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 89
galGal2.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 89
galGal2.sgpGene.LENGTH . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 90
galGal3.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 90
galGal3.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 91
galGal3.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 91
galGal3.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 92
galGal3.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 92
galGal3.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 93
gasAcu1.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 93
gasAcu1.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 94
.
geneLenDatabase-pkg .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 94
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 95
hg16.acembly.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 95
hg16.ensGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 96
hg16.exoniphy.LENGTH .
hg16.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 96
.
hg16.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 97
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 97
hg16.genscan.LENGTH .
hg16.knownGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 98
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 98
hg16.refGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 99
hg16.sgpGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 99
hg17.acembly.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 100
.
hg17.acescan.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 100
hg17.ccdsGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 101
hg17.ensGene.LENGTH .
hg17.exoniphy.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 101
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 102
.
hg17.geneid.LENGTH .
hg17.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 102
hg17.genscan.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 103
hg17.knownGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 103
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 104
hg17.refGene.LENGTH .
hg17.sgpGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 104
hg17.vegaGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 105
hg17.vegaPseudoGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 105
hg17.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 106
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 106
hg18.acembly.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 107
hg18.acescan.LENGTH .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 107
hg18.ccdsGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 108
hg18.ensGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 108
hg18.exoniphy.LENGTH .
hg18.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 109
.
hg18.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 109
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 110
hg18.genscan.LENGTH .
hg18.knownGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 110
hg18.knownGeneOld3.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 111
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 111
hg18.refGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 112
hg18.sgpGene.LENGTH .
hg18.sibGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 112
.
hg18.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 113
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 113
hg19.ccdsGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 114
hg19.ensGene.LENGTH .

6

Contents

.

.

hg19.exoniphy.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 114
hg19.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 115
hg19.knownGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 115
hg19.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 116
hg19.refGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 116
hg19.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 117
loxAfr3.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 117
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 118
mm7.ensGene.LENGTH .
mm7.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 118
.
mm7.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 119
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 119
mm7.genscan.LENGTH .
mm7.knownGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 120
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 120
mm7.refGene.LENGTH .
mm7.sgpGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 121
mm7.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 121
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 122
mm8.ccdsGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 122
mm8.ensGene.LENGTH .
mm8.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 123
.
mm8.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 123
mm8.genscan.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 124
mm8.knownGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 124
mm8.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 125
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 125
mm8.refGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 126
mm8.sgpGene.LENGTH .
mm8.sibGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 126
mm8.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 127
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 127
mm9.acembly.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 128
mm9.ccdsGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 128
mm9.ensGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 129
mm9.exoniphy.LENGTH .
mm9.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 129
.
mm9.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 130
mm9.genscan.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 130
mm9.knownGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 131
mm9.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 131
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 132
mm9.refGene.LENGTH .
mm9.sgpGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 132
mm9.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 133
monDom1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 133
monDom4.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 134
monDom4.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 134
monDom4.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 135
monDom4.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 135
monDom4.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 136
monDom4.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . 136
monDom5.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 137
monDom5.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 137
monDom5.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 138
monDom5.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 138
monDom5.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 139
monDom5.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . 139
ornAna1.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 140

.

Contents

7

ornAna1.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 140
ornAna1.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 141
ornAna1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 141
oryLat2.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 142
oryLat2.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 142
oryLat2.refGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 143
oryLat2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 143
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 144
panTro1.ensGene.LENGTH .
panTro1.geneid.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 144
panTro1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 145
panTro1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 145
panTro2.ensGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 146
panTro2.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 146
panTro2.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 147
panTro2.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 147
panTro2.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 148
panTro2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 148
petMar1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 149
ponAbe2.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 149
ponAbe2.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 150
ponAbe2.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 150
ponAbe2.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 151
ponAbe2.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 151
ponAbe2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 152
priPac1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 152
rheMac2.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 153
rheMac2.geneid.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 153
rheMac2.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 154
rheMac2.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 154
rheMac2.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 155
rheMac2.sgpGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 155
rheMac2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 156
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 156
rn3.ensGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 157
rn3.geneid.LENGTH .
. .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 157
rn3.geneSymbol.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 158
rn3.genscan.LENGTH .
rn3.knownGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 158
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 159
rn3.nscanGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 159
.
rn3.refGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 160
.
rn3.sgpGene.LENGTH .
rn3.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 160
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 161
rn4.ensGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 161
rn4.geneid.LENGTH .
. .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 162
rn4.geneSymbol.LENGTH .
rn4.genscan.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 162
rn4.knownGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 163
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 163
rn4.nscanGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 164
.
rn4.refGene.LENGTH .
rn4.sgpGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 164
.
rn4.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 165
sacCer1.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 165
sacCer2.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 166

.
.

.
.

.

.

8

anoCar1.ensGene.LENGTH

.
.

.
.

.
.

. .
.

strPur1.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 166
strPur1.genscan.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 167
strPur1.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 167
strPur1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 168
strPur2.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 168
strPur2.genscan.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 169
strPur2.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 169
strPur2.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 170
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 170
supportedGeneIDs
.
supportedGenomes .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 171
taeGut1.ensGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 171
taeGut1.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 172
taeGut1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 172
taeGut1.nscanGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 173
taeGut1.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 173
taeGut1.xenoRefGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 174
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 174
tetNig1.ensGene.LENGTH . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 175
tetNig1.geneid.LENGTH .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 175
tetNig1.genscan.LENGTH . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 176
tetNig1.nscanGene.LENGTH .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 176
tetNig2.ensGene.LENGTH . .
unfactor .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 177
.
xenTro1.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 178
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 178
xenTro2.ensGene.LENGTH .
xenTro2.geneSymbol.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 179
xenTro2.genscan.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 179
xenTro2.refGene.LENGTH . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 180

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

181

anoCar1.ensGene.LENGTH

Transcript length data for the organism anoCar

Description

anoCar1.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(anoCar1, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(anoCar1.ensGene.LENGTH)
head(anoCar1.ensGene.LENGTH)

anoCar1.genscan.LENGTH

9

anoCar1.genscan.LENGTH

Transcript length data for the organism anoCar

Description

anoCar1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(anoCar1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(anoCar1.genscan.LENGTH)
head(anoCar1.genscan.LENGTH)

anoCar1.xenoRefGene.LENGTH

Transcript length data for the organism anoCar

Description

anoCar1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(anoCar1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(anoCar1.xenoRefGene.LENGTH)
head(anoCar1.xenoRefGene.LENGTH)

10

anoGam1.geneid.LENGTH

anoGam1.ensGene.LENGTH

Transcript length data for the organism anoGam

Description

anoGam1.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(anoGam1, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(anoGam1.ensGene.LENGTH)
head(anoGam1.ensGene.LENGTH)

anoGam1.geneid.LENGTH Transcript length data for the organism anoGam

Description

anoGam1.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(anoGam1, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(anoGam1.geneid.LENGTH)
head(anoGam1.geneid.LENGTH)

anoGam1.genscan.LENGTH

11

anoGam1.genscan.LENGTH

Transcript length data for the organism anoGam

Description

anoGam1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(anoGam1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(anoGam1.genscan.LENGTH)
head(anoGam1.genscan.LENGTH)

apiMel1.genscan.LENGTH

Transcript length data for the organism apiMel

Description

apiMel1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(apiMel1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(apiMel1.genscan.LENGTH)
head(apiMel1.genscan.LENGTH)

12

apiMel2.geneid.LENGTH

apiMel2.ensGene.LENGTH

Transcript length data for the organism apiMel

Description

apiMel2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(apiMel2, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(apiMel2.ensGene.LENGTH)
head(apiMel2.ensGene.LENGTH)

apiMel2.geneid.LENGTH Transcript length data for the organism apiMel

Description

apiMel2.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(apiMel2, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(apiMel2.geneid.LENGTH)
head(apiMel2.geneid.LENGTH)

apiMel2.genscan.LENGTH

13

apiMel2.genscan.LENGTH

Transcript length data for the organism apiMel

Description

apiMel2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(apiMel2, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(apiMel2.genscan.LENGTH)
head(apiMel2.genscan.LENGTH)

aplCal1.xenoRefGene.LENGTH

Transcript length data for the organism aplCal

Description

aplCal1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(aplCal1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(aplCal1.xenoRefGene.LENGTH)
head(aplCal1.xenoRefGene.LENGTH)

14

bosTau2.geneSymbol.LENGTH

bosTau2.geneid.LENGTH Transcript length data for the organism bosTau

Description

bosTau2.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(bosTau2, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau2.geneid.LENGTH)
head(bosTau2.geneid.LENGTH)

bosTau2.geneSymbol.LENGTH

Transcript length data for the organism bosTau

Description

bosTau2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(bosTau2, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau2.geneSymbol.LENGTH)
head(bosTau2.geneSymbol.LENGTH)

bosTau2.genscan.LENGTH

15

bosTau2.genscan.LENGTH

Transcript length data for the organism bosTau

Description

bosTau2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(bosTau2, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau2.genscan.LENGTH)
head(bosTau2.genscan.LENGTH)

bosTau2.refGene.LENGTH

Transcript length data for the organism bosTau

Description

bosTau2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(bosTau2, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau2.refGene.LENGTH)
head(bosTau2.refGene.LENGTH)

16

bosTau3.ensGene.LENGTH

bosTau2.sgpGene.LENGTH

Transcript length data for the organism bosTau

Description

bosTau2.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(bosTau2, sgpGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau2.sgpGene.LENGTH)
head(bosTau2.sgpGene.LENGTH)

bosTau3.ensGene.LENGTH

Transcript length data for the organism bosTau

Description

bosTau3.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(bosTau3, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau3.ensGene.LENGTH)
head(bosTau3.ensGene.LENGTH)

bosTau3.geneid.LENGTH

17

bosTau3.geneid.LENGTH Transcript length data for the organism bosTau

Description

bosTau3.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(bosTau3, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau3.geneid.LENGTH)
head(bosTau3.geneid.LENGTH)

bosTau3.geneSymbol.LENGTH

Transcript length data for the organism bosTau

Description

bosTau3.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(bosTau3, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau3.geneSymbol.LENGTH)
head(bosTau3.geneSymbol.LENGTH)

18

bosTau3.refGene.LENGTH

bosTau3.genscan.LENGTH

Transcript length data for the organism bosTau

Description

bosTau3.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(bosTau3, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau3.genscan.LENGTH)
head(bosTau3.genscan.LENGTH)

bosTau3.refGene.LENGTH

Transcript length data for the organism bosTau

Description

bosTau3.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(bosTau3, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau3.refGene.LENGTH)
head(bosTau3.refGene.LENGTH)

bosTau3.sgpGene.LENGTH

19

bosTau3.sgpGene.LENGTH

Transcript length data for the organism bosTau

Description

bosTau3.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(bosTau3, sgpGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau3.sgpGene.LENGTH)
head(bosTau3.sgpGene.LENGTH)

bosTau4.ensGene.LENGTH

Transcript length data for the organism bosTau

Description

bosTau4.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(bosTau4, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau4.ensGene.LENGTH)
head(bosTau4.ensGene.LENGTH)

20

bosTau4.genscan.LENGTH

bosTau4.geneSymbol.LENGTH

Transcript length data for the organism bosTau

Description

bosTau4.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(bosTau4, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau4.geneSymbol.LENGTH)
head(bosTau4.geneSymbol.LENGTH)

bosTau4.genscan.LENGTH

Transcript length data for the organism bosTau

Description

bosTau4.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(bosTau4, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau4.genscan.LENGTH)
head(bosTau4.genscan.LENGTH)

bosTau4.nscanGene.LENGTH

21

bosTau4.nscanGene.LENGTH

Transcript length data for the organism bosTau

Description

bosTau4.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(bosTau4, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau4.nscanGene.LENGTH)
head(bosTau4.nscanGene.LENGTH)

bosTau4.refGene.LENGTH

Transcript length data for the organism bosTau

Description

bosTau4.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(bosTau4, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(bosTau4.refGene.LENGTH)
head(bosTau4.refGene.LENGTH)

22

caeJap1.xenoRefGene.LENGTH

braFlo1.xenoRefGene.LENGTH

Transcript length data for the organism braFlo

Description

braFlo1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(braFlo1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(braFlo1.xenoRefGene.LENGTH)
head(braFlo1.xenoRefGene.LENGTH)

caeJap1.xenoRefGene.LENGTH

Transcript length data for the organism caeJap

Description

caeJap1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(caeJap1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(caeJap1.xenoRefGene.LENGTH)
head(caeJap1.xenoRefGene.LENGTH)

caePb1.xenoRefGene.LENGTH

23

caePb1.xenoRefGene.LENGTH

Transcript length data for the organism caePb

Description

caePb1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(caePb1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(caePb1.xenoRefGene.LENGTH)
head(caePb1.xenoRefGene.LENGTH)

caePb2.xenoRefGene.LENGTH

Transcript length data for the organism caePb

Description

caePb2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(caePb2, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(caePb2.xenoRefGene.LENGTH)
head(caePb2.xenoRefGene.LENGTH)

24

caeRem3.xenoRefGene.LENGTH

caeRem2.xenoRefGene.LENGTH

Transcript length data for the organism caeRem

Description

caeRem2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(caeRem2, xenoRefGene) on the
date on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(caeRem2.xenoRefGene.LENGTH)
head(caeRem2.xenoRefGene.LENGTH)

caeRem3.xenoRefGene.LENGTH

Transcript length data for the organism caeRem

Description

caeRem3.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(caeRem3, xenoRefGene) on the
date on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(caeRem3.xenoRefGene.LENGTH)
head(caeRem3.xenoRefGene.LENGTH)

calJac1.genscan.LENGTH

25

calJac1.genscan.LENGTH

Transcript length data for the organism calJac

Description

calJac1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(calJac1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(calJac1.genscan.LENGTH)
head(calJac1.genscan.LENGTH)

calJac1.nscanGene.LENGTH

Transcript length data for the organism calJac

Description

calJac1.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(calJac1, nscanGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(calJac1.nscanGene.LENGTH)
head(calJac1.nscanGene.LENGTH)

26

canFam1.ensGene.LENGTH

calJac1.xenoRefGene.LENGTH

Transcript length data for the organism calJac

Description

calJac1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(calJac1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(calJac1.xenoRefGene.LENGTH)
head(calJac1.xenoRefGene.LENGTH)

canFam1.ensGene.LENGTH

Transcript length data for the organism canFam

Description

canFam1.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(canFam1, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(canFam1.ensGene.LENGTH)
head(canFam1.ensGene.LENGTH)

canFam1.geneSymbol.LENGTH

27

canFam1.geneSymbol.LENGTH

Transcript length data for the organism canFam

Description

canFam1.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(canFam1, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(canFam1.geneSymbol.LENGTH)
head(canFam1.geneSymbol.LENGTH)

canFam1.genscan.LENGTH

Transcript length data for the organism canFam

Description

canFam1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(canFam1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(canFam1.genscan.LENGTH)
head(canFam1.genscan.LENGTH)

28

canFam1.refGene.LENGTH

canFam1.nscanGene.LENGTH

Transcript length data for the organism canFam

Description

canFam1.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(canFam1, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(canFam1.nscanGene.LENGTH)
head(canFam1.nscanGene.LENGTH)

canFam1.refGene.LENGTH

Transcript length data for the organism canFam

Description

canFam1.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(canFam1, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(canFam1.refGene.LENGTH)
head(canFam1.refGene.LENGTH)

canFam1.xenoRefGene.LENGTH

29

canFam1.xenoRefGene.LENGTH

Transcript length data for the organism canFam

Description

canFam1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(canFam1, xenoRefGene) on the
date on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(canFam1.xenoRefGene.LENGTH)
head(canFam1.xenoRefGene.LENGTH)

canFam2.ensGene.LENGTH

Transcript length data for the organism canFam

Description

canFam2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(canFam2, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(canFam2.ensGene.LENGTH)
head(canFam2.ensGene.LENGTH)

30

canFam2.genscan.LENGTH

canFam2.geneSymbol.LENGTH

Transcript length data for the organism canFam

Description

canFam2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(canFam2, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(canFam2.geneSymbol.LENGTH)
head(canFam2.geneSymbol.LENGTH)

canFam2.genscan.LENGTH

Transcript length data for the organism canFam

Description

canFam2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(canFam2, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(canFam2.genscan.LENGTH)
head(canFam2.genscan.LENGTH)

canFam2.nscanGene.LENGTH

31

canFam2.nscanGene.LENGTH

Transcript length data for the organism canFam

Description

canFam2.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(canFam2, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(canFam2.nscanGene.LENGTH)
head(canFam2.nscanGene.LENGTH)

canFam2.refGene.LENGTH

Transcript length data for the organism canFam

Description

canFam2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(canFam2, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(canFam2.refGene.LENGTH)
head(canFam2.refGene.LENGTH)

32

cavPor3.ensGene.LENGTH

canFam2.xenoRefGene.LENGTH

Transcript length data for the organism canFam

Description

canFam2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(canFam2, xenoRefGene) on the
date on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(canFam2.xenoRefGene.LENGTH)
head(canFam2.xenoRefGene.LENGTH)

cavPor3.ensGene.LENGTH

Transcript length data for the organism cavPor

Description

cavPor3.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(cavPor3, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(cavPor3.ensGene.LENGTH)
head(cavPor3.ensGene.LENGTH)

cavPor3.genscan.LENGTH

33

cavPor3.genscan.LENGTH

Transcript length data for the organism cavPor

Description

cavPor3.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(cavPor3, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(cavPor3.genscan.LENGTH)
head(cavPor3.genscan.LENGTH)

cavPor3.nscanGene.LENGTH

Transcript length data for the organism cavPor

Description

cavPor3.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(cavPor3, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(cavPor3.nscanGene.LENGTH)
head(cavPor3.nscanGene.LENGTH)

34

cb1.xenoRefGene.LENGTH

cavPor3.xenoRefGene.LENGTH

Transcript length data for the organism cavPor

Description

cavPor3.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(cavPor3, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(cavPor3.xenoRefGene.LENGTH)
head(cavPor3.xenoRefGene.LENGTH)

cb1.xenoRefGene.LENGTH

Transcript length data for the organism cb

Description

cb1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(cb1, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(cb1.xenoRefGene.LENGTH)
head(cb1.xenoRefGene.LENGTH)

cb3.xenoRefGene.LENGTH

35

cb3.xenoRefGene.LENGTH

Transcript length data for the organism cb

Description

cb3.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(cb3, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(cb3.xenoRefGene.LENGTH)
head(cb3.xenoRefGene.LENGTH)

ce2.geneid.LENGTH

Transcript length data for the organism ce

Description

ce2.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(ce2, geneid) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ce2.geneid.LENGTH)
head(ce2.geneid.LENGTH)

36

ce2.refGene.LENGTH

ce2.geneSymbol.LENGTH Transcript length data for the organism ce

Description

ce2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(ce2, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ce2.geneSymbol.LENGTH)
head(ce2.geneSymbol.LENGTH)

ce2.refGene.LENGTH

Transcript length data for the organism ce

Description

ce2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(ce2, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ce2.refGene.LENGTH)
head(ce2.refGene.LENGTH)

ce4.geneSymbol.LENGTH

37

ce4.geneSymbol.LENGTH Transcript length data for the organism ce

Description

ce4.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(ce4, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ce4.geneSymbol.LENGTH)
head(ce4.geneSymbol.LENGTH)

ce4.refGene.LENGTH

Transcript length data for the organism ce

Description

ce4.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(ce4, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ce4.refGene.LENGTH)
head(ce4.refGene.LENGTH)

38

ce6.ensGene.LENGTH

ce4.xenoRefGene.LENGTH

Transcript length data for the organism ce

Description

ce4.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(ce4, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ce4.xenoRefGene.LENGTH)
head(ce4.xenoRefGene.LENGTH)

ce6.ensGene.LENGTH

Transcript length data for the organism ce

Description

ce6.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(ce6, ensGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ce6.ensGene.LENGTH)
head(ce6.ensGene.LENGTH)

ce6.geneSymbol.LENGTH

39

ce6.geneSymbol.LENGTH Transcript length data for the organism ce

Description

ce6.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(ce6, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ce6.geneSymbol.LENGTH)
head(ce6.geneSymbol.LENGTH)

ce6.refGene.LENGTH

Transcript length data for the organism ce

Description

ce6.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(ce6, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ce6.refGene.LENGTH)
head(ce6.refGene.LENGTH)

40

ci1.geneSymbol.LENGTH

ce6.xenoRefGene.LENGTH

Transcript length data for the organism ce

Description

ce6.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(ce6, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ce6.xenoRefGene.LENGTH)
head(ce6.xenoRefGene.LENGTH)

ci1.geneSymbol.LENGTH Transcript length data for the organism ci

Description

ci1.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(ci1, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ci1.geneSymbol.LENGTH)
head(ci1.geneSymbol.LENGTH)

ci1.refGene.LENGTH

41

ci1.refGene.LENGTH

Transcript length data for the organism ci

Description

ci1.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(ci1, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ci1.refGene.LENGTH)
head(ci1.refGene.LENGTH)

ci1.xenoRefGene.LENGTH

Transcript length data for the organism ci

Description

ci1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(ci1, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ci1.xenoRefGene.LENGTH)
head(ci1.xenoRefGene.LENGTH)

42

ci2.geneSymbol.LENGTH

ci2.ensGene.LENGTH

Transcript length data for the organism ci

Description

ci2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(ci2, ensGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ci2.ensGene.LENGTH)
head(ci2.ensGene.LENGTH)

ci2.geneSymbol.LENGTH Transcript length data for the organism ci

Description

ci2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(ci2, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ci2.geneSymbol.LENGTH)
head(ci2.geneSymbol.LENGTH)

ci2.refGene.LENGTH

43

ci2.refGene.LENGTH

Transcript length data for the organism ci

Description

ci2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(ci2, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ci2.refGene.LENGTH)
head(ci2.refGene.LENGTH)

ci2.xenoRefGene.LENGTH

Transcript length data for the organism ci

Description

ci2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(ci2, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ci2.xenoRefGene.LENGTH)
head(ci2.xenoRefGene.LENGTH)

44

danRer3.geneSymbol.LENGTH

danRer3.ensGene.LENGTH

Transcript length data for the organism danRer

Description

danRer3.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(danRer3, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer3.ensGene.LENGTH)
head(danRer3.ensGene.LENGTH)

danRer3.geneSymbol.LENGTH

Transcript length data for the organism danRer

Description

danRer3.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(danRer3, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer3.geneSymbol.LENGTH)
head(danRer3.geneSymbol.LENGTH)

danRer3.refGene.LENGTH

45

danRer3.refGene.LENGTH

Transcript length data for the organism danRer

Description

danRer3.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(danRer3, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer3.refGene.LENGTH)
head(danRer3.refGene.LENGTH)

danRer4.ensGene.LENGTH

Transcript length data for the organism danRer

Description

danRer4.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(danRer4, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer4.ensGene.LENGTH)
head(danRer4.ensGene.LENGTH)

46

danRer4.genscan.LENGTH

danRer4.geneSymbol.LENGTH

Transcript length data for the organism danRer

Description

danRer4.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(danRer4, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer4.geneSymbol.LENGTH)
head(danRer4.geneSymbol.LENGTH)

danRer4.genscan.LENGTH

Transcript length data for the organism danRer

Description

danRer4.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(danRer4, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer4.genscan.LENGTH)
head(danRer4.genscan.LENGTH)

danRer4.nscanGene.LENGTH

47

danRer4.nscanGene.LENGTH

Transcript length data for the organism danRer

Description

danRer4.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(danRer4, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer4.nscanGene.LENGTH)
head(danRer4.nscanGene.LENGTH)

danRer4.refGene.LENGTH

Transcript length data for the organism danRer

Description

danRer4.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(danRer4, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer4.refGene.LENGTH)
head(danRer4.refGene.LENGTH)

48

danRer5.geneSymbol.LENGTH

danRer5.ensGene.LENGTH

Transcript length data for the organism danRer

Description

danRer5.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(danRer5, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer5.ensGene.LENGTH)
head(danRer5.ensGene.LENGTH)

danRer5.geneSymbol.LENGTH

Transcript length data for the organism danRer

Description

danRer5.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(danRer5, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer5.geneSymbol.LENGTH)
head(danRer5.geneSymbol.LENGTH)

danRer5.refGene.LENGTH

49

danRer5.refGene.LENGTH

Transcript length data for the organism danRer

Description

danRer5.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(danRer5, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer5.refGene.LENGTH)
head(danRer5.refGene.LENGTH)

danRer5.vegaGene.LENGTH

Transcript length data for the organism danRer

Description

danRer5.vegaGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the vegaGene table.

The data file was made by calling downloadLengthFromUCSC(danRer5, vegaGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer5.vegaGene.LENGTH)
head(danRer5.vegaGene.LENGTH)

50

danRer6.ensGene.LENGTH

danRer5.vegaPseudoGene.LENGTH

Transcript length data for the organism danRer

Description

danRer5.vegaPseudoGene.LENGTH is an R object which maps transcripts to the length (in bp)
of their mature mRNA transcripts. Where available, it will also provide the mapping between
a gene ID and its associated transcripts. The data is obtained from the UCSC table browser
(http://genome.ucsc.edu/cgi-bin/hgTables) using the vegaPseudoGene table.

The data file was made by calling downloadLengthFromUCSC(danRer5, vegaPseudoGene) on the
date on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer5.vegaPseudoGene.LENGTH)
head(danRer5.vegaPseudoGene.LENGTH)

danRer6.ensGene.LENGTH

Transcript length data for the organism danRer

Description

danRer6.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(danRer6, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer6.ensGene.LENGTH)
head(danRer6.ensGene.LENGTH)

danRer6.geneSymbol.LENGTH

51

danRer6.geneSymbol.LENGTH

Transcript length data for the organism danRer

Description

danRer6.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(danRer6, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer6.geneSymbol.LENGTH)
head(danRer6.geneSymbol.LENGTH)

danRer6.refGene.LENGTH

Transcript length data for the organism danRer

Description

danRer6.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(danRer6, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer6.refGene.LENGTH)
head(danRer6.refGene.LENGTH)

52

dm1.geneSymbol.LENGTH

danRer6.xenoRefGene.LENGTH

Transcript length data for the organism danRer

Description

danRer6.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(danRer6, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(danRer6.xenoRefGene.LENGTH)
head(danRer6.xenoRefGene.LENGTH)

dm1.geneSymbol.LENGTH Transcript length data for the organism dm

Description

dm1.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(dm1, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dm1.geneSymbol.LENGTH)
head(dm1.geneSymbol.LENGTH)

dm1.genscan.LENGTH

53

dm1.genscan.LENGTH

Transcript length data for the organism dm

Description

dm1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(dm1, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dm1.genscan.LENGTH)
head(dm1.genscan.LENGTH)

dm1.refGene.LENGTH

Transcript length data for the organism dm

Description

dm1.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(dm1, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dm1.refGene.LENGTH)
head(dm1.refGene.LENGTH)

54

dm2.geneSymbol.LENGTH

dm2.geneid.LENGTH

Transcript length data for the organism dm

Description

dm2.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(dm2, geneid) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dm2.geneid.LENGTH)
head(dm2.geneid.LENGTH)

dm2.geneSymbol.LENGTH Transcript length data for the organism dm

Description

dm2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(dm2, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dm2.geneSymbol.LENGTH)
head(dm2.geneSymbol.LENGTH)

dm2.genscan.LENGTH

55

dm2.genscan.LENGTH

Transcript length data for the organism dm

Description

dm2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(dm2, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dm2.genscan.LENGTH)
head(dm2.genscan.LENGTH)

dm2.nscanGene.LENGTH

Transcript length data for the organism dm

Description

dm2.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(dm2, nscanGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dm2.nscanGene.LENGTH)
head(dm2.nscanGene.LENGTH)

56

dm3.geneSymbol.LENGTH

dm2.refGene.LENGTH

Transcript length data for the organism dm

Description

dm2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(dm2, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dm2.refGene.LENGTH)
head(dm2.refGene.LENGTH)

dm3.geneSymbol.LENGTH Transcript length data for the organism dm

Description

dm3.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(dm3, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dm3.geneSymbol.LENGTH)
head(dm3.geneSymbol.LENGTH)

dm3.nscanPasaGene.LENGTH

57

dm3.nscanPasaGene.LENGTH

Transcript length data for the organism dm

Description

dm3.nscanPasaGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanPasaGene table.

The data file was made by calling downloadLengthFromUCSC(dm3, nscanPasaGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dm3.nscanPasaGene.LENGTH)
head(dm3.nscanPasaGene.LENGTH)

dm3.refGene.LENGTH

Transcript length data for the organism dm

Description

dm3.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(dm3, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dm3.refGene.LENGTH)
head(dm3.refGene.LENGTH)

58

downloadLengthFromUCSC

downloadLengthFromUCSC

Download Transcript Length Data

Description

Attempts to download the length of each transcript for the genome and gene ID specified from the
UCSC genome browser.

Usage

downloadLengthFromUCSC(genome, id)

Arguments

genome

id

Details

A string identifying the genome that genes refer to. For a list of supported
organisms see supportedGenomes.
A string identifying the gene identifier used by genes. For a list of supported
gene identifierst see supportedGeneIDs.

For each transcript, the UCSC genome browser is used to obtain the exon boundaries. The length
of each transcript is then taken to be the sum of the lengths of all its exons. Each transcript is then
associated with a gene.

The UCSC does not contain length information for all combinations of genome and gene ID listed
by supportedGeneIDs and supportedGenomes. If downloadLengthFromUCSC fails because your
gene ID format is not supported for the genome you specified, a list of possible ID formats for the
specified genome will be listed.

Value

A data.frame containing with three columns, the gene name, transcript identifier and the length of
the transcript. Each row represents one transcript.

Note

For some genome / gene ID combinations, no gene ID will be provided by UCSC. In this case, the
gene name column is set to NA. However, the transcript ID column will always be populated.

Author(s)

Matthew D. Young <myoung@wehi.edu.au>

See Also

supportedGenomes, supportedGeneIDs

dp2.genscan.LENGTH

Examples

## Not run:

flat_length <- downloadLengthFromUCSC('hg19', 'ensGene')

## End(Not run)

59

dp2.genscan.LENGTH

Transcript length data for the organism dp

Description

dp2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(dp2, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dp2.genscan.LENGTH)
head(dp2.genscan.LENGTH)

dp2.xenoRefGene.LENGTH

Transcript length data for the organism dp

Description

dp2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(dp2, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dp2.xenoRefGene.LENGTH)
head(dp2.xenoRefGene.LENGTH)

60

dp3.genscan.LENGTH

dp3.geneid.LENGTH

Transcript length data for the organism dp

Description

dp3.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(dp3, geneid) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dp3.geneid.LENGTH)
head(dp3.geneid.LENGTH)

dp3.genscan.LENGTH

Transcript length data for the organism dp

Description

dp3.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(dp3, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dp3.genscan.LENGTH)
head(dp3.genscan.LENGTH)

dp3.xenoRefGene.LENGTH

61

dp3.xenoRefGene.LENGTH

Transcript length data for the organism dp

Description

dp3.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(dp3, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(dp3.xenoRefGene.LENGTH)
head(dp3.xenoRefGene.LENGTH)

droAna1.geneid.LENGTH Transcript length data for the organism droAna

Description

droAna1.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(droAna1, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droAna1.geneid.LENGTH)
head(droAna1.geneid.LENGTH)

62

droAna1.xenoRefGene.LENGTH

droAna1.genscan.LENGTH

Transcript length data for the organism droAna

Description

droAna1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droAna1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droAna1.genscan.LENGTH)
head(droAna1.genscan.LENGTH)

droAna1.xenoRefGene.LENGTH

Transcript length data for the organism droAna

Description

droAna1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droAna1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droAna1.xenoRefGene.LENGTH)
head(droAna1.xenoRefGene.LENGTH)

droAna2.genscan.LENGTH

63

droAna2.genscan.LENGTH

Transcript length data for the organism droAna

Description

droAna2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droAna2, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droAna2.genscan.LENGTH)
head(droAna2.genscan.LENGTH)

droAna2.xenoRefGene.LENGTH

Transcript length data for the organism droAna

Description

droAna2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droAna2, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droAna2.xenoRefGene.LENGTH)
head(droAna2.xenoRefGene.LENGTH)

64

droEre1.xenoRefGene.LENGTH

droEre1.genscan.LENGTH

Transcript length data for the organism droEre

Description

droEre1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droEre1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droEre1.genscan.LENGTH)
head(droEre1.genscan.LENGTH)

droEre1.xenoRefGene.LENGTH

Transcript length data for the organism droEre

Description

droEre1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droEre1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droEre1.xenoRefGene.LENGTH)
head(droEre1.xenoRefGene.LENGTH)

droGri1.genscan.LENGTH

65

droGri1.genscan.LENGTH

Transcript length data for the organism droGri

Description

droGri1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droGri1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droGri1.genscan.LENGTH)
head(droGri1.genscan.LENGTH)

droGri1.xenoRefGene.LENGTH

Transcript length data for the organism droGri

Description

droGri1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droGri1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droGri1.xenoRefGene.LENGTH)
head(droGri1.xenoRefGene.LENGTH)

66

droMoj1.genscan.LENGTH

droMoj1.geneid.LENGTH Transcript length data for the organism droMoj

Description

droMoj1.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(droMoj1, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droMoj1.geneid.LENGTH)
head(droMoj1.geneid.LENGTH)

droMoj1.genscan.LENGTH

Transcript length data for the organism droMoj

Description

droMoj1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droMoj1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droMoj1.genscan.LENGTH)
head(droMoj1.genscan.LENGTH)

droMoj1.xenoRefGene.LENGTH

67

droMoj1.xenoRefGene.LENGTH

Transcript length data for the organism droMoj

Description

droMoj1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droMoj1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droMoj1.xenoRefGene.LENGTH)
head(droMoj1.xenoRefGene.LENGTH)

droMoj2.genscan.LENGTH

Transcript length data for the organism droMoj

Description

droMoj2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droMoj2, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droMoj2.genscan.LENGTH)
head(droMoj2.genscan.LENGTH)

68

droPer1.genscan.LENGTH

droMoj2.xenoRefGene.LENGTH

Transcript length data for the organism droMoj

Description

droMoj2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droMoj2, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droMoj2.xenoRefGene.LENGTH)
head(droMoj2.xenoRefGene.LENGTH)

droPer1.genscan.LENGTH

Transcript length data for the organism droPer

Description

droPer1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droPer1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droPer1.genscan.LENGTH)
head(droPer1.genscan.LENGTH)

droPer1.xenoRefGene.LENGTH

69

droPer1.xenoRefGene.LENGTH

Transcript length data for the organism droPer

Description

droPer1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droPer1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droPer1.xenoRefGene.LENGTH)
head(droPer1.xenoRefGene.LENGTH)

droSec1.genscan.LENGTH

Transcript length data for the organism droSec

Description

droSec1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droSec1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droSec1.genscan.LENGTH)
head(droSec1.genscan.LENGTH)

70

droSim1.geneid.LENGTH

droSec1.xenoRefGene.LENGTH

Transcript length data for the organism droSec

Description

droSec1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droSec1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droSec1.xenoRefGene.LENGTH)
head(droSec1.xenoRefGene.LENGTH)

droSim1.geneid.LENGTH Transcript length data for the organism droSim

Description

droSim1.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(droSim1, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droSim1.geneid.LENGTH)
head(droSim1.geneid.LENGTH)

droSim1.genscan.LENGTH

71

droSim1.genscan.LENGTH

Transcript length data for the organism droSim

Description

droSim1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droSim1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droSim1.genscan.LENGTH)
head(droSim1.genscan.LENGTH)

droSim1.xenoRefGene.LENGTH

Transcript length data for the organism droSim

Description

droSim1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droSim1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droSim1.xenoRefGene.LENGTH)
head(droSim1.xenoRefGene.LENGTH)

72

droVir1.genscan.LENGTH

droVir1.geneid.LENGTH Transcript length data for the organism droVir

Description

droVir1.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(droVir1, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droVir1.geneid.LENGTH)
head(droVir1.geneid.LENGTH)

droVir1.genscan.LENGTH

Transcript length data for the organism droVir

Description

droVir1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droVir1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droVir1.genscan.LENGTH)
head(droVir1.genscan.LENGTH)

droVir1.xenoRefGene.LENGTH

73

droVir1.xenoRefGene.LENGTH

Transcript length data for the organism droVir

Description

droVir1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droVir1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droVir1.xenoRefGene.LENGTH)
head(droVir1.xenoRefGene.LENGTH)

droVir2.genscan.LENGTH

Transcript length data for the organism droVir

Description

droVir2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droVir2, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droVir2.genscan.LENGTH)
head(droVir2.genscan.LENGTH)

74

droYak1.geneid.LENGTH

droVir2.xenoRefGene.LENGTH

Transcript length data for the organism droVir

Description

droVir2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droVir2, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droVir2.xenoRefGene.LENGTH)
head(droVir2.xenoRefGene.LENGTH)

droYak1.geneid.LENGTH Transcript length data for the organism droYak

Description

droYak1.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(droYak1, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droYak1.geneid.LENGTH)
head(droYak1.geneid.LENGTH)

droYak1.genscan.LENGTH

75

droYak1.genscan.LENGTH

Transcript length data for the organism droYak

Description

droYak1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droYak1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droYak1.genscan.LENGTH)
head(droYak1.genscan.LENGTH)

droYak1.xenoRefGene.LENGTH

Transcript length data for the organism droYak

Description

droYak1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droYak1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droYak1.xenoRefGene.LENGTH)
head(droYak1.xenoRefGene.LENGTH)

76

droYak2.xenoRefGene.LENGTH

droYak2.genscan.LENGTH

Transcript length data for the organism droYak

Description

droYak2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(droYak2, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droYak2.genscan.LENGTH)
head(droYak2.genscan.LENGTH)

droYak2.xenoRefGene.LENGTH

Transcript length data for the organism droYak

Description

droYak2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(droYak2, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(droYak2.xenoRefGene.LENGTH)
head(droYak2.xenoRefGene.LENGTH)

equCab1.geneid.LENGTH

77

equCab1.geneid.LENGTH Transcript length data for the organism equCab

Description

equCab1.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(equCab1, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(equCab1.geneid.LENGTH)
head(equCab1.geneid.LENGTH)

equCab1.geneSymbol.LENGTH

Transcript length data for the organism equCab

Description

equCab1.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(equCab1, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(equCab1.geneSymbol.LENGTH)
head(equCab1.geneSymbol.LENGTH)

78

equCab1.refGene.LENGTH

equCab1.nscanGene.LENGTH

Transcript length data for the organism equCab

Description

equCab1.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(equCab1, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(equCab1.nscanGene.LENGTH)
head(equCab1.nscanGene.LENGTH)

equCab1.refGene.LENGTH

Transcript length data for the organism equCab

Description

equCab1.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(equCab1, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(equCab1.refGene.LENGTH)
head(equCab1.refGene.LENGTH)

equCab1.sgpGene.LENGTH

79

equCab1.sgpGene.LENGTH

Transcript length data for the organism equCab

Description

equCab1.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(equCab1, sgpGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(equCab1.sgpGene.LENGTH)
head(equCab1.sgpGene.LENGTH)

equCab2.ensGene.LENGTH

Transcript length data for the organism equCab

Description

equCab2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(equCab2, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(equCab2.ensGene.LENGTH)
head(equCab2.ensGene.LENGTH)

80

equCab2.nscanGene.LENGTH

equCab2.geneSymbol.LENGTH

Transcript length data for the organism equCab

Description

equCab2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(equCab2, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(equCab2.geneSymbol.LENGTH)
head(equCab2.geneSymbol.LENGTH)

equCab2.nscanGene.LENGTH

Transcript length data for the organism equCab

Description

equCab2.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(equCab2, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(equCab2.nscanGene.LENGTH)
head(equCab2.nscanGene.LENGTH)

equCab2.refGene.LENGTH

81

equCab2.refGene.LENGTH

Transcript length data for the organism equCab

Description

equCab2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(equCab2, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(equCab2.refGene.LENGTH)
head(equCab2.refGene.LENGTH)

equCab2.xenoRefGene.LENGTH

Transcript length data for the organism equCab

Description

equCab2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(equCab2, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(equCab2.xenoRefGene.LENGTH)
head(equCab2.xenoRefGene.LENGTH)

82

felCat3.geneid.LENGTH

felCat3.ensGene.LENGTH

Transcript length data for the organism felCat

Description

felCat3.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(felCat3, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(felCat3.ensGene.LENGTH)
head(felCat3.ensGene.LENGTH)

felCat3.geneid.LENGTH Transcript length data for the organism felCat

Description

felCat3.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(felCat3, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(felCat3.geneid.LENGTH)
head(felCat3.geneid.LENGTH)

felCat3.geneSymbol.LENGTH

83

felCat3.geneSymbol.LENGTH

Transcript length data for the organism felCat

Description

felCat3.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(felCat3, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(felCat3.geneSymbol.LENGTH)
head(felCat3.geneSymbol.LENGTH)

felCat3.genscan.LENGTH

Transcript length data for the organism felCat

Description

felCat3.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(felCat3, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(felCat3.genscan.LENGTH)
head(felCat3.genscan.LENGTH)

84

felCat3.refGene.LENGTH

felCat3.nscanGene.LENGTH

Transcript length data for the organism felCat

Description

felCat3.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(felCat3, nscanGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(felCat3.nscanGene.LENGTH)
head(felCat3.nscanGene.LENGTH)

felCat3.refGene.LENGTH

Transcript length data for the organism felCat

Description

felCat3.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(felCat3, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(felCat3.refGene.LENGTH)
head(felCat3.refGene.LENGTH)

felCat3.sgpGene.LENGTH

85

felCat3.sgpGene.LENGTH

Transcript length data for the organism felCat

Description

felCat3.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(felCat3, sgpGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(felCat3.sgpGene.LENGTH)
head(felCat3.sgpGene.LENGTH)

felCat3.xenoRefGene.LENGTH

Transcript length data for the organism felCat

Description

felCat3.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(felCat3, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(felCat3.xenoRefGene.LENGTH)
head(felCat3.xenoRefGene.LENGTH)

86

fr1.genscan.LENGTH

fr1.ensGene.LENGTH

Transcript length data for the organism fr

Description

fr1.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(fr1, ensGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(fr1.ensGene.LENGTH)
head(fr1.ensGene.LENGTH)

fr1.genscan.LENGTH

Transcript length data for the organism fr

Description

fr1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(fr1, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(fr1.genscan.LENGTH)
head(fr1.genscan.LENGTH)

fr2.ensGene.LENGTH

87

fr2.ensGene.LENGTH

Transcript length data for the organism fr

Description

fr2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(fr2, ensGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(fr2.ensGene.LENGTH)
head(fr2.ensGene.LENGTH)

galGal2.ensGene.LENGTH

Transcript length data for the organism galGal

Description

galGal2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(galGal2, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(galGal2.ensGene.LENGTH)
head(galGal2.ensGene.LENGTH)

88

galGal2.geneSymbol.LENGTH

galGal2.geneid.LENGTH Transcript length data for the organism galGal

Description

galGal2.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(galGal2, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(galGal2.geneid.LENGTH)
head(galGal2.geneid.LENGTH)

galGal2.geneSymbol.LENGTH

Transcript length data for the organism galGal

Description

galGal2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(galGal2, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(galGal2.geneSymbol.LENGTH)
head(galGal2.geneSymbol.LENGTH)

galGal2.genscan.LENGTH

89

galGal2.genscan.LENGTH

Transcript length data for the organism galGal

Description

galGal2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(galGal2, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(galGal2.genscan.LENGTH)
head(galGal2.genscan.LENGTH)

galGal2.refGene.LENGTH

Transcript length data for the organism galGal

Description

galGal2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(galGal2, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(galGal2.refGene.LENGTH)
head(galGal2.refGene.LENGTH)

90

galGal3.ensGene.LENGTH

galGal2.sgpGene.LENGTH

Transcript length data for the organism galGal

Description

galGal2.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(galGal2, sgpGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(galGal2.sgpGene.LENGTH)
head(galGal2.sgpGene.LENGTH)

galGal3.ensGene.LENGTH

Transcript length data for the organism galGal

Description

galGal3.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(galGal3, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(galGal3.ensGene.LENGTH)
head(galGal3.ensGene.LENGTH)

galGal3.geneSymbol.LENGTH

91

galGal3.geneSymbol.LENGTH

Transcript length data for the organism galGal

Description

galGal3.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(galGal3, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(galGal3.geneSymbol.LENGTH)
head(galGal3.geneSymbol.LENGTH)

galGal3.genscan.LENGTH

Transcript length data for the organism galGal

Description

galGal3.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(galGal3, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(galGal3.genscan.LENGTH)
head(galGal3.genscan.LENGTH)

92

galGal3.refGene.LENGTH

galGal3.nscanGene.LENGTH

Transcript length data for the organism galGal

Description

galGal3.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(galGal3, nscanGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(galGal3.nscanGene.LENGTH)
head(galGal3.nscanGene.LENGTH)

galGal3.refGene.LENGTH

Transcript length data for the organism galGal

Description

galGal3.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(galGal3, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(galGal3.refGene.LENGTH)
head(galGal3.refGene.LENGTH)

galGal3.xenoRefGene.LENGTH

93

galGal3.xenoRefGene.LENGTH

Transcript length data for the organism galGal

Description

galGal3.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(galGal3, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(galGal3.xenoRefGene.LENGTH)
head(galGal3.xenoRefGene.LENGTH)

gasAcu1.ensGene.LENGTH

Transcript length data for the organism gasAcu

Description

gasAcu1.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(gasAcu1, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(gasAcu1.ensGene.LENGTH)
head(gasAcu1.ensGene.LENGTH)

94

geneLenDatabase-pkg

gasAcu1.nscanGene.LENGTH

Transcript length data for the organism gasAcu

Description

gasAcu1.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(gasAcu1, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(gasAcu1.nscanGene.LENGTH)
head(gasAcu1.nscanGene.LENGTH)

geneLenDatabase-pkg

geneLenDatabase:

Description

Lengths of mRNA transcripts for a number of genomes

Details

Length of mRNA transcripts for a number of genomes and gene ID formats, largely based on UCSC
table browser. Data objects are provided as individual pieces of information to be retrieved and
loaded. A variety of different gene identifiers and genomes is supported to ensure wide applicability.

Author(s)

Maintainer: Federico Marini <marinif@uni-mainz.de> (ORCID) [contributor]
Authors:

• Matthew Young <my4@sanger.ac.uk>
• Nadia Davidson <nadia.davidson@mcri.edu.au>

See Also

Useful links:

• https://github.com/federicomarini/geneLenDataBase
• Report bugs at https://github.com/federicomarini/geneLenDataBase/issues

hg16.acembly.LENGTH

95

hg16.acembly.LENGTH

Transcript length data for the organism hg

Description

hg16.acembly.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the acembly table.

The data file was made by calling downloadLengthFromUCSC(hg16, acembly) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg16.acembly.LENGTH)
head(hg16.acembly.LENGTH)

hg16.ensGene.LENGTH

Transcript length data for the organism hg

Description

hg16.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(hg16, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg16.ensGene.LENGTH)
head(hg16.ensGene.LENGTH)

96

hg16.geneid.LENGTH

hg16.exoniphy.LENGTH

Transcript length data for the organism hg

Description

hg16.exoniphy.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the exoniphy table.

The data file was made by calling downloadLengthFromUCSC(hg16, exoniphy) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg16.exoniphy.LENGTH)
head(hg16.exoniphy.LENGTH)

hg16.geneid.LENGTH

Transcript length data for the organism hg

Description

hg16.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(hg16, geneid) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg16.geneid.LENGTH)
head(hg16.geneid.LENGTH)

hg16.geneSymbol.LENGTH

97

hg16.geneSymbol.LENGTH

Transcript length data for the organism hg

Description

hg16.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(hg16, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg16.geneSymbol.LENGTH)
head(hg16.geneSymbol.LENGTH)

hg16.genscan.LENGTH

Transcript length data for the organism hg

Description

hg16.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(hg16, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg16.genscan.LENGTH)
head(hg16.genscan.LENGTH)

98

hg16.refGene.LENGTH

hg16.knownGene.LENGTH Transcript length data for the organism hg

Description

hg16.knownGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the knownGene table.

The data file was made by calling downloadLengthFromUCSC(hg16, knownGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg16.knownGene.LENGTH)
head(hg16.knownGene.LENGTH)

hg16.refGene.LENGTH

Transcript length data for the organism hg

Description

hg16.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(hg16, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg16.refGene.LENGTH)
head(hg16.refGene.LENGTH)

hg16.sgpGene.LENGTH

99

hg16.sgpGene.LENGTH

Transcript length data for the organism hg

Description

hg16.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(hg16, sgpGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg16.sgpGene.LENGTH)
head(hg16.sgpGene.LENGTH)

hg17.acembly.LENGTH

Transcript length data for the organism hg

Description

hg17.acembly.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the acembly table.

The data file was made by calling downloadLengthFromUCSC(hg17, acembly) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.acembly.LENGTH)
head(hg17.acembly.LENGTH)

100

hg17.ccdsGene.LENGTH

hg17.acescan.LENGTH

Transcript length data for the organism hg

Description

hg17.acescan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the acescan table.

The data file was made by calling downloadLengthFromUCSC(hg17, acescan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.acescan.LENGTH)
head(hg17.acescan.LENGTH)

hg17.ccdsGene.LENGTH

Transcript length data for the organism hg

Description

hg17.ccdsGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ccdsGene table.

The data file was made by calling downloadLengthFromUCSC(hg17, ccdsGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.ccdsGene.LENGTH)
head(hg17.ccdsGene.LENGTH)

hg17.ensGene.LENGTH

101

hg17.ensGene.LENGTH

Transcript length data for the organism hg

Description

hg17.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(hg17, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.ensGene.LENGTH)
head(hg17.ensGene.LENGTH)

hg17.exoniphy.LENGTH

Transcript length data for the organism hg

Description

hg17.exoniphy.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the exoniphy table.

The data file was made by calling downloadLengthFromUCSC(hg17, exoniphy) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.exoniphy.LENGTH)
head(hg17.exoniphy.LENGTH)

102

hg17.geneSymbol.LENGTH

hg17.geneid.LENGTH

Transcript length data for the organism hg

Description

hg17.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(hg17, geneid) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.geneid.LENGTH)
head(hg17.geneid.LENGTH)

hg17.geneSymbol.LENGTH

Transcript length data for the organism hg

Description

hg17.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(hg17, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.geneSymbol.LENGTH)
head(hg17.geneSymbol.LENGTH)

hg17.genscan.LENGTH

103

hg17.genscan.LENGTH

Transcript length data for the organism hg

Description

hg17.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(hg17, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.genscan.LENGTH)
head(hg17.genscan.LENGTH)

hg17.knownGene.LENGTH Transcript length data for the organism hg

Description

hg17.knownGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the knownGene table.

The data file was made by calling downloadLengthFromUCSC(hg17, knownGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.knownGene.LENGTH)
head(hg17.knownGene.LENGTH)

104

hg17.sgpGene.LENGTH

hg17.refGene.LENGTH

Transcript length data for the organism hg

Description

hg17.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(hg17, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.refGene.LENGTH)
head(hg17.refGene.LENGTH)

hg17.sgpGene.LENGTH

Transcript length data for the organism hg

Description

hg17.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(hg17, sgpGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.sgpGene.LENGTH)
head(hg17.sgpGene.LENGTH)

hg17.vegaGene.LENGTH

105

hg17.vegaGene.LENGTH

Transcript length data for the organism hg

Description

hg17.vegaGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the vegaGene table.

The data file was made by calling downloadLengthFromUCSC(hg17, vegaGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.vegaGene.LENGTH)
head(hg17.vegaGene.LENGTH)

hg17.vegaPseudoGene.LENGTH

Transcript length data for the organism hg

Description

hg17.vegaPseudoGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the vegaPseudoGene table.

The data file was made by calling downloadLengthFromUCSC(hg17, vegaPseudoGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.vegaPseudoGene.LENGTH)
head(hg17.vegaPseudoGene.LENGTH)

106

hg18.acembly.LENGTH

hg17.xenoRefGene.LENGTH

Transcript length data for the organism hg

Description

hg17.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(hg17, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg17.xenoRefGene.LENGTH)
head(hg17.xenoRefGene.LENGTH)

hg18.acembly.LENGTH

Transcript length data for the organism hg

Description

hg18.acembly.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the acembly table.

The data file was made by calling downloadLengthFromUCSC(hg18, acembly) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.acembly.LENGTH)
head(hg18.acembly.LENGTH)

hg18.acescan.LENGTH

107

hg18.acescan.LENGTH

Transcript length data for the organism hg

Description

hg18.acescan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the acescan table.

The data file was made by calling downloadLengthFromUCSC(hg18, acescan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.acescan.LENGTH)
head(hg18.acescan.LENGTH)

hg18.ccdsGene.LENGTH

Transcript length data for the organism hg

Description

hg18.ccdsGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ccdsGene table.

The data file was made by calling downloadLengthFromUCSC(hg18, ccdsGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.ccdsGene.LENGTH)
head(hg18.ccdsGene.LENGTH)

108

hg18.exoniphy.LENGTH

hg18.ensGene.LENGTH

Transcript length data for the organism hg

Description

hg18.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(hg18, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.ensGene.LENGTH)
head(hg18.ensGene.LENGTH)

hg18.exoniphy.LENGTH

Transcript length data for the organism hg

Description

hg18.exoniphy.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the exoniphy table.

The data file was made by calling downloadLengthFromUCSC(hg18, exoniphy) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.exoniphy.LENGTH)
head(hg18.exoniphy.LENGTH)

hg18.geneid.LENGTH

109

hg18.geneid.LENGTH

Transcript length data for the organism hg

Description

hg18.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(hg18, geneid) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.geneid.LENGTH)
head(hg18.geneid.LENGTH)

hg18.geneSymbol.LENGTH

Transcript length data for the organism hg

Description

hg18.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(hg18, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.geneSymbol.LENGTH)
head(hg18.geneSymbol.LENGTH)

110

hg18.knownGene.LENGTH

hg18.genscan.LENGTH

Transcript length data for the organism hg

Description

hg18.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(hg18, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.genscan.LENGTH)
head(hg18.genscan.LENGTH)

hg18.knownGene.LENGTH Transcript length data for the organism hg

Description

hg18.knownGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the knownGene table.

The data file was made by calling downloadLengthFromUCSC(hg18, knownGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.knownGene.LENGTH)
head(hg18.knownGene.LENGTH)

hg18.knownGeneOld3.LENGTH

111

hg18.knownGeneOld3.LENGTH

Transcript length data for the organism hg

Description

hg18.knownGeneOld3.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the knownGeneOld3 table.

The data file was made by calling downloadLengthFromUCSC(hg18, knownGeneOld3) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.knownGeneOld3.LENGTH)
head(hg18.knownGeneOld3.LENGTH)

hg18.refGene.LENGTH

Transcript length data for the organism hg

Description

hg18.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(hg18, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.refGene.LENGTH)
head(hg18.refGene.LENGTH)

112

hg18.sibGene.LENGTH

hg18.sgpGene.LENGTH

Transcript length data for the organism hg

Description

hg18.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(hg18, sgpGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.sgpGene.LENGTH)
head(hg18.sgpGene.LENGTH)

hg18.sibGene.LENGTH

Transcript length data for the organism hg

Description

hg18.sibGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sibGene table.

The data file was made by calling downloadLengthFromUCSC(hg18, sibGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.sibGene.LENGTH)
head(hg18.sibGene.LENGTH)

hg18.xenoRefGene.LENGTH

113

hg18.xenoRefGene.LENGTH

Transcript length data for the organism hg

Description

hg18.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(hg18, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg18.xenoRefGene.LENGTH)
head(hg18.xenoRefGene.LENGTH)

hg19.ccdsGene.LENGTH

Transcript length data for the organism hg

Description

hg19.ccdsGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ccdsGene table.

The data file was made by calling downloadLengthFromUCSC(hg19, ccdsGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg19.ccdsGene.LENGTH)
head(hg19.ccdsGene.LENGTH)

114

hg19.exoniphy.LENGTH

hg19.ensGene.LENGTH

Transcript length data for the organism hg

Description

hg19.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(hg19, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg19.ensGene.LENGTH)
head(hg19.ensGene.LENGTH)

hg19.exoniphy.LENGTH

Transcript length data for the organism hg

Description

hg19.exoniphy.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the exoniphy table.

The data file was made by calling downloadLengthFromUCSC(hg19, exoniphy) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg19.exoniphy.LENGTH)
head(hg19.exoniphy.LENGTH)

hg19.geneSymbol.LENGTH

115

hg19.geneSymbol.LENGTH

Transcript length data for the organism hg

Description

hg19.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(hg19, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg19.geneSymbol.LENGTH)
head(hg19.geneSymbol.LENGTH)

hg19.knownGene.LENGTH Transcript length data for the organism hg

Description

hg19.knownGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the knownGene table.

The data file was made by calling downloadLengthFromUCSC(hg19, knownGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg19.knownGene.LENGTH)
head(hg19.knownGene.LENGTH)

116

hg19.refGene.LENGTH

hg19.nscanGene.LENGTH Transcript length data for the organism hg

Description

hg19.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(hg19, nscanGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg19.nscanGene.LENGTH)
head(hg19.nscanGene.LENGTH)

hg19.refGene.LENGTH

Transcript length data for the organism hg

Description

hg19.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(hg19, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg19.refGene.LENGTH)
head(hg19.refGene.LENGTH)

hg19.xenoRefGene.LENGTH

117

hg19.xenoRefGene.LENGTH

Transcript length data for the organism hg

Description

hg19.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(hg19, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(hg19.xenoRefGene.LENGTH)
head(hg19.xenoRefGene.LENGTH)

loxAfr3.xenoRefGene.LENGTH

Transcript length data for the organism loxAfr

Description

loxAfr3.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(loxAfr3, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(loxAfr3.xenoRefGene.LENGTH)
head(loxAfr3.xenoRefGene.LENGTH)

118

mm7.geneid.LENGTH

mm7.ensGene.LENGTH

Transcript length data for the organism mm

Description

mm7.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(mm7, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm7.ensGene.LENGTH)
head(mm7.ensGene.LENGTH)

mm7.geneid.LENGTH

Transcript length data for the organism mm

Description

mm7.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(mm7, geneid) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm7.geneid.LENGTH)
head(mm7.geneid.LENGTH)

mm7.geneSymbol.LENGTH

119

mm7.geneSymbol.LENGTH Transcript length data for the organism mm

Description

mm7.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(mm7, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm7.geneSymbol.LENGTH)
head(mm7.geneSymbol.LENGTH)

mm7.genscan.LENGTH

Transcript length data for the organism mm

Description

mm7.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(mm7, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm7.genscan.LENGTH)
head(mm7.genscan.LENGTH)

120

mm7.refGene.LENGTH

mm7.knownGene.LENGTH

Transcript length data for the organism mm

Description

mm7.knownGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the knownGene table.

The data file was made by calling downloadLengthFromUCSC(mm7, knownGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm7.knownGene.LENGTH)
head(mm7.knownGene.LENGTH)

mm7.refGene.LENGTH

Transcript length data for the organism mm

Description

mm7.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(mm7, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm7.refGene.LENGTH)
head(mm7.refGene.LENGTH)

mm7.sgpGene.LENGTH

121

mm7.sgpGene.LENGTH

Transcript length data for the organism mm

Description

mm7.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(mm7, sgpGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm7.sgpGene.LENGTH)
head(mm7.sgpGene.LENGTH)

mm7.xenoRefGene.LENGTH

Transcript length data for the organism mm

Description

mm7.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(mm7, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm7.xenoRefGene.LENGTH)
head(mm7.xenoRefGene.LENGTH)

122

mm8.ensGene.LENGTH

mm8.ccdsGene.LENGTH

Transcript length data for the organism mm

Description

mm8.ccdsGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ccdsGene table.

The data file was made by calling downloadLengthFromUCSC(mm8, ccdsGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm8.ccdsGene.LENGTH)
head(mm8.ccdsGene.LENGTH)

mm8.ensGene.LENGTH

Transcript length data for the organism mm

Description

mm8.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(mm8, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm8.ensGene.LENGTH)
head(mm8.ensGene.LENGTH)

mm8.geneid.LENGTH

123

mm8.geneid.LENGTH

Transcript length data for the organism mm

Description

mm8.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(mm8, geneid) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm8.geneid.LENGTH)
head(mm8.geneid.LENGTH)

mm8.geneSymbol.LENGTH Transcript length data for the organism mm

Description

mm8.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(mm8, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm8.geneSymbol.LENGTH)
head(mm8.geneSymbol.LENGTH)

124

mm8.knownGene.LENGTH

mm8.genscan.LENGTH

Transcript length data for the organism mm

Description

mm8.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(mm8, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm8.genscan.LENGTH)
head(mm8.genscan.LENGTH)

mm8.knownGene.LENGTH

Transcript length data for the organism mm

Description

mm8.knownGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the knownGene table.

The data file was made by calling downloadLengthFromUCSC(mm8, knownGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm8.knownGene.LENGTH)
head(mm8.knownGene.LENGTH)

mm8.nscanGene.LENGTH

125

mm8.nscanGene.LENGTH

Transcript length data for the organism mm

Description

mm8.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(mm8, nscanGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm8.nscanGene.LENGTH)
head(mm8.nscanGene.LENGTH)

mm8.refGene.LENGTH

Transcript length data for the organism mm

Description

mm8.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(mm8, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm8.refGene.LENGTH)
head(mm8.refGene.LENGTH)

126

mm8.sibGene.LENGTH

mm8.sgpGene.LENGTH

Transcript length data for the organism mm

Description

mm8.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(mm8, sgpGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm8.sgpGene.LENGTH)
head(mm8.sgpGene.LENGTH)

mm8.sibGene.LENGTH

Transcript length data for the organism mm

Description

mm8.sibGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sibGene table.

The data file was made by calling downloadLengthFromUCSC(mm8, sibGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm8.sibGene.LENGTH)
head(mm8.sibGene.LENGTH)

mm8.xenoRefGene.LENGTH

127

mm8.xenoRefGene.LENGTH

Transcript length data for the organism mm

Description

mm8.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(mm8, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm8.xenoRefGene.LENGTH)
head(mm8.xenoRefGene.LENGTH)

mm9.acembly.LENGTH

Transcript length data for the organism mm

Description

mm9.acembly.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the acembly table.

The data file was made by calling downloadLengthFromUCSC(mm9, acembly) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm9.acembly.LENGTH)
head(mm9.acembly.LENGTH)

128

mm9.ensGene.LENGTH

mm9.ccdsGene.LENGTH

Transcript length data for the organism mm

Description

mm9.ccdsGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ccdsGene table.

The data file was made by calling downloadLengthFromUCSC(mm9, ccdsGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm9.ccdsGene.LENGTH)
head(mm9.ccdsGene.LENGTH)

mm9.ensGene.LENGTH

Transcript length data for the organism mm

Description

mm9.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(mm9, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm9.ensGene.LENGTH)
head(mm9.ensGene.LENGTH)

mm9.exoniphy.LENGTH

129

mm9.exoniphy.LENGTH

Transcript length data for the organism mm

Description

mm9.exoniphy.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the exoniphy table.

The data file was made by calling downloadLengthFromUCSC(mm9, exoniphy) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm9.exoniphy.LENGTH)
head(mm9.exoniphy.LENGTH)

mm9.geneid.LENGTH

Transcript length data for the organism mm

Description

mm9.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(mm9, geneid) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm9.geneid.LENGTH)
head(mm9.geneid.LENGTH)

130

mm9.genscan.LENGTH

mm9.geneSymbol.LENGTH Transcript length data for the organism mm

Description

mm9.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(mm9, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm9.geneSymbol.LENGTH)
head(mm9.geneSymbol.LENGTH)

mm9.genscan.LENGTH

Transcript length data for the organism mm

Description

mm9.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(mm9, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm9.genscan.LENGTH)
head(mm9.genscan.LENGTH)

mm9.knownGene.LENGTH

131

mm9.knownGene.LENGTH

Transcript length data for the organism mm

Description

mm9.knownGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the knownGene table.

The data file was made by calling downloadLengthFromUCSC(mm9, knownGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm9.knownGene.LENGTH)
head(mm9.knownGene.LENGTH)

mm9.nscanGene.LENGTH

Transcript length data for the organism mm

Description

mm9.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(mm9, nscanGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm9.nscanGene.LENGTH)
head(mm9.nscanGene.LENGTH)

132

mm9.sgpGene.LENGTH

mm9.refGene.LENGTH

Transcript length data for the organism mm

Description

mm9.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(mm9, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm9.refGene.LENGTH)
head(mm9.refGene.LENGTH)

mm9.sgpGene.LENGTH

Transcript length data for the organism mm

Description

mm9.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(mm9, sgpGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm9.sgpGene.LENGTH)
head(mm9.sgpGene.LENGTH)

mm9.xenoRefGene.LENGTH

133

mm9.xenoRefGene.LENGTH

Transcript length data for the organism mm

Description

mm9.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(mm9, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(mm9.xenoRefGene.LENGTH)
head(mm9.xenoRefGene.LENGTH)

monDom1.genscan.LENGTH

Transcript length data for the organism monDom

Description

monDom1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(monDom1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom1.genscan.LENGTH)
head(monDom1.genscan.LENGTH)

134

monDom4.geneSymbol.LENGTH

monDom4.ensGene.LENGTH

Transcript length data for the organism monDom

Description

monDom4.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(monDom4, ensGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom4.ensGene.LENGTH)
head(monDom4.ensGene.LENGTH)

monDom4.geneSymbol.LENGTH

Transcript length data for the organism monDom

Description

monDom4.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(monDom4, geneSymbol) on the
date on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom4.geneSymbol.LENGTH)
head(monDom4.geneSymbol.LENGTH)

monDom4.genscan.LENGTH

135

monDom4.genscan.LENGTH

Transcript length data for the organism monDom

Description

monDom4.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(monDom4, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom4.genscan.LENGTH)
head(monDom4.genscan.LENGTH)

monDom4.nscanGene.LENGTH

Transcript length data for the organism monDom

Description

monDom4.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(monDom4, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom4.nscanGene.LENGTH)
head(monDom4.nscanGene.LENGTH)

136

monDom4.xenoRefGene.LENGTH

monDom4.refGene.LENGTH

Transcript length data for the organism monDom

Description

monDom4.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(monDom4, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom4.refGene.LENGTH)
head(monDom4.refGene.LENGTH)

monDom4.xenoRefGene.LENGTH

Transcript length data for the organism monDom

Description

monDom4.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp)
of their mature mRNA transcripts. Where available, it will also provide the mapping between
a gene ID and its associated transcripts. The data is obtained from the UCSC table browser
(http://genome.ucsc.edu/cgi-bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(monDom4, xenoRefGene) on the
date on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom4.xenoRefGene.LENGTH)
head(monDom4.xenoRefGene.LENGTH)

monDom5.ensGene.LENGTH

137

monDom5.ensGene.LENGTH

Transcript length data for the organism monDom

Description

monDom5.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(monDom5, ensGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom5.ensGene.LENGTH)
head(monDom5.ensGene.LENGTH)

monDom5.geneSymbol.LENGTH

Transcript length data for the organism monDom

Description

monDom5.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(monDom5, geneSymbol) on the
date on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom5.geneSymbol.LENGTH)
head(monDom5.geneSymbol.LENGTH)

138

monDom5.nscanGene.LENGTH

monDom5.genscan.LENGTH

Transcript length data for the organism monDom

Description

monDom5.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(monDom5, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom5.genscan.LENGTH)
head(monDom5.genscan.LENGTH)

monDom5.nscanGene.LENGTH

Transcript length data for the organism monDom

Description

monDom5.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(monDom5, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom5.nscanGene.LENGTH)
head(monDom5.nscanGene.LENGTH)

monDom5.refGene.LENGTH

139

monDom5.refGene.LENGTH

Transcript length data for the organism monDom

Description

monDom5.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(monDom5, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom5.refGene.LENGTH)
head(monDom5.refGene.LENGTH)

monDom5.xenoRefGene.LENGTH

Transcript length data for the organism monDom

Description

monDom5.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp)
of their mature mRNA transcripts. Where available, it will also provide the mapping between
a gene ID and its associated transcripts. The data is obtained from the UCSC table browser
(http://genome.ucsc.edu/cgi-bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(monDom5, xenoRefGene) on the
date on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(monDom5.xenoRefGene.LENGTH)
head(monDom5.xenoRefGene.LENGTH)

140

ornAna1.geneSymbol.LENGTH

ornAna1.ensGene.LENGTH

Transcript length data for the organism ornAna

Description

ornAna1.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(ornAna1, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ornAna1.ensGene.LENGTH)
head(ornAna1.ensGene.LENGTH)

ornAna1.geneSymbol.LENGTH

Transcript length data for the organism ornAna

Description

ornAna1.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(ornAna1, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ornAna1.geneSymbol.LENGTH)
head(ornAna1.geneSymbol.LENGTH)

ornAna1.refGene.LENGTH

141

ornAna1.refGene.LENGTH

Transcript length data for the organism ornAna

Description

ornAna1.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(ornAna1, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ornAna1.refGene.LENGTH)
head(ornAna1.refGene.LENGTH)

ornAna1.xenoRefGene.LENGTH

Transcript length data for the organism ornAna

Description

ornAna1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(ornAna1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ornAna1.xenoRefGene.LENGTH)
head(ornAna1.xenoRefGene.LENGTH)

142

oryLat2.geneSymbol.LENGTH

oryLat2.ensGene.LENGTH

Transcript length data for the organism oryLat

Description

oryLat2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(oryLat2, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(oryLat2.ensGene.LENGTH)
head(oryLat2.ensGene.LENGTH)

oryLat2.geneSymbol.LENGTH

Transcript length data for the organism oryLat

Description

oryLat2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(oryLat2, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(oryLat2.geneSymbol.LENGTH)
head(oryLat2.geneSymbol.LENGTH)

oryLat2.refGene.LENGTH

143

oryLat2.refGene.LENGTH

Transcript length data for the organism oryLat

Description

oryLat2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(oryLat2, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(oryLat2.refGene.LENGTH)
head(oryLat2.refGene.LENGTH)

oryLat2.xenoRefGene.LENGTH

Transcript length data for the organism oryLat

Description

oryLat2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(oryLat2, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(oryLat2.xenoRefGene.LENGTH)
head(oryLat2.xenoRefGene.LENGTH)

144

panTro1.geneid.LENGTH

panTro1.ensGene.LENGTH

Transcript length data for the organism panTro

Description

panTro1.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(panTro1, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(panTro1.ensGene.LENGTH)
head(panTro1.ensGene.LENGTH)

panTro1.geneid.LENGTH Transcript length data for the organism panTro

Description

panTro1.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(panTro1, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(panTro1.geneid.LENGTH)
head(panTro1.geneid.LENGTH)

panTro1.genscan.LENGTH

145

panTro1.genscan.LENGTH

Transcript length data for the organism panTro

Description

panTro1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(panTro1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(panTro1.genscan.LENGTH)
head(panTro1.genscan.LENGTH)

panTro1.xenoRefGene.LENGTH

Transcript length data for the organism panTro

Description

panTro1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(panTro1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(panTro1.xenoRefGene.LENGTH)
head(panTro1.xenoRefGene.LENGTH)

146

panTro2.geneSymbol.LENGTH

panTro2.ensGene.LENGTH

Transcript length data for the organism panTro

Description

panTro2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(panTro2, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(panTro2.ensGene.LENGTH)
head(panTro2.ensGene.LENGTH)

panTro2.geneSymbol.LENGTH

Transcript length data for the organism panTro

Description

panTro2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(panTro2, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(panTro2.geneSymbol.LENGTH)
head(panTro2.geneSymbol.LENGTH)

panTro2.genscan.LENGTH

147

panTro2.genscan.LENGTH

Transcript length data for the organism panTro

Description

panTro2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(panTro2, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(panTro2.genscan.LENGTH)
head(panTro2.genscan.LENGTH)

panTro2.nscanGene.LENGTH

Transcript length data for the organism panTro

Description

panTro2.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(panTro2, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(panTro2.nscanGene.LENGTH)
head(panTro2.nscanGene.LENGTH)

148

panTro2.xenoRefGene.LENGTH

panTro2.refGene.LENGTH

Transcript length data for the organism panTro

Description

panTro2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(panTro2, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(panTro2.refGene.LENGTH)
head(panTro2.refGene.LENGTH)

panTro2.xenoRefGene.LENGTH

Transcript length data for the organism panTro

Description

panTro2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(panTro2, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(panTro2.xenoRefGene.LENGTH)
head(panTro2.xenoRefGene.LENGTH)

petMar1.xenoRefGene.LENGTH

149

petMar1.xenoRefGene.LENGTH

Transcript length data for the organism petMar

Description

petMar1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(petMar1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(petMar1.xenoRefGene.LENGTH)
head(petMar1.xenoRefGene.LENGTH)

ponAbe2.ensGene.LENGTH

Transcript length data for the organism ponAbe

Description

ponAbe2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(ponAbe2, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ponAbe2.ensGene.LENGTH)
head(ponAbe2.ensGene.LENGTH)

150

ponAbe2.genscan.LENGTH

ponAbe2.geneSymbol.LENGTH

Transcript length data for the organism ponAbe

Description

ponAbe2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(ponAbe2, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ponAbe2.geneSymbol.LENGTH)
head(ponAbe2.geneSymbol.LENGTH)

ponAbe2.genscan.LENGTH

Transcript length data for the organism ponAbe

Description

ponAbe2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(ponAbe2, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ponAbe2.genscan.LENGTH)
head(ponAbe2.genscan.LENGTH)

ponAbe2.nscanGene.LENGTH

151

ponAbe2.nscanGene.LENGTH

Transcript length data for the organism ponAbe

Description

ponAbe2.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(ponAbe2, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ponAbe2.nscanGene.LENGTH)
head(ponAbe2.nscanGene.LENGTH)

ponAbe2.refGene.LENGTH

Transcript length data for the organism ponAbe

Description

ponAbe2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(ponAbe2, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ponAbe2.refGene.LENGTH)
head(ponAbe2.refGene.LENGTH)

152

priPac1.xenoRefGene.LENGTH

ponAbe2.xenoRefGene.LENGTH

Transcript length data for the organism ponAbe

Description

ponAbe2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(ponAbe2, xenoRefGene) on the
date on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(ponAbe2.xenoRefGene.LENGTH)
head(ponAbe2.xenoRefGene.LENGTH)

priPac1.xenoRefGene.LENGTH

Transcript length data for the organism priPac

Description

priPac1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(priPac1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(priPac1.xenoRefGene.LENGTH)
head(priPac1.xenoRefGene.LENGTH)

rheMac2.ensGene.LENGTH

153

rheMac2.ensGene.LENGTH

Transcript length data for the organism rheMac

Description

rheMac2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(rheMac2, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rheMac2.ensGene.LENGTH)
head(rheMac2.ensGene.LENGTH)

rheMac2.geneid.LENGTH Transcript length data for the organism rheMac

Description

rheMac2.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(rheMac2, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rheMac2.geneid.LENGTH)
head(rheMac2.geneid.LENGTH)

154

rheMac2.nscanGene.LENGTH

rheMac2.geneSymbol.LENGTH

Transcript length data for the organism rheMac

Description

rheMac2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(rheMac2, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rheMac2.geneSymbol.LENGTH)
head(rheMac2.geneSymbol.LENGTH)

rheMac2.nscanGene.LENGTH

Transcript length data for the organism rheMac

Description

rheMac2.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(rheMac2, nscanGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rheMac2.nscanGene.LENGTH)
head(rheMac2.nscanGene.LENGTH)

rheMac2.refGene.LENGTH

155

rheMac2.refGene.LENGTH

Transcript length data for the organism rheMac

Description

rheMac2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(rheMac2, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rheMac2.refGene.LENGTH)
head(rheMac2.refGene.LENGTH)

rheMac2.sgpGene.LENGTH

Transcript length data for the organism rheMac

Description

rheMac2.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(rheMac2, sgpGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rheMac2.sgpGene.LENGTH)
head(rheMac2.sgpGene.LENGTH)

156

rn3.ensGene.LENGTH

rheMac2.xenoRefGene.LENGTH

Transcript length data for the organism rheMac

Description

rheMac2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(rheMac2, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rheMac2.xenoRefGene.LENGTH)
head(rheMac2.xenoRefGene.LENGTH)

rn3.ensGene.LENGTH

Transcript length data for the organism rn

Description

rn3.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(rn3, ensGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn3.ensGene.LENGTH)
head(rn3.ensGene.LENGTH)

rn3.geneid.LENGTH

157

rn3.geneid.LENGTH

Transcript length data for the organism rn

Description

rn3.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(rn3, geneid) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn3.geneid.LENGTH)
head(rn3.geneid.LENGTH)

rn3.geneSymbol.LENGTH Transcript length data for the organism rn

Description

rn3.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(rn3, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn3.geneSymbol.LENGTH)
head(rn3.geneSymbol.LENGTH)

158

rn3.knownGene.LENGTH

rn3.genscan.LENGTH

Transcript length data for the organism rn

Description

rn3.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(rn3, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn3.genscan.LENGTH)
head(rn3.genscan.LENGTH)

rn3.knownGene.LENGTH

Transcript length data for the organism rn

Description

rn3.knownGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the knownGene table.

The data file was made by calling downloadLengthFromUCSC(rn3, knownGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn3.knownGene.LENGTH)
head(rn3.knownGene.LENGTH)

rn3.nscanGene.LENGTH

159

rn3.nscanGene.LENGTH

Transcript length data for the organism rn

Description

rn3.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(rn3, nscanGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn3.nscanGene.LENGTH)
head(rn3.nscanGene.LENGTH)

rn3.refGene.LENGTH

Transcript length data for the organism rn

Description

rn3.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(rn3, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn3.refGene.LENGTH)
head(rn3.refGene.LENGTH)

160

rn3.xenoRefGene.LENGTH

rn3.sgpGene.LENGTH

Transcript length data for the organism rn

Description

rn3.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(rn3, sgpGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn3.sgpGene.LENGTH)
head(rn3.sgpGene.LENGTH)

rn3.xenoRefGene.LENGTH

Transcript length data for the organism rn

Description

rn3.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(rn3, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn3.xenoRefGene.LENGTH)
head(rn3.xenoRefGene.LENGTH)

rn4.ensGene.LENGTH

161

rn4.ensGene.LENGTH

Transcript length data for the organism rn

Description

rn4.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(rn4, ensGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn4.ensGene.LENGTH)
head(rn4.ensGene.LENGTH)

rn4.geneid.LENGTH

Transcript length data for the organism rn

Description

rn4.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(rn4, geneid) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn4.geneid.LENGTH)
head(rn4.geneid.LENGTH)

162

rn4.genscan.LENGTH

rn4.geneSymbol.LENGTH Transcript length data for the organism rn

Description

rn4.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(rn4, geneSymbol) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn4.geneSymbol.LENGTH)
head(rn4.geneSymbol.LENGTH)

rn4.genscan.LENGTH

Transcript length data for the organism rn

Description

rn4.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(rn4, genscan) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn4.genscan.LENGTH)
head(rn4.genscan.LENGTH)

rn4.knownGene.LENGTH

163

rn4.knownGene.LENGTH

Transcript length data for the organism rn

Description

rn4.knownGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the knownGene table.

The data file was made by calling downloadLengthFromUCSC(rn4, knownGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn4.knownGene.LENGTH)
head(rn4.knownGene.LENGTH)

rn4.nscanGene.LENGTH

Transcript length data for the organism rn

Description

rn4.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(rn4, nscanGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn4.nscanGene.LENGTH)
head(rn4.nscanGene.LENGTH)

164

rn4.sgpGene.LENGTH

rn4.refGene.LENGTH

Transcript length data for the organism rn

Description

rn4.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(rn4, refGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn4.refGene.LENGTH)
head(rn4.refGene.LENGTH)

rn4.sgpGene.LENGTH

Transcript length data for the organism rn

Description

rn4.sgpGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the sgpGene table.

The data file was made by calling downloadLengthFromUCSC(rn4, sgpGene) on the date on which
the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn4.sgpGene.LENGTH)
head(rn4.sgpGene.LENGTH)

rn4.xenoRefGene.LENGTH

165

rn4.xenoRefGene.LENGTH

Transcript length data for the organism rn

Description

rn4.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(rn4, xenoRefGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(rn4.xenoRefGene.LENGTH)
head(rn4.xenoRefGene.LENGTH)

sacCer1.ensGene.LENGTH

Transcript length data for the organism sacCer

Description

sacCer1.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(sacCer1, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(sacCer1.ensGene.LENGTH)
head(sacCer1.ensGene.LENGTH)

166

strPur1.geneSymbol.LENGTH

sacCer2.ensGene.LENGTH

Transcript length data for the organism sacCer

Description

sacCer2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(sacCer2, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(sacCer2.ensGene.LENGTH)
head(sacCer2.ensGene.LENGTH)

strPur1.geneSymbol.LENGTH

Transcript length data for the organism strPur

Description

strPur1.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(strPur1, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(strPur1.geneSymbol.LENGTH)
head(strPur1.geneSymbol.LENGTH)

strPur1.genscan.LENGTH

167

strPur1.genscan.LENGTH

Transcript length data for the organism strPur

Description

strPur1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(strPur1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(strPur1.genscan.LENGTH)
head(strPur1.genscan.LENGTH)

strPur1.refGene.LENGTH

Transcript length data for the organism strPur

Description

strPur1.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(strPur1, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(strPur1.refGene.LENGTH)
head(strPur1.refGene.LENGTH)

168

strPur2.geneSymbol.LENGTH

strPur1.xenoRefGene.LENGTH

Transcript length data for the organism strPur

Description

strPur1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(strPur1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(strPur1.xenoRefGene.LENGTH)
head(strPur1.xenoRefGene.LENGTH)

strPur2.geneSymbol.LENGTH

Transcript length data for the organism strPur

Description

strPur2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(strPur2, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(strPur2.geneSymbol.LENGTH)
head(strPur2.geneSymbol.LENGTH)

strPur2.genscan.LENGTH

169

strPur2.genscan.LENGTH

Transcript length data for the organism strPur

Description

strPur2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(strPur2, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(strPur2.genscan.LENGTH)
head(strPur2.genscan.LENGTH)

strPur2.refGene.LENGTH

Transcript length data for the organism strPur

Description

strPur2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(strPur2, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(strPur2.refGene.LENGTH)
head(strPur2.refGene.LENGTH)

170

supportedGeneIDs

strPur2.xenoRefGene.LENGTH

Transcript length data for the organism strPur

Description

strPur2.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(strPur2, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(strPur2.xenoRefGene.LENGTH)
head(strPur2.xenoRefGene.LENGTH)

supportedGeneIDs

Supported Gene IDs

Description

Lists supported gene ID formats

Usage

supportedGeneIDs()

Details

Uses the supportedUCSCtables function from the GenomicFeatures package to obtain a list of
gene ID formats available from the UCSC genome browser. The db column gives the gene ID
formats which are provided to the id arguement of various functions. The track and subtrack
columns are the names of the UCSC track/subtrack from which information is fetched.
The GeneID column lists the "full name" of the gene ID format where available.
The final column, headed AvailableGenomes lists the genomes for which there is a local copy of
the length information avaible for the gene ID format listed in the geneLenDataBase package.

Value

A data.frame containing supported gene ID formats.

Author(s)

Matthew D. Young <myoung@wehi.edu.au>

171

supportedGenomes

Examples

supportedGeneIDs()

supportedGenomes

Supported Genomes

Description

Lists supported genomes

Usage

supportedGenomes()

Details

Uses the ucscGenomes() function from the rtracklayer package to obtain a list of genomes avail-
able from the UCSC genome browser. The db column lists genomes as they are provided to the
genome arguement of various functions.
The final column, headed AvailableGeneIDs lists the gene ID formats for which there is a local
copy of the length information avaible for the genome listed in the geneLenDataBase package.

Value

A data.frame containing supported genomes.

Author(s)

Matthew D. Young <myoung@wehi.edu.au>

Examples

supportedGenomes()

taeGut1.ensGene.LENGTH

Transcript length data for the organism taeGut

Description

taeGut1.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(taeGut1, ensGene) on the date on
which the package was last updated.

taeGut1.genscan.LENGTH

172

See Also

downloadLengthFromUCSC

Examples

data(taeGut1.ensGene.LENGTH)
head(taeGut1.ensGene.LENGTH)

taeGut1.geneSymbol.LENGTH

Transcript length data for the organism taeGut

Description

taeGut1.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(taeGut1, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(taeGut1.geneSymbol.LENGTH)
head(taeGut1.geneSymbol.LENGTH)

taeGut1.genscan.LENGTH

Transcript length data for the organism taeGut

Description

taeGut1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(taeGut1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(taeGut1.genscan.LENGTH)
head(taeGut1.genscan.LENGTH)

taeGut1.nscanGene.LENGTH

173

taeGut1.nscanGene.LENGTH

Transcript length data for the organism taeGut

Description

taeGut1.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(taeGut1, nscanGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(taeGut1.nscanGene.LENGTH)
head(taeGut1.nscanGene.LENGTH)

taeGut1.refGene.LENGTH

Transcript length data for the organism taeGut

Description

taeGut1.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(taeGut1, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(taeGut1.refGene.LENGTH)
head(taeGut1.refGene.LENGTH)

174

tetNig1.ensGene.LENGTH

taeGut1.xenoRefGene.LENGTH

Transcript length data for the organism taeGut

Description

taeGut1.xenoRefGene.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the xenoRefGene table.

The data file was made by calling downloadLengthFromUCSC(taeGut1, xenoRefGene) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(taeGut1.xenoRefGene.LENGTH)
head(taeGut1.xenoRefGene.LENGTH)

tetNig1.ensGene.LENGTH

Transcript length data for the organism tetNig

Description

tetNig1.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(tetNig1, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(tetNig1.ensGene.LENGTH)
head(tetNig1.ensGene.LENGTH)

tetNig1.geneid.LENGTH

175

tetNig1.geneid.LENGTH Transcript length data for the organism tetNig

Description

tetNig1.geneid.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneid table.

The data file was made by calling downloadLengthFromUCSC(tetNig1, geneid) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(tetNig1.geneid.LENGTH)
head(tetNig1.geneid.LENGTH)

tetNig1.genscan.LENGTH

Transcript length data for the organism tetNig

Description

tetNig1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their mature
mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its as-
sociated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(tetNig1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(tetNig1.genscan.LENGTH)
head(tetNig1.genscan.LENGTH)

176

tetNig2.ensGene.LENGTH

tetNig1.nscanGene.LENGTH

Transcript length data for the organism tetNig

Description

tetNig1.nscanGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the nscanGene table.

The data file was made by calling downloadLengthFromUCSC(tetNig1, nscanGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(tetNig1.nscanGene.LENGTH)
head(tetNig1.nscanGene.LENGTH)

tetNig2.ensGene.LENGTH

Transcript length data for the organism tetNig

Description

tetNig2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(tetNig2, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(tetNig2.ensGene.LENGTH)
head(tetNig2.ensGene.LENGTH)

unfactor

177

unfactor

Purge factors

Description

Removes all factors from a variable in a sensible way.

Usage

unfactor(var)

Arguments

var

Details

The variable from which you want the factors removed.

As factors are their own type, to remove factors we must convert each level into another type. This
is currently done using "typeless" behaviour: a factor is converted to a numeric vector if this can be
done without inducing NAs, otherwise it is coerced using as.character. Currently supported types
are: factor, data.frame and list.

Value

The variable with all factors converted to characters or numbers (see details).

Author(s)

Matthew D. Young <myoung@wehi.edu.au>

Examples

# A named factor
x <- factor(sample(1:6, 100, replace=TRUE))
names(x) <- paste("Roll.No", 1:100, sep='.')
x
unfactor(x)

# A data.frame
x <- data.frame(player <- c("Alice", "Bob", "Mary", "Fred"),

score <- factor(c(9, 7, 8, 9)), stringsAsFactors=TRUE)

x$player
x$score
y <- unfactor(x)
y$player
y$score

178

xenTro2.ensGene.LENGTH

xenTro1.genscan.LENGTH

Transcript length data for the organism xenTro

Description

xenTro1.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(xenTro1, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(xenTro1.genscan.LENGTH)
head(xenTro1.genscan.LENGTH)

xenTro2.ensGene.LENGTH

Transcript length data for the organism xenTro

Description

xenTro2.ensGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the ensGene table.

The data file was made by calling downloadLengthFromUCSC(xenTro2, ensGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(xenTro2.ensGene.LENGTH)
head(xenTro2.ensGene.LENGTH)

xenTro2.geneSymbol.LENGTH

179

xenTro2.geneSymbol.LENGTH

Transcript length data for the organism xenTro

Description

xenTro2.geneSymbol.LENGTH is an R object which maps transcripts to the length (in bp) of their
mature mRNA transcripts. Where available, it will also provide the mapping between a gene ID and
its associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the geneSymbol table.

The data file was made by calling downloadLengthFromUCSC(xenTro2, geneSymbol) on the date
on which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(xenTro2.geneSymbol.LENGTH)
head(xenTro2.geneSymbol.LENGTH)

xenTro2.genscan.LENGTH

Transcript length data for the organism xenTro

Description

xenTro2.genscan.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the genscan table.

The data file was made by calling downloadLengthFromUCSC(xenTro2, genscan) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(xenTro2.genscan.LENGTH)
head(xenTro2.genscan.LENGTH)

180

xenTro2.refGene.LENGTH

xenTro2.refGene.LENGTH

Transcript length data for the organism xenTro

Description

xenTro2.refGene.LENGTH is an R object which maps transcripts to the length (in bp) of their ma-
ture mRNA transcripts. Where available, it will also provide the mapping between a gene ID and its
associated transcripts. The data is obtained from the UCSC table browser (http://genome.ucsc.edu/cgi-
bin/hgTables) using the refGene table.

The data file was made by calling downloadLengthFromUCSC(xenTro2, refGene) on the date on
which the package was last updated.

See Also

downloadLengthFromUCSC

Examples

data(xenTro2.refGene.LENGTH)
head(xenTro2.refGene.LENGTH)

Index

∗ datasets

anoCar1.ensGene.LENGTH, 8
anoCar1.genscan.LENGTH, 9
anoCar1.xenoRefGene.LENGTH, 9
anoGam1.ensGene.LENGTH, 10
anoGam1.geneid.LENGTH, 10
anoGam1.genscan.LENGTH, 11
apiMel1.genscan.LENGTH, 11
apiMel2.ensGene.LENGTH, 12
apiMel2.geneid.LENGTH, 12
apiMel2.genscan.LENGTH, 13
aplCal1.xenoRefGene.LENGTH, 13
bosTau2.geneid.LENGTH, 14
bosTau2.geneSymbol.LENGTH, 14
bosTau2.genscan.LENGTH, 15
bosTau2.refGene.LENGTH, 15
bosTau2.sgpGene.LENGTH, 16
bosTau3.ensGene.LENGTH, 16
bosTau3.geneid.LENGTH, 17
bosTau3.geneSymbol.LENGTH, 17
bosTau3.genscan.LENGTH, 18
bosTau3.refGene.LENGTH, 18
bosTau3.sgpGene.LENGTH, 19
bosTau4.ensGene.LENGTH, 19
bosTau4.geneSymbol.LENGTH, 20
bosTau4.genscan.LENGTH, 20
bosTau4.nscanGene.LENGTH, 21
bosTau4.refGene.LENGTH, 21
braFlo1.xenoRefGene.LENGTH, 22
caeJap1.xenoRefGene.LENGTH, 22
caePb1.xenoRefGene.LENGTH, 23
caePb2.xenoRefGene.LENGTH, 23
caeRem2.xenoRefGene.LENGTH, 24
caeRem3.xenoRefGene.LENGTH, 24
calJac1.genscan.LENGTH, 25
calJac1.nscanGene.LENGTH, 25
calJac1.xenoRefGene.LENGTH, 26
canFam1.ensGene.LENGTH, 26
canFam1.geneSymbol.LENGTH, 27
canFam1.genscan.LENGTH, 27
canFam1.nscanGene.LENGTH, 28
canFam1.refGene.LENGTH, 28
canFam1.xenoRefGene.LENGTH, 29

canFam2.ensGene.LENGTH, 29
canFam2.geneSymbol.LENGTH, 30
canFam2.genscan.LENGTH, 30
canFam2.nscanGene.LENGTH, 31
canFam2.refGene.LENGTH, 31
canFam2.xenoRefGene.LENGTH, 32
cavPor3.ensGene.LENGTH, 32
cavPor3.genscan.LENGTH, 33
cavPor3.nscanGene.LENGTH, 33
cavPor3.xenoRefGene.LENGTH, 34
cb1.xenoRefGene.LENGTH, 34
cb3.xenoRefGene.LENGTH, 35
ce2.geneid.LENGTH, 35
ce2.geneSymbol.LENGTH, 36
ce2.refGene.LENGTH, 36
ce4.geneSymbol.LENGTH, 37
ce4.refGene.LENGTH, 37
ce4.xenoRefGene.LENGTH, 38
ce6.ensGene.LENGTH, 38
ce6.geneSymbol.LENGTH, 39
ce6.refGene.LENGTH, 39
ce6.xenoRefGene.LENGTH, 40
ci1.geneSymbol.LENGTH, 40
ci1.refGene.LENGTH, 41
ci1.xenoRefGene.LENGTH, 41
ci2.ensGene.LENGTH, 42
ci2.geneSymbol.LENGTH, 42
ci2.refGene.LENGTH, 43
ci2.xenoRefGene.LENGTH, 43
danRer3.ensGene.LENGTH, 44
danRer3.geneSymbol.LENGTH, 44
danRer3.refGene.LENGTH, 45
danRer4.ensGene.LENGTH, 45
danRer4.geneSymbol.LENGTH, 46
danRer4.genscan.LENGTH, 46
danRer4.nscanGene.LENGTH, 47
danRer4.refGene.LENGTH, 47
danRer5.ensGene.LENGTH, 48
danRer5.geneSymbol.LENGTH, 48
danRer5.refGene.LENGTH, 49
danRer5.vegaGene.LENGTH, 49
danRer5.vegaPseudoGene.LENGTH, 50
danRer6.ensGene.LENGTH, 50

181

182

INDEX

danRer6.geneSymbol.LENGTH, 51
danRer6.refGene.LENGTH, 51
danRer6.xenoRefGene.LENGTH, 52
dm1.geneSymbol.LENGTH, 52
dm1.genscan.LENGTH, 53
dm1.refGene.LENGTH, 53
dm2.geneid.LENGTH, 54
dm2.geneSymbol.LENGTH, 54
dm2.genscan.LENGTH, 55
dm2.nscanGene.LENGTH, 55
dm2.refGene.LENGTH, 56
dm3.geneSymbol.LENGTH, 56
dm3.nscanPasaGene.LENGTH, 57
dm3.refGene.LENGTH, 57
dp2.genscan.LENGTH, 59
dp2.xenoRefGene.LENGTH, 59
dp3.geneid.LENGTH, 60
dp3.genscan.LENGTH, 60
dp3.xenoRefGene.LENGTH, 61
droAna1.geneid.LENGTH, 61
droAna1.genscan.LENGTH, 62
droAna1.xenoRefGene.LENGTH, 62
droAna2.genscan.LENGTH, 63
droAna2.xenoRefGene.LENGTH, 63
droEre1.genscan.LENGTH, 64
droEre1.xenoRefGene.LENGTH, 64
droGri1.genscan.LENGTH, 65
droGri1.xenoRefGene.LENGTH, 65
droMoj1.geneid.LENGTH, 66
droMoj1.genscan.LENGTH, 66
droMoj1.xenoRefGene.LENGTH, 67
droMoj2.genscan.LENGTH, 67
droMoj2.xenoRefGene.LENGTH, 68
droPer1.genscan.LENGTH, 68
droPer1.xenoRefGene.LENGTH, 69
droSec1.genscan.LENGTH, 69
droSec1.xenoRefGene.LENGTH, 70
droSim1.geneid.LENGTH, 70
droSim1.genscan.LENGTH, 71
droSim1.xenoRefGene.LENGTH, 71
droVir1.geneid.LENGTH, 72
droVir1.genscan.LENGTH, 72
droVir1.xenoRefGene.LENGTH, 73
droVir2.genscan.LENGTH, 73
droVir2.xenoRefGene.LENGTH, 74
droYak1.geneid.LENGTH, 74
droYak1.genscan.LENGTH, 75
droYak1.xenoRefGene.LENGTH, 75
droYak2.genscan.LENGTH, 76
droYak2.xenoRefGene.LENGTH, 76
equCab1.geneid.LENGTH, 77
equCab1.geneSymbol.LENGTH, 77

equCab1.nscanGene.LENGTH, 78
equCab1.refGene.LENGTH, 78
equCab1.sgpGene.LENGTH, 79
equCab2.ensGene.LENGTH, 79
equCab2.geneSymbol.LENGTH, 80
equCab2.nscanGene.LENGTH, 80
equCab2.refGene.LENGTH, 81
equCab2.xenoRefGene.LENGTH, 81
felCat3.ensGene.LENGTH, 82
felCat3.geneid.LENGTH, 82
felCat3.geneSymbol.LENGTH, 83
felCat3.genscan.LENGTH, 83
felCat3.nscanGene.LENGTH, 84
felCat3.refGene.LENGTH, 84
felCat3.sgpGene.LENGTH, 85
felCat3.xenoRefGene.LENGTH, 85
fr1.ensGene.LENGTH, 86
fr1.genscan.LENGTH, 86
fr2.ensGene.LENGTH, 87
galGal2.ensGene.LENGTH, 87
galGal2.geneid.LENGTH, 88
galGal2.geneSymbol.LENGTH, 88
galGal2.genscan.LENGTH, 89
galGal2.refGene.LENGTH, 89
galGal2.sgpGene.LENGTH, 90
galGal3.ensGene.LENGTH, 90
galGal3.geneSymbol.LENGTH, 91
galGal3.genscan.LENGTH, 91
galGal3.nscanGene.LENGTH, 92
galGal3.refGene.LENGTH, 92
galGal3.xenoRefGene.LENGTH, 93
gasAcu1.ensGene.LENGTH, 93
gasAcu1.nscanGene.LENGTH, 94
hg16.acembly.LENGTH, 95
hg16.ensGene.LENGTH, 95
hg16.exoniphy.LENGTH, 96
hg16.geneid.LENGTH, 96
hg16.geneSymbol.LENGTH, 97
hg16.genscan.LENGTH, 97
hg16.knownGene.LENGTH, 98
hg16.refGene.LENGTH, 98
hg16.sgpGene.LENGTH, 99
hg17.acembly.LENGTH, 99
hg17.acescan.LENGTH, 100
hg17.ccdsGene.LENGTH, 100
hg17.ensGene.LENGTH, 101
hg17.exoniphy.LENGTH, 101
hg17.geneid.LENGTH, 102
hg17.geneSymbol.LENGTH, 102
hg17.genscan.LENGTH, 103
hg17.knownGene.LENGTH, 103
hg17.refGene.LENGTH, 104

INDEX

183

hg17.sgpGene.LENGTH, 104
hg17.vegaGene.LENGTH, 105
hg17.vegaPseudoGene.LENGTH, 105
hg17.xenoRefGene.LENGTH, 106
hg18.acembly.LENGTH, 106
hg18.acescan.LENGTH, 107
hg18.ccdsGene.LENGTH, 107
hg18.ensGene.LENGTH, 108
hg18.exoniphy.LENGTH, 108
hg18.geneid.LENGTH, 109
hg18.geneSymbol.LENGTH, 109
hg18.genscan.LENGTH, 110
hg18.knownGene.LENGTH, 110
hg18.knownGeneOld3.LENGTH, 111
hg18.refGene.LENGTH, 111
hg18.sgpGene.LENGTH, 112
hg18.sibGene.LENGTH, 112
hg18.xenoRefGene.LENGTH, 113
hg19.ccdsGene.LENGTH, 113
hg19.ensGene.LENGTH, 114
hg19.exoniphy.LENGTH, 114
hg19.geneSymbol.LENGTH, 115
hg19.knownGene.LENGTH, 115
hg19.nscanGene.LENGTH, 116
hg19.refGene.LENGTH, 116
hg19.xenoRefGene.LENGTH, 117
loxAfr3.xenoRefGene.LENGTH, 117
mm7.ensGene.LENGTH, 118
mm7.geneid.LENGTH, 118
mm7.geneSymbol.LENGTH, 119
mm7.genscan.LENGTH, 119
mm7.knownGene.LENGTH, 120
mm7.refGene.LENGTH, 120
mm7.sgpGene.LENGTH, 121
mm7.xenoRefGene.LENGTH, 121
mm8.ccdsGene.LENGTH, 122
mm8.ensGene.LENGTH, 122
mm8.geneid.LENGTH, 123
mm8.geneSymbol.LENGTH, 123
mm8.genscan.LENGTH, 124
mm8.knownGene.LENGTH, 124
mm8.nscanGene.LENGTH, 125
mm8.refGene.LENGTH, 125
mm8.sgpGene.LENGTH, 126
mm8.sibGene.LENGTH, 126
mm8.xenoRefGene.LENGTH, 127
mm9.acembly.LENGTH, 127
mm9.ccdsGene.LENGTH, 128
mm9.ensGene.LENGTH, 128
mm9.exoniphy.LENGTH, 129
mm9.geneid.LENGTH, 129
mm9.geneSymbol.LENGTH, 130

mm9.genscan.LENGTH, 130
mm9.knownGene.LENGTH, 131
mm9.nscanGene.LENGTH, 131
mm9.refGene.LENGTH, 132
mm9.sgpGene.LENGTH, 132
mm9.xenoRefGene.LENGTH, 133
monDom1.genscan.LENGTH, 133
monDom4.ensGene.LENGTH, 134
monDom4.geneSymbol.LENGTH, 134
monDom4.genscan.LENGTH, 135
monDom4.nscanGene.LENGTH, 135
monDom4.refGene.LENGTH, 136
monDom4.xenoRefGene.LENGTH, 136
monDom5.ensGene.LENGTH, 137
monDom5.geneSymbol.LENGTH, 137
monDom5.genscan.LENGTH, 138
monDom5.nscanGene.LENGTH, 138
monDom5.refGene.LENGTH, 139
monDom5.xenoRefGene.LENGTH, 139
ornAna1.ensGene.LENGTH, 140
ornAna1.geneSymbol.LENGTH, 140
ornAna1.refGene.LENGTH, 141
ornAna1.xenoRefGene.LENGTH, 141
oryLat2.ensGene.LENGTH, 142
oryLat2.geneSymbol.LENGTH, 142
oryLat2.refGene.LENGTH, 143
oryLat2.xenoRefGene.LENGTH, 143
panTro1.ensGene.LENGTH, 144
panTro1.geneid.LENGTH, 144
panTro1.genscan.LENGTH, 145
panTro1.xenoRefGene.LENGTH, 145
panTro2.ensGene.LENGTH, 146
panTro2.geneSymbol.LENGTH, 146
panTro2.genscan.LENGTH, 147
panTro2.nscanGene.LENGTH, 147
panTro2.refGene.LENGTH, 148
panTro2.xenoRefGene.LENGTH, 148
petMar1.xenoRefGene.LENGTH, 149
ponAbe2.ensGene.LENGTH, 149
ponAbe2.geneSymbol.LENGTH, 150
ponAbe2.genscan.LENGTH, 150
ponAbe2.nscanGene.LENGTH, 151
ponAbe2.refGene.LENGTH, 151
ponAbe2.xenoRefGene.LENGTH, 152
priPac1.xenoRefGene.LENGTH, 152
rheMac2.ensGene.LENGTH, 153
rheMac2.geneid.LENGTH, 153
rheMac2.geneSymbol.LENGTH, 154
rheMac2.nscanGene.LENGTH, 154
rheMac2.refGene.LENGTH, 155
rheMac2.sgpGene.LENGTH, 155
rheMac2.xenoRefGene.LENGTH, 156

184

INDEX

rn3.ensGene.LENGTH, 156
rn3.geneid.LENGTH, 157
rn3.geneSymbol.LENGTH, 157
rn3.genscan.LENGTH, 158
rn3.knownGene.LENGTH, 158
rn3.nscanGene.LENGTH, 159
rn3.refGene.LENGTH, 159
rn3.sgpGene.LENGTH, 160
rn3.xenoRefGene.LENGTH, 160
rn4.ensGene.LENGTH, 161
rn4.geneid.LENGTH, 161
rn4.geneSymbol.LENGTH, 162
rn4.genscan.LENGTH, 162
rn4.knownGene.LENGTH, 163
rn4.nscanGene.LENGTH, 163
rn4.refGene.LENGTH, 164
rn4.sgpGene.LENGTH, 164
rn4.xenoRefGene.LENGTH, 165
sacCer1.ensGene.LENGTH, 165
sacCer2.ensGene.LENGTH, 166
strPur1.geneSymbol.LENGTH, 166
strPur1.genscan.LENGTH, 167
strPur1.refGene.LENGTH, 167
strPur1.xenoRefGene.LENGTH, 168
strPur2.geneSymbol.LENGTH, 168
strPur2.genscan.LENGTH, 169
strPur2.refGene.LENGTH, 169
strPur2.xenoRefGene.LENGTH, 170
taeGut1.ensGene.LENGTH, 171
taeGut1.geneSymbol.LENGTH, 172
taeGut1.genscan.LENGTH, 172
taeGut1.nscanGene.LENGTH, 173
taeGut1.refGene.LENGTH, 173
taeGut1.xenoRefGene.LENGTH, 174
tetNig1.ensGene.LENGTH, 174
tetNig1.geneid.LENGTH, 175
tetNig1.genscan.LENGTH, 175
tetNig1.nscanGene.LENGTH, 176
tetNig2.ensGene.LENGTH, 176
xenTro1.genscan.LENGTH, 178
xenTro2.ensGene.LENGTH, 178
xenTro2.geneSymbol.LENGTH, 179
xenTro2.genscan.LENGTH, 179
xenTro2.refGene.LENGTH, 180

∗ internal

geneLenDatabase-pkg, 94

anoCar1.ensGene.LENGTH, 8
anoCar1.genscan.LENGTH, 9
anoCar1.xenoRefGene.LENGTH, 9
anoGam1.ensGene.LENGTH, 10
anoGam1.geneid.LENGTH, 10
anoGam1.genscan.LENGTH, 11

apiMel1.genscan.LENGTH, 11
apiMel2.ensGene.LENGTH, 12
apiMel2.geneid.LENGTH, 12
apiMel2.genscan.LENGTH, 13
aplCal1.xenoRefGene.LENGTH, 13

bosTau2.geneid.LENGTH, 14
bosTau2.geneSymbol.LENGTH, 14
bosTau2.genscan.LENGTH, 15
bosTau2.refGene.LENGTH, 15
bosTau2.sgpGene.LENGTH, 16
bosTau3.ensGene.LENGTH, 16
bosTau3.geneid.LENGTH, 17
bosTau3.geneSymbol.LENGTH, 17
bosTau3.genscan.LENGTH, 18
bosTau3.refGene.LENGTH, 18
bosTau3.sgpGene.LENGTH, 19
bosTau4.ensGene.LENGTH, 19
bosTau4.geneSymbol.LENGTH, 20
bosTau4.genscan.LENGTH, 20
bosTau4.nscanGene.LENGTH, 21
bosTau4.refGene.LENGTH, 21
braFlo1.xenoRefGene.LENGTH, 22

caeJap1.xenoRefGene.LENGTH, 22
caePb1.xenoRefGene.LENGTH, 23
caePb2.xenoRefGene.LENGTH, 23
caeRem2.xenoRefGene.LENGTH, 24
caeRem3.xenoRefGene.LENGTH, 24
calJac1.genscan.LENGTH, 25
calJac1.nscanGene.LENGTH, 25
calJac1.xenoRefGene.LENGTH, 26
canFam1.ensGene.LENGTH, 26
canFam1.geneSymbol.LENGTH, 27
canFam1.genscan.LENGTH, 27
canFam1.nscanGene.LENGTH, 28
canFam1.refGene.LENGTH, 28
canFam1.xenoRefGene.LENGTH, 29
canFam2.ensGene.LENGTH, 29
canFam2.geneSymbol.LENGTH, 30
canFam2.genscan.LENGTH, 30
canFam2.nscanGene.LENGTH, 31
canFam2.refGene.LENGTH, 31
canFam2.xenoRefGene.LENGTH, 32
cavPor3.ensGene.LENGTH, 32
cavPor3.genscan.LENGTH, 33
cavPor3.nscanGene.LENGTH, 33
cavPor3.xenoRefGene.LENGTH, 34
cb1.xenoRefGene.LENGTH, 34
cb3.xenoRefGene.LENGTH, 35
ce2.geneid.LENGTH, 35
ce2.geneSymbol.LENGTH, 36
ce2.refGene.LENGTH, 36

185

INDEX

ce4.geneSymbol.LENGTH, 37
ce4.refGene.LENGTH, 37
ce4.xenoRefGene.LENGTH, 38
ce6.ensGene.LENGTH, 38
ce6.geneSymbol.LENGTH, 39
ce6.refGene.LENGTH, 39
ce6.xenoRefGene.LENGTH, 40
ci1.geneSymbol.LENGTH, 40
ci1.refGene.LENGTH, 41
ci1.xenoRefGene.LENGTH, 41
ci2.ensGene.LENGTH, 42
ci2.geneSymbol.LENGTH, 42
ci2.refGene.LENGTH, 43
ci2.xenoRefGene.LENGTH, 43

danRer3.ensGene.LENGTH, 44
danRer3.geneSymbol.LENGTH, 44
danRer3.refGene.LENGTH, 45
danRer4.ensGene.LENGTH, 45
danRer4.geneSymbol.LENGTH, 46
danRer4.genscan.LENGTH, 46
danRer4.nscanGene.LENGTH, 47
danRer4.refGene.LENGTH, 47
danRer5.ensGene.LENGTH, 48
danRer5.geneSymbol.LENGTH, 48
danRer5.refGene.LENGTH, 49
danRer5.vegaGene.LENGTH, 49
danRer5.vegaPseudoGene.LENGTH, 50
danRer6.ensGene.LENGTH, 50
danRer6.geneSymbol.LENGTH, 51
danRer6.refGene.LENGTH, 51
danRer6.xenoRefGene.LENGTH, 52
dm1.geneSymbol.LENGTH, 52
dm1.genscan.LENGTH, 53
dm1.refGene.LENGTH, 53
dm2.geneid.LENGTH, 54
dm2.geneSymbol.LENGTH, 54
dm2.genscan.LENGTH, 55
dm2.nscanGene.LENGTH, 55
dm2.refGene.LENGTH, 56
dm3.geneSymbol.LENGTH, 56
dm3.nscanPasaGene.LENGTH, 57
dm3.refGene.LENGTH, 57
downloadLengthFromUCSC, 8–57, 58, 59–170,

172–176, 178–180

dp2.genscan.LENGTH, 59
dp2.xenoRefGene.LENGTH, 59
dp3.geneid.LENGTH, 60
dp3.genscan.LENGTH, 60
dp3.xenoRefGene.LENGTH, 61
droAna1.geneid.LENGTH, 61
droAna1.genscan.LENGTH, 62
droAna1.xenoRefGene.LENGTH, 62

droAna2.genscan.LENGTH, 63
droAna2.xenoRefGene.LENGTH, 63
droEre1.genscan.LENGTH, 64
droEre1.xenoRefGene.LENGTH, 64
droGri1.genscan.LENGTH, 65
droGri1.xenoRefGene.LENGTH, 65
droMoj1.geneid.LENGTH, 66
droMoj1.genscan.LENGTH, 66
droMoj1.xenoRefGene.LENGTH, 67
droMoj2.genscan.LENGTH, 67
droMoj2.xenoRefGene.LENGTH, 68
droPer1.genscan.LENGTH, 68
droPer1.xenoRefGene.LENGTH, 69
droSec1.genscan.LENGTH, 69
droSec1.xenoRefGene.LENGTH, 70
droSim1.geneid.LENGTH, 70
droSim1.genscan.LENGTH, 71
droSim1.xenoRefGene.LENGTH, 71
droVir1.geneid.LENGTH, 72
droVir1.genscan.LENGTH, 72
droVir1.xenoRefGene.LENGTH, 73
droVir2.genscan.LENGTH, 73
droVir2.xenoRefGene.LENGTH, 74
droYak1.geneid.LENGTH, 74
droYak1.genscan.LENGTH, 75
droYak1.xenoRefGene.LENGTH, 75
droYak2.genscan.LENGTH, 76
droYak2.xenoRefGene.LENGTH, 76

equCab1.geneid.LENGTH, 77
equCab1.geneSymbol.LENGTH, 77
equCab1.nscanGene.LENGTH, 78
equCab1.refGene.LENGTH, 78
equCab1.sgpGene.LENGTH, 79
equCab2.ensGene.LENGTH, 79
equCab2.geneSymbol.LENGTH, 80
equCab2.nscanGene.LENGTH, 80
equCab2.refGene.LENGTH, 81
equCab2.xenoRefGene.LENGTH, 81

felCat3.ensGene.LENGTH, 82
felCat3.geneid.LENGTH, 82
felCat3.geneSymbol.LENGTH, 83
felCat3.genscan.LENGTH, 83
felCat3.nscanGene.LENGTH, 84
felCat3.refGene.LENGTH, 84
felCat3.sgpGene.LENGTH, 85
felCat3.xenoRefGene.LENGTH, 85
fr1.ensGene.LENGTH, 86
fr1.genscan.LENGTH, 86
fr2.ensGene.LENGTH, 87

galGal2.ensGene.LENGTH, 87

186

INDEX

galGal2.geneid.LENGTH, 88
galGal2.geneSymbol.LENGTH, 88
galGal2.genscan.LENGTH, 89
galGal2.refGene.LENGTH, 89
galGal2.sgpGene.LENGTH, 90
galGal3.ensGene.LENGTH, 90
galGal3.geneSymbol.LENGTH, 91
galGal3.genscan.LENGTH, 91
galGal3.nscanGene.LENGTH, 92
galGal3.refGene.LENGTH, 92
galGal3.xenoRefGene.LENGTH, 93
gasAcu1.ensGene.LENGTH, 93
gasAcu1.nscanGene.LENGTH, 94
geneLenDataBase (geneLenDatabase-pkg),

94

geneLenDataBase-package

(geneLenDatabase-pkg), 94

geneLenDatabase-pkg, 94

hg16.acembly.LENGTH, 95
hg16.ensGene.LENGTH, 95
hg16.exoniphy.LENGTH, 96
hg16.geneid.LENGTH, 96
hg16.geneSymbol.LENGTH, 97
hg16.genscan.LENGTH, 97
hg16.knownGene.LENGTH, 98
hg16.refGene.LENGTH, 98
hg16.sgpGene.LENGTH, 99
hg17.acembly.LENGTH, 99
hg17.acescan.LENGTH, 100
hg17.ccdsGene.LENGTH, 100
hg17.ensGene.LENGTH, 101
hg17.exoniphy.LENGTH, 101
hg17.geneid.LENGTH, 102
hg17.geneSymbol.LENGTH, 102
hg17.genscan.LENGTH, 103
hg17.knownGene.LENGTH, 103
hg17.refGene.LENGTH, 104
hg17.sgpGene.LENGTH, 104
hg17.vegaGene.LENGTH, 105
hg17.vegaPseudoGene.LENGTH, 105
hg17.xenoRefGene.LENGTH, 106
hg18.acembly.LENGTH, 106
hg18.acescan.LENGTH, 107
hg18.ccdsGene.LENGTH, 107
hg18.ensGene.LENGTH, 108
hg18.exoniphy.LENGTH, 108
hg18.geneid.LENGTH, 109
hg18.geneSymbol.LENGTH, 109
hg18.genscan.LENGTH, 110
hg18.knownGene.LENGTH, 110
hg18.knownGeneOld3.LENGTH, 111
hg18.refGene.LENGTH, 111

hg18.sgpGene.LENGTH, 112
hg18.sibGene.LENGTH, 112
hg18.xenoRefGene.LENGTH, 113
hg19.ccdsGene.LENGTH, 113
hg19.ensGene.LENGTH, 114
hg19.exoniphy.LENGTH, 114
hg19.geneSymbol.LENGTH, 115
hg19.knownGene.LENGTH, 115
hg19.nscanGene.LENGTH, 116
hg19.refGene.LENGTH, 116
hg19.xenoRefGene.LENGTH, 117

loxAfr3.xenoRefGene.LENGTH, 117

mm7.ensGene.LENGTH, 118
mm7.geneid.LENGTH, 118
mm7.geneSymbol.LENGTH, 119
mm7.genscan.LENGTH, 119
mm7.knownGene.LENGTH, 120
mm7.refGene.LENGTH, 120
mm7.sgpGene.LENGTH, 121
mm7.xenoRefGene.LENGTH, 121
mm8.ccdsGene.LENGTH, 122
mm8.ensGene.LENGTH, 122
mm8.geneid.LENGTH, 123
mm8.geneSymbol.LENGTH, 123
mm8.genscan.LENGTH, 124
mm8.knownGene.LENGTH, 124
mm8.nscanGene.LENGTH, 125
mm8.refGene.LENGTH, 125
mm8.sgpGene.LENGTH, 126
mm8.sibGene.LENGTH, 126
mm8.xenoRefGene.LENGTH, 127
mm9.acembly.LENGTH, 127
mm9.ccdsGene.LENGTH, 128
mm9.ensGene.LENGTH, 128
mm9.exoniphy.LENGTH, 129
mm9.geneid.LENGTH, 129
mm9.geneSymbol.LENGTH, 130
mm9.genscan.LENGTH, 130
mm9.knownGene.LENGTH, 131
mm9.nscanGene.LENGTH, 131
mm9.refGene.LENGTH, 132
mm9.sgpGene.LENGTH, 132
mm9.xenoRefGene.LENGTH, 133
monDom1.genscan.LENGTH, 133
monDom4.ensGene.LENGTH, 134
monDom4.geneSymbol.LENGTH, 134
monDom4.genscan.LENGTH, 135
monDom4.nscanGene.LENGTH, 135
monDom4.refGene.LENGTH, 136
monDom4.xenoRefGene.LENGTH, 136
monDom5.ensGene.LENGTH, 137

187

rn4.genscan.LENGTH, 162
rn4.knownGene.LENGTH, 163
rn4.nscanGene.LENGTH, 163
rn4.refGene.LENGTH, 164
rn4.sgpGene.LENGTH, 164
rn4.xenoRefGene.LENGTH, 165

sacCer1.ensGene.LENGTH, 165
sacCer2.ensGene.LENGTH, 166
strPur1.geneSymbol.LENGTH, 166
strPur1.genscan.LENGTH, 167
strPur1.refGene.LENGTH, 167
strPur1.xenoRefGene.LENGTH, 168
strPur2.geneSymbol.LENGTH, 168
strPur2.genscan.LENGTH, 169
strPur2.refGene.LENGTH, 169
strPur2.xenoRefGene.LENGTH, 170
supportedGeneIDs, 58, 170
supportedGenomes, 58, 171

taeGut1.ensGene.LENGTH, 171
taeGut1.geneSymbol.LENGTH, 172
taeGut1.genscan.LENGTH, 172
taeGut1.nscanGene.LENGTH, 173
taeGut1.refGene.LENGTH, 173
taeGut1.xenoRefGene.LENGTH, 174
tetNig1.ensGene.LENGTH, 174
tetNig1.geneid.LENGTH, 175
tetNig1.genscan.LENGTH, 175
tetNig1.nscanGene.LENGTH, 176
tetNig2.ensGene.LENGTH, 176

unfactor, 177

xenTro1.genscan.LENGTH, 178
xenTro2.ensGene.LENGTH, 178
xenTro2.geneSymbol.LENGTH, 179
xenTro2.genscan.LENGTH, 179
xenTro2.refGene.LENGTH, 180

INDEX

monDom5.geneSymbol.LENGTH, 137
monDom5.genscan.LENGTH, 138
monDom5.nscanGene.LENGTH, 138
monDom5.refGene.LENGTH, 139
monDom5.xenoRefGene.LENGTH, 139

ornAna1.ensGene.LENGTH, 140
ornAna1.geneSymbol.LENGTH, 140
ornAna1.refGene.LENGTH, 141
ornAna1.xenoRefGene.LENGTH, 141
oryLat2.ensGene.LENGTH, 142
oryLat2.geneSymbol.LENGTH, 142
oryLat2.refGene.LENGTH, 143
oryLat2.xenoRefGene.LENGTH, 143

panTro1.ensGene.LENGTH, 144
panTro1.geneid.LENGTH, 144
panTro1.genscan.LENGTH, 145
panTro1.xenoRefGene.LENGTH, 145
panTro2.ensGene.LENGTH, 146
panTro2.geneSymbol.LENGTH, 146
panTro2.genscan.LENGTH, 147
panTro2.nscanGene.LENGTH, 147
panTro2.refGene.LENGTH, 148
panTro2.xenoRefGene.LENGTH, 148
petMar1.xenoRefGene.LENGTH, 149
ponAbe2.ensGene.LENGTH, 149
ponAbe2.geneSymbol.LENGTH, 150
ponAbe2.genscan.LENGTH, 150
ponAbe2.nscanGene.LENGTH, 151
ponAbe2.refGene.LENGTH, 151
ponAbe2.xenoRefGene.LENGTH, 152
priPac1.xenoRefGene.LENGTH, 152

rheMac2.ensGene.LENGTH, 153
rheMac2.geneid.LENGTH, 153
rheMac2.geneSymbol.LENGTH, 154
rheMac2.nscanGene.LENGTH, 154
rheMac2.refGene.LENGTH, 155
rheMac2.sgpGene.LENGTH, 155
rheMac2.xenoRefGene.LENGTH, 156
rn3.ensGene.LENGTH, 156
rn3.geneid.LENGTH, 157
rn3.geneSymbol.LENGTH, 157
rn3.genscan.LENGTH, 158
rn3.knownGene.LENGTH, 158
rn3.nscanGene.LENGTH, 159
rn3.refGene.LENGTH, 159
rn3.sgpGene.LENGTH, 160
rn3.xenoRefGene.LENGTH, 160
rn4.ensGene.LENGTH, 161
rn4.geneid.LENGTH, 161
rn4.geneSymbol.LENGTH, 162


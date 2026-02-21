MafDb.ESP6500SI.V2.SSA137.hs37d5
April 16, 2019

MafDb.ESP6500SI.V2.SSA137.hs37d5-package

Annotation package for minor allele frequency data from the NHLBI
ESP project

Description

This annotation package stores minor allele frequency (MAF) data values from the release ESP6500SI-
V2 of the NHLBI Exome Sequencing project (ESP). The data are exposed to the user in the form
of a GScores object, named after the package and loaded into main memory only as different chro-
mosomes and populations are being queried. The class deﬁnition and methods to access GScores
objects are found in the GenomicScores software package. To minimize disk space and memory
requirements, MAF values larger or equal than 0.1 are stored using two signiﬁcant digits, while
MAF values smaller than 0.1 are stored using one signiﬁcant digit.

Format

MafDb.ESP6500SI.V2.SSA137.hs37d5

GScores object containing MAF values from 6503 exomes downloaded on March 2018 from http://evs.gs.washington.edu/evs_bulk_data/ESP6500SI-V2-SSA137.GRCh38-liftover.snps_indels.vcf.tar.gz. See the inst/extdata/README ﬁle from the source code for more information on how to update these data.

Author(s)

R. Castelo

Source

Tennessen JA, et al. Evolution and functional impact of rare coding variation from deep sequencing
of human exomes. Science, 337:64-69, 2012.

Exome Variant Server, NHLBI GO Exome Sequencing Project (ESP), Seattle, WA (URL: http:
//evs.gs.washington.edu/EVS) [March, 2018, accessed]

See Also

GScores-class gscores GenomicScores

1

2

Examples

MafDb.ESP6500SI.V2.SSA137.hs37d5-package

library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
library(MafDb.ESP6500SI.V2.SSA137.hs37d5)

ls("package:MafDb.ESP6500SI.V2.SSA137.hs37d5")

mafdb <- MafDb.ESP6500SI.V2.SSA137.hs37d5
mafdb
citation(mafdb)

populations(mafdb)

## lookup allele frequencies for rs1129038, an SNP associated to blue and brown eye colors
## as reported in Eiberg et al. Blue eye color in humans may be caused by a perfectly associated
## founder mutation in a regulatory element located within the HERC2 gene inhibiting OCA2 expression.
## Human Genetics, 123(2):177-87, 2008 [http://www.ncbi.nlm.nih.gov/pubmed/18172690]

snpdb <- SNPlocs.Hsapiens.dbSNP144.GRCh37
rng <- snpsById(snpdb, ids="rs1129038")
rng
gscores(mafdb, rng)
gscores(mafdb, GRanges("15:28356859"))

Index

∗Topic data

MafDb.ESP6500SI.V2.SSA137.hs37d5-package,

1

∗Topic package

MafDb.ESP6500SI.V2.SSA137.hs37d5-package,

1

GenomicScores, 1
GScores, 1
gscores, 1
GScores-class, 1

MafDb.ESP6500SI.V2.SSA137.hs37d5, 1
MafDb.ESP6500SI.V2.SSA137.hs37d5

(MafDb.ESP6500SI.V2.SSA137.hs37d5-package),
1

MafDb.ESP6500SI.V2.SSA137.hs37d5-package,

1

3


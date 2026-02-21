MafDb.ESP6500SI.V2.SSA137.GRCh38
April 16, 2019

MafDb.ESP6500SI.V2.SSA137.GRCh38-package

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

WARNING: The positions associated to these MAF data are based on the GRCh38 release of the
human genome and they were lifted by the NHLBI ESP from GRCh37. This means, the variants
were not called directly on the GRCh38 human genome reference sequence. Moreover, nonSNVs
positions were lifted to single nucleotide positions and, for this reason, have been discarded in this
package.

Format

MafDb.ESP6500SI.V2.SSA137.GRCh38

GScores object containing MAF values from 6503 exomes downloaded on March 2018 from http://evs.gs.washington.edu/evs_bulk_data/ESP6500SI-V2-SSA137.GRCh38-liftover.snps_indels.vcf.tar.gz. The original data were derived from the human genome release GRCh37 and the data in this package were derived by lifting the associated genomic positions over to GRCh38. See the inst/extdata/README ﬁle from the source code for more information on how to update these data.

Author(s)

R. Castelo

Source

Tennessen JA, et al. Evolution and functional impact of rare coding variation from deep sequencing
of human exomes. Science, 337:64-69, 2012.

Exome Variant Server, NHLBI GO Exome Sequencing Project (ESP), Seattle, WA (URL: http:
//evs.gs.washington.edu/EVS) [March, 2018, accessed]

1

2

See Also

MafDb.ESP6500SI.V2.SSA137.GRCh38-package

GScores-class gscores GenomicScores

Examples

library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
library(MafDb.ESP6500SI.V2.SSA137.GRCh38)

ls("package:MafDb.ESP6500SI.V2.SSA137.GRCh38")

mafdb <- MafDb.ESP6500SI.V2.SSA137.GRCh38
mafdb
citation(mafdb)

populations(mafdb)

## lookup allele frequencies for rs1129038, an SNP associated to blue and brown eye colors
## as reported in Eiberg et al. Blue eye color in humans may be caused by a perfectly associated
## founder mutation in a regulatory element located within the HERC2 gene inhibiting OCA2 expression.
## Human Genetics, 123(2):177-87, 2008 [http://www.ncbi.nlm.nih.gov/pubmed/18172690]

snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38
rng <- snpsById(snpdb, ids="rs1129038")
rng
gscores(mafdb, rng)
gscores(mafdb, GRanges("15:28111713"))

Index

∗Topic data

MafDb.ESP6500SI.V2.SSA137.GRCh38-package,

1

∗Topic package

MafDb.ESP6500SI.V2.SSA137.GRCh38-package,

1

GenomicScores, 1, 2
GScores, 1
gscores, 2
GScores-class, 2

MafDb.ESP6500SI.V2.SSA137.GRCh38, 1
MafDb.ESP6500SI.V2.SSA137.GRCh38

(MafDb.ESP6500SI.V2.SSA137.GRCh38-package),
1

MafDb.ESP6500SI.V2.SSA137.GRCh38-package,

1

3


MafDb.1Kgenomes.phase3.GRCh38

February 25, 2026

MafDb.1Kgenomes.phase3.GRCh38-package

Annotation package for minor allele frequency data from the 1000
Genomes Project Phase 3

Description

This annotation package stores minor allele frequency (MAF) data from the Phase 3 of the 1000
Genomes Project. The data are exposed to the user in the form of a GScores object, named after the
package and loaded into memory only as different chromosomes and populations are being queried.
The class definition and methods to access GScores objects are found in the GenomicScores soft-
ware package. To minimize disk space and memory requirements, MAF values larger or equal than
0.1 are stored using two significant digits, while MAF values smaller than 0.1 are stored using one
significant digit.

Please consult the 1000 Genomes Project FAQ page at http://www.internationalgenome.org/
faq before you use these data for your own research.

Format

MafDb.1Kgenomes.phase3.GRCh38

GScores object containing MAF values from the 1000 Genomes Project Phase 3 downloaded on March 2018 from http://www.internationalgenome.org/data. The original data were derived from the human genome release GRCh37 and the data in this package were derived by lifting the associated genomic positions over to GRCh38. The lifted positions were downloaded from ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/supporting/GRCh38_positions. See the inst/extadata/README file from the source code for more information on how these data have been stored into this annnotation package.

Author(s)

R. Castelo

Source

The 1000 Genomes Project Consortium. A global reference for human genetic variation. Nature,
526:68-74, 2015.

The International Genome Sample Resource (IGSR), Hinxton, UK (URL: http://www.internationalgenome.
org) [March, 2018, accessed]

See Also

GScores-class gscores GenomicScores

1

MafDb.1Kgenomes.phase3.GRCh38-package

2

Examples

library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
library(MafDb.1Kgenomes.phase3.GRCh38)

ls("package:MafDb.1Kgenomes.phase3.GRCh38")

mafdb <- MafDb.1Kgenomes.phase3.GRCh38
mafdb
citation(mafdb)

populations(mafdb)

## lookup allele frequencies for rs1129038, a SNP associated to blue and brown eye colors
## as reported by Eiberg et al. Blue eye color in humans may be caused by a perfectly associated
## founder mutation in a regulatory element located within the HERC2 gene inhibiting OCA2 expression.
## Human Genetics, 123(2):177-87, 2008 [http://www.ncbi.nlm.nih.gov/pubmed/18172690]

snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38
rng <- snpsById(snpdb, ids="rs1129038")
rng
gscores(mafdb, rng)
gscores(mafdb, GRanges("15:28111713"))

Index

∗ data

MafDb.1Kgenomes.phase3.GRCh38-package,

1
∗ package

MafDb.1Kgenomes.phase3.GRCh38-package,

1

GenomicScores, 1
GScores, 1
gscores, 1
GScores-class, 1

MafDb.1Kgenomes.phase3.GRCh38

(MafDb.1Kgenomes.phase3.GRCh38-package),
1

MafDb.1Kgenomes.phase3.GRCh38-package,

1

3


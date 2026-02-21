MafDb.TOPMed.freeze5.hg38

February 11, 2026

MafDb.TOPMed.freeze5.hg38-package

Annotation package for minor allele frequency data from NHLBI
TOPMed freeze5

Description

This annotation package stores minor allele frequency (MAF) data from the NHLBI TOPMed
consortium, freeze5 version. The data are exposed to the user in the form of a GScores object,
named after the package and loaded into memory only as different chromosomes and populations
are being queried. The class definition and methods to access GScores objects are found in the
GenomicScores software package. To minimize disk space and memory requirements, MAF val-
ues larger or equal than 0.1 are stored using two significant digits, while MAF values smaller than
0.1 are stored using one significant digit.

Please consult the TOPMed page at https://bravo.sph.umich.edu before you use these data for
your own research.

Format

MafDb.TOPMed.freeze5.hg38

GScores object containing MAF values from the NHLBI TOPMed Consortium downloaded on March 2019 from https://bravo.sph.umich.edu/freeze5/hg38/download/all. See the inst/extadata/README file from the source code for more information on how these data have been stored into this annnotation package.

Author(s)

R. Castelo

Source

The NHLBI TOPMed Consortium. Trans-Omics for Precision Medicine (TOPMed), Ann Arbor,
USA (URL: https://bravo.sph.umich.edu) [October, 2019, accessed]

See Also

GScores-class gscores GenomicScores

1

MafDb.TOPMed.freeze5.hg38-package

2

Examples

library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
library(MafDb.TOPMed.freeze5.hg38)

ls("package:MafDb.TOPMed.freeze5.hg38")

mafdb <- MafDb.TOPMed.freeze5.hg38
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
seqlevelsStyle(rng) <- seqlevelsStyle(mafdb)
gscores(mafdb, rng)
gscores(mafdb, GRanges("chr15:28111713"))

Index

∗ data

MafDb.TOPMed.freeze5.hg38-package,

1
∗ package

MafDb.TOPMed.freeze5.hg38-package,

1

GenomicScores, 1
GScores, 1
gscores, 1
GScores-class, 1

MafDb.TOPMed.freeze5.hg38

(MafDb.TOPMed.freeze5.hg38-package),
1

MafDb.TOPMed.freeze5.hg38-package, 1

3


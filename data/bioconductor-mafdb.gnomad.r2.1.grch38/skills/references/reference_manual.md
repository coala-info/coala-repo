MafDb.gnomAD.r2.1.GRCh38

February 11, 2026

MafDb.gnomAD.r2.1.GRCh38-package

Annotation package for minor allele frequency data from the Genome
Aggregation Database

Description

This annotation package stores minor allele frequency (MAF) data derived from the whole genome
variant set release 2.1 of the Genome Aggregation Database (gnomAD). The data are exposed to the
user in the form of a GScores object, named after the package and loaded into main memory only
as different chromosomes and populations are being queried. The class definition and methods to
access GScores objects are found in the GenomicScores software package. To minimize disk space
and memory requirements, MAF values larger or equal than 0.1 are stored using two significant
digits, while MAF values smaller than 0.1 are stored using one significant digit.

Please consult the gnomAD FAQ page at http://gnomad.broadinstitute.org/faq before you
use these data for your own research.

Format

MafDb.gnomAD.r2.1.GRCh38

GScores object containing MAF values from gnomAD genomes downloaded on April 2019 from http://gnomad.broadinstitute.org/downloads. The original data were derived from the human genome release GRCh37 and the data in this package were derived by lifting the associated genomic positions over to GRCh38. The lifted positions were downloaded from ftp://ftp.ensembl.org/pub/data_files/homo_sapiens/GRCh38/variation_genotype. See the inst/extdata/README file from the source code for more information on how these data have been stored into this annotation package.

Author(s)

R. Castelo

Source

Karczewski et al. Variation across 141,456 human exomes and genomes reveals the spectrum of
loss-of-function intolerance across human protein-coding genes. bioRxiv, 531210, 2019.

The Genome Aggregation Database (gnomAD), Cambridge, MA (URL: http://gnomad.broadinstitute.
org) [April 2019, accessed]

See Also

GScores-class gscores GenomicScores

1

MafDb.gnomAD.r2.1.GRCh38-package

2

Examples

library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
library(MafDb.gnomAD.r2.1.GRCh38)

ls("package:MafDb.gnomAD.r2.1.GRCh38")

mafdb <- MafDb.gnomAD.r2.1.GRCh38
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

MafDb.gnomAD.r2.1.GRCh38-package,

1
∗ package

MafDb.gnomAD.r2.1.GRCh38-package,

1

GenomicScores, 1
GScores, 1
gscores, 1
GScores-class, 1

MafDb.gnomAD.r2.1.GRCh38, 1
MafDb.gnomAD.r2.1.GRCh38

(MafDb.gnomAD.r2.1.GRCh38-package),
1

MafDb.gnomAD.r2.1.GRCh38-package, 1

3


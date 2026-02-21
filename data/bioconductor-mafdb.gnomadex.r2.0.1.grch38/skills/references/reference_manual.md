MafDb.gnomADex.r2.0.1.GRCh38

April 16, 2019

MafDb.gnomADex.r2.0.1.GRCh38-package

Annotation package for minor allele frequency data from exomes of
the Genome Aggregation Database

Description

This annotation package stores minor allele frequency (MAF) data derived from the exome variant
set release 2.0.1 of the Genome Aggregation Database (gnomAD). The data are exposed to the
user in the form of a GScores object, named after the package and loaded into main memory only
as different chromosomes and populations are being queried. The class deﬁnition and methods to
access GScores objects are found in the GenomicScores software package. To minimize disk space
and memory requirements, MAF values larger or equal than 0.1 are stored using two signiﬁcant
digits, while MAF values smaller than 0.1 are stored using one signiﬁcant digit.

Please consult the gnomAD FAQ page at http://gnomad.broadinstitute.org/faq before you
use these data for your own research.

Format

MafDb.gnomADex.r2.0.1.GRCh38

GScores object containing MAF values from gnomAD exomes downloaded on March 2018 from http://gnomad.broadinstitute.org/downloads. The original data were derived from the human genome release GRCh37 and the data in this package were derived by lifting the associated genomic positions over to GRCh38. The lifted positions were downloaded from ftp://ftp.ensembl.org/pub/data_files/homo_sapiens/GRCh38/variation_genotype. See the inst/extdata/README ﬁle from the source code for more information on how these data have been stored into this annotation package.

Author(s)

R. Castelo

Source

Lek M et al. Analysis of protein-coding genetic variation in 60,706 humans. Nature, 536:285-291,
2016.

The Genome Aggregation Database (gnomAD), Cambridge, MA (URL: http://gnomad.broadinstitute.
org) [March, 2018, accessed]

1

MafDb.gnomADex.r2.0.1.GRCh38-package

2

See Also

GScores-class gscores GenomicScores

Examples

library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
library(MafDb.gnomADex.r2.0.1.GRCh38)

ls("package:MafDb.gnomADex.r2.0.1.GRCh38")

mafdb <- MafDb.gnomADex.r2.0.1.GRCh38
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

∗Topic data

MafDb.gnomADex.r2.0.1.GRCh38-package,

1

∗Topic package

MafDb.gnomADex.r2.0.1.GRCh38-package,

1

GenomicScores, 1, 2
GScores, 1
gscores, 2
GScores-class, 2

MafDb.gnomADex.r2.0.1.GRCh38, 1
MafDb.gnomADex.r2.0.1.GRCh38

(MafDb.gnomADex.r2.0.1.GRCh38-package),
1

MafDb.gnomADex.r2.0.1.GRCh38-package,

1

3


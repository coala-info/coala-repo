MafDb.ExAC.r1.0.nonTCGA.GRCh38

February 11, 2026

MafDb.ExAC.r1.0.nonTCGA.GRCh38-package

Annotation package for minor allele frequency data from the Exome
Aggregation Consortium

Description

This annotation package stores minor allele frequency (MAF) data derived from the variant set
release 1.0 of the Exome Aggregation Consortium (ExAC), excluding TCGA samples. The data are
exposed to the user in the form of a GScores object, named after the package and loaded into main
memory only as different chromosomes and populations are being queried. The class definition
and methods to access GScores objects are found in the GenomicScores software package. To
minimize disk space and memory requirements, MAF values larger or equal than 0.1 are stored
using two significant digits, while MAF values smaller than 0.1 are stored using one significant
digit.

Please consult the ExAC FAQ page at http://exac.broadinstitute.org/faq before you use
these data for your own research.

Format

MafDb.ExAC.r1.0.nonTCGA.GRCh38

GScores object containing MAF values from ExAC downloaded on March 2018 from http://exac.broadinstitute.org/downloads. The original data were derived from the human genome release GRCh37 and the data in this package were derived by lifting the associated genomic positions over to GRCh38, using the implementation of the liftOver tool (https://genome.ucsc.edu/cgi-bin/hgLiftOver in the rtracklayer Bioconductor package. See the inst/extdata/README file from the source code for more information on how these data have been stored into this package.

Author(s)

R. Castelo

Source

Lek M et al. Analysis of protein-coding genetic variation in 60,706 humans. Nature, 536:285-291,
2016.

The Exome Aggregation Consortium (ExAC), Cambridge, MA (URL: http://exac.broadinstitute.
org) [March, 2018, accessed]

1

MafDb.ExAC.r1.0.nonTCGA.GRCh38-package

2

See Also

GScores-class gscores GenomicScores

Examples

library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
library(MafDb.ExAC.r1.0.nonTCGA.GRCh38)

ls("package:MafDb.ExAC.r1.0.nonTCGA.GRCh38")

mafdb <- MafDb.ExAC.r1.0.nonTCGA.GRCh38
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

MafDb.ExAC.r1.0.nonTCGA.GRCh38-package,

1
∗ package

MafDb.ExAC.r1.0.nonTCGA.GRCh38-package,

1

GenomicScores, 1, 2
GScores, 1
gscores, 2
GScores-class, 2

MafDb.ExAC.r1.0.nonTCGA.GRCh38, 1
MafDb.ExAC.r1.0.nonTCGA.GRCh38

(MafDb.ExAC.r1.0.nonTCGA.GRCh38-package),
1

MafDb.ExAC.r1.0.nonTCGA.GRCh38-package,

1

3


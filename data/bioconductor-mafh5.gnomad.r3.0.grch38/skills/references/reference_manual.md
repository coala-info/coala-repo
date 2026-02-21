MafH5.gnomAD.r3.0.GRCh38

August 27, 2020

MafH5.gnomAD.r3.0.GRCh38-package

Annotation package for minor allele frequency data from the Genome
Aggregation Database

Description

This annotation package stores minor allele frequency (MAF) data derived from the whole genome
variant set release 3.0 of the Genome Aggregation Database (gnomAD). The data are exposed to the
user in the form of a GScores object, named after the package and loaded into main memory only
as different chromosomes and populations are being queried. The class deﬁnition and methods to
access GScores objects are found in the GenomicScores software package. To minimize disk space
and memory requirements, MAF values larger or equal than 0.1 are stored using two signiﬁcant
digits, while MAF values smaller than 0.1 are stored using one signiﬁcant digit. MAF data are
stored using a HDF5 backend, which minimizes de main memory footprint but whose performance
depends on the hard disk drive (HDD) reading performance. For this reason, this packages will
perform faster if it is installed in a local HDD rather than in network HDD (e.g., through NFS
access).

Please consult the gnomAD FAQ page at http://gnomad.broadinstitute.org/faq before you
use these data for your own research.

Format

MafH5.gnomAD.r3.0.GRCh38

GScores object containing MAF values from gnomAD genomes downloaded on October 2019 from http://gnomad.broadinstitute.org/downloads. See the extdata/README ﬁle for more information on how these data have been stored into this annotation package.

Author(s)

R. Castelo

Source

Karczewski et al. The mutational constraint spectrum quantiﬁed from variation in 141,456 humans.
bioRxiv, 531210, 2020.

1

2

MafH5.gnomAD.r3.0.GRCh38-package

The Genome Aggregation Database (gnomAD), Cambridge, MA (URL: http://gnomad.broadinstitute.
org) [October 2019, accessed]

See Also

GScores-class gscores GenomicScores

Examples

library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
library(MafH5.gnomAD.r3.0.GRCh38)

ls("package:MafH5.gnomAD.r3.0.GRCh38")

mafh5 <- MafH5.gnomAD.r3.0.GRCh38
mafh5
citation(mafh5)

populations(mafh5)

## lookup allele frequency for rs1129038, a SNP associated with blue and brown eye colors
## (Eiberg et al., Human Genetics, 2008). Blue eye color in humans may be caused by a
## perfectly associated founder mutation in a regulatory element located within the HERC2
## gene inhibiting OCA2 expression.

snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38
rng <- snpsById(snpdb, ids="rs1129038")
rng
gscores(mafh5, rng)
gscores(mafh5, GRanges("15:28111713"))

## lookup allele frequency for rs333, a deletion of 32 nucleotides (delta 32) within the CCR5 gene
## associated with resistance to an infection by HIV, the virus that causes AIDS. The homozygous
## state of this delta 32 allele has been reported to be highly protective against HIV-1
## infection (Huang et al., Nature Medicine, 1996) but with no effects on lifespan (Maier et al.,
## bioRxiv, 2019, Gudbjartsson et al., bioRxiv, 2019; Karczewski et al., bioRxiv 2019).

gscores(mafh5, GRanges("3:46373452-46373484"), type="nonsnrs")

Index

∗ data

MafH5.gnomAD.r3.0.GRCh38-package,

1
∗ package

MafH5.gnomAD.r3.0.GRCh38-package,

1

GenomicScores, 1, 2
GScores, 1
gscores, 2
GScores-class, 2

MafH5.gnomAD.r3.0.GRCh38, 1
MafH5.gnomAD.r3.0.GRCh38

(MafH5.gnomAD.r3.0.GRCh38-package),
1

MafH5.gnomAD.r3.0.GRCh38-package, 1

3


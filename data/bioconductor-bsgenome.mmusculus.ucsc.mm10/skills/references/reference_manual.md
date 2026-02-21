BSgenome.Mmusculus.UCSC.mm10

February 11, 2026

BSgenome.Mmusculus.UCSC.mm10

Full genome sequences for Mus musculus (UCSC version mm10,
based on GRCm38.p6)

Description

Full genome sequences for Mus musculus (Mouse) as provided by UCSC (mm10, based on GRCm38.p6)
and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

mm10.p6.2bit, downloaded from https://hgdownload.soe.ucsc.edu/goldenPath/mm10/bigZips/p6/ on July 1st, 2021

See ?BSgenomeForge and the BSgenomeForge vignette (vignette("BSgenomeForge")) in the
BSgenome software package for how to make a BSgenome data package.

Author(s)

The Bioconductor Dev Team

See Also

• BSgenome objects and the available.genomes function in the BSgenome software package.

• DNAString objects in the Biostrings package.

• The BSgenomeForge vignette (vignette("BSgenomeForge")) in the BSgenome software

package for how to make a BSgenome data package.

1

2

Examples

BSgenome.Mmusculus.UCSC.mm10
genome <- BSgenome.Mmusculus.UCSC.mm10
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

BSgenome.Mmusculus.UCSC.mm10

## ---------------------------------------------------------------------
## Genome-wide motif searching
## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Mmusculus.UCSC.mm10, 1

∗ package

BSgenome.Mmusculus.UCSC.mm10, 1

available.genomes, 1

BSgenome, 1
BSgenome.Mmusculus.UCSC.mm10, 1
BSgenome.Mmusculus.UCSC.mm10-package

(BSgenome.Mmusculus.UCSC.mm10),
1
BSgenomeForge, 1

DNAString, 1

Mmusculus

(BSgenome.Mmusculus.UCSC.mm10),
1

3


BSgenome.Mmusculus.UCSC.mm39

February 11, 2026

BSgenome.Mmusculus.UCSC.mm39

Full genome sequences for Mus musculus (UCSC genome mm39,
based on GRCm39)

Description

Full genome sequences for Mus musculus (Mouse) as provided by UCSC (genome mm39, based
on assembly GRCm39) and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

mm39.2bit, downloaded from https://hgdownload.soe.ucsc.edu/goldenPath/mm39/bigZips/ on August 30, 2021

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

BSgenome.Mmusculus.UCSC.mm39
genome <- BSgenome.Mmusculus.UCSC.mm39
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

BSgenome.Mmusculus.UCSC.mm39

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

BSgenome.Mmusculus.UCSC.mm39, 1

∗ package

BSgenome.Mmusculus.UCSC.mm39, 1

available.genomes, 1

BSgenome, 1
BSgenome.Mmusculus.UCSC.mm39, 1
BSgenome.Mmusculus.UCSC.mm39-package

(BSgenome.Mmusculus.UCSC.mm39),
1
BSgenomeForge, 1

DNAString, 1

Mmusculus

(BSgenome.Mmusculus.UCSC.mm39),
1

3


BSgenome.Mfuro.UCSC.musFur1

February 11, 2026

BSgenome.Mfuro.UCSC.musFur1

Full genome sequences for Mustela putorius furo (UCSC version mus-
Fur1)

Description

Full genome sequences for Mustela putorius furo (Ferret) as provided by UCSC (musFur1, Apr.
2011) and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

musFur1.2bit from http://hgdownload.soe.ucsc.edu/goldenPath/musFur1/bigZips/

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

BSgenome.Mfuro.UCSC.musFur1

BSgenome.Mfuro.UCSC.musFur1
genome <- BSgenome.Mfuro.UCSC.musFur1
seqlengths(genome)
genome$GL896898 # same as genome[["GL896898"]]

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

BSgenome.Mfuro.UCSC.musFur1, 1

∗ package

BSgenome.Mfuro.UCSC.musFur1, 1

available.genomes, 1

BSgenome, 1
BSgenome.Mfuro.UCSC.musFur1, 1
BSgenome.Mfuro.UCSC.musFur1-package

(BSgenome.Mfuro.UCSC.musFur1),
1
BSgenomeForge, 1

DNAString, 1

Mfuro (BSgenome.Mfuro.UCSC.musFur1), 1

3


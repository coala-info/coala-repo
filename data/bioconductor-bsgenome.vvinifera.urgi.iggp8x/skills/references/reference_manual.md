BSgenome.Vvinifera.URGI.IGGP8X

February 11, 2026

BSgenome.Vvinifera.URGI.IGGP8X

Full reference nuclear genome sequences for Vitis vinifera subsp.
vinifera PN40024 (IGGP version 8X)

Description

Full reference nuclear genome sequences for Vitis vinifera subsp. vinifera PN40024 (derived from
Pinot Noir and close to homozygosity after 6-9 rounds of selfing) as assembled by the IGGP (version
8X) and available at the URGI (INRA). More details in Jaillon et al (Nature, 2007).

Note

This BSgenome data package was made from the following source data files:

https://urgi.versailles.inra.fr/download/vitis/VV_chr12x.fsa.zip

See ?BSgenomeForge and the BSgenomeForge vignette (vignette("BSgenomeForge")) in the
BSgenome software package for how to make a BSgenome data package.

Author(s)

Timothee Flutre [cre,aut]

See Also

• BSgenome objects and the available.genomes function in the BSgenome software package.

• DNAString objects in the Biostrings package.

• The BSgenomeForge vignette (vignette("BSgenomeForge")) in the BSgenome software

package for how to make a BSgenome data package.

1

2

Examples

BSgenome.Vvinifera.URGI.IGGP8X
genome <- BSgenome.Vvinifera.URGI.IGGP8X
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

BSgenome.Vvinifera.URGI.IGGP8X

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

BSgenome.Vvinifera.URGI.IGGP8X, 1

∗ package

BSgenome.Vvinifera.URGI.IGGP8X, 1

available.genomes, 1

BSgenome, 1
BSgenome.Vvinifera.URGI.IGGP8X, 1
BSgenome.Vvinifera.URGI.IGGP8X-package

(BSgenome.Vvinifera.URGI.IGGP8X),
1
BSgenomeForge, 1

DNAString, 1

Vvinifera

(BSgenome.Vvinifera.URGI.IGGP8X),
1

3


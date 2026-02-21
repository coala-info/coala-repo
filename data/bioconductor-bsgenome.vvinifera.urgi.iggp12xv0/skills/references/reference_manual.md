BSgenome.Vvinifera.URGI.IGGP12Xv0

February 11, 2026

BSgenome.Vvinifera.URGI.IGGP12Xv0

Full reference nuclear genome sequences for Vitis vinifera subsp.
vinifera PN40024 (IGGP version 12Xv0)

Description

Full reference nuclear genome sequences for Vitis vinifera subsp. vinifera PN40024 (derived from
Pinot Noir and close to homozygosity after 6-9 rounds of selfing) as assembled by the IGGP (version
12Xv0) and available at the URGI (INRA)

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

BSgenome.Vvinifera.URGI.IGGP12Xv0
genome <- BSgenome.Vvinifera.URGI.IGGP12Xv0
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

BSgenome.Vvinifera.URGI.IGGP12Xv0

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

BSgenome.Vvinifera.URGI.IGGP12Xv0,

1
∗ package

BSgenome.Vvinifera.URGI.IGGP12Xv0,

1

available.genomes, 1

BSgenome, 1
BSgenome.Vvinifera.URGI.IGGP12Xv0, 1
BSgenome.Vvinifera.URGI.IGGP12Xv0-package

(BSgenome.Vvinifera.URGI.IGGP12Xv0),
1
BSgenomeForge, 1

DNAString, 1

Vvinifera

(BSgenome.Vvinifera.URGI.IGGP12Xv0),
1

3


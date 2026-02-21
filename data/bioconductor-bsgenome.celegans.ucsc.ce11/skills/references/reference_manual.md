BSgenome.Celegans.UCSC.ce11

February 11, 2026

BSgenome.Celegans.UCSC.ce11

Full genome sequences for Caenorhabditis elegans (UCSC version
ce11)

Description

Full genome sequences for Caenorhabditis elegans (Worm) as provided by UCSC (ce11, Feb. 2013)
and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

ce11.2bit from http://hgdownload.soe.ucsc.edu/goldenPath/ce11/bigZips/

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

BSgenome.Celegans.UCSC.ce11
genome <- BSgenome.Celegans.UCSC.ce11
head(seqlengths(genome))
genome$chrI # same as genome[["chrI"]]

BSgenome.Celegans.UCSC.ce11

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

BSgenome.Celegans.UCSC.ce11, 1

∗ package

BSgenome.Celegans.UCSC.ce11, 1

available.genomes, 1

BSgenome, 1
BSgenome.Celegans.UCSC.ce11, 1
BSgenome.Celegans.UCSC.ce11-package

(BSgenome.Celegans.UCSC.ce11),
1
BSgenomeForge, 1

Celegans (BSgenome.Celegans.UCSC.ce11),

1

DNAString, 1

3


BSgenome.Cjacchus.UCSC.calJac4

February 11, 2026

BSgenome.Cjacchus.UCSC.calJac4

Full genome sequences for Callithrix jacchus (UCSC version calJac4)

Description

Full genome sequences for Callithrix jacchus (Marmoset) as provided by UCSC (calJac4, May
2020) and wrapped in a BSgenome object.

Note

This BSgenome data package was made from the following source data files:

calJac4.2bit from http://hgdownload.cse.ucsc.edu/goldenPath/calJac4/bigZips/

See ?BSgenomeForge and the BSgenomeForge vignette (vignette("BSgenomeForge")) in the
BSgenome software package for how to make a BSgenome data package.

Author(s)

The Bioconductor Dev Team

See Also

• BSgenome objects and the available.genomes function in the BSgenome software package.

• DNAString objects in the Biostrings package.

• The BSgenomeForge vignette (vignette("BSgenomeForge")) in the BSgenome software

package for how to make a BSgenome data package.

Examples

BSgenome.Cjacchus.UCSC.calJac4
genome <- BSgenome.Cjacchus.UCSC.calJac4
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

## ---------------------------------------------------------------------
## Genome-wide motif searching

1

2

BSgenome.Cjacchus.UCSC.calJac4

## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Cjacchus.UCSC.calJac4, 1

∗ package

BSgenome.Cjacchus.UCSC.calJac4, 1

available.genomes, 1

BSgenome, 1
BSgenome.Cjacchus.UCSC.calJac4, 1
BSgenome.Cjacchus.UCSC.calJac4-package

(BSgenome.Cjacchus.UCSC.calJac4),
1
BSgenomeForge, 1

Cjacchus

(BSgenome.Cjacchus.UCSC.calJac4),
1

DNAString, 1

3


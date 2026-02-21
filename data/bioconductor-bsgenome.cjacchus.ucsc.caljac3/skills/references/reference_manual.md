BSgenome.Cjacchus.UCSC.calJac3

February 11, 2026

BSgenome.Cjacchus.UCSC.calJac3

Full genome sequences for Callithrix jacchus (UCSC version calJac3)

Description

Full genome sequences for Callithrix jacchus (Marmoset) as provided by UCSC (calJac3, Mar.
2009) and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

calJac3.2bit from http://hgdownload.cse.ucsc.edu/goldenPath/calJac3/bigZips/

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

BSgenome.Cjacchus.UCSC.calJac3
genome <- BSgenome.Cjacchus.UCSC.calJac3
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

## ---------------------------------------------------------------------
## Genome-wide motif searching

1

2

BSgenome.Cjacchus.UCSC.calJac3

## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Cjacchus.UCSC.calJac3, 1

∗ package

BSgenome.Cjacchus.UCSC.calJac3, 1

available.genomes, 1

BSgenome, 1
BSgenome.Cjacchus.UCSC.calJac3, 1
BSgenome.Cjacchus.UCSC.calJac3-package

(BSgenome.Cjacchus.UCSC.calJac3),
1
BSgenomeForge, 1

Cjacchus

(BSgenome.Cjacchus.UCSC.calJac3),
1

DNAString, 1

3


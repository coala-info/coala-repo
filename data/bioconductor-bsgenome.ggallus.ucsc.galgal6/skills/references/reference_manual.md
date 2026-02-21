BSgenome.Ggallus.UCSC.galGal6

February 11, 2026

BSgenome.Ggallus.UCSC.galGal6

Full genome sequences for Gallus gallus (UCSC version galGal6)

Description

Full genome sequences for Gallus gallus (Chicken) as provided by UCSC (galGal6, Mar. 2018) and
stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

galGal6.2bit from http://hgdownload.cse.ucsc.edu/goldenPath/galGal6/bigZips/

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

BSgenome.Ggallus.UCSC.galGal6
genome <- BSgenome.Ggallus.UCSC.galGal6
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

## ---------------------------------------------------------------------
## Genome-wide motif searching

1

2

BSgenome.Ggallus.UCSC.galGal6

## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Ggallus.UCSC.galGal6, 1

∗ package

BSgenome.Ggallus.UCSC.galGal6, 1

available.genomes, 1

BSgenome, 1
BSgenome.Ggallus.UCSC.galGal6, 1
BSgenome.Ggallus.UCSC.galGal6-package

(BSgenome.Ggallus.UCSC.galGal6),
1
BSgenomeForge, 1

DNAString, 1

Ggallus

(BSgenome.Ggallus.UCSC.galGal6),
1

3


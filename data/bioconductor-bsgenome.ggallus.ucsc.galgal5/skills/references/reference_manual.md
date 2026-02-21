BSgenome.Ggallus.UCSC.galGal5

February 11, 2026

BSgenome.Ggallus.UCSC.galGal5

Full genome sequences for Gallus gallus (UCSC version galGal5)

Description

Full genome sequences for Gallus gallus (Chicken) as provided by UCSC (galGal5, Dec. 2015) and
stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

galGal5.2bit from http://hgdownload.cse.ucsc.edu/goldenPath/galGal5/bigZips/

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

BSgenome.Ggallus.UCSC.galGal5
genome <- BSgenome.Ggallus.UCSC.galGal5
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

## ---------------------------------------------------------------------
## Genome-wide motif searching

1

2

BSgenome.Ggallus.UCSC.galGal5

## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Ggallus.UCSC.galGal5, 1

∗ package

BSgenome.Ggallus.UCSC.galGal5, 1

available.genomes, 1

BSgenome, 1
BSgenome.Ggallus.UCSC.galGal5, 1
BSgenome.Ggallus.UCSC.galGal5-package

(BSgenome.Ggallus.UCSC.galGal5),
1
BSgenomeForge, 1

DNAString, 1

Ggallus

(BSgenome.Ggallus.UCSC.galGal5),
1

3


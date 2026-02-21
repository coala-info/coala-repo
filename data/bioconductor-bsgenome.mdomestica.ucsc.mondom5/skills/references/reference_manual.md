BSgenome.Mdomestica.UCSC.monDom5

February 11, 2026

BSgenome.Mdomestica.UCSC.monDom5

Full genome sequences for Monodelphis domestica (UCSC version
monDom5)

Description

Full genome sequences for Monodelphis domestica (Opossum) as provided by UCSC (monDom5,
Oct. 2006) and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

monDom5.2bit from http://hgdownload.cse.ucsc.edu/goldenPath/monDom5/bigZips/

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

BSgenome.Mdomestica.UCSC.monDom5
genome <- BSgenome.Mdomestica.UCSC.monDom5
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

BSgenome.Mdomestica.UCSC.monDom5

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

BSgenome.Mdomestica.UCSC.monDom5,

1
∗ package

BSgenome.Mdomestica.UCSC.monDom5,

1

available.genomes, 1

BSgenome, 1
BSgenome.Mdomestica.UCSC.monDom5, 1
BSgenome.Mdomestica.UCSC.monDom5-package

(BSgenome.Mdomestica.UCSC.monDom5),
1
BSgenomeForge, 1

DNAString, 1

Mdomestica

(BSgenome.Mdomestica.UCSC.monDom5),
1

3


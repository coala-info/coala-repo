BSgenome.Sscrofa.UCSC.susScr11

February 11, 2026

BSgenome.Sscrofa.UCSC.susScr11

Full genome sequences for Sus scrofa (UCSC version susScr11)

Description

Full genome sequences for Sus scrofa (Pig) as provided by UCSC (susScr11, Feb. 2017) and stored
in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

susScr11.2bit from http://hgdownload.cse.ucsc.edu/goldenPath/susScr11/bigZips/

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

BSgenome.Sscrofa.UCSC.susScr11
genome <- BSgenome.Sscrofa.UCSC.susScr11
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

## ---------------------------------------------------------------------
## Genome-wide motif searching

1

2

BSgenome.Sscrofa.UCSC.susScr11

## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Sscrofa.UCSC.susScr11, 1

∗ package

BSgenome.Sscrofa.UCSC.susScr11, 1

available.genomes, 1

BSgenome, 1
BSgenome.Sscrofa.UCSC.susScr11, 1
BSgenome.Sscrofa.UCSC.susScr11-package

(BSgenome.Sscrofa.UCSC.susScr11),
1
BSgenomeForge, 1

DNAString, 1

Sscrofa

(BSgenome.Sscrofa.UCSC.susScr11),
1

3


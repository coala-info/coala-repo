BSgenome.Scerevisiae.UCSC.sacCer2

February 11, 2026

BSgenome.Scerevisiae.UCSC.sacCer2

Saccharomyces cerevisiae (Yeast) full genome (UCSC version sac-
Cer2)

Description

Saccharomyces cerevisiae (Yeast) full genome as provided by UCSC (sacCer2, June 2008) and
stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

chromFa.tar.gz from http://hgdownload.cse.ucsc.edu/goldenPath/sacCer2/bigZips/

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

BSgenome.Scerevisiae.UCSC.sacCer2
genome <- BSgenome.Scerevisiae.UCSC.sacCer2
seqlengths(genome)
genome$chrI # same as genome[["chrI"]]

BSgenome.Scerevisiae.UCSC.sacCer2

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

BSgenome.Scerevisiae.UCSC.sacCer2,

1
∗ package

BSgenome.Scerevisiae.UCSC.sacCer2,

1

available.genomes, 1

BSgenome, 1
BSgenome.Scerevisiae.UCSC.sacCer2, 1
BSgenome.Scerevisiae.UCSC.sacCer2-package

(BSgenome.Scerevisiae.UCSC.sacCer2),
1
BSgenomeForge, 1

DNAString, 1

Scerevisiae

(BSgenome.Scerevisiae.UCSC.sacCer2),
1

3


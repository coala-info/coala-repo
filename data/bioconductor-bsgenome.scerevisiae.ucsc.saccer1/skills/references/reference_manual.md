BSgenome.Scerevisiae.UCSC.sacCer1

February 11, 2026

BSgenome.Scerevisiae.UCSC.sacCer1

Saccharomyces cerevisiae (Yeast) full genome (UCSC version sac-
Cer1)

Description

Saccharomyces cerevisiae (Yeast) full genome as provided by UCSC (sacCer1, Oct. 2003) and
stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

chromFa.zip from http://hgdownload.cse.ucsc.edu/goldenPath/sacCer1/bigZips/

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

BSgenome.Scerevisiae.UCSC.sacCer1
genome <- BSgenome.Scerevisiae.UCSC.sacCer1
seqlengths(genome)
genome$chr1 # same as genome[["chr1"]]

BSgenome.Scerevisiae.UCSC.sacCer1

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

BSgenome.Scerevisiae.UCSC.sacCer1,

1
∗ package

BSgenome.Scerevisiae.UCSC.sacCer1,

1

available.genomes, 1

BSgenome, 1
BSgenome.Scerevisiae.UCSC.sacCer1, 1
BSgenome.Scerevisiae.UCSC.sacCer1-package

(BSgenome.Scerevisiae.UCSC.sacCer1),
1
BSgenomeForge, 1

DNAString, 1

Scerevisiae

(BSgenome.Scerevisiae.UCSC.sacCer1),
1

3


BSgenome.Hsapiens.UCSC.hs1

February 11, 2026

BSgenome.Hsapiens.UCSC.hs1

Full genomic sequences for UCSC genome hs1 (Homo sapiens)

Description

Full genomic sequences for UCSC genome hs1 (the hs1 genome is based on assembly T2T-CHM13v2.0,
with GenBank assembly accession GCA_009914755.4). The sequences are stored in DNAString
objects.

Note

This BSgenome data package was made from the following source data files:

hs1.2bit, downloaded from https://hgdownload.soe.ucsc.edu/goldenPath/hs1/bigZips/ on 2023-01-03

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

BSgenome.Hsapiens.UCSC.hs1
genome <- BSgenome.Hsapiens.UCSC.hs1
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

BSgenome.Hsapiens.UCSC.hs1

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

BSgenome.Hsapiens.UCSC.hs1, 1

∗ package

BSgenome.Hsapiens.UCSC.hs1, 1

available.genomes, 1

BSgenome, 1
BSgenome.Hsapiens.UCSC.hs1, 1
BSgenome.Hsapiens.UCSC.hs1-package

(BSgenome.Hsapiens.UCSC.hs1), 1

BSgenomeForge, 1

DNAString, 1

Hsapiens (BSgenome.Hsapiens.UCSC.hs1), 1

3


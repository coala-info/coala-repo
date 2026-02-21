BSgenome.Hsapiens.UCSC.hg19

February 11, 2026

BSgenome.Hsapiens.UCSC.hg19

Full genome sequences for Homo sapiens (UCSC version hg19, based
on GRCh37.p13)

Description

Full genome sequences for Homo sapiens (Human) as provided by UCSC (hg19, based on GRCh37.p13)
and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

hg19.2bit, downloaded from https://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/latest/ on March 24, 2020

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

BSgenome.Hsapiens.UCSC.hg19
genome <- BSgenome.Hsapiens.UCSC.hg19
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

BSgenome.Hsapiens.UCSC.hg19

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

BSgenome.Hsapiens.UCSC.hg19, 1

∗ package

BSgenome.Hsapiens.UCSC.hg19, 1

available.genomes, 1

BSgenome, 1
BSgenome.Hsapiens.UCSC.hg19, 1
BSgenome.Hsapiens.UCSC.hg19-package

(BSgenome.Hsapiens.UCSC.hg19),
1
BSgenomeForge, 1

DNAString, 1

Hsapiens (BSgenome.Hsapiens.UCSC.hg19),

1

3


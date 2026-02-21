BSgenome.Rnorvegicus.UCSC.rn7

February 11, 2026

BSgenome.Rnorvegicus.UCSC.rn7

Full genome sequences for Rattus norvegicus (UCSC genome rn7)

Description

Full genome sequences for Rattus norvegicus (Rat) as provided by UCSC (genome rn7) and stored
in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

rn7.2bit, downloaded from https://hgdownload.soe.ucsc.edu/goldenPath/rn7/bigZips/ on August 24, 2021

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

BSgenome.Rnorvegicus.UCSC.rn7
genome <- BSgenome.Rnorvegicus.UCSC.rn7
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

## ---------------------------------------------------------------------
## Genome-wide motif searching

1

2

BSgenome.Rnorvegicus.UCSC.rn7

## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Rnorvegicus.UCSC.rn7, 1

∗ package

BSgenome.Rnorvegicus.UCSC.rn7, 1

available.genomes, 1

BSgenome, 1
BSgenome.Rnorvegicus.UCSC.rn7, 1
BSgenome.Rnorvegicus.UCSC.rn7-package

(BSgenome.Rnorvegicus.UCSC.rn7),
1
BSgenomeForge, 1

DNAString, 1

Rnorvegicus

(BSgenome.Rnorvegicus.UCSC.rn7),
1

3


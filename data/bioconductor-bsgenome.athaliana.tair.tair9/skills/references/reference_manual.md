BSgenome.Athaliana.TAIR.TAIR9

February 11, 2026

BSgenome.Athaliana.TAIR.TAIR9

Full genome sequences for Arabidopsis thaliana (TAIR9)

Description

Full genome sequences for Arabidopsis thaliana as provided by TAIR (TAIR9 Genome Release)
and stored in Biostrings objects. Note that TAIR10 is an "annotation release" based on the same
genome assembly as TAIR9.

Note

This BSgenome data package was made from the following source data files:

ftp://ftp.arabidopsis.org/home/tair/Genes/TAIR9_genome_release/TAIR9_chr_all.fas

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

BSgenome.Athaliana.TAIR.TAIR9
genome <- BSgenome.Athaliana.TAIR.TAIR9
seqlengths(genome)
genome$Chr1 # same as genome[["Chr1"]]

BSgenome.Athaliana.TAIR.TAIR9

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

BSgenome.Athaliana.TAIR.TAIR9, 1

∗ package

BSgenome.Athaliana.TAIR.TAIR9, 1

Athaliana

(BSgenome.Athaliana.TAIR.TAIR9),
1
available.genomes, 1

BSgenome, 1
BSgenome.Athaliana.TAIR.TAIR9, 1
BSgenome.Athaliana.TAIR.TAIR9-package

(BSgenome.Athaliana.TAIR.TAIR9),
1
BSgenomeForge, 1

DNAString, 1

3


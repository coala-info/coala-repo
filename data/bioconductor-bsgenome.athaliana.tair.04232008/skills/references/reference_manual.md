BSgenome.Athaliana.TAIR.04232008

February 11, 2026

BSgenome.Athaliana.TAIR.04232008

Full genome sequences for Arabidopsis thaliana (TAIR version from
April 23, 2008)

Description

Full genome sequences for Arabidopsis thaliana as provided by TAIR (snapshot from April 23,
2008) and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

all the chr*.fas file from ftp://ftp.arabidopsis.org/home/tair/Sequences/whole_chromosomes/
WARNING: This is where things are today (Oct 1st, 2008) but is probably
NOT aimed to be the permanent URL for the 04232008 snapshot of the genome.
TAIR might update the content of this folder in the future with a new
snapshot and move the 04232008 snapshot to the OLD/ subfolder.

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

BSgenome.Athaliana.TAIR.04232008
genome <- BSgenome.Athaliana.TAIR.04232008
seqlengths(genome)
genome$chr1 # same as genome[["chr1"]]

BSgenome.Athaliana.TAIR.04232008

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

BSgenome.Athaliana.TAIR.04232008,

1
∗ package

BSgenome.Athaliana.TAIR.04232008,

1

Athaliana

(BSgenome.Athaliana.TAIR.04232008),
1
available.genomes, 1

BSgenome, 1
BSgenome.Athaliana.TAIR.04232008, 1
BSgenome.Athaliana.TAIR.04232008-package

(BSgenome.Athaliana.TAIR.04232008),
1
BSgenomeForge, 1

DNAString, 1

3


BSgenome.Mfascicularis.NCBI.6.0

February 11, 2026

BSgenome.Mfascicularis.NCBI.6.0

genome
Full
(Macaca_fascicularis_6.0)

sequences

for

Macaca

fascicularis

Description

Full genome sequences for Macaca fascicularis (Crab-eating macaque) as provided by NCBI (as-
sembly Macaca_fascicularis_6.0, assembly accession GCA_011100615.1) and stored in Biostrings
objects.

Note

This BSgenome data package was made from the following source data files:

GCA_011100615.1_Macaca_fascicularis_6.0_genomic.fna.gz from https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/011/100/615/GCA_011100615.1_Macaca_fascicularis_6.0/

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

BSgenome.Mfascicularis.NCBI.6.0
genome <- BSgenome.Mfascicularis.NCBI.6.0
head(seqlengths(genome))
genome[["1"]]

BSgenome.Mfascicularis.NCBI.6.0

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

BSgenome.Mfascicularis.NCBI.6.0, 1

∗ package

BSgenome.Mfascicularis.NCBI.6.0, 1

available.genomes, 1

BSgenome, 1
BSgenome.Mfascicularis.NCBI.6.0, 1
BSgenome.Mfascicularis.NCBI.6.0-package

(BSgenome.Mfascicularis.NCBI.6.0),
1
BSgenomeForge, 1

DNAString, 1

Mfascicularis

(BSgenome.Mfascicularis.NCBI.6.0),
1

3


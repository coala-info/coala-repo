BSgenome.Alyrata.JGI.v1

February 11, 2026

Alyrata

Arabidopsis lyrata full genome (JGI version V1.0)

Description

Arabidopsis lyrata 8x Release [project ID 4002920] as provided by JGI ( snapshot from March 24,
2011) and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

all the chr*.fa file from http://genome.jgi-psf.org/Araly1/Araly1.download.ftp.html
Chloroplast and mitochondrion genomes are presented as scaffolds, see JGI websites for INFO.
WARNING: This is where things are today (March 24, 2011) but is probably
NOT aimed to be the permanent URL for the V1.0 snapshot of the genome.
JGI might update the content of this folder in the future with a new
snapshot and move the V1.0 snapshot to the OLD/ subfolder.

See ?BSgenomeForge and the BSgenomeForge vignette (vignette("BSgenomeForge")) in the
BSgenome software package for how to make a BSgenome data package.

Author(s)

Jian-Feng Mao and Ya-Long Guo, with acknowledgement to Detlef Weigel

See Also

BSgenome-class, DNAString-class, available.genomes, BSgenomeForge

1

2

Examples

Alyrata
seqlengths(Alyrata)
Alyrata$chr1 # same as Alyrata[["chr1"]]

Alyrata

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

Alyrata, 1

∗ package

Alyrata, 1

Alyrata, 1
available.genomes, 1

BSgenome-class, 1
BSgenome.Alyrata.JGI.v1 (Alyrata), 1
BSgenome.Alyrata.JGI.v1-package

(Alyrata), 1

BSgenomeForge, 1

DNAString-class, 1

3


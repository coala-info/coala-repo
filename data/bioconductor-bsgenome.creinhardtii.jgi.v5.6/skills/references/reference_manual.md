BSgenome.Creinhardtii.JGI.v5.6

February 11, 2026

BSgenome.Creinhardtii.JGI.v5.6

Full genome sequences for Chlamydomonas reinhardtii (v5.6)

Description

Full genome sequences for Chlamydomonas reinhardtii (v5.6) as provided by JGI and stored in
Biostrings objects. The data in this package is public. See ’citation("BSgenome.Creinhardtii.JGI.v5.6")’
for how to cite in publications.

Note

This BSgenome data package was made from the following source data files:

Creinhardtii_281_v5.0.fa.gz from https://phytozome-next.jgi.doe.gov/info/Creinhardtii_v5_6

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

BSgenome.Creinhardtii.JGI.v5.6
genome <- BSgenome.Creinhardtii.JGI.v5.6
head(seqlengths(genome))
genome[["chromosome_1"]]

BSgenome.Creinhardtii.JGI.v5.6

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

BSgenome.Creinhardtii.JGI.v5.6, 1

∗ package

BSgenome.Creinhardtii.JGI.v5.6, 1

available.genomes, 1

BSgenome, 1
BSgenome.Creinhardtii.JGI.v5.6, 1
BSgenome.Creinhardtii.JGI.v5.6-package

(BSgenome.Creinhardtii.JGI.v5.6),
1
BSgenomeForge, 1

Creinhardtii

(BSgenome.Creinhardtii.JGI.v5.6),
1

DNAString, 1

3


BSgenome.Tguttata.UCSC.taeGut1

February 11, 2026

BSgenome.Tguttata.UCSC.taeGut1

Full genome sequences for Taeniopygia guttata (UCSC version
taeGut1)

Description

Full genome sequences for Taeniopygia guttata (Zebra finch) as provided by UCSC (taeGut1, Jul.
2008) and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

chromFa.tar.gz from http://hgdownload.soe.ucsc.edu/goldenPath/taeGut1/bigZips/

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

BSgenome.Tguttata.UCSC.taeGut1
genome <- BSgenome.Tguttata.UCSC.taeGut1
seqlengths(genome)
genome$chr1 # same as genome[["chr1"]]

BSgenome.Tguttata.UCSC.taeGut1

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

BSgenome.Tguttata.UCSC.taeGut1, 1

∗ package

BSgenome.Tguttata.UCSC.taeGut1, 1

available.genomes, 1

BSgenome, 1
BSgenome.Tguttata.UCSC.taeGut1, 1
BSgenome.Tguttata.UCSC.taeGut1-package

(BSgenome.Tguttata.UCSC.taeGut1),
1
BSgenomeForge, 1

DNAString, 1

Tguttata

(BSgenome.Tguttata.UCSC.taeGut1),
1

3


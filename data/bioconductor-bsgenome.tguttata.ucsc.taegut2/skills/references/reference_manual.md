BSgenome.Tguttata.UCSC.taeGut2

February 11, 2026

BSgenome.Tguttata.UCSC.taeGut2

Full genome sequences for Taeniopygia guttata (UCSC version
taeGut2)

Description

Full genome sequences for Taeniopygia guttata (Zebra finch) as provided by UCSC (taeGut2, Feb.
2013) and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

taeGut2.2bit from http://hgdownload.soe.ucsc.edu/goldenPath/taeGut2/bigZips/

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

BSgenome.Tguttata.UCSC.taeGut2
genome <- BSgenome.Tguttata.UCSC.taeGut2
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

BSgenome.Tguttata.UCSC.taeGut2

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

BSgenome.Tguttata.UCSC.taeGut2, 1

∗ package

BSgenome.Tguttata.UCSC.taeGut2, 1

available.genomes, 1

BSgenome, 1
BSgenome.Tguttata.UCSC.taeGut2, 1
BSgenome.Tguttata.UCSC.taeGut2-package

(BSgenome.Tguttata.UCSC.taeGut2),
1
BSgenomeForge, 1

DNAString, 1

Tguttata

(BSgenome.Tguttata.UCSC.taeGut2),
1

3


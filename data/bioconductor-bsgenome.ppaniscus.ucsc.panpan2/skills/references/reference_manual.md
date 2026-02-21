BSgenome.Ppaniscus.UCSC.panPan2

February 11, 2026

BSgenome.Ppaniscus.UCSC.panPan2

Full genome sequences for Pan paniscus (UCSC version panPan2)

Description

Full genome sequences for Pan paniscus (Bonobo) as provided by UCSC (panPan2, Dec. 2015) and
stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

panPan2.2bit from https://hgdownload.cse.ucsc.edu/goldenPath/panPan2/bigZips/

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

BSgenome.Ppaniscus.UCSC.panPan2
genome <- BSgenome.Ppaniscus.UCSC.panPan2
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

## ---------------------------------------------------------------------
## Genome-wide motif searching

1

2

BSgenome.Ppaniscus.UCSC.panPan2

## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Ppaniscus.UCSC.panPan2, 1

∗ package

BSgenome.Ppaniscus.UCSC.panPan2, 1

available.genomes, 1

BSgenome, 1
BSgenome.Ppaniscus.UCSC.panPan2, 1
BSgenome.Ppaniscus.UCSC.panPan2-package

(BSgenome.Ppaniscus.UCSC.panPan2),
1
BSgenomeForge, 1

DNAString, 1

Ppaniscus

(BSgenome.Ppaniscus.UCSC.panPan2),
1

3


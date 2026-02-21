BSgenome.Mmulatta.UCSC.rheMac8

February 11, 2026

BSgenome.Mmulatta.UCSC.rheMac8

Full genome sequences for Macaca mulatta (UCSC version rheMac8)

Description

Full genome sequences for Macaca mulatta (Rhesus) as provided by UCSC (rheMac8, Nov. 2015)
and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

rheMac8.2bit from http://hgdownload.soe.ucsc.edu/goldenPath/rheMac8/bigZips/

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

BSgenome.Mmulatta.UCSC.rheMac8
genome <- BSgenome.Mmulatta.UCSC.rheMac8
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

## ---------------------------------------------------------------------
## Genome-wide motif searching

1

2

BSgenome.Mmulatta.UCSC.rheMac8

## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Mmulatta.UCSC.rheMac8, 1

∗ package

BSgenome.Mmulatta.UCSC.rheMac8, 1

available.genomes, 1

BSgenome, 1
BSgenome.Mmulatta.UCSC.rheMac8, 1
BSgenome.Mmulatta.UCSC.rheMac8-package

(BSgenome.Mmulatta.UCSC.rheMac8),
1
BSgenomeForge, 1

DNAString, 1

Mmulatta

(BSgenome.Mmulatta.UCSC.rheMac8),
1

3


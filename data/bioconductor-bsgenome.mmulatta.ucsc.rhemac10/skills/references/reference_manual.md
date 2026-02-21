BSgenome.Mmulatta.UCSC.rheMac10

February 11, 2026

BSgenome.Mmulatta.UCSC.rheMac10

Full genome sequences
rheMac10)

for Macaca mulatta (UCSC version

Description

Full genome sequences for Macaca mulatta (Rhesus) as provided by UCSC (rheMac10, Feb. 2019)
and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

rheMac10.2bit from http://hgdownload.soe.ucsc.edu/goldenPath/rheMac10/bigZips/

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

BSgenome.Mmulatta.UCSC.rheMac10
genome <- BSgenome.Mmulatta.UCSC.rheMac10
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

BSgenome.Mmulatta.UCSC.rheMac10

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

BSgenome.Mmulatta.UCSC.rheMac10, 1

∗ package

BSgenome.Mmulatta.UCSC.rheMac10, 1

available.genomes, 1

BSgenome, 1
BSgenome.Mmulatta.UCSC.rheMac10, 1
BSgenome.Mmulatta.UCSC.rheMac10-package

(BSgenome.Mmulatta.UCSC.rheMac10),
1
BSgenomeForge, 1

DNAString, 1

Mmulatta

(BSgenome.Mmulatta.UCSC.rheMac10),
1

3


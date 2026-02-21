BSgenome.Amellifera.UCSC.apiMel2

February 11, 2026

BSgenome.Amellifera.UCSC.apiMel2

Full genome sequences for Apis mellifera (UCSC version apiMel2)

Description

Full genome sequences for Apis mellifera (Honey Bee) as provided by UCSC (apiMel2, Jan. 2005)
and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

GroupFa.zip from http://hgdownload.cse.ucsc.edu/goldenPath/apiMel2/bigZips/

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

BSgenome.Amellifera.UCSC.apiMel2
genome <- BSgenome.Amellifera.UCSC.apiMel2
seqlengths(genome)
genome$Group1 # same as genome[["Group1"]]

## ---------------------------------------------------------------------
## Genome-wide motif searching

1

2

BSgenome.Amellifera.UCSC.apiMel2

## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Amellifera.UCSC.apiMel2,

1
∗ package

BSgenome.Amellifera.UCSC.apiMel2,

1

Amellifera

(BSgenome.Amellifera.UCSC.apiMel2),
1
available.genomes, 1

BSgenome, 1
BSgenome.Amellifera.UCSC.apiMel2, 1
BSgenome.Amellifera.UCSC.apiMel2-package

(BSgenome.Amellifera.UCSC.apiMel2),
1
BSgenomeForge, 1

DNAString, 1

3


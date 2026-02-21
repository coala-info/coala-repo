BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1

February 11, 2026

BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1

Full Genome Sequence for Cryptococcus neoformans var. grubii
KN99 (ASM221672v1)

Description

Full genome sequences for Cryptococcus neoformans var. grubii KN99 (assembly ASM221672v1
assembly accession GCA_002216725.1).

Note

This BSgenome data package was made from the following source data files:

-- information not available --

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

BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1

BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1
genome <- BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1
head(seqlengths(genome))
genome$CP022321.1 # same as genome[["CP022321.1"]]

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

BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1,

1
∗ package

BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1,

1

available.genomes, 1

BSgenome, 1
BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1,

1

BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1-package

(BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1),
1
BSgenomeForge, 1

CneoformansVarGrubiiKN99

(BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1),
1

DNAString, 1

3


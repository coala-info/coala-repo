BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0

February 11, 2026

BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0

T2T-CHM13v2.0 assembly (Homo sapiens) wrapped in a BSgenome
object

Description

The T2T-CHM13v2.0 assembly (accession GCA_009914755.4), as submitted to NCBI by the T2T
Consortium, and wrapped in a BSgenome object. Companion paper: "The complete sequence of a
human genome" by Nurk S, Koren S, Rhie A, Rautiainen M, et al. Science, 2022.

Note

This BSgenome data package was made from the following source data files:

GCA_009914755.4_T2T-CHM13v2.0_genomic.fna.gz from https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/009/914/755/GCA_009914755.4_T2T-CHM13v2.0/

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

BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0

BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0
genome <- BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0
head(seqlengths(genome))
genome[["1"]]

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

BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0,

1
∗ package

BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0,

1

available.genomes, 1

BSgenome, 1
BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0,

1

BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0-package

(BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0),
1
BSgenomeForge, 1

DNAString, 1

Hsapiens

(BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0),
1

3


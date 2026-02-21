BSgenome.Hsapiens.NCBI.GRCh38

February 11, 2026

BSgenome.Hsapiens.NCBI.GRCh38

Full genome sequences for Homo sapiens (GRCh38)

Description

Full genome sequences for Homo sapiens (Human) as provided by NCBI (GRCh38, 2013-12-17)
and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

GCA_000001405.15_GRCh38_top-level.fna.gz from ftp://ftp.ncbi.nlm.nih.gov/genbank/genomes/Eukaryotes/vertebrates_mammals/Homo_sapiens/GRCh38

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

BSgenome.Hsapiens.NCBI.GRCh38
genome <- BSgenome.Hsapiens.NCBI.GRCh38
seqlengths(genome)
genome[["1"]]

## ---------------------------------------------------------------------
## Genome-wide motif searching

1

2

BSgenome.Hsapiens.NCBI.GRCh38

## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Hsapiens.NCBI.GRCh38, 1

∗ package

BSgenome.Hsapiens.NCBI.GRCh38, 1

available.genomes, 1

BSgenome, 1
BSgenome.Hsapiens.NCBI.GRCh38, 1
BSgenome.Hsapiens.NCBI.GRCh38-package

(BSgenome.Hsapiens.NCBI.GRCh38),
1
BSgenomeForge, 1

DNAString, 1

Hsapiens

(BSgenome.Hsapiens.NCBI.GRCh38),
1

3


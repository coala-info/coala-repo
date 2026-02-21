BSgenome.Amellifera.NCBI.AmelHAv3.1

February 11, 2026

BSgenome.Amellifera.NCBI.AmelHAv3.1

Full genome sequences for Apis mellifera (Amel_HAv3.1)

Description

Full genome sequences for Apis mellifera as provided by NCBI (assembly Amel_HAv3.1, assembly
accession GCF_003254395.2) and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

GCF_003254395.2_Amel_HAv3.1_genomic.fna.gz from https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/254/395/GCF_003254395.2_Amel_HAv3.1/

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

BSgenome.Amellifera.NCBI.AmelHAv3.1
genome <- BSgenome.Amellifera.NCBI.AmelHAv3.1
head(seqlengths(genome))
genome[["Group1"]]

## ---------------------------------------------------------------------
## Genome-wide motif searching

1

2

BSgenome.Amellifera.NCBI.AmelHAv3.1

## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Amellifera.NCBI.AmelHAv3.1,

1
∗ package

BSgenome.Amellifera.NCBI.AmelHAv3.1,

1

Amellifera

(BSgenome.Amellifera.NCBI.AmelHAv3.1),
1
available.genomes, 1

BSgenome, 1
BSgenome.Amellifera.NCBI.AmelHAv3.1, 1
BSgenome.Amellifera.NCBI.AmelHAv3.1-package

(BSgenome.Amellifera.NCBI.AmelHAv3.1),
1
BSgenomeForge, 1

DNAString, 1

3


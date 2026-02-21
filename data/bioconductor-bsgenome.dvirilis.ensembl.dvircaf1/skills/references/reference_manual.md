BSgenome.Dvirilis.Ensembl.dvircaf1

February 11, 2026

BSgenome.Dvirilis.Ensembl.dvircaf1

Full genome sequences for Drosophila virilis (assembly dvir_caf1)

Description

Full genome sequences for Drosophila virilis (assembly dvir_caf1, GenBank assembly accession
GCA_000005245.1) as provided by Ensembl and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

Drosophila_virilis.dvir_caf1.dna.toplevel.fa.gz, downloaded from ftp://ftp.ensemblgenomes.org/pub/release-46/metazoa/fasta/drosophila_virilis/dna/ and converted to 2bit format on March 2020

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

BSgenome.Dvirilis.Ensembl.dvircaf1
genome <- BSgenome.Dvirilis.Ensembl.dvircaf1
head(seqlengths(genome))
genome$scaffold_13049 # same as genome[["scaffold_13049"]]

## ---------------------------------------------------------------------
## Genome-wide motif searching

1

2

BSgenome.Dvirilis.Ensembl.dvircaf1

## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Dvirilis.Ensembl.dvircaf1,

1
∗ package

BSgenome.Dvirilis.Ensembl.dvircaf1,

1

available.genomes, 1

BSgenome, 1
BSgenome.Dvirilis.Ensembl.dvircaf1, 1
BSgenome.Dvirilis.Ensembl.dvircaf1-package

(BSgenome.Dvirilis.Ensembl.dvircaf1),
1
BSgenomeForge, 1

DNAString, 1
Dvirilis

(BSgenome.Dvirilis.Ensembl.dvircaf1),
1

3


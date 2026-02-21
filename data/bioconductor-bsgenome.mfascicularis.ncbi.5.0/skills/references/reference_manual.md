BSgenome.Mfascicularis.NCBI.5.0

February 11, 2026

BSgenome.Mfascicularis.NCBI.5.0

genome
Full
(Macaca_fascicularis_5.0)

sequences

for

Macaca

fascicularis

Description

Full genome sequences for Macaca fascicularis (long-tailed macaque) as provided by NCBI (Macaca_fascicularis_5.0,
2013-06-12) and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

GCF_000364345.1_Macaca_fascicularis_5.0_genomic.fna.gz from ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000364345.1_Macaca_fascicularis_5.0/

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

BSgenome.Mfascicularis.NCBI.5.0
genome <- BSgenome.Mfascicularis.NCBI.5.0
head(seqlengths(genome))
genome$MFA1 # same as genome[["MFA1"]]

BSgenome.Mfascicularis.NCBI.5.0

## ---------------------------------------------------------------------
## About the ordering of the sequences
## ---------------------------------------------------------------------
## The sequences in BSgenome object 'genome' are ordered like in the
## assembly report at the following URL
url <- "ftp://ftp.ncbi.nlm.nih.gov/genomes/ASSEMBLY_REPORTS/All/GCF_000364345.1.assembly.txt"
## except that the MT sequence was moved from the last position to the
## position between the chromosomes (MFA* sequences) and the scaffolds
## (Scaffold* sequences):
SequenceName <- read.table(url, sep="\t", stringsAsFactors=FALSE)[[1]]
target_seqlevels <- SequenceName[c(1:21, 7601, 22:7600)]
stopifnot(identical(seqlevels(genome), target_seqlevels))

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

BSgenome.Mfascicularis.NCBI.5.0, 1

∗ package

BSgenome.Mfascicularis.NCBI.5.0, 1

available.genomes, 1

BSgenome, 1
BSgenome.Mfascicularis.NCBI.5.0, 1
BSgenome.Mfascicularis.NCBI.5.0-package

(BSgenome.Mfascicularis.NCBI.5.0),
1
BSgenomeForge, 1

DNAString, 1

Mfascicularis

(BSgenome.Mfascicularis.NCBI.5.0),
1

3


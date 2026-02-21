BSgenome.Dmelanogaster.UCSC.dm6

February 11, 2026

BSgenome.Dmelanogaster.UCSC.dm6

Full genome sequences for Drosophila melanogaster (UCSC version
dm6)

Description

Full genome sequences for Drosophila melanogaster (Fly) as provided by UCSC (dm6, Aug. 2014)
and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

dm6.2bit from http://hgdownload.cse.ucsc.edu/goldenPath/dm6/bigZips/

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

BSgenome.Dmelanogaster.UCSC.dm6
genome <- BSgenome.Dmelanogaster.UCSC.dm6
seqlengths(genome)
genome$chr2L # same as genome[["chr2L"]]

BSgenome.Dmelanogaster.UCSC.dm6

## ---------------------------------------------------------------------
## Extract the upstream sequences
## ---------------------------------------------------------------------
## The upstream sequences can easily be extracted from the full genome
## sequences with something like:

library(GenomicFeatures)
txdb <- makeTxDbFromUCSC("dm6", tablename="refGene")
up1000seqs <- extractUpstreamSeqs(genome, txdb, width=1000)

## IMPORTANT: Make sure you use a TxDb package (or TxDb object) that
## contains a gene model based on dm6 or on a compatible genome (i.e.
## a genome with sequences identical to the sequences in dm6). Note
## that you can make a TxDb object from various annotation resources.
## See the makeTxDbFromUCSC(), makeTxDbFromBiomart(), and
## makeTxDbFromGFF() functions in the GenomicFeatures package for more
## information.

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

BSgenome.Dmelanogaster.UCSC.dm6, 1

∗ package

BSgenome.Dmelanogaster.UCSC.dm6, 1

available.genomes, 1

BSgenome, 1
BSgenome.Dmelanogaster.UCSC.dm6, 1
BSgenome.Dmelanogaster.UCSC.dm6-package

(BSgenome.Dmelanogaster.UCSC.dm6),
1
BSgenomeForge, 1

Dmelanogaster

(BSgenome.Dmelanogaster.UCSC.dm6),
1

DNAString, 1

3


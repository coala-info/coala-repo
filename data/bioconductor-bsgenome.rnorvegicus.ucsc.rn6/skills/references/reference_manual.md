BSgenome.Rnorvegicus.UCSC.rn6

February 11, 2026

BSgenome.Rnorvegicus.UCSC.rn6

Full genome sequences for Rattus norvegicus (UCSC version rn6)

Description

Full genome sequences for Rattus norvegicus (Rat) as provided by UCSC (rn6, Jul. 2014) and
stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

rn6.2bit from http://hgdownload.cse.ucsc.edu/goldenPath/rn6/bigZips/

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

BSgenome.Rnorvegicus.UCSC.rn6
genome <- BSgenome.Rnorvegicus.UCSC.rn6
seqlengths(genome)
genome$chr1 # same as genome[["chr1"]]

## ---------------------------------------------------------------------
## Extract the upstream sequences

1

2

BSgenome.Rnorvegicus.UCSC.rn6

## ---------------------------------------------------------------------
## The upstream sequences can easily be extracted from the full genome
## sequences with something like:

library(GenomicFeatures)
txdb <- makeTxDbFromUCSC("rn6", tablename="refGene")
up1000seqs <- extractUpstreamSeqs(genome, txdb, width=1000)

## IMPORTANT: Make sure you use a TxDb package (or TxDb object) that
## contains a gene model based on rn6 or on a compatible genome (i.e.
## a genome with sequences identical to the sequences in rn6). Note
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

BSgenome.Rnorvegicus.UCSC.rn6, 1

∗ package

BSgenome.Rnorvegicus.UCSC.rn6, 1

available.genomes, 1

BSgenome, 1
BSgenome.Rnorvegicus.UCSC.rn6, 1
BSgenome.Rnorvegicus.UCSC.rn6-package

(BSgenome.Rnorvegicus.UCSC.rn6),
1
BSgenomeForge, 1

DNAString, 1

Rnorvegicus

(BSgenome.Rnorvegicus.UCSC.rn6),
1

3


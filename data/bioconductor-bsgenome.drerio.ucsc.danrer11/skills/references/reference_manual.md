BSgenome.Drerio.UCSC.danRer11

February 11, 2026

BSgenome.Drerio.UCSC.danRer11

Full genome sequences for Danio rerio (UCSC version danRer11)

Description

Full genome sequences for Danio rerio (Zebrafish) as provided by UCSC (danRer11, May 2017)
and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

danRer11.2bit from http://hgdownload.soe.ucsc.edu/goldenPath/danRer11/bigZips/

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

BSgenome.Drerio.UCSC.danRer11
genome <- BSgenome.Drerio.UCSC.danRer11
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

## ---------------------------------------------------------------------
## Extract the upstream sequences

1

2

BSgenome.Drerio.UCSC.danRer11

## ---------------------------------------------------------------------
## The upstream sequences located in
##
## are based on RefSeq genes (RefSeq Genes track in the Genome Browser).
## These can easily be extracted from the full genome sequences with:

http://hgdownload.cse.ucsc.edu/goldenPath/danRer11/bigZips/

library(GenomicFeatures)
refGene_txdb <- suppressWarnings(makeTxDbFromUCSC("danRer11", "refGene"))
refGene_up1000seqs <- extractUpstreamSeqs(genome, refGene_txdb)

## Note that you can make TxDb objects from various annotation
## resources. See the makeTxDbFromUCSC(), makeTxDbFromEnsembl(), and
## makeTxDbFromGFF() functions in the GenomicFeatures package for more
## information.
## IMPORTANT: Make sure you use a TxDb package (or TxDb object) that
## contains a gene model based on danRer11 or on a compatible genome
## (i.e. a genome with sequences identical to the sequences in
## danRer11). See ?extractUpstreamSeqs in the GenomicFeatures package
## for more information.

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

BSgenome.Drerio.UCSC.danRer11, 1

∗ package

BSgenome.Drerio.UCSC.danRer11, 1

available.genomes, 1

BSgenome, 1
BSgenome.Drerio.UCSC.danRer11, 1
BSgenome.Drerio.UCSC.danRer11-package

(BSgenome.Drerio.UCSC.danRer11),
1
BSgenomeForge, 1

DNAString, 1
Drerio (BSgenome.Drerio.UCSC.danRer11),

1

3


BSgenome.Drerio.UCSC.danRer10

February 11, 2026

BSgenome.Drerio.UCSC.danRer10

Full genome sequences for Danio rerio (UCSC version danRer10)

Description

Full genome sequences for Danio rerio (Zebrafish) as provided by UCSC (danRer10, Sep. 2014)
and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

danRer10.2bit from http://hgdownload.soe.ucsc.edu/goldenPath/danRer10/bigZips/

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

BSgenome.Drerio.UCSC.danRer10
genome <- BSgenome.Drerio.UCSC.danRer10
head(seqlengths(genome))
genome$chr1 # same as genome[["chr1"]]

## ---------------------------------------------------------------------
## Extract the upstream sequences

1

2

BSgenome.Drerio.UCSC.danRer10

## ---------------------------------------------------------------------
## The upstream sequences located in
##
## are based on RefSeq genes (RefSeq Genes track in the Genome Browser).
## These can easily be extracted from the full genome sequences with:

http://hgdownload.cse.ucsc.edu/goldenPath/danRer10/bigZips/

library(GenomicFeatures)
refGene_txdb <- suppressWarnings(makeTxDbFromUCSC("danRer10", "refGene"))
refGene_up1000seqs <- extractUpstreamSeqs(genome, refGene_txdb)

## Note that you can make a TxDb object from various annotation
## resources. See the makeTxDbFromUCSC(), makeTxDbFromBiomart(), and
## makeTxDbFromGFF() functions in the GenomicFeatures package for more
## information.
## IMPORTANT: Make sure you use a TxDb package (or TxDb object) that
## contains a gene model based on danRer10 or on a compatible genome
## (i.e. a genome with sequences identical to the sequences in
## danRer10). See ?extractUpstreamSeqs in the GenomicFeatures package
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

BSgenome.Drerio.UCSC.danRer10, 1

∗ package

BSgenome.Drerio.UCSC.danRer10, 1

available.genomes, 1

BSgenome, 1
BSgenome.Drerio.UCSC.danRer10, 1
BSgenome.Drerio.UCSC.danRer10-package

(BSgenome.Drerio.UCSC.danRer10),
1
BSgenomeForge, 1

DNAString, 1
Drerio (BSgenome.Drerio.UCSC.danRer10),

1

3


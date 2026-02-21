BSgenome.Mmusculus.UCSC.mm8

February 11, 2026

BSgenome.Mmusculus.UCSC.mm8

Full genome sequences for Mus musculus (UCSC version mm8)

Description

Full genome sequences for Mus musculus (Mouse) as provided by UCSC (mm8, Feb. 2006) and
stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

chromFa.tar.gz from http://hgdownload.cse.ucsc.edu/goldenPath/mm8/bigZips/

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

BSgenome.Mmusculus.UCSC.mm8
genome <- BSgenome.Mmusculus.UCSC.mm8
seqlengths(genome)
genome$chr1 # same as genome[["chr1"]]

## --------------------------------------------------------------------- ## Upstream sequences
## ---------------------------------------------------------------------

1

2

BSgenome.Mmusculus.UCSC.mm8

## Starting with BioC 3.0, the upstream1000, upstream2000, and
## upstream5000 sequences for mm8 are not included in the BSgenome data
## package anymore. However they can easily be extracted from the full
## genome sequences with something like:

library(GenomicFeatures)
txdb <- makeTranscriptDbFromUCSC("mm8", "knownGene")
gn <- sort(genes(txdb))
up1000 <- flank(gn, width=1000)
up1000seqs <- getSeq(genome, up1000)

## IMPORTANT: Make sure you use a TxDb package (or TranscriptDb object),
## that contains a gene model based on the exact same reference genome
## as the BSgenome object you pass to getSeq(). Note that you can make
## your own custom TranscriptDb object from various annotation resources.
## See the makeTranscriptDbFromUCSC(), makeTranscriptDbFromBiomart(),
## and makeTranscriptDbFromGFF() functions in the GenomicFeatures
## package.

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

BSgenome.Mmusculus.UCSC.mm8, 1

∗ package

BSgenome.Mmusculus.UCSC.mm8, 1

available.genomes, 1

BSgenome, 1
BSgenome.Mmusculus.UCSC.mm8, 1
BSgenome.Mmusculus.UCSC.mm8-package

(BSgenome.Mmusculus.UCSC.mm8),
1
BSgenomeForge, 1

DNAString, 1

Mmusculus

(BSgenome.Mmusculus.UCSC.mm8),
1

3


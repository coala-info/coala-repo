BSgenome.Ptroglodytes.UCSC.panTro3

February 11, 2026

BSgenome.Ptroglodytes.UCSC.panTro3

Full genome sequences for Pan troglodytes (UCSC version panTro3)

Description

Full genome sequences for Pan troglodytes (Chimp) as provided by UCSC (panTro3, Oct. 2010)
and stored in Biostrings objects.

Note

This BSgenome data package was made from the following source data files:

panTro3.fa.gz from http://hgdownload.cse.ucsc.edu/goldenPath/panTro3/bigZips/

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

BSgenome.Ptroglodytes.UCSC.panTro3
genome <- BSgenome.Ptroglodytes.UCSC.panTro3
seqlengths(genome)
genome$chr1 # same as genome[["chr1"]]

## ---------------------------------------------------------------------
## Upstream sequences

1

2

BSgenome.Ptroglodytes.UCSC.panTro3

## ---------------------------------------------------------------------
## Starting with BioC 3.0, the upstream1000, upstream2000, and
## upstream5000 sequences for panTro3 are not included in the BSgenome
## data package anymore. However they can easily be extracted from the
## full genome sequences with something like:

library(GenomicFeatures)
txdb <- makeTranscriptDbFromUCSC("panTro3", "refGene")
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

BSgenome.Ptroglodytes.UCSC.panTro3,

1
∗ package

BSgenome.Ptroglodytes.UCSC.panTro3,

1

available.genomes, 1

BSgenome, 1
BSgenome.Ptroglodytes.UCSC.panTro3, 1
BSgenome.Ptroglodytes.UCSC.panTro3-package

(BSgenome.Ptroglodytes.UCSC.panTro3),
1
BSgenomeForge, 1

DNAString, 1

Ptroglodytes

(BSgenome.Ptroglodytes.UCSC.panTro3),
1

3


BSgenome.Btaurus.UCSC.bosTau9.masked
February 11, 2026

BSgenome.Btaurus.UCSC.bosTau9.masked

Full masked genome sequences for Bos taurus (UCSC version
bosTau9)

Description

Full genome sequences for Bos taurus (Cow) as provided by UCSC (genome bosTau9) and stored
in Biostrings objects. The sequences are the same as in BSgenome.Btaurus.UCSC.bosTau9, except
that each of them has the 4 following masks on top: (1) the mask of assembly gaps (AGAPS mask),
(2) the mask of intra-contig ambiguities (AMB mask), (3) the mask of repeats from RepeatMasker
(RM mask), and (4) the mask of repeats from Tandem Repeats Finder (TRF mask). Only the
AGAPS and AMB masks are "active" by default.

Note

The masks in this BSgenome data package were made from the following source data files:

AGAPS masks: gap.txt.gz, downloaded from https://hgdownload.soe.ucsc.edu/goldenPath/bosTau9/database/ on March 23, 2022
RM masks: bosTau9.fa.out.gz, downloaded from https://hgdownload.soe.ucsc.edu/goldenPath/bosTau9/bigZips/ on March 23, 2022
TRF masks: bosTau9.trf.bed.gz, downloaded from https://hgdownload.soe.ucsc.edu/goldenPath/bosTau9/bigZips/ on March 23, 2022

See ?BSgenome.Btaurus.UCSC.bosTau9 in the BSgenome.Btaurus.UCSC.bosTau9 package for
information about how the sequences were obtained.
See ?BSgenomeForge and the BSgenomeForge vignette (vignette("BSgenomeForge")) in the
BSgenome software package for how to make a BSgenome data package.

Author(s)

The Bioconductor Dev Team

See Also

• BSgenome.Btaurus.UCSC.bosTau9 in the BSgenome.Btaurus.UCSC.bosTau9 package for

information about how the sequences were obtained.

• BSgenome objects and the available.genomes function in the BSgenome software package.
• MaskedDNAString objects in the Biostrings package.
• The BSgenomeForge vignette (vignette("BSgenomeForge")) in the BSgenome software

package for how to make a BSgenome data package.

1

2

Examples

BSgenome.Btaurus.UCSC.bosTau9.masked

BSgenome.Btaurus.UCSC.bosTau9.masked
genome <- BSgenome.Btaurus.UCSC.bosTau9.masked
head(seqlengths(genome))
genome$chr1 # a MaskedDNAString object!
## To get rid of the masks altogether:
unmasked(genome$chr1) # same as BSgenome.Btaurus.UCSC.bosTau9$chr1

if ("AGAPS" %in% masknames(genome)) {

## Check that the assembly gaps contain only Ns:
checkOnlyNsInGaps <- function(seq)
{

## Replace all masks by the inverted AGAPS mask
masks(seq) <- gaps(masks(seq)["AGAPS"])
unique_letters <- uniqueLetters(seq)
if (any(unique_letters != "N"))

stop("assembly gaps contain more than just Ns")

}

## A message will be printed each time a sequence is removed
## from the cache:
options(verbose=TRUE)

for (seqname in seqnames(genome)) {

cat("Checking sequence", seqname, "... ")
seq <- genome[[seqname]]
checkOnlyNsInGaps(seq)
cat("OK\n")

}

}

## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Btaurus.UCSC.bosTau9.masked,

1
∗ package

BSgenome.Btaurus.UCSC.bosTau9.masked,

1

available.genomes, 1

BSgenome, 1
BSgenome.Btaurus.UCSC.bosTau9, 1
BSgenome.Btaurus.UCSC.bosTau9.masked,

1

BSgenome.Btaurus.UCSC.bosTau9.masked-package

(BSgenome.Btaurus.UCSC.bosTau9.masked),
1
BSgenomeForge, 1

MaskedDNAString, 1

3


BSgenome.Hsapiens.UCSC.hg19.masked
February 11, 2026

BSgenome.Hsapiens.UCSC.hg19.masked

Full masked genome sequences for Homo sapiens (UCSC version
hg19, based on GRCh37.p13)

Description

Full genome sequences for Homo sapiens (Human) as provided by UCSC (hg19, based on GRCh37.p13)
and stored in Biostrings objects. The sequences are the same as in BSgenome.Hsapiens.UCSC.hg19,
except that each of them has the 4 following masks on top: (1) the mask of assembly gaps (AGAPS
mask), (2) the mask of intra-contig ambiguities (AMB mask), (3) the mask of repeats from Repeat-
Masker (RM mask), and (4) the mask of repeats from Tandem Repeats Finder (TRF mask). Only
the AGAPS and AMB masks are "active" by default.

Note

The masks in this BSgenome data package were made from the following source data files:

AGAPS masks: gap.txt.gz, downloaded from https://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/ on March 24, 2020
RM masks: hg19.fa.out.gz, downloaded from https://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/latest/ on March 24, 2020
TRF masks: hg19.trf.bed.gz, downloaded from https://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/latest/ on March 24, 2020

See ?BSgenome.Hsapiens.UCSC.hg19 in the BSgenome.Hsapiens.UCSC.hg19 package for infor-
mation about how the sequences were obtained.
See ?BSgenomeForge and the BSgenomeForge vignette (vignette("BSgenomeForge")) in the
BSgenome software package for how to make a BSgenome data package.

Author(s)

The Bioconductor Dev Team

See Also

• BSgenome.Hsapiens.UCSC.hg19 in the BSgenome.Hsapiens.UCSC.hg19 package for infor-

mation about how the sequences were obtained.

• BSgenome objects and the available.genomes function in the BSgenome software package.
• MaskedDNAString objects in the Biostrings package.
• The BSgenomeForge vignette (vignette("BSgenomeForge")) in the BSgenome software

package for how to make a BSgenome data package.

1

2

Examples

BSgenome.Hsapiens.UCSC.hg19.masked

BSgenome.Hsapiens.UCSC.hg19.masked
genome <- BSgenome.Hsapiens.UCSC.hg19.masked
head(seqlengths(genome))
genome$chr1 # a MaskedDNAString object!
## To get rid of the masks altogether:
unmasked(genome$chr1) # same as BSgenome.Hsapiens.UCSC.hg19$chr1

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

BSgenome.Hsapiens.UCSC.hg19.masked,

1
∗ package

BSgenome.Hsapiens.UCSC.hg19.masked,

1

available.genomes, 1

BSgenome, 1
BSgenome.Hsapiens.UCSC.hg19, 1
BSgenome.Hsapiens.UCSC.hg19.masked, 1
BSgenome.Hsapiens.UCSC.hg19.masked-package

(BSgenome.Hsapiens.UCSC.hg19.masked),
1
BSgenomeForge, 1

MaskedDNAString, 1

3


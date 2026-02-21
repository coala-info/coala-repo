BSgenome.Hsapiens.UCSC.hg38.masked

February 11, 2026

BSgenome.Hsapiens.UCSC.hg38.masked

Full masked genomic sequences for Homo sapiens (UCSC version
hg38)

Description

Full genomic sequences for Homo sapiens as provided by UCSC (genome hg38, based on assembly
GRCh38.p14 since 2023/01/31). The sequences are the same as in BSgenome.Hsapiens.UCSC.hg38,
except that each of them has the 4 following masks on top: (1) the mask of assembly gaps (AGAPS
mask), (2) the mask of intra-contig ambiguities (AMB mask), (3) the mask of repeats from Repeat-
Masker (RM mask), and (4) the mask of repeats from Tandem Repeats Finder (TRF mask). Only the
AGAPS and AMB masks are "active" by default. The sequences are stored in MaskedDNAString
objects.

Note

The masks in this BSgenome data package were made from the following source data files:

AGAPS masks: gap.txt.gz, downloaded from https://hgdownload.soe.ucsc.edu/goldenPath/hg38/database/ on Feb. 7, 2023
RM masks: hg38.p14.fa.out.gz, downloaded from https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/p14/ on Feb. 7, 2023
TRF masks: hg38.p14.trf.bed.gz, downloaded from https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/p14/ on Feb. 7, 2023

See ?BSgenome.Hsapiens.UCSC.hg38 in the BSgenome.Hsapiens.UCSC.hg38 package for infor-
mation about how the sequences were obtained.

See ?BSgenomeForge and the BSgenomeForge vignette (vignette("BSgenomeForge")) in the
BSgenome software package for how to create a BSgenome data package.

Author(s)

The Bioconductor Dev Team

1

2

See Also

BSgenome.Hsapiens.UCSC.hg38.masked

• BSgenome.Hsapiens.UCSC.hg38 in the BSgenome.Hsapiens.UCSC.hg38 package for infor-

mation about how the sequences were obtained.

• BSgenome objects in the BSgenome software package.

• The seqinfo getter and Seqinfo objects in the GenomeInfoDb package.

• The seqlevelsStyle getter and setter in the GenomeInfoDb package.

• MaskedDNAString objects in the Biostrings package.

• The available.genomes function in the BSgenome software package.

• The BSgenomeForge vignette (vignette("BSgenomeForge")) in the BSgenome software

package for how to create a BSgenome data package.

Examples

BSgenome.Hsapiens.UCSC.hg38.masked
mbsg <- BSgenome.Hsapiens.UCSC.hg38.masked
head(seqlengths(mbsg))
seqinfo(mbsg)

mbsg$chr1 # a MaskedDNAString object!
## To get rid of the masks altogether:
unmasked(mbsg$chr1) # same as BSgenome.Hsapiens.UCSC.hg38$chr1

if ("AGAPS" %in% masknames(mbsg)) {

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

for (seqname in seqnames(mbsg)) {

cat("Checking sequence", seqname, "... ")
seq <- mbsg[[seqname]]
checkOnlyNsInGaps(seq)
cat("OK\n")

}

}

## ---------------------------------------------------------------------
## Genome-wide motif searching
## ---------------------------------------------------------------------

## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())

BSgenome.Hsapiens.UCSC.hg38.masked

3

vignette("GenomeSearching", package="BSgenome")

Index

∗ data

BSgenome.Hsapiens.UCSC.hg38.masked,

1
∗ package

BSgenome.Hsapiens.UCSC.hg38.masked,

1

available.genomes, 2

BSgenome, 2
BSgenome.Hsapiens.UCSC.hg38, 1, 2
BSgenome.Hsapiens.UCSC.hg38.masked, 1
BSgenome.Hsapiens.UCSC.hg38.masked-package

(BSgenome.Hsapiens.UCSC.hg38.masked),
1
BSgenomeForge, 1

MaskedDNAString, 2

Seqinfo, 2
seqinfo, 2
seqlevelsStyle, 2

4


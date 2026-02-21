BSgenome.Amellifera.UCSC.apiMel2.masked
February 11, 2026

BSgenome.Amellifera.UCSC.apiMel2.masked

Full masked genome sequences for Apis mellifera (UCSC version
apiMel2)

Description

Full genome sequences for Apis mellifera (Honey Bee) as provided by UCSC (apiMel2, Jan. 2005)
and stored in Biostrings objects. The sequences are the same as in BSgenome.Amellifera.UCSC.apiMel2,
except that each of them has the 3 following masks on top: (1) the mask of assembly gaps (AGAPS
mask), (2) the mask of intra-contig ambiguities (AMB mask), and (3) the mask of repeats from
RepeatMasker (RM mask). Only the AGAPS and AMB masks are "active" by default.

Note

The masks in this BSgenome data package were made from the following source data files:

AGAPS masks: http://hgdownload.cse.ucsc.edu/goldenPath/apiMel2/database/gap.txt.gz
RM masks: http://hgdownload.cse.ucsc.edu/goldenPath/apiMel2/bigZips/GroupOut.zip

See ?BSgenome.Amellifera.UCSC.apiMel2 in the BSgenome.Amellifera.UCSC.apiMel2 pack-
age for information about how the sequences were obtained.
See ?BSgenomeForge and the BSgenomeForge vignette (vignette("BSgenomeForge")) in the
BSgenome software package for how to make a BSgenome data package.

Author(s)

The Bioconductor Dev Team

See Also

• BSgenome.Amellifera.UCSC.apiMel2 in the BSgenome.Amellifera.UCSC.apiMel2 pack-

age for information about how the sequences were obtained.

• BSgenome objects and the the available.genomes function in the BSgenome software pack-

age.

• MaskedDNAString objects in the Biostrings package.
• The BSgenomeForge vignette (vignette("BSgenomeForge")) in the BSgenome software

package for how to make a BSgenome data package.

1

2

Examples

BSgenome.Amellifera.UCSC.apiMel2.masked

BSgenome.Amellifera.UCSC.apiMel2.masked
genome <- BSgenome.Amellifera.UCSC.apiMel2.masked
seqlengths(genome)
genome$Group1 # a MaskedDNAString object!
## To get rid of the masks altogether:
unmasked(genome$Group1) # same as BSgenome.Amellifera.UCSC.apiMel2$Group1

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

BSgenome.Amellifera.UCSC.apiMel2.masked,

1
∗ package

BSgenome.Amellifera.UCSC.apiMel2.masked,

1

available.genomes, 1

BSgenome, 1
BSgenome.Amellifera.UCSC.apiMel2, 1
BSgenome.Amellifera.UCSC.apiMel2.masked,

1

BSgenome.Amellifera.UCSC.apiMel2.masked-package

(BSgenome.Amellifera.UCSC.apiMel2.masked),
1
BSgenomeForge, 1

MaskedDNAString, 1

3


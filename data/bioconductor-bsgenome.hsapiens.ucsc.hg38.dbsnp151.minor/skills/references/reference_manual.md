BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor

February 11, 2026

BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor

Full genome sequences for Homo sapiens (UCSC version hg38, based
on GRCh38.p12) with injected minor alleles (dbSNP151)

Description

Full genome sequences for Homo sapiens (Human) as provided by UCSC (hg38, based on GRCh38.p12)
with minor alleles injected from dbSNP151, and stored in Biostrings objects. Only common single
nucleotide variants (SNVs) with at least one alternate allele with frequency greater than 0.01 were
considered. For SNVs with more than 1 alternate allele, the most frequent allele was chosen as the
minor allele to be injected into the reference genome.

Author(s)

Jean-Philippe Fortin

See Also

• BSgenome objects and the available.genomes function in the BSgenome software package.

• DNAString objects in the Biostrings package.

• The BSgenomeForge vignette (vignette("BSgenomeForge")) in the BSgenome software

package for how to make a BSgenome data package.

Examples

BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor
genome_min <- BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor
head(seqlengths(genome_min))

# Getting nucleotide at SNP rs12813551 (C/T, MAF>0.5)
# Minor allele genome has a C:
chr <- "chr12"
pos <- 25241845L
getSeq(genome_min, chr, start=pos, end=pos)

# Reference genome has the minor allele, C:
if (require(BSgenome.Hsapiens.UCSC.hg38)){

1

2

}

BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor

genome_ref <- BSgenome.Hsapiens.UCSC.hg38
getSeq(genome_ref, chr, start=pos, end=pos)

# Major allele genome has a T:
if (require(BSgenome.Hsapiens.UCSC.hg38.dbSNP151.major)){

genome_maj <- BSgenome.Hsapiens.UCSC.hg38.dbSNP151.major
getSeq(genome_maj, chr, start=pos, end=pos)

}

Index

∗ data

BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor,

1
∗ package

BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor,

1

available.genomes, 1

BSgenome, 1
BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor,

1

BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor-package

(BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor),
1

DNAString, 1

Hsapiens

(BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor),
1

3


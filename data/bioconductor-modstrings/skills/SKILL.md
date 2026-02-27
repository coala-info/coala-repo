---
name: bioconductor-modstrings
description: This tool provides comprehensive handling and analysis of DNA and RNA sequences containing modified nucleotides by extending the Biostrings framework. Use when user asks to create modified sequences, convert between standard and modified alphabets, or read and write FASTA files containing non-canonical bases.
homepage: https://bioconductor.org/packages/release/bioc/html/Modstrings.html
---


# bioconductor-modstrings

name: bioconductor-modstrings
description: Comprehensive handling of DNA and RNA sequences containing modified nucleotides. Use when working with post-transcriptionally modified RNA (tRNA, rRNA, mRNA) or modified DNA, including creating, converting, and analyzing sequences with specialized modification alphabets.

## Overview

The Modstrings package extends the Biostrings framework to support nucleic acid sequences containing modified nucleotides. It introduces specialized classes like ModRNAString and ModDNAString that can store, identify, and manipulate non-canonical bases. This is essential for analyzing tRNA, rRNA, and epigenetically modified DNA where standard ACGU/ACGT alphabets are insufficient.

## Core Workflows

### Creating Modified Sequences

Avoid using literal special characters in scripts to prevent encoding issues across different operating systems. Instead, use the following methods:

1. Use modifyNucleotides():
   Apply modifications to an existing RNAString or DNAString by specifying positions and modification short names.
   r <- RNAString("ACGUG")
   mr <- modifyNucleotides(r, at = 5, modifications = "m7G")

2. Use combineIntoModstrings():
   Streamline creation by providing a sequence and a GRanges object containing modification data in a 'mod' column.
   gr <- GRanges(seqnames = "seq1", ranges = IRanges(start = 5, width = 1), mod = "m7G")
   mr <- combineIntoModstrings(r, gr)

3. Inspect Alphabets:
   Check available modifications and their nomenclatures.
   shortName(ModRNAString())
   nomenclature(ModDNAString())
   alphabet(ModRNAString())

### Converting and Exporting Data

1. Tabular Extraction:
   Use separate() to convert a ModString object into a GRanges object, which identifies the location and type of every modification.
   mod_table <- separate(mrs)

2. Reverting to Standard Bases:
   Coerce a ModString to a standard RNAString or DNAString to remove modification information and return to originating bases.
   standard_rna <- RNAString(mr)

3. Quality Scores:
   Handle sequences with quality data using QualityScaledModRNAStringSet or QualityScaledModDNAStringSet.
   qmrs <- QualityScaledModRNAStringSet(mrs, PhredQuality("!!!!h"))

### File I/O

Use specialized functions to preserve modification characters during read/write operations:

1. Fasta/Fastq:
   writeModStringSet(mrs, file = "output.fasta")
   mrs <- readModRNAStringSet("input.fasta", format = "fasta")

2. Quality-scaled Fastq:
   qmrs <- readQualityScaledModRNAStringSet("input.fastq")

### Pattern Matching

Standard Biostrings matching functions are implemented for modified strings:

1. Single Pattern:
   matchPattern("U7", mr) # Where '7' represents m7G

2. Multiple Patterns:
   vmatchPattern("D7", mrs)

## Implementation Tips

1. Originating Base Constraint: A modification can only replace its specific originating base (e.g., m7G can only replace G). The package will throw an error if you attempt to place a modification on the wrong base.
2. Sanitize Input: When importing data from external databases like MODOMICS, use sanitizeFromModomics() to convert external symbols to the Modstrings-compatible alphabet.
3. Comparison: ModString objects can be compared directly to standard XString objects; the comparison automatically handles the conversion to originating bases for the check.

## Reference documentation

- [ModDNAString alphabet](./references/ModDNAString-alphabet.md)
- [ModRNAString alphabet](./references/ModRNAString-alphabet.md)
- [Modstrings Main Guide](./references/Modstrings.md)
---
name: r-seqinr
description: The r-seqinr tool provides functions for the retrieval and analysis of DNA and protein sequences within the R environment. Use when user asks to read or write FASTA files, calculate GC content, perform codon usage analysis, translate sequences, or interface with ACNUC databases.
homepage: https://cloud.r-project.org/web/packages/seqinr/index.html
---

# r-seqinr

name: r-seqinr
description: Retrieval and analysis of biological sequences (DNA and protein) using the seqinr R package. Use this skill when performing exploratory data analysis, sequence management via ACNUC, calculating biological statistics (GC content, codon usage), or handling FASTA/GenBank files in R.

# r-seqinr

## Overview
The `seqinr` package provides tools for the retrieval and analysis of biological sequences. It is particularly strong in DNA and protein sequence statistics, codon usage analysis, and interfacing with the ACNUC database system.

## Installation
To install the package from CRAN:
```r
install.packages("seqinr")
library(seqinr)
```

## Core Workflows

### 1. Sequence Input and Output
- **Read FASTA**: `read.fasta(file = "myfile.fasta", seqtype = "DNA", as.string = TRUE)`
- **Write FASTA**: `write.fasta(sequences, names, file.out = "output.fasta")`
- **Get Sequence**: `getSequence(object)` returns a vector of characters.

### 2. DNA Analysis
- **GC Content**: `GC(sequence)` calculates the fraction of G+C.
- **Base Composition**: `count(sequence, wordsize)` counts oligonucleotides of a specific length.
- **Reverse Complement**: `revcomp(sequence)` returns the reverse-complement of a DNA sequence.
- **Translation**: `translate(sequence, frame = 0, sens = "F", numcode = 1)` translates DNA to protein.

### 3. Protein Analysis
- **Isoelectric Point**: `computePI(protein_seq)` calculates the theoretical pI.
- **Molecular Weight**: `mw(protein_seq)` calculates the molecular weight.
- **AA Composition**: `AAstat(protein_seq)` provides a summary of amino acid properties.

### 4. Codon Usage
- **RSCU**: `uco(sequence, index = "rscu")` calculates Relative Synonymous Codon Usage.
- **Codon Adaptation Index (CAI)**: `cai(sequence, reference)` calculates the CAI based on a reference set.

### 5. ACNUC Database Access
- **Connect**: `choosebank("genbank")`
- **Query**: `query("my_query", "sp=homo sapiens AND k=kinase")`
- **Close**: `closebank()`

## Tips and Best Practices
- **Sequence Types**: Always specify `seqtype = "DNA"` or `"AA"` (Amino Acid) in functions like `read.fasta` to ensure correct downstream analysis.
- **Internal Data**: Use `data(all_genetic_codes)` to see available translation tables.
- **String vs Vector**: Many functions expect a vector of single characters. If your sequence is a single string, use `s2c(string)` to convert it to a character vector. Use `c2s(vector)` to convert back to a string.

## Reference documentation
- [SeqinR Home Page](./references/home_page.md)
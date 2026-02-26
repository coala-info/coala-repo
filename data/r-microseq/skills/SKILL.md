---
name: r-microseq
description: This tool provides basic biological sequence handling in R by storing FASTA and FASTQ data in tibbles for compatibility with the tidyverse. Use when user asks to read or write sequence files, translate DNA to protein, find genes, or manipulate sequences using standard R data structures.
homepage: https://cloud.r-project.org/web/packages/microseq/index.html
---


# r-microseq

name: r-microseq
description: Basic biological sequence handling in R. Use this skill when you need to read, write, or manipulate FASTA and FASTQ files using standard R data structures (tibbles). It is ideal for microbial genomics workflows, gene finding, sequence translation, and sequence wrangling compatible with the tidyverse.

## Overview
The `microseq` package provides basic functions for microbial sequence analysis. Its core philosophy is to use generic R data structures—specifically tibbles—to store sequence data. This allows users to use standard tools like `dplyr`, `stringr`, and `tidyr` for biological sequence manipulation, rather than relying on complex specialized objects.

## Installation
To install the package from CRAN:
```R
install.packages("microseq")
```

## Core Functions and Workflows

### Reading and Writing Sequences
The package reads FASTA and FASTQ files into tibbles where each row is a sequence.

- **FASTA**: `readFasta("file.fasta")` returns a tibble with columns `Header` and `Sequence`.
- **FASTQ**: `readFastq("file.fastq")` returns a tibble with columns `Header`, `Sequence`, and `Quality`.
- **Writing**: Use `writeFasta(my_tibble, "out.fasta")` or `writeFastq(my_tibble, "out.fastq")`.

### Sequence Manipulation
Since sequences are stored as character strings in a tibble, you can use standard R functions or `microseq` utilities:

- **Reverse Complement**: `reverseComplement(sequence_vec)`
- **Translation**: `translate(sequence_vec)` converts DNA/RNA to Amino Acids.
- **Sub-sequences**: Use `stringr::str_sub()` or `base::substr()` directly on the `Sequence` column.

### Gene Finding
The package includes a fast gene finder:
- `findGenes(sequence_vec)`: Identifies potential protein-coding genes (ORFs) in a set of sequences. It returns a tibble with information on start, stop, strand, and the predicted protein sequence.

### Sequence Statistics
- `charCount(sequence_vec, chars = "GC")`: Efficiently counts specific characters (e.g., for calculating GC content).
- `countGaps(sequence_vec)`: Counts gap characters in alignments.

## Usage Tips
- **Tidyverse Integration**: Always use `dplyr::mutate()` to create new sequence columns (e.g., translating DNA to protein).
- **Memory Efficiency**: While tibbles are convenient, for extremely large datasets (e.g., raw Illumina reads), consider the memory overhead of character strings compared to specialized Bioconductor containers. `microseq` is best suited for genomes, contigs, and processed gene sets.
- **Header Parsing**: Use `tidyr::separate()` or `stringr::str_match()` on the `Header` column to extract metadata like Accession numbers or Taxon names.

## Reference documentation
- [microseq Home Page](./references/home_page.md)
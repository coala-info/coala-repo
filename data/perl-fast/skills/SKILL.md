---
name: perl-fast
description: The FAST Analysis of Sequences Toolbox provides command-line utilities for processing biological sequence records using UNIX-style text processing patterns. Use when user asks to filter records by regex or length, transform sequences, calculate composition statistics, or perform taxonomic sorting.
homepage: http://metacpan.org/pod/FAST
metadata:
  docker_image: "quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2"
---

# perl-fast

## Overview

The FAST Analysis of Sequences Toolbox (FAST) provides a suite of command-line utilities that bring the power of standard UNIX text processing (like grep, cut, and head) to biological sequence records. Instead of treating files as collections of lines, perl-fast treats them as collections of discrete sequence objects. This allows for sophisticated serial processing where the output of one tool serves as the input for the next, enabling complex bioinformatics workflows without the need for custom Perl or Python scripting.

## Core Utilities and Usage Patterns

### Filtering and Selection
*   **fasgrep**: Filter records using Perl regular expressions against sequence IDs or the sequences themselves.
*   **fasfilter**: Filter records based on numerical attributes (e.g., filtering by a specific length range).
*   **fashead / fastail**: Extract the first or last N records from a file.
*   **fascut**: Select or reorder specific sequence records based on index lists or ranges.
*   **fasuniq**: Remove duplicate records from a sorted stream.

### Transformation and Modification
*   **fastr**: Transform sequence characters (e.g., degapping or case conversion).
*   **fasrc**: Generate the reverse complement of nucleotide sequences.
*   **fassub**: Perform regex-based substitutions on sequence data or headers.
*   **fasxl**: Translate nucleotide sequences into amino acids, supporting gapped alignments.
*   **faspaste**: Concatenate sequence records horizontally.

### Analysis and Annotation
*   **faswc**: Count the number of sequences and total characters in a file.
*   **faslen**: Calculate and append sequence lengths to the record headers.
*   **fascomp / fascodon**: Tally monomer (nucleotide/amino acid) frequencies or codon usage.
*   **alnpi**: Calculate molecular population genetic statistics from alignments.

### Sorting and Taxonomy
*   **fassort**: Sort records based on various criteria.
*   **fastax / fastaxsort**: Filter or sort records based on NCBI taxonomy IDs or names.

## Expert Tips and Best Practices

1.  **Pipeline Efficiency**: Always chain commands using standard UNIX pipes (`|`). Since perl-fast tools are designed for serial processing, you can perform complex filtering and transformation in a single command string.
    *   *Example*: `fasgrep "Homo sapiens" input.fasta | faslen | fasfilter -n "len > 500" > filtered.fasta`
2.  **Regex Power**: Leverage the fact that `fasgrep` and `fassub` use Perl-compatible regular expressions (PCRE), allowing for much more complex pattern matching than standard grep.
3.  **Format Support**: While the default is Multi-FASTA, the tools are compatible with FASTQ. Use `fasconvert` if you need to move between specific biological flatfile formats.
4.  **Header Preservation**: Many tools (like `faslen`) annotate records by adding information to the header. Be mindful of header length and format if the downstream tool has strict requirements.
5.  **Memory Management**: Because perl-fast processes records serially, it is generally memory-efficient even for very large datasets, as it does not need to load the entire database into RAM.

## Reference documentation
- [FAST - FAST Analysis of Sequences Toolbox](./references/metacpan_org_pod_FAST.md)
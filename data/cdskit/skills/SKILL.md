---
name: cdskit
description: cdskit is a toolkit for processing protein-coding DNA sequences that performs codon-aware operations to preserve open reading frames. Use when user asks to pad sequences to multiples of three, mask stop codons, back-translate protein alignments, trim codon-based alignments, extract degenerate sites, or find the longest open reading frame.
homepage: https://github.com/kfuku52/cdskit
---


# cdskit

## Overview

cdskit is a specialized toolkit designed for the bioinformatic processing of protein-coding DNA sequences. Unlike general-purpose sequence tools, cdskit treats the codon (three nucleotides) as the fundamental unit of operation. This ensures that edits—such as trimming, masking, or padding—preserve the open reading frame (ORF). It is particularly useful for preparing datasets for molecular evolution studies, phylogenetics, and comparative genomics where maintaining the relationship between DNA and its translated protein product is critical.

## Core Workflows and CLI Patterns

### 1. Sequence Preparation and Cleaning
Before downstream analysis, use these commands to ensure sequences are in-frame and free of problematic characters.

*   **In-frame Padding**: Add head/tail Ns to make sequences a multiple of three.
    `cdskit pad input.fasta > padded.fasta`
*   **Masking**: Replace ambiguous codons or internal stop codons with NNN or ???.
    `cdskit mask --mask_stop yes --mask_ambig yes input.fasta > masked.fasta`
*   **Gap Adjustment**: Standardize consecutive Ns (often representing gaps) to a fixed length.
    `cdskit gapjust --length 3 input.fasta`

### 2. Alignment Manipulation
Handle codon-based alignments to maintain biological signal.

*   **Back-translation**: Use a protein alignment to guide the alignment of corresponding DNA sequences.
    `cdskit backtrim --protein_aln prot.fasta --dna_seq dna.fasta > dna_aln.fasta`
*   **Hammering**: Remove columns in a codon alignment that are poorly occupied (gappy).
    `cdskit hammer --threshold 0.5 input.fasta`
*   **Trimming**: Remove codon columns based on occupancy or ambiguity.
    `cdskit trimcodon --min_occupancy 0.8 input.fasta`

### 3. Feature Extraction and Statistics
Extract specific biological signals from CDS data.

*   **Codon Position Splitting**: Separate 1st, 2nd, and 3rd positions into different files.
    `cdskit split input.fasta --prefix my_data`
*   **Degeneracy Extraction**: Extract 0-fold, 2-fold, 3-fold, or 4-fold degenerate sites.
    `cdskit degeneracy --site 4fold input.fasta`
*   **ORF Finding**: Identify the longest ORF using six-frame translation.
    `cdskit longestorf input.fasta`

### 4. Streamlined Pipe Integration
cdskit is designed for Unix-style piping. Combine it with tools like `seqkit` for powerful workflows.

```bash
# Example: Clean, pad, mask, and translate in one line
cat input.fasta | cdskit pad | cdskit mask | cdskit translate > final_pep.fasta
```

## Expert Tips

*   **Regex Filtering**: Use `cdskit printseq` or `cdskit rmseq` with the `-x` flag to filter sequences by name using regular expressions. This is faster than manual editing for large datasets.
*   **GenBank Parsing**: Use `cdskit parsegb` to extract CDS features directly from GenBank files while maintaining metadata.
*   **Validation**: Always run `cdskit validate` on your final alignment to check for unexpected stop codons or frame issues before starting expensive evolutionary analyses.
*   **Labeling**: Use `cdskit label` to batch-rename sequences based on patterns, which is essential when merging datasets from different sources.



## Subcommands

| Command | Description |
|---------|-------------|
| backalign | Backalign CDS sequences to their corresponding aligned amino acid sequences. |
| cdskit accession2fasta | Convert NCBI accession numbers to FASTA sequences. |
| cdskit intersection | Performs intersection operations on CDS sequences. |
| cdskit label | Label sequences in a file. |
| cdskit_aggregate | Aggregate sequences based on a regular expression. |
| cdskit_backtrim | Backtrim CDS alignments to match trimmed amino acid alignments. |
| cdskit_gapjust | Adjusts gap lengths in sequences. |
| cdskit_hammer | Hammer sequences to remove gaps and ambiguous bases. |
| cdskit_mask | Masks codons in a sequence file based on specified criteria. |
| cdskit_pad | Pad CDS sequences to be multiples of three. |
| cdskit_parsegb | Parse GenBank files. |
| cdskit_printseq | Print sequences from a sequence file. |
| cdskit_split | Split CDS sequences into multiple files based on sequence identifiers. |
| cdskit_stats | Calculate statistics for CDS sequences. |
| rmseq | Remove sequences based on name or problematic characters. |

## Reference documentation

- [cdskit Wiki Home](./references/github_com_kfuku52_cdskit_wiki.md)
- [Installation and Dependencies](./references/github_com_kfuku52_cdskit_wiki_Installation-and-dependencies.md)
- [Command: accession2fasta](./references/github_com_kfuku52_cdskit_wiki_cdskit-accession2fasta.md)
- [Command: split](./references/github_com_kfuku52_cdskit_wiki_cdskit-split.md)
- [Command: mask](./references/github_com_kfuku52_cdskit_wiki_cdskit-mask.md)
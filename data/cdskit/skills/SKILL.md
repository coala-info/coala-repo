---
name: cdskit
description: cdskit is a specialized suite of command-line utilities designed for bioinformaticians working with protein-coding DNA.
homepage: https://github.com/kfuku52/cdskit
---

# cdskit

## Overview

cdskit is a specialized suite of command-line utilities designed for bioinformaticians working with protein-coding DNA. Unlike general-purpose sequence tools, cdskit treats the codon (a triplet of nucleotides) as the fundamental unit of operation. This ensures that common tasks—like masking ambiguous bases, trimming alignments, or adding padding—preserve the open reading frame (ORF) and prevent the introduction of artificial frameshift mutations. It is built to integrate seamlessly into bioinformatics pipelines via standard input/output piping.

## CLI Usage and Best Practices

### Core Workflow: Preparing Sequences for Translation
When working with raw CDS data that may be incomplete or contain problematic characters, use a piped approach to clean the data before translating to protein sequences.

```bash
# Standard cleaning pipeline: Pad to frame -> Mask stops/ambiguities -> Translate
cat input.fasta | cdskit pad | cdskit mask | seqkit translate > cleaned_protein.fasta
```

### Key Subcommands and Patterns

*   **In-Frame Padding (`pad`)**: Use this first if your sequences are not multiples of three. It adds "N" or "-" to the head and tail to ensure the sequence is in-frame.
*   **Codon Position Splitting (`split`)**: Essential for molecular evolution studies. Use this to separate the 1st, 2nd, and 3rd codon positions into different files.
    *   *Tip*: Use the `--prefix` flag to name the resulting files (e.g., `cdskit split --prefix my_gene input.fasta`).
*   **Masking (`mask`)**: Use this to replace stop codons or ambiguous nucleotides with "N" or "?". This prevents downstream alignment tools from failing or misinterpreting stop codons as valid amino acids.
*   **Filtering by Length (`aggregate`)**: When dealing with multiple isoforms or redundant hits, use `cdskit aggregate` with a regex to keep only the longest sequence per group.
    *   *Example*: `cdskit aggregate -x ":.*" input.fasta` (removes everything after a colon in the header to group sequences).
*   **Cleaning Alignments (`hammer`)**: Use this on gappy codon alignments to remove columns that are poorly occupied, which improves the signal-to-noise ratio in phylogenetic trees.

### Expert Tips
*   **Standard Input**: Most `cdskit` commands accept input from `stdin`. Always prefer piping (`|`) to avoid creating unnecessary intermediate files.
*   **Biopython Compatibility**: Since `cdskit` uses Biopython for I/O, you can specify formats using standard Biopython strings (e.g., `fasta`, `genbank`, `phylip`).
*   **Back-translation**: If you have a high-quality protein alignment and the original DNA sequences, use `cdskit backtrim` to create a codon-aware DNA alignment that matches the protein gaps exactly.

## Reference documentation
- [cdskit GitHub Repository](./references/github_com_kfuku52_cdskit.md)
- [cdskit Command Overview](./references/github_com_kfuku52_cdskit_wiki.md)
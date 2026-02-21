---
name: meme
description: STREME (Sensitive, Thorough, Rapid, Enriched Motif Elicitation) discovers motifs in a set of sequences.
homepage: https://meme-suite.org
---

# meme

## Overview
The MEME Suite is a collection of tools designed for the analysis of sequence motifs. It is primarily used to discover novel, ungapped patterns in sets of related sequences (MEME, STREME), search for known motifs in new sequences (FIMO, MAST), and determine if specific motifs are enriched in a dataset relative to a control (AME, CentriMo). It supports DNA, RNA, and protein sequences and is a standard in bioinformatics for studying transcription factor binding sites and protein domains.

## Core Tool Workflows

### 1. Motif Discovery with MEME
Use `meme` for discovery in smaller datasets or when precise statistical modeling of motif distribution is required.

*   **Distribution Models (`-mod`):**
    *   `oops`: One Occurrence Per Sequence. Fastest, but sensitive to "noise" sequences without the motif.
    *   `zoops`: Zero or One Occurrence Per Sequence. Best for most discovery tasks where the motif might not be in every sequence.
    *   `anr`: Any Number of Repetitions. Use for finding repeats or motifs that appear multiple times per sequence.
*   **Common CLI Pattern:**
    ```bash
    meme sequences.fasta -dna -mod zoops -nmotifs 3 -minw 6 -maxw 15 -oc output_dir
    ```
*   **Expert Tip:** Use `-revcomp` for DNA sequences unless the motif is known to be strand-specific (e.g., RNA-binding protein sites).

### 2. Rapid Discovery with STREME
Use `streme` for large datasets (e.g., ChIP-seq peaks) where `meme` would be too slow. It is designed to find motifs enriched in a primary set relative to a control set.

*   **Common CLI Pattern:**
    ```bash
    streme --p primary.fasta --n control.fasta --dna --minw 8 --maxw 15 --oc streme_out
    ```
*   **Expert Tip:** If no control file is provided, STREME will automatically generate one by shuffling the primary sequences.

### 3. Motif Scanning with FIMO
Use `fimo` to locate occurrences of known motifs (in MEME format) within a genome or sequence set.

*   **Common CLI Pattern:**
    ```bash
    fimo --thresh 1e-4 --oc fimo_out motifs.meme sequences.fasta
    ```
*   **Expert Tip:** The default p-value threshold is `1e-4`. For large genomes, consider a more stringent threshold (e.g., `1e-6`) to reduce false positives.

### 4. Enrichment Analysis (AME & CentriMo)
*   **AME:** Tests for general enrichment of motifs anywhere in the sequences.
    ```bash
    ame --control control.fasta primary.fasta motif_database.meme
    ```
*   **CentriMo:** Tests for local enrichment, specifically looking for motifs clustered in the center of sequences (ideal for ChIP-seq).
    ```bash
    centrimo --oc centrimo_out sequences.fasta motif_database.meme
    ```

## Input Format Requirements

### FASTA Sequences
*   Must be plain text.
*   Sequence IDs must follow the `>` character without whitespace.
*   For `meme`, use the `-dna`, `-rna`, or `-protein` flags to specify the alphabet.

### MEME Motif Format
*   A minimal MEME file requires: `MEME version`, `ALPHABET`, and a `MOTIF` line followed by a `letter-probability matrix`.
*   **Example Minimal Header:**
    ```text
    MEME version 5
    ALPHABET= ACGT
    strands: + -
    Background letter frequencies
    A 0.25 C 0.25 G 0.25 T 0.25
    ```

## Expert Best Practices
*   **Sequence Length:** For ChIP-seq discovery, use centered 100bp-200bp regions. Longer sequences increase noise and computation time.
*   **Background Models:** Use `fasta-get-markov` to create a background model from your specific genome/organism. This significantly improves the accuracy of p-values and E-values.
    ```bash
    fasta-get-markov -m 1 < genome.fasta > genome.bg
    meme sequences.fasta -bg genome.bg [options]
    ```
*   **Handling RNA:** When using RNA, convert `U` to `T` or ensure the tool is explicitly set to RNA mode. Many MEME tools treat RNA as DNA internally but ignore the reverse strand if specified.

## Reference documentation
- [MEME Tool Documentation](./references/meme-suite_org_meme_tools_meme.md)
- [STREME Tool Documentation](./references/meme-suite_org_meme_tools_streme.md)
- [MEME Motif Format Specification](./references/meme-suite_org_meme_doc_meme-format.html.md)
- [FASTA Format Specification](./references/meme-suite_org_meme_doc_fasta-format.html.md)
- [AME Enrichment Analysis](./references/meme-suite_org_meme_tools_ame.md)
- [CentriMo Local Enrichment](./references/meme-suite_org_meme_tools_centrimo.md)
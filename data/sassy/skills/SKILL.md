---
name: sassy
description: "Sassy is a high-performance utility for SIMD-accelerated approximate string matching optimized for biological data. Use when user asks to search for DNA patterns with mismatches or indels, perform color-coded grep-like sequence matching, filter FASTA/FASTQ records based on pattern hits, or identify CRISPR off-target sites."
homepage: https://github.com/ragnargrootkoerkamp/sassy
---


# sassy

## Overview
Sassy is a high-performance utility for SIMD-accelerated approximate string matching. It is specifically optimized for biological data, supporting DNA (ACGT) and IUPAC (ambiguity codes) alphabets alongside standard ASCII. By leveraging bitpacking and SIMD tiling, it provides rapid searching for short patterns within large reference texts or sequencing reads, allowing for substitutions, insertions, and deletions up to a user-defined cost (k).

## CLI Usage Patterns

### Basic Searching
Use `sassy search` to find occurrences of a pattern and output results in a tab-delimited (TSV) format.
*   **Single pattern search:** `sassy search --pattern ATGAGCA -k 1 genome.fasta`
*   **Multiple patterns from file:** `sassy search --pattern-fasta queries.fasta -k 2 reads.fastq`
*   **Save matches to file:** `sassy search -p ACGT -k 1 input.fa --matches results.tsv`

### Visual Inspection (Grep Mode)
Use `sassy grep` for human-readable, color-coded output highlighting matches, mismatches (orange), deletions (red), and insertions (blue).
*   **Command:** `sassy grep -p GCTAGCTAG -k 2 sequences.txt`

### Filtering Records
Use `sassy filter` to extract or exclude specific records from FASTA/FASTQ files based on pattern matches.
*   **Keep matching records:** `sassy filter -p [PATTERN] -k [K] input.fq -o filtered.fq`
*   **Discard matching records (Invert):** `sassy filter -p [PATTERN] -k [K] input.fq --invert -o non_matches.fq`

### CRISPR Off-target Search
The `crispr` command is specialized for guide RNA searching, enforcing exact PAM matches by default.
*   **Standard search:** `sassy crispr --guide guides.txt -k 3 --threads 8 hg38.fa > hits.tsv`
*   **Allow PAM edits:** Add the `--allow-pam-edits` flag if the PAM sequence does not need to be exact.
*   **Filter by N-fraction:** Use `--max-n-frac 0.1` to limit matches in regions with high ambiguity.

## Expert Tips
*   **Alphabet Selection:** If the input is strictly ACGT, the DNA profile is slightly faster. If the input contains ambiguity codes (N, Y, R, etc.), ensure the IUPAC profile is used.
*   **Performance:** Sassy is optimized for patterns between 20 and 100 characters but remains efficient up to 1000. Performance relies on AVX2 or NEON instructions; ensure the environment supports these for maximum speed.
*   **Overhangs:** Sassy supports overhang alignments where the pattern extends beyond the boundaries of the text.
*   **CIGAR Strings:** The TSV output includes CIGAR strings (e.g., `42=`, `37=1X4=`), which are useful for downstream bioinformatic analysis of alignment types.

## Reference documentation
- [Sassy GitHub Repository](./references/github_com_RagnarGrootKoerkamp_sassy.md)
- [Sassy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sassy_overview.md)
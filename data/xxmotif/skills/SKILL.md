---
name: xxmotif
description: XXmotif is a specialized tool designed to identify sequence motifs using position weight matrices (PWMs) rather than simple consensus strings.
homepage: https://github.com/soedinglab/xxmotif
---

# xxmotif

## Overview
XXmotif is a specialized tool designed to identify sequence motifs using position weight matrices (PWMs) rather than simple consensus strings. It excels at discovering complex motifs, including those with gaps, palindromic structures, or tandem repeats. By employing an exhaustive search strategy and a statistical model that can incorporate localization and conservation data, it provides high sensitivity for regulatory element discovery in genomic datasets.

## Command Line Usage

The basic syntax for running XXmotif is:
`XXmotif OUTDIR SEQFILE [options]`

### Common Patterns

**Basic Discovery**
Run a standard search on a FASTA file, outputting results to a specific directory:
`XXmotif ./output_dir sequences.fasta`

**Comparative Enrichment**
Use a negative/background set to find motifs specifically enriched in the positive set:
`XXmotif ./output_dir positive.fasta --negSet background.fasta`

**Strand-Specific Search**
By default, XXmotif does not search the reverse complement. For double-stranded DNA where orientation is unknown, enable:
`XXmotif ./output_dir sequences.fasta --revcomp`

**Masking Sequences**
To prevent the discovery of motifs in repetitive or low-complexity regions:
`XXmotif ./output_dir sequences.fasta --XXmasker`

### Advanced Configuration

*   **Occurrence Model**: Use `--mops` (Multiple Occurrence Per Sequence) if a motif is expected to appear multiple times within a single sequence. The default is ZOOPS (Zero Or One Per Sequence).
*   **Seed Types**: Restrict the search to specific structural motifs using `--type`:
    *   `PALINDROME`: Search for inverted repeats.
    *   `TANDEM`: Search for direct repeats.
    *   `FIVEMERS`: Standard short seeds.
*   **Localization**: If motifs are expected at a specific distance from an anchor point (e.g., a Transcription Start Site), use `--localization`. Note that all input sequences must be the same length for this mode.
*   **Jump-starting**: If you have a known motif and want to refine it or find variants, use:
    *   `-m "IUPAC_STRING"`: e.g., `-m "TATAWAWR"`
    *   `-p profile_file`: Provide a custom PWM file.

## Output Files

XXmotif generates several key files in the output directory:
1.  `*_MotifFile.txt`: A summary of discovered motifs, including E-values, IUPAC consensus, and occurrence percentages.
2.  `*_Pvals.txt`: Detailed list of every motif site found, including coordinates, strand, and P-values.
3.  `*.pwm`: Position Weight Matrices for all detected motifs, suitable for use in other bioinformatics pipelines.
4.  `*_sequence.txt`: Mapping of internal sequence numbers to the original FASTA headers.

## Expert Tips
*   **Background Order**: When using a negative set, the default background model order is 8. For small datasets, consider lowering this with `--background-model-order` to avoid overfitting.
*   **Merging**: If you receive many redundant motifs, set `--merge-motif-threshold HIGH` to consolidate similar PWMs.
*   **Gapped Seeds**: To find motifs with internal spacers, increase the gap allowance: `-g 3`.

## Reference documentation
- [XXmotif README](./references/github_com_soedinglab_xxmotif.md)
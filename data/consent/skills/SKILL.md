---
name: consent
description: CONSENT performs self-correction and assembly polishing for long-read sequencing data using multiple sequence alignment and local de Bruijn graphs. Use when user asks to perform self-correction on raw long reads or refine a draft assembly using long reads.
homepage: https://github.com/morispi/CONSENT
---

# consent

## Overview

CONSENT (Scalable long read self-correction and assembly polishing with multiple sequence alignment) is a tool designed to handle the high error rates associated with long-read sequencing technologies. It functions by computing overlaps between reads to define alignment piles, which are then partitioned into windows. Each window is corrected independently using a two-step strategy: first, a multiple alignment strategy computes a consensus, and second, this consensus is polished using a local de Bruijn graph to eliminate remaining errors.

## Command Line Usage

### Self-Correction
Use `CONSENT-correct` to perform self-correction on raw long reads.

```bash
./CONSENT-correct --in <reads.fasta|fastq> --out <corrected.fasta> --type <PB|ONT> [options]
```

*   **--type**: Must be specified as `PB` (PacBio) or `ONT` (Oxford Nanopore) to set appropriate alignment parameters.
*   **--nproc, -j**: Number of threads to use (defaults to all available cores).

### Assembly Polishing
Use `CONSENT-polish` to refine a draft assembly using long reads.

```bash
./CONSENT-polish --contigs <draft.fasta> --reads <long_reads.fasta|fastq> --out <polished.fasta> [options]
```

## Optimization and Expert Tips

### Performance and Resource Management
*   **Memory Control**: If running on a machine with limited RAM, use `--minimapIndex` (e.g., `-m 500M`) to split the minimap2 index into smaller chunks.
*   **Temporary Files**: CONSENT generates large intermediate alignment files. Use `--tmpdir` to point to a high-speed disk or a specific directory to avoid cluttering the working directory.

### Tuning Correction Sensitivity
*   **Window Size**: The default window size is 500bp (`-l 500`). For extremely noisy data, decreasing this might improve MSA stability, though it increases computational overhead.
*   **Support Thresholds**: 
    *   `--minSupport` (default 3 for correction, 1 for polishing): Increase this value if you have very high coverage and want to ensure only high-confidence overlaps are used.
    *   `--maxSupport` (default 150): Limits the number of sequences in an alignment pile to prevent bottlenecks in the MSA step.
*   **K-mer Polishing**: The `--merSize` (default 9) and `--solid` (default 4) parameters control the local de Bruijn graph polishing. If coverage is low, you may need to decrease the `--solid` threshold to consider k-mers as valid.

### Troubleshooting
*   **Path Requirements**: Ensure `minimap2` is in your system PATH, as CONSENT relies on it for the initial overlapping/alignment phase.
*   **Input Formats**: While the output is always FASTA, the input can be either FASTA or FASTQ.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/CONSENT-correct | Indicate whether the long reads are from PacBio (--type PB) or Oxford Nanopore (--type ONT) |
| /usr/local/bin/CONSENT-polish | Polishes contigs using long reads. |

## Reference documentation
- [CONSENT Main Repository](./references/github_com_morispi_CONSENT.md)
- [CONSENT README](./references/github_com_morispi_CONSENT_blob_master_README.md)
- [CONSENT-correct Script](./references/github_com_morispi_CONSENT_blob_master_CONSENT-correct.md)
- [CONSENT-polish Script](./references/github_com_morispi_CONSENT_blob_master_CONSENT-polish.md)
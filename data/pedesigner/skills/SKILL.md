---
name: pedesigner
description: The pedesigner tool automates the design of pegRNAs and secondary nicking guides for CRISPR prime editing systems by optimizing primer binding site and reverse transcription template lengths. Use when user asks to design pegRNAs, calculate optimal PBS and RTT lengths, or generate sequences for PE3 prime editing experiments.
homepage: https://github.com/VeredKunik/pedesigner
---


# pedesigner

## Overview
The `pedesigner` tool is a specialized utility for researchers working with CRISPR prime editing systems. Unlike standard CRISPR which relies on double-strand breaks, prime editing uses a search-and-replace mechanism. This tool automates the design of the pegRNA—the most critical component—by calculating the optimal lengths for the Primer Binding Site (PBS) and the Reverse Transcription Template (RTT). It evaluates potential target sequences and provides the necessary sequences for the pegRNA extension and secondary nicking guides (PE3 approach).

## CLI Usage and Patterns

The tool requires specific sequence files and parameter ranges to generate design candidates.

### Basic Command Structure
```bash
pedesigner -m <mismatches> \
           --pbs_min <min_len> --pbs_max <max_len> \
           --rtt_min <min_len> --rtt_max <max_len> \
           <ref.fa> <edit.fa> <PAM> <genome.fa>
```

### Parameter Definitions
- `-m`: Maximum number of mismatches allowed for off-target considerations.
- `--pbs_min` / `--pbs_max`: The range for the Primer Binding Site length (typically 10–15 nt).
- `--rtt_min` / `--rtt_max`: The range for the Reverse Transcription Template length (typically 10–30 nt).
- `<ref.fa>`: FASTA file containing the wild-type (original) sequence.
- `<edit.fa>`: FASTA file containing the desired edited sequence.
- `<PAM>`: The Protospacer Adjacent Motif required by the Cas9 variant (e.g., `NGG`).
- `<genome.fa>`: The full genome reference file used to check for off-target effects.

### Resource Management
The tool behaves differently depending on whether CPU resources are explicitly managed by the user or an external scheduler (like Slurm or Snakemake):

- **Manual Execution**: Use the `--use_cpus` flag to allow the tool to manage local parallelization.
- **Managed Execution**: Omit `--use_cpus` when running within a cluster environment where CPU allocation is handled by the job scheduler.

## Best Practices for pegRNA Design

1. **Sequence Preparation**: Ensure `<ref.fa>` and `<edit.fa>` are centered around the mutation site. The sequences should be long enough to accommodate the maximum RTT length and the initial spacer sequence (usually ~100-200bp).
2. **PBS Optimization**: Start with a range of 10–15 nt. Shorter PBS sequences may decrease binding stability, while excessively long ones can hinder the dissociation required for the next steps of prime editing.
3. **RTT Optimization**: The RTT must cover the mutation and extend beyond it. A common starting range is 10–20 nt. If the edit is a large insertion, the RTT must be lengthened accordingly.
4. **Off-target Analysis**: Setting the `-m` (mismatch) parameter higher increases the sensitivity of off-target detection but significantly increases computation time. A value of 2 or 3 is standard for initial screening.
5. **PAM Selection**: While `NGG` is standard for SpCas9, ensure the PAM provided matches the specific prime editor protein being used in the lab.

## Reference documentation
- [pedesigner GitHub Repository](./references/github_com_VeredKunik_pedesigner.md)
- [pedesigner Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pedesigner_overview.md)
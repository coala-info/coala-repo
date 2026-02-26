---
name: circulocov
description: CirculoCov calculates and visualizes read mapping coverage for circular sequences by padding reference ends to eliminate edge effects. Use when user asks to analyze circular genome coverage, map reads to circular contigs, or generate depth plots for bacterial assemblies.
homepage: https://github.com/erinyoung/CirculoCov
---


# circulocov

## Overview
CirculoCov addresses the "edge effect" in bioinformatics where read mapping coverage appears artificially low at the start and end of circular sequences represented linearly. It solves this by "padding" the reference—appending the beginning of the sequence to its end during the mapping process. The tool automates the workflow of circularity detection, read mapping via `minimap2`, and depth calculation via `pysam`, providing both tabular summaries and visual plots.

## Circularity Detection
The tool determines if a sequence is circular by scanning FASTA headers for specific keywords (case-insensitive). To ensure a contig is treated as circular, include one of the following in the header:
- `circular=true` or `circular=t`
- `circ=true` or `circ=t`
- `complete sequence`

## Common CLI Patterns

### Basic Coverage Analysis
Run a standard analysis using Nanopore reads against a draft assembly:
```bash
circulocov -g assembly.fasta -n nanopore_reads.fastq.gz -o output_dir
```

### Hybrid Analysis (Illumina + Nanopore)
Map both short and long reads simultaneously to compare coverage profiles:
```bash
circulocov -g assembly.fasta -i R1.fastq.gz R2.fastq.gz -n nanopore.fastq.gz -o hybrid_out
```

### Generating All Outputs
Use the `-a` or `--all` flag to trigger optional steps: extracting per-contig FASTQ files, calculating full depth (not just windows), and generating depth visualizations.
```bash
circulocov -g assembly.fasta -n reads.fastq.gz -o full_results -a
```

### Adjusting Resolution and Padding
For very small plasmids or specific resolution needs, adjust the window count and padding:
```bash
circulocov -g assembly.fasta -n reads.fastq.gz -w 500 -d 5000 -o custom_res
```
- `-w`: Number of "snapshots" (windows) taken across the genome.
- `-d`: Bases added to the end of circular sequences (default is 10,000).

## Expert Tips and Best Practices

- **Padding Impact**: The default 10kb padding is optimized for bacterial chromosomes. If working with small plasmids (e.g., <15kb), consider reducing the padding (`-d`) to avoid over-representation of the sequence.
- **Interpreting Windows**: CirculoCov "windows" are snapshots at specific positions rather than traditional sliding windows. This is computationally efficient but means the `window_depth.txt` files represent depth at specific intervals.
- **Validation via Unmapped Reads**: Check the `fastq/` directory (when using `-a`) for `unmapped` files. A large volume of unmapped reads often indicates contamination or a significantly incomplete assembly.
- **Summary Metrics**: The `overall_summary.txt` provides a weighted average of coverage. Pay close attention to the `covbases` vs `length` columns; if `covbases` is significantly lower than `length`, the assembly may have regions unsupported by the provided reads.
- **Environment Setup**: Ensure `minimap2` is in your system PATH, as the Python package depends on the binary for the alignment phase.

## Reference documentation
- [CirculoCov GitHub Repository](./references/github_com_erinyoung_CirculoCov.md)
- [CirculoCov Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_circulocov_overview.md)
---
name: read-it-and-keep
description: read-it-and-keep removes read contamination by keeping only the sequences that align to a specific target reference genome. Use when user asks to filter reads by positive selection, remove host contamination from clinical samples, or keep reads matching a reference.
homepage: https://github.com/GenomePathogenAnalysisService/read-it-and-keep
---


# read-it-and-keep

## Overview
This skill provides procedural knowledge for `read-it-and-keep`, a tool designed for "read contamination removal" by positive selection. Unlike tools that subtract known contaminants, this tool works by explicitly keeping only the reads that align to your target reference genome. It is highly efficient for clinical samples where the pathogen of interest represents a small fraction of the total genetic material.

## Core Usage Patterns

### Illumina Paired-End Filtering
For standard Illumina data, provide both mate files. The tool ensures that if one read in a pair matches the reference, the pair is preserved.
```bash
readItAndKeep \
  --ref_fasta reference.fasta \
  --reads1 sample_R1.fastq.gz \
  --reads2 sample_R2.fastq.gz \
  --outprefix filtered_output
```

### Nanopore (ONT) Filtering
When processing long reads, you must specify the technology flag to adjust alignment parameters.
```bash
readItAndKeep \
  --tech ont \
  --ref_fasta reference.fasta \
  --reads1 sample_ont.fastq.gz \
  -o filtered_ont
```

### SARS-CoV-2 Best Practices
When working with SARS-CoV-2 data, use the MN908947.3 reference but **remove the poly-A tail** to prevent false-positive matches from host mRNA containing long A-runs.
- **Recommended Reference**: `tests/MN908947.3.no_poly_A.fa` (found in the source repository).

## Advanced Configuration

### Tuning Stringency
You can control how strictly a read must match the reference to be "kept" using length or percentage thresholds:
- `--min_map_length`: Minimum match length in base pairs (default: 50).
- `--min_map_length_pc`: Minimum match length as a percentage of total read length (default: 50.0).

### Output Handling
- **Format Persistence**: If input is FASTA, output will be FASTA. If input is FASTQ, output will be FASTQ.
- **Read Renaming**: Use `--enumerate_names` to simplify read headers to integers (1, 2, 3...), which can reduce file size and anonymize headers.
- **Statistics**: The tool outputs a tab-delimited summary to `STDOUT` showing:
  - Input read counts
  - Kept read counts

## Troubleshooting and Logging
- **Logs**: All progress and error messages are sent to `STDERR`.
- **Debug Mode**: Use `--debug` to generate verbose logs and intermediate alignment files if results are unexpected.

## Reference documentation
- [GitHub Repository and Usage Guide](./references/github_com_GlobalPathogenAnalysisService_read-it-and-keep.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_read-it-and-keep_overview.md)
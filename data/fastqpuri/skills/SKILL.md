---
name: fastqpuri
description: FastqPuri is a lightweight suite of tools for FASTQ quality assessment and sequence filtering using Bloom filters. Use when user asks to generate quality reports, filter contaminants, trim reads, or create Bloom filters for sequence screening.
homepage: https://github.com/jengelmann/FastqPuri
---


# fastqpuri

## Overview

FastqPuri is a lightweight and efficient suite of tools designed for the quality management of FASTQ files. It provides a complete workflow to evaluate sequencing quality both before and after data processing. Its primary strengths lie in its ability to generate visual HTML reports and its specialized filtering mechanisms that use Bloom filters to identify and remove unwanted sequences (e.g., contamination) without the overhead of full alignment.

## Core Executables

- **Qreport**: Generates a detailed quality report in HTML format for an individual FASTQ file.
- **Sreport**: Creates a summary report across multiple samples to compare quality metrics or filtering results.
- **makeBloom**: Prepares a Bloom filter from a FASTA file (e.g., a contaminant genome) for use in filtering.
- **makeTree**: Creates a tree structure from a FASTA file for alternative sequence filtering.
- **trimFilter**: Filters and trims single-end FASTQ data.
- **trimFilterPE**: Filters and trims paired-end FASTQ data.

## Common Workflows and CLI Patterns

### 1. Initial Quality Assessment
Generate a report for a single sample to inspect quality scores and sequence composition.
```bash
Qreport -f sample_R1.fastq -o quality_report_dir
```

### 2. Preparing Contamination Filters
To filter out specific contaminants (like rRNA or adapter sequences), first generate a Bloom filter from the reference FASTA.
```bash
makeBloom -f contamination_refs.fasta -o contamination.bloom
```

### 3. Filtering and Trimming
Apply quality thresholds and remove sequences matching the Bloom filter.

**Single-End:**
```bash
trimFilter -f input.fastq -q 20 -b contamination.bloom -o filtered_output.fastq
```

**Paired-End:**
```bash
trimFilterPE -f1 input_R1.fastq -f2 input_R2.fastq -q 20 -b contamination.bloom -o1 filtered_R1.fastq -o2 filtered_R2.fastq
```

### 4. Comparative Summary
After processing multiple samples, use Sreport to aggregate the results into a single view.
```bash
Sreport -i directory_with_qreports -o study_summary.html
```

## Best Practices and Expert Tips

- **Validation Loop**: Always run `Qreport` and `Sreport` both before and after filtering. Comparing the "before" and "after" summary reports is the most effective way to verify that the filtering parameters (like `-q` for quality or `-n` for N-content) were appropriate.
- **Dependency Check**: HTML report generation requires `Rscript`, `pandoc`, and specific R packages (`pheatmap`, `knitr`, `rmarkdown`). If these are missing, the tools will still process data but will skip the visual report generation.
- **Memory Efficiency**: Bloom filters are highly memory-efficient for contamination screening. Use `makeBloom` on known contaminant databases (e.g., UniVec or specific rRNA sets) to clean your data without needing a high-memory aligner.
- **Read Length**: If working with non-standard Illumina lengths, ensure the `READ_MAXLEN` was set correctly during compilation (default is 400).

## Reference documentation
- [FastqPuri GitHub Repository](./references/github_com_jengelmann_FastqPuri.md)
- [FastqPuri Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastqpuri_overview.md)
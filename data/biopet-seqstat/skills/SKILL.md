---
name: biopet-seqstat
description: "Biopet-seqstat generates, merges, and validates quality metrics and nucleotide statistics from FASTQ sequencing data. Use when user asks to generate sequencing statistics, merge multiple stats files, or validate the integrity of stats JSON files."
homepage: https://github.com/biopet/seqstat
---


# biopet-seqstat

## Overview
SeqStat is a specialized tool within the Biopet suite designed for the quality assessment of sequencing data. It processes FASTQ files to extract critical metrics such as base quality distributions, nucleotide composition, and read length histograms. Beyond initial generation, the tool allows for the aggregation of statistics across multiple samples or libraries while maintaining metadata structures, and provides a validation mechanism to ensure the integrity of the resulting stats files.

## Common CLI Patterns

### Generating Statistics
The `Generate` mode is used to analyze a single FASTQ file. It automatically detects quality encoding (e.g., Sanger, Solexa).

```bash
biopet-seqstat Generate -i input.fastq.gz -o output_stats.json
```

**Outputted Metrics:**
*   **Bases:** Total count, base quality distribution, and individual nucleotide counts (A, C, G, T, N).
*   **Reads:** Total count, minimum/maximum lengths, average quality histograms, and quality encoding detection.

### Merging Statistics
The `Merge` mode aggregates multiple SeqStat JSON files. This is useful for combining data from different lanes, libraries, or samples.

```bash
# Merge multiple files while keeping sample/library/readgroup structure
biopet-seqstat Merge -i sample1.json -i sample2.json -o merged_stats.json

# Collapse the structure into a single aggregate
biopet-seqstat Merge --collapse -i sample1.json -i sample2.json -o collapsed_stats.json
```

### Validating Stats Files
Use the `Validate` mode if a stats file has been manually edited or if corruption is suspected. It attempts to regenerate aggregation values to ensure consistency.

```bash
biopet-seqstat Validate -i stats_file.json
```

## Expert Tips and Best Practices

*   **Input Formats:** SeqStat typically handles compressed FASTQ files (.gz) natively, which is recommended to save disk I/O.
*   **Metadata Preservation:** When merging, the tool preserves the hierarchical structure (Sample -> Library -> Readgroup). If your downstream reporting tools require a flat file, use the `--collapse` flag.
*   **Quality Encoding:** If you are working with older datasets, use the `Generate` mode to verify the quality encoding (e.g., Illumina 1.3+ vs 1.8+) before proceeding with alignment or trimming.
*   **Integration:** SeqStat is often used as a lightweight alternative to FastQC when only numerical summaries are required for automated pipelines or custom dashboards.



## Subcommands

| Command | Description |
|---------|-------------|
| generate | Generate stats from FastQ files |
| merge | Merge seqstat files into a single file |
| validate | Validate a seqstat schema file |

## Reference documentation
- [SeqStat GitHub README](./references/github_com_biopet_seqstat_blob_develop_README.md)
- [SeqStat Build Configuration](./references/github_com_biopet_seqstat_blob_develop_build.sbt.md)
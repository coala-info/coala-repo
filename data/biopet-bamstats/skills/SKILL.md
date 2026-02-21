---
name: biopet-bamstats
description: biopet-bamstats is a utility within the BIOPET tool suite used to profile alignment data.
homepage: https://github.com/biopet/bamstats
---

# biopet-bamstats

## Overview
biopet-bamstats is a utility within the BIOPET tool suite used to profile alignment data. It extracts detailed metrics such as clipping statistics, mapping quality, and insert sizes from BAM files. The tool's primary strength is its hierarchical output structure, which preserves the relationship between samples, libraries, and readgroups. This makes it a powerful tool for aggregating QC data across large cohorts while maintaining the ability to drill down into specific sequencing runs.

## Command Line Usage

### Generate Statistics
The `generate` mode creates a report from a single BAM file.

```bash
# Basic generation (outputs JSON by default)
bamstats generate -b input.bam -o output.json

# Generate both JSON and TSV formats
bamstats generate -b input.bam -o output.json --tsv
```

### Merge Statistics
The `merge` mode combines multiple bamstats JSON files into a single aggregate file.

```bash
# Merge multiple files
bamstats merge -i sample1.json -i sample2.json -o cohort_stats.json
```

### Validate Statistics
The `validate` mode ensures the integrity of a bamstats file, checking if the aggregated values match the underlying data.

```bash
bamstats validate -i stats.json
```

## Best Practices and Expert Tips

### 1. Mandatory Readgroup Tags
biopet-bamstats requires every readgroup in the BAM file to have both Sample (`SM`) and Library (`LB`) tags. If these are missing, the tool will throw an error.
*   **Fixing missing tags:** Use `samtools addreplacerg` or Picard's `AddOrReplaceReadGroups` to annotate your BAM files before running bamstats.

### 2. Output Formats
*   **JSON (Default):** Best for automated pipelines and programmatic analysis. It maintains the full hierarchical tree structure.
*   **TSV:** Use the `--tsv` flag when you need to perform quick manual inspections or import data into spreadsheet software.

### 3. Data Integrity
Always run the `validate` mode if a JSON file has been manually edited or transferred across systems where corruption is suspected. The tool considers a file corrupt if the internal aggregation values cannot be recalculated from the raw counts.

### 4. Merging Logic
When merging, values for identical readgroups across different files are added together. Ensure that readgroup IDs are unique across different libraries unless they truly represent the same sequencing event.

## Reference documentation
- [biopet-bamstats - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_biopet-bamstats_overview.md)
- [GitHub - biopet/bamstats](./references/github_com_biopet_bamstats.md)
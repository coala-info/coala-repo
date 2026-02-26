---
name: biopet-seqstat
description: Biopet-seqstat extracts and manages descriptive quality statistics from FASTQ files, including read lengths and base quality metrics. Use when user asks to generate sequencing statistics, merge multiple stats files into a single report, or validate the integrity of stats files.
homepage: https://github.com/biopet/seqstat
---


# biopet-seqstat

## Overview
biopet-seqstat is a bioinformatics utility designed to extract and manage descriptive statistics from FASTQ files. It is used to assess the quality of sequencing runs by providing detailed metrics on read lengths and base qualities. The tool is particularly effective in multi-sample workflows because it can merge individual statistics while preserving the hierarchical metadata structure (Sample/Library/Readgroup), or collapse them into a single summary. It also includes a validation component to ensure that generated statistics files remain uncorrupted and consistent.

## Installation
Install the tool via bioconda:
```bash
conda install bioconda::biopet-seqstat
```

## Core Command Modes

### 1. Generate Mode
Use this mode to process a FASTQ file and produce a JSON-formatted statistics file.
*   **Primary Output**: Total base count, nucleotide distribution (A, C, G, T, N), total read count, and quality encoding (e.g., Sanger).
*   **Histograms**: Generates distributions for average base qualities and read lengths (minimum and maximum).
*   **Usage Tip**: Run this on individual FASTQ files immediately after sequencing or adapter trimming to establish a quality baseline.

### 2. Merge Mode
Use this mode to aggregate multiple seqstat output files into a single report.
*   **Metadata Preservation**: By default, the tool maintains the Sample, Library, and Readgroup structure defined in the input files.
*   **Collapsing**: Use the collapse option if you require a single global summary without hierarchical breakdown.
*   **Expert Tip**: Avoid manual editing of the intermediate seqstat files before merging, as this can lead to "corrupt" status if aggregation values cannot be recalculated.

### 3. Validate Mode
Use this mode to check the integrity of a generated seqstat file.
*   **Function**: It attempts to regenerate aggregation values from the raw data within the file.
*   **When to use**: Run validation if a file has been transferred across systems or if manual modification is suspected.

## Common CLI Patterns
While specific flags may vary by version, the general invocation follows the sub-command structure:

```bash
# Generate stats for a single FASTQ
biopet-seqstat generate -i input.fastq.gz -o output.json

# Merge multiple stats files
biopet-seqstat merge -i sample1.json -i sample2.json -o merged_stats.json

# Validate a stats file
biopet-seqstat validate -i stats.json
```

## Best Practices
*   **Quality Encoding**: Always verify the detected quality encoding (Sanger vs. Solexa) in the "Generate" output to ensure downstream tools interpret Phred scores correctly.
*   **Read Length Analysis**: Use the read length histograms to identify unexpected trimming artifacts or library preparation issues (e.g., excessive adapter dimmers appearing as a peak at very short lengths).
*   **Pipeline Integration**: In large-scale projects, generate stats for every FASTQ and use the "Merge" mode at the end of the pipeline to create a comprehensive QC report for the entire cohort.

## Reference documentation
- [biopet-seqstat - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_biopet-seqstat_overview.md)
- [GitHub - biopet/seqstat](./references/github_com_biopet_seqstat.md)
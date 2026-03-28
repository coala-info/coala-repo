---
name: clinvar-tsv
description: The clinvar-tsv tool transforms ClinVar XML data into standardized TSV formats for high-throughput genomic analysis. Use when user asks to convert ClinVar XML to TSV, summarize clinical significance assertions, or normalize variant coordinates across genome builds.
homepage: https://github.com/bihealth/clinvar-tsv
---

# clinvar-tsv

## Overview

The `clinvar-tsv` tool automates the complex process of transforming ClinVar's XML data into a format suitable for high-throughput genomic analysis. It manages a multi-stage Snakemake-based workflow that handles data retrieval via `wget`, XML parsing into raw TSV records, coordinate-based sorting, and final record merging. The tool is particularly valuable for researchers who need to reconcile multiple assertions for the same Variation Control Value (VCV) into a single clinical significance summary using either standard ClinVar logic or a more conservative "paranoid" approach.

## Command Line Usage

### The Main Workflow
The primary way to use the tool is through the `main` command, which executes the full download-to-summary pipeline.

```bash
clinvar_tsv main \
    --cores 4 \
    --b37-path /path/to/human_g1k_v37.fasta \
    --b38-path /path/to/GRCh38.fasta
```

**Key Arguments:**
- `--cores`: Specifies the number of CPU cores for Snakemake to use during parallel processing.
- `--b37-path`: Path to the GRCh37/hg19 reference FASTA file.
- `--b38-path`: Path to the GRCh38/hg38 reference FASTA file.
- `--clinvar-version`: (Optional) Allows you to specify a specific ClinVar release version (e.g., `2023-06-01`).

### Granular Commands
If you need to run specific parts of the pipeline manually:
- `clinvar_tsv parse_xml`: Converts a local ClinVar XML file into a "raw" TSV.
- `clinvar_tsv normalize`: Used internally to standardize variant representations.

## Output Summaries

The tool produces two distinct types of summary files for each genome build. Choosing the right one depends on your clinical interpretation philosophy:

1.  **`summary_clinvar_*`**: Follows the official NCBI ClinVar review status logic. It prioritizes assertions from providers that provide practice guidelines or have higher star ratings.
2.  **`summary_paranoid_*`**: Treats all assessments as equally important. If any reporter provides a conflicting assessment, it is reflected in the summary regardless of the reporter's criteria or star rating.

## Expert Tips and Best Practices

- **Reference Genomes**: Ensure your reference FASTA files are indexed (using `samtools faidx`). The tool requires these to validate and normalize variant coordinates.
- **Disk Space**: ClinVar XML files are large and expand significantly during parsing. Ensure the `downloads/` and `parsed/` directories have at least 50GB of available space for a full run.
- **Structural Variants**: As of version 0.5.0, the tool supports the extraction of structural variants. If your analysis involves CNVs or large rearrangements, ensure you are using the latest version.
- **Memory Management**: For very large XML files, if you encounter memory issues during the `normalize` step, reduce the number of `--cores` to lower the concurrent memory overhead.
- **Interpreting "Low Penetrance"**: The tool maps "low penetrance" assertions to "uncertain significance" to maintain compatibility with standard filtering tiers in tools like VarFish.



## Subcommands

| Command | Description |
|---------|-------------|
| clinvar-tsv | A tool for processing ClinVar data. |
| clinvar-tsv main | Main command for clinvar-tsv |
| clinvar-tsv parse_xml | Parse ClinVar XML file into TSV format. |

## Reference documentation
- [Clinvar-TSV README](./references/github_com_bihealth_clinvar-tsv_blob_main_README.md)
- [Clinvar-TSV Changelog](./references/github_com_bihealth_clinvar-tsv_blob_main_CHANGELOG.md)
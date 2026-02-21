---
name: esviritu
description: EsViritu is a specialized bioinformatics pipeline designed for the sensitive detection of viral sequences within complex metagenomic datasets.
homepage: https://github.com/cmmr/EsViritu
---

# esviritu

## Overview

EsViritu is a specialized bioinformatics pipeline designed for the sensitive detection of viral sequences within complex metagenomic datasets. It maps short reads against a curated database of nearly 20,000 high-quality viral genomes, providing both presence/absence data and detailed assembly-aware reconstructions. It is particularly effective for identifying viruses with at least 80% Average Nucleotide Identity (ANI) to reference sequences and produces interactive HTML reports for visualizing genome coverage.

## Installation and Setup

EsViritu is primarily distributed via Bioconda.

```bash
# Create and activate environment
mamba create -n EsViritu bioconda::esviritu
conda activate EsViritu
```

### Database Management
The tool requires a specific curated database. As of version 1.1.6, database v3.2.4 is recommended.

1. **Download**: Obtain the database tarball from Zenodo.
2. **Configuration**: Set the `ESVIRITU_DB` environment variable to avoid specifying the path in every command.

```bash
conda env config vars set ESVIRITU_DB=/path/to/esviritu_DB/v3.2.4
# Re-activate environment to apply changes
conda activate EsViritu
```

## Command Line Usage

### Basic Execution
The primary command is `EsViritu`. You must specify the read type (paired or unpaired).

**Unpaired Reads:**
```bash
EsViritu -r sample.fastq -s SampleID -o output_dir -p unpaired
```

**Paired-End Reads:**
```bash
EsViritu -r R1.fastq R2.fastq -s SampleID -o output_dir -p paired
```

### Advanced Filtering Options
For clinical or environmental samples with high host contamination or low-quality reads, use the pre-filtering flags:

*   `-q True`: Enables quality trimming/filtering.
*   `-f True`: Enables host read filtering (requires host reference).
*   `--dedup`: (v1.1.4+) Optional flag for PCR duplicate removal.

```bash
EsViritu -r sample.fastq -s SampleID -o output_dir -p unpaired -q True -f True
```

### Batch Summarization
After running multiple samples into the same output directory, use the collation script to generate a project-wide summary.

```bash
summarize_esv_runs output_dir
```
This generates:
*   `batch_detected_viruses.html`: A searchable, interactive table of all findings.
*   `tax_profile.tsv`: Taxonomic distribution across the batch.
*   `detected_virus.info.tsv`: Detailed metrics for each detection.

## Expert Tips and Best Practices

*   **Read Length**: Ensure input reads are at least 100 nt for optimal sensitivity.
*   **Memory Management**: When running large custom reference databases, monitor RAM usage as the mapping step can be resource-intensive.
*   **Visualization**: To see genome coverage sparklines in the HTML reports, ensure the R package `dataui` is installed in your environment.
*   **Sensitivity**: EsViritu is sensitive enough to detect a virus from a single read, but always verify "low-hit" detections using the breadth of coverage metrics in the HTML report.

## Reference documentation
- [EsViritu Overview](./references/anaconda_org_channels_bioconda_packages_esviritu_overview.md)
- [EsViritu GitHub Repository](./references/github_com_cmmr_EsViritu.md)
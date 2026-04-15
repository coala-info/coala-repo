---
name: checkv
description: CheckV assesses the quality of single-nucleus viral genomes by estimating completeness, identifying closed circular genomes, and detecting integrated prophages. Use when user asks to estimate viral genome completeness, identify host contamination in proviruses, or run the end-to-end viral quality assessment pipeline.
homepage: https://bitbucket.org/berkeleylab/checkv
metadata:
  docker_image: "quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0"
---

# checkv

## Overview
CheckV is a specialized command-line tool designed to assess the quality of single-nucleus viral genomes (UViGs). It provides essential metrics for viral ecology, including the estimation of genome completeness, the identification of closed circular genomes, and the detection of integrated prophages within host scaffolds. This skill assists in executing the CheckV pipeline and interpreting its multi-stage output.

## Core Workflow
The standard CheckV pipeline is executed through the `end_to_end` command, which automates the identification of viral genes, estimation of completeness, and removal of host contamination.

### Basic Execution
```bash
# Run the full pipeline
checkv end_to_end input_sequences.fasta output_directory -t 16
```

### Key Sub-commands
- `contamination`: Identifies and removes host sequences from integrated proviruses.
- `completeness`: Estimates the percentage of the viral genome present based on a database of complete viral genomes.
- `quality_summary`: Generates the primary summary file (`quality_summary.tsv`) containing the final quality tier (Complete, High-quality, Medium-quality, Low-quality, or Not-determined).

## Expert Tips and Best Practices
- **Database Setup**: Ensure the `CHECKVDB` environment variable is set to the location of the CheckV reference database before running commands.
- **Prophage Detection**: When working with integrated viruses, CheckV uses a combination of gene-based (HMM) and k-mer based approaches to find the virus-host boundary. Review the `contamination.tsv` file to see specific coordinates.
- **Circular Contigs**: CheckV identifies circularity via terminal repeats. Contigs flagged as circular are automatically assigned 100% completeness.
- **Resource Allocation**: Use the `-t` flag to specify CPU threads. The HMM search stage (prodigal and diamond) is the most computationally intensive part of the workflow.
- **Interpreting Results**: 
    - Focus on "High-quality" (>90% completeness) and "Complete" genomes for robust comparative genomics.
    - "Not-determined" status often occurs for short contigs (<2kb) or those with no viral gene hits.



## Subcommands

| Command | Description |
|---------|-------------|
| checkv contamination | Estimate host contamination for integrated proviruses |
| checkv end_to_end | Run full pipeline to estimate completeness, contamination, and identify closed genomes |
| checkv update_database | Update CheckV's database with your own complete genomes |
| checkv_complete_genomes | Identify complete genomes based on terminal repeats and flanking host regions |
| checkv_completeness | Estimate completeness for genome fragments |
| checkv_download_database | Download the latest version of CheckV's database |
| checkv_quality_summary | Summarize results across modules |

## Reference documentation
- [CheckV Bitbucket Repository](./references/bitbucket_org_berkeleylab_checkv.md)
- [Bioconda CheckV Overview](./references/anaconda_org_channels_bioconda_packages_checkv_overview.md)
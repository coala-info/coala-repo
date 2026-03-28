---
name: snakesv
description: snakeSV is a Snakemake-based framework for comprehensive structural variant discovery, genotyping, and annotation. Use when user asks to run structural variant analysis pipelines, integrate multiple SV callers, or annotate variants with custom genomic features.
homepage: https://github.com/RajLabMSSM/snakeSV/
---

# snakesv

## Overview
snakeSV is a flexible Snakemake-based framework designed for comprehensive Structural Variant (SV) analysis. It streamlines the process of SV discovery by integrating multiple callers and providing automated pre- and post-processing steps. It is particularly effective for large-scale studies where consistency across samples and integration of diverse annotation sources—such as cell-type-specific enhancers or long-read discovery panels—are required.

## Installation and Setup
The preferred method for installation is via Bioconda to ensure all dependencies and sub-tools are correctly versioned and managed within an isolated environment.

- **Environment Creation**: Use `conda create -n snakesv_env -c bioconda snakesv` to set up the environment.
- **Activation**: Run `conda activate snakesv_env` before executing any pipeline commands.
- **Validation**: Execute `snakeSV --test_run` in a new directory to verify the installation using the built-in example dataset.

## Core CLI Usage
The primary interface is the `snakeSV` command, which acts as a wrapper for the underlying Snakemake workflow.

- **Standard Execution**: `snakeSV --configfile [PATH_TO_CONFIG] [SNAKEMAKE_FLAGS]`
- **HPC Execution**: For LSF-based clusters, use the `snakejob` wrapper script. This requires a cluster configuration file (typically `cluster.yaml`) to define threads, memory, and partitions for individual rules.
- **Common Snakemake Flags**: Always include `--cores [N]` and `--use-conda`. Use `--dry-run` (or `-n`) to verify the execution plan before processing large datasets.

## Workflow Configuration Requirements
To run the pipeline, you must prepare a configuration file. The following parameters are required for a successful run:

- **SAMPLE_KEY**: A tab-separated file with columns `participant_id` and `bam`. It maps sample identifiers to their full BAM file paths.
- **TOOLS**: A list of specific SV discovery tools to be utilized (e.g., manta, smoove, delly).
- **REFERENCE_FASTA**: The path to the reference genome FASTA file.
- **REF_BUILD**: The assembly version (e.g., "37" or "38").
- **GTF (Optional)**: A Gencode GTF file used to annotate SV consequences like Loss of Function (LOF) or Copy Gain.
- **SV_PANEL (Optional)**: A VCF file containing structural variants (often from long-read data) to be genotyped alongside the discovery set.
- **ANNOTATION_BED (Optional)**: A list of BED files (formatted as chr, start, end, element_name) for custom functional annotations.

## Expert Tips and Best Practices
- **Leveraging Long-Read Data**: To improve the sensitivity of short-read SV detection, use a VCF generated from long-read assemblies (e.g., via svim-asm) as an `SV_PANEL`. This allows snakeSV to genotype high-confidence variants in your short-read samples.
- **Tissue-Specific Interpretation**: When analyzing disease-related variants, provide cell-type-specific enhancer data (like H3K27ac peaks) via the `ANNOTATION_BED` parameter. This automatically labels SVs overlapping these regions in the final VCF INFO field.
- **Resource Management**: SV discovery is resource-intensive. If running on a local machine, ensure `TMP_DIR` is set to a location with sufficient space, as tools like Manta and Smoove generate large intermediate files.
- **Manual Git Installation**: If you clone the repository directly instead of using Bioconda, you must manually install Snakemake and ensure the `workdir` and `OUT_FOLDER` are explicitly defined in the command line configuration.



## Subcommands

| Command | Description |
|---------|-------------|
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |

## Reference documentation
- [snakeSV Main Repository](./references/github_com_RajLabMSSM_snakeSV.md)
- [snakeSV Wiki Home](./references/github_com_RajLabMSSM_snakeSV_wiki.md)
- [Usage Examples and Case Studies](./references/github_com_RajLabMSSM_snakeSV_wiki_Usage-examples.md)
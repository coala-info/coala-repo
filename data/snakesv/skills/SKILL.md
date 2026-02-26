---
name: snakesv
description: snakeSV is a Snakemake workflow that automates the identification and interpretation of structural variants across large genomic datasets. Use when user asks to identify structural variants, run SV discovery tools like Manta or Delly, annotate VCF files, or submit genomic pipelines to HPC clusters.
homepage: https://github.com/RajLabMSSM/snakeSV/
---


# snakesv

## Overview

snakeSV is a specialized framework designed to streamline the identification and interpretation of structural variants across large genomic datasets. By wrapping multiple discovery tools—such as Manta, Delly, and Smoove—into a unified Snakemake workflow, it automates the complex transition from raw BAM files to annotated VCFs. It is particularly useful for researchers needing a reproducible, scalable pipeline that handles pre-processing, multi-tool discovery, genotyping, and functional annotation in a single execution path.

## Installation and Environment Setup

The most reliable way to deploy snakeSV is through Bioconda to ensure all dependencies (Python, Snakemake, and bioinformatics tools) are correctly versioned.

- **Environment Creation**: Always install snakeSV in a dedicated conda environment to avoid dependency conflicts with other genomic tools.
- **Channel Configuration**: Ensure `conda-forge` and `bioconda` are added to your conda channels before installation.
- **Verification**: After installation, use the built-in test command to verify the environment and tool paths:
  `snakeSV --test_run`

## Core Execution Patterns

### Native CLI Usage
The `snakeSV` executable acts as the primary entry point. While it relies on a configuration file, the execution logic follows standard Snakemake behavior.

- **Test Run**: Validates the installation using a small internal dataset.
- **Direct Snakemake Execution**: For users who have cloned the repository, the pipeline can be triggered directly via Snakemake:
  `snakemake -s workflow/Snakefile --configfile <path_to_config> --cores <N> --use-conda`

### HPC Job Submission
For large-scale studies, snakeSV provides a wrapper script called `snakejob` specifically designed for cluster environments (e.g., LSF).

- **Wrapper Execution**: Use `snakejob` to handle the submission of the Snakemake master process and its sub-jobs to the cluster scheduler.
- **Cluster Configuration**: The wrapper requires a cluster-specific configuration file (typically a YAML-formatted file, though the CLI interaction focuses on the `-u` and `-c` flags).
- **Command Pattern**:
  `./snakejob -u <cluster_config> -c <pipeline_config>`

## Data Preparation Best Practices

- **Sample Key Mapping**: Prepare a tab-separated "sample key" file. This file must contain a header with `participant_id` and `bam` columns. Ensure the paths to the BAM files are absolute or correctly relative to the working directory.
- **Reference Genome**: The reference FASTA must be indexed. If using optional annotation features, ensure the reference build (e.g., 37 or 38) matches your input data and GTF files.
- **Custom Annotations**: To enhance SV interpretation, provide BED files containing genomic elements. The pipeline will append the element names from the fourth column of the BED file to the SV INFO field.

## Expert Tips for Large-Scale Studies

- **Temporary Directories**: SV discovery tools generate massive amounts of intermediate data. Use the `TMP_DIR` parameter to point to high-speed local scratch space rather than network-attached storage to prevent I/O bottlenecks.
- **Tool Selection**: You can customize the discovery suite by modifying the `TOOLS` list in your configuration. Running Manta, Smoove, and Delly in parallel is the standard approach for maximizing sensitivity.
- **Genotyping Panels**: If you have a specific set of SVs (e.g., from long-read sequencing), use the `SV_PANEL` option to force-genotype those specific variants across your entire cohort.

## Reference documentation
- [snakeSV Wiki](./references/github_com_RajLabMSSM_snakeSV_wiki.md)
- [snakeSV Main Repository](./references/github_com_RajLabMSSM_snakeSV.md)
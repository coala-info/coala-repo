---
name: metapi
description: metapi is a Snakemake-based pipeline designed to streamline metagenomics data mining and bioinformatics workflows. Use when user asks to initialize a metagenomics project, configure sample metadata, or execute workflows for genome assembly, binning, and gene-centric analysis.
homepage: https://github.com/ohmeta/metapi
---

# metapi

## Overview

metapi is a specialized metagenomics data mining system designed for robust microbiome research. It streamlines complex bioinformatics workflows by wrapping various tools into a cohesive Snakemake-based pipeline. You should use this skill to manage the lifecycle of a metagenomics project, from initial project setup and sample metadata configuration to the execution of Metagenome-Assembled Genome (MAG) or gene-centric workflows. It is particularly useful for researchers needing to run standardized, reproducible analyses across multiple samples using different assemblers (e.g., MetaSPAdes, MegaHit) and binners (e.g., MetaBAT2, CONCOCT).

## Project Initialization

The first step in any metapi workflow is creating the project structure.

- **Basic Initialization**: Run `metapi init -s samples.tsv -d <workdir>` to generate the necessary directory structure (`envs/`, `logs/`, `results/`, `profiles/`) and the core configuration file.
- **Defining the Entry Point**: Use the `-b` or `--begin` flag to specify where the pipeline should start based on your data's current state:
  - `simulate`: Start by generating synthetic reads.
  - `trimming`: Start with raw fastq files (default).
  - `rmhost`: Start with quality-controlled reads that need host sequence removal.
  - `assembly`: Start with clean, non-host reads.
  - `binning`: Start with existing assemblies and reads for binning.
- **Tool Selection**: You can pre-configure preferred tools during init:
  - `--trimmer {fastp,sickle,trimmomatic}`
  - `--rmhoster {bowtie2,bwa,minimap2,kraken2,kneaddata}`
  - `--assembler {metaspades,megahit,idba-ud,opera-ms}`

## Sample Sheet Configuration

The `samples.tsv` file is the most critical input. It must be a tab-separated file with specific headers depending on the starting point.

- **Standard Fastq Input**:
  Header: `sample_id`, `assembly_group`, `binning_group`, `fq1`, `fq2`
- **SRA Input**:
  Header: `sample_id`, `assembly_group`, `binning_group`, `sra`
- **Simulation Input**:
  Header: `id`, `genome`, `abundance`, `reads_num`, `model`

*Note: `assembly_group` and `binning_group` allow you to control which samples are co-assembled or co-binned.*

## Executing Workflows

Once initialized, use the workflow subcommands to run the analysis.

- **MAG Workflow**: `metapi mag_wf`
- **Gene Workflow**: `metapi gene_wf`
- **Simulation Workflow**: `metapi simulate_wf`

### Common Execution Flags
- `--use-conda`: Essential for allowing metapi to manage tool dependencies automatically.
- `--cluster-engine`: Specify a scheduler (`slurm`, `sge`, `lsf`, `pbs-torque`) for high-performance computing environments.
- `--check-samples`: Validates the sample sheet before starting the run.

### Targeted Task Execution
Instead of running the entire pipeline (`all`), you can target specific endpoints to save time or troubleshoot:
- `trimming_all`: Run only quality control.
- `assembly_all`: Run only the assembly stage.
- `binning_all`: Run only the binning and refinement stage.
- `taxonomic_all`: Run GTDB-Tk for taxonomic assignment.
- `checkm_all`: Run quality assessment of bins.

## Expert Tips

- **Environment Management**: If you need to update a specific tool version, modify the environment files located in the `envs/` directory created during `metapi init`.
- **Resuming Projects**: Use `metapi sync` to synchronize project states if files have been moved or if you are updating the sample list.
- **Resource Allocation**: For cluster users, edit the `cluster.yaml` file within the generated `profiles/` directory to fine-tune CPU and memory requests for specific rules.
- **Co-assembly Logic**: To perform co-assembly, assign the same `assembly_group` name to multiple samples in your `samples.tsv`.



## Subcommands

| Command | Description |
|---------|-------------|
| metapi init | Initialize a metapi project. |
| metapi mag_wf | Metagenomic MAG workflow |
| metapi simulate | Pipeline end point. Allowed values are simulate_all, all (default: all) |
| metapi sync | Sync project to a directory |
| metapi_gene_wf | Pipeline end point. Allowed values are prepare_reads_all, raw_fastqc_all, raw_report_all, raw_all, trimming_sickle_all, trimming_fastp_all, trimming_trimmomatic_all, trimming_report_all, trimming_all, rmhost_bwa_all, rmhost_bowtie2_all, rmhost_minimap2_all, rmhost_report_all, rmhost_all, qcreport_all, assebmly_megahit_all, assembly_idba_ud_all, assembly_metaspades_all, assembly_spades_all, assembly_plass_all, assembly_metaquast_all, assembly_report_all, predict_scaftigs_gene_prodigal_all, predict_scaftigs_gene_prokka_all, predict_scafitgs_gene_all, predict_all, dereplicate_gene_cdhit_all, dereplicate_gene_all, upload_sequencing_all, upload_assembly_all, upload_all, all (default: all) |

## Reference documentation
- [metapi Main Documentation](./references/github_com_ohmeta_metapi.md)
- [metapi Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_metapi_overview.md)
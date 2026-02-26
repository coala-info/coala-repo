---
name: mmlong2-lite
description: mmlong2-lite is a Snakemake-based pipeline that automates the recovery of microbial genomes from long-read metagenomic data through assembly, binning, and curation. Use when user asks to recover microbial genomes from Nanopore or PacBio reads, perform differential coverage binning, or identify circular genomes in metagenomic samples.
homepage: https://github.com/Serka-M/mmlong2-lite
---


# mmlong2-lite

## Overview

`mmlong2-lite` is a streamlined Snakemake-based bioinformatics pipeline designed to recover microbial genomes from complex metagenomic samples. It automates the transition from raw long reads to curated, binned genomes by integrating assembly, misassembly detection, and iterative ensemble binning. The tool is particularly effective for identifying circular microbial genomes and filtering out eukaryotic contigs using Tiara or Whokaryote.

## Installation and Setup

The most reliable way to install `mmlong2-lite` is via Bioconda:

```bash
conda create -n mmlong2 -c conda-forge -c bioconda mmlong2-lite
conda activate mmlong2
```

By default, the workflow uses Singularity containers for dependencies. If your environment does not support Singularity, use the `--conda_envs_only` (or `-env`) flag to use Conda environments instead.

## Common CLI Patterns

### Basic Execution
For standard microbial genome recovery using Nanopore or PacBio HiFi reads:

```bash
# Nanopore reads
mmlong2-lite -np reads.fastq.gz -o output_dir -p 16

# PacBio HiFi reads
mmlong2-lite -pb reads.fastq.gz -o output_dir -p 16
```

### Differential Coverage Binning
To improve genome recovery using additional read sets, provide a two-column CSV (datatype,path):

```bash
# Example coverage.csv content:
# PB,/path/to/pacbio.fastq
# IL,/path/to/illumina.fastq.gz

mmlong2-lite -np reads.fastq.gz -cov coverage.csv -o output_dir
```

### Advanced Assembly and Polishing
You can swap the default assembler or enable Medaka polishing for Nanopore data:

```bash
# Use metaMDBG instead of default metaFlye
mmlong2-lite -np reads.fastq.gz -dbg -o output_dir

# Enable Medaka polishing with a specific model
mmlong2-lite -np reads.fastq.gz -med -mm r1041_e82_400bps_sup_v5.0.0 -o output_dir
```

## Expert Tips and Best Practices

- **Binning Modes**: Use `-bin extended` for high-complexity samples where standard binning might miss low-abundance organisms. Use `fast` for quick preliminary assessments.
- **Stage Control**: Use the `-run` flag to stop the pipeline at specific checkpoints (e.g., `assembly`, `curation`, `filtering`) to inspect intermediate results before committing to the full binning process.
- **Contig Filtering**: The default minimum contig length is 3000bp (`-mlc 3000`). For highly fragmented assemblies, you may need to lower this, though it may reduce binning quality.
- **Eukaryotic Removal**: By default, the tool uses Tiara. If you prefer Whokaryote, use the `-who` flag.
- **Resource Management**: Always specify the number of threads with `-p` to match your HPC or workstation environment, as assembly and binning are computationally intensive.
- **Dry Runs**: Before starting a long-running job, use `-n` (dry run) to verify the Snakemake execution plan.

## Main Outputs

- `<output_name>_assembly.fasta`: The final metagenome assembly.
- `<output_name>_bins.tsv`: Mapping of contigs to recovered genome bins.
- `bins/`: Directory containing individual FASTA files for each recovered MAG.
- `dependencies.csv`: A record of tool versions used, essential for publication reproducibility.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mmlong2-lite_overview.md)
- [GitHub Repository and Usage Guide](./references/github_com_Serka-M_mmlong2-lite.md)
---
name: purge_dups
description: purge_dups is a bioinformatics pipeline that removes redundant haplotypic sequences from de novo genome assemblies using read depth and sequence alignment. Use when user asks to refine a genome assembly, remove haplotigs, identify redundant sequences, or purge duplications from diploid or polyploid assemblies.
homepage: https://github.com/dfguan/purge_dups
---


# purge_dups

## Overview

`purge_dups` is a bioinformatics pipeline designed to refine de novo genome assemblies by removing redundant sequences. In diploid or polyploid organisms, assemblers often fail to merge allelic variants into a single representative sequence, resulting in "haplotigs" that inflate the assembly size and interfere with downstream analysis. This tool uses read depth distribution and sequence alignment to distinguish between true genomic repeats and haplotypic duplications, producing a "purged" primary assembly and a separate set of haplotypic sequences.

## Core Workflow

The standard pipeline consists of three main steps: configuration generation, manual refinement (optional), and execution.

### 1. Configuration Generation
Use `pd_config.py` to create a JSON configuration file that defines the input files and resource allocation.

```bash
# Basic usage
python3 scripts/pd_config.py -l <output_dir> -n config.json <reference.fa> <pb.fofn>

# Including short reads for k-mer comparison
python3 scripts/pd_config.py -s short_reads.fofn -n config.json <reference.fa> <pb.fofn>
```
*   **reference.fa**: The assembly to be purged.
*   **pb.fofn**: A "File Of File Names" containing absolute paths to PacBio/long-read files (one per line).

### 2. Pipeline Execution
Run the automated wrapper `run_purge_dups.py`.

```bash
python3 scripts/run_purge_dups.py config.json <bin_dir> <species_id>
```
*   **bin_dir**: Path to the `purge_dups` executables (usually the `src` or `bin` directory).
*   **species_id**: A prefix for output files.
*   **-p bash**: Use this flag to run locally if not using a workload manager like LSF or SLURM.

## Manual Pipeline & Binary Usage

For finer control or troubleshooting, you can run the individual components:

### Read Depth Calculation
*   **pbcstat**: Processes PacBio alignments (PAF format) to create a read depth histogram and base-level depth files.
*   **ngstat**: Similar to `pbcstat` but for Illumina/NGS data.
*   **calcuts**: Calculates coverage cutoffs from the histogram produced by `pbcstat`/`ngstat`.

### Purging and Sequence Extraction
*   **purge_dups**: The core engine that identifies haplotigs and overlaps based on the calculated cutoffs and self-alignment of the assembly.
*   **get_seqs**: Extracts the final sequences. It generates:
    *   `*.purged.fa`: The cleaned primary assembly.
    *   `*.red.fa`: The removed redundant sequences (haplotigs).

## Expert Tips & Best Practices

*   **Cutoff Validation**: Always inspect the `coverage.hist` plot. If the automatically calculated cutoffs in `calcuts` look incorrect (e.g., the transition between the haploid and diploid peaks is missed), manually adjust the cutoffs in the configuration file.
*   **Over-purging**: If BUSCO scores show a significant increase in "Missing" genes after purging, the cutoffs may be too aggressive, causing the tool to remove unique genomic regions.
*   **Large Genomes**: For assemblies with scaffolds larger than 2GB, ensure you are using the latest version, as older versions of `split_fa` had coordinate overflow issues.
*   **Input Quality**: Ensure the `pb.fofn` contains absolute paths. Relative paths often cause failures during the alignment stages of the automated pipeline.
*   **Repeat Masking**: While not strictly required, running `purge_dups` on an assembly where repeats have been handled or understood can help distinguish between segmental duplications and haplotypic ones.

## Reference documentation
- [purge_dups GitHub Repository](./references/github_com_dfguan_purge_dups.md)
- [Bioconda purge_dups Overview](./references/anaconda_org_channels_bioconda_packages_purge_dups_overview.md)
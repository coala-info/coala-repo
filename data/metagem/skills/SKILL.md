---
name: metagem
description: metaGEM is a Snakemake-based pipeline that automates the workflow from raw metagenomic sequencing data to functional metabolic simulations and interaction modeling. Use when user asks to process raw reads into metagenome-assembled genomes, assign taxonomy to bins, reconstruct genome-scale metabolic models, or predict metabolic interactions within microbial communities.
homepage: https://github.com/franciscozorrilla/metaGEM
---


# metagem

## Overview

metaGEM is a specialized Snakemake-based pipeline designed to bridge the gap between metagenomics and systems biology. It automates a complex multi-step workflow that transforms raw sequencing data into functional metabolic simulations. By integrating tools for assembly, binning, taxonomic assignment, and metabolic reconstruction, it allows researchers to predict how microbial species interact within their specific environmental contexts. It is particularly powerful for identifying metabolic dependencies and cross-feeding interactions within complex microbial communities.

## Core Workflow Execution

The primary interface for metaGEM is the `metaGEM.sh` wrapper script. All tasks follow a standard execution pattern.

### Basic Command Structure
```bash
bash metaGEM.sh -t [TASK] [OPTIONS]
```

### Essential Options
- `-t, --task`: The specific step to execute (e.g., `fastp`, `megahit`, `carveme`).
- `-j, --nJobs`: Number of parallel jobs to submit to the cluster.
- `-c, --nCores`: CPU cores allocated per job.
- `-m, --mem`: RAM in GB required per job.
- `-h, --hours`: Maximum runtime for the job.
- `-l, --local`: Critical flag for running on a local machine instead of a HPC cluster (SLURM/SGE).

## Task Sequences

### 1. Initialization and Setup
Before running the core workflow, initialize the directory structure and verify the environment:
- `createFolders`: Generates the required directory hierarchy.
- `organizeData`: Moves your raw `.fastq.gz` files into the expected input structure.
- `check`: Validates that all dependencies and paths are correctly configured.

### 2. From Reads to MAGs (Core)
Execute these tasks in sequence for standard genome reconstruction:
1. `fastp`: Quality filtering and adapter trimming.
2. `megahit`: De novo assembly of filtered reads.
3. `concoct` / `metabat` / `maxbin`: Generate initial bin sets.
4. `binRefine`: Use metaWRAP to consolidate and improve bin quality.
5. `binReassemble`: Reassemble refined bins to improve completion and N50.
6. `gtdbtk`: Assign taxonomy to the resulting MAGs.

### 3. Metabolic Modeling and Interaction
Once MAGs are generated, move into metabolic reconstruction:
1. `extractProteinBins`: Prepare protein sequences for modeling.
2. `carveme`: Reconstruct genome-scale metabolic models (GEMs).
3. `organizeGEMs`: Standardize model file locations for downstream analysis.
4. `smetana`: Perform species metabolic coupling analysis to predict interactions.

## Expert Tips and Best Practices

- **Local vs. Cluster**: Always include the `-l` flag if you are not on a high-performance computing cluster. Without it, the script defaults to `sbatch` or `qsub` commands which will fail on standard workstations.
- **Resource Allocation**: Tasks like `megahit` (assembly) and `gtdbtk` (taxonomy) are memory-intensive. Ensure you allocate at least 64GB-128GB of RAM for these steps on large datasets.
- **Bin Refinement**: Never rely on a single binner. The `binRefine` task is the "secret sauce" of metaGEM; it uses a consensus approach to significantly increase the number of high-quality MAGs compared to using CONCOCT or MetaBAT2 alone.
- **Toy Dataset**: If testing the installation, use the `downloadToy` task to pull a small dataset that allows for rapid verification of the full pipeline.
- **Abundance Estimation**: Run the `abundance` task after binning to map reads back to MAGs, which is required for context-specific modeling and SMETANA simulations.



## Subcommands

| Command | Description |
|---------|-------------|
| concoct | concoct |
| fastp | an ultra-fast all-in-one FASTQ preprocessor |
| megahit | MEGAHIT v1.2.9 |
| metagem_metabat | Metagenome Binning based on Abundance and Tetranucleotide frequency |

## Reference documentation
- [metaGEM Main Repository](./references/github_com_francisco_zorrilla_metaGEM.md)
- [metaGEM Wiki Home](./references/github_com_francisco_zorrilla_metaGEM_wiki.md)
- [Task Implementation Details](./references/github_com_francisco_zorrilla_metaGEM_wiki_1.md)
- [Draft Binning Documentation](./references/github_com_francisco_zorrilla_metaGEM_wiki_Draft-bin-sets-with-CONCOCT_MaxBin2_-and-MetaBAT2.md)
- [Metabolic Reconstruction (CarveMe/memote)](./references/github_com_francisco_zorrilla_metaGEM_wiki_Reconstruct-%26-evaluate-genome-scale-metabolic-models-with-CarveMe-and-memote.md)
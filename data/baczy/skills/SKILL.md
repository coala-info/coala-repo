---
name: baczy
description: Baczy is a bioinformatics pipeline that automates bacterial genome assembly, annotation, and functional characterization from raw sequencing data. Use when user asks to assemble bacterial genomes, identify antibiotic resistance genes, detect defense systems, or perform taxonomic profiling.
homepage: https://github.com/npbhavya/baczy/
---

# baczy

## Overview

Baczy is a comprehensive bioinformatics pipeline designed to streamline the transition from raw sequencing data to fully annotated bacterial genomes. Built on Snakemake, it automates the complex process of host genome assembly and functional characterization. It is particularly useful for researchers needing to identify antibiotic resistance genes, defense systems (like CRISPR-Cas or RM systems), virulence factors, and prophage regions within a bacterial host.

## Installation and Environment Setup

Baczy requires a Python 3.12 environment and relies on external databases for taxonomic and functional profiling.

1. **Environment Creation**:
   ```bash
   conda create -n baczy python=3.12
   conda activate baczy
   pip install baczy
   ```

2. **Database Configuration**:
   You must download and set the path for CheckM2, GTDB-Tk, and CapsuleDB databases.
   ```bash
   export BACZY_DATABASE_PATH=/path/to/your/databases
   ```

## Command Line Usage

The primary interface is the `baczy run` command. It supports both short-read (Illumina) and long-read (Nanopore) data.

### Standard Paired-End (Short Read) Workflow
Use this for standard Illumina datasets.
```bash
baczy run --input path/to/reads --cores 32 --use-singularity --sdm apptainer --output results_dir -k --use-conda
```

### Long-Read Workflow
Specify the sequencing type when working with Nanopore data.
```bash
baczy run --input path/to/reads --sequencing longread --cores 32 --use-singularity --sdm apptainer --output results_dir -k --use-conda
```

### Key Arguments
- `--input`: Directory containing fastq files.
- `--cores`: Number of CPU cores to allocate.
- `--use-singularity`: Enables containerized execution (recommended for tool consistency).
- `--sdm apptainer`: Specifies the software deployment manager (e.g., apptainer/singularity).
- `-k`: Keep going; continues the workflow even if some jobs fail.

## Expert Tips and Best Practices

- **Taxonomic Tree Customization**: Before running, ensure the GTDB-Tk configuration matches your target organism. You can refine the `outgroup` and `taxa_filter` settings to specific genera (e.g., `g__Escherichia`) to improve tree resolution.
- **Resource Management**: Baczy is resource-intensive, especially during assembly (MEGAHIT/Hybracter) and taxonomic classification (GTDB-Tk). Always specify a high core count (`--cores`) if the hardware permits.
- **Output Navigation**: 
  - Intermediate files are stored in `baczy.out/PROCESSING`.
  - Final results are consolidated in `RESULT-short` or `RESULTS-long`.
  - Look for `amrfinder_summary.tsv` and `defensefinder_summary.tsv` for quick profiling across all samples.
- **Prophage Detection**: The workflow includes PhiSpy. Check the `{sample}_prophage_coordinates.tsv` for precise genomic locations of identified prophages.



## Subcommands

| Command | Description |
|---------|-------------|
| baczy config | Copy the system default config file |
| baczy run | Run baczy |
| baczy_citation | Please cite sphaehost in your paper using this article: |

## Reference documentation
- [Baczy README](./references/github_com_npbhavya_baczy_blob_master_README.md)
- [Baczy Changes](./references/github_com_npbhavya_baczy_blob_master_Changes.md)
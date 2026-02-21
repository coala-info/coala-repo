---
name: hybracter
description: hybracter is a Snakemake-based pipeline designed to streamline the assembly of bacterial isolate genomes.
homepage: https://github.com/gbouras13/hybracter
---

# hybracter

## Overview

hybracter is a Snakemake-based pipeline designed to streamline the assembly of bacterial isolate genomes. It prioritizes long reads (ONT or PacBio) to achieve high-quality, often circularized assemblies, and can optionally incorporate paired-end short reads for high-accuracy polishing. The tool automates several complex bioinformatics steps, including read quality control (Filtlong), assembly (Flye/Unicycler), targeted plasmid assembly (plassembler), contig reorientation (dnaapler), and polishing (Medaka/Pilon).

## Installation and Setup

Before running assemblies, ensure the environment and dependencies are initialized.

- **Standard Install**: `hybracter install`
- **MacOS Users**: Use the `--mac` flag during installation or execution to ensure compatibility with Medaka v1.8 (e.g., `hybracter install --mac`).
- **Offline/HPC Preparation**: If running on a cluster without internet access, run the test commands on a login node with internet first to cache all Snakemake environments:
  - `hybracter test-hybrid --threads 8`
  - `hybracter test-long --threads 8`

## Common CLI Patterns

### Single Sample Assembly
For quick processing of a single isolate without creating an input CSV.

- **Hybrid (Long + Short reads)**:
  `hybracter hybrid-single -l long_reads.fastq.gz -1 short_R1.fastq.gz -2 short_R2.fastq.gz -o output_dir -t 8 --auto`
- **Long-read Only**:
  `hybracter long-single -l long_reads.fastq.gz -o output_dir -t 8 --auto`

### Batch Processing
For processing multiple isolates, use the `hybrid` or `long` commands with an input CSV.

- **Batch Hybrid**: `hybracter hybrid --input samples.csv --outdir results_dir --threads 16`
- **Batch Long**: `hybracter long --input samples.csv --outdir results_dir --threads 16`

## Expert Tips and Best Practices

- **PacBio HiFi Reads**: hybracter is optimized for ONT, but can handle PacBio. When using HiFi reads, use the `--no_medaka` flag to skip ONT-specific polishing and specify the model: `--flyeModel pacbio-hifi`.
- **Automated Logic**: The `--auto` flag is highly recommended for most users; it allows the pipeline to automatically select the best assembly based on circularity and quality metrics.
- **Resource Management**: Since hybracter uses Snakemake, you can pass Snakemake-specific arguments. For large-scale HPC runs, utilize Snakemake profiles (e.g., `--profile slurm`).
- **Medaka Versions**: If you require Medaka v2 on MacOS, use the Docker container instead of a native Conda install, as the native MacOS version is capped at v1.8.
- **Container Usage**: For reproducibility in HPC environments, use the Singularity/Docker images. Note that containers come with the database pre-installed, so you do not need to run `hybracter install`.

## Reference documentation
- [Hybracter GitHub Repository](./references/github_com_gbouras13_hybracter.md)
- [Hybracter Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hybracter_overview.md)
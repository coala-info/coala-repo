---
name: edta
description: The Extensive de-novo TE Annotator (EDTA) is a comprehensive pipeline designed to streamline the identification and classification of Transposable Elements (TEs) in genome assemblies.
homepage: https://github.com/oushujun/EDTA
---

# edta

## Overview

The Extensive de-novo TE Annotator (EDTA) is a comprehensive pipeline designed to streamline the identification and classification of Transposable Elements (TEs) in genome assemblies. It integrates multiple search programs and applies rigorous filtering to minimize false positives, ultimately producing a curated TE library and genome-wide annotations. Use this tool to transform raw genomic sequences into high-quality TE datasets suitable for evolutionary and functional genomics.

## Usage Guidelines

### Input Requirements and Preparation

*   **Genome FASTA**: Ensure sequence names are short (≤13 characters) and contain only letters, numbers, and underscores.
*   **Coding Sequences (CDS)**: Provide a FASTA file of CDS from the same or a closely related species to help the pipeline purge gene sequences from the TE library.
*   **Exclusion BED**: Use a BED file of known gene positions to prevent over-masking of functional regions.
*   **Curated Library**: If available, provide a curated TE library (even if incomplete) to improve annotation quality, particularly for SINEs and LINEs.

### Common CLI Patterns

Run the main pipeline using the `EDTA.pl` script.

**Basic Annotation:**
```bash
perl EDTA.pl --genome genome.fa --threads 10
```

**Comprehensive Annotation (Recommended):**
```bash
perl EDTA.pl --genome genome.fa --cds genome.cds.fa --curatedlib species.lib.fa --exclude genome.exclude.bed --overwrite 1 --sensitive 1 --anno 1 --threads 20
```

### Key Parameters

*   `--genome [file]`: (Required) The genome assembly in FASTA format.
*   `--cds [file]`: (Optional) Coding sequences to filter out gene-related repeats.
*   `--curatedlib [file]`: (Optional) A trusted TE library to seed the annotation.
*   `--exclude [file]`: (Optional) BED file of regions to exclude from TE search.
*   `--sensitive 1`: Enable a more thorough search for TEs (increases runtime).
*   `--anno 1`: Perform the actual whole-genome TE annotation after library construction.
*   `--threads [int]`: Number of CPU cores to utilize.

### Expert Tips and Troubleshooting

*   **Initial Testing**: Always validate the installation and environment by running EDTA on a small (e.g., 1-Mb) toy genome. This should complete in approximately 5 minutes.
*   **Memory Management**: For large genomes (>10Gb), ensure the system has sufficient RAM, as TE search programs can be memory-intensive.
*   **Pan-genome Workflow**: For pan-genome projects, annotate each genome individually with EDTA, merge the results into a pan-genome library, and then re-annotate each genome using that master library.
*   **Container Usage**: When using Docker, mount the current directory (`-v $PWD:/in`) and ensure all input files are in that directory without absolute paths, as the container environment is isolated.
*   **PyTorch Issues**: If encountering CUDA errors in certain environments, force a CPU-only build by installing `pytorch=*=*cpu*` via conda/mamba.

## Reference documentation

- [EDTA Main Repository](./references/github_com_oushujun_EDTA.md)
- [EDTA Wiki and Q&A](./references/github_com_oushujun_EDTA_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_edta_overview.md)
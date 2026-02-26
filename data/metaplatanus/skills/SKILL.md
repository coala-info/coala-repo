---
name: metaplatanus
description: MetaPlatanus is a hybrid assembler designed to generate high-quality scaffolds and organized bins from complex metagenomic datasets. Use when user asks to assemble microbiome reads, perform hybrid assembly with long reads, or generate binned scaffolds from mixed-read libraries.
homepage: https://github.com/rkajitani/metaplatanus
---


# metaplatanus

## Overview

MetaPlatanus is a specialized hybrid assembler designed for complex microbiome datasets. It reduces inter-species mis-assemblies by integrating coverage depths, k-mer frequencies, and binning results directly into the assembly workflow. Use this tool to generate high-quality scaffolds and automatically organized bins from mixed-read libraries.

## Core CLI Usage

The basic execution requires at least one Illumina paired-end library.

### Basic Assembly
```bash
metaplatanus -IP1 PE_R1.fq PE_R2.fq -o my_assembly
```

### Hybrid Assembly (ONT or PacBio)
To utilize long reads for scaffolding and gap-closing:
```bash
# Using Oxford Nanopore reads
metaplatanus -t 16 -m 64 -IP1 R1.fq R2.fq -ont long_reads.fq

# Using PacBio reads
metaplatanus -t 16 -m 64 -IP1 R1.fq R2.fq -p pacbio_reads.fq
```

### Advanced Library Inputs
*   **Mate-pairs (Outward-pair):** Use `-OP{INT}` for jumping libraries.
*   **10x Genomics:** Use `-x` for interleaved barcoded files or `-X` for separate files.
*   **Binning-specific reads:** Use `-binning_IP{INT}` if you have specific libraries intended only for the binning depth calculation.

## Expert Tips and Best Practices

### Resource Management
*   **Threads and Memory:** Always explicitly set `-t` (threads) and `-m` (memory in GB). The default memory is 64GB; ensure this matches your environment to avoid OOM (Out of Memory) errors during k-mer distribution steps.
*   **Temporary Files:** Metagenome assembly generates massive intermediate data. Use `-tmp /path/to/fast/disk` to point to a high-speed SSD or scratch space.

### Workflow Control
*   **Restarting vs. Overwriting:** By default, MetaPlatanus attempts to restart from the last successful step. Use `-overwrite` if you need to restart the entire process from scratch.
*   **Skipping Modules:** If you have already performed contig assembly or wish to skip specific polishing steps to save time:
    *   `-no_megahit`: Skip the initial MEGAHIT assembly.
    *   `-no_binning`: Skip the MetaBAT2 binning process.
    *   `-no_nextpolish`: Skip the final polishing step.

### Output Interpretation
Results are stored in the `[PREFIX]_result` directory:
*   `out_final.fa`: The primary output containing gap-closed and polished scaffolds.
*   `out_finalClusters/`: Directory containing the resulting bins as individual FASTA files.
*   `out_finalClusters.tsv`: Mapping file showing which scaffold belongs to which bin.

## Reference documentation
- [MetaPlatanus GitHub README](./references/github_com_rkajitani_MetaPlatanus.md)
- [Bioconda MetaPlatanus Overview](./references/anaconda_org_channels_bioconda_packages_metaplatanus_overview.md)
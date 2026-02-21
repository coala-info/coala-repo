---
name: phables
description: Phables is a specialized bioinformatics tool designed to resolve bacteriophage genomes from fragmented metagenomic data.
homepage: https://github.com/Vini2/phables
---

# phables

## Overview

Phables is a specialized bioinformatics tool designed to resolve bacteriophage genomes from fragmented metagenomic data. While standard assemblers often produce disconnected contigs for viral sequences, Phables analyzes the assembly graph to identify "phage bubbles"—components that represent potential phage genomes. By modeling these components as flow networks and solving a minimum flow decomposition problem, Phables can reconstruct complete or near-complete genomic paths, even for variant phages within a complex community.

## Installation and Setup

Phables relies on the Gurobi optimizer for its linear programming steps.

1.  **Environment Setup**: It is recommended to use Conda for installation.
    ```bash
    conda create -n phables -c conda-forge -c anaconda -c bioconda phables
    conda activate phables
    ```
2.  **Solver Configuration**: Install the Gurobi solver and its Python interface.
    ```bash
    conda install -c gurobi gurobi
    pip install gurobipy
    ```
3.  **License Activation**: To handle large assembly models without size restrictions, you must activate a Gurobi license (academic licenses are available).
    ```bash
    grbgetkey <YOUR_GUROBI_LICENSE_KEY>
    ```
4.  **Database Initialization**: Run the one-time setup to download required databases.
    ```bash
    phables install
    ```

## Common CLI Patterns

### Standard Execution
The primary command is `phables run`. You must provide the assembly graph and the directory containing your sequencing reads.

```bash
phables run --input assembly_graph.gfa --reads path/to/fastq_dir/ --threads 8
```

### Working with Long Reads
If you have long-read data (e.g., Oxford Nanopore or PacBio), use the `--longreads` flag to improve path resolution.

```bash
phables run --input assembly_graph.gfa --reads path/to/fastq_dir/ --threads 16 --longreads
```

### Testing the Pipeline
To verify the installation and solver configuration using provided test data:

```bash
phables test
```

## Expert Tips and Best Practices

-   **Input Requirements**: Phables specifically requires the assembly graph in GFA format. If your assembler produced a different format (like FASTG), you must convert it to GFA first.
-   **Gurobi Limitations**: Without a valid license key, Gurobi operates in a restricted mode that may fail on complex metagenomic assembly graphs. Always ensure `grbgetkey` has been successfully executed in your environment.
-   **Read Mapping**: Phables uses the reads to determine flow values (coverage) across the graph edges. Ensure your `--reads` directory contains all relevant FASTQ files for the sample associated with the GFA.
-   **Visualization**: Use Bandage to visualize your `assembly_graph.gfa` before and after running Phables to understand the complexity of the phage components being resolved.
-   **Co-assemblies**: While Phables can be used on co-assemblies, performance is often better on per-sample assemblies where the graph complexity is lower and strain variation is more manageable.

## Reference documentation

- [Phables GitHub Repository](./references/github_com_Vini2_phables.md)
- [Phables Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phables_overview.md)
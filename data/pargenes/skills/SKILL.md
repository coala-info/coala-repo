---
name: pargenes
description: ParGenes is a high-performance wrapper designed to simplify and accelerate phylogenomic pipelines.
homepage: https://github.com/BenoitMorel/ParGenes
---

# pargenes

## Overview
ParGenes is a high-performance wrapper designed to simplify and accelerate phylogenomic pipelines. It automates the transition from multiple sequence alignments (MSAs) to finished gene trees and species trees. By integrating ModelTest-NG for evolutionary model selection and RAxML-NG for tree inference, it provides a robust, parallelized solution for handling massive datasets that would otherwise be computationally prohibitive to process manually.

## Common CLI Patterns

### Basic Workflow
The most common use case involves providing a directory of alignments and specifying the number of cores for parallelization.

```bash
pargenes.py -a ./alignments_dir -o ./output_dir -c 16
```

### Full Pipeline (Model Selection + Tree Inference)
To run the complete pipeline including model selection (ModelTest-NG) and tree inference (RAxML-NG):

```bash
pargenes.py -a ./alignments_dir -o ./output_dir -c 32 -m -t RAXML-NG
```

### Advanced Tree Inference Options
You can customize the number of starting trees and bootstrap replicates to improve tree search and support values:

```bash
pargenes.py -a ./alignments_dir -o ./output_dir -c 64 -m -t RAXML-NG -s 10 -b 100
```
*   `-s`: Number of starting trees (e.g., 10).
*   `-b`: Number of bootstrap replicates (e.g., 100).

### Species Tree Inference
If you have ASTRAL or ASTER installed, ParGenes can automatically compute a species tree after the gene trees are finished:

```bash
# Using ASTRAL
pargenes.py -a ./alignments_dir -o ./output_dir --astral-jar /path/to/astral.jar

# Using ASTER
pargenes.py -a ./alignments_dir -o ./output_dir --aster-bin /path/to/aster
```

## Expert Tips and Best Practices

### Efficient Parallelization
*   **MPI vs. OpenMP**: For single-node multi-core machines, OpenMP is sufficient. For clusters with multiple nodes, ensure ParGenes is compiled with MPI support to distribute tasks across the network.
*   **Core Allocation**: Match the `-c` parameter to the physical cores available. ParGenes handles the scheduling of individual ModelTest/RAxML jobs automatically to maximize throughput.

### Checkpointing and Restarts
ParGenes features built-in checkpointing. If a run is interrupted (e.g., due to a wall-time limit on a cluster), simply run the exact same command again pointing to the same output directory. ParGenes will detect completed tasks and resume only the pending ones.

### Handling Failures
Check the `errors` directory within your output folder. ParGenes logs specific MSAs that failed during model selection or tree inference, allowing you to troubleshoot problematic alignments without restarting the entire batch.

### Input Formatting
Ensure all alignments in the input directory have consistent extensions (e.g., `.fasta`, `.phy`). While ParGenes is flexible, keeping a clean input directory prevents the tool from attempting to process non-alignment files.

## Reference documentation
- [ParGenes GitHub Repository](./references/github_com_BenoitMorel_ParGenes.md)
- [ParGenes Wiki Home](./references/github_com_BenoitMorel_ParGenes_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pargenes_overview.md)
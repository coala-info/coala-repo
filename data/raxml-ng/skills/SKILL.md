---
name: raxml-ng
description: RAxML-NG (Next Generation) is a high-performance phylogenetic inference tool that utilizes the maximum-likelihood optimality criterion.
homepage: https://github.com/amkozlov/raxml-ng
---

# raxml-ng

## Overview
RAxML-NG (Next Generation) is a high-performance phylogenetic inference tool that utilizes the maximum-likelihood optimality criterion. It is the successor to the widely used RAxML 8.x, offering significant improvements in speed, scalability, and user-friendliness. The tool is designed to handle massive datasets through efficient parallelization (pthreads and MPI) and provides a flexible command-line interface for complex workflows, including partitioned model analysis and ancestral state reconstruction.

## Common CLI Patterns

### 1. Basic Tree Inference
Perform a quick search for the best ML tree using a single parsimony starting tree.
```bash
raxml-ng --search1 --msa alignment.fa --model GTR+G
```

### 2. All-in-One Analysis
The most common workflow: performs ML tree searches from multiple starting trees and executes non-parametric bootstrapping.
```bash
raxml-ng --all --msa alignment.phy --model LG+G8+F --tree pars{10},rand{10} --bs-trees 200
```
*   `--tree pars{10},rand{10}`: Uses 10 parsimony and 10 random starting trees.
*   `--bs-trees 200`: Generates 200 bootstrap replicates.

### 3. Model Evaluation and Parameter Optimization
Optimize branch lengths and model parameters on a fixed, pre-existing topology.
```bash
raxml-ng --evaluate --msa alignment.fa --model partitions.txt --tree fixed.tree --brlen scaled
```

### 4. Mapping Support Values
Map bootstrap support values onto the best-scoring ML tree.
```bash
raxml-ng --support --tree bestML.tree --bs-trees bootstraps.tree --prefix support_map
```

## Best Practices and Expert Tips

### Data Validation and Memory Estimation
Always run a check on your alignment before starting a long analysis. This validates the input format and provides a memory requirement estimate.
```bash
raxml-ng --check --msa alignment.fa --model GTR+G
```

### Parallelization
*   **Multithreading**: Use `--threads N` to specify the number of CPU cores.
*   **Auto-tuning**: RAxML-NG can automatically determine the optimal number of threads for your hardware and dataset size.
*   **MPI**: For very large datasets across multiple nodes, use the MPI-enabled version of the binary.

### Partitioned Models
For multi-gene alignments, define partitions in a separate text file (e.g., `partitions.txt`):
```text
DNA, part1 = 1-500
DNA, part2 = 501-1000
```
Then call it using `--model partitions.txt`.

### Checkpointing and Resuming
RAxML-NG automatically creates checkpoints. If a run is interrupted (e.g., power failure or cluster timeout), simply re-run the exact same command. The program will detect the `.raxml.checkpoint` file and resume from the last completed step.

### Branch Support Metrics
Beyond standard Felsenstein bootstrap (FBP), RAxML-NG supports Internode Certainty (IC) and Transfer Bootstrap Expectation (TBE).
*   Use `--bs-metric fbp,tbe,ic1` to calculate multiple support metrics in one go.

## Reference documentation
- [RAxML-NG GitHub Repository](./references/github_com_amkozlov_raxml-ng.md)
- [RAxML-NG Wiki Home](./references/github_com_amkozlov_raxml-ng_wiki.md)
- [Bioconda raxml-ng Overview](./references/anaconda_org_channels_bioconda_packages_raxml-ng_overview.md)
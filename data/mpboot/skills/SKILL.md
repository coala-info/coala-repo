---
name: mpboot
description: mpboot is a high-performance tool for phylogenetic tree inference based on the Maximum Parsimony (MP) criterion.
homepage: https://github.com/diepthihoang/mpboot
---

# mpboot

## Overview

mpboot is a high-performance tool for phylogenetic tree inference based on the Maximum Parsimony (MP) criterion. It addresses the computational bottlenecks of traditional MP methods by implementing fast tree-searching heuristics and an efficient bootstrap approximation. This skill enables the rapid construction of phylogenetic trees from sequence alignments and provides statistical support for branches, making it ideal for large-scale genomic datasets where traditional parsimony or likelihood-based methods may be too slow.

## Installation and Setup

The most efficient way to install mpboot is via Bioconda:

```bash
conda install bioconda::mpboot
```

If compiling from source, the binary name varies based on your CPU architecture:
- **AVX-enabled CPUs**: The executable is typically named `mpboot-avx`.
- **SSE4-enabled CPUs**: The executable is typically named `mpboot`.

## Common CLI Patterns

### Basic Tree Inference
To infer a maximum parsimony tree from a Phylip alignment:
```bash
mpboot -s example.phy
```

### Bootstrap Analysis
To perform a fast bootstrap approximation with a specific number of replicates (e.g., 1000):
```bash
mpboot -s example.phy -b 1000
```

### Parallel Execution (MPI)
For very large datasets, use the MPI-enabled version to distribute the workload across multiple CPU cores:
```bash
mpirun -np 4 mpboot-avx -s example.phy
```

## Expert Tips and Best Practices

### Sequence Pre-processing
- **Duplicate Sequences**: Use the `-remove_dup_seq` flag to handle identical sequences in your alignment. This reduces the search space and improves performance without losing phylogenetic information.
- **Informative Sites**: mpboot is most effective when the alignment contains a high proportion of parsimony-informative sites.

### Search Heuristics
- **Ratchet Search**: If the default search is not converging, you can toggle the parsimony ratchet. While the ratchet is usually beneficial, it can be disabled using `-ratchet_off` for specific testing scenarios.
- **NNI Search**: Use `-nni_pars` to perform Nearest Neighbor Interchanges specifically optimized for parsimony scores.

### Handling Gaps
- By default, gaps are often treated as missing data. If gaps should be treated as a 5th state (for DNA) or a new state, check for the `-gap_as_new` option (available in recent versions/branches).

### Troubleshooting Performance
- **Memory Allocation**: For datasets with >5,000 sequences or >15,000 informative sites, monitor memory usage closely, as large alignments can trigger `std::bad_alloc` errors.
- **Architecture Optimization**: Always prefer the `mpboot-avx` binary over the standard `mpboot` binary if your hardware supports AVX instructions, as it significantly speeds up the Sankoff algorithm computations.

## Reference documentation
- [MPBoot GitHub Repository](./references/github_com_diepthihoang_mpboot.md)
- [Bioconda mpboot Overview](./references/anaconda_org_channels_bioconda_packages_mpboot_overview.md)
- [MPBoot Commit History](./references/github_com_diepthihoang_mpboot_commits_mpboot.md)
---
name: ucsc-chainprenet
description: The `ucsc-chainprenet` tool filters alignment chains by removing those statistically unlikely to be part of the final whole-genome alignment. Use when user asks to filter alignment chains, prepare chains for whole-genome netting, or optimize whole-genome alignment computation.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-chainprenet

## Overview
The `ucsc-chainprenet` tool (commonly executed as `chainPreNet`) is a utility from the UCSC Genome Browser "kent" suite designed to streamline whole-genome alignments. Its primary function is to remove alignment chains that have no statistical likelihood of being included in the final "net" (the best single-coverage alignment). By filtering these "hopeless" chains early, it significantly reduces the computational overhead and memory requirements of the subsequent `chainNet` process.

## Usage Instructions

### Basic Command Pattern
The tool requires the input chains, the chromosome sizes for both the target and query genomes, and a destination for the filtered output.

```bash
chainPreNet input.chain target.sizes query.sizes output.chain
```

### Input Requirements
1.  **Input Chain File**: A `.chain` file, typically produced by `axtChain` and subsequently sorted by `chainSort`.
2.  **Target Sizes**: A two-column tab-separated file listing `<chromName> <size>` for the target genome.
3.  **Query Sizes**: A two-column tab-separated file listing `<chromName> <size>` for the query genome.

### Pipeline Integration
`chainPreNet` is strictly positional in the standard UCSC pipeline:
1.  **Alignment**: `lastz` or `blat` produces initial alignments.
2.  **Chaining**: `axtChain` groups alignments into chains.
3.  **Sorting**: `chainSort` orders the chains (Required before PreNet).
4.  **Pre-Netting**: `chainPreNet` (This tool) filters the sorted chains.
5.  **Netting**: `chainNet` creates the final alignment hierarchy.

### Best Practices
- **Always Sort First**: Never run `chainPreNet` on unsorted chains. The tool expects the input to be ordered, usually by target chromosome and score.
- **Memory Management**: Use this tool especially when working with large, repetitive genomes where the number of initial chains can be massive. It prevents `chainNet` from crashing due to memory exhaustion.
- **Verification**: You can verify the reduction in file size between `input.chain` and `output.chain` to ensure the filter is working; a significant reduction is common and expected.

### Common CLI Options
While usually run with default parameters, the following flags are often available:
- `-dots=N`: Output a dot every N chains to monitor progress in large datasets.
- `-pad=N`: Add N bases of padding to the alignment blocks (default is usually 0).
- `-verbose=N`: Increase verbosity level for debugging pipeline issues.

## Reference documentation
- [Bioconda ucsc-chainprenet Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-chainprenet_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
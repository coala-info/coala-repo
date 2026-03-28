---
name: ucsc-chainswap
description: The ucsc-chainswap utility reverses the target and query roles within a genomic chain alignment file. Use when user asks to swap the target and query in a chain file, reverse alignment coordinates, or perform reciprocal genome analysis without re-aligning.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-chainswap

## Overview

The `chainSwap` utility is a specialized tool within the UCSC Genome Browser "kent" suite designed to manipulate `.chain` alignment files. In a standard chain file, one genome is designated as the "target" (reference) and the other as the "query." `chainSwap` reverses these roles, transforming the coordinates and headers so that the original query becomes the new target. This allows bioinformaticians to reuse existing alignment data for reciprocal analysis without the need to re-align the genomes, saving significant computational time.

## Command Line Usage

The tool follows the standard UCSC Genome Browser utility pattern where the usage statement is displayed by running the binary with no arguments.

### Basic Syntax
To swap the target and query in a chain file:
```bash
chainSwap input.chain output.chain
```

### Using Standard I/O
`chainSwap` supports `stdin` and `stdout`, which is useful for integration into shell pipelines:
```bash
cat input.chain | chainSwap stdin stdout > swapped.chain
```

## Best Practices and Expert Tips

### 1. Post-Swap Sorting
Swapping a chain file often results in the records being out of chromosomal order relative to the new target genome. It is a best practice to sort the resulting file using `chainSort`:
```bash
chainSwap input.chain stdout | chainSort stdin output.chain
```

### 2. Coordinate Systems
`chainSwap` automatically handles the conversion of coordinates, including the strand orientation. If the original alignment was on the negative strand, the tool ensures the new target coordinates are correctly represented in the swapped file.

### 3. Integration with Netting
If you are building "Nets" (hierarchical collections of alignments), you must swap the chains before running `chainNet` if your goal is to create a net for the original query genome.

### 4. Verification
After swapping, you can use `checkChain` (another UCSC utility) to ensure the integrity of the new file:
```bash
checkChain swapped.chain
```



## Subcommands

| Command | Description |
|---------|-------------|
| chainSwap | Swap target and query in a chain file. |
| netChainSubset | Create a chain file from a net file and the original chains. This tool subsets a chain file based on the alignments that were kept in a corresponding net file. |

## Reference documentation
- [UCSC Genome Browser Source](./references/github_com_ucscGenomeBrowser_kent.md)
- [UCSC Linux Binaries Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.aarch64.v492.md)
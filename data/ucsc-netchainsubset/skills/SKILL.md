---
name: ucsc-netchainsubset
description: The ucsc-netchainsubset tool extracts chain records that correspond to a net file. Use when user asks to clean chain files to match nets, subset chain files, or get chains corresponding to filtered nets.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-netchainsubset:482--h0b57e2e_0"
---

# ucsc-netchainsubset

## Overview
The `netChainSubset` utility is a specialized tool within the UCSC Genome Browser "kent" suite used during the final stages of whole-genome alignment pipelines (like Lastz/Chain/Net). While `.chain` files contain raw pairwise alignments, `.net` files represent a hierarchical selection of those alignments that best cover the genome. This tool allows you to extract the specific chain records that were actually used to build a given net, effectively "cleaning" your chain files to match your nets. This is essential for downstream tasks like creating liftOver files or visualizing high-quality syntenic blocks.

## Usage Patterns

### Basic Syntax
The tool requires two input files and specifies one output file:
```bash
netChainSubset in.net in.chain out.chain
```

### Common Workflow: Syntenic Filtering
Often, users filter a net file first (e.g., using `netFilter` to keep only top-level orthologous blocks) and then want the corresponding chains.
1. Filter the net: `netFilter -syn test.net > test.syn.net`
2. Subset the chains: `netChainSubset test.syn.net test.chain test.syn.chain`

### Expert Tips
*   **Input Consistency**: Ensure that the `in.chain` file provided is the exact same file (or contains the same Chain IDs) used to generate the `in.net` file. The tool matches records based on the numeric IDs assigned during the `chainNet` process.
*   **Binary Availability**: This tool is part of the UCSC Genome Browser "userApps" and is available for multiple architectures (Linux x86_64, macOS arm64/intel). If you encounter "permission denied," remember to `chmod +x` the binary.
*   **Memory Efficiency**: `netChainSubset` is generally efficient as it uses the net file as a lookup table to stream the chain file, but for extremely large mammalian alignments, ensure you have sufficient RAM to hold the net structure.
*   **Downstream Processing**: The output `out.chain` is a standard chain file. It is frequently used as the input for `chainStitchId` or `chainMergeSort` if multiple subset files are being combined.

## Reference documentation
- [UCSC Genome Browser Bioconda Package](./references/anaconda_org_channels_bioconda_packages_ucsc-netchainsubset_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
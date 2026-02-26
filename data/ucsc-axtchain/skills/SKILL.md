---
name: ucsc-axtchain
description: `axtChain` organizes local genomic alignments into larger, co-linear blocks called "chains." Use when user asks to chain genomic alignments, chain cross-species alignments, or chain alignments using a custom score matrix.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-axtchain

## Overview
`axtChain` is a high-performance utility from the UCSC Genome Browser "Kent" source tree designed to organize local genomic alignments into "chains." While raw alignments (AXT format) represent local similarities, chaining joins these segments into larger, co-linear blocks that follow a consistent order and orientation in both the target and query genomes. This process is a critical intermediate step in comparative genomics pipelines, sitting between initial alignment discovery and the final "netting" process that defines orthology.

## Usage Patterns

### Basic Command Structure
The tool requires the input AXT file, the sequence data for both genomes (preferably in `.2bit` format for efficiency), and the output filename.

```bash
axtChain [options] input.axt target.2bit query.2bit output.chain
```

### Common CLI Patterns

**1. Standard Chaining for Cross-Species Alignments**
For most genome-to-genome comparisons, use a minimum score threshold to filter out noise and specify a gap penalty scheme.
```bash
axtChain -minScore=3000 -linearGap=medium input.axt target.2bit query.2bit output.chain
```

**2. Using a Custom Substitution Matrix**
When aligning divergent species, providing a specific score matrix (often a `.q` file) is recommended.
```bash
axtChain -scoreScheme=human_chimp.q input.axt target.2bit query.2bit output.chain
```

**3. Processing PSL Input**
If your alignments are in PSL format, you can pipe them through `pslToAxt` or use the `-psl` flag if the specific build supports it (though converting to AXT first is the most robust method).

## Expert Tips and Best Practices

### 1. Sequence Format Efficiency
Always use `.2bit` files for the target and query sequence arguments. `axtChain` needs to look up sequences to score gaps and extensions; using raw FASTA files is significantly slower and more memory-intensive.

### 2. The -linearGap Parameter
The `-linearGap` option is crucial for performance. 
- Use `loose` or `medium` for closely related species.
- Use `fine` for more distant species where small indels are more frequent.
- If you have a specific gap cost file, use `-linearGap=<file.tab>`.

### 3. Memory Management
`axtChain` can be memory-intensive on large genomes (like mammals). If the process crashes:
- Ensure you are using the 64-bit version of the binary.
- Split the input AXT file by target chromosome and run chaining in parallel, then merge the resulting chains using `chainMergeSort`.

### 4. Pre-Chaining Filtering
Before running `axtChain`, it is often beneficial to run `axtSort` on your input. While `axtChain` can handle unsorted input, sorted AXT files lead to more predictable behavior in complex pipelines.

### 5. Integration in the UCSC Pipeline
Remember that `axtChain` is only step two of the standard "Chain-Net" workflow:
1.  **Align**: `lastz` -> `output.axt`
2.  **Chain**: `axtChain` -> `output.chain`
3.  **Sort**: `chainMergeSort` -> `sorted.chain`
4.  **Pre-Net**: `chainPreNet` -> `filtered.chain`
5.  **Net**: `chainNet` -> `output.net`

## Reference documentation
- [ucsc-axtchain Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-axtchain_overview.md)
- [UCSC Executable Directory (Linux x86_64)](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [UCSC Administrative Executables Guide](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
---
name: ucsc-chainantirepeat
description: The `ucsc-chainantirepeat` tool removes repeat-driven alignments from genomic chain files. Use when user asks to remove spurious alignments, filter repeat-heavy chains, or clean up genomic alignment files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-chainantirepeat:482--h0b57e2e_0"
---

# ucsc-chainantirepeat

## Overview
The `ucsc-chainantirepeat` tool is a specialized utility from the UCSC Kent Toolkit designed to post-process genomic alignment chain files. In comparative genomics, alignments often pick up "spurious" chains caused by low-complexity repeats or degenerate DNA sequences rather than true orthology. This tool analyzes the underlying sequence of the target and query genomes to identify and remove these repeat-driven alignments, resulting in a cleaner set of chains for downstream applications like synteny mapping or liftOver.

## Usage Instructions

### Basic Command Syntax
To use `chainAntiRepeat`, you must provide the sequence data for both the target and query genomes (typically in `.2bit` format) along with the input and output chain files.

```bash
chainAntiRepeat target.2bit query.2bit input.chain output.chain
```

### Input Requirements
- **.2bit files**: You must have the `.2bit` files corresponding to the exact assembly versions used to generate the original chains.
- **.chain files**: The input should be a standard UCSC chain file.

### Expert Tips and Best Practices
1. **Sequence Masking**: The tool is most effective when the `.2bit` files contain information about repeats. Ensure your `.2bit` files were generated from soft-masked or hard-masked fasta files if you want the tool to leverage existing repeat annotations.
2. **Workflow Integration**: This tool is typically used after `axtChain` and before `chainNet`. Running it early in the chain-processing pipeline prevents repeat-heavy alignments from being promoted to "nets."
3. **Permissions**: If you are using the binary directly from the UCSC download server, ensure it has execution permissions:
   ```bash
   chmod +x chainAntiRepeat
   ```
4. **Memory Considerations**: While generally efficient, processing very large chain files (e.g., whole-genome human vs. mouse) requires sufficient RAM to handle the chain structures in memory.

## Reference documentation
- [ucsc-chainantirepeat overview](./references/anaconda_org_channels_bioconda_packages_ucsc-chainantirepeat_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
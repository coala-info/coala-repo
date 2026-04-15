---
name: ucsc-chaintopslbasic
description: This tool converts chain alignment files into PSL format. Use when user asks to convert chain files to PSL format.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-chaintopslbasic:482--h0b57e2e_0"
---

# ucsc-chaintopslbasic

## Overview
The `chainToPslBasic` utility is a specialized tool from the UCSC Kent toolkit designed for the straightforward conversion of chain alignment files into PSL format. While the standard `chainToPsl` tool often requires additional sequence size files to populate all PSL fields, `chainToPslBasic` provides a simplified conversion path. This is particularly useful when you need a quick PSL representation of alignments for tools that do not strictly require the sequence size metadata usually found in the PSL header or specific columns.

## Usage Instructions

### Basic Command Syntax
The tool follows the standard UCSC command-line pattern where the input and output are positional arguments:

```bash
chainToPslBasic input.chain output.psl
```

### Common Workflow Patterns
1. **Format Conversion**: Use this as a bridge between alignment pipelines that output `.chain` files (like `lastz` or `axtChain`) and tools that require `.psl` input.
2. **Piping and Redirection**: Like most Kent utilities, it can often be used in shell pipes, though it typically expects defined file paths for the basic version.
3. **Batch Processing**: When dealing with whole-genome alignments, you can iterate through chromosome-specific chain files:
   ```bash
   for f in *.chain; do chainToPslBasic "$f" "${f%.chain}.psl"; done
   ```

### Expert Tips
* **Permissions**: If you have downloaded the binary directly from the UCSC server, ensure it is executable using `chmod +x chainToPslBasic`.
* **Chain vs. PSL**: Remember that Chain files are hierarchical and can represent gaps more compactly, while PSL is a flat, tab-delimited format where each line represents a single alignment record. Converting to PSL increases file size but improves compatibility with many legacy bioinformatics tools.
* **Missing Sizes**: If your downstream tool complains about 0-length sequences or missing target/query sizes in the PSL, you may need to use the full `chainToPsl` utility instead, which accepts `.2bit` or `.sizes` files to fill those fields.
* **Validation**: After conversion, it is good practice to run `pslCheck` on the output to ensure the resulting PSL file is well-formed.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-chaintopslbasic Package](./references/anaconda_org_channels_bioconda_packages_ucsc-chaintopslbasic_overview.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
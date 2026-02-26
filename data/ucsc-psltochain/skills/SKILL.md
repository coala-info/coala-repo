---
name: ucsc-psltochain
description: `ucsc-psltochain` converts alignment data from PSL format to Chain format. Use when user asks to create liftOver files, generate syntenic nets, or visualize synteny.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-psltochain

## Overview
`pslToChain` is a specialized utility from the UCSC Kent toolkit that transforms alignment data. While PSL files provide a detailed record of how a sequence matches a genome, the Chain format groups these alignments into larger, gap-filled blocks that represent more continuous genomic relationships. This tool is a critical component in the pipeline for creating "liftOver" files and generating syntenic "nets" between different species or assembly versions.

## Usage Instructions

### Basic Command Line
The tool reads a PSL file and outputs a Chain file.
```bash
pslToChain input.psl output.chain
```

### Common Workflow Patterns
1. **Pre-sorting PSL files**: For large datasets, it is often necessary to sort the PSL file by target name and start position before conversion to ensure the resulting chains are logically ordered.
   ```bash
   pslSort col target tempDir input.psl
   ```

2. **Integration with LiftOver**: After converting PSL to Chain, the output is typically used as an input for `chainNet` or directly as a custom track for the UCSC Genome Browser to visualize synteny.

### Expert Tips
* **Permission Handling**: If running the binary directly from a download, ensure it has executable permissions: `chmod +x pslToChain`.
* **Standard Input/Output**: Like many Kent utilities, `pslToChain` can often be used in pipes, though it typically expects file arguments. If you need to process a stream, check if your specific version supports `stdin` or use `/dev/stdin`.
* **Memory Considerations**: When processing whole-genome BLAT results, ensure the environment has sufficient memory, as the tool may need to hold significant alignment metadata to resolve chain blocks.
* **Validation**: Use `pslCheck` on your input file before running `pslToChain` to avoid silent failures or malformed chain outputs caused by corrupted PSL records.

## Reference documentation
- [bioconda | ucsc-psltochain Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-psltochain_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
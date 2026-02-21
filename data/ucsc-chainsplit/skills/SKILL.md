---
name: ucsc-chainsplit
description: The `chainSplit` utility is a specialized tool from the UCSC Genome Browser "kent" source suite designed to manage large genomic alignment files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-chainsplit

## Overview
The `chainSplit` utility is a specialized tool from the UCSC Genome Browser "kent" source suite designed to manage large genomic alignment files. It partitions a single `.chain` file into multiple files, organized by either the target (reference) or query (source) sequence names. This is a critical preprocessing step for bioinformatics pipelines that require parallelizing liftOver operations or analyzing specific genomic regions without loading massive global alignment files into memory.

## Usage Patterns

### Basic Command Structure
The tool follows a standard UCSC CLI pattern where running the binary without arguments displays the help text.
```bash
chainSplit outDir inChain
```

### Splitting by Target Sequence (Default)
To split a chain file so that every target chromosome (e.g., chr1, chr2) has its own file in the output directory:
```bash
mkdir -p split_by_target
chainSplit split_by_target input.chain
```
*Result: Files named `chr1.chain`, `chr2.chain`, etc., will be created in `split_by_target/`.*

### Splitting by Query Sequence
Use the `-q` flag to split based on the query sequence names instead of the target:
```bash
mkdir -p split_by_query
chainSplit -q split_by_query input.chain
```

### Handling Large Numbers of Files
If the input chain contains thousands of small scaffolds, use the `-lump` option to prevent creating too many individual files. This groups sequences together to keep the file count manageable:
```bash
chainSplit -lump=100 outDir input.chain
```

## Best Practices and Expert Tips
- **Directory Preparation**: Always create the output directory (`mkdir -p`) before running the command, as the tool expects the destination to exist.
- **Permissions**: If using the binary directly from a download, ensure it is executable: `chmod +x chainSplit`.
- **Memory Efficiency**: `chainSplit` is highly efficient because it processes the input stream-wise. It is the preferred method for preparing data for `liftOver` when working with non-standard assemblies or massive datasets.
- **Downstream Parallelization**: After splitting, you can use a simple loop or `xargs` to run analysis on each chromosome independently, significantly reducing total wall-clock time.
- **Naming Conventions**: Note that the output filenames will exactly match the sequence names in the chain file (e.g., `scaffold_10.chain`). Ensure your downstream scripts are prepared for these names.

## Reference documentation
- [UCSC Genome Browser Binaries Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-chainsplit Package Details](./references/anaconda_org_channels_bioconda_packages_ucsc-chainsplit_overview.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
---
name: ucsc-randomlines
description: The `ucsc-randomlines` utility is a high-performance tool from the UCSC Genome Browser "Kent" suite designed to extract a random subset of lines from a file.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-randomlines

## Overview
The `ucsc-randomlines` utility is a high-performance tool from the UCSC Genome Browser "Kent" suite designed to extract a random subset of lines from a file. It is particularly useful in bioinformatics for downsampling large datasets (like BED, PSL, or FASTA-tab files) to a manageable size for testing or visualization without the overhead of loading the entire file into memory.

## Usage Instructions

### Basic Command Structure
The tool requires the number of lines to extract and the input file path. By default, it outputs to standard output (stdout).

```bash
randomLines <count> <input_file>
```

### Common Patterns
*   **Subsampling to a new file**:
    `randomLines 1000 large_data.bed > subset.bed`
*   **Sampling from a compressed file** (using a pipe):
    `zcat large_data.gz | randomLines 500 stdin > sample.txt`
*   **Randomizing and then sampling**:
    While `randomLines` picks lines randomly, if you need a specific seed or more complex shuffling, it is often used in conjunction with other Kent utilities or standard Unix tools.

### Expert Tips
*   **Performance**: Unlike some sampling tools that read the entire file into memory, `randomLines` is optimized for large files.
*   **Permissions**: If you download the binary directly from the UCSC servers instead of using Conda, remember to set execution permissions: `chmod +x randomLines`.
*   **Standard Input**: You can use `stdin` as the filename to process data coming from a pipe.
*   **No Header Preservation**: Note that `randomLines` treats all lines equally. If your file has a header (e.g., a track line or column names), it may be sampled as a data line or missed. To preserve a header, use:
    `head -n 1 input.txt > output.txt && tail -n +2 input.txt | randomLines 100 stdin >> output.txt`

## Reference documentation
- [UCSC Genome Browser Admin Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-randomlines Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-randomlines_overview.md)
- [Linux x86_64 Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
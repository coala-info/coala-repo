---
name: ucsc-fasplit
description: ucsc-fasplit partitions FASTA files into smaller segments based on record count, sequence name, or base pair size while maintaining header-sequence pairings. Use when user asks to split FASTA files into a specific number of chunks, divide sequences by name, or break genomic data into pieces of a certain size or at gaps.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-fasplit:482--h0b57e2e_0"
---

# ucsc-fasplit

## Overview

`faSplit` is a high-performance, sequence-aware utility from the UCSC Genome Browser "Kent" toolset. Unlike standard Unix `split`, `faSplit` understands the FASTA format, ensuring that headers and sequences remain correctly paired. It provides multiple modes to partition data by record count, total base pairs, or specific genomic features like gaps.

## Command Line Usage

The basic syntax for `faSplit` requires a specific mode, the input file, a parameter value, and an output prefix.

```bash
faSplit <mode> <input.fa> <parameter> <outRoot>
```

### Common Modes and Patterns

*   **Split by File Count (`sequence`)**
    Distributes sequences across a fixed number of files.
    `faSplit sequence input.fa 10 out_`
    *Result: Creates out_01.fa through out_10.fa.*

*   **Split by Sequence Name (`byname`)**
    Creates a separate file for every sequence record in the input.
    `faSplit byname input.fa outDir/`
    *Note: The parameter is ignored but required; the output root should usually be a directory.*

*   **Split by Approximate Size (`about`)**
    Splits into files containing approximately *N* bases. This is the preferred method for load-balancing parallel alignment jobs.
    `faSplit about input.fa 1000000 out_`
    *Result: Each file contains roughly 1MB of sequence data.*

*   **Split at Gaps (`gap`)**
    Breaks sequences into chunks at every gap (run of Ns) longer than *N* bases.
    `faSplit gap input.fa 100 out_`

*   **Split by Exact Size (`size`)**
    Splits sequences into chunks of exactly *N* bases.
    `faSplit size input.fa 5000 out_`

### Expert Tips

1.  **Directory Preparation**: `faSplit` does not automatically create output directories. If your `outRoot` includes a path (e.g., `splits/chunk_`), run `mkdir -p splits` first.
2.  **Handling Large Record Sets**: When using `byname` on a file with thousands of scaffolds, you may hit filesystem limits or experience slow performance. In these cases, use `about` with a large enough size to group sequences instead.
3.  **Compressed Inputs**: While some UCSC tools handle `.gz` natively, it is safest to provide uncompressed FASTA files to `faSplit` to ensure accurate splitting and offset calculation.
4.  **Verification**: After splitting, use `faSize` (another UCSC utility) on the output files to verify that the total base count matches the original input.

## Reference documentation
- [Bioconda ucsc-fasplit Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-fasplit_overview.md)
- [UCSC Kent Utility Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
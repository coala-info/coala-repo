---
name: transrate-tools
description: transrate-tools parses BAM files to aggregate read mapping information by contig for transcriptome assembly evaluation. Use when user asks to evaluate transcriptome assembly quality, get read mapping metrics per contig, or calculate scores like mean MAPQ and proper pair counts.
homepage: https://github.com/blahah/transrate-tools
---


# transrate-tools

## Overview

transrate-tools is a collection of high-performance C++ utilities designed to support the Transrate transcriptome assembly evaluation suite. Its primary component, `bam-read`, parses BAM files to aggregate read mapping information by contig. This tool is essential for generating the underlying metrics required to score the quality of a de novo transcriptome assembly, such as mean MAPQ, proper pair counts, and the probability of coverage segmentation.

## Installation and Setup

Install the tools via Bioconda for the most reliable environment:

```bash
conda install bioconda::transrate-tools
```

If building from source, ensure you have a C++11 compatible compiler (g++ 4.8+) and CMake. Note that the `bamtools` submodule must be initialized and built before compiling transrate-tools.

## Using bam-read

The primary executable is `bam-read`. It is designed to process BAM files after multi-mapping reads have been assigned to specific contigs.

### Basic Command Pattern
```bash
bam-read <input.bam>
```

### Key Features and Behavior
- **Sorting**: `bam-read` does not require the input BAM file to be sorted.
- **Aggregation**: It aggregates data per contig, providing a summary of how reads support each sequence in your assembly.
- **Metrics Output**: The tool captures and outputs the following metrics for each contig:
  - `name`: The contig identifier.
  - `length`: Total length of the contig.
  - `bases mapped`: Total number of bases aligned to the contig.
  - `reads mapped`: Total number of reads aligned.
  - `proper pair`: Number of reads mapped as a proper pair.
  - `both mapped`: Number of read pairs where both ends are mapped.
  - `edit distance`: The sum of edit distances for all mapped reads.
  - `mean mapq`: The average mapping quality score.
  - `uncovered bases`: The count of bases with zero coverage.
  - `p_seq_true`: The probability that the coverage is not segmented (used to identify potential chimeras or misassemblies).

## Expert Tips and Best Practices

- **Pre-processing**: For the most accurate Transrate scores, ensure your BAM file includes multi-mapping assignments. `bam-read` is most effective when it can see the final placement of all reads.
- **Fragment Size Estimation**: The tool uses fragment size and standard deviation to calculate the "good" mapping metric. Ensure your library preparation parameters are consistent, as outliers in fragment size can affect the "good" read count.
- **Memory Efficiency**: Since `bam-read` does not require sorted BAMs, it can often process large files more efficiently than tools that require coordinate sorting, reducing the I/O overhead of pre-sorting.
- **OSX Compatibility**: If building on macOS, you must explicitly point CMake to a modern GCC version (e.g., `brew install gcc`) using `-DCMAKE_CXX_COMPILER=$(which g++-X)`, as the default Clang may have compatibility issues with the specific C++11 features used in older versions of the tool.

## Reference documentation
- [transrate-tools - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_transrate-tools_overview.md)
- [blahah/transrate-tools: Reading bam files and aggregating read mapping information about sequences](./references/github_com_blahah_transrate-tools.md)
---
name: maelstrom-core
description: maelstrom-core provides Rust utilities for high-performance Next-Generation Sequencing (NGS) data processing. Use when user asks to process NGS data, align reads to a reference, call variants, or perform genome assembly.
homepage: https://github.com/bihealth/maelstrom-core
---


# maelstrom-core

Provides Rust utilities for Next-Generation Sequencing (NGS) data processing, focusing on
  heavy-lifting tasks that benefit from efficient, compiled code. Use when Claude needs to
  perform complex bioinformatics analyses on NGS data, particularly when performance is critical
  or when specific Rust-based tools are required for tasks such as:
  - Sequence alignment and manipulation (e.g., BAM file processing)
  - Variant calling and analysis
  - Genome assembly and annotation
  - Other computationally intensive bioinformatics workflows.
  This skill is suitable for users familiar with command-line interfaces and bioinformatics tools.
---
## Overview

The `maelstrom-core` skill provides access to a suite of Rust-based command-line utilities designed for high-performance Next-Generation Sequencing (NGS) data processing. It is particularly useful for computationally intensive bioinformatics tasks where efficiency and speed are paramount. This skill enables Claude to leverage these specialized tools for operations like sequence alignment, variant analysis, and other core NGS data manipulation workflows.

## Usage Instructions

`maelstrom-core` is a command-line tool. Its specific subcommands and options will depend on the installed version and its compiled features. The primary way to interact with `maelstrom-core` is by invoking its executable followed by subcommands and arguments.

### General Usage Pattern

The general pattern for using `maelstrom-core` is:

```bash
maelstrom-core <subcommand> [options] <input_files>
```

### Common Subcommands and Operations (Based on available information)

While the exact subcommands can vary, based on the project's description and commit history, common operations likely involve processing BAM files and performing variant analysis.

*   **BAM File Processing**: Tools for manipulating and analyzing Binary Alignment Map (BAM) files are a likely component. This could include:
    *   Collecting statistics (e.g., coverage, read counts).
    *   Filtering or manipulating alignment data.

    **Example (Hypothetical, based on commit `feat(bam-collect-doc): compute normalized coverage`):**
    ```bash
    maelstrom-core bam-collect-doc --input alignment.bam --output coverage_stats.tsv
    ```
    *   **Tip**: Always check the specific subcommand's help (`maelstrom-core <subcommand> --help`) for detailed options and expected input/output formats.

*   **Variant Analysis**: Tools for variant calling or analysis are also indicated.

    **Example (Hypothetical, based on commit `feat: add bam-collect-doc command`):**
    This suggests a command that might collect documentation or statistics related to BAM files, potentially for variant calling pipelines.

### Expert Tips

*   **Consult Help Pages**: For any `maelstrom-core` command, always use the `--help` flag to understand its specific arguments, options, and expected input/output. For example: `maelstrom-core <subcommand> --help`.
*   **Input/Output Redirection**: Leverage standard input (`<`) and standard output (`>`) redirection for piping data between `maelstrom-core` commands or with other command-line tools.
*   **Version Specificity**: If you encounter issues, ensure you are aware of the `maelstrom-core` version being used, as functionality and options can change between releases. The latest release is v0.1.1.
*   **Performance**: `maelstrom-core` is designed for performance. For very large datasets, consider running it on systems with sufficient CPU and memory resources.

## Reference documentation
- [GitHub - bihealth/maelstrom-core: Rust utilities for NGS data processing](./references/github_com_bihealth_maelstrom-core.md)
- [Anaconda.org | bioconda | maelstrom-core](./references/anaconda_org_channels_bioconda_packages_maelstrom-core_overview.md)
---
name: b2b-utils
description: The `b2b-utils` suite is a specialized collection of bioinformatics tools developed by BASE2BIO, primarily written in Perl.
homepage: https://github.com/jvolkening/b2b-utils
---

# b2b-utils

## Overview

The `b2b-utils` suite is a specialized collection of bioinformatics tools developed by BASE2BIO, primarily written in Perl. It is designed to fill gaps in standard genomic workflows, offering utilities for iterative assembly, viral sequence polishing, and efficient file handling. Use this skill to identify the correct utility for a specific genomic task and to understand the execution patterns for these tools within a Bioconda or source-installed environment.

## Installation and Environment Setup

The suite is most easily managed via Conda, though it has a unique dependency model.

- **Standard Install**: `conda install -c bioconda b2b-utils`
- **Dependency Handling**: To keep the footprint small, the base package does not include all dependencies for every tool. If a tool fails due to a missing requirement, install the specific dependency via Conda as prompted by the tool's error message.
- **Full Environment**: For a complete setup with all possible dependencies, use the `environment.yml` provided in the source repository: `conda env create -f environment.yml`.

## Core Utilities and CLI Patterns

All tools in the suite follow a standard CLI pattern. Always use the `--help` flag to see specific options for each utility.

### Sequence Assembly and Polishing
- **minimeta**: A powerful tool for iterative assembly and polishing.
    - Supports `medaka` for polishing; you can specify the model using the appropriate flags.
    - Includes options for `homopolish` integration.
    - Features "polyN" trimming and fractional splitting of contigs.
    - Can split contigs at low-coverage regions to improve assembly quality.
- **virus_term_polish**: Specifically designed for polishing the terminal regions of viral genomes.

### Sequence File Manipulation
- **fq_interleave**: Used to interleave paired-end FASTQ files into a single stream or file.
- **bam2consensus**: Converts BAM alignment files into consensus sequences. This tool is optimized to handle edge cases like low coverage without crashing (e.g., divide-by-zero errors).
- **nano_replay**: Specialized utility for handling Oxford Nanopore data streams or logs.

### Data Optimization
- **shrink_bedgraph**: Reduces the size of bedgraph files by merging adjacent regions with identical or similar coverage values, making them easier to load into genome browsers.

## Expert Tips and Best Practices

- **Alpha Scripts**: The `alpha/` directory in the source contains tools awaiting full documentation or testing. Use these for cutting-edge features (like chunked assemblies) but verify results manually.
- **Runtime Checks**: These tools perform runtime dependency checks. If running in a pipeline, it is best to run the tool once with `--help` in the environment to ensure all underlying Perl modules and binaries are present.
- **Memory Management**: For tools like `minimeta` that perform iterative assemblies, ensure the temporary directory has sufficient space, as it creates multiple intermediate files during the polishing cycles.

## Reference documentation

- [b2b-utils Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_b2b-utils_overview.md)
- [b2b-utils GitHub Repository](./references/github_com_jvolkening_b2b-utils.md)
- [b2b-utils Commit History (Tool Details)](./references/github_com_jvolkening_b2b-utils_commits_master.md)
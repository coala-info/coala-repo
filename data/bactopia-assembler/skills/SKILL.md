---
name: bactopia-assembler
description: The bactopia-assembler transforms raw sequencing reads into assembled bacterial contigs within the Bactopia framework. Use when user asks to assemble draft genomes from short-read data, specify assembly engines like SKESA or SPAdes, or filter contigs by length and coverage.
homepage: https://bactopia.github.io/
metadata:
  docker_image: "quay.io/biocontainers/bactopia-assembler:1.0.4--hdfd78af_0"
---

# bactopia-assembler

## Overview
The `bactopia-assembler` is the core engine responsible for transforming raw sequencing reads into assembled contigs within the Bactopia framework. While Bactopia is a comprehensive pipeline, this specific component focuses on the critical transition from quality-controlled reads to a draft genome. Use this skill to guide the assembly process, ensure compatibility with downstream Bactopia tools (like the Annotator), and implement best practices for bacterial de novo assembly.

## Usage Guidelines

### Installation
The tool is primarily distributed via Bioconda. To set up the environment:
```bash
conda install -c bioconda bactopia-assembler
```

### Core Workflow
The assembler typically follows the "Gather" and "QC" steps in a standard Bactopia run. It is designed to handle:
- **Short-read assembly**: Optimized for Illumina data.
- **Standardization**: Produces outputs that are formatted for seamless integration with `prokka` or `bakta` for annotation.

### Best Practices
- **Input Quality**: Ensure reads have undergone adapter trimming and quality filtering (Bactopia's QC step) before assembly to improve N50 and reduce fragmentation.
- **Resource Management**: Assembly is memory-intensive. When running on a cluster, ensure sufficient RAM is allocated based on the estimated genome size and coverage depth.
- **Integration**: If you intend to use the full Bactopia suite, ensure the output directory structure follows the standard `bactopia/sample-name/` format to allow downstream modules to auto-detect the assembly.

### Common CLI Patterns
While often invoked as part of the larger `bactopia` command, the assembler logic can be targeted by focusing on the assembly-specific parameters:
- Use `--assembler <name>` to specify the underlying engine (e.g., SKESA or SPAdes).
- Use `--min_contig_len` to filter out small, uninformative contigs (default is often 500bp).
- Use `--min_contig_cov` to remove low-coverage artifacts that may represent contamination or sequencing errors.

## Reference documentation
- [Bactopia Introduction](./references/bactopia_github_io_index.md)
- [Anaconda Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bactopia-assembler_overview.md)
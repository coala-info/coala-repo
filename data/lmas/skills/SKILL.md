---
name: lmas
description: LMAS (Last Metagenomic Assembler Standing) is an automated benchmarking workflow designed to evaluate the performance of various prokaryotic de novo assembly tools.
homepage: https://github.com/B-UMMI/LMAS
---

# lmas

---

## Overview

LMAS (Last Metagenomic Assembler Standing) is an automated benchmarking workflow designed to evaluate the performance of various prokaryotic de novo assembly tools. It simplifies the complex task of running multiple assemblers on the same dataset by wrapping them into a single Nextflow-based execution. The tool generates an interactive HTML report that allows users to explore global and reference-specific metrics, helping researchers identify the most effective assembly strategy for their specific metagenomic data.

## Core CLI Usage

The primary way to interact with LMAS is through its command-line interface. The `--fastq` and `--reference` arguments are mandatory for execution.

### Basic Execution
Run the full suite of default assemblers against a set of paired-end reads:
```bash
LMAS --fastq 'data/fastq/*_{1,2}.fastq.gz' --reference 'data/reference/*.fasta'
```

### Selective Benchmarking
By default, LMAS attempts to run all supported assemblers. You can disable specific ones to save time or resources:
```bash
LMAS --fastq 'reads/*_{1,2}.fq' --reference 'ref.fa' --abyss false --unicycler false --skesa false
```

### Customizing Assembler Parameters
Fine-tune the assembly process by passing specific k-mer sizes or configuration strings:
- **MEGAHIT**: `--megahitKmerSize 21,41,61,81,101`
- **metaSPAdes**: `--metaspadesKmerSize '21 33 55'` (Note the space-separated string)
- **ABySS**: `--abyssKmerSize 64 --abyssBloomSize 4G`

## Quality Assessment Parameters

Adjust how LMAS calculates performance metrics to match your project requirements:

- **Minimum Contig Length**: Filter out short, uninformative sequences.
  ```bash
  --minLength 2000
```
- **Mapping Threshold**: Set the minimum percentage of a read that must align to a contig to be considered "mapped."
  ```bash
  --mapped_reads_threshold 0.85
```
- **Target Metrics**: Change the N, NA, NG, or L target values (default is 0.5 for N50, etc.).
  ```bash
  --n_target 0.75 --l_target 0.75
```

## Expert Tips

- **Container Engines**: LMAS relies on Docker, Singularity, or Shifter. Ensure your environment has one of these installed and configured. If you are working in an environment without internet access during runtime, use the provided script to pre-fetch images: `sh pull_images.sh`.
- **Resource Allocation**: Use the `--cpus` flag to prevent the workflow from over-consuming system resources, especially when running multiple assemblers in parallel.
- **Input Patterns**: When using the `--fastq` flag, always use quotes around the path expression (e.g., `'path/*_{1,2}.* '`) to prevent the shell from expanding the glob before it reaches the tool.
- **Metadata Integration**: You can provide a markdown file via `--md` to include custom sample descriptions in the final interactive HTML report.

## Reference documentation
- [LMAS GitHub Repository](./references/github_com_B-UMMI_LMAS.md)
- [LMAS Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_lmas_overview.md)
---
name: neodisambiguate
description: `neodisambiguate` is a high-performance tool designed to resolve the origin of sequencing reads that align to multiple reference genomes.
homepage: https://github.com/clintval/neodisambiguate
---

# neodisambiguate

## Overview
`neodisambiguate` is a high-performance tool designed to resolve the origin of sequencing reads that align to multiple reference genomes. It compares alignment metrics across primary, secondary, and supplementary alignments to determine the most likely source for each template. It is particularly useful in bioinformatics pipelines for Patient-Derived Xenografts (PDX) to separate host (mouse) reads from graft (human) reads.

## Installation
The tool is available via Bioconda. Ensure your conda channels are configured correctly before installation.

```bash
conda install -c bioconda neodisambiguate
```

## Core Usage Patterns

### Basic Disambiguation
To disambiguate a sample aligned to two different references (e.g., Human and Mouse), provide the BAM files and corresponding reference names.

```bash
neodisambiguate \
  -i sample.human.bam sample.mouse.bam \
  -o output_directory \
  -n hg38 mm10
```

### Parameters
- `-i, --input`: Paths to the input BAM/SAM files (one per reference).
- `-o, --output`: Directory where disambiguated BAM files and indices will be written.
- `-n, --names`: (Optional) Descriptive names for the references, matching the order of input files.
- `-a, --algorithm`: (Optional) Specify the disambiguation strategy (defaults to the original AstraZeneca algorithm logic).

## Expert Tips and Best Practices

### Supported Aligners
`neodisambiguate` is validated for use with BAM files produced by:
- `bwa` / `bwa-mem2`
- `minimap2`
- `STAR`

### Sort Order Handling
- **Input**: The tool accepts BAMs in any sort order. However, if the BAM is not already `queryname` sorted, the tool will perform an internal sort. To maximize performance and reduce memory overhead, provide `queryname` sorted BAMs as input.
- **Output**: All generated BAM files will maintain the same sort order as the input files.
- **Known Issue**: Be aware of potential incompatibilities between Picard and Samtools `queryname` sort logic; ensure consistent sorting tools are used across your pipeline.

### Output Structure
The tool creates a structured output directory:
1. **Reference-specific BAMs**: Templates positively assigned to a single source are written to `[output]/[prefix].[name].bam`.
2. **Ambiguous BAMs**: Templates that cannot be confidently assigned are written to a sub-directory: `[output]/ambiguous-alignments/`.

### Data Types
While paired-end data provides the highest discriminatory power for short-read sequencing, `neodisambiguate` natively supports:
- Paired-end reads
- Single-end (fragment) reads
- Mixed pairing data within the same BAM

## Reference documentation
- [neodisambiguate Overview](./references/anaconda_org_channels_bioconda_packages_neodisambiguate_overview.md)
- [neodisambiguate GitHub Repository](./references/github_com_clintval_neodisambiguate.md)
- [Known Issues](./references/github_com_clintval_neodisambiguate_issues.md)
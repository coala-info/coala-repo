---
name: svarp
description: SVarp identifies and resolves haplotype-resolved structural variants within a pangenome graph context using long-read sequencing data. Use when user asks to discover structural variants in a pangenome, generate local assemblies of SV alleles, or perform phased SV discovery using GAF alignments and GFA graphs.
homepage: https://github.com/asylvz/SVarp
---


# svarp

## Overview

SVarp (Pangenome-based structural variant discovery) is a specialized tool designed to identify and resolve structural variants within a pangenome graph context. By utilizing long-read sequencing data, it discovers haplotype-resolved SVs and outputs local assemblies of SV alleles, known as "svtigs." It is particularly effective for resolving complex genomic regions that are often poorly represented in linear reference genomes.

## Installation and Environment

The recommended way to install SVarp is via Bioconda:

```bash
conda create -n svarp -c conda-forge -c bioconda svarp
conda activate svarp
```

Note: SVarp currently supports 64-bit Linux systems only.

## Input Requirements

To ensure successful execution, input files must meet specific formatting standards:
- **Reads**: FASTA files must be bgzipped (e.g., `reads.fasta.gz`).
- **Alignments (GAF)**: Must follow the unstable rGFA coordinate system. Alignments should be generated using the same GFA file provided as input.
- **Graph (GFA)**: The pangenome must be in GFA format.
- **Phasing (Optional)**: Phasing tags should be generated using `WhatsHap` in a `.tsv` format.

## Common CLI Patterns

### Basic SV Discovery
Run a standard discovery workflow using alignments, the graph, and the original reads:
```bash
svarp --gaf sample.gaf --graph pangenome.gfa --fasta reads.fasta.gz --sample SAMPLE1 --out ./output_dir
```

### Phased SV Discovery
To perform haplotype-resolved discovery, provide a WhatsHap haplotag file:
```bash
svarp -a sample.gaf -g pangenome.gfa -f reads.fasta.gz -p read_tags.tsv -i SAMPLE1 -o ./output_dir
```

### High-Performance Phased Run
If you only require phased variants, use the `--skip-untagged` flag to increase processing speed by approximately 30%:
```bash
svarp -a sample.gaf -g pangenome.gfa -f reads.fasta.gz -p read_tags.tsv --skip-untagged -t 32 -o ./output_dir
```

## Parameter Optimization and Tips

- **Thread Management**: Use `-t` or `--threads` to specify the number of threads for assembly and realignment. The default is 32, which is suitable for high-performance computing environments.
- **Minimum Support**: The `--support` parameter (default: 5) defines the minimum number of reads required for a cluster to be assembled. For low-coverage data, you may need to lower this value, while for high-coverage data, increasing it can reduce noise.
- **Breakpoint Merging**: Use `-d` or `--dist_threshold` (default: 100) to adjust the distance threshold for merging SV breakpoints.
- **Extensive Mode**: When using WFA (Wavefront Alignment) realignment, ensure you provide the bgzipped FASTA file via the `-r` or `--reads` flag.
- **Debugging**: If the tool fails or produces unexpected results, use the `--debug` flag to generate multiple log files for detailed troubleshooting.

## Reference documentation
- [SVarp Overview](./references/anaconda_org_channels_bioconda_packages_svarp_overview.md)
- [SVarp GitHub Documentation](./references/github_com_asylvz_SVarp.md)
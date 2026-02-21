---
name: vqbg
description: VQBG (Viral Quasispecies from Bubble Graph) is a specialized genomic assembly tool focused on the recovery of intra-host viral diversity.
homepage: https://github.com/qdu-bioinfo/VQBG
---

# vqbg

## Overview
VQBG (Viral Quasispecies from Bubble Graph) is a specialized genomic assembly tool focused on the recovery of intra-host viral diversity. Unlike standard assemblers that produce a single consensus sequence, VQBG navigates the ambiguities in assembly graphs (bubbles) to reconstruct the distinct genetic variants present in a viral population, such as HIV, HCV, or SARS-CoV-2. It is most effective when provided with a "trunk" or backbone assembly and the original sequencing reads to resolve strain-specific paths.

## Installation
The most reliable way to install VQBG is via Bioconda:
```bash
conda install bioconda::vqbg
```

## Core Usage and CLI Patterns

### Basic Command Structure
The tool requires input reads and a trunk file (the initial assembly graph or backbone).
```bash
VQBG -i <reads_file> -t <trunk_file> [options]
```

### Common Parameters
- `-i`, `--reads`: Path to the input reads (can be specified multiple times for paired-end data).
- `-t`, `--trunk_filename`: The backbone or trunk assembly file (e.g., from FC-Virus).
- `-k`, `--kmer_length`: K-mer size for assembly (default: 25).
- `-q`, `--fastq`: Flag indicating input reads are in FASTQ format.
- `-a`, `--fasta`: Flag indicating input reads are in FASTA format.
- `-o`, `--output_filename`: Name of the resulting assembly file (default: `paths.fasta`).

### Standard Workflow Example
When working with paired-end FASTQ data and a pre-generated trunk file:
```bash
VQBG -k 25 -q -t backbone.fa -i forward.fastq -i reverse.fastq -o reconstructed_strains.fasta
```

## Best Practices and Expert Tips

### 1. Integration with FC-Virus
VQBG is designed to complement the `fc-virus` pipeline. A typical high-resolution workflow involves:
1. Running `fc-virus` to generate the initial assembly and trunk file.
2. Passing that trunk file to `VQBG` along with the raw reads to resolve the quasispecies.

### 2. Handling Paired-End Data
Ensure you use the `-i` flag for each input file. VQBG accepts multiple input sources to maximize the evidence used for path reconstruction through the bubble graph.

### 3. K-mer Selection
While the default k-mer length is 25, users working with high-diversity samples or longer reads may need to adjust this. 
- **Lower K:** Increases sensitivity but may introduce more noise/chimeras in the graph.
- **Higher K:** Increases specificity and helps resolve repeats, but requires higher sequencing depth.

### 4. Input Format Flags
Always explicitly define your input format using `-q` (FASTQ) or `-a` (FASTA). The tool relies on these flags to correctly parse the input stream.

## Reference documentation
- [VQBG Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vqbg_overview.md)
- [VQBG GitHub Repository](./references/github_com_qdu-bioinfo_VQBG.md)
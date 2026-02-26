---
name: abruijn
description: "abruijn is a de novo assembler designed to generate high-quality contigs from long, noisy sequencing reads using a repeat graph approach. Use when user asks to perform de novo assembly of PacBio or Oxford Nanopore reads, assemble metagenomes, or resolve complex genomic repeats."
homepage: https://github.com/fenderglass/ABruijn/
---


# abruijn

## Overview
The `abruijn` tool (now primarily known and maintained as **Flye**) is a specialized de novo assembler designed for single-molecule sequencing (SMS) reads. Unlike traditional de Bruijn graph assemblers that require exact k-mer matches, this tool utilizes a repeat graph constructed from approximate sequence matches. This allows it to handle the high noise and error rates typical of PacBio and ONT data. It functions as a complete pipeline, taking raw reads as input and producing polished, high-quality contigs as output.

## Usage Patterns and Best Practices

### Basic Command Structure
The primary command is `flye`. You must specify the read type, the input files, and an output directory.

```bash
flye --<read-type> <reads.fastq> --out-dir <output_directory> --genome-size <estimated_size>
```

### Supported Read Types
Selecting the correct read type is critical for the assembly algorithm's performance:
- `--nano-raw`: For traditional Oxford Nanopore reads (pre-Guppy5).
- `--nano-hq`: For high-quality ONT reads (Guppy5+ SUP mode or Q20+).
- `--pacbio-raw`: For uncorrected, sub-read PacBio data.
- `--pacbio-hifi`: For PacBio HiFi (CCS) reads.
- `--pacbio-corr`: For PacBio reads that have been pre-corrected.

### Common CLI Options
- `--genome-size (-g)`: Highly recommended. Helps the assembler estimate coverage and resolve repeats. (e.g., `5m` for bacteria, `3g` for human).
- `--threads (-t)`: Number of parallel threads to use.
- `--meta`: Enables metagenome mode for datasets with highly non-uniform coverage and multiple species.
- `--asm-coverage`: For very high-coverage datasets (e.g., >100x), limit the coverage used for the initial assembly to speed up processing (e.g., `--asm-coverage 50`).
- `--iterations (-i)`: Number of polishing iterations (default is 1).

### Expert Tips
- **Repeat Resolution**: Flye is particularly strong at resolving repeats. If the assembly is tangled, ensure you have provided an accurate `--genome-size`.
- **Metagenomics**: When assembling metagenomes, always use the `--meta` flag. This bypasses certain assumptions about uniform coverage that apply to single-isolate genomes.
- **Memory Management**: For mammalian-scale genomes, ensure the system has significant RAM (e.g., 400GB+ for human ONT data).
- **Output Files**:
    - `assembly.fasta`: The final polished contigs.
    - `assembly_graph.gfa`: The final repeat graph; can be visualized in tools like Bandage.
    - `flye.log`: Essential for troubleshooting and checking final assembly statistics (NG50, total length).

## Reference documentation
- [Flye assembler overview](./references/github_com_mikolmogorov_Flye.md)
- [abruijn Bioconda metadata](./references/anaconda_org_channels_bioconda_packages_abruijn_overview.md)
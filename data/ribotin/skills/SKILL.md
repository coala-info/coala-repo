---
name: ribotin
description: ribotin is a specialized bioinformatics tool designed to resolve the repetitive and complex structure of ribosomal DNA.
homepage: https://github.com/maickrau/ribotin
---

# ribotin

## Overview
ribotin is a specialized bioinformatics tool designed to resolve the repetitive and complex structure of ribosomal DNA. It works by extracting rDNA-specific reads using k-mer matches against a reference or by navigating assembly graph topologies. The tool constructs a De Bruijn Graph (DBG) from these reads to generate a high-accuracy consensus. When ultralong ONT reads are provided, ribotin can further phase and assemble highly abundant rDNA morphs, providing a more complete picture of rDNA variation within a genome.

## Installation and Dependencies
The most reliable way to install ribotin is via Conda:
```bash
conda install bioconda::ribotin
```
Ensure the following tools are in your PATH:
- MBG (version 1.0.17 or more recent)
- GraphAligner
- Winnowmap
- samtools
- Liftoff

## Common CLI Patterns

### 1. Reference-Based Assembly
Use `ribotin-ref` when you have raw reads and a known reference or example morph for the species.
```bash
ribotin-ref -x human -i hifi_reads.fa --nano ont_reads.fa -o output_folder
```
- `-x human`: A shortcut for human rDNA parameters.
- `-i`: Input HiFi or Duplex reads (can be used multiple times).
- `--nano`: (Optional) Ultralong ONT reads to enable morph assembly.

### 2. Assembly-Graph Based (Verkko)
Use `ribotin-verkko` after running a whole-genome assembly with Verkko to resolve rDNA tangles.
```bash
ribotin-verkko -x human -i /path/to/verkko_assembly_dir -o output_prefix
```
- The input directory should be the one specified by Verkko's `-d` parameter.

### 3. Assembly-Graph Based (Hifiasm)
Use `ribotin-hifiasm` to extract and assemble rDNA from Hifiasm assembly prefixes.
```bash
ribotin-hifiasm -x human -a /path/to/hifiasm_prefix -i hifi_reads.fa --nano ont_reads.fa -o output_prefix
```

### 4. Handling Non-Human Species
For non-human samples, replace `-x human` with specific morph size estimates and reference files.
```bash
ribotin-ref --approx-morphsize 45000 -r example_morphs.fa -i hifi.fa -o output
```
- `--approx-morphsize`: Estimated size of a single rDNA repeat unit.
- `-r`: A FASTA/FASTQ file containing example morphs or fragments from the same species.

## Expert Tips and Best Practices
- **Morph Orientation**: Use `--orient-by-reference single_morph.fa` to ensure your output consensus matches the orientation and rotation of an existing reference. The file must contain exactly one complete morph.
- **Manual Tangle Selection**: If automatic detection fails in `verkko` or `hifiasm` modes, manually identify rDNA nodes from the GFA file and provide them using the `-c` flag (one file per tangle).
- **Short Morph Species**: If the rDNA morph size is very short (~10kb or less), you can achieve higher accuracy by passing the HiFi reads into the `--nano` parameter instead of ONT reads.
- **Output Interpretation**: The primary results are found in `morphs.fa`, which contains the assembled sequences and their corresponding ONT coverage levels.

## Reference documentation
- [ribotin GitHub Repository](./references/github_com_maickrau_ribotin.md)
- [ribotin Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ribotin_overview.md)
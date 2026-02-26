---
name: muscle
description: Muscle performs high-performance multiple sequence alignment for biological sequences and protein structures. Use when user asks to align sequences, generate alignment ensembles to assess reliability, or perform large-scale protein structure alignment.
homepage: https://github.com/rcedgar/muscle
---


# muscle

## Overview
Muscle (Multiple Sequence Comparison by Log-Expectation) is a high-performance tool for biological sequence alignment. Version 5+ focuses on two primary goals: achieving the highest possible accuracy on benchmarks and providing "alignment ensembles." Unlike tools that provide a single "best" alignment, Muscle can generate multiple alternative alignments to help researchers assess the reliability of downstream results like phylogenetic trees. It also supports Muscle-3D for protein structure alignment.

## Installation
The most common way to install Muscle is via Bioconda:
```bash
conda install bioconda::muscle
```
Alternatively, self-contained binaries are available for Linux, macOS, and Windows.

## Common CLI Patterns

### Basic Sequence Alignment
To align a set of sequences in a FASTA file using default parameters:
```bash
muscle -align sequences.fasta -output alignment.afa
```

### Large Datasets (Thousands of Sequences)
For very large datasets where speed is a priority, use the `-super5` algorithm:
```bash
muscle -super5 sequences.fasta -output alignment.afa
```

### Generating Alignment Ensembles
To generate a set of alternative alignments (replicates) to test the robustness of your analysis:
```bash
muscle -align sequences.fasta -replicates 100 -output ensemble.efa
```
*Note: The `.efa` (Ensemble FASTA) format contains multiple alignments in a single file.*

### Protein Structure Alignment (Muscle-3D)
Structure alignment requires the `reseek` utility to prepare the input "mega" file.

**For up to ~100 structures:**
1. Generate the mega file:
   ```bash
   reseek -pdb2mega STRUCTS_DIR -output structs.mega
   ```
2. Align with Muscle:
   ```bash
   muscle -align structs.mega -output structs.afa
   ```

**For large-scale structure alignment (up to ~10,000):**
1. Convert structures to BCA format:
   ```bash
   reseek -convert STRUCTS_DIR -bca structs.bca
   ```
2. Generate mega file and distance matrix:
   ```bash
   reseek -pdb2mega structs.bca -output structs.mega
   reseek -distmx structs.bca -output structs.distmx
   ```
3. Align using the `super7` algorithm:
   ```bash
   muscle -super7 structs.mega -distmxin structs.distmx -reseek -output structs.afa
   ```

## Expert Tips and Best Practices
- **Input Formats**: Muscle v5 is optimized for standard FASTA. For structure alignment, always use the `reseek` pre-processor to ensure compatibility.
- **Assessing Robustness**: If a phylogenetic tree changes significantly when built from different alignments in an ensemble, the conclusions may not be robust. Use the `-replicates` flag to identify these ambiguities.
- **Memory Management**: While Muscle is scalable, `-super5` is significantly more memory-efficient for datasets exceeding 10,000 sequences compared to the standard `-align` (PPP) algorithm.
- **Output Extensions**: By convention, Muscle uses `.afa` (Aligned FASTA) for single alignments and `.efa` (Ensemble FASTA) for multiple replicates.

## Reference documentation
- [Muscle GitHub Repository](./references/github_com_rcedgar_muscle.md)
- [Bioconda Muscle Package](./references/anaconda_org_channels_bioconda_packages_muscle_overview.md)
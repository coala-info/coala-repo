---
name: sibeliaz
description: SibeliaZ is a high-performance pipeline for whole-genome alignment and the construction of locally collinear blocks across multiple similar genomes. Use when user asks to align multiple genomes, identify conserved regions, generate synteny blocks, or produce alignments in MAF and GFF formats.
homepage: https://github.com/medvedevgroup/SibeliaZ
metadata:
  docker_image: "quay.io/biocontainers/sibeliaz:1.2.7--h9948957_0"
---

# sibeliaz

## Overview
SibeliaZ is a high-performance pipeline designed for whole-genome alignment and the construction of locally collinear blocks. It is optimized for inputs consisting of multiple similar genomes, such as different strains of the same bacterial species or mammalian-sized genomes. The tool identifies conserved regions and outputs their coordinates in GFF format and the actual sequence alignment in MAF format. It is particularly effective for large datasets where traditional aligners might be too slow, provided the sequences are not too divergent.

## Installation
The recommended way to install SibeliaZ is via Bioconda:
```bash
conda install bioconda::sibeliaz
```

## Common CLI Patterns

### Basic Alignment
To align a set of FASTA files and produce both LCB coordinates and a MAF alignment:
```bash
sibeliaz genome1.fa genome2.fa genome3.fa
```
*Note: All input sequences must have unique IDs in their FASTA headers.*

### Coordinate-Only Mode (Fast)
If you only need the block coordinates (GFF) and not the full sequence alignment (MAF), use the `-n` flag. This saves significant time and memory:
```bash
sibeliaz -n -o output_directory genome1.fa genome2.fa
```

### Constructing Synteny Blocks
After running SibeliaZ, you can use the bundled `maf2synteny` tool to generate higher-order synteny blocks:
```bash
maf2synteny sibeliaz_out/blocks_coords.gff
```

## Parameter Optimization

### Sensitivity vs. Performance (-k)
The `-k` parameter sets the k-mer size (must be an odd integer).
- **Bacteria/Small Genomes**: Use `-k 15` for higher sensitivity.
- **Mammals/Large Genomes**: Use `-k 25` (default) to balance memory usage and speed.

### Handling Repeats (-a)
The `-a` parameter controls the vertex frequency threshold to filter out repetitive elements.
- **Recommended Formula**: Set `-a` to $2 \times (\text{max copies of a block}) \times (\text{number of genomes})$.
- **Example**: If aligning 10 genomes where a specific gene is duplicated 4 times, set `-a 80`.
- **Impact**: Setting this too low will cause missing alignments in repetitive regions; setting it too high increases memory consumption and runtime.

## Expert Tips and Constraints
- **Evolutionary Distance**: SibeliaZ is designed for genomes with a distance to the most recent common ancestor not exceeding 0.09 substitutions per site (9 PAM units).
- **Chromosome Limits**: Currently, the tool does not support individual chromosomes longer than 4,294,967,296 bp (4.3 Gb).
- **Memory Management**: The alignment step (producing the MAF file) is extremely memory-intensive. If the process crashes on large datasets, run with `-n` to get the GFF coordinates first, then analyze specific blocks.
- **Failed Alignments**: If certain blocks are too complex to align, SibeliaZ saves them as FASTA files in the `blocks/` subdirectory within the output folder for manual inspection or alternative alignment.

## Reference documentation
- [SibeliaZ Main Documentation](./references/github_com_medvedevgroup_SibeliaZ.md)
- [Bioconda SibeliaZ Package Overview](./references/anaconda_org_channels_bioconda_packages_sibeliaz_overview.md)
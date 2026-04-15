---
name: mace
description: MACE is a bioinformatics pipeline designed to identify high-resolution protein-DNA binding sites from ChIP-exo data using signal preprocessing and border pairing algorithms. Use when user asks to process ChIP-exo sequencing data, normalize replicates, or identify transcription factor binding sites at single-nucleotide resolution.
homepage: http://chipexo.sourceforge.net
metadata:
  docker_image: "quay.io/biocontainers/mace:1.2--py27h99da42f_0"
---

# mace

## Overview
MACE (Model-based Analysis of ChIP-exo) is a specialized bioinformatics pipeline for processing ChIP-exo data. Unlike standard ChIP-seq, ChIP-exo uses exonuclease digestion to create precise "borders" at protein binding sites. MACE leverages these unique properties by using Shannon’s entropy for noise reduction and the Gale-Shapley stable matching algorithm to pair forward and reverse strand borders, providing superior resolution for identifying transcription factor binding sites.

## Core Workflow

### 1. Signal Preprocessing
Use `preprocessor.py` to normalize sequencing depth and consolidate replicates. This step is critical for reducing noise and correcting nucleotide composition bias.

```bash
# Basic preprocessing of multiple replicates
preprocessor.py -i rep1.bam,rep2.bam,rep3.bam -r hg19.chrom.sizes -o output_prefix
```

**Key Parameters:**
- `-m`: Consolidation method. `EM` (Entropy weighted mean) is the default and recommended setting for optimal noise reduction.
- `-d`: Normalization depth. Defaults to 10 million reads to make wiggle files comparable across different experiments.
- `-w`: Kmer size (default 6) for correcting nucleotide composition bias. Set to 0 to disable.
- `-q`: Mapping quality threshold (default 30) to ensure only unique alignments are used.

### 2. Border Detection and Pairing
Use `mace.py` to identify single-base resolution borders and pair them into binding sites.

```bash
# Call peaks/borders from preprocessed BigWig files
mace.py -s hg19.chrom.sizes -f forward_signal.bw -r reverse_signal.bw -o output_prefix
```

**Output Files:**
- `prefix.border_pair.bed`: The final result containing detected border pairs (binding sites).
- `prefix.border.bed`: 1nt resolution single borders (intermediate).
- `prefix.border_pair_elite.bed`: High-confidence pairs used for model estimation.

## Expert Tips
- **Replicate Handling**: Always provide replicates as a comma-separated list to `preprocessor.py`. The tool is specifically designed to consolidate these signals to improve the signal-to-noise ratio (SNR).
- **Visualization**: MACE outputs are compatible with the UCSC Genome Browser. Convert the resulting `.bed` files to `BigBed` and `.wig` files to `BigWig` for efficient remote hosting and viewing.
- **Memory Management**: If running on a machine with limited RAM, decrease the `-b` (bin size) parameter in `preprocessor.py` to process smaller chromosome chunks.
- **Software Requirements**: Ensure `python2.7`, `numpy`, and the `GNU Scientific Library (GSL)` are installed and configured in your environment.



## Subcommands

| Command | Description |
|---------|-------------|
| mace.py | Model based Analysis of ChIP Exo |
| preprocessor.py | Model based Analysis of ChIP Exo |
| wigToBigWig | Convert ascii format wig file (in fixedStep, variableStep or bedGraph format) to binary big wig format. |

## Reference documentation
- [MACE: Model based Analysis of ChIP-exo 1.0 documentation](./references/chipexo_sourceforge_net_index.md)
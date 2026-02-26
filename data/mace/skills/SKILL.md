---
name: mace
description: MACE is a bioinformatics suite designed for high-resolution mapping of protein-DNA interactions from ChIP-exo sequencing data. Use when user asks to preprocess ChIP-exo replicates, normalize sequencing depth, or identify and pair border signals to pinpoint binding sites.
homepage: http://chipexo.sourceforge.net
---


# mace

## Overview

MACE is a specialized bioinformatics suite tailored for the high-resolution mapping of protein-DNA interactions provided by ChIP-exo technology. While standard ChIP-seq tools often struggle with the unique "border" signals created by λ phage exonuclease digestion, MACE utilizes signal consolidation and stable matching algorithms to pinpoint binding sites. It is particularly effective for workflows requiring sequencing depth normalization, nucleotide composition bias correction, and noise reduction using Shannon’s entropy.

## Usage Instructions

### 1. Signal Preprocessing
The `preprocessor.py` script handles normalization and consolidation of biological replicates.

```bash
preprocessor.py -i rep1.bam,rep2.bam,rep3.bam -r hg19.chrom.sizes -o output_prefix -m EM
```

**Key Parameters:**
- `-i`: Comma-separated list of sorted BAM files.
- `-r`: Chromosome sizes file (tab-delimited).
- `-o`: Output prefix for the resulting wiggle files.
- `-m`: Consolidation method. `EM` (Entropy weighted mean) is the recommended default for optimal signal-to-noise ratios. Other options include `AM` (Arithmetic), `GM` (Geometric), and `SNR`.

### 2. Format Conversion
MACE requires BigWig files for the final analysis. If `wigToBigWig` is in your PATH, the preprocessor may attempt conversion; otherwise, perform it manually:

```bash
wigToBigWig output_prefix_Forward.wig hg19.chrom.sizes output_prefix_Forward.bw
wigToBigWig output_prefix_Reverse.wig hg19.chrom.sizes output_prefix_Reverse.bw
```

### 3. Border Detection and Pairing
The `mace.py` script performs the core "border peak" calling and pairs forward/reverse borders to define binding sites.

```bash
mace.py -s hg19.chrom.sizes -f output_prefix_Forward.bw -r output_prefix_Reverse.bw -o final_results
```

**Key Parameters:**
- `-s`: Chromosome sizes file.
- `-f`: Consolidated Forward strand BigWig.
- `-r`: Consolidated Reverse strand BigWig.

### 4. Interpreting Results
The primary output is `prefix.border_pair.bed`. The fourth column (label) indicates the pairing method:
- **GSB**: Gale-Shapley paired Border (highest confidence).
- **SFB**: Single Forward Border (paired based on model).
- **SRB**: Single Reverse Border (paired based on model).

## Best Practices
- **Input Quality**: Ensure BAM files are sorted and indexed (`samtools index`) before running the preprocessor.
- **Environment**: MACE is built for Python 2.7. Ensure your environment has `numpy` and the GNU Scientific Library (GSL) installed.
- **Visualization**: For UCSC Genome Browser visualization, convert the final BED files to BigBed format to handle high-resolution border data efficiently.

## Reference documentation
- [MACE: Model based Analysis of ChIP-exo](./references/chipexo_sourceforge_net_index.md)
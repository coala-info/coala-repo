---
name: emerald
description: EMERALD is a protein sequence aligner that identifies safety windows to quantify alignment reliability across suboptimal paths. Use when user asks to find conserved alignment segments, identify structural cores in protein families, or calculate safety windows for protein clusters.
homepage: https://github.com/algbio/emerald
---


# emerald

## Overview

EMERALD is a specialized protein sequence aligner designed to find "safety windows"—segments of an alignment that remain consistent across a specified proportion ($\alpha$) of all possible suboptimal alignments. Unlike standard aligners that provide a single optimal path, EMERALD quantifies alignment reliability, making it ideal for identifying conserved motifs or structural cores in diverse protein families. It processes FASTA clusters by aligning one representative sequence against all other sequences in the file.

## Installation

The tool is available via Bioconda:
```bash
conda install -c bioconda emerald
```

## Core CLI Usage

### Basic Alignment
To calculate safety windows for a protein cluster using default parameters (α=0.75, Δ=0):
```bash
emerald -f input.fasta -o results.out
```

### Key Parameters
- **Safety Threshold (`-a`, `--alpha`)**: Sets the proportion of suboptimal alignments that must contain the window. Range: $0.5 < \alpha \leq 1$. Default is `0.75`.
- **Suboptimal Space (`-d`, `--delta`)**: An integer defining the size of the suboptimal space. Increasing Δ considers more alignments as "suboptimal," which typically results in fewer and shorter safety windows.
- **Representative Selection (`-r`, `--reference`)**: By default, EMERALD uses the first sequence in the FASTA file as the representative. Use this flag with a unique identifier from the FASTA header to select a different sequence.
- **Threading (`-i`, `--threads`)**: Enable multi-threading for faster processing of large clusters.

### Advanced Configuration
- **Gap Penalties**: Customize the affine-linear gap score using `-g` (gap extension, default -1) and `-e` (gap start, default -11).
- **Substitution Matrix (`-c`, `--costmat`)**: Provide a custom lower triangular matrix file. The amino acid order must be: `Ala Arg Asn Asp Cys Gln Glu Gly His Ile Leu Lys Met Phe Pro Ser Thr Trp Tyr Val`.
- **Window Merging (`-m`, `--windowmerge`)**: Use this to combine intersecting or adjacent safety windows into contiguous blocks in the output.

## Output Format

EMERALD output is structured as follows:
1. Representative sequence description and sequence.
2. Number of aligned pairs.
3. For each pair:
   - Target sequence description and sequence.
   - Number of safety windows found.
   - Window coordinates: $L_0, R_0, L_1, R_1$ (where $[L, R)$ are half-open intervals for the representative and target sequences respectively).

## Expert Tips

- **Output Management**: EMERALD **appends** to the output file rather than overwriting it. If you are running multiple iterations, ensure you delete or rename existing output files to avoid mixing results.
- **Memory/Stability**: If $\alpha$ is set to 0.5 or lower, the tool may display a warning or crash. Always keep $\alpha$ above 0.5 for mathematical validity in the safety window model.
- **Visualization**: For experimental analysis of the alignment space, use `-w {directory}` to generate `.dot` graph files of the suboptimal alignment graph.

## Reference documentation
- [EMERALD GitHub Repository](./references/github_com_algbio_emerald.md)
- [Bioconda EMERALD Overview](./references/anaconda_org_channels_bioconda_packages_emerald_overview.md)
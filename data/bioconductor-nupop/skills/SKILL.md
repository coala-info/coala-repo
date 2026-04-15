---
name: bioconductor-nupop
description: NuPoP predicts nucleosome positioning and occupancy scores using a duration Hidden Markov Model. Use when user asks to predict nucleosome positions, calculate occupancy and binding affinity, or visualize nucleosome maps from DNA sequences.
homepage: https://bioconductor.org/packages/release/bioc/html/NuPoP.html
---

# bioconductor-nupop

## Overview

NuPoP is an R package designed for the prediction of nucleosome positioning. It utilizes a duration Hidden Markov Model (dHMM) where linker DNA length is explicitly modeled. The package provides two primary prediction engines: one trained on MNase-map data and another trained on chemical map data (available for specific species). It outputs Viterbi-optimized nucleosome maps, occupancy scores, and binding affinity scores.

## Core Workflow

### 1. Nucleosome Prediction
Predictions are performed by calling Fortran subroutines that process FASTA files. Note that these functions write output files to the current working directory.

**MNase-based Prediction:**
```r
library(NuPoP)
# species: 7 (S. cerevisiae), model: 4 (4th order Markov chain)
predNuPoP(file="path/to/sequence.fasta", species=7, model=4)
```

**Chemical Map-based Prediction:**
```r
# Recommended for Human, Mouse, S. cerevisiae, and S. pombe
predNuPoP_chem(file="path/to/sequence.fasta", species=7, model=4)
```

### 2. Parameters
- `file`: Absolute path to the FASTA file. Avoid using tilde (`~`) expansion.
- `species`: 
    - 1: Human, 2: Mouse, 3: Rat, 4: Zebrafish, 5: D. melanogaster, 6: C. elegans, 7: S. cerevisiae, 8: C. albicans, 9: S. pombe, 10: A. thaliana, 11: Maize.
    - 0: Automatic (selects species with most similar base composition).
- `model`: 1 or 4 (order of the Markov chain for nucleosome and linker states).

### 3. Reading and Visualizing Results
The prediction functions generate a text file named `[input]_Prediction[model].txt`.

```r
# Read the generated text file
results <- readNuPoP("path/to/sequence.fasta_Prediction4.txt", startPos=1, endPos=5000)

# View the first few rows
head(results)

# Visualize occupancy and start probabilities
plotNuPoP(results)
```

## Interpreting Output
The output dataframe contains five columns:
1. `Position`: Genomic position.
2. `P-start`: Probability that the position is the start of a nucleosome.
3. `Occup`: Nucleosome occupancy score (probability the position is covered by a nucleosome).
4. `N/L`: Viterbi prediction (1 for nucleosome, 0 for linker).
5. `Affinity`: Binding affinity score (defined for 147bp windows; NA for the first/last 73bp).

## Usage Tips
- **File Paths**: Always provide the full system path to the input file to ensure the Fortran backend locates the sequence correctly.
- **Chemical vs MNase**: Use `predNuPoP_chem` for higher resolution predictions in Human, Mouse, Yeast, and S. pombe, as these are trained on base-pair resolution chemical maps.
- **Memory Management**: For very long sequences, use the `startPos` and `endPos` arguments in `readNuPoP` to load specific genomic regions into R memory.

## Reference documentation
- [NuPoP: Nucleosomes Positioning Prediction](./references/NuPoP.md)
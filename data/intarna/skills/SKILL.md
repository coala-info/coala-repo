---
name: intarna
description: IntaRNA predicts the hybridization and interaction sites between two RNA molecules by accounting for sequence complementarity and structural accessibility. Use when user asks to predict RNA-RNA interactions, identify sRNA targets, calculate energy of disclosure, or find suboptimal binding sites.
homepage: https://github.com/BackofenLab/IntaRNA
---

# intarna

## Overview
IntaRNA (Interaction of RNA) is a specialized tool for predicting how two RNA molecules will hybridize. It stands out by calculating the "energy of disclosure" (the energy needed to open local structures in both RNAs) and enforcing a "seed" region to ensure biological relevance. It offers several specialized execution modes (personalities) to emulate other tools or optimize for specific tasks like sRNA target prediction.

## Common CLI Patterns

### Basic Interaction Prediction
To predict the interaction between a target (e.g., mRNA) and a query (e.g., sRNA) using default heuristic settings:
```bash
IntaRNA -t target.fasta -q query.fasta
```

### Using Specialized Personalities
IntaRNA provides several "personalities" that adjust internal parameters for specific use cases:
- **IntaRNAsTar**: Optimized specifically for bacterial sRNA-target prediction.
- **IntaRNAhelix**: Focuses on stable inter-molecular helices.
- **IntaRNAexact**: Performs exact predictions similar to `RNAup`.
- **IntaRNAduplex**: Performs hybrid-only optimization similar to `RNAduplex`.
- **IntaRNAens**: Used for ensemble-based prediction and partition function computation.

Example using the sRNA-target optimized mode:
```bash
IntaRNAsTar -t target.fasta -q query.fasta
```

### Managing Accessibility Data
Calculating accessibility (unpaired probabilities) can be computationally expensive. You can precompute and reuse this data:
- **Save accessibility**: `IntaRNA -t target.fasta -q query.fasta --accFromFile false --outFiles acc.txt` (Note: specific flag usage may vary by version; check `--help` for exact output stream flags).
- **Load accessibility**: Use `--accFromFile` to read precomputed unpaired probabilities from a file to speed up repeated searches.

### Handling Large Sequences
For long sequences where partition function overflows might occur, use sequence-specific scaling:
```bash
IntaRNA -t target.fasta -q query.fasta --tPfScale 1.05 --qPfScale 1.05
```

### Constraining the Interaction
- **Seed Constraints**: Define a specific seed interaction to force the prediction to include a known binding nucleus.
- **Suboptimal Interactions**: To see more than just the Minimum Free Energy (MFE) interaction, use the `--subopts` flag to report multiple potential binding sites.

## Expert Tips
- **Parallelization**: IntaRNA supports OpenMP. Ensure your environment has `OMP_NUM_THREADS` set correctly to utilize multiple cores during genome-wide searches.
- **Window-based Prediction**: For very long target sequences (like full genomes), use window-based prediction modes to limit memory consumption.
- **SHAPE Integration**: If experimental SHAPE reactivity data is available, it can be incorporated to improve the accuracy of the accessibility (ED) calculations.



## Subcommands

| Command | Description |
|---------|-------------|
| intarna_IntaRNA | IntaRNA predicts RNA-RNA interactions. |
| intarna_IntaRNAduplex | IntaRNA predicts RNA-RNA interactions. |
| intarna_IntaRNAens | IntaRNA predicts RNA-RNA interactions. |
| intarna_IntaRNAexact | IntaRNA predicts RNA-RNA interactions. |
| intarna_IntaRNAhelix | IntaRNA predicts RNA-RNA interactions. |
| intarna_IntaRNAsTar | IntaRNA predicts RNA-RNA interactions. |
| intarna_IntaRNAseed | IntaRNA predicts RNA-RNA interactions. |

## Reference documentation
- [IntaRNA Main Documentation](./references/github_com_BackofenLab_IntaRNA.md)
- [IntaRNA README and Overview](./references/github_com_BackofenLab_IntaRNA_blob_master_README.md)
- [IntaRNA ChangeLog (Flag Updates)](./references/github_com_BackofenLab_IntaRNA_blob_master_ChangeLog.md)
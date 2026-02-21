---
name: deepaccess
description: DeepAccess is a specialized deep learning framework designed for genomic sequence analysis.
homepage: https://github.com/gifford-lab/deepaccess-package
---

# deepaccess

## Overview
DeepAccess is a specialized deep learning framework designed for genomic sequence analysis. It enables the training of ensemble models to predict chromatin accessibility across multiple tasks (e.g., different cell types or conditions) and provides robust interpretation tools to understand the sequence features driving those predictions. Use this skill to guide the preparation of genomic regions (BED/FASTA), execute model training with cross-validation/holdout strategies, and perform differential interpretation between experimental conditions.

## Installation and Dependencies
DeepAccess requires `bedtools` (v2.29.2+) to be available in the system PATH for processing BED files.
- **Pip**: `pip install deepaccess`
- **Conda**: `conda install -c bioconda deepaccess`

## Training Models
The `deepaccess train` command builds models from either BED files or FASTA sequences.

### Using BED Files (Recommended for Genomic Regions)
When starting with genomic coordinates, you must provide a reference FASTA and a chromosome sizes file.
```bash
deepaccess train -l CellTypeA CellTypeB \
    -beds cell_a.bed cell_b.bed \
    -ref mm10.fa \
    -g mm10.chrom.sizes \
    -out output_dir \
    -ho chr19 \
    -nepochs 10
```

### Using FASTA Files
If sequences are already extracted, use the `-fa` and `-fasta_labels` arguments.
```bash
deepaccess train -l Task1 Task2 \
    -fa sequences.fa \
    -fasta_labels labels.txt \
    -out output_dir
```

### Expert Tips for Training
- **Holdout Strategy**: Always use the `-ho` (holdout) argument to specify a chromosome (e.g., `chr19`) for validation to prevent overfitting and ensure genomic independence.
- **Outgroup Regions**: Use `-f` (default 0.1) to include a fraction of random genomic regions as a negative "outgroup" set, which helps the model distinguish accessible regions from the genomic background.
- **Reproducibility**: Set a specific seed using `-seed` to ensure deterministic behavior across training runs.

## Interpreting Results
The `deepaccess interpret` command extracts biological insights from trained models.

### Differential Accessibility (DEPE)
To compare the importance of features between two labels (e.g., ASCL1 vs CTCF):
```bash
deepaccess interpret -trainDir output_dir \
    -fastas test_sequences.fa \
    -l ASCL1 CTCF \
    -c ASCL1vsCTCF \
    -evalMotifs default/HMv11_MOUSE.txt
```

### Saliency and Visualization
To generate per-base importance scores and visualize them:
```bash
deepaccess interpret -trainDir output_dir \
    -fastas sequences.fa \
    -saliency \
    -vis
```

### Key Interpretation Parameters
- **-c (Comparisons)**: Define specific contrasts. `C1,C2vsC3` runs differential analysis for the combination of C1 and C2 against C3.
- **-evalMotifs**: Provide a PWM/PCM database to map learned patterns to known transcription factor binding sites.
- **-subtract**: By default, DeepAccess uses ratios for Expected Prediction Effect (EPE). Use `-subtract` to use the difference instead.

## Reference documentation
- [DeepAccess Package Overview](./references/github_com_gifford-lab_deepaccess-package.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_deepaccess_overview.md)
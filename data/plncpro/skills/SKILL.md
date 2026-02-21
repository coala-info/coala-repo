---
name: plncpro
description: PlncPRO (Plant Long Non-Coding RNA Prediction by Random Forests) is a machine learning tool designed to distinguish between coding (mRNA) and long non-coding (lncRNA) transcripts.
homepage: https://github.com/urmi-21/PLncPRO
---

# plncpro

## Overview

PlncPRO (Plant Long Non-Coding RNA Prediction by Random Forests) is a machine learning tool designed to distinguish between coding (mRNA) and long non-coding (lncRNA) transcripts. It utilizes Random Forest classifiers based on protein homology search, sequence-based features, and 3-mer frequency patterns. This skill provides the necessary procedural knowledge to build custom models, run predictions on unknown sequences, and extract high-confidence transcripts for downstream analysis.

## Core Workflows

### 1. Predicting lncRNAs
Use the `predict` command to classify sequences in a FASTA file. This requires a pre-built model and a BLAST database for homology features.

```bash
plncpro predict -i <input.fasta> -o <output_dir> -p <prefix> -m <model_file> -d <blast_db> -t <threads>
```

**Key Parameters:**
- `-i`: Input FASTA file.
- `-o`: Directory for output files.
- `-p`: Filename prefix for the prediction results.
- `-m`: Path to the `.p` model file.
- `-d`: Path to the BLAST database (e.g., UniProt or specialized plant protein DB).
- `-t`: Number of threads (default is 4).

### 2. Building Custom Models
If existing models are not suitable for your specific species, train a new one using known mRNA (positive) and lncRNA (negative) datasets.

```bash
plncpro build -p <mrna.fasta> -n <lncrna.fasta> -o <out_dir> -m <model_name> -d <blast_db>
```

**Optimization Tips:**
- Use at least 1000 trees (default) for stable results.
- Ensure the BLAST database used during building is the same one used during prediction.
- Use `--min_len` to filter out short transcripts that might introduce noise into the model.

### 3. Extracting Sequences
After prediction, use `predtoseq` to isolate specific classes (lncRNA or mRNA) based on the classifier's confidence.

```bash
plncpro predtoseq -f <original.fasta> -p <prediction_file> -o <output.fasta> -l 0 -s 0.9
```

**Filtering Logic:**
- `-l 0`: Extracts lncRNAs (default).
- `-l 1`: Extracts mRNAs.
- `-s 0.9`: Only extracts sequences with a probability score $\ge$ 0.9 (high confidence).

## Expert Tips and Best Practices

### Accelerating with Diamond
Standard `blastx` can be slow for large transcriptomes. You can use Diamond as a drop-in replacement by pre-calculating the alignment and passing the result to PlncPRO.

1. **Run Diamond:**
   ```bash
   diamond blastx -d <diamondDB> -q <query.fasta> -o <diamond_out> --outfmt 6 qseqid sseqid pident evalue nident qcovhsp score bitscore qframe qstrand
   ```
2. **Run PlncPRO with pre-calculated results:**
   ```bash
   plncpro predict -i <input.fasta> -o <out> -p <preds> --blastres <diamond_out> -m <model>
   ```

### Handling BLAST Results
If you have existing BLAST results, you can skip the internal BLAST step using `--blastres` (for `predict`) or `--pos_blastres` and `--neg_blastres` (for `build`). The input must follow this specific format:
`-outfmt '6 qseqid sseqid pident evalue qcovs qcovhsp score bitscore qframe sframe'`

### Feature Control
- **No BLAST:** If no protein database is available or you want a purely sequence-based prediction, use the `--noblast` flag. Note that this typically reduces accuracy.
- **No FrameFinder:** Use `--no_ff` to disable FrameFinder features if necessary.

## Reference documentation
- [Main Documentation and CLI Usage](./references/github_com_urmi-21_PLncPRO.md)
- [Installation and Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_plncpro_overview.md)
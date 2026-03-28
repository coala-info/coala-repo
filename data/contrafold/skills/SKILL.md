---
name: contrafold
description: CONTRAfold predicts RNA secondary structures using a discriminative training approach based on conditional random fields. Use when user asks to predict RNA folding, generate base pair posterior probabilities, apply structural constraints, or train new model parameters from known structures.
homepage: http://contra.stanford.edu/contrafold/faq.html
---


# contrafold

## Overview
CONTRAfold is a specialized tool for RNA secondary structure prediction that utilizes discriminative training (Conditional Random Fields) rather than traditional thermodynamic energy parameters. This skill enables the execution of prediction tasks, extraction of posterior probabilities for base pairs, and the application of structural constraints. It is particularly effective when probabilistic confidence scores are required for structural motifs.

## Prediction Workflows

### Basic Folding
Predict the structure of a single sequence in FASTA or plain text format.
```bash
contrafold predict sequence.fasta
```

### Generating Specific Output Formats
CONTRAfold supports multiple output types simultaneously.
- **Parenthesized (Dot-bracket)**: `--parens output.dot`
- **BPSEQ (Columnar)**: `--bpseq output.bpseq`
- **Posteriors**: `--posteriors <threshold> output.post` (Exports pairs with probability > threshold)

Example for multiple outputs:
```bash
contrafold predict seq.fasta --parens seq.dot --bpseq seq.bpseq --posteriors 0.01 seq.post
```

### Batch Processing
When providing multiple input files, specify an output directory. CONTRAfold will create the directory and populate it with results using the original filenames.
```bash
contrafold predict seq1.fasta seq2.fasta seq3.fasta --parens results_dir
```

## Advanced Prediction Options

### Sensitivity vs. Specificity (Gamma)
Adjust the $\gamma$ parameter to trade off between sensitivity (finding all true pairs) and specificity (avoiding false positives).
- **High Sensitivity**: Use $\gamma > 1$ (e.g., `--gamma 4`)
- **High Specificity**: Use $0 \le \gamma \le 1$ (e.g., `--gamma 0.5`)
- **Default**: $\gamma = 6$

### Constrained Folding
To force specific bases to be paired or unpaired, use a BPSEQ file as input with the `--constraints` flag.
- In the BPSEQ input: `0` means forced unpaired, `-1` means unconstrained, and a positive index `j` forces a pair with position `j`.
```bash
contrafold predict constraints.bpseq --constraints
```

### Algorithms
- **Maximum Expected Accuracy (Default)**: Recommended for highest accuracy.
- **Viterbi**: Use `--viterbi` for the single most likely parse (faster, but often less accurate).
- **Non-canonical Pairs**: Use `--noncomplementary` to allow pairs other than AU, CG, and GU.

## Training and Evaluation

### Model Training
Train new parameters from known structures (BPSEQ format). Use `--holdout` to prevent overfitting via cross-validation.
```bash
contrafold train --holdout 0.25 data/*.bpseq
```

### Log Partition Function
Calculate the "energy" or log-sum of structures for a sequence.
```bash
contrafold predict seq.fasta --partition
```



## Subcommands

| Command | Description |
|---------|-------------|
| contrafold predict | Predict RNA secondary structures using the CONTRAfold algorithm. |
| contrafold_train | Train CONTRAfold models using provided sequence and structure data. |

## Reference documentation
- [CONTRAfold 2.02 User Manual](./references/contra_stanford_edu_contrafold_manual_v2_02.pdf.md)
- [CONTRAfold FAQ](./references/contra_stanford_edu_contrafold_faq.html.md)
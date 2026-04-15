---
name: consan
description: Consan performs pairwise RNA structural alignment by simultaneously predicting and aligning secondary structures using stochastic context-free grammars. Use when user asks to align two RNA sequences based on structural conservation, train new structural alignment models from Stockholm files, or compare predicted alignments against reference structures.
homepage: http://eddylab.org/software/consan/
metadata:
  docker_image: "quay.io/biocontainers/consan:1.2--h7b50bb2_7"
---

# consan

## Overview
Consan is a specialized tool for pairwise RNA structural alignment. Unlike traditional sequence-only aligners, Consan uses a pairwise stochastic context-free grammar to simultaneously predict and align RNA secondary structures. It is particularly effective for identifying conserved structural elements in divergent sequences. It supports both full (unconstrained) alignment and a faster "constrained" mode using alignment pins to reduce the computational search space.

## Core Workflows

### 1. Structural Alignment of Two Sequences
Use `sfold` to align two RNA sequences in FASTA format using a pre-trained model.

```bash
sfold -m model.mod seq1.fa seq2.fa
```

### 2. Training a New Model
Use `strain_ml` to generate a model parameter file from a set of structural alignments in Stockholm format.

```bash
strain_ml -s my_model.mod training_set.stk
```

### 3. Alignment Comparison and Evaluation
Use `scompare` to align two sequences and immediately compare the result to a known reference alignment provided in a Stockholm file.

```bash
scompare -m model.mod reference_alignment.stk
```

## Expert Tips and Best Practices

### Managing Resource Intensity
Consan is computationally expensive ($N^6$ time and $N^4$ memory complexity). 
- **Use Constraints**: By default, Consan uses a constrained version of the Sankoff algorithm. This is significantly faster than the full version (`-f`).
- **Adjust Posterior Cutoffs**: Use `-Z <float>` to change the posterior probability cutoff for alignment pins (default is 0.95). Higher values increase speed but may reduce sensitivity.
- **Window Size**: Use `-W <int>` to adjust the protection window around pins (default is 20).

### Handling Stockholm Files
Consan relies heavily on the Stockholm 1.0 format.
- Ensure your input files include the `# STOCKHOLM 1.0` header and the `//` terminator.
- For single sequence annotation, Consan uses `#=GR <seqname> SS` for secondary structure.
- For consensus structure in alignments, it uses `#=GC SS_cons`.
- Structure notation uses `<` and `>` to indicate base pairing.

### Parallelization Warning
Consan uses a temporary file mechanism in `src/tmp/` that is not thread-safe for simultaneous runs on the same machine. If running in a cluster environment, ensure each process points to a unique local scratch directory or unique path to avoid file collisions.

### Evaluation Pipeline
To reproduce results from the Consan literature:
1. Reformat to WUSS notation using `sreformat --wuss`.
2. Compare structures using `compstruct`.
3. Generate bootstrap statistics using `bstats` on the comparison output.



## Subcommands

| Command | Description |
|---------|-------------|
| mltrain | Train models for consan_strain using training set files. |
| scompare | Given a MSA, calculate foldings for all pairs. Output two files -- predicted pairs to stdout and given pairs to a required -s file. |
| sfold | Structural folding and alignment tool for sequences using parameters, grammar, and scoring models. |

## Reference documentation
- [Consan README](./references/eddylab_org_software_consan_README.md)
- [Consan Paper Guide](./references/eddylab_org_software_consan_paperguide.txt.md)
- [Consan Installation and Notes](./references/eddylab_org_software_consan_notes.txt.md)
---
name: pbsim2
description: pbsim2 is a simulator designed for long-read sequencing technologies.
homepage: https://github.com/yukiteruono/pbsim2
---

# pbsim2

## Overview

pbsim2 is a simulator designed for long-read sequencing technologies. It improves upon the original PBSIM by introducing a generative model for quality scores based on Factorised Information Criteria Hidden Markov Models (FIC-HMM). This allows for the simulation of reads that closely mimic the non-uniform quality and error distributions found in real PacBio and Nanopore data.

Use this skill when you need to:
- Generate synthetic long reads with specific coverage depths.
- Simulate reads based on specific sequencing chemistries (e.g., PacBio P6C4).
- Mimic the characteristics of an existing FASTQ dataset using sampling-based simulation.
- Introduce sequencing errors into specific template sequences.

## Common CLI Patterns

### Model-Based Simulation
Generates reads using built-in HMM models to determine read length, accuracy, and quality scores.
```bash
pbsim --depth 20 --hmm_model data/P6C4.model reference.fasta
```

### Sampling-Based Simulation
Uses a real dataset to determine the length and quality score distributions.
```bash
pbsim --depth 20 --sample-fastq real_reads.fastq reference.fasta
```

### Template-Based Error Simulation
Introduces errors into specific sequences without random sampling from a genome.
```bash
pbsim --template-fasta templates.fasta --hmm_model data/P6C4.model
```

### Efficient Re-sampling
When running multiple simulations with different depths using the same real dataset, use profile IDs to avoid re-parsing the FASTQ:
```bash
# First run: create profile
pbsim --depth 20 --prefix d20 --sample-fastq real.fastq --sample-profile-id pf1 ref.fasta

# Subsequent runs: reuse profile
pbsim --depth 50 --prefix d50 --sample-profile-id pf1 ref.fasta
```

## Expert Tips and Best Practices

- **Output Management**: By default, pbsim2 uses the prefix `sd`. Always use the `--prefix` option to organize outputs when running multiple iterations (e.g., `--prefix experiment_v1`).
- **Multi-FASTA Handling**: If the input reference is a multi-FASTA file, pbsim2 generates a separate set of output files (`.ref`, `.fastq`, `.maf`) for every sequence in the file.
- **Error Type Ratios**: You can fine-tune the ratio of substitutions, insertions, and deletions using the `--difference-ratio` option if the default model behavior does not match your specific experimental needs.
- **Memory Considerations**: Memory usage is approximately the size of the reference sequence plus a few megabytes. For very large genomes, ensure the environment has sufficient RAM to load the entire reference into memory.
- **Quality Score Standards**: Ensure input FASTQ files for sampling-based simulation are in Sanger standard (fastq-sanger) format.
- **Model Selection**: The `data/` directory in the pbsim2 installation contains various `.model` files. Choose the model that most closely matches the chemistry of the sequencer you are trying to emulate.

## Reference documentation
- [PBSIM2 GitHub Repository](./references/github_com_yukiteruono_pbsim2.md)
- [Bioconda pbsim2 Package](./references/anaconda_org_channels_bioconda_packages_pbsim2_overview.md)
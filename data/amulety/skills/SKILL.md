---
name: amulety
description: amulety generates high-dimensional embeddings for BCR and TCR sequences using pre-trained immunological language models. Use when user asks to convert immune receptor sequences into embeddings, apply models like AntiBERTa2 or AbLang to AIRR data, or translate nucleotide sequences to amino acids using IgBlast.
homepage: https://github.com/immcantation/amulety
metadata:
  docker_image: "quay.io/biocontainers/amulety:2.1.2--pyh6d73907_0"
---

# amulety

## Overview

amulety (Adaptive imMUne receptor Language model Embedding tool for TCR and antibodY) is a specialized CLI tool within the Immcantation framework. It streamlines the process of applying pre-trained language models to immunological data. The tool is essential for researchers who need to convert BCR/TCR sequences into high-dimensional embeddings that capture structural and functional properties, supporting models like AntiBERTa2, AbLang, and Immune2Vec. It also provides utility for translating nucleotide sequences to amino acids via IgBlast integration.

## Installation and Setup

The recommended installation method is via Conda to ensure all dependencies, including IgBlast, are correctly configured:

```bash
conda install -c conda-forge -c bioconda amulety --strict-channel-priority
```

**Note on Python Versions:** If you require the `ablang` model, you must use Python < 3.14 (e.g., Python 3.13), as the underlying `numba` dependency does not yet support newer versions.

## Common CLI Patterns

### Generating Embeddings
The primary command is `amulety embed`. You must specify the input file (AIRR format), the receptor chain, and the desired model.

```bash
amulety embed \
  --input-airr sequences.tsv \
  --chain H \
  --model antiberta2 \
  --output-file-path embeddings.tsv \
  --cache-dir ./model_cache
```

### Translation with IgBlast
If starting from nucleotide sequences, use the translation utility before embedding:

```bash
amulety igblast-translate \
  --input-airr nucleotide_sequences.tsv \
  --output-file-path translated_sequences.tsv
```

## Tool-Specific Best Practices

- **Chain Specification:** Always ensure the `--chain` argument matches your data (e.g., `H` for Heavy chain, `L` for Light chain, or TCR-specific chains).
- **Caching:** Use the `--cache-dir` flag to specify a persistent directory for downloaded models. This prevents redundant downloads and speeds up execution in restricted network environments.
- **Input Format:** amulety expects AIRR-compliant TSV files. Ensure your input columns (like `sequence_alignment_aa`) follow the AIRR Rearrangement schema.
- **Model Selection:**
    - Use `antiberta2` or `ablang` for antibody-specific (BCR) tasks.
    - Use `tcrt5` for T-cell receptor tasks.
    - Use `immune2vec` for general immune receptor embeddings.
- **Docker Execution:** For consistent environments, use the official container:
  `docker run -itv $(pwd):$(pwd) -w $(pwd) immcantation/amulety amulety [args]`

## Troubleshooting

- **Command Not Found:** If installed via Conda and the command is missing, ensure Python is explicitly in the environment: `conda install python amulety`.
- **AbLang Errors:** If you encounter an `ImportError` when using `--model ablang`, check your Python version. AbLang is automatically disabled on Python 3.14+.
- **Output Directories:** Ensure the destination directory for `--output-file-path` exists before running the command to avoid write errors.

## Reference documentation
- [amulety GitHub Repository](./references/github_com_immcantation_amulety.md)
- [amulety Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_amulety_overview.md)
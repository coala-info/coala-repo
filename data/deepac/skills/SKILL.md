---
name: deepac
description: DeePaC is a deep learning framework designed to classify short DNA reads as pathogenic or non-pathogenic using reverse-complement neural networks. Use when user asks to predict pathogenicity from sequencing data, train or evaluate classification models, preprocess genomic reads, or perform interpretability analysis to identify pathogenic motifs.
homepage: https://gitlab.com/rki_bioinformatics/DeePaC
---


# deepac

## Overview
DeePaC (Deep Learning for Pathogenicity Prediction) is a specialized framework designed to classify short DNA reads—typically from next-generation sequencing (NGS)—into categories such as pathogenic or non-pathogenic. It utilizes reverse-complement neural networks to ensure that the biological complementarity of DNA is respected during training and inference. The toolset is modular, supporting everything from initial data preparation and model fetching to advanced interpretability analysis that identifies specific genomic features driving the model's predictions.

## Core CLI Workflows

### Model Management
Instead of training from scratch, use the built-in utility to download pre-trained models for specific pathogens or environments.
- **Fetch pre-trained models**: `deepac fetch`
- **Note**: Recent versions support loading both `.h5` and `.keras` model formats.

### Data Preparation
Prepare your raw sequencing data (FASTA/FASTQ) for the neural network.
- **Preprocess reads**: `deepac preproc`
- **Trimming**: Use the `--trim` flag during preprocessing to handle variable read lengths or quality issues.
- **Simulation**: Generate synthetic Illumina or Nanopore reads for benchmarking using `deepac simulate`.

### Training and Evaluation
- **Train a model**: `deepac train`
- **Evaluate performance**: `deepac eval`
- **Tip**: Use the `--thresh` flag in evaluation to adjust the classification threshold for sensitivity/specificity tuning.

### Prediction and Filtering
- **Run inference**: `deepac predict`
- **Filter results**: Use `deepac filter` to separate reads based on prediction scores. You can explicitly output negative and undefined classifications for further analysis.

### Interpretability and GWPA
To understand *why* a read was classified as pathogenic, use the explainability suite.
- **Explain predictions**: `deepac explain` (supports SHAP values for feature importance).
- **Genomic Wide Phenotype Association**: `deepac gwpa` to map predictions back to genomic coordinates and identify pathogenic motifs.

## Expert Tips
- **Reverse Complement Symmetry**: DeePaC models are designed to be RC-invariant. When using custom architectures, ensure they maintain this symmetry to avoid biased predictions based on strand orientation.
- **Memory Management**: If encountering `ContentTooShortErrors` during model fetching, check your network stability or manually download models from the repository.
- **Multiprocessing**: If experiencing issues with temporary files or hangs during `gene_rank` or `explain` tasks, consider disabling multiprocessing or checking `pybedtools` temporary directory configurations.
- **Input Shapes**: Ensure your input read lengths match the expected input shape of the model (e.g., 250bp). Use the trimming flags in `preproc` if your data is longer than the model's training length.



## Subcommands

| Command | Description |
|---------|-------------|
| deepac convert | Convert a trained deepac model to a format suitable for inference. |
| deepac eval | Evaluate deep-AC models. |
| deepac filter | Filter predictions based on thresholds and classes. |
| deepac test | Test the deepac tool |
| deepac train | Train a deep learning model for DNA classification. |
| deepac_explain | DeePaC explain subcommands. See command --help for details. |
| deepac_getmodels | Rebuilds or fetches deep learning models for deep-AMR. |
| deepac_predict | Predicts the presence of bacteriophages in DNA sequences. |
| gwpa | DeePaC gwpa subcommands. See command --help for details. |
| preproc | Preprocessing config file. |

## Reference documentation
- [DeePaC README](./references/gitlab_com_rki_bioinformatics_DeePaC_-_blob_master_README.md)
- [DeePaC Changelog](./references/gitlab_com_rki_bioinformatics_DeePaC_-_blob_master_CHANGELOG.md)
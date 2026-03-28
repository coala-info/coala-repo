---
name: instanovo
description: InstaNovo is a deep learning framework that performs de novo peptide sequencing from tandem mass spectrometry data using a transformer-based architecture. Use when user asks to predict amino acid sequences from spectral peaks, refine predictions with diffusion models, evaluate model performance against ground truth, or train custom models on proteomics data.
homepage: https://github.com/instadeepai/instanovo
---

# instanovo

## Overview
InstaNovo is a specialized deep learning framework designed for the automated interpretation of tandem mass spectrometry (MS/MS) data. It utilizes a transformer-based architecture to perform *de novo* sequencing, converting spectral peaks directly into amino acid sequences without the need for a reference database. This tool is essential for proteomics researchers identifying novel peptides, analyzing non-model organisms, or refining sequence predictions using the diffusion-powered InstaNovo+ model.

## Core Workflows

### Making Predictions
The primary interface for sequencing is the `instanovo predict` command.

- **Standard Inference**:
  Run basic sequencing by providing a model checkpoint and a spectra file (e.g., MGF or mzML).
  `instanovo predict --model_path path/to/checkpoint.ckpt --data_path spectra.mgf --output_path results.csv`

- **InstaNovo+ (Diffusion Refinement)**:
  To enable iterative refinement of predicted sequences for higher accuracy, use the diffusion flag.
  `instanovo predict --model_path path/to/checkpoint.ckpt --data_path spectra.mgf --output_path results.csv --use_diffusion`

- **Optimization**:
  Adjust `--batch_size` to fit your GPU memory and `--num_workers` for data loading efficiency.

### Performance Evaluation
To benchmark predictions against a ground truth dataset:
`instanovo evaluate --data_path results.csv --target_column target_sequence --prediction_column predicted_sequence`

### Model Training
To train a custom model on specific proteomics data:
`instanovo train --config_path path/to/config.yaml`

## Expert Tips and Best Practices

- **Input Preparation**: While InstaNovo supports multiple formats, `.mgf` and `.mzML` are the most common. Ensure your data is centroided for optimal performance.
- **Handling Modifications**: Always check the supported Post-Translational Modifications (PTMs). If your sample contains specific modifications (e.g., Oxidation or Carbamidomethylation), ensure they are defined in your configuration or command-line arguments.
- **Confidence Filtering**: The output CSV includes confidence metrics. For large-scale experiments, it is best practice to filter results based on the `log_probs` or sequence-level confidence scores to reduce false discovery rates.
- **Hardware**: For InstaNovo+, a high-performance GPU is strongly recommended due to the iterative nature of the diffusion refinement process.



## Subcommands

| Command | Description |
|---------|-------------|
| instanovo convert | Convert data to SpectrumDataFrame and save as *.parquet file(s). |
| instanovo predict | Run predictions with InstaNovo and optionally refine with InstaNovo+. First with the transformer-based InstaNovo model and then optionally refine them with the diffusion based InstaNovo+ model. |

## Reference documentation
- [CLI Reference](./references/instadeepai_github_io_InstaNovo_reference_cli.md)
- [Predicting Guide](./references/instadeepai_github_io_InstaNovo_how-to_predicting.md)
- [Modifications](./references/instadeepai_github_io_InstaNovo_reference_modifications.md)
- [Tutorials: Getting Started](./references/instadeepai_github_io_InstaNovo_tutorials_getting_started.md)
- [Prediction Output Schema](./references/instadeepai_github_io_InstaNovo_reference_prediction_output.md)
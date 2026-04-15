---
name: mavenn
description: MAVE-NN constructs predictive models that map genetic sequences to functional phenotypes by treating genotype-phenotype map inference as an information compression problem. Use when user asks to implement Global Epistasis regression for continuous phenotypes, perform Measurement Process Agnostic regression for binned data, or visualize sequence-function relationships using heatmaps.
homepage: http://mavenn.readthedocs.io
metadata:
  docker_image: "quay.io/biocontainers/mavenn:1.1.3--pyhdfd78af_0"
---

# mavenn

## Overview
The `mavenn` skill enables the construction of predictive models that map genetic sequences to functional phenotypes. It treats G-P map inference as an information compression problem, utilizing a TensorFlow backend to train models that account for both the underlying biophysics of the sequence and the noise characteristics of the experimental assay. Use this skill to implement Global Epistasis (GE) regression for continuous phenotypes or Measurement Process Agnostic (MPA) regression for binned/sorted data.

## Core Workflows

### Model Initialization
To create a model, define the G-P map type and the measurement process.
- **G-P Map Types**: `additive`, `neighbor`, `pairwise`, or `blackbox`.
- **Regression Types**: 
    - `ge`: For continuous values (e.g., DMS enrichment scores).
    - `mpa`: For discrete bins (e.g., Sort-seq data).

```python
import mavenn
# Example: Initializing a GE regression model with an additive G-P map
model = mavenn.Model(regression_type='ge', 
                     L=sequence_length, 
                     alphabet='dna', 
                     gp_map_type='additive')
```

### Training Best Practices
- **Data Splitting**: Always split data into training, validation, and test sets to monitor for overfitting.
- **Noise Models**: For GE regression, choose a noise model that matches your data distribution: `Gaussian`, `Cauchy`, or `Skewed-t` (useful for outliers or asymmetric noise).
- **Gauge Fixing**: MAVE-NN models have inherent "gauge" freedoms. Use `model.fix_gauge()` after training to ensure parameters are interpretable and comparable across models.

### Visualization and Evaluation
- **Heatmaps**: Use `mavenn.heatmap()` to visualize additive parameters and `mavenn.heatmap_pairwise()` for epistatic interactions.
- **Information Metrics**: Evaluate model performance using `predictive_information` (I_pred) rather than just R-squared, as it provides a more robust measure of how much experimental variation the model captures.

## Expert Tips
- **Custom G-P Maps**: For protein modeling, you can define custom biophysical G-P maps by passing a specific functional form to the `Model` class.
- **Pre-built Datasets**: Use `mavenn.load_example_dataset()` to benchmark your pipeline against standard datasets like `gb1` (protein), `sortseq` (regulatory), or `mpsa` (splicing).
- **Diffeomorphic Modes**: Be aware that nonlinearities in the GE process can "stretch" the G-P map. Use the built-in methods to fix diffeomorphic modes if you require absolute scale consistency.

## Reference documentation
- [MAVE-NN Documentation Overview](./references/mavenn_readthedocs_io_en_v1_1_3.md)
- [Bioconda Package Metadata](./references/anaconda_org_channels_bioconda_packages_mavenn_overview.md)
---
name: basenji
description: Basenji is a deep learning framework designed to model the relationship between DNA sequences and their regulatory activity across long, chromosome-scale distances.
homepage: https://github.com/calico/basenji
---

# basenji

## Overview
Basenji is a deep learning framework designed to model the relationship between DNA sequences and their regulatory activity across long, chromosome-scale distances. It enables researchers to predict quantitative signals like chromatin accessibility and gene expression directly from sequence data. Beyond standard regulatory predictions, the toolkit includes "Akita" for predicting 3D genome contact maps (Hi-C) and "Saluki" for modeling mRNA stability. Use this skill to guide the preprocessing of genomic tracks, model training, and in silico mutagenesis for variant effect prediction.

## Installation and Environment
Basenji requires TensorFlow and specific environmental configurations to function correctly.

- **Conda Installation**: `conda install -c bioconda basenji`
- **Environment Variables**: Ensure the following are set to access the binary scripts:
  ```bash
  export BASENJIDIR=~/code/Basenji
  export PATH=$BASENJIDIR/bin:$PATH
  export PYTHONPATH=$BASENJIDIR/bin:$PYTHONPATH
  ```

## Common CLI Workflows

### 1. Data Preprocessing
Before training, raw genomic data (BAM/BigWig) must be converted into HDF5 format.
- **Generate coverage tracks**: Use `bam_cov.py` to process BAM files into coverage profiles.
- **Create HDF5 datasets**: Use `basenji_hdf5_single.py` for single-machine processing or `basenji_hdf5_cluster.py` for distributed environments.
- **Gene-specific datasets**: Use `basenji_hdf5_genes.py` when the focus is on specific TSS (Transcription Start Site) locations.

### 2. Training and Testing
- **Train a model**: `basenji_train.py [options] <params_file> <data_dir>`
  - The `<params_file>` is typically a JSON file defining the architecture and hyperparameters.
- **Evaluate accuracy**: `basenji_test.py [options] <model_file> <data_dir>`
  - Use `basenji_test_genes.py` to evaluate performance specifically at gene coordinates.

### 3. Variant Effect Prediction
One of Basenji's most powerful features is scoring the impact of SNPs on regulatory activity.
- **SNP Activity Difference (SAD)**: Use `basenji_sad.py` to calculate how a variant changes the predicted regulatory signal across the sequence.
- **SNP Expression Difference (SED)**: Use `basenji_sed.py` to predict the specific change in expression for a target gene.
- **VCF Mutagenesis**: Use `basenji_sat_vcf.py` to perform saturated mutagenesis around variants provided in a VCF file.

### 4. Regulatory Element Analysis
- **In silico Saturated Mutagenesis**: `basenji_sat.py` allows you to mutate every nucleotide in a sequence to identify functional motifs.
- **Motif Discovery**: `basenji_motifs.py` helps visualize and identify the sequence motifs the model has learned.
- **Contribution Maps**: `basenji_map.py` generates maps of which sequence regions contribute most to a specific prediction.

## Expert Tips
- **Binning Strategy**: Basenji makes predictions in "bins" across the sequence. For high-resolution classification tasks similar to Basset, use smaller sequences and aggregate the target signal for the entire sequence.
- **Regression vs. Classification**: Unlike many earlier tools that use binary classification (peak vs. no-peak), Basenji is optimized for regression to predict quantitative signal intensity.
- **Memory Management**: When working with Akita for 3D genome folding, contact maps can become extremely sparse and large. Ensure you have sufficient GPU memory or use the `--multi_gpu` flags if available in your environment.
- **NaN Handling**: If you encounter NaNs during training (especially with Akita), check for sparse near-zero matrices in your input data or adjust the learning rate in your parameters file.

## Reference documentation
- [Basenji GitHub Repository](./references/github_com_calico_basenji.md)
- [Bioconda Basenji Package Overview](./references/anaconda_org_channels_bioconda_packages_basenji_overview.md)
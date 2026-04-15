---
name: mlpy
description: mlpy is a high-performance Python library for machine learning that provides efficient implementations of classification, regression, and dimensionality reduction algorithms. Use when user asks to implement predictive models, perform feature selection, analyze time-series data with Dynamic Time Warping, or apply wavelet transforms for signal processing.
homepage: http://mlpy.sourceforge.net/index.html
metadata:
  docker_image: "quay.io/biocontainers/mlpy:3.5.0--py36h2ad2d48_3"
---

# mlpy

## Overview
mlpy is a specialized Python library designed for high-performance machine learning, bridging the gap between NumPy/SciPy and the GNU Scientific Libraries (GSL). It is particularly effective for researchers and developers who require reproducible and efficient implementations of state-of-the-art algorithms. Use this skill to implement robust predictive models, perform complex feature selection, or analyze time-series data using advanced distance metrics like DTW.

## Implementation Patterns

### Classification and Regression
mlpy provides a consistent interface for various supervised methods.
- **SVM/SVR**: Use for high-dimensional classification or regression.
- **Elastic Net/LARS**: Ideal for sparse modeling and feature selection.
- **LDA/DLDA**: Use for linear dimensionality reduction and classification, especially in bioinformatics contexts.

### Dimensionality Reduction
- **PCA/Kernel PCA**: Standard and non-linear principal component analysis for data compression or visualization.
- **FDA/SRDA**: Fisher Discriminant Analysis and Spectral Regression Discriminant Analysis for supervised dimensionality reduction.

### Specialized Submodules
- **mlpy.wavelet**: Provides Discrete, Undecimated, and Continuous Wavelet Transforms. Use this for signal processing and feature extraction from non-stationary data.
- **DTW and LCS**: Use `mlpy.dtw` for Dynamic Time Warping to compare sequences of different lengths or speeds.

## Best Practices
- **Data Preparation**: Ensure input data is formatted as NumPy arrays. mlpy is built to operate directly on these structures for maximum efficiency.
- **Resampling**: Utilize the built-in resampling algorithms to validate model stability and prevent overfitting.
- **Feature Ranking**: Before training complex models, use the provided feature ranking/selection algorithms (like Iterative RELIEF) to identify the most informative variables.
- **Environment**: When installing via Conda, use the `bioconda` channel: `conda install bioconda::mlpy`.

## Reference documentation
- [mlpy Overview](./references/anaconda_org_channels_bioconda_packages_mlpy_overview.md)
- [mlpy Features and Documentation](./references/mlpy_sourceforge_net_index.html.md)
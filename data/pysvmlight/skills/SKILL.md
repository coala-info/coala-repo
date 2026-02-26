---
name: pysvmlight
description: pysvmlight provides a Python interface for the SVM-Light software to train and apply support vector machine models. Use when user asks to train SVM models, perform classification or regression, or use SVM-Light optimization algorithms within a Python workflow.
homepage: https://bitbucket.org/wcauchois/pysvmlight
---


# pysvmlight

## Overview
pysvmlight provides a Python binding for the SVM-Light software, enabling efficient training and application of SVM models. It allows users to pass data directly from Python structures (like lists or arrays) into the SVM-Light engine, bypassing the need to manually write and read intermediate `.dat` files on disk. Use this tool when you require the specific optimization algorithms of SVM-Light (such as its handling of many optimization constraints) while maintaining a Python-based data science workflow.

## Usage Guidance

### Data Format
SVM-Light expects data in a sparse format. In Python, this is typically represented as a list of tuples for each instance:
- Format: `(target, [(feature_id, feature_value), ...])`
- `target`: The class label (+1/-1 for classification) or target value (for regression).
- `features`: A list of `(index, value)` pairs, where index is an integer starting from 1.

### Core Functions
- `svmlight.learn()`: Trains a model. Accepts the training data and a string of command-line options identical to the standard SVM-Light CLI (e.g., `-c 1.0 -t 2`).
- `svmlight.classify()`: Uses a trained model to predict values for new data.
- `svmlight.write_model()` / `svmlight.read_model()`: Handles model persistence to disk.

### Common Parameters
When passing options to `learn()`, use the standard SVM-Light flags:
- `-z c`: Classification (default).
- `-z r`: Regression.
- `-t`: Kernel type (0: linear, 1: polynomial, 2: RBF, 3: sigmoid).
- `-c`: Trade-off between error and margin.
- `-g`: Gamma parameter for RBF kernel.

### Performance Tip
Since pysvmlight wraps C code, ensure your feature indices are sorted in ascending order within each instance to maintain compatibility and performance with the underlying SVM-Light implementation.

## Reference documentation
- [pysvmlight Overview](./references/anaconda_org_channels_bioconda_packages_pysvmlight_overview.md)
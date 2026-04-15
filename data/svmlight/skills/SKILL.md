---
name: svmlight
description: svmlight is a toolset for training and applying Support Vector Machines optimized for high-dimensional sparse data. Use when user asks to train classification or regression models, perform preference ranking, or classify new data using a trained model.
homepage: http://svmlight.joachims.org/
metadata:
  docker_image: "quay.io/biocontainers/svmlight:6.02--h7b50bb2_8"
---

# svmlight

## Overview

`svmlight` is a specialized toolset for implementing Support Vector Machines, optimized for speed and memory efficiency when dealing with sparse data. It consists of two primary modules: `svm_learn` for model training and `svm_classify` for making predictions on new data. This skill provides the necessary patterns for data formatting, kernel selection, and parameter optimization to effectively utilize the SVM-Light algorithm.

## Data Format

`svmlight` requires a specific sparse input format. Each line represents one training example:

`<target> <feature>:<value> <feature>:<value> ... <feature>:<value> # <info>`

- **target**: +1 or -1 (classification), a real value (regression), or a float (ranking).
- **feature**: An integer index starting from 1 (must be in increasing order).
- **value**: A float representing the feature value.
- **# <info>**: Optional comment or string identifier.

## Common CLI Patterns

### Training a Model (`svm_learn`)

The basic syntax is `svm_learn [options] example_file model_file`.

**Linear Classification (Default):**
```bash
svm_learn train.dat model.bin
```

**RBF Kernel Classification:**
Use the `-t 2` option for Radial Basis Function and `-g` to set the gamma parameter.
```bash
svm_learn -t 2 -g 0.1 train.dat model.bin
```

**Regression Task:**
Use the `-z r` option to switch from classification to regression.
```bash
svm_learn -z r -w 0.1 train.dat model.bin
```

**Preference Ranking:**
Use the `-z p` option. The target values in the data file should represent the desired ordering.
```bash
svm_learn -z p train.dat model.bin
```

### Applying a Model (`svm_classify`)

The basic syntax is `svm_classify [options] test_file model_file output_file`.

```bash
svm_classify test.dat model.bin predictions.txt
```
The `predictions.txt` file will contain one value per line, representing the distance from the hyperplane (for classification) or the predicted value (for regression).

## Expert Tips and Best Practices

- **Feature Scaling**: SVMs are sensitive to the scale of input features. Always scale your features to a common range (e.g., [0, 1] or [-1, 1]) before training to prevent features with large magnitudes from dominating the model.
- **Kernel Selection**: Start with a linear kernel (`-t 0`). It is faster and often sufficient for high-dimensional text data. Move to RBF (`-t 2`) or Polynomial (`-t 1`) only if the linear model underperforms.
- **Tuning the Trade-off (-c)**: The `-c` parameter controls the trade-off between training error and margin. If your model is overfitting, try decreasing `-c`; if it is underfitting, try increasing it.
- **Handling Imbalanced Data**: Use the `-j` option to set the cost factor. For example, `-j 2` tells the learner that errors on positive examples are twice as "expensive" as errors on negative examples.
- **Memory Management**: For very large datasets, increase the kernel cache size using `-m <size_in_mb>` (default is 40MB) to significantly speed up training.
- **Verbosity**: Use `-v 0` for quiet mode in scripts or `-v 3` to debug optimization convergence issues.

## Reference documentation
- [SVM-Light: Support Vector Machine](./references/www_cs_cornell_edu_people_tj_svm_light.md)
- [svmlight - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_svmlight_overview.md)
---
name: deeplift
description: DeepLIFT is a framework for decomposing deep neural network predictions to explain the contribution of input features relative to a reference. Use when user asks to explain model predictions, compute feature importance scores, identify regulatory motifs in genomics, or handle gradient saturation in deep learning models.
homepage: https://github.com/kundajelab/deeplift
metadata:
  docker_image: "quay.io/biocontainers/deeplift:0.6.13.0--pyh3252c3a_0"
---

# deeplift

## Overview

DeepLIFT (Deep Learning Important FeaTures) is a specialized framework for decomposing the output predictions of deep neural networks. Unlike simple gradient-based methods, DeepLIFT explains the difference in output from a "reference" output in terms of differences in inputs from "reference" inputs. This approach allows the tool to capture non-linear effects and avoid issues like gradient saturation. It is widely used in bioinformatics to identify regulatory motifs and in general machine learning to provide transparent, feature-level explanations for model behavior.

## Installation

Install the package via PyPI or Bioconda:

```bash
# Via pip
pip install deeplift

# Via conda
conda install -c bioconda deeplift
```

## Core Workflow

To use DeepLIFT, you must convert your trained model into a DeepLIFT-compatible format and then compile a function to compute scores.

### 1. Model Conversion
DeepLIFT provides autoconversion for Keras models. You must specify a `NonlinearMxtsMode` which dictates how non-linearities are handled during backpropagation.

```python
import deeplift
from deeplift.conversion import kerasapi_conversion as kc

# Common modes:
# .DeepLIFT_GenomicsDefault: RevealCancel on Dense, Rescale on Conv
# .RevealCancel: Best for MNIST/Vision
# .Rescale: Standard rescaling
deeplift_model = kc.convert_model_from_saved_files(
    'model.h5',
    nonlinear_mxts_mode=deeplift.layers.NonlinearMxtsMode.DeepLIFT_GenomicsDefault
)
```

### 2. Compiling the Contribution Function
Define which layer you want scores for (usually the input layer, index 0) and which output task to explain.

```python
# find_scores_layer_idx=0 targets the input layer
# target_layer_idx=-2 is recommended for sigmoid/softmax (explains the logits)
# target_layer_idx=-1 is for regression/linear outputs
deeplift_contribs_func = deeplift_model.get_target_contribs_func(
    find_scores_layer_idx=0, 
    target_layer_idx=-2
)
```

### 3. Computing Scores
You must provide the input data and a "reference" input (e.g., a zero-background or shuffled sequence).

```python
# task_idx: the index of the class/output you are explaining
scores = deeplift_contribs_func(
    task_idx=0,
    input_data_list=[X_test],
    batch_size=10,
    progress_update=None
)
```

## Expert Tips and Best Practices

### Choice of Reference
The reference input is the most critical parameter. 
- **Genomics**: Use dinucleotide-shuffled versions of the original sequence to preserve local composition while breaking motifs.
- **Vision**: Often a black image or a blurred version of the input.
- **Note**: If the reference is poor, the importance scores may be misleading.

### Target Layer Selection
For classification models (Sigmoid or Softmax), always compute explanations with respect to the **logits** (the layer before the final activation). This is achieved by setting `target_layer_idx=-2`. Explaining the final probabilities directly can lead to "artifactual" importance due to the squashing nature of the activation function.

### Softmax Normalization
When dealing with Softmax outputs, it is recommended to mean-normalize the weights of the final layer so they sum to zero. This ensures that features contributing equally to all classes are assigned a score of zero, as they do not help discriminate between classes.

### Computer Vision Specifics
For complex images, computing scores for the raw pixels can sometimes be noisy. You may get more interpretable results by computing contribution scores for a higher convolutional layer using the `find_scores_layer_idx` argument.

### Negative Scores
A positive score means the feature drives the output *away* from the reference toward the target prediction. A negative score means the feature suppresses the output relative to the reference.

## Reference documentation
- [DeepLIFT GitHub Repository](./references/github_com_kundajelab_deeplift.md)
- [Bioconda DeepLIFT Overview](./references/anaconda_org_channels_bioconda_packages_deeplift_overview.md)
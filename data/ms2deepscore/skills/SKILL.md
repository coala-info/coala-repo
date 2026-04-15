---
name: ms2deepscore
description: ms2deepscore is a deep learning-based tool that predicts the structural similarity between tandem mass spectrometry spectra using Siamese neural networks. Use when user asks to calculate spectral similarity scores, generate vector embeddings for clustering, perform cross-ion mode comparisons, or train custom models on mass spectrometry data.
homepage: https://github.com/matchms/ms2deepscore
metadata:
  docker_image: "quay.io/biocontainers/ms2deepscore:2.7.1--pyhdfd78af_0"
---

# ms2deepscore

## Overview

ms2deepscore is a deep learning-based similarity measure designed to compare tandem mass spectrometry (MS/MS) spectra based on their underlying chemical similarity. Unlike traditional algorithms that rely on direct peak matching, ms2deepscore uses a Siamese neural network to predict the structural similarity of the molecules that produced the spectra. 

Use this skill when you need to:
- Calculate high-accuracy similarity scores between pairs of spectra.
- Generate vector embeddings of spectra for dimensionality reduction (e.g., UMAP) or clustering.
- Perform cross-ion mode comparisons (matching positive mode spectra to negative mode).
- Train specialized models on proprietary or niche mass spectrometry libraries.

## Installation and Setup

Install the package via pip or conda. It is recommended to use a dedicated environment with Python 3.10+.

```bash
# Via Pip
pip install ms2deepscore

# Via Conda
conda install -c bioconda -c conda-forge ms2deepscore
```

## Core Workflows

### 1. Computing Spectral Similarities
The most efficient way to compute scores is using the `matchms` Pipeline. This ensures spectra are properly filtered before scoring.

```python
from ms2deepscore.models import load_model
from ms2deepscore import MS2DeepScore
from matchms.Pipeline import Pipeline, create_workflow
from matchms.filtering.default_pipelines import DEFAULT_FILTERS

# Load a pre-trained model (.pt file)
model = load_model("ms2deepscore_model.pt")

# Define the workflow
workflow = create_workflow(
    query_filters=DEFAULT_FILTERS, 
    score_computations=[[MS2DeepScore, {"model": model}]]
)

# Run pipeline on your spectrum file (mgf, msp, mzml, etc.)
pipeline = Pipeline(workflow)
pipeline.run("your_spectra.mgf")

# Access the similarity matrix as a numpy array
similarity_matrix = pipeline.scores.to_array()
```

### 2. Generating Spectral Embeddings
Embeddings are vector representations of spectra. These are useful for visualizing "chemical space" or as inputs for other machine learning tasks.

```python
from ms2deepscore import MS2DeepScore

# Initialize the wrapper with a loaded model
ms2ds_model = MS2DeepScore(model)

# Generate embeddings for a list of matchms Spectrum objects
embeddings = ms2ds_model.get_embedding_array(spectra)
```

### 3. Training Custom Models
Training requires a large dataset (ideally >100,000 spectra). You must define settings for metadata handling (like precursor m/z and ion mode).

```python
from ms2deepscore.SettingsMS2Deepscore import SettingsMS2Deepscore, SettingsEmbeddingEvaluator
from ms2deepscore.wrapper_functions.training_wrapper_functions import train_ms2deepscore_wrapper

settings = SettingsMS2Deepscore(
    spectrum_file_path="training_data.mgf",
    additional_metadata=[
        ("CategoricalToBinary", {"metadata_field": "ionmode", "entries_becoming_one": "positive", "entries_becoming_zero": "negative"}),
        ("StandardScaler", {"metadata_field": "precursor_mz", "mean": 0, "standard_deviation": 1000})
    ],
    ionmode="both"
)

# Training the model and an optional embedding evaluator for accuracy prediction
train_ms2deepscore_wrapper(settings, SettingsEmbeddingEvaluator())
```

## Expert Tips and Best Practices

- **Pre-trained Models**: Do not train from scratch unless you have a very large, diverse dataset. Use the community-provided models (e.g., from Zenodo) which are trained on over 500,000 spectra.
- **Data Cleaning**: Always use `matchms` filters (like `DEFAULT_FILTERS`) before passing spectra to ms2deepscore. The model expects cleaned, normalized intensity data.
- **Memory Management**: When computing large similarity matrices (e.g., 50k x 50k), ensure you have sufficient RAM or process the data in batches, as the resulting numpy array can be several gigabytes.
- **Ion Mode**: The default models are often "bimodal," meaning they can handle positive and negative mode spectra simultaneously. Ensure your `ionmode` metadata is correctly labeled in your input files to leverage this.
- **Pair Sampling**: If training a custom model, pay close attention to pair sampling. Suboptimal sampling of chemical pairs can lead to poor model generalization.

## Reference documentation
- [ms2deepscore GitHub Repository](./references/github_com_matchms_ms2deepscore.md)
- [ms2deepscore Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ms2deepscore_overview.md)
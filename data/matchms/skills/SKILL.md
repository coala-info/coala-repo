---
name: matchms
description: matchms is a Python library for the processing, filtering, and fuzzy comparison of mass spectrometry data. Use when user asks to clean spectral metadata, filter peaks, or compute similarity scores between MS/MS spectra using algorithms like CosineGreedy or Spec2Vec.
homepage: https://github.com/matchms/matchms
---


# matchms

## Overview
matchms is a specialized Python library designed for the fuzzy comparison and processing of mass spectrometry data. It provides a standardized framework for the entire MS/MS data lifecycle: from importing raw data in various formats to metadata validation, peak filtering, and high-throughput similarity scoring. Use this skill to implement reproducible metabolomics workflows, clean spectral libraries, and perform large-scale pairwise comparisons of spectra.

## Installation and Setup
The recommended way to install matchms is via Conda to manage dependencies like RDKit and NumPy effectively:

```bash
conda install --channel bioconda --channel conda-forge matchms
```

## Core Workflows

### 1. Using the Pipeline Class
The `Pipeline` class is the primary interface for executing complex workflows. It handles data import, processing (filtering), and score computation in a single execution.

```python
from matchms.Pipeline import Pipeline, create_workflow

# Define the workflow parameters
workflow = create_workflow(
    score_computations=[["cosinegreedy", {"tolerance": 1.0}]]
)

# Initialize and run the pipeline
pipeline = Pipeline(workflow)
pipeline.run("path/to/data.mgf")
```

### 2. Spectral Filtering and Cleaning
matchms includes pre-defined filter sets to ensure data integrity. These are essential for removing low-quality peaks or correcting metadata.

*   **DEFAULT_FILTERS**: Basic cleaning for general MS/MS data.
*   **LIBRARY_CLEANING**: Specialized filters for preparing data for reference libraries.

```python
from matchms.filtering.default_pipelines import DEFAULT_FILTERS, LIBRARY_CLEANING

# These can be passed into a Pipeline or applied manually to Spectrum objects
```

### 3. Similarity Measures
matchms supports multiple similarity scores. While Cosine-based scores are built-in, others require additional packages but follow the same API:

*   **CosineGreedy**: Standard peak-based matching.
*   **Spec2Vec**: Machine-learning based similarity (requires `spec2vec` package).
*   **MS2DeepScore**: Deep-learning based similarity (requires `ms2deepscore` package).

### 4. Handling Large Datasets
For large-scale comparisons (hundreds of thousands of spectra), matchms utilizes sparse handling of scores. This ensures that only significant, non-null values are stored, preventing memory exhaustion.

## Expert Tips
*   **Metadata Validation**: Always use the metadata cleaning filters before similarity scoring to ensure that precursor m/z and adduct information are correctly formatted.
*   **Sparse Arrays**: When performing many-to-many comparisons, leverage the sparse scores array feature to handle large similarity matrices efficiently.
*   **Ecosystem Integration**: For advanced tasks, combine matchms with `matchmsextras` for networking/plotting or `MSMetaEnhancer` for automated metadata retrieval.
*   **Logging**: Set `pipeline.logging_file = "process.log"` to track the progress and potential issues during long-running batch processing.

## Reference documentation
- [matchms Overview](./references/github_com_matchms_matchms.md)
- [Installation Guide](./references/anaconda_org_channels_bioconda_packages_matchms_overview.md)
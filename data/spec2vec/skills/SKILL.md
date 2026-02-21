---
name: spec2vec
description: Spec2Vec is a spectral similarity measure that treats mass spectrometry fragments and neutral losses as "words" within a "sentence" (the spectrum).
homepage: https://github.com/iomega/spec2vec
---

# spec2vec

## Overview
Spec2Vec is a spectral similarity measure that treats mass spectrometry fragments and neutral losses as "words" within a "sentence" (the spectrum). By leveraging Word2Vec-based natural language processing algorithms, it learns the structural relationships between fragments across large datasets. This allows the tool to identify chemically related molecules even if they do not share identical peak patterns, making it significantly more robust than traditional rule-based similarity scores for complex metabolomics analysis.

## Installation and Setup
The recommended installation method is via Conda to ensure all dependencies (like `rdkit` for filtering) are correctly managed.

```bash
conda create --name spec2vec python=3.13
conda activate spec2vec
conda install --channel bioconda --channel conda-forge spec2vec
```

## Core Workflow

### 1. Data Preparation
Spec2Vec works in tandem with `matchms`. Spectra must be cleaned and filtered before being converted into documents.

```python
from matchms.importing import load_from_mgf
from matchms.filtering.default_pipelines import DEFAULT_FILTERS
from matchms import SpectrumProcessor

# Load and clean spectra
spectra = list(load_from_mgf("data.mgf"))
processor = SpectrumProcessor(DEFAULT_FILTERS)
spectra_cleaned, _ = processor.process_spectra(spectra)
spectra_cleaned = [s for s in spectra_cleaned if s is not None]
```

### 2. Document Conversion
Convert spectra into `SpectrumDocument` objects. This process bins peaks into "words" based on their m/z ratio.

```python
from spec2vec import SpectrumDocument

# n_decimals=2 is the standard for most Spec2Vec applications
reference_documents = [SpectrumDocument(s, n_decimals=2) for s in spectra_cleaned]
```

### 3. Model Training
You can train a new model on your specific dataset to capture unique fragment relationships.

```python
from spec2vec.model_building import train_new_word2vec_model

model_file = "my_spec2vec_model.model"
model = train_new_word2vec_model(reference_documents, iterations=[10, 20, 30], filename=model_file, workers=2)
```

### 4. Similarity Scoring
Use a trained model to calculate similarity between query spectra and a reference library.

```python
import gensim
from spec2vec import Spec2Vec
from matchms import calculate_scores

# Load pre-trained model
model = gensim.models.Word2Vec.load("my_spec2vec_model.model")

# Initialize similarity function
spec2vec_similarity = Spec2Vec(model=model, 
                               intensity_weighting_power=0.5, 
                               allowed_missing_percentage=5.0)

# Calculate scores
scores = calculate_scores(reference_documents, query_spectra_cleaned, spec2vec_similarity)
```

## Expert Tips and Best Practices
- **Peak Binning**: The `n_decimals` parameter in `SpectrumDocument` is critical. Using 2 decimals (e.g., "peak@100.39") is the standard for general-purpose models.
- **Missing Peaks**: When using a model on data it wasn't trained on, always set `allowed_missing_percentage`. This prevents the score from being heavily penalized by fragments the model has never seen.
- **Intensity Weighting**: The `intensity_weighting_power` (default 0.5) balances the importance of fragment intensity versus the presence of the fragment itself.
- **Gensim Compatibility**: As of version 0.9.0, Spec2Vec requires `gensim >= 4.4.0`. If loading very old models, ensure your environment matches the training version or follow Gensim's migration guides.

## Reference documentation
- [Spec2Vec GitHub Repository](./references/github_com_iomega_spec2vec.md)
- [Spec2Vec Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_spec2vec_overview.md)
---
name: scispacy
description: ScispaCy is a specialized library for processing and analyzing scientific and biomedical text using pre-trained spaCy pipelines. Use when user asks to identify medical entities, perform sentence segmentation on research papers, or link mentions to biomedical databases.
homepage: https://allenai.github.io/scispacy
---


# scispacy

## Overview
ScispaCy is a specialized library designed to handle the linguistic complexities of scientific and biomedical text. It provides pre-trained spaCy pipelines that outperform general-purpose models on domain-specific tasks. Use this skill to identify medical entities, analyze sentence structures in research papers, and link mentions to biomedical databases.

## Instructions

### Installation and Model Setup
Install the core package and specific models using pip. Models must be installed individually via their URLs or names.

```bash
pip install scispacy
# Example: Install a specific NER model
pip install https://s3-us-west-2.amazonaws.com/ai2-s2-scispacy/releases/v0.5.4/en_ner_bc5cdr_md-0.5.4.tar.gz
```

### Loading and Using Models
Load models using the standard `spacy.load()` function.

```python
import scispacy
import spacy

# Load a biomedical model
nlp = spacy.load("en_core_sci_sm")
doc = nlp("Myeloid derived suppressor cells (MDSC) accumulate in hepatocellular carcinoma (HCC).")
```

### Named Entity Recognition (NER)
Select the appropriate model based on the required entity types:
- **en_core_sci_***: General mention detection (no specific types).
- **en_ner_bc5cdr_md**: Detects `DISEASE` and `CHEMICAL`.
- **en_ner_craft_md**: Detects `GGP`, `SO`, `TAXON`, `CHEBI`, `GO`, `CL`.
- **en_ner_jnlpba_md**: Detects `DNA`, `RNA`, `CELL_TYPE`, `CELL_LINE`, `PROTEIN`.
- **en_ner_bionlp13cg_md**: Detects 16 types including `CANCER`, `ORGAN`, and `GENE_OR_GENE_PRODUCT`.

### Sentence Segmentation
Use the `doc.sents` generator to access sentences parsed with biomedical-specific boundaries, which are more accurate for scientific abstracts than standard English models.

### Visualization
Utilize `spacy.displacy` to visualize dependency parses or entity spans within a Jupyter notebook or as an exported SVG.

```python
from spacy import displacy
displacy.render(doc, style="ent")
```

### Performance Optimization
- Use `en_core_sci_scibert` for the highest accuracy in dependency parsing and POS tagging, as it utilizes a transformer-based architecture.
- Use `en_core_sci_sm` for fast processing and low memory footprints.
- Use `en_core_sci_lg` for a balance between vocabulary size (600k vectors) and speed.

## Reference documentation
- [scispaCy: spaCy models for biomedical text processing](./references/allenai_github_io_scispacy.md)
- [scispacy - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_scispacy_overview.md)
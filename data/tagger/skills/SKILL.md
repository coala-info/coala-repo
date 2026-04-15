---
name: tagger
description: The tagger tool performs high-performance named entity recognition by matching a dictionary of terms against a document corpus. Use when user asks to extract biological entities from text, perform dictionary-based string matching, or identify specific terms within large datasets.
homepage: https://bitbucket.org/larsjuhljensen/tagger
metadata:
  docker_image: "quay.io/biocontainers/tagger:1.1--py312hf731ba3_2"
---

# tagger

## Overview
The `tagger` tool is a high-performance utility for named entity recognition (NER) within large text datasets. It functions by matching a user-provided dictionary of terms against a document corpus. This skill provides the necessary patterns for installing the tool via Bioconda and executing tagging workflows to extract structured biological data from unstructured text.

## Installation
Install `tagger` using the conda package manager from the bioconda channel:
```bash
conda install -c bioconda tagger
```

## Usage Patterns
The tool typically requires two primary inputs: a dictionary of terms to search for and the corpus of documents to be processed.

### Basic Command Structure
While specific flags may vary by version, the general execution pattern follows:
```bash
tagger --dictionary <terms_file> --corpus <input_documents> --output <results_file>
```

### Common Workflows
- **Biomedical Entity Extraction**: Use pre-defined lists of protein names or disease identifiers to scan Medline abstracts.
- **Dictionary Preparation**: Ensure your search terms are formatted as a tab-separated or newline-delimited file (depending on the specific entity type) to ensure optimal matching performance.
- **Large Scale Processing**: When working with the full Medline corpus, ensure the environment has sufficient memory to load the dictionary into RAM for fast string matching.

## Best Practices
- **Normalization**: Pre-process your dictionary to include synonyms and common variations of entity names to increase recall.
- **Format Consistency**: Ensure input documents are in a plain text or Medline-compatible format before running the tagger.
- **Environment**: Always run `tagger` within a dedicated conda environment to avoid dependency conflicts with other bioinformatics tools.

## Reference documentation
- [tagger Overview](./references/anaconda_org_channels_bioconda_packages_tagger_overview.md)
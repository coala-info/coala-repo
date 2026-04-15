---
name: lexmapr
description: LexMapr maps informal specimen descriptions from tabular data to formal semantic ontologies. Use when user asks to map specimen descriptions to ontologies, standardize metadata, or clean and tokenize specimen provenance data.
homepage: https://github.com/LexMapr/lexmapr
metadata:
  docker_image: "quay.io/biocontainers/lexmapr:0.7.1--py36h09cc20e_1"
---

# lexmapr

## Overview
LexMapr is designed to bridge the gap between informal specimen descriptions and formal semantic ontologies. It processes tabular data (CSV/TSV) to clean, tokenize, and match text against specified ontology resources. This tool is particularly useful for bioinformatics pipelines requiring standardized metadata for specimen provenance and classification.

## Installation and Setup
LexMapr requires Python and specific NLTK data to function.

```bash
# Recommended installation via Conda
conda create -n LexMapr lexmapr
conda activate LexMapr

# Required: Download NLTK dependencies
python -m nltk.downloader all
```

## Core Usage Patterns

### Basic Mapping
To run a mapping, you need an input CSV and a JSON configuration file defining the target ontologies.

```bash
lexmapr input_specimens.csv -c config.json
```

### Configuration File Structure
The configuration file tells LexMapr which ontologies to use as the base for mapping.
Example `config.json`:
```json
[
  {
    "http://purl.obolibrary.org/obo/foodon.owl" : "http://purl.obolibrary.org/obo/BFO_0000001"
  }
]
```

### Input Data Format
The input CSV should typically contain a header row. LexMapr identifies the sample description column to perform cleaning and matching.
Example `input.csv`:
```csv
SampleId,Sample
S1,Chicken Breast
S2,Baked Potato
```

## CLI Options and Best Practices
- **Input Formats**: While CSV is standard, ensure your data is UTF-8 encoded to avoid character mapping errors during the NLTK processing phase.
- **Output Interpretation**: LexMapr provides a multi-column output:
    - `Sample_Id`: Original identifier.
    - `Sample_Desc`: Original text.
    - `Cleaned_Sample`: The text after normalization/tokenization.
    - `Matched_Components`: The resulting ontology terms and their IRIs.
- **Ontology Selection**: Use specific OWL files (like FoodOn) for specialized domains to increase the hit rate of the rule-based engine.

## Troubleshooting
- **NLTK Errors**: If the tool fails during the "Cleaning" phase, verify that `python -m nltk.downloader all` was executed in the active environment.
- **No Matches**: If `Matched_Components` is empty, check if the ontology IRI in your `config.json` is accessible or correctly pointed to a local/remote `.owl` file.

## Reference documentation
- [LexMapr GitHub Repository](./references/github_com_lexmapr_LexMapr.md)
- [Bioconda LexMapr Overview](./references/anaconda_org_channels_bioconda_packages_lexmapr_overview.md)
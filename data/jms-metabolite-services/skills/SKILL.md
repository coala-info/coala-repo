---
name: jms-metabolite-services
description: `jms-metabolite-services` (JMS) is a specialized Python library designed for the metabolomics community.
homepage: https://github.com/shuzhao-li/JMS
---

# jms-metabolite-services

## Overview
`jms-metabolite-services` (JMS) is a specialized Python library designed for the metabolomics community. It provides a framework for mapping identifiers across various genome-scale metabolic models and metabolite databases. Its primary utility lies in its efficient mass and empirical compound search functions, allowing researchers to link LC-MS peaks to known chemical entities using standardized JSON-based data structures. It acts as a bridge between raw mass spectrometry features and biological context.

## Installation
Install the package via Bioconda or Pip:

```bash
# Using Conda
conda install bioconda::jms-metabolite-services

# Using Pip
pip install jms-metabolite-services
```

## Core Data Structures
JMS relies on specific dictionary formats for interoperability. Familiarity with these schemas is essential for custom scripting:

- **Peak**: Represents an LC-MS feature (e.g., `mz`, `rtime`, `height`).
- **Compound**: Represents a known metabolite (e.g., `primary_id`, `neutral_formula_mass`, `SMILES`, `inchikey`).
- **Empirical Compound**: A higher-level object that groups multiple MS1 features (adducts, isotopes) suspected to originate from the same metabolite.

## Common Workflows

### Annotating Feature Tables
The most common use case is annotating a TSV feature table against a compound database like HMDB.

```python
import json
from jms.dbStructures import annotate_peaks_against_kcds
from jms.io import read_table_to_peaks

# 1. Load your compound database (must be in JMS JSON format)
list_compounds = json.load(open('jms/data/compounds/list_compounds_HMDB4.json'))

# 2. Read your LC-MS feature table
# Expects a tab-delimited file with mz and rtime columns
mydata = read_table_to_peaks('testdata/full_Feature_table.tsv', '\t')

# 3. Run the annotation
annotate_peaks_against_kcds(
    mydata, 
    list_compounds, 
    export_file_name_prefix='jms_annotated_', 
    mode='pos', 
    mz_tolerance_ppm=5
)
```

### Testing the Environment
To verify the installation and ensure data structures are being handled correctly, run the internal test suite:

```bash
# Decompress reference data if using the source repository
xz -d jms/data/compounds/list_compounds_HMDB4.json.xz

# Run tests from the root directory
python3 -m jms.test
```

## Expert Tips
- **Ionization Mode**: Always verify the `mode` parameter (`'pos'` or `'neg'`) in annotation functions. Adduct calculations are mode-specific and will fail to match correctly if mismatched.
- **Tolerance Tuning**: For high-resolution Orbitrap data, a `mz_tolerance_ppm` of 5 is standard, but this should be increased for Q-TOF or older instruments.
- **Data Integration**: JMS is designed to be the "mapping layer" between `asari` (for preprocessing) and `mummichog` (for pathway analysis). Use it to resolve identifier conflicts before performing network analysis.
- **Custom Databases**: You can create custom search databases by formatting any metabolite list into the JMS "Compound" JSON schema.

## Reference documentation
- [JMS GitHub Repository](./references/github_com_metabolomics-cloud_JMS.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_jms-metabolite-services_overview.md)
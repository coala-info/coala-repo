---
name: psm-utils
description: psm-utils is a library and command-line interface for handling and converting peptide-spectrum match (PSM) files across various proteomics search engine formats. Use when user asks to convert search engine results, standardize peptide modifications using ProForma 2.0, or prepare proteomics data for rescoring and visualization.
homepage: https://github.com/compomics/psm_utils
metadata:
  docker_image: "quay.io/biocontainers/psm-utils:1.5.2--pyhdfd78af_0"
---

# psm-utils

## Overview

`psm-utils` is a high-level library and command-line interface designed to bridge the gap between the numerous output formats produced by proteomics search engines. It provides a unified API to handle PSMs from tools such as MaxQuant, DIA-NN, FragPipe, and Sage. Use this skill to automate the conversion of search results, standardize peptide modifications using ProForma 2.0, and prepare data for downstream rescoring or visualization.

## Installation

Install the package via pip or conda:

```bash
pip install psm-utils
# For specific format support (e.g., idXML or CBOR)
pip install psm-utils[idxml,cbor]
```

## CLI Usage Patterns

The primary CLI utility is used for converting between supported proteomics formats.

### Basic Conversion
Convert search engine results to a standardized format using the `psm-utils convert` command. You must specify the input and output formats using their respective "tags."

```bash
psm-utils convert --input-file <input_file> --input-format <format_tag> --output-file <output_file> --output-format <format_tag>
```

### Common Format Tags
Use these tags for the `--input-format` and `--output-format` arguments:

| Search Engine / Format | Tag | Read | Write |
| :--- | :--- | :---: | :---: |
| mzIdentML | `mzid` | ✅ | ✅ |
| Percolator Tab | `percolator` | ✅ | ✅ |
| MaxQuant (msms.txt) | `msms` | ✅ | ❌ |
| DIA-NN TSV | `diann` | ✅ | ❌ |
| FragPipe PSM TSV | `fragpipe` | ✅ | ❌ |
| Sage TSV | `sage_tsv` | ✅ | ❌ |
| Apache Parquet | `parquet` | ✅ | ✅ |
| Peptide Record (PEPREC) | `peprec` | ✅ | ✅ |

### Example: Preparing for Percolator
To convert MaxQuant results for rescoring in Percolator:
```bash
psm-utils convert -i msms.txt -if msms -o results.tab -of percolator
```

## Python API Best Practices

For more complex workflows, use the Python API to manipulate `PSMList` objects.

### Reading and Iterating
```python
from psm_utils.io import read_file

# Automatically infers format or use the 'file_format' argument
psm_list = read_file("search_results.mzid")

# PSMList behaves like a list of PSM objects
for psm in psm_list:
    print(psm.peptidoform, psm.score)
```

### Handling Peptidoforms
`psm-utils` uses the `Peptidoform` class to handle sequences and modifications according to ProForma 2.0 standards.
```python
# Accessing mass or sequence information
peptidoform = psm_list[0].peptidoform
print(peptidoform.theoretical_mass)
print(peptidoform.sequence)
```

## Expert Tips

- **Large Datasets**: When dealing with millions of PSMs, use the `parquet` format tag. It is significantly faster and more disk-efficient than TSV or XML-based formats.
- **Modification Mapping**: If a search engine uses non-standard modification labels, `psm-utils` attempts to map them to Unimod or PSI-MOD via ProForma. Ensure your input files have clear modification headers (e.g., "Assigned Modifications" in FragPipe).
- **Q-value Calculation**: The library includes utilities in `psm_utils.stats` to calculate q-values and PEPs if the search engine hasn't already provided them.
- **USI Support**: The library can generate and parse Universal Spectrum Identifiers (USI), which is useful for linking PSMs back to public repositories like PRIDE.

## Reference documentation
- [psm-utils GitHub Repository](./references/github_com_CompOmics_psm_utils.md)
- [psm-utils Releases and Changelog](./references/github_com_compomics_psm_utils_releases.md)
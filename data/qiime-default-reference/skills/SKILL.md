---
name: qiime-default-reference
description: This tool provides programmatic access to standardized Greengenes 16S rRNA reference data and file paths for QIIME-based analyses. Use when user asks to retrieve absolute paths for reference sequences, PyNAST template alignments, phylogenetic trees, or taxonomy mappings.
homepage: https://github.com/biocore/qiime-default-reference
metadata:
  docker_image: "quay.io/biocontainers/qiime-default-reference:0.1.3--py36_0"
---

# qiime-default-reference

## Overview
The qiime-default-reference package provides a standardized way to access the Greengenes 16S rRNA database (version 13_8) specifically curated for use with QIIME. Instead of manually managing file paths for reference datasets, this tool allows users to retrieve absolute file paths for 97% OTU sequences, PyNAST template alignments, and phylogenetic trees directly through a Python interface or shell commands.

## Installation
Install the package via pip:
```bash
pip install qiime-default-reference
```

## Accessing Reference Data
The primary utility of this tool is retrieving the absolute paths to specific reference files.

### Python API Usage
Import the package to access the following getter functions:

```python
import qiime_default_reference

# Get path to reference sequences (FASTA)
seqs = qiime_default_reference.get_reference_sequences()

# Get path to PyNAST template alignment (FASTA)
align = qiime_default_reference.get_template_alignment()

# Get path to phylogenetic tree (Newick)
tree = qiime_default_reference.get_reference_tree()

# Get path to taxonomy mapping (TSV)
tax = qiime_default_reference.get_reference_taxonomy()

# Get the Lane mask (alignment column mask)
mask = qiime_default_reference.get_template_alignment_column_mask()
```

### Command Line Integration
Since the tool provides paths via Python, you can use python one-liners to pass these paths directly to other CLI bioinformatics tools:

```bash
# Example: Using the reference sequences in a grep search
grep "target_sequence" $(python -c "import qiime_default_reference; print(qiime_default_reference.get_reference_sequences())")

# Example: Assigning the tree path to a variable
REF_TREE=$(python -c "import qiime_default_reference; print(qiime_default_reference.get_reference_tree())")
```

## Best Practices and Tips
- **Consistency**: Always use these programmatic accessors rather than hardcoding paths to Greengenes files. This ensures that your scripts remain portable across different environments where the package is installed.
- **Alignment Masking**: Use `get_template_alignment_column_mask()` when performing sequence alignments to ensure you are using the standard Lane mask, which filters out highly variable or uninformative positions in the 16S rRNA gene.
- **Version Awareness**: Note that this package specifically distributes Greengenes 13_8. If your study requires a different version (e.g., 13_5) or a different database (e.g., SILVA), you must source those files manually as they are not covered by this specific tool.
- **Verification**: You can run the internal unit tests to ensure the data files are intact and accessible:
  ```bash
  nosetests --with-doctest qiime_default_reference
  ```

## Reference documentation
- [biocore/qiime-default-reference](./references/github_com_biocore_qiime-default-reference.md)
---
name: pygenetic_code
description: pygenetic_code translates nucleotide sequences into proteins using various NCBI genetic codes through a high-performance C-based backend. Use when user asks to translate DNA sequences, perform six-frame translations, or look up amino acid codes for specific codons using alternative translation tables.
homepage: https://github.com/linsalrob/genetic_codes
metadata:
  docker_image: "quay.io/biocontainers/pygenetic_code:0.20.0--py312he4a0461_0"
---

# pygenetic_code

## Overview

The `pygenetic_code` tool is a high-performance library and command-line utility designed to handle the complexities of biological sequence translation. While most genomic work defaults to the Standard Code, many organisms and organelles (like mitochondria) utilize alternative translation tables. This tool provides a fast C-based backend to accurately convert nucleotide sequences into proteins using any of the recognized NCBI genetic codes. It is optimized for speed and can handle large-scale data, including direct processing of compressed gzip files.

## Installation and Setup

Install the tool via Bioconda (recommended) or pip:

```bash
# Using Conda/Mamba
conda install bioconda::pygenetic_code

# Using pip
pip install pygenetic_code
```

## Command Line Usage

The primary CLI entry point is `pygenetic_code`. It is typically used to translate sequences provided via standard input or files.

### Basic Translation
To translate a DNA sequence in the current reading frame:
```bash
echo "ATGCGT" | pygenetic_code --translate
```

### Six-Frame Translation
For genomic analysis where the coding frame is unknown, use the six-frame translation capability. While the library provides direct functions, the package includes example scripts for common file-based workflows:
```bash
# Translate a FASTA file in all 6 frames using the Bacterial code (Table 11)
python examples/translate_sequence_in_all_frames.py -f input.fna -t 11
```

## Python API Integration

For more complex workflows, integrate the library directly into Python scripts.

### High-Level Wrappers
The easiest way to access translation is through the high-level wrappers:

```python
from pygenetic_code import translate, six_frame_translation

dna_seq = "ATGGCCATTGTAATGGGCCGCTGAAAGGGTGCCCGATAG"

# Single frame translation (Table 1 is default)
protein = translate(dna_seq, translation_table=1)

# Six-frame translation (returns a dictionary of frames)
frames = six_frame_translation(dna_seq, translation_table=11)
```

### Codon Lookup
To translate a single codon or query a specific table:

```python
from pygenetic_code import translate_codon

# Get one-letter amino acid code for a codon in the Vertebrate Mitochondrial code (Table 2)
aa = translate_codon("AGA", translation_table=2, one_letter=True)
# Note: AGA is 'Stop' in Table 2, but 'Arg' in Table 1.
```

## Expert Tips and Best Practices

- **Table Selection**: Always verify the correct `translation_table` ID. Common IDs include:
    - `1`: Standard Code
    - `2`: Vertebrate Mitochondrial
    - `4`: Mold/Protozoan/Coelenterate Mitochondrial
    - `11`: Bacterial, Archaeal, and Plant Plastid
- **Gzip Support**: The library can process `.gz` files directly without manual decompression, which is significantly more efficient for large genomic datasets (e.g., `U00096.3.fna.gz`).
- **Performance**: For bulk translation of many sequences, use the `PyGeneticCode` C-extension methods directly to minimize Python overhead.
- **Handling Ambiguity**: Ensure input sequences are cleaned of non-ATGC characters unless the specific translation table supports ambiguity codes.

## Reference documentation
- [pygenetic_code Overview](./references/anaconda_org_channels_bioconda_packages_pygenetic_code_overview.md)
- [Genetic Codes GitHub Repository](./references/github_com_linsalrob_genetic_codes.md)
---
name: pyvcf
description: The pyvcf library provides a Pythonic interface for reading and parsing VCF v4.0 files into structured objects. Use when user asks to parse genomic variant files, extract INFO field metadata, or inspect sample-level genotypes.
homepage: https://github.com/jdoughertyii/PyVCF
---


# pyvcf

## Overview
The `pyvcf` library provides a Pythonic interface for reading VCF v4.0 files, designed to mimic the simplicity of the standard `csv` module. It transforms complex VCF records into structured Python objects, automatically parsing data types based on the meta-information lines (##INFO and ##FORMAT) in the VCF header. Use this skill to automate genomic data extraction, filter variants based on quality or frequency, and inspect sample-level genotypes.

## Core Usage Patterns

### Initializing the Reader
Always open VCF files in binary mode (`'rb'`) to ensure compatibility with the parser.

```python
import vcf
vcf_reader = vcf.VCFReader(open('data.vcf', 'rb'))
```

### Accessing Record Data
Each record object contains the 8 fixed VCF fields as attributes and structured data for INFO and samples.

*   **Fixed Fields**: `record.CHROM`, `record.POS`, `record.ID`, `record.REF`, `record.ALT`, `record.QUAL`, `record.FILTER`.
*   **INFO Field**: Accessed as a dictionary. Flags return `True`.
    ```python
    # Accessing an Allele Frequency (AF) list
    af = record.INFO['AF'] 
    # Checking a flag
    is_db = record.INFO.get('DB', False)
    ```
*   **Genotypes (Samples)**: Accessed via the `samples` attribute.
    ```python
    for sample in record.samples:
        print(sample['GT'])
    ```

### Inspecting Metadata
The reader object stores header information which is useful for validating file structure or retrieving descriptions.

*   `vcf_reader.metadata`: General file metadata (e.g., fileDate).
*   `vcf_reader.infos`: Dictionary of INFO field definitions.
*   `vcf_reader.formats`: Dictionary of FORMAT field definitions.
*   `vcf_reader.samples`: List of sample names found in the header.

## Expert Tips and Best Practices

*   **List Handling**: `pyvcf` converts comma-separated VCF values into Python lists. Even if a field like `ALT` or an `INFO` tag has only one value, it will often be returned as a single-element list (e.g., `['A']`). Always check for list length or index into the first element if you expect a single value.
*   **Type Casting**: The parser relies heavily on the `##INFO` and `##FORMAT` lines in the header to determine if a value should be an integer, float, or string. If your VCF has a malformed header, `pyvcf` will default to returning strings.
*   **Memory Efficiency**: The `VCFReader` acts as an iterator. For very large VCF files, process records one by one in a loop rather than converting the entire reader to a list.
*   **Missing FORMAT**: If a VCF record lacks a FORMAT column, `record.FORMAT` will return `None`. Always verify this attribute before attempting to parse sample-specific data in heterogeneous files.

## Reference documentation
- [PyVCF Main Documentation](./references/github_com_jdoughertyii_PyVCF.md)
---
name: pyvcf3
description: pyvcf3 is a Python library for reading, parsing, and writing VCF v4.0 and v4.1 files. Use when user asks to parse genomic variant records, extract sample genotypes, filter variants by type, or perform region-based queries on indexed VCF files.
homepage: https://github.com/dridk/PyVCF3
metadata:
  docker_image: "quay.io/biocontainers/pyvcf3:1.0.4--py311haab0aaa_0"
---

# pyvcf3

## Overview

pyvcf3 is a Python 3 library designed to handle VCF v4.0 and v4.1 files. It provides an interface similar to the standard library's `csv` module, allowing for intuitive iteration over genomic records. The tool automatically parses meta-information (##INFO and ##FORMAT lines) to convert VCF data into native Python types like lists and dictionaries. It is particularly useful for extracting specific variant attributes, calculating sample statistics, and performing region-based queries on indexed files.

## Installation

Install via bioconda:
```bash
conda install bioconda::pyvcf3
```

## Core Usage Patterns

### Reading VCF Files
The primary interface is the `vcf.Reader` class. It accepts a file-like object.

```python
import vcf
vcf_reader = vcf.Reader(open('input.vcf', 'r'))
for record in vcf_reader:
    print(f"{record.CHROM}:{record.POS} {record.REF}>{record.ALT}")
```

### Accessing Record Data
Records contain fixed fields and a dictionary-like `INFO` field.
- **Fixed Fields**: `record.CHROM`, `record.POS`, `record.ID`, `record.REF`, `record.ALT`, `record.QUAL`, `record.FILTER`.
- **INFO Field**: `record.INFO['AF']` (returns a list for comma-separated values).

### Working with Genotypes (Samples)
Genotype data is stored in `record.samples` as a list of `Call` objects. You can also look up genotypes by sample name.

```python
# Get a specific sample call
call = record.genotype('NA00001')
print(call.gt_bases)  # e.g., 'T|T'
print(call.called)    # True if not './.'
print(call.gt_type)   # 0=HOM_REF, 1=HET, 2=HOM_ALT, None=UNRECOGNIZED/MISSING
```

### Filtering and Convenience Properties
Records provide boolean properties for quick filtering:
- `record.is_snp`, `record.is_indel`, `record.is_transition`, `record.is_deletion`.
- `record.var_type` (e.g., 'snp', 'indel') and `record.var_subtype` (e.g., 'ts', 'tv').
- `record.num_called`, `record.call_rate`, `record.num_hom_ref`, `record.num_het`, `record.num_hom_alt`.

### Random Access with Tabix
If the VCF is compressed with `bgzip` and indexed with `tabix`, use the `fetch` method for region-based retrieval. Note: coordinates are 0-based, half-open.

```python
vcf_reader = vcf.Reader(filename='compressed.vcf.gz')
# Fetch records on Chromosome 20 from base 1110696 to 1230237
for record in vcf_reader.fetch('20', 1110695, 1230237):
    print(record)
```

### Writing VCF Files
The `vcf.Writer` requires a template (usually a `Reader`) to copy the header information.

```python
vcf_reader = vcf.Reader(open('input.vcf', 'r'))
vcf_writer = vcf.Writer(open('output.vcf', 'w'), vcf_reader)
for record in vcf_reader:
    if record.is_snp:
        vcf_writer.write_record(record)
```

## Expert Tips

- **Single vs. List Values**: In newer releases, attributes known to have single values (like DP or GQ) are returned as single values, while others remain lists. Always check the type if the VCF header is non-standard.
- **Memory Efficiency**: For very large VCFs, avoid loading all records into a list. Iterate through the `Reader` object directly.
- **Missing Data**: `record.ALT` is always a list, even for single alleles. A "None" in the ALT list typically represents a reference-only call in some VCF flavors.
- **Metadata Inspection**: Use `vcf_reader.metadata`, `vcf_reader.infos`, `vcf_reader.filters`, and `vcf_reader.formats` to programmatically inspect the VCF header definitions.

## Reference documentation
- [PyVCF3 GitHub README](./references/github_com_dridk_PyVCF3.md)
- [Bioconda PyVCF3 Overview](./references/anaconda_org_channels_bioconda_packages_pyvcf3_overview.md)
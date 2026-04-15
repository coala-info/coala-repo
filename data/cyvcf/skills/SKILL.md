---
name: cyvcf
description: cyvcf provides a high-speed interface for parsing and analyzing genomic variant data using the htslib C library. Use when user asks to extract variants from specific genomic regions, filter VCF files by INFO fields, or programmatically analyze genotypes and depth using NumPy.
homepage: https://github.com/brentp/cyvcf2
metadata:
  docker_image: "quay.io/biocontainers/cyvcf:0.8.0--py36_0"
---

# cyvcf

## Overview

The `cyvcf` skill (utilizing the `cyvcf2` library) provides a high-speed interface to genomic variant data by wrapping the C-based `htslib`. It is significantly faster than standard Python VCF parsers and is optimized for large-scale datasets. This skill covers both the command-line interface for quick data extraction and the Python API for complex programmatic analysis, with a focus on memory efficiency and NumPy integration.

## Command Line Usage

The `cyvcf2` CLI is used for rapid filtering and streaming of VCF data.

### Basic Filtering
Extract variants from a specific genomic region:
```bash
cyvcf2 -c chr11 -s 435345 -e 556565 input.vcf.gz
```

### Field Selection
Limit output to specific INFO fields to reduce processing overhead:
```bash
cyvcf2 --include DP,AF --exclude AC input.vcf.gz
```

## Python API Best Practices

### Efficient Iteration
Always use the `VCF` object for streaming variants. For indexed files, use the call syntax for region queries.

```python
from cyvcf2 import VCF

vcf = VCF('data.vcf.gz')

# Region-specific query (requires index)
for variant in vcf('11:435345-556565'):
    # Access basic attributes
    chrom = variant.CHROM
    pos = variant.start
    
    # Access INFO fields
    af = variant.INFO.get('AF')
    
    # Access FORMAT fields (returns NumPy arrays)
    dp = variant.format('DP')
```

### Memory Management with NumPy
**Critical**: NumPy arrays returned by `cyvcf2` (like `gt_ref_depths`) are often backed by the underlying C memory of the variant record. If the `variant` object goes out of scope or the loop moves to the next record, the array data may become invalid.

**Safe Pattern**:
```python
import numpy as np

# Copy the data if you need it outside the loop
depths_copy = np.array(variant.gt_ref_depths)
```

### Genotype Handling
Genotypes are represented as integers in the `gt_types` array:
- `0`: HOM_REF (0/0)
- `1`: HET (0/1)
- `2`: UNKNOWN (./.)
- `3`: HOM_ALT (1/1)

## Expert Tips

1.  **BCF Preference**: For maximum performance, use BCF (Binary VCF) files instead of compressed VCF. `cyvcf2` handles both transparently, but BCF is faster to parse.
2.  **Indexing**: Ensure your VCF files are indexed with `tabix` or `bcftools` to enable region-based queries.
3.  **Context Managers**: Use `VCF` as a context manager to ensure file handles are closed properly:
    ```python
    with VCF('input.vcf.gz') as vcf:
        for v in vcf:
            pass
    ```
4.  **String Representation**: To print a variant in its original VCF format, use `str(variant)`.

## Reference documentation
- [cyvcf2 GitHub Repository](./references/github_com_brentp_cyvcf2.md)
- [cyvcf Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cyvcf_overview.md)
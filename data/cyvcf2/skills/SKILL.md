---
name: cyvcf2
description: cyvcf2 is a high-performance tool and Python library for the rapid processing and filtering of VCF and BCF genomic variant data. Use when user asks to parse variant files, query specific genomic regions, extract genotype data as NumPy arrays, or filter VCF records by INFO fields.
homepage: https://github.com/brentp/cyvcf2
---


# cyvcf2

## Overview

cyvcf2 is a specialized tool for the rapid processing of genomic variant data. By leveraging a Cython wrapper around the htslib C library, it provides a Pythonic interface that achieves significantly higher performance than standard VCF parsers. It is designed to handle both VCF and BCF formats efficiently, offering features like fast region-based lookups and the ability to return sample-level data (such as depths and genotype types) directly as NumPy arrays. This makes it a core component for developers building genomic pipelines that require low-latency data access and memory-efficient processing of large-scale datasets.

## Command Line Interface (CLI) Usage

The `cyvcf2` command line tool is primarily used for fast filtering and streaming of VCF data.

### Basic Filtering
To stream a VCF file and filter by specific genomic regions:
```bash
cyvcf2 -c chr11 -s 435345 -e 556565 input.vcf.gz
```

### Field Selection
You can limit the output to specific INFO fields to reduce data volume:
```bash
cyvcf2 --include DP --exclude AF input.vcf.gz
```

### Logging and Silence
For use in scripts where only the data stream is needed, or for debugging:
```bash
# Set log level to suppress warnings
cyvcf2 --loglevel ERROR input.vcf.gz

# Skip printing the VCF content (useful for performance testing)
cyvcf2 --silent input.vcf.gz
```

## Python API Best Practices

### Efficient Iteration and Region Queries
Always use the indexed query method for large files to avoid scanning the entire dataset.
```python
from cyvcf2 import VCF

vcf = VCF('data.vcf.gz')
# Efficiently query a specific region
for variant in vcf('11:435345-556565'):
    print(variant.CHROM, variant.start, variant.REF, variant.ALT)
```

### Handling Genotype Data with NumPy
cyvcf2 provides direct access to genotype fields as NumPy arrays. Note that these arrays are often backed by C memory.

**Critical Memory Warning:** If the `variant` object goes out of scope, the underlying C data is freed. If you need to keep the data, you must create a copy.
```python
import numpy as np

# Correct way to persist data
ref_depths = np.array(variant.gt_ref_depths) 

# Incorrect (will contain nonsense once variant is garbage collected)
# ref_depths = variant.gt_ref_depths 
```

### Genotype Type Mapping
The `gt_types` attribute returns an integer array where:
- `0`: HOM_REF (Homozygous Reference)
- `1`: HET (Heterozygous)
- `2`: UNKNOWN (Missing data)
- `3`: HOM_ALT (Homozygous Alternative)

### Accessing INFO and FORMAT Fields
```python
# Extract from INFO field
dp = variant.INFO.get('DP') # Returns int or None
af = variant.INFO.get('AF') # Returns float or None

# Extract from FORMAT field (per-sample data)
# Returns a NumPy array of shape (n_samples, n_values_per_sample)
sample_depths = variant.format('DP')
sample_allelic_balance = variant.format('SB')
```

## Expert Tips
- **BCF vs VCF**: For maximum performance in repetitive workflows, convert your VCF files to BCF format. cyvcf2 handles BCF natively and significantly faster due to the binary representation.
- **Context Managers**: Use `VCF` as a context manager to ensure file handles are closed properly: `with VCF('file.vcf.gz') as vcf:`.
- **Performance**: When processing millions of variants, avoid converting variants to strings (`str(variant)`) unless necessary, as string serialization is a major bottleneck.

## Reference documentation
- [cyvcf2 Overview](./references/anaconda_org_channels_bioconda_packages_cyvcf2_overview.md)
- [cyvcf2 GitHub Repository](./references/github_com_brentp_cyvcf2.md)
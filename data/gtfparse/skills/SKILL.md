---
name: gtfparse
description: gtfparse is a Python library that transforms GTF files into tabular formats like Pandas or Polars DataFrames while expanding attribute columns. Use when user asks to parse GTF files, convert genomic annotations to DataFrames, or extract specific gene attributes for data analysis.
homepage: https://github.com/openvax/gtfparse
metadata:
  docker_image: "quay.io/biocontainers/gtfparse:2.5.0--pyh7cba7a3_0"
---

# gtfparse

## Overview

gtfparse is a high-performance Python library designed to transform GTF (Gene Transfer Format) files into tabular formats like Pandas or Polars DataFrames. It simplifies genomic data processing by automatically expanding the semicolon-separated "attributes" column into individual, named columns. This tool is essential for bioinformaticians who need to programmatically interact with gene models, transcript data, or custom annotations from tools like StringTie or Ensembl.

## Usage Instructions

### Basic Parsing
The primary entry point is the `read_gtf` function. By default, it returns a Pandas DataFrame containing essential columns (seqname, source, feature, start, end, score, strand, frame) plus any keys found in the attributes column.

```python
from gtfparse import read_gtf

# Load the GTF file
df = read_gtf("annotations.gtf")

# Filter for specific features
genes = df[df["feature"] == "gene"]
```

### Handling Custom Attributes
GTF files often contain tool-specific attributes (e.g., FPKM, TPM, gene_name). You can specify data types for these attributes during parsing to ensure they are ready for calculation.

```python
# Convert FPKM attributes to floats during parsing
df = read_gtf("transcripts.gtf", column_converters={"FPKM": float})

# Access the converted column directly
mean_fpkm = df["FPKM"].mean()
```

### Performance Optimization
For very large GTF files, gtfparse utilizes Polars internally for speed. You can control the return type or disable attribute expansion if you only need the core genomic coordinates.

- **Polars Integration**: Recent versions allow specifying the return type to leverage Polars' memory efficiency.
- **Attribute Expansion**: If you do not need the key-value pairs from the 9th column, set `expand_attribute_column=False` to significantly speed up parsing and reduce memory overhead.

### Common Filtering Patterns
Once loaded, use standard DataFrame operations to slice your genomic data:

- **By Chromosome**: `df[df["seqname"] == "chr1"]`
- **By Feature Type**: `df[df["feature"] == "exon"]`
- **By Attribute**: `df[df["gene_name"] == "BRCA1"]`

## Expert Tips

- **Memory Management**: If you encounter memory errors with large files (like whole-genome Gencode sets), parse only the necessary columns or use the `expand_attribute_column=False` flag to inspect the data structure first.
- **StringTie Compatibility**: When working with StringTie output, always use `column_converters` for "FPKM" and "TPM" to avoid them being treated as strings.
- **Data Integrity**: Note that `gtfparse` expects standard 1-based, closed-interval GTF coordinates. If your downstream tool requires 0-based coordinates (like BED format), you must manually subtract 1 from the "start" column.

## Reference documentation
- [github_com_openvax_gtfparse.md](./references/github_com_openvax_gtfparse.md)
- [anaconda_org_channels_bioconda_packages_gtfparse_overview.md](./references/anaconda_org_channels_bioconda_packages_gtfparse_overview.md)
- [github_com_openvax_gtfparse_issues.md](./references/github_com_openvax_gtfparse_issues.md)
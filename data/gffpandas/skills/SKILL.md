---
name: gffpandas
description: gffpandas is a Python library designed to simplify the handling of GFF3 (General Feature Format version 3) files by loading them into a specialized Pandas-like DataFrame structure.
homepage: https://github.com/foerstner-lab/gffpandas
---

# gffpandas

## Overview

gffpandas is a Python library designed to simplify the handling of GFF3 (General Feature Format version 3) files by loading them into a specialized Pandas-like DataFrame structure. While traditional tools often require complex database setups or manual string parsing of the "attributes" column, gffpandas provides a high-level API to perform multi-step filtering and attribute extraction. It is particularly useful for researchers who want to integrate genomic annotations directly into Python data science pipelines for downstream analysis.

## Installation and Setup

Install gffpandas via Bioconda or pip:

```bash
# Using Conda
conda install -c bioconda gffpandas

# Using pip
pip install gffpandas
```

## Core Usage Patterns

### Loading and Basic Filtering
The library uses a `Gff3DataFrame` object to wrap the underlying Pandas DataFrame.

```python
import gffpandas as gp

# Load a GFF3 file
annotation = gp.read_gff3('genome_annotation.gff')

# Filter for specific feature types (e.g., only genes and exons)
genes_exons = annotation.filter_feature_of_type(['gene', 'exon'])

# Filter by feature length
long_features = annotation.filter_by_length(min_len=1000, max_len=5000)
```

### Attribute Manipulation
One of the most powerful features is the ability to handle the semicolon-separated attributes column.

```python
# Convert the 'attributes' string column into individual columns
# This makes it easy to filter by 'ID', 'Name', or 'Parent'
expanded_df = annotation.attributes_to_columns()

# Filter by specific attribute values
specific_genes = annotation.get_feature_by_attribute(attr_key='ID', attr_value=['gene_01', 'gene_02'])
```

### Exporting Data
gffpandas supports saving filtered results back to GFF3 or converting them to tabular formats.

```python
# Save as a new GFF3 file
annotation.filter_feature_of_type(['gene']).write_gff3('only_genes.gff')

# Export to CSV or TSV
annotation.write_csv('annotation_table.csv')
annotation.write_tsv('annotation_table.tsv')
```

## Expert Tips

- **Method Chaining**: Most filtering methods return a new `Gff3DataFrame` object, allowing you to chain operations:
  `df.filter_feature_of_type(['gene']).filter_by_length(min_len=100).write_gff3('filtered.gff')`
- **Handling Attributes**: Use `attributes_to_columns()` early in your exploratory analysis to see the available metadata, but be aware that in very large GFF files with inconsistent attribute keys, this can significantly increase memory usage.
- **Overlap Analysis**: The library includes an `overlaps_with` function (v0.3.0+) which can be used to find features within specific genomic regions or to identify features that do not overlap with a region (using the `out_of_region` parameter).
- **Pandas Integration**: If you need to perform a custom operation not supported by the library, you can access the raw Pandas DataFrame via `annotation.df`.

## Reference documentation

- [gffpandas Overview](./references/anaconda_org_channels_bioconda_packages_gffpandas_overview.md)
- [gffpandas GitHub Repository](./references/github_com_foerstner-lab_gffpandas.md)
- [gffpandas Version Tags and Features](./references/github_com_foerstner-lab_gffpandas_tags.md)
---
name: ga4ghmongo
description: This tool provides a document-based schema for modeling genomic variants in MongoDB using the GA4GH standard. Use when user asks to model variant data with high fidelity, convert genomic variants into MongoDB-ready dictionaries, or manage variants across multiple variant sets.
homepage: https://github.com/Phelimb/ga4gh-mongo
metadata:
  docker_image: "quay.io/biocontainers/ga4ghmongo:0.0.1.2--py36_0"
---

# ga4ghmongo

## Overview

The `ga4ghmongo` tool provides a document-based schema for genomic variants, bridging the gap between the GA4GH standard and the flexibility of MongoDB. It allows bioinformaticians to model variant data with high fidelity while relaxing certain constraints of the original GA4GH v0.5.1 API—most notably by allowing a single variant to be associated with multiple `VariantSets`. This makes it an ideal choice for complex genomic databases where variants are shared across different experimental or clinical cohorts.

## Installation and Setup

To use the tool within a Python environment, install it via the Bioconda channel:

```bash
conda install bioconda::ga4ghmongo
```

The package requires a running MongoDB instance to store the generated documents.

## Core Usage Patterns

### Programmatic Variant Creation
The primary workflow involves using the `schema` module to define variants. The `Variant.create` method handles the initialization of genomic coordinates and base changes.

```python
from ga4ghmongo.schema import Variant

# Create a single nucleotide polymorphism (SNP)
v = Variant.create(
    start=0, 
    reference_bases="A", 
    alternate_bases=["T"]
)
```

### Database Preparation
Before inserting data into MongoDB, convert the Python object into a dictionary format compatible with the database driver.

```python
# Convert to a MongoDB-ready dictionary
variant_data = v.to_mongo().to_dict()
```

The resulting dictionary includes automatically generated metadata such as:
- `var_hash`: A unique identifier based on the variant's properties.
- `names`: Standardized nomenclature (e.g., "A0T").
- `is_snp`, `is_indel`, `is_insertion`, `is_deletion`: Boolean flags for rapid filtering.
- `created_at` and `updated_at`: Timestamps for data provenance.

### Managing Variant Sets
Unlike standard GA4GH implementations, `ga4ghmongo` uses a list for `variant_sets`, allowing you to tag a variant with multiple identifiers.

```python
# Example of the internal structure for variant sets
# {'variant_sets': ['set_id_1', 'set_id_2']}
```

## Expert Tips

- **Hashing for Deduplication**: Use the `var_hash` field as a unique index in your MongoDB collection to prevent duplicate variant entries while allowing them to be linked to new `variant_sets`.
- **Batch Processing**: When importing large VCF files, instantiate `Variant` objects and collect their `to_dict()` outputs into a list for use with MongoDB's `insert_many()` operation to improve performance.
- **Schema Validation**: The `Variant.create` method performs basic validation on coordinates and bases; always wrap creation in try-except blocks when processing raw external data to catch malformed genomic records.

## Reference documentation
- [ga4ghmongo - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ga4ghmongo_overview.md)
- [GitHub - Phelimb/ga4gh-mongo](./references/github_com_Phelimb_ga4gh-mongo.md)
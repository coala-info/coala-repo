---
name: pytaxonkit
description: pytaxonkit provides a Python interface to the TaxonKit library for querying and manipulating NCBI taxonomy data using pandas DataFrames. Use when user asks to convert scientific names to TaxIDs, retrieve taxonomic lineages, find the lowest common ancestor, filter taxa by rank, or list subtaxa.
homepage: https://github.com/bioforensics/pytaxonkit/
---


# pytaxonkit

## Overview
The `pytaxonkit` skill provides a Pythonic interface to the TaxonKit library, a high-performance tool for manipulating NCBI taxonomy data. This skill allows for efficient querying of taxonomic information without leaving the Python environment. It is particularly useful for processing large lists of species names or TaxIDs, as it leverages pandas for data handling and supports batch operations. Users must ensure the NCBI taxonomy dump files (`names.dmp` and `nodes.dmp`) are available locally, typically in `~/.taxonkit/`.

## Core Functions and Usage

### Name to TaxID Conversion
Convert scientific names to NCBI TaxIDs. Use `sciname=True` to restrict results to official scientific names only.
```python
import pytaxonkit
names = ["Homo sapiens", "Drosophila melanogaster"]
df = pytaxonkit.name2taxid(names)
# Returns DataFrame with columns: Name, TaxID, Rank
```

### Lineage Retrieval
Retrieve full taxonomic lineages for a list of TaxIDs.
```python
# Basic lineage
df = pytaxonkit.lineage([9606, 7227])

# Custom formatted lineage
# Use formatstr to define specific ranks (e.g., {family};{genus};{species})
df = pytaxonkit.lineage([9606], formatstr="{f};{g};{s}")
```

### Lowest Common Ancestor (LCA)
Find the common ancestor for a group of TaxIDs.
```python
# Single LCA for a list
ancestor = pytaxonkit.lca([9606, 9598]) # Human and Chimpanzee

# Multiple LCAs (for sets of TaxIDs)
ancestors = pytaxonkit.lca([[9606, 9598], [7227, 7217]], multi=True)
```

### Filtering by Rank
Filter a list of TaxIDs based on their taxonomic rank (e.g., keep only those at or below 'genus').
```python
# Filter for taxa equal to or higher than phylum
filtered_ids = pytaxonkit.filter(taxids, equal_to='phylum', higher_than='phylum')

# Discard 'no rank' entries
filtered_ids = pytaxonkit.filter(taxids, lower_than='family', discard_norank=True)
```

### Subtaxa Listing
List all subtaxa for a given TaxID.
```python
# Returns a list of (taxon, tree) tuples
results = pytaxonkit.list([9605]) # Genus Homo
for taxon, tree in results:
    subtaxa = [t for t in tree.traverse]
```

## Expert Tips and Best Practices

- **Data Directory**: If your NCBI taxonomy files are not in the default `~/.taxonkit/` directory, specify the path using the `data_dir` parameter in any function call: `pytaxonkit.lineage(ids, data_dir='/path/to/taxdump')`.
- **Pandas Integration**: Since most functions return pandas DataFrames, you can immediately chain operations like `.to_csv()`, `.query()`, or `.merge()` for downstream analysis.
- **Batch Processing**: Always pass lists or pandas Series to functions rather than iterating through individual items in a loop; `pytaxonkit` is optimized for batch queries.
- **Version Checking**: Use `pytaxonkit.__taxonkitversion__` to verify the version of the underlying TaxonKit binary, which may differ from the Python binding version (`pytaxonkit.__version__`).
- **Unsupported Operations**: Note that `pytaxonkit` does not support `cami-filter`, `create-taxdump`, `profile2cami`, or `taxid-changelog`.

## Reference documentation
- [pytaxonkit GitHub Repository](./references/github_com_bioforensics_pytaxonkit.md)
- [pytaxonkit Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pytaxonkit_overview.md)
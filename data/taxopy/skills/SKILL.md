---
name: taxopy
description: taxopy interacts with NCBI-formatted taxonomic databases to manage TaxIds, scientific names, and lineages. Use when user asks to map TaxIds to names, retrieve taxonomic ranks, find the lowest common ancestor, or perform majority-vote consensus taxonomy.
homepage: https://apcamargo.github.io/taxopy/
---


# taxopy

## Overview
The `taxopy` skill enables efficient interaction with NCBI-formatted taxonomic databases. It is designed for bioinformatics workflows where you need to map TaxIds to scientific names, ranks, and full lineages. It is particularly powerful for consensus taxonomy tasks, such as determining the LCA or a majority-vote taxon from a collection of inputs (e.g., metagenomic classification results).

## Core Workflows

### Initializing the Taxonomy Database
The `TaxDb` object is the central database interface. It can download the NCBI taxdump automatically or use local files.

```python
import taxopy

# Option 1: Automatic download from NCBI (files deleted after loading by default)
taxdb = taxopy.TaxDb()

# Option 2: Use local files (faster for repeated use)
taxdb = taxopy.TaxDb(
    nodes_dmp="path/to/nodes.dmp",
    names_dmp="path/to/names.dmp",
    merged_dmp="path/to/merged.dmp",
    keep_files=True
)
```

### Working with Taxon Objects
Initialize a `Taxon` object using a TaxId to access its properties.

```python
taxon = taxopy.Taxon(9606, taxdb) # 9606 = Homo sapiens

print(taxon.name)               # Scientific name
print(taxon.rank)               # e.g., 'species'
print(taxon.name_lineage)        # List of names from taxon to root
print(taxon.rank_name_dictionary) # Mapping of ranks to names
```

### Finding Consensus Taxonomy
Use these functions to aggregate multiple taxonomic assignments.

```python
taxa_list = [taxopy.Taxon(id, taxdb) for id in [9606, 9593, 9975]]

# Lowest Common Ancestor (LCA)
lca = taxopy.find_lca(taxa_list, taxdb)

# Majority Vote
# fraction=0.5 means the taxon must appear in >50% of lineages
majority = taxopy.find_majority_vote(taxa_list, taxdb, fraction=0.5)
```

### Name to TaxId Resolution
Retrieve TaxIds from scientific names. Note that fuzzy matching requires the `rapidfuzz` library.

```python
# Exact match
taxids = taxopy.taxid_from_name("Saccharomyces cerevisiae", taxdb)

# Fuzzy match (if rapidfuzz is installed)
taxids = taxopy.taxid_from_name("Saccharomyces cerevisia", taxdb, fuzzy=True)
```

## Expert Tips
- **Memory Management**: `TaxDb` loads the taxonomy into memory. For large databases like NCBI, ensure the environment has sufficient RAM (several GBs).
- **Legacy Support**: Always provide the `merged.dmp` file when using local files to ensure that old TaxIds are correctly mapped to their current versions via `taxdb.oldtaxid2newtaxid`.
- **Custom Databases**: You can use `taxopy` with non-NCBI databases (like GTDB) as long as they are formatted in the NCBI `nodes.dmp`/`names.dmp` style. Use the `taxdump_url` parameter in `TaxDb` to point to custom tarballs.
- **Performance**: If processing thousands of TaxIds, instantiate `TaxDb` once and reuse it. Avoid re-initializing the database within loops.

## Reference documentation
- [Introduction to taxopy](./references/apcamargo_github_io_taxopy.md)
- [taxopy User Guide](./references/apcamargo_github_io_taxopy_guide.md)
- [taxopy API Reference](./references/apcamargo_github_io_taxopy_reference.md)
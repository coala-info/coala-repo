---
name: rcsbsearch
description: The rcsbsearch skill provides a Pythonic interface to the RCSB Search API, allowing for sophisticated filtering of the Protein Data Bank.
homepage: https://github.com/sbliven/rcsbsearch
---

# rcsbsearch

## Overview
The rcsbsearch skill provides a Pythonic interface to the RCSB Search API, allowing for sophisticated filtering of the Protein Data Bank. It supports two primary styles of query construction: an "operator" syntax using standard Python comparators and bitwise logic, and a "fluent" syntax for method chaining. This tool is essential for bioinformatics workflows that require automated retrieval of PDB IDs or Assembly IDs based on structural or experimental properties.

## Installation
The package can be installed via pip or conda:
```bash
pip install rcsbsearch
# OR
conda install -c bioconda rcsbsearch
```

## Usage Patterns

### 1. Operator Syntax
This style uses Python's bitwise operators (`&` for AND, `|` for OR, `~` for NOT) to combine query objects. It is often more readable for complex logic.

```python
from rcsbsearch import TextQuery, rcsb_attributes as attrs

# Define individual criteria
q1 = TextQuery('"heat-shock transcription factor"')
q2 = attrs.rcsb_struct_symmetry.symbol == "C2"
q3 = attrs.rcsb_entry_info.polymer_entity_count_DNA >= 1

# Combine using bitwise operators
query = q1 & q2 & q3

# Execute by calling the query object with the desired result type
for assembly_id in query("assembly"):
    print(assembly_id)
```

### 2. Fluent Syntax
This style uses method chaining to build the query. It is useful for programmatically adding filters in a sequence.

```python
from rcsbsearch import TextQuery

results = TextQuery("collagen") \
    .and_("rcsb_struct_symmetry.kind").exact_match("Global Symmetry") \
    .and_("rcsb_entry_info.polymer_entity_count_protein").greater_or_equal(3) \
    .exec("entry")

for pdb_id in results:
    print(pdb_id)
```

## Best Practices and Tips
- **Result Types**: When executing a query (using `query("type")` or `.exec("type")`), specify the level of granularity needed. Common types include `"entry"` (PDB IDs), `"assembly"`, and `"polymer_entity"`.
- **Attribute Discovery**: Use the `rcsb_attributes` object to explore available metadata fields. These map directly to the RCSB Search API schema.
- **Text Queries**: Wrap multi-word phrases in double quotes within the `TextQuery` string to ensure the API treats them as a single term.
- **Performance**: The execution returns an iterator. For very large result sets, process them lazily rather than converting to a list immediately to save memory.
- **Schema Reference**: If an attribute name is unknown, refer to the [RCSB Search API Schema](https://search.rcsb.org/rcsbsearch/index.html#search-attributes) as the library attributes mirror this structure.

## Reference documentation
- [rcsbsearch Overview](./references/anaconda_org_channels_bioconda_packages_rcsbsearch_overview.md)
- [rcsbsearch GitHub README](./references/github_com_sbliven_rcsbsearch.md)
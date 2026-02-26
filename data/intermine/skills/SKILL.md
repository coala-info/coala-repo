---
name: intermine
description: InterMine is an open-source data warehouse system that integrates and queries diverse biological data through a unified Python interface. Use when user asks to perform complex genomic queries across biological databases, retrieve data from specific Mines, or manage lists of biological identifiers.
homepage: http://www.intermine.org
---


# intermine

## Overview
InterMine is an open-source data warehouse system that integrates diverse biological data sources, making them searchable through a unified interface. This skill focuses on using the `intermine` Python client to perform complex queries across various "Mines" (e.g., TargetMine, MouseMine, ThaleMine). It allows for the retrieval of genomic, proteomic, and interaction data by connecting to specific web service endpoints, defining path-based queries, and applying constraints to filter results.

## Core Usage Patterns

### Initializing a Service
To interact with a specific database, initialize a `Service` object using the URL of the Mine's web service.
```python
from intermine.webservice import Service
service = Service("https://www.flymine.org/flymine/service")
```

### Creating a Query
Queries are built by selecting "paths" (attributes of biological entities) and adding constraints.
```python
query = service.new_query("Gene")
query.add_view("symbol", "primaryIdentifier", "organism.shortName")
query.add_constraint("organism.shortName", "=", "D. melanogaster")
query.add_constraint("symbol", "=", "zen")

for row in query.rows():
    print(row["symbol"], row["primaryIdentifier"])
```

### Working with Lists
InterMine allows for the creation and manipulation of lists of identifiers (e.g., a list of gene symbols).
```python
# Create a list from a Python list of identifiers
my_list = service.create_list(content=["zen", "bcd", "nos"], list_type="Gene", name="MyGeneList")

# Use a list in a query constraint
query.add_constraint("Gene", "IN", "MyGeneList")
```

## Best Practices
- **Identify the Right Mine**: Use the InterMine Registry or specific organism databases (e.g., YeastMine for *S. cerevisiae*, ThaleMine for *A. thaliana*) to ensure you are querying the most relevant data.
- **Path Logic**: Understand the data model of the specific Mine. Common paths include `Gene.proteins`, `Gene.pathways`, and `Gene.goAnnotation`.
- **Code Generation**: Use the "Generate Python code" button on the InterMine web interface to get a boilerplate script for a query you have built visually, then adapt it using this skill.
- **Batch Processing**: When dealing with large datasets, iterate through `query.rows()` rather than loading all results into memory at once.

## Reference documentation
- [InterMine WebService client Overview](./references/anaconda_org_channels_bioconda_packages_intermine_overview.md)
- [InterMine Home and Resources](./references/intermine_org_index.md)
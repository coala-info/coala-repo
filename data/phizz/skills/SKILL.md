---
name: phizz
description: Phizz queries the Human Phenotype Ontology (HPO) database to retrieve clinical terms and descriptions associated with specific HPO or OMIM identifiers. Use when user asks to query HPO terms, look up OMIM disease phenotypes, or automate clinical case annotation.
homepage: https://github.com/moonso/phizz
---

# phizz

## Overview
Phizz is a specialized command-line utility and Python library designed to bridge the gap between clinical phenotypes and standardized ontologies. It allows researchers and clinicians to programmatically query the HPO database using either specific HPO terms or OMIM disease identifiers. This is particularly useful for automating the annotation of clinical cases or preparing phenotype lists for variant prioritization workflows.

## Command Line Usage

The primary interface for phizz is the `query` command. By default, results are returned in a CSV-style format with headers for HPO IDs and their corresponding descriptions.

### Basic Queries
To retrieve all HPO terms associated with a specific OMIM disease:
```bash
phizz query -m OMIM:615373
```

To look up the description of a specific HPO term:
```bash
phizz query -h HP:0000002
```

### Output Formatting
For downstream data processing, use the JSON flag to get a structured array of objects:
```bash
phizz query -m OMIM:615373 --to_json
```

To save results directly to a file instead of stdout:
```bash
phizz query -m OMIM:615373 -o phenotypes.csv
```

## Python API Integration

Phizz can be integrated directly into Python scripts for more complex workflows.

```python
import phizz

# Query by a list of OMIM IDs
results = phizz.query_disease(['OMIM:615373'])

# The output is a list of dictionaries
for entry in results:
    print(f"{entry['hpo_term']}: {entry['description']}")
```

## Best Practices
- **Identifier Formatting**: Always prefix OMIM IDs with `OMIM:` (e.g., `OMIM:615373`) and HPO terms with `HP:` followed by seven digits to ensure successful database matching.
- **Batch Processing**: When using the Python API, pass multiple IDs in a list to `query_disease` to minimize overhead.
- **Configuration**: If using a custom HPO/OMIM database build, specify the path using the `-c` or `--config` flag.



## Subcommands

| Command | Description |
|---------|-------------|
| phizz build-genes | Create a gene database. |
| phizz query | Query the hpo database.   Print the result in csv format as default. |
| phizz_delete | Deletes the phizz database. |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_moonso_phizz.md)
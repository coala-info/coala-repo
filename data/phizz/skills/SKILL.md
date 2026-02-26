---
name: phizz
description: "phizz links disease identifiers to phenotypic features by querying OMIM and HPO data. Use when user asks to retrieve HPO terms associated with an OMIM ID, get descriptions for specific phenotype terms, or convert disease-phenotype associations into CSV or JSON formats."
homepage: https://github.com/moonso/phizz
---


# phizz

## Overview
phizz is a specialized utility designed to bridge the gap between disease identifiers (OMIM) and phenotypic features (HPO). It provides a streamlined interface for bioinformaticians and clinical geneticists to retrieve structured phenotypic data. The tool is primarily used to identify the clinical features associated with specific genetic disorders or to get detailed descriptions for individual phenotype terms, supporting both command-line operations and direct Python integration.

## Command Line Usage

### Basic Queries
The primary command is `phizz query`. You can search by either HPO terms or OMIM IDs.

*   **Query by OMIM ID**: Retrieve all HPO terms associated with a specific disease.
    ```bash
    phizz query -m OMIM:615373
    ```
*   **Query by HPO Term**: Retrieve the description for a specific phenotype.
    ```bash
    phizz query -h HP:0000002
    ```

### Output Formatting
By default, phizz outputs results in CSV format to the standard output.

*   **JSON Output**: Use the `-j` or `--to_json` flag for structured data that is easier for other tools to parse.
    ```bash
    phizz query -m OMIM:615373 --to_json
    ```
*   **Save to File**: Use the `-o` flag to specify a destination path.
    ```bash
    phizz query -m OMIM:615373 -o phenotypes.csv
    ```

## Python API
For integration into larger bioinformatics pipelines, phizz can be imported directly.

```python
import phizz

# Query disease associations
results = phizz.query_disease(['OMIM:615373'])
for entry in results:
    print(f"{entry['hpo_term']}: {entry['description']}")
```

## Best Practices and Tips
*   **Identifier Prefixing**: Always include the appropriate prefix (`OMIM:` for diseases, `HP:` for phenotypes) to ensure the query engine resolves the terms correctly.
*   **Batch Processing**: While the CLI handles individual terms, the Python API `query_disease` accepts a list, making it more efficient for processing multiple disease IDs in a single script execution.
*   **Data Extraction**: When using the default CSV output, the columns provided are typically `hpo_id` and `description`. If you require more complex metadata, prefer the JSON output which provides a more explicit key-value structure.

## Reference documentation
- [phizz - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_phizz_overview.md)
- [GitHub - moonso/phizz: Query hpo with phenotypes and OMIM terms](./references/github_com_moonso_phizz.md)
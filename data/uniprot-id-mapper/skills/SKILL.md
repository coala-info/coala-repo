---
name: uniprot-id-mapper
description: The uniprot-id-mapper converts UniProt protein accessions to identifiers from other databases and retrieves associated metadata. Use when user asks to map protein IDs, retrieve protein metadata, query proteins by attributes, or list available mapping databases and fields.
homepage: https://github.com/David-Araripe/UniProtMapper
---


# uniprot-id-mapper

## Overview
The `uniprot-id-mapper` (UniProtMapper) is a specialized tool designed to interface with the UniProt Mapping API. It streamlines the process of converting lists of protein accessions into cross-referenced identifiers from other biological databases and allows for the retrieval of specific metadata fields (like gene names, organism, or 3D structure status). It is particularly useful when you need to handle large-scale proteomics datasets or perform sophisticated queries using boolean logic to filter proteins by attributes like length, review status, or modification date.

## CLI Usage Patterns
The primary command for the CLI is `protmap`.

### Basic ID Mapping
To map a list of UniProt accessions to Ensembl IDs:
```bash
protmap -i P30542 Q16678 -from UniProtKB_AC-ID -to Ensembl -o results.csv
```

### Data Retrieval with Specific Fields
To fetch specific metadata for a set of proteins:
```bash
protmap -i P30542 -r accession gene_names organism_name -o protein_info.txt
```

### Using Default Field Sets
If you frequently need a standard set of information, use the `-def` flag to use the package's predefined field list:
```bash
protmap -i Q02880 --default-fields
```

### Discovering Supported Fields
To see all available databases for mapping or return fields for data retrieval:
```bash
protmap --print-fields
```

## Python API Best Practices
For more complex logic, use the Python interface directly.

### Batch Mapping
The `ProtMapper` class returns a pandas DataFrame, making it easy to integrate into data science pipelines.
```python
from UniProtMapper import ProtMapper
mapper = ProtMapper()
result, failed = mapper.get(ids=["P30542", "Q16678"], from_db="UniProtKB_AC-ID", to_db="Ensembl")
```

### Advanced Field-Based Querying
Use the `ProtKB` module to build complex queries with boolean operators:
- `&` (AND)
- `|` (OR)
- `~` (NOT)

```python
from UniProtMapper import ProtKB
from UniProtMapper.uniprotkb_fields import organism_name, reviewed, length

# Query: Reviewed human proteins between 100-200 amino acids
query = organism_name("human") & reviewed(True) & length(100, 200)
protkb = ProtKB()
result = protkb.get(query)
```

## Expert Tips
- **Full Version Fields**: For cross-referenced fields that support extra versioning information, append `_full` to the field name (e.g., `xref_pdb_full`) to retrieve more detailed metadata.
- **Handling Failures**: The `get()` method returns a tuple `(result, failed)`. Always check the `failed` list to identify IDs that did not match in the target database.
- **Database Names**: When using `-from` or `-to`, ensure you use the exact string identifiers required by UniProt (e.g., `UniProtKB_AC-ID` instead of just `UniProt`). Use `protmap --print-fields` to verify these strings.

## Reference documentation
- [UniProtMapper GitHub Repository](./references/github_com_David-Araripe_UniProtMapper.md)
- [UniProtMapper Overview](./references/anaconda_org_channels_bioconda_packages_uniprot-id-mapper_overview.md)
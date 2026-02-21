---
name: rsidx
description: rsidx provides a mechanism for indexing VCF files by rsID, enabling the same high-speed random access for identifiers that tabix provides for genomic coordinates.
homepage: https://github.com/bioforensics/rsidx
---

# rsidx

## Overview

rsidx provides a mechanism for indexing VCF files by rsID, enabling the same high-speed random access for identifiers that tabix provides for genomic coordinates. It functions by creating a lightweight SQLite3 database that maps rsIDs to their respective genomic positions. When a search is performed, rsidx retrieves the coordinates from this index and then utilizes tabix to extract the actual variant data from the VCF. This approach is significantly faster than grepping through a VCF or performing coordinate-based searches when only the rsID is known.

## Installation and Requirements

The tool is best installed via Bioconda:
`conda install -c bioconda rsidx`

**Critical Dependencies:**
- The target VCF file must be compressed with `bgzip` and sorted by genomic coordinates.
- A tabix index (`.tbi`) must exist for the VCF file.
- The `tabix` executable must be available in your `$PATH`.

## Command Line Usage

### Creating an Index
To index a VCF file, provide the compressed VCF and the desired name for the index file (typically ending in `.rsidx` or `.db`).

```bash
rsidx index input.vcf.gz input.rsidx
```

**Expert Tip:** If the index file already exists, the command will fail to prevent accidental overwrites. Use the `--force` flag to overwrite an existing index:
```bash
rsidx index input.vcf.gz input.rsidx --force
```

### Searching by rsID
You can search for one or more rsIDs by passing them as positional arguments after the VCF and index file.

```bash
rsidx search input.vcf.gz input.rsidx rs3114908 rs10756819
```

### Batch Searching from a File
For large-scale lookups, use the `--file` flag to provide a newline-delimited list of rsIDs. This is much more efficient than passing hundreds of IDs as individual arguments.

```bash
rsidx search input.vcf.gz input.rsidx --file rsid_list.txt
```

## Python API Integration

For integration into bioinformatics pipelines, rsidx can be used directly within Python scripts.

```python
import sqlite3
import rsidx

vcf_path = 'data.vcf.gz'
index_path = 'data.rsidx'

# Indexing
with sqlite3.connect(index_path) as dbconn, open(vcf_path, 'r') as vcffh:
    rsidx.index.index(dbconn, vcffh)

# Searching
rsids = ['rs123', 'rs456']
with sqlite3.connect(index_path) as dbconn, open(vcf_path, 'r') as vcffh:
    for line in rsidx.search.search(rsids, dbconn, vcffh):
        print(line.strip())
```

## Best Practices

1. **Index Portability**: Since the index is a standard SQLite3 database, you can move it between systems as long as the relative path to the VCF remains consistent or you update your search command to point to the new VCF location.
2. **Memory Efficiency**: rsidx is designed to be memory-efficient by leveraging the SQLite index and tabix's stream-based access, making it suitable for very large VCFs (e.g., dbSNP).
3. **ID Formatting**: Ensure the rsIDs in your search query exactly match the format in the VCF's ID column (e.g., including or excluding the 'rs' prefix as per your specific file's convention).

## Reference documentation
- [rsidx README and API Guide](./references/github_com_bioforensics_rsidx.md)
- [rsidx Version History and Tags](./references/github_com_bioforensics_rsidx_tags.md)
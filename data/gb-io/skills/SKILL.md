---
name: gb-io
description: The gb-io library provides a high-performance Python interface for parsing and writing GenBank files using a Rust-based backend. Use when user asks to parse GenBank records efficiently, iterate through large genomic files, extract specific features or qualifiers, or serialize records back to GenBank format.
homepage: https://github.com/althonos/gb-io.py
---


# gb-io

## Overview
The `gb-io` library provides a Python interface to a fast GenBank parser written in Rust. It is designed for speed and memory efficiency, utilizing a copy-on-access pattern that only moves data to the Python heap when specifically accessed. This makes it an excellent choice for high-throughput bioinformatics pipelines that require extracting specific features or sequences from large GenBank records without the overhead of full object model instantiation.

## Usage Patterns

### Efficient Loading and Iteration
For small files, you can load all records into memory. For large files, always use the iterator to maintain a low memory footprint.

```python
import gb_io

# Load all records into a list
records = gb_io.load("data.gb")

# Iterate over records (Memory Efficient)
for record in gb_io.iter("large_data.gb"):
    print(f"Processing: {record.name}")
```

### Accessing Features and Qualifiers
Features are stored in the `features` attribute of a record. Qualifiers are stored as a list of objects with `key` and `value` attributes.

```python
for record in gb_io.iter("sequence.gb"):
    # Filter for specific feature types (e.g., CDS)
    for feature in filter(lambda f: f.kind == "CDS", record.features):
        # Convert qualifiers list to a dictionary for easier access
        qualifiers = {q.key: q.value for q in feature.qualifiers}
        
        # Access specific tags (values are lists)
        gene_name = qualifiers.get("gene", ["unknown"])[0]
        translation = qualifiers.get("translation", [""])[0]
```

### Serializing Records
You can write records back to GenBank format using the `dump` method. This supports both file paths and file-like objects.

```python
# Writing a list of records to a file
with open("output.gb", "wb") as dst:
    gb_io.dump(records, dst)
```

## Expert Tips
- **Copy-on-Access**: Remember that `gb-io` only copies data to Python when you access an attribute. If you only need the `name` and `features`, the `sequence` data remains in the Rust-managed memory, saving significant time and RAM.
- **Binary Mode**: When using file-like objects with `gb_io.dump`, ensure the file is opened in binary mode (`"wb"`) to handle the serialization correctly.
- **Performance Comparison**: `gb-io` can be up to 8x faster than Biopython's `SeqIO`. If a script processing GenBank files is a bottleneck, replacing the parser with `gb-io` is often the simplest optimization.

## Reference documentation
- [gb-io.py GitHub Repository](./references/github_com_althonos_gb-io.py.md)
- [gb-io Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gb-io_overview.md)
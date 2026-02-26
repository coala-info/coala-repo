---
name: simplesam
description: Simplesam provides a lightweight Pythonic interface for reading, manipulating, and writing SAM alignment records. Use when user asks to parse SAM files, modify record tags and attributes, or filter alignment data within Python scripts.
homepage: http://mattshirley.com
---


# simplesam

## Overview

The `simplesam` skill provides a lightweight, Pythonic interface for interacting with SAM records. It is particularly useful for quick scripts, data transformation tasks, and bioinformatics workflows where ease of installation and pure-Python compatibility are prioritized over the high-performance requirements of massive-scale alignment processing.

## Usage Guidelines

### Installation and Setup
The tool is primarily distributed via Bioconda. Ensure the environment is configured to use the `bioconda` channel.
```bash
conda install -c bioconda simplesam
```

### Core Python API Patterns
When using `simplesam` within Python scripts, follow these standard patterns for reading and iterating over records:

```python
import simplesam

# Reading from a SAM file or stdin
with simplesam.Sam(open('alignments.sam', 'r')) as sam:
    for record in sam:
        # Accessing basic fields
        name = record.qname
        pos = record.pos
        
        # Checking flags
        if record.mapped:
            print(f"Read {name} mapped to {record.rname} at {pos}")
            
        # Accessing tags
        if 'NM' in record.tags:
            edit_distance = record.tags['NM']
```

### Common Record Attributes
Use these attributes for concise record manipulation:
- `record.qname`: Query template name
- `record.flag`: Integer bitwise flag
- `record.rname`: Reference sequence name
- `record.pos`: 1-based leftmost mapping position
- `record.mapq`: Mapping quality
- `record.cigar`: CIGAR string
- `record.seq`: Segment sequence
- `record.qual`: ASCII of Phred-scaled base quality

### Filtering and Transformation
`simplesam` objects are mutable. You can modify records and write them back to a new SAM file:

```python
with simplesam.Sam(open('input.sam')) as in_sam:
    # The header is preserved from the input file
    with simplesam.Writer(open('output.sam', 'w'), in_sam.header) as out_sam:
        for record in in_sam:
            if record.mapq > 30:
                # Add a custom tag
                record.tags['X1'] = 'HighQuality'
                out_sam.write(record)
```

## Best Practices
- **Memory Efficiency**: `simplesam` processes records one at a time. Always use the iterator pattern (`for record in sam`) rather than loading all records into a list to avoid memory exhaustion on large files.
- **File Handles**: Always use context managers (`with` statements) when opening SAM files to ensure file handles are closed properly, especially when piping data.
- **Pure Python Limitation**: Remember that `simplesam` is written in pure Python. For extremely large datasets (hundreds of millions of reads), consider pre-filtering data with `samtools` before passing it to `simplesam`.

## Reference documentation
- [simplesam Overview](./references/anaconda_org_channels_bioconda_packages_simplesam_overview.md)
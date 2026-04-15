---
name: pyslow5
description: pyslow5 is a Python interface for reading, writing, and analyzing nanopore raw signal data in SLOW5 and BLOW5 formats. Use when user asks to read or write SLOW5/BLOW5 files, extract nanopore raw signal data, perform random access by read ID, or access file metadata and auxiliary fields.
homepage: https://github.com/hasindu2008/slow5lib
metadata:
  docker_image: "quay.io/biocontainers/pyslow5:1.4.0--py311he8b63cb_0"
---

# pyslow5

## Overview
pyslow5 is the Python interface for slow5lib, a library designed for efficient storage and analysis of nanopore raw signal data. While the standard FAST5 format relies on the complex HDF5 framework, SLOW5/BLOW5 offers a streamlined alternative that enables faster parallel access and significantly smaller storage footprints. This skill assists in implementing data extraction, random access by read ID, and file conversion workflows within Python-based bioinformatics pipelines.

## Installation and Setup
The package is primarily distributed via Bioconda.
```bash
conda install -c bioconda pyslow5
```

## Core Usage Patterns

### Reading Records
pyslow5 supports both sequential and random access. Random access requires a SLOW5 index file (`.idx`).

```python
import pyslow5

# Open a SLOW5/BLOW5 file
s5 = pyslow5.Open('data.blow5', 'r')

# 1. Sequential Reading (Generator)
reads = s5.seq_reads()
for read in reads:
    read_id = read['read_id']
    raw_signal = read['signal'] # Returns a numpy array
    sampling_rate = read['sampling_rate']
    
# 2. Random Access (Requires .idx file)
# If data.blow5.idx exists, it is loaded automatically
read = s5.get_read('read_id_string', aux=["read_group", "digitisation"])
if read:
    print(read['signal'])

s5.close()
```

### Fetching Metadata and Auxiliary Fields
Header attributes and auxiliary fields (like `median_before` or `channel_number`) are accessed through specific methods.

```python
# Get a list of all read IDs in the file
read_ids = s5.get_read_ids()

# Get header attributes
version = s5.get_header_attr('slow5_version')

# Get auxiliary field names
aux_fields = s5.get_aux_names()
```

### Writing and Appending
When creating new files, you must define the header and any auxiliary fields before writing records.

```python
# Open for writing
s5 = pyslow5.Open('output.blow5', 'w')

# Add header attributes
s5.add_header_attr('flow_cell_id', 'FAH12345')

# Add auxiliary fields
s5.add_aux_field("median_before", "double")

# Write a record (dictionary format)
record = {
    'read_id': 'read_1',
    'read_group': 0,
    'digitisation': 8192.0,
    'offset': 10.0,
    'range': 1400.0,
    'sampling_rate': 4000.0,
    'len_raw_signal': len(signal_array),
    'signal': signal_array
}
s5.write_record(record)
s5.close()
```

## Expert Tips and Best Practices
- **Format Choice**: Always prefer **BLOW5** (binary) over SLOW5 (ASCII) for production pipelines. BLOW5 is significantly faster to parse and smaller in size.
- **Compression**: Use **zstd** compression for BLOW5 if portability to very old systems isn't a concern; it offers a better compression-to-speed ratio than the default zlib.
- **Indexing**: If you perform random access, ensure you have an index. You can generate one using the CLI tool `slow5tools index` if it's missing.
- **Memory Management**: For large datasets, always use the `seq_reads()` generator rather than loading all signals into a list to avoid OOM (Out of Memory) errors.
- **Data Types**: Note that `read['signal']` returns a 1D NumPy array of integers. To convert these to picoamperes (pA), use the formula: `(raw_signal + offset) * range / digitisation`.

## Reference documentation
- [github_com_hasindu2008_slow5lib.md](./references/github_com_hasindu2008_slow5lib.md)
- [anaconda_org_channels_bioconda_packages_pyslow5_overview.md](./references/anaconda_org_channels_bioconda_packages_pyslow5_overview.md)
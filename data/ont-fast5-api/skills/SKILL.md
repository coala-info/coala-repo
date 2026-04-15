---
name: ont-fast5-api
description: The ont-fast5-api is a toolkit for manipulating and interacting with HDF5-based .fast5 files produced by Oxford Nanopore sequencers. Use when user asks to convert between single-read and multi-read formats, subset reads by ID, demultiplex data based on summary files, or programmatically access raw signal data.
homepage: https://github.com/nanoporetech/ont_fast5_api
metadata:
  docker_image: "quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0"
---

# ont-fast5-api

## Overview

The `ont-fast5-api` is the standard toolkit for interacting with HDF5-based .fast5 files produced by Oxford Nanopore sequencers. Use this skill to handle data organization tasks, such as batching thousands of small single-read files into efficient multi-read files (which significantly improves filesystem performance and tool compatibility) or extracting specific reads for downstream analysis. It provides both a suite of command-line utilities and a Python API for direct data access.

## Command Line Interface (CLI) Patterns

### Converting Single-Read to Multi-Read
Modern ONT pipelines prefer multi-read files. Use this to batch single files into larger containers.
```bash
single_to_multi_fast5 --input_path ./single_reads --save_path ./multi_reads --batch_size 4000 --threads 4 --recursive
```
*   **Tip**: A `batch_size` of 4000 is the standard default for balancing file size and performance.
*   **Tip**: Use `--filename_base` to customize the output prefix (e.g., `--filename_base run_metadata`).

### Converting Multi-Read to Single-Read
Use this for legacy tools that do not support multi-read formats.
```bash
multi_to_single_fast5 --input_path ./multi_reads --save_path ./single_reads --recursive
```

### Subsetting Reads
Extract specific reads from a large dataset using a list of Read IDs.
```bash
fast5_subset --input ./multi_reads --save_path ./subset_output --read_id_list ids_to_extract.txt --recursive
```
*   **Input**: The `read_id_list` can be a simple text file (one ID per line) or a sequencing_summary.txt file.

### Demultiplexing
Organize reads into folders based on barcode information found in a summary file.
```bash
demux_fast5 --input ./multi_reads --save_path ./demuxed --summary_file sequencing_summary.txt --demultiplex_column barcode_arrangement
```

## Python API Usage

For custom analysis, use the `get_fast5_file` interface. It abstracts the difference between single- and multi-read formats.

```python
from ont_fast5_api.fast5_interface import get_fast5_file

# Works for both single-read and multi-read files
with get_fast5_file("data.fast5", mode="r") as f5:
    for read in f5.get_reads():
        read_id = read.read_id
        raw_data = read.get_raw_data()
        # Access attributes like sampling rate
        sampling_rate = read.get_channel_info()['sampling_rate']
```

## Expert Tips

1.  **Performance**: Always use the `--threads` (or `-t`) flag in CLI tools when processing large datasets to utilize multi-core CPUs.
2.  **Compression**: If files are uncompressed, use the `fast5_compress` utility (if available in your environment) or specify compression in the API to save significant disk space.
3.  **Validation**: If files appear corrupted, ensure they follow the schema using the `ont_h5_validator` (a separate ONT tool often used alongside this API).
4.  **File Modes**: When using the Python API, always use context managers (`with` statements) to ensure HDF5 file handles are closed correctly, preventing file corruption.

## Reference documentation
- [ont-fast5-api GitHub README](./references/github_com_nanoporetech_ont_fast5_api.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ont-fast5-api_overview.md)
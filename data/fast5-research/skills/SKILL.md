---
name: fast5-research
description: This tool provides a Python API and command-line utilities for manipulating, reading, and writing Oxford Nanopore FAST5 files. Use when user asks to extract raw signal data, generate synthetic nanopore datasets, create read summaries, or perform granular HDF5 file manipulation for sequencing research.
homepage: https://github.com/nanoporetech/fast5_research
metadata:
  docker_image: "quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0"
---

# fast5-research

## Overview

The `fast5-research` skill provides the procedural knowledge required to handle ONT's HDF5-based FAST5 format. This tool is essential for research workflows involving raw signal analysis, custom basecalling, or the generation of synthetic nanopore datasets. It offers a Python API for granular file manipulation and several command-line utilities for indexing and summarizing sequencing runs. Use this skill when general HDF5 libraries are insufficient for maintaining the specific schemas required by Nanopore software.

## Installation

The package can be installed via pip or Conda:

```bash
# Via pip
pip install fast5_research

# Via Conda (Bioconda channel)
conda install bioconda::fast5-research
```

## Python API Usage

### Reading FAST5 Files
Always use the `Fast5` class as a context manager to ensure file handles are properly closed.

```python
from fast5_research import Fast5

with Fast5('input.fast5') as fh:
    # Extract raw signal data
    raw = fh.get_read(raw=True)
    # Get summary metadata
    summary = fh.summary()
    print(f"Read length: {len(raw)} samples")
```

### Writing New FAST5 Files
Writing requires specific metadata dictionaries to ensure the resulting file is valid. The library enforces type checking and presence of required fields.

**Required Metadata Structures:**
- `channel_id`: Includes `digitisation`, `offset`, `range`, `sampling_rate`, and `channel_number`.
- `read_id`: Includes `start_time`, `duration`, `read_number`, `start_mux`, `read_id` (UUID), and `scaling_used`.
- `tracking_id`: Includes `exp_start_time`, `run_id`, and `flow_cell_id`.

**Writing Pattern:**
```python
import numpy as np
from uuid import uuid4
from fast5_research import Fast5

# Raw data MUST be np.int16
raw_data = np.array([100, 105, 98], dtype=np.int16)

with Fast5.New('output.fast5', 'w', tracking_id=tracking_id, 
              context_tags={}, channel_id=channel_id) as h:
    h.set_raw(raw_data, meta=read_id, read_number=1)
```

## Command Line Utilities

The package includes several CLI tools for batch processing:

- `extract_read_summary`: Generates a TSV summary of reads within FAST5 files.
- `filter_from_bam`: Creates a filter TSV file based on a BAM alignment and a sequencing summary.
- `fast5_index`: (Internal) Used for indexing large collections of FAST5 files for faster access.

## Best Practices and Expert Tips

1. **Data Type Enforcement**: The library will refuse to write raw data if it is not explicitly cast to `np.int16`. Always use `.astype(np.int16)` before calling `set_raw`.
2. **Digitization Logic**: When converting float voltage signals to integer raw data, use the formula: `raw = (voltage / (range / digitisation)) + offset`.
3. **Bulk vs. Single-Read**: Use the `Fast5` interface for bulk files (multi-read) and `Fast5.New` specifically when creating standardized single-read files for tools that do not support multi-read formats.
4. **Resource Management**: When processing thousands of files, explicitly close handles or use context managers to avoid "Too many open files" OS errors, as HDF5 handles are resource-intensive.

## Reference documentation
- [fast5-research Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fast5-research_overview.md)
- [fast5-research GitHub Repository](./references/github_com_nanoporetech_fast5_research.md)
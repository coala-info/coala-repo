---
name: genomedata
description: Genomedata provides high-performance storage and random access for multiple tracks of genomic signal data using the HDF5 format. Use when user asks to create a genomic data archive, load signal tracks from Wiggle or BED files, query specific genomic regions, or programmatically access track data via a Python API.
homepage: http://genomedata.hoffmanlab.org
---

# genomedata

## Overview

Genomedata is a specialized high-performance storage format designed to handle multiple tracks of numeric data anchored to a reference genome. Unlike flat files (like Wiggle or BED) which require exhaustive parsing, Genomedata utilizes HDF5 to provide near-instant random access to hundreds of gigabytes of data with a minimal disk footprint. This skill enables the efficient transformation of raw bioinformatics outputs into structured archives that are optimized for downstream analysis and parallel processing.

## Core CLI Workflows

### Creating an Archive (Convenience Method)
The `genomedata-load` command is the primary entry point for creating a new archive from sequence and signal files.

```bash
genomedata-load -s <sequence.fa> -t <trackname>=<signal.wig> <archive_name>
```
*   **Note**: Use multiple `-s` flags for multiple sequence files and multiple `-t` flags for different data tracks.
*   **Expert Tip**: Always put glob filenames in quotes (e.g., `-s "chr*.fa"`) to prevent the shell from expanding them before the tool can process them.

### Manual Loading Pipeline (Fine-grained Control)
For parallel loading or adding tracks to existing archives, use the underlying command sequence:

1.  **Initialize Sequence**: `genomedata-load-seq <archive> <sequence.fa>`
2.  **Open Tracks**: `genomedata-open-data <archive> <trackname1> <trackname2>`
3.  **Stream Data**: `genomedata-load-data <archive> <trackname> < <signal_file>`
4.  **Finalize**: `genomedata-close-data <archive>`

### Querying and Inspection
*   **List Tracks**: `genomedata-info tracknames <archive>`
*   **Check Sizes**: `genomedata-info sizes <archive>`
*   **Extract Data**: `genomedata-query -c <chrom> -s <start> -e <end> -t <trackname> <archive>`

## Python API Best Practices

To access data programmatically, use the `Genome` object as a context manager to ensure file handles and HDF5 resources are cleaned up automatically.

```python
from genomedata import Genome

with Genome("path/to/archive") as genome:
    # Access a specific chromosome
    chrom = genome["chr1"]
    
    # Slice data: [start:end, track_index_or_name]
    # Uses zero-based, half-open indexing (standard Python/BED convention)
    data = chrom[100:200, "my_track"]
    
    # Access underlying sequence (returned as uint8 array)
    seq_array = chrom.seq[100:110]
```

## Expert Tips and Constraints

*   **Sequence Matching**: Ensure chromosome names (e.g., `chr1`) in signal files match the FASTA headers exactly.
*   **Implementation Choice**: Genomedata automatically chooses between a directory-based archive (better for parallel access, <100 sequences) and a single-file archive (better for distribution, >100 sequences).
*   **Compression**: After running `genomedata-close-data`, you can further compress the archive using the external tool `h5repack` to save additional disk space.
*   **Hardmasking**: Use `genomedata-hardmask` to filter out specific regions from tracks after they have been loaded, which is useful for removing blacklisted genomic regions.
*   **BigWig Support**: The Python API can transparently open `.bw` files as if they were Genomedata archives, though they are limited to a single track.



## Subcommands

| Command | Description |
|---------|-------------|
| genomedata-histogram | Print a histogram of values from a genomedata archive |
| genomedata-info | Print information about a genomedata archive. |
| genomedata-load | Create Genomedata archive named GENOMEDATAFILE by loading specified track data and sequences. If GENOMEDATAFILE already exists, it will be overwritten. |
| genomedata-load-seq | Start a Genomedata archive at GENOMEDATAFILE with the provided sequences. SEQFILEs should be in fasta format, and a separate Chromosome will be created for each definition line. |
| genomedata-query | print data from genomedata archive in specified trackname and coordinates |
| genomedata_genomedata-close-data | Compute summary statistics for data in Genomedata archive and ready for accessing. |

## Reference documentation
- [Genomedata 1.7.4 Documentation](./references/genomedata_hoffmanlab_org_doc_1.7.4_genomedata.html.md)
- [Genomedata GitHub README](./references/github_com_hoffmangroup_genomedata_blob_master_README.rst.md)
- [Random Access Performance Script](./references/genomedata_hoffmanlab_org_performance_scripts_genomedata_random_access.py.md)
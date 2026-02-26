---
name: genomedata
description: "Genomedata stores and manages large-scale genomic track data in a high-performance HDF5-based format for fast random access. Use when user asks to create genomic archives from sequence files, load numeric tracks from BED or Wiggle files, query specific genomic regions, or access track data via the Python API."
homepage: http://genomedata.hoffmanlab.org
---


# genomedata

## Overview
Genomedata is a specialized high-performance format designed to store multiple tracks of numeric genomic data anchored to a reference genome. It leverages HDF5 to provide fast random access and a small disk footprint, making it ideal for handling hundreds of gigabytes of functional genomics data (like ChIP-seq or RNA-seq tracks). This skill provides the necessary patterns for loading data into archives, querying values, and inspecting archive metadata.

## Core CLI Workflows

### Creating a Genomedata Archive
The loading process typically involves two steps: loading the sequence/assembly information and then loading the numeric data tracks.

1.  **Initialize with Sequence/Assembly:**
    ```bash
    # Load from FASTA files
    genomedata-load-seq ARCHIVE_NAME chromosome1.fa chromosome2.fa
    
    # Or initialize using chromosome sizes (without sequence data)
    genomedata-load-seq --sizes ARCHIVE_NAME chrom.sizes
    ```

2.  **Load Data Tracks:**
    ```bash
    # Load tracks from BED, bedGraph, or Wiggle files
    # Note: Quote globs to ensure they are parsed by genomedata-load
    genomedata-load ARCHIVE_NAME -s "data_dir/*.bedgraph"
    ```

### Querying and Inspection
*   **Extract Data:** Use `genomedata-query` to retrieve values for specific regions.
    ```bash
    genomedata-query ARCHIVE_NAME --track TRACKNAME --coords CHR START END
    ```
*   **List Tracks:** View all available tracks in an archive.
    ```bash
    genomedata-info tracknames ARCHIVE_NAME
    ```
*   **Summary Statistics:** Generate histograms or view contig information.
    ```bash
    genomedata-histogram ARCHIVE_NAME TRACKNAME
    genomedata-info contigs ARCHIVE_NAME
    ```

## Python API Usage
For high-performance access within scripts, use the `genomedata` Python package.

```python
import genomedata

with genomedata.Genome("path/to/archive") as genome:
    # Access a specific chromosome
    chrom = genome["chr1"]
    
    # Slice data: [start:end, track_index_or_name]
    # Returns a NumPy array
    data = chrom[100:200, ["track1", "track2"]]
    
    # Access track names
    print(genome.tracknames)
```

## Best Practices
*   **Input Formatting:** Ensure BED/bedGraph files are sorted by genomic coordinate before loading to prevent errors.
*   **Memory Efficiency:** When performing massive random access, use the "offline" pattern (sorting input positions first) to minimize HDF5 seek overhead.
*   **Large Gaps:** `genomedata-close-data` automatically trims large gaps between supercontigs to save space.
*   **Platform Support:** While primarily tested on Linux (x86_64, aarch64), it is compatible with Python 3.9+ and requires HDF5 libraries.

## Reference documentation
- [Genomedata Homepage](./references/genomedata_hoffmanlab_org_index.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_genomedata_overview.md)
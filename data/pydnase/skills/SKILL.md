---
name: pydnase
description: pydnase is designed specifically for the nuances of DNase-seq data, where the focus is on the 5' end of aligned fragments (the "cut site") rather than the full fragment overlap typical of ChIP-seq.
homepage: http://jpiper.github.io/pyDNase
---

# pydnase

## Overview
pydnase is designed specifically for the nuances of DNase-seq data, where the focus is on the 5' end of aligned fragments (the "cut site") rather than the full fragment overlap typical of ChIP-seq. It provides a Python API for efficient, cached random access to cut counts and includes command-line implementations of the Wellington footprinting algorithms.

## Core Python API Usage
The library interfaces with sorted and indexed BAM files to provide strand-specific cut counts.

```python
import pyDNase

# Initialize the BAM handler
# pyDNase.example_reads() provides a path to a sample BAM for testing
reads = pyDNase.BAMHandler("path/to/your/sorted_indexed.bam")

# Query a specific genomic location
# Format: "chrom,start,end,strand"
# Returns a dictionary with '+' and '-' numpy arrays of cut counts
data = reads["chr6,170863500,170863532,+"]

print(data['+']) # Counts on positive strand
print(data['-']) # Counts on negative strand
```

## Command Line Tools
pydnase installs several scripts for common DNase-seq workflows.

### Wellington Footprinting
The primary utility of pydnase is identifying digital genomic footprints—regions of protection within hypersensitive sites where transcription factors are bound.

- **wellington_footprints.py**: The standard implementation for identifying footprints.
- **wellington_1D.py**: A faster, 1D version of the algorithm for rapid analysis.

### Best Practices
- **Indexing**: Ensure your BAM files are sorted and indexed (`samtools index`) before use, as pydnase relies on random access.
- **Caching**: By default, `BAMHandler` caches queried data. If performing a massive genome-wide scan where memory is a concern, consider the memory footprint of the cache.
- **Strand Awareness**: Always account for the 5' offset. pydnase specifically looks at the 5' most end of the aligned fragment to pinpoint the DNase I cleavage event.

## Reference documentation
- [pyDNase Introduction](./references/jpiper_github_io_pyDNase.md)
- [Bioconda pydnase Overview](./references/anaconda_org_channels_bioconda_packages_pydnase_overview.md)
---
name: pybedtools
description: pybedtools is a Python wrapper for the BEDTools suite that enables genomic interval manipulation and "genome algebra" directly within Python scripts. Use when user asks to perform operations like intersections or subtractions on genomic files, iterate over individual genomic intervals, or convert between BED files and Pandas DataFrames.
homepage: https://github.com/daler/pybedtools
metadata:
  docker_image: "quay.io/biocontainers/pybedtools:0.12.0--py310h275bdba_0"
---

# pybedtools

## Overview
pybedtools is a powerful Python wrapper for the BEDTools suite, designed to facilitate "genome algebra" directly within Python scripts. It transforms genomic files into `BedTool` objects, allowing you to chain operations like intersections and subtractions as if they were native Python methods. Beyond simple wrapping, it provides feature-level access, allowing you to iterate over individual genomic intervals and manipulate their attributes (chrom, start, stop, etc.) using standard Python syntax.

## Core Usage Patterns

### Initializing BedTool Objects
You can create a `BedTool` from a file path, a string, or even an existing Python iterable.
```python
from pybedtools import BedTool

# From a file (supports gzipped files automatically)
a = BedTool('peaks.bed.gz')

# From a string (useful for small examples or testing)
b = BedTool("""
chr1 100 200
chr1 150 300
""", from_string=True)
```

### Method Chaining and Arguments
Every BEDTools command is available as a method on the `BedTool` object. Command-line flags are passed as keyword arguments.
```python
# Equivalent to: intersectBed -a a.bed -b b.bed -wa -u
result = a.intersect(b, wa=True, u=True)

# Chaining multiple operations
# Intersect a and b, then subtract c from the result
final = a.intersect(b).subtract('exclude.bed')
```

### Feature-Level Manipulation
Iterating over a `BedTool` yields `Interval` objects.
```python
for feature in a:
    print(feature.chrom, feature.start, feature.stop, feature.name)
    # Access by index for non-standard columns
    score = feature[4] 
```

## Expert Tips and Best Practices

### Memory Management with Streaming
For massive datasets, use `stream=True`. This uses Unix pipes under the hood, processing features one by one rather than loading the entire result into memory or writing a full temporary file.
```python
# Efficiently find the closest gene to each SNP without large temp files
nearby = genes.closest(snps, d=True, stream=True)
```

### Temporary File Cleanup
pybedtools creates temporary files for intermediate steps. While it attempts to manage these, in long-running scripts or loops, you should manually trigger cleanup to avoid filling up `/tmp`.
```python
import pybedtools
# Delete all temporary files created by pybedtools so far
pybedtools.cleanup(remove_all=True)
```

### Integration with Pandas
One of the strongest features of pybedtools is the ability to move between genomic intervals and DataFrames.
```python
# Convert BedTool to Pandas DataFrame
df = a.to_dataframe()

# Convert Pandas DataFrame back to BedTool
new_bed = BedTool.from_dataframe(df)
```

### Handling GFF/GTF Attributes
When working with GFF or GTF files, pybedtools provides a helper to parse the attributes string (column 9).
```python
gff = BedTool('genes.gff')
for gene in gff:
    # Access attributes like a dictionary
    gene_id = gene.attrs['gene_id']
```

### Sorting Requirements
Many BEDTools operations (like `map` or `merge`) require sorted input. You can sort on the fly:
```python
sorted_bed = a.sort()
merged_bed = sorted_bed.merge(d=100)
```

## Reference documentation
- [pybedtools GitHub Repository](./references/github_com_daler_pybedtools.md)
- [pybedtools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pybedtools_overview.md)
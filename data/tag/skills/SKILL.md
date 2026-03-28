---
name: tag
description: The Toolkit for Annotating Genomes (tag) provides a Python API and command-line interface for processing, transforming, and managing GFF3 genomic annotation files. Use when user asks to collapse overlapping features into loci, merge GFF3 files, extract specific feature types, or map protein coordinates to nucleotide coordinates.
homepage: https://github.com/standage/tag/
---

# tag

## Overview
The Toolkit for Annotating Genomes (`tag`) is a specialized utility designed to handle the complexities of genomic text formatting and feature management. While many bioinformatic tools are cumbersome, `tag` provides a streamlined Python API and a set of CLI subcommands to perform common operations like feature collapsing, summary generation, and coordinate mapping. It is particularly useful for researchers who need to programmatically interact with GFF3 files or perform quick transformations on the command line.

## CLI Usage and Patterns

The `tag` package installs a command-line interface that provides several subcommands for rapid data processing.

#

## Python API Best Practices

For more complex workflows, use the `tag` Python module directly.

### Reading and Filtering Features
The core of the API is the `GFF3Reader`. You can iterate through features and use the `select` module to filter for specific types.

```python
import tag

# Initialize the reader for a GFF3 file
reader = tag.GFF3Reader(infilename='annotations.gff3')

# Select only 'gene' features and iterate
for gene in tag.select.features(reader, type='gene'):
    # Access sub-features (like exons) directly from the gene object
    exons = [feat for feat in gene if feat.type == 'exon']
    print(f'Gene {gene.id} has {len(exons)} exons')
```

### Feature Management
- **Coordinate Handling**: `tag` handles 1-based GFF3 coordinates internally. When performing arithmetic on positions, ensure you are accounting for the inclusive nature of GFF3 boundaries.
- **Attribute Access**: Genomic attributes (like ID, Parent, Name) are accessible as properties on the feature objects.
- **Parent-Child Relationships**: The library automatically handles the hierarchical structure of GFF3 files, allowing you to traverse from genes to mRNAs to exons/CDSes easily.

## Expert Tips
- **Large Files**: For very large GFF3 files, ensure they are sorted by coordinate and indexed. `tag` includes a named index data structure for efficient querying of specific genomic regions.
- **Validation**: Use the built-in validation logic to check for common GFF3 errors, such as mismatched Parent IDs or features that extend beyond the boundaries of their parents.
- **ID Preservation**: When writing modified GFF3 files back to disk, use the `retainids` mode if you need to keep the original ID attributes exactly as they were in the input.



## Subcommands

| Command | Description |
|---------|-------------|
| tag bae | Group features in GFF3 files into loci. |
| tag bcollapse | Collapse overlapping features in GFF3 files into loci. |
| tag gff3 | Processes GFF3 files. |
| tag merge | Merges multiple GFF3 files into a single GFF3 file. |
| tag occ | Extracts features of a given type from a GFF3 file. |
| tag pep2nuc | Converts protein-coordinate GFF3 features to their corresponding nucleotide coordinates in a genome-coordinate GFF3 file. |
| tag pmrna | Parses and processes a GFF3 file for pmRNA analysis. |
| tag_locuspocus | Group features into loci based on overlap and proximity. |
| tag_sum | Briefly summarize a GFF3 file |

## Reference documentation
- [tag: Toolkit for Annotating Genomes](./references/github_com_standage_tag.md)
- [tag CLI and Module Commits](./references/github_com_standage_tag_commits_master.md)
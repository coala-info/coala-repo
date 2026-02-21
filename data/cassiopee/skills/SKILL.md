---
name: cassiopee
description: Cassiopee is a specialized tool for indexing and scanning genomic sequences.
homepage: https://github.com/osallou/cassiopee-c
---

# cassiopee

## Overview
Cassiopee is a specialized tool for indexing and scanning genomic sequences. It is a C-based implementation designed for speed and efficiency, utilizing compressed suffix trees to manage large datasets. It is particularly useful when you need to find specific motifs or patterns within a genome while accounting for biological variation like mutations or sequencing errors.

## CLI Usage and Patterns

### Preparing Input Data
Cassiopee requires a specific input format: a single-line sequence file with no headers (no FASTA format).
- **Conversion**: Use the companion tool `CassiopeeKnife` to convert standard FASTA files into the required one-line format.
- **Sequence Types**: Supports DNA, RNA, and protein sequences.

### Basic Search
To search for a pattern within a sequence file:
```bash
Cassiopee -s <sequence_file> -p <pattern>
```

### Advanced Search Options
While specific flags for Hamming distance and indels are managed via the CLI, always check the help menu for version-specific parameter limits:
```bash
Cassiopee -h
```

- **Morphism Support**: Use the `-b` option to enable morphism support during the search process.
- **Index Depth**: For short patterns relative to a very large sequence, you can limit the maximum index depth to significantly reduce indexing time.

### Performance and Large Datasets
- **Index Persistence**: For large datasets, Cassiopee allows you to save the indexed sequence. This prevents the need to re-index the entire sequence for subsequent searches.
- **Memory Management**: If you encounter performance bottlenecks on large files, ensure the sequence is strictly one line, as headers or line breaks will cause parsing errors or unexpected behavior.

### Visualization and Debugging
Cassiopee can generate a representation of its internal suffix tree:
1. Generate the dot file using the internal graph method.
2. Convert to an image using Graphviz:
```bash
dot -Tpng cassiopee.dot > cassiopee.png
```

## Expert Tips
- **Validation**: If a search with errors (substitutions/indels) is returning unexpected results, verify the sequence indexing. In some versions, tree reduction can affect search sensitivity; ensure you are using the latest stable release (e.g., 1.0.9+).
- **Testing**: You can run the internal test suite to verify the environment's compatibility:
```bash
bin/test_cassiopee
# or
cd test && ctest -V
```

## Reference documentation
- [Cassiopee-c README](./references/github_com_osallou_cassiopee-c.md)
- [Bioconda Cassiopee Overview](./references/anaconda_org_channels_bioconda_packages_cassiopee_overview.md)
---
name: phylopandas
description: PhyloPandas provides a seamless bridge between specialized phylogenetic data formats and the standard Python data science stack.
homepage: https://github.com/Zsailer/phylopandas
---

# phylopandas

## Overview
PhyloPandas provides a seamless bridge between specialized phylogenetic data formats and the standard Python data science stack. By wrapping Biopython and DendroPy, it allows you to load biological sequences and evolutionary trees directly into Pandas DataFrames. This enables you to use familiar Pandas operations—like `.loc`, `.groupby()`, and `.merge()`—on biological data, making it an essential tool for data cleaning, metadata integration, and exploratory analysis in bioinformatics.

## Core Usage Patterns

### Reading Phylogenetic Data
PhyloPandas provides several top-level functions to load data. Each returns a standard Pandas DataFrame where rows represent sequences or nodes.

```python
import phylopandas as ph

# Read sequence data
df_fasta = ph.read_fasta('sequences.fasta')
df_phylip = ph.read_phylip('sequences.phy')

# Read tree data
df_tree = ph.read_newick('tree.newick')
df_nexus = ph.read_nexus('tree.nexus')

# Read BLAST results (XML)
df_blast = ph.read_blast('results.xml')
```

### The .phylo Accessor
PhyloPandas uses the `pandas_flavor` library to register a `.phylo` accessor on all DataFrames. This is the primary interface for writing data and specialized phylogenetic operations.

#### Writing and Converting Formats
You can convert between formats by reading one and writing another via the accessor.

```python
# Convert FASTA to Clustal
df = ph.read_fasta('data.fasta')
df.phylo.to_clustal('data.clustal')

# Convert Newick to Nexus
df_t = ph.read_newick('tree.nwk')
df_t.phylo.to_nexus('tree.nexus')
```

#### Visualization
If `phylovega` is installed, you can visualize trees directly from the DataFrame.

```python
df.phylo.display(height=500)
```

### Data Manipulation Tips
Since the resulting object is a standard DataFrame, you can perform complex filtering that would be difficult in standard sequence editors:

*   **Filter by length:** `df[df['sequence'].str.len() > 500]`
*   **Search for motifs:** `df[df['sequence'].str.contains('ATG...TGA')]`
*   **Merge Metadata:** Use `pd.merge()` to attach experimental metadata to sequences based on their ID/label.

## Supported Formats
*   **Sequences:** FASTA, Phylip (including relaxed and sequential variants), Clustal, BLAST XML.
*   **Trees:** Newick, Nexus.

## Expert Tips
*   **BLAST Parsing:** The `read_blast` function is particularly useful for converting complex BLAST XML output into a flat table for rapid hit filtering.
*   **Memory Management:** For extremely large genomic files, remember that Pandas loads the entire dataset into memory. For multi-gigabyte files, consider filtering the data using Biopython's generators before passing a subset to PhyloPandas.
*   **ID Consistency:** When merging sequence DataFrames with tree DataFrames, ensure that the `id` column in the sequence DataFrame matches the `label` or `taxon` column in the tree DataFrame.

## Reference documentation
- [Zsailer/phylopandas GitHub Repository](./references/github_com_Zsailer_phylopandas.md)
- [PhyloPandas Commit History](./references/github_com_Zsailer_phylopandas_commits_master.md)
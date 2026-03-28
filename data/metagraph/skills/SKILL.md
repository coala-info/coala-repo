---
name: metagraph
description: MetaGraph is a bioinformatics suite that constructs, manipulates, and queries large-scale sequence graphs using succinct data structures. Use when user asks to build de Bruijn graphs, clean sequencing errors, annotate graph nodes, or align reads to a graph index.
homepage: https://github.com/ratschlab/metagraph
---


# metagraph

## Overview

MetaGraph is a high-performance bioinformatics suite designed to handle massive sequence datasets using succinct data structures. It represents genomic or protein data as annotated graphs, enabling efficient search and alignment across millions of samples. It is particularly effective for petabase-scale sequence repositories where traditional indexing methods fail due to memory or storage constraints.

## CLI Usage Patterns

### Alphabet Selection
MetaGraph uses specialized binaries for different alphabets to optimize performance. Ensure you call the correct binary for your data type:
- `metagraph`: Default binary, optimized for DNA {A, C, G, T}.
- `metagraph_DNA5`: Use for DNA sequences including the ambiguity code {A, C, G, T, N}.
- `metagraph_Protein`: Use for amino acid sequences.

### Graph Construction
Build a de Bruijn graph from FASTA/FASTQ files.
```bash
metagraph build -k <kmer_size> -o <output_prefix> <input_fasta>
```
- **Expert Tip**: Use `-v` (verbose) for large builds to monitor progress.
- **K-mer Size**: Choose `k` based on the complexity of the organism and sequencing error rate (commonly 21-31 for genomes).

### Cleaning and Error Correction
Remove sequencing errors (low-frequency k-mers) to simplify the graph.
```bash
metagraph clean -i <input_graph> -o <cleaned_graph> --fallback <threshold>
```

### Annotation
Add labels or metadata (e.g., sample IDs, expression counts) to the graph nodes.
```bash
metagraph annotate -i <graph_file> --anno-label <label_name> -o <output_anno> <input_files>
```

### Querying and Alignment
Search for sequences or align reads against the constructed graph.
```bash
# Query k-mer presence
metagraph query -i <graph_file> -a <annotation_file> <query_fasta>

# Sequence-to-graph alignment
metagraph align -i <graph_file> -a <annotation_file> <reads_fastq>
```

## Best Practices

- **Batch Operations**: MetaGraph's succinct data structures are highly optimized for batched operations. Always prefer processing multiple sequences in a single command rather than calling the tool repeatedly for individual sequences.
- **Memory Management**: For extremely large graphs, MetaGraph utilizes `mmap` and `jemalloc`. Ensure your system has sufficient virtual memory address space.
- **Server Mode**: For repetitive queries, use the server mode to keep the index in memory and interact via the Python API.
- **Custom Alphabets**: If working with non-standard sequences, MetaGraph supports custom alphabet definitions during the build phase.



## Subcommands

| Command | Description |
|---------|-------------|
| metagraph | metagraph is a tool for working with sequence graphs. |
| metagraph | metagraph is a tool for working with graphs constructed from sequence data. |
| metagraph | metagraph is a tool for constructing, manipulating, and querying sequence graphs. |

## Reference documentation
- [MetaGraph GitHub Repository](./references/github_com_ratschlab_metagraph.md)
- [MetaGraph README](./references/github_com_ratschlab_metagraph_blob_master_README.md)
- [MetaGraph Dockerfile (Build Instructions)](./references/github_com_ratschlab_metagraph_blob_master_Dockerfile.md)
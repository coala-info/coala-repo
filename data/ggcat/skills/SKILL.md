---
name: ggcat
description: ggcat (Compacted and Colored de Bruijn Graph Construction and Querying) is a high-performance bioinformatics tool designed to transform raw sequencing reads into compacted de Bruijn graphs.
homepage: https://github.com/algbio/ggcat
---

# ggcat

## Overview
ggcat (Compacted and Colored de Bruijn Graph Construction and Querying) is a high-performance bioinformatics tool designed to transform raw sequencing reads into compacted de Bruijn graphs. It excels at handling "colored" graphs, which allow you to track which specific input files contain which k-mers. The tool provides multiple output representations to optimize for graph size or path properties and includes a dedicated query mode for rapid k-mer lookups against built graphs.

## Graph Construction
The `build` command is the primary entry point for creating graphs.

### Basic Construction
To build a standard compacted de Bruijn graph from FASTA/FASTQ files:
```bash
ggcat build -k <kmer_length> -j <threads> <input_files> -o <output.fasta.lz4>
```

### Colored Graphs
Colored graphs associate k-mers with their source files. By default, the filename is the color name.
- **Enable colors**: Add the `-c` flag.
- **Custom color mapping**: Use a tab-separated file (`color\tpath`) with the `-d` flag.
```bash
# Example color_mapping.txt:
# sample_A    reads_1.fq
# sample_A    reads_2.fq
# sample_B    genome.fa

ggcat build -k 31 -c -d color_mapping.txt -o colored_graph.fasta.lz4
```

### Output Representations
ggcat supports several algorithms to represent k-mer sets efficiently:
- **Maximal Unitigs**: Default output.
- **Simplitigs**: Use `--simplitigs` for a more compact representation.
- **Matchtigs/Eulertigs**: Use `--greedy-matchtigs` or `--eulertigs` for minimum-size plain-text representations.
- **GFA Output**: Use `--gfa-v1` or `--gfa-v2` for Graphical Fragment Assembly formats.

## Querying Graphs
The `query` command checks for the presence of k-mers from a query file in an existing graph.

### Uncolored Query
```bash
ggcat query -k <k_value> <input_graph> <query.fasta>
```

### Colored Query
When querying a colored graph, ggcat looks for a `.colors.dat` file with the same base name as the graph.
- **Standard query**: `ggcat query -c -k 31 graph.fasta.lz4 query.fasta`
- **Human-readable colors**: By default, colors are integers. To get filenames in the output, use `-f JsonLinesWithNames`.
- **Mapping recovery**: Use `ggcat dump-colors <colormap.colors.dat> <output.txt>` to export the integer-to-filename mapping.

## Performance and Resource Tuning
- **Memory Management**: Use `-m <GB>` to set a suggested memory limit for temporary file storage. Use `-p` (prefer-memory) to force the tool to use the allocated memory before spilling to disk.
- **Multiplicity**: By default, k-mers with a count of 1 are filtered out. Use `-s 1` to include all k-mers or increase it to filter noise in high-coverage data.
- **Threading**: Always specify `-j` to match your available CPU cores for optimal speed.
- **Temporary Files**: ggcat creates a `.temp_files` directory. You can change this with `-t <dir>`.

## Expert Tips
- **K-mer Consistency**: The `-k` value used during `query` must be identical to the one used during `build`.
- **Input Lists**: If you have hundreds of input files, use `-l <file_list.txt>` instead of passing them as individual arguments to avoid shell command length limits.
- **Compression**: The default output is lz4 compressed. Most downstream tools require decompression or specific library support.

## Reference documentation
- [GGCAT GitHub Repository](./references/github_com_algbio_ggcat.md)
- [Bioconda ggcat Package](./references/anaconda_org_channels_bioconda_packages_ggcat_overview.md)
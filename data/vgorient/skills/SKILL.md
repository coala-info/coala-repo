---
name: vgorient
description: vgorient is a toolkit for normalizing the orientation and starting positions of circular DNA sequences within a variation graph. Use when user asks to construct pangenome graphs for circular genomes, identify universal cutoff nodes, or rotate and orient sequences to a common reference point.
homepage: https://github.com/whelixw/vgOrient
metadata:
  docker_image: "quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0"
---

# vgorient

## Overview

vgorient is a specialized toolkit for the pangenome analysis of circular DNA, such as mitochondrial genomes. It solves the problem of inconsistent starting points and orientations in sequence data by providing a workflow to construct variation graphs, identify universal "cutoff" nodes, and rotate circular paths to a common reference point. By leveraging the `vg` (Variation Graph) toolkit and `odgi`, it allows researchers to build highly accurate pangenome representations where all sequences are oriented and synchronized, facilitating better variant calling and comparative genomics.

## Core Workflows and CLI Usage

### 1. Pangenome Normalization (Main Wrapper)
The primary entry point for orienting and rotating sequences based on k-mer Jaccard similarity.

```bash
python jaccard_dit_wrapper.py datasets/your_folder/*.fasta \
    --vg_output_dir VG_OUTPUT_DIR \
    --output PROJECT_NAME \
    --orientation \
    --min_jaccard_init \
    -w 512 \
    -m 256
```
*   `--orientation`: Enables the orientation normalization step.
*   `-w`: Sets the band width for mapping (default 512).
*   `-m`: Sets the maximum node length for graph construction (default 256).

### 2. Iterative Graph Construction
To build a variation graph from a list of FASTA files iteratively, adding one sequence at a time to the pangenome.

```bash
python VG_iterative.py input_list.txt -o output_graphs -t 10
```
*   `input_list.txt`: A text file containing paths to FASTA files.
*   `-t`: Number of threads for mapping and augmentation.

### 3. Identifying Cutoff Nodes
Before rotating paths, you must identify a node that is present in all paths (or the majority of paths) to serve as the new "start" point.

```bash
python Cutoff_Node.py path_to_graph.odgi [path_to_graph.vg]
```
This script generates a `*_cutoff_nodes.txt` file containing candidate node IDs that represent universal segments in the pangenome.

### 4. Path Rotation and Orientation
Once a cutoff node is selected, use this script to rotate the GFA paths and output a synchronized FASTA file.

```bash
python Rotation_and_Orientation.py input.gfa output.fasta <cutoff_node_id>
```
*   The script will rotate the sequence so it begins at the specified node.
*   If the path traverses the node in the reverse orientation (`-`), it will reverse-complement the sequence accordingly.

## Expert Tips and Best Practices

*   **Environment Setup**: Always ensure `vg`, `odgi`, and the `bdsg` Python bindings are installed. The tool is best managed via a Conda environment using the `bioconda` and `conda-forge` channels.
*   **Circularization**: When using `VG_iterative.py`, the tool automatically attempts to circularize the initial reference graph using `vg circularize`. Ensure your initial reference sequence is a complete circular molecule.
*   **Memory Management**: For large pangenomes, the `vg index` steps (GCSA and XG) can be memory-intensive. Use the `-t` flag to limit thread usage if you encounter OOM (Out of Memory) errors.
*   **GFA Parsing**: If you need to find specific coordinates of a node within the pangenome paths, use `OOP_gfa_parser.py`:
    ```bash
    python OOP_gfa_parser.py graph1.gfa graph2.gfa --node <node_id>
    ```



## Subcommands

| Command | Description |
|---------|-------------|
| jaccard_dit_wrapper.py | Run kmer_jaccard.py and VG_diterative.py |
| vgorient_noisify.py | Adds random transformations to FASTA files. |

## Reference documentation

- [Main README and Installation](./references/github_com_whelixw_vgOrient_blob_main_README.md)
- [Jaccard Wrapper Documentation](./references/github_com_whelixw_vgOrient_blob_main_jaccard_dit_wrapper.py.md)
- [Cutoff Node Identification](./references/github_com_whelixw_vgOrient_blob_main_Cutoff_Node.py.md)
- [Rotation and Orientation Logic](./references/github_com_whelixw_vgOrient_blob_main_Rotation_and_Orientation.py.md)
- [Iterative Construction Workflow](./references/github_com_whelixw_vgOrient_blob_main_VG_iterative.py.md)
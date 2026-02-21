---
name: vgorient
description: The `vgorient` toolset (also known as MitoGraphs) is a specialized collection of scripts designed to solve the "starting point" and "strand orientation" problems inherent in circular mitochondrial DNA.
homepage: https://github.com/whelixw/vgOrient
---

# vgorient

## Overview
The `vgorient` toolset (also known as MitoGraphs) is a specialized collection of scripts designed to solve the "starting point" and "strand orientation" problems inherent in circular mitochondrial DNA. Because mitochondrial sequences in FASTA files often begin at arbitrary positions or exist on different strands, they create unnecessarily complex variation graphs. This skill provides the procedural knowledge to use `vgorient` to rotate and flip these sequences into a canonical state, facilitating cleaner graph construction and more accurate downstream alignments.

## Installation
The tool is available via Bioconda. It is recommended to run it within a dedicated environment.
```bash
conda install -c bioconda vgorient
```

## Core Workflow: Standardizing Mitochondrial Sequences
The primary method for processing a set of mitochondrial sequences is using the Jaccard-based iterative wrapper. This script calculates k-mer similarities to determine the best orientation and rotation for each sequence relative to the set.

### Basic Command Pattern
```bash
jaccard_dit_wrapper.py datasets/species/*.fasta \
  --vg_output_dir ./vg_results \
  --output standardized_mito \
  --orientation \
  --min_jaccard_init \
  -w 512 -m 256
```

### Key Parameters
- `--orientation`: Enables the algorithm to flip sequences to the reverse complement if it improves the Jaccard similarity score.
- `--min_jaccard_init`: Uses an initial Jaccard similarity pass to order the sequences before processing.
- `-w` (Window Size): Sets the window size for the mapping/alignment phase (default often 512).
- `-m` (Max Node Size): Controls the maximum node length in the resulting graph (default often 256).

## Specialized Script Usage

### High-Throughput K-mer Rotation
If you only need to rotate sequences based on k-mer density without building a full graph:
```bash
kmer_rotation_multiprocessing.py -i input_list.txt -o ./rotated_fastas -t 8
```

### Handling Complex Rotations
When standard string-searching fails due to repetitive regions in the mitochondria, use the "rebuild" variant of the rotation script. This builds the new FASTA directly from the graph nodes:
```bash
cut_and_rot_rebuild.py --fasta input.fasta --gfa graph.gfa --rotation_point 5000
```

### Simulation and Testing
To test the robustness of a pangenome pipeline, use `noisify.py` to randomly rotate and flip existing sequences:
```bash
noisify.py input.fasta --output noisy_input.fasta
```

## Expert Tips and Best Practices
- **Node Size Management**: When constructing graphs with `vg`, setting a max node length (e.g., `-m 1024`) prevents nodes from being smaller than the longest shared sequence, which can improve the stability of the `vgorient` iterative process.
- **Memory Efficiency**: For large datasets, use the `jaccard_dit_wrapper.py` which is optimized for iterative processing rather than attempting to load all permutations into memory.
- **File Extensions**: Ensure input files use the `.fasta` extension; some internal scripts in the suite specifically look for this extension rather than `.fa`.
- **Header Consistency**: Use the option to rename FASTAs to the first word in the header to avoid downstream issues with complex FASTA IDs in the variation graph.

## Reference documentation
- [vgorient Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vgorient_overview.md)
- [vgOrient GitHub Repository](./references/github_com_whelixw_vgOrient.md)
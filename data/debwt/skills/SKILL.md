---
name: debwt
description: "deBWT rapidly constructs BWT indexes from DNA sequences using a de Bruijn graph-based data structure. Use when user asks to build a BWT index, process repetitive genomes, or construct indexes for large collections of DNA sequences."
homepage: https://github.com/DixianZhu/deBWT
---


# debwt

## Overview
deBWT is a specialized tool designed for the rapid construction of BWT indexes from DNA sequences. Unlike traditional suffix-sorting methods that struggle with long common prefixes in repetitive genomes, deBWT utilizes a de Bruijn graph-based data structure to facilitate suffix comparisons. It is optimized for high-performance computing environments, requiring significant RAM and disk space to process large collections of genomes (e.g., multiple human genomes) in parallel.

## Installation and Setup
deBWT must be compiled from source on a Linux system. It has a hard dependency on **Jellyfish** for k-mer counting.

1. **Install Jellyfish**: Ensure Jellyfish is installed and note its binary directory.
2. **Compile deBWT**:
   ```bash
   cd deBWT
   make
   ```

## Command Line Usage
The basic syntax for index construction is:
```bash
./deBWT -o <output_file> -j <jellyfish_dir> -t <threads> <input_fasta>
```

### Parameters
- `-o`: (Required) Path for the resulting BWT string output file.
- `-j`: (Required) The directory containing the Jellyfish executable.
- `-t`: (Optional) Number of threads to use for parallel construction (Default: 8).
- `-k`: (Optional) k-mer length used for the de Bruijn graph structure (Default: 32).
- `input_sequence`: Path to the input DNA sequence in FASTA format.

## Best Practices and Expert Tips

### Handling Uncertain Characters ('N')
deBWT cannot process sequences containing 'N' or other non-ACGT characters. You must pre-process your FASTA files using the included utility:
```bash
./otherTool/transferN <input_with_N.fasta> <output_cleaned.fasta>
```

### Resource Allocation
- **Memory**: deBWT is memory-intensive during the k-mer counting phase. For 10 human genomes (~30 Gbp), expect to allocate at least 120GB of RAM.
- **Disk Space**: Ensure the temporary directory has sufficient space for intermediate files. A 10-human-genome project may require ~200GB of temporary disk space. These files are automatically deleted upon successful completion.

### Optimization
- **Parallelization**: deBWT scales well with additional cores. On multi-core servers, increase the `-t` parameter to match your available hardware threads to significantly reduce construction time.
- **K-mer Selection**: While the default `k=32` is suitable for most genomic tasks, adjusting `-k` can impact the efficiency of the de Bruijn branch encoding depending on the specific repeat structure of the target genome.

## Reference documentation
- [deBWT Introduction and Usage](./references/github_com_DixianZhu_deBWT.md)
- [Utility Tools](./references/github_com_DixianZhu_deBWT_tree_master_otherTool.md)
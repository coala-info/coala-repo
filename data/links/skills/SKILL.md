---
name: links
description: LINKS is a genomics tool that uses long-range sequence data and k-mer pairs to scaffold draft genome assemblies. Use when user asks to scaffold contigs, increase assembly continuity, or run alignment-free genome scaffolding workflows.
homepage: https://github.com/bcgsc/LINKS
metadata:
  docker_image: "quay.io/biocontainers/links:2.0.1--h9948957_7"
---

# links

## Overview
LINKS (Long Interval Nucleotide K-mer Scaffolder) is a specialized genomics application used to increase the continuity of draft genome assemblies. By utilizing long-range sequence data—such as ONT/PacBio reads or even other draft genomes—LINKS identifies k-mer pairs that span across contig boundaries to join them into scaffolds. It is an alignment-free approach, making it computationally efficient for large genomes. Use this skill to guide the execution of scaffolding workflows, parameter optimization, and interpretation of assembly outputs.

## Command Line Usage

The primary entry point for the application is the `LINKS` shell script, which acts as a wrapper for the underlying Makefile-based pipeline (`LINKS-make`).

### Basic Execution
To run LINKS with default parameters, you must provide the draft assembly and a "file-of-filenames" (fof) containing the paths to your long reads.

```bash
LINKS -f draft_assembly.fa -s long_reads.fof
```

### Key Parameters
- `-f`: Path to the input draft assembly (FASTA).
- `-s`: A text file listing the full paths to long-read files (FASTA or FASTQ).
- `-k`: K-mer size (default is 15).
- `-d`: Distance(s) between k-mer pairs. Multiple distances can be provided (e.g., `-d 500,1000,2000`).
- `-t`: Step size for k-mer extraction. Smaller steps increase sensitivity but use more memory.
- `-j`: Number of threads. **CRITICAL**: Do not exceed 4 threads (`-j 4`), as the tool currently throws errors beyond this limit.
- `-z`: Minimum contig size to consider for scaffolding.
- `-a`: Minimum number of links to suggest a scaffold join.

### Input Requirements
The `-s` flag does not take sequence files directly. You must create a `.fof` file:
```bash
# Example of creating a .fof file
ls /path/to/reads/*.fastq > long_reads.fof
```

## Expert Tips and Best Practices

### Performance and Memory
- **Version 2.0+ Advantage**: Always prefer v2.0.1 or higher. The C++ implementation provides ~5x less memory usage and ~3x faster runtimes compared to the legacy Perl implementation.
- **Bloom Filters**: LINKS uses Bloom filters to manage k-mer space. For large genomes (>1Gbp), if RAM is limited, you can increase the False Positive Rate (FPR) to save memory, though this may impact runtime.
- **Iterative Scaffolding**: You can reuse Bloom filters from previous runs using the `-r` option to save time during parameter exploration.

### Workflow Optimization
- **Distance Stratification**: When using multiple distances with `-d`, LINKS v1.8.1+ prioritizes shorter distances first to build a stable local layout before applying longer-range links.
- **Gap Handling**: LINKS prioritizes paths with shorter gaps when there are no ambiguous distances.
- **ARCS/ARKS Integration**: LINKS is frequently used as the final step in the ARCS/ARKS pipeline to perform the actual scaffolding of contig pairs linked by barcode information.

### Output Interpretation
- **.scaffolds.fa**: The final scaffolded assembly.
- **.assembly_correspondence.tsv**: A human-readable file mapping new scaffolds to original contigs, including orientation and link support.
- **.gv**: A Graphviz-compatible file representing the scaffold graph. Use this to visualize complex merges or problematic regions in the assembly.

## Reference documentation
- [LINKS GitHub Repository](./references/github_com_bcgsc_LINKS.md)
- [Bioconda LINKS Overview](./references/anaconda_org_channels_bioconda_packages_links_overview.md)
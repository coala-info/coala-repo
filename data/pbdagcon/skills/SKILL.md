---
name: pbdagcon
description: pbdagcon generates high-quality consensus sequences by applying directed acyclic graphs to multiple sequence alignments. Use when user asks to generate a consensus sequence from alignments, perform HGAP-style read correction, or refine sequence quality using PacBio data.
homepage: https://github.com/jgurtowski/pbdagcon_python
metadata:
  docker_image: "quay.io/biocontainers/pbdagcon:0.1--boost1.60_0"
---

# pbdagcon

## Overview
pbdagcon (Directed Acyclic Graph Consensus) is a specialized tool for sequence consensus that utilizes directed acyclic graphs to encode multiple sequence alignments. By aligning reads to a "backbone" sequence, the tool identifies discrepancies and applies dynamic programming to the DAG to determine the optimal consensus sequence. While optimized for PacBio raw sequence data, it is a general-purpose consensus tool that accepts FASTA inputs and can be used iteratively to refine sequence quality.

## CLI Usage and Workflows

### Basic Consensus Generation
The simplest use case involves generating a consensus from BLASR alignments in `-m 5` format.

```bash
# Generate consensus from -m 5 alignments
pbdagcon mapped.m5 > consensus.fasta
```

### HGAP Read Correction Workflow
For Hierarchical Genome Assembly Process (HGAP) style correction, pbdagcon requires a multi-step pipeline using auxiliary Python scripts to process `-m 4` alignments.

1. **Filter Alignments**: Remove chimeras and low-quality mappings.
   ```bash
   filterm4.py mapped.m4 > mapped.m4.filt
   ```

2. **Convert to Pre-alignments**: Use the adapter script to format the data for the consensus engine.
   ```bash
   # Usage: m4topre.py <filtered_m4> <filtered_m4_ref> <reads_fasta> <min_length>
   m4topre.py mapped.m4.filt mapped.m4.filt reads.fasta 24 > mapped.pre
   ```

3. **Execute Consensus**: Run the core engine, typically utilizing multiple threads for performance.
   ```bash
   pbdagcon -j 4 -a mapped.pre > corrected.fasta
   ```

## Expert Tips and Best Practices

- **Alignment Formats**: 
    - **-m 5**: Can be fed directly into `pbdagcon`.
    - **-m 4**: Must be processed through `m4topre.py` before running the consensus.
- **Short Read Handling**: If working with shorter read sequences, you must adjust BLASR alignment parameters to ensure the alignment strings are properly formatted for the DAG algorithm.
- **Iterative Refinement**: The output consensus can be used as a new backbone for a subsequent round of alignment and consensus to further improve base-calling accuracy.
- **Threading**: Use the `-j` flag to specify the number of consensus threads. This is critical for large datasets as the DAG construction and dynamic programming steps are computationally intensive.
- **Automation**: For standard correction tasks, look for the `pbdagcon_wf.sh` script in the source directory which automates the filtering, conversion, and correction steps.

## Reference documentation
- [pbdagcon_python README](./references/github_com_jgurtowski_pbdagcon_python.md)
---
name: smartdenovo
description: SMARTdenovo is a high-performance assembler that produces unitigs and consensus sequences directly from raw long-read sequencing data without a prior error-correction step. Use when user asks to assemble long reads into unitigs, generate a draft genome assembly, or create a Makefile for a multi-step assembly workflow.
homepage: https://github.com/ruanjue/smartdenovo
---


# smartdenovo

## Overview

SMARTdenovo is a high-performance assembler tailored for the characteristics of long-read sequencing data. Unlike many assemblers that require a computationally expensive error-correction step before assembly, SMARTdenovo produces unitigs directly from all-vs-all raw read alignments. It is composed of several modular tools (wtzmo, wtgbo, wtclp, wtcns) coordinated by a central Perl wrapper. While it produces accurate consensus sequences, the output is typically intended to be polished further by platform-specific tools like Quiver or Nanopolish.

## Command Line Usage

The primary interface for SMARTdenovo is the `smartdenovo.pl` script, which generates a Makefile to manage the multi-step assembly process.

### Standard Assembly Workflow

1. **Prepare Input**: Ensure reads are in FASTA format. If starting with FASTQ, convert them first:
   ```bash
   # Example conversion using sed
   sed -n '1~4s/^@/>/p;2~4p' reads.fastq > reads.fa
   ```

2. **Generate Makefile**:
   ```bash
   smartdenovo.pl -p my_assembly -c 1 reads.fa > my_assembly.mak
   ```
   * `-p`: Prefix for all output files.
   * `-c 1`: Enables the generation of consensus sequences (default is 0, which only produces raw unitigs).

3. **Execute Assembly**:
   ```bash
   make -f my_assembly.mak
   ```

### Output Files

* `prefix.lay.utg`: Raw unitig layouts.
* `prefix.cns`: Final consensus unitig sequences in FASTA format.
* `prefix.mak`: The generated Makefile containing the specific tool parameters.

## Advanced Configuration and Best Practices

### Dot Matrix Alignment (DMO)
For maximum speed, SMARTdenovo supports a "Smith-Waterman free" algorithm called dot matrix alignment. This is significantly faster for large datasets.

* **Manual Trigger**: Add `-U -1 -m 0.1` to the `wtzmo` overlapping stage.
* **Automated Script**: Use the provided `run_dmo.sh` for a pre-configured DMO pipeline, which has been validated on E. coli, Yeast, and Drosophila datasets.

### Tool-Specific Functions
If you need to run components individually for custom pipelines:
* **wtzmo**: Handles the initial read overlapping.
* **wtgbo**: Rescues missing overlaps to improve assembly contiguity.
* **wtclp**: Identifies and trims low-quality regions and chimeric reads.
* **wtcns / wtmsa**: Generates the unitig consensus sequences.

### Expert Tips
* **Memory Management**: SMARTdenovo is memory-efficient, but for very large genomes, ensure your environment has sufficient RAM for the all-vs-all alignment phase.
* **Polishing**: Always treat the `.cns` output as a "draft" assembly. For high-accuracy applications (e.g., variant calling), follow up with platform-specific polishers.
* **Parallelization**: The generated Makefile supports parallel execution. Use `make -j <threads> -f prefix.mak` to speed up the assembly on multi-core systems.

## Reference documentation
- [SMARTdenovo Main Repository](./references/github_com_ruanjue_smartdenovo.md)
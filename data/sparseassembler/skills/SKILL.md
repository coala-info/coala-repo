---
name: sparseassembler
description: SparseAssembler is a genome assembly tool that utilizes a sparse k-mer graph to minimize memory consumption during the assembly of large-scale genomic data. Use when user asks to assemble a genome from sequencing reads, reduce memory usage during the assembly process, or build a sparse k-mer graph with specific skip sizes.
homepage: https://github.com/yechengxi/SparseAssembler
metadata:
  docker_image: "quay.io/biocontainers/sparseassembler:20160205--h9948957_11"
---

# sparseassembler

## Overview

SparseAssembler is a genome assembly tool that optimizes memory consumption by utilizing a sparse k-mer graph. Unlike traditional assemblers that store every k-mer, this tool skips a user-defined number of intermediate k-mers, significantly reducing the memory footprint without a proportional loss in assembly quality. It is particularly effective for large-scale genomic projects where computational resources are a constraint.

## Command Line Usage

The basic execution pattern for SparseAssembler involves specifying k-mer parameters, genome size estimates, and input files.

### Basic Assembly Command
```bash
./SparseAssembler k 51 g 10 GS 2000000000 NodeCovTh 1 EdgeCovTh 0 f reads_1.fastq f reads_2.fastq
```

### Parameter Guidance

*   **k (k-mer size):** Supports values from 15 to 127. Larger k-mers can resolve more repeats but require higher coverage.
*   **g (skip size):** The number of skipped intermediate k-mers (1–25). Increasing `g` reduces memory usage but may impact the connectivity of the graph.
*   **f (input files):** Used to specify FASTA or FASTQ files. Each file must be preceded by the `f` flag (e.g., `f file1.fq f file2.fq`).
*   **GS (Genome Size):** Estimated genome size in base pairs. This is used for memory pre-allocation. It is highly recommended to set this to ~3x the expected genome size for optimal performance.
*   **NodeCovTh (Node Coverage Threshold):** Threshold for removing spurious k-mers (0–16). Default is 1. Increase this for high-coverage data to filter out sequencing errors.
*   **EdgeCovTh (Edge Coverage Threshold):** Threshold for removing spurious links (0–16). Default is 0.
*   **PathCovTh:** Coverage threshold for spurious paths during breadth-first search (0–100).
*   **LD (Load Graph):** Set to 1 to load a previously saved k-mer graph, or 0 to build a new one.

## Best Practices and Expert Tips

*   **Memory Pre-allocation:** The `GS` parameter is critical. If the value is too small, the assembler may fail or perform poorly during graph construction. Always lean toward a larger estimate.
*   **Input Handling:** SparseAssembler treats all `f` inputs as a single pool of reads. If you have paired-end data, provide both files using the `f` flag; however, note that the tool primarily focuses on the k-mer graph construction rather than advanced scaffolding using mate-pair distances.
*   **Noise Reduction:** In datasets with high error rates, increasing `NodeCovTh` to 2 or 3 can significantly clean the graph and improve contig N50, though it may slightly reduce total assembly length.
*   **Performance Tuning:** The `g` parameter is the primary lever for memory control. A common starting point is `g 10`. If the process exceeds available RAM, increase `g`.

## Reference documentation
- [SparseAssembler README](./references/github_com_yechengxi_SparseAssembler.md)
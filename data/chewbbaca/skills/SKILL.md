---
name: chewbbaca
description: chewBBACA is a comprehensive suite for creating, evaluating, and applying core genome and whole genome MultiLocus Sequence Typing schemas. Use when user asks to create a schema, perform allele calling, compute multiple sequence alignments, or evaluate schema quality.
homepage: https://github.com/B-UMMI/chewBBACA
metadata:
  docker_image: "quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0"
---

# chewbbaca

## Overview

chewBBACA is a comprehensive suite designed for the creation, evaluation, and application of core genome (cgMLST) and whole genome (wgMLST) MultiLocus Sequence Typing schemas. It utilizes a Blast Score Ratio (BSR) based allele calling algorithm, which provides a robust way to identify and categorize genetic variation across bacterial strains. The tool is highly scalable, capable of processing thousands of genomes, and includes modules for schema annotation, core genome computation, and Multiple Sequence Alignment (MSA) generation.

## Core Modules and CLI Patterns

The tool is typically invoked using the main script followed by a specific module name: `chewBBACA.py [Module] [Options]`.

### Schema Creation and Preparation
*   **CreateSchema**: Use this to define target loci based on a set of high-quality reference genomes.
    *   Input: A directory containing genome assemblies in FASTA format.
    *   Logic: Identifies distinct loci to build the initial schema.
*   **PrepExternalSchema**: Use this to adapt schemas downloaded from external platforms (like Chewie-NS) for use with chewBBACA.
    *   Note: As of v3.5.1, this module supports loci FASTA files with basenames longer than 30 characters.

### Allele Calling
*   **AlleleCall**: The primary module for determining allelic profiles of bacterial strains against a schema.
    *   **BSR Logic**: Uses Blast Score Ratio to determine if a sequence is a known allele or a new variant.
    *   **Masked Profiles**: Use the `--output-masked` option to generate a TSV file where INF- prefixes are removed and specific quality classes (NIPH, NIPHEM, ASM, etc.) are converted to 0 for easier downstream analysis.
    *   **Input Handling**: Accepts genome or CDS files. Ensure each file has a unique basename, as the extension is stripped to create the identifier.

### Evaluation and Alignment
*   **ComputeMSA**: Generates Multiple Sequence Alignments from allele calling results.
    *   Supports both protein and DNA MSAs.
    *   Can be configured to exclude or ignore variable positions containing gaps or ambiguous characters.
*   **SchemaEvaluator / AlleleCallEvaluator**: Use these to generate interactive reports and visualize allele variation or schema quality.

## Expert Tips and Best Practices

*   **File Naming**: Since v3.5.1, chewBBACA uses the full file basename (minus extension) as the unique identifier. Avoid using special characters (!@#?$^*()+ ) in filenames. Ensure that files do not share the same basename even if they have different extensions (e.g., `sample1.fasta` and `sample1.fna` will conflict).
*   **Identifier Stability**: The tool now uses `lcl|SEQ` prefixes for BLAST databases to ensure sequence identifiers are treated as local and not modified by BLAST's internal parsing logic.
*   **Scalability**: Always utilize the multiprocessing capabilities for `AlleleCall` and `ComputeMSA` when working with large datasets to significantly reduce computation time.
*   **Memory Management**: For `ComputeMSA`, the tool uses `SeqIO.index_db` to store record information on disk, which is more memory-efficient for large-scale alignments.

## Reference documentation

- [chewBBACA Overview](./references/anaconda_org_channels_bioconda_packages_chewbbaca_overview.md)
- [chewBBACA GitHub Repository](./references/github_com_B-UMMI_chewBBACA.md)
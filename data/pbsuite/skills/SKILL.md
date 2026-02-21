---
name: pbsuite
description: PBSuite is a software suite designed for the analysis of Pacific Biosciences (PacBio) long-read sequencing data.
homepage: https://github.com/dbrowneup/PBSuite
---

# pbsuite

## Overview
PBSuite is a software suite designed for the analysis of Pacific Biosciences (PacBio) long-read sequencing data. Its primary components are **PBJelly**, which automates the process of gap-filling and assembly improvement by mapping long reads to existing scaffolds, and **PBHoney**, which identifies structural variations. This skill provides guidance on the native command-line execution and configuration of these tools to refine genomic assemblies.

## Core Components and Workflows

### PBJelly (Gap Filling)
PBJelly follows a multi-stage pipeline to fill gaps in a reference assembly using long reads. The workflow typically proceeds through these stages:

1.  **Setup**: Prepares the workspace and initializes the protocol.
2.  **Mapping**: Aligns PacBio reads to the reference assembly (typically using BLASR).
3.  **Support**: Identifies reads that support gap filling.
4.  **Extraction**: Extracts the relevant sequences for gap closure.
5.  **Assembly**: Performs local assembly of the gaps.
6.  **Output**: Generates the final refined assembly.

### PBHoney (Structural Variant Detection)
PBHoney identifies structural variants (SVs) by analyzing long-read alignments. It is particularly effective at detecting:
*   Deletions, insertions, and inversions.
*   Translocations and complex rearrangements.
*   Tailored analysis for "Spot" (within-read) and "Tails" (split-read) evidence.

## CLI Usage Patterns

### Execution Syntax
The tools are generally invoked via Python scripts located in the `bin/` directory. The standard pattern for running a stage is:

```bash
# General pattern for PBJelly
Jelly.py <stage> <Protocol.xml>

# General pattern for PBHoney
Honey.py <subcommand> <options>
```

### Common Stages and Commands
*   **Jelly.py setup**: Initializes the project directory based on the XML protocol.
*   **Jelly.py mapping**: Executes the alignment process. Ensure your environment has `blasr` installed and accessible.
*   **Jelly.py assembly**: Finalizes the local assembly of gaps.
*   **Honey.py pie**: Used for structural variant discovery.
*   **Honey.py tails**: Specifically targets split-read evidence for SVs.

## Best Practices and Expert Tips

*   **BLASR Parameter Convention**: Modern versions of PBSuite (post-v15.8.24) use the double-dash convention for BLASR parameters (e.g., `--sa` instead of `-sa`). Ensure your `Protocol.xml` reflects this to avoid alignment failures.
*   **Protocol Configuration**: The `Protocol.xml` file is the central configuration hub. It must define the reference genome path, the input read files (Fastq or Bas.h5), and the specific parameters for the aligner.
*   **Memory Management**: Long-read alignment is resource-intensive. When running the `mapping` stage, ensure the compute environment has sufficient RAM for the reference genome index.
*   **Refinement Iteration**: PBJelly can be run in multiple iterations to progressively close gaps, though the first pass typically yields the most significant improvements.
*   **Jelly2 Transition**: For users seeking the most recent updates, consider transitioning to Jelly2, which is the successor to the original PBJelly implementation found in this suite.

## Reference documentation
- [Main Repository Overview](./references/github_com_dbrowneup_PBSuite.md)
- [Bin Directory Structure](./references/github_com_dbrowneup_PBSuite_tree_master_bin.md)
- [Documentation Assets](./references/github_com_dbrowneup_PBSuite_tree_master_docs.md)
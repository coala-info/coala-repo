---
name: cosigt
description: cosigt (COsine SImilarity-based GenoTyper) is a specialized bioinformatics pipeline designed to assign structural haplotypes to sequenced samples.
homepage: https://github.com/davidebolo1993/cosigt
---

# cosigt

## Overview
cosigt (COsine SImilarity-based GenoTyper) is a specialized bioinformatics pipeline designed to assign structural haplotypes to sequenced samples. Unlike traditional genotypers that rely on linear reference genomes, cosigt leverages pangenome graphs to capture complex structural variations. It utilizes a cosine similarity-based approach to determine the most likely genotype for a given sample by comparing sequencing data against the paths within a pangenome graph.

## Installation
The tool is available via Bioconda. To set up the environment:
```bash
conda install bioconda::cosigt
```

## Core Functionality and CLI Patterns
cosigt is implemented as a Snakemake pipeline, often wrapped or managed via Python/Go components. Based on the tool's architecture, users should focus on the following patterns:

### Execution Environment
- **Snakemake Integration**: Since the core logic resides in `cosigt_smk`, the tool typically requires a Snakemake environment. Ensure `snakemake` is installed and available in your PATH.
- **Resource Management**: Use the `--threads` flag (defaulting to 8 in recent versions) to manage computational load, especially for the `panplexity` and `refine` steps.

### Common Command-Line Arguments
While specific wrappers may vary, the following parameters are frequently used in the pipeline's logic:
- `--assemblies`: Used to specify the input assembly files for pangenome construction or comparison.
- `--min-span`: A parameter for the `refine` step to control the minimum span of alignments or variants.
- `--SVByEye`: An optional flag used for structural variation validation or visualization.
- `--threads`: Specifies the number of CPU threads for parallel processing.

### Workflow Components
The pipeline integrates several high-performance bioinformatics tools. Understanding their role helps in troubleshooting:
- **pggb**: Used for pangenome graph construction.
- **odgi**: Used for graph manipulation and similarity calculations.
- **impg**: Utilized for the `refine` step to improve alignment accuracy.
- **kfilt**: Used for filtering and recruiting unmapped reads.

## Expert Tips
- **Deterministic Output**: In version 0.1.7 and later, cosigt ensures deterministic output by sorting results by key to break ties in similarity scores.
- **Memory Management**: When working with large pangenomes, monitor temporary file usage. Recent updates have moved many intermediate files to temporary storage to reduce disk footprint.
- **Read Recruitment**: If you have a high number of unmapped reads, ensure `kfilt` is properly configured within the pipeline to recruit these reads back into the genotyping process.
- **Chromosome Info**: Ensure your input metadata includes chromosome information, as recent versions of the organization scripts (`organize.py`) now include this in the final output for better downstream analysis.

## Reference documentation
- [cosigt Overview](./references/anaconda_org_channels_bioconda_packages_cosigt_overview.md)
- [cosigt GitHub Repository](./references/github_com_davidebolo1993_cosigt.md)
- [cosigt Commit History](./references/github_com_davidebolo1993_commits_master.md)
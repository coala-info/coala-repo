---
name: nextpolish
description: NextPolish is a high-efficiency tool designed to refine genome assemblies by correcting base-level errors using short or long reads. Use when user asks to polish a genome assembly, correct base-level errors, or improve assembly consensus quality.
homepage: https://github.com/Nextomics/NextPolish
metadata:
  docker_image: "quay.io/biocontainers/nextpolish:1.4.1--heebf65f_5"
---

# nextpolish

## Overview
NextPolish is a high-efficiency tool designed to refine genome assemblies by correcting base-level errors. While long-read assemblers are excellent at resolving structural complexity, they often leave behind a high rate of small-scale errors. NextPolish addresses this by using a stepwise polishing process. It is particularly useful for researchers who have completed an initial assembly and need to reach high-quality consensus (Q-scores) using available Illumina short reads or by re-mapping the original long reads.

## Installation and Setup
The most reliable way to install NextPolish is via Bioconda:
```bash
conda install -c bioconda nextpolish
```
Alternatively, for manual installation, ensure the Python library `paralleltask` is installed, as NextPolish relies on it for job distribution and monitoring.

## Core Workflow
NextPolish is primarily driven by a configuration file (typically `run.cfg`). The execution pattern follows a simple command:

```bash
nextPolish run.cfg
```

### Configuration Best Practices
The `run.cfg` file defines the input assembly, the read files (short or long), and the task parameters. 
- **Task Specification**: Use `task = best` to let the tool automatically determine the optimal polishing strategy based on your input data.
- **Parallelization**: Configure the `job_type` and `task_threads` within the config file to match your HPC environment (e.g., local, sge, or slurm).
- **Data Types**: 
    - For **Short Reads**: Ensure reads are pre-processed/trimmed for better mapping accuracy.
    - For **Long Reads**: Use this module if short-read data is unavailable, though hybrid polishing (short reads followed by long reads) generally yields the highest accuracy.

## Expert Tips and Common Patterns
- **Stepwise Polishing**: For hybrid data, it is often recommended to run 2-4 rounds of short-read polishing followed by 1-2 rounds of long-read polishing.
- **Temporary File Management**: Polishing generates large intermediate mapping files (BAMs). Use the `deltmp = yes` option in your configuration to automatically remove these files after a successful run to save disk space.
- **Memory Allocation**: When working with large genomes (e.g., human or plant), ensure the `parallel_jobs` parameter is balanced with available RAM, as each job will load a portion of the genome and the corresponding reads.
- **Handling Scaffolds with Ns**: If your input assembly contains gaps (Ns), NextPolish will process the contiguous sequences. However, significant decrease in genome size after polishing may indicate over-aggressive filtering or issues with the input mapping; always check the `genome.size` log.
- **HiFi Data**: While NextPolish supports HiFi reads, the developers recommend **NextPolish2** for assemblies specifically generated from and polished with PacBio HiFi reads for optimal performance.

## Reference documentation
- [Nextomics/NextPolish GitHub Repository](./references/github_com_Nextomics_NextPolish.md)
- [Bioconda NextPolish Overview](./references/anaconda_org_channels_bioconda_packages_nextpolish_overview.md)
- [NextPolish Parameter Reference and Documentation](./references/github_com_Nextomics_NextPolish_tree_master_doc.md)
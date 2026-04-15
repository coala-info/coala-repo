---
name: graftm
description: GraftM is a bioinformatic pipeline for the rapid identification and taxonomic classification of marker genes within meta-omic datasets. Use when user asks to identify specific genes in metagenomes, classify sequences using marker gene packages, or generate community profiles from raw reads.
homepage: http://geronimp.github.io/graftM
metadata:
  docker_image: "quay.io/biocontainers/graftm:0.15.1--pyhdfd78af_0"
---

# graftm

## Overview
GraftM is a specialized bioinformatic pipeline designed for the high-speed identification and classification of specific marker genes (e.g., 16S rRNA, mcrA, pmoA) within meta-omic data. Unlike general-purpose classifiers that rely on exhaustive pairwise alignments, GraftM uses a targeted approach to find "hits" and assign taxonomy or function. This skill provides the necessary command-line patterns to execute the `graft` workflow and manage GraftM packages.

## Core Workflows

### Running the Graft Pipeline
The primary command is `graftm graft`. It requires a sequence input and a pre-defined GraftM package (.gpkg).

**Basic usage for short reads:**
```bash
graftm graft --forward reads_f.fa --graftm_package <package_name>.gpkg
```

**Commonly used flags:**
- `--forward`: Path to the forward reads (FASTA/FASTQ).
- `--reverse`: Path to the reverse reads (if using paired-end data).
- `--graftm_package`: Path to the directory containing the GraftM marker set.
- `--threads`: Specify the number of CPU cores to use for parallel processing.
- `--search_only`: Use this if you only need to identify sequences without performing full taxonomic classification.

### Output Interpretation
GraftM generates a results directory containing:
- **Taxonomic/Functional Summary Table**: A text file summarizing the hits found.
- **Krona Plot**: An interactive HTML visualization of the community profile.
- **Aligned/Unaligned Hits**: FASTA files containing the sequences that matched the marker gene.
- **Run Statistics**: Log files detailing the search and classification performance.

### Package Management
GraftM relies on specific packages for different genes. While common packages like 16S rRNA are often pre-provided, you can interact with them via the CLI:
- Ensure the `.gpkg` directory is accessible and contains the necessary HMMs and reference trees.
- If a user asks to analyze a specific gene not in the default set, they must provide or create a custom GraftM package.

## Best Practices
- **Input Format**: GraftM handles assembled contigs and protein sequences in addition to raw reads. Ensure the input file extension matches the data type (e.g., `.faa` for proteins).
- **Speed Optimization**: For large metagenomes (e.g., >200Mb), GraftM is significantly faster than BLAST-based methods. Use the `--threads` flag to maximize throughput on HPC systems.
- **Memory Considerations**: While designed for speed, loading large reference trees within a GraftM package can be memory-intensive. Monitor RAM usage when running multiple instances.

## Reference documentation
- [GraftM Overview and Usage](./references/geronimp_github_io_graftM.md)
- [Bioconda GraftM Package Details](./references/anaconda_org_channels_bioconda_packages_graftm_overview.md)
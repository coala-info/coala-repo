---
name: shotmap
description: Shotmap performs functional annotation and comparative analysis of shotgun metagenomic sequences. Use when user asks to build search databases, execute functional annotation on metagenomes, or perform statistical comparisons between multiple samples.
homepage: https://github.com/sharpton/shotmap
metadata:
  docker_image: "biocontainers/shotmap:v1.0.0_cv3"
---

# shotmap

## Overview
Shotmap is a specialized software workflow designed for the functional annotation and comparative analysis of shotgun metagenomes. It allows researchers to map either unassembled or assembled metagenomic sequences to protein family databases to determine functional abundance and diversity. This skill should be used to guide the execution of the pipeline, from the initial creation of search databases to the final statistical comparison of multiple samples to identify differentiating protein families.

## Core Workflow and CLI Patterns

The Shotmap workflow follows a linear three-step process. Ensure the `$SHOTMAP_LOCAL` environment variable is correctly set to the installation directory before running these commands.

### 1. Build the Search Database
This is a one-time setup requirement to prepare the reference protein family database for searching.

```bash
perl $SHOTMAP_LOCAL/scripts/build_shotmap_searchdb.pl \
  -r=</path/to/reference/database> \
  -d=</path/to/search/database>
```

### 2. Execute Functional Annotation
Run the main pipeline on your metagenomic sequences. Shotmap supports multicore processing and can interface with SGE-configured clusters.

```bash
perl $SHOTMAP_LOCAL/scripts/shotmap.pl \
  -i=</path/to/metagenomes> \
  -d=</path/to/search/database> \
  -o=</path/to/result/database/>
```

### 3. Compare Results
If you have multiple samples, use this script to perform statistical and ecological comparisons.

```bash
perl $SHOTMAP_LOCAL/scripts/compare_shotmap_results.pl \
  -i=</path/to/result/database/> \
  -m=</path/to/optional/metadata/file> \
  -o=</path/to/comparison/output/directory/>
```

## Expert Tips and Best Practices

- **Metadata Files**: When using `compare_shotmap_results.pl`, providing a metadata file via the `-m` flag is highly recommended. This allows the pipeline to perform robust statistical tests to identify protein families that differentiate metagenomes based on your experimental categories.
- **Database Management**: Shotmap can optionally manage workflow data in a relational database. For high-throughput environments, ensure the database configuration files are properly tuned.
- **Resource Allocation**: For large metagenomic datasets, utilize the multicore capabilities or cloud/cluster (SGE) interfacing to reduce processing time.
- **Input Formats**: Shotmap is versatile and can handle both unassembled raw reads and assembled contigs.

## Reference documentation
- [Shotmap Main README](./references/github_com_sharpton_shotmap.md)
---
name: dammit
description: `dammit` is a streamlined de novo transcriptome annotator that automates the integration of several standard biological databases and software tools.
homepage: http://dib-lab.github.io/dammit/
---

# dammit

## Overview

`dammit` is a streamlined de novo transcriptome annotator that automates the integration of several standard biological databases and software tools. Use this skill to navigate the multi-step process of preparing a computational environment for annotation, managing significant storage and RAM requirements, and executing the annotation pipeline to assign functional information to transcript sequences.

## Database Management

Before running annotations, you must install and prepare the reference databases.

### Basic Installation
Install the default databases (Pfam-A, Rfam, OrthoDB, and Metazoa BUSCO) to the default directory (`~/.dammit/databases`):
```bash
dammit databases --install
```

### Customizing BUSCO Groups
Specify a taxonomically appropriate BUSCO group to improve assessment accuracy:
```bash
dammit databases --install --busco-group eukaryota
```

### Handling Large Databases
To include the comprehensive but massive UniRef90 database, use the `--full` flag. Note that this requires significant disk space and high-speed internet:
```bash
dammit databases --install --full
```

### Using Existing Databases
If databases are already present on the system, point `dammit` to their location to avoid redundant downloads:
```bash
dammit databases --database-dir /path/to/existing/dbs --install
```

## Annotation Workflow

### Standard Annotation
Run the basic annotation pipeline on a transcriptome FASTA file. It is highly recommended to specify the number of threads to utilize system resources effectively:
```bash
dammit annotate <transcriptome.fasta> --n_threads 8
```

### Advanced Annotation with User Databases
Incorporate specific protein databases (in FASTA format) to supplement the standard annotation:
```bash
dammit annotate <transcriptome.fasta> --user-databases <custom_proteins.fasta> --busco-group <group> --n_threads 12
```

## Best Practices and Performance

- **Memory Management**: The standard pipeline recommends at least 16GB of RAM. If memory is a bottleneck, consider using a custom configuration file to adjust LAST parameters.
- **Storage Requirements**: Ensure at least 18GB of free space for standard databases. The "full" pipeline with UniRef90 requires several hundred GB.
- **Environment Persistence**: Set the `DAMMIT_DB_DIR` environment variable in your `.bashrc` to make custom database locations persistent across sessions:
  ```bash
  export DAMMIT_DB_DIR=/path/to/databases
  ```
- **Software Dependencies**: Always install `dammit` via Bioconda to ensure all underlying dependencies (HMMER, Infernal, LAST, TransDecoder) are correctly versioned and linked.

## Reference documentation

- [Database Usage](./references/dib-lab_github_io_dammit_database-usage.md)
- [Advanced Database Handling](./references/dib-lab_github_io_dammit_database-advanced.md)
- [System Requirements](./references/dib-lab_github_io_dammit_system_requirements.md)
- [Tutorial](./references/dib-lab_github_io_dammit_tutorial.md)
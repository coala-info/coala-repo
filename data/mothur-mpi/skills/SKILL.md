---
name: mothur-mpi
description: mothur-mpi processes large-scale environmental DNA sequence datasets for microbial ecology research. Use when user asks to perform sequence quality control, align reads to a reference, remove chimeras, assign taxonomy, or cluster sequences into operational taxonomic units.
homepage: https://www.mothur.org
---

# mothur-mpi

## Overview
mothur-mpi is a specialized toolset designed to handle the high-throughput bioinformatics needs of microbial ecologists. It excels at processing large datasets of environmental DNA sequences, specifically targeting the 16S rRNA gene. This skill assists in navigating mothur's extensive command-line interface to perform tasks ranging from raw sequence quality control and alignment to OTU (Operational Taxonomic Unit) clustering and diversity analysis. It is particularly useful for researchers following the MiSeq SOP or requiring reproducible microbial community analysis.

## Command Line Usage Patterns
mothur can be used in two primary modes: Interactive and Batch.

### Interactive Mode
Simply type `mothur` to enter the interactive shell. This is useful for exploring data or testing individual commands.
```bash
mothur
```

### Batch Mode
For reproducible pipelines and HPC environments, provide a script file containing a list of mothur commands.
```bash
mothur batchfile.mothur
```

### Command Line Options
You can run single commands directly from the terminal:
```bash
mothur "#summary.seqs(fasta=yourfile.fasta)"
```

## Best Practices and Expert Tips
- **Parallelization**: Many mothur commands support the `processors` argument. Always check the available cores on your system to speed up intensive tasks like `align.seqs` or `dist.seqs`.
- **File Management**: mothur generates many intermediate files. Use the `set.dir` command within your batch scripts to organize output and input directories effectively.
- **Log Files**: mothur automatically creates a log file (e.g., `mothur.YYYYMMDD.logfile`). Always review this file for warnings or errors that might not be apparent in the standard output.
- **Current Files**: mothur remembers the "current" version of files (fasta, count, taxonomy). You can often omit file arguments in sequential commands (e.g., running `summary.seqs()` immediately after a filtering step).
- **Memory Management**: For extremely large datasets, prefer the `cluster.split` command over `cluster` to reduce memory overhead by splitting sequences by taxonomic classification before clustering.

## Common Workflow Steps
1. **Quality Control**: Use `make.contigs` to join paired-end reads and `screen.seqs` to remove sequences with ambiguous bases or poor lengths.
2. **Alignment**: Use `align.seqs` against a reference database (like SILVA) followed by `filter.seqs` to remove empty columns.
3. **Chimera Removal**: Use `chimera.vsearch` or `chimera.uchime` to identify and remove PCR artifacts.
4. **Classification**: Use `classify.seqs` with the RDP or SILVA reference sets to assign taxonomy.
5. **Clustering**: Use `dist.seqs` followed by `cluster` (or `cluster.split`) to group sequences into OTUs.

## Reference documentation
- [mothur Project Home](./references/mothur_org_index.md)
- [mothur Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mothur_overview.md)
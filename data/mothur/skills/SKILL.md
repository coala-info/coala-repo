---
name: mothur
description: mothur is a comprehensive, open-source bioinformatics platform designed specifically for the microbial ecology community.
homepage: https://www.mothur.org
---

# mothur

## Overview
mothur is a comprehensive, open-source bioinformatics platform designed specifically for the microbial ecology community. This skill assists in navigating mothur's extensive command-line interface to transform raw DNA sequencing data (typically from Illumina MiSeq or Ion Torrent platforms) into community analysis outputs like OTU tables, phylogenetic trees, and alpha/beta diversity metrics. It is particularly useful for implementing the "Standard Operating Procedure" (SOP) for sequence processing and ensuring reproducible research workflows.

## Core Command Patterns
mothur can be run in interactive mode (by typing `mothur` at the terminal) or batch mode. For automation and reproducibility, batch mode is preferred.

### Batch Execution
To run a series of commands from a file:
```bash
mothur batchfile.mothur
```

### Common Command Syntax
Most mothur commands follow a consistent `command(parameter=value, parameter=value)` format.
- **make.file**: Generates a stability file from raw FASTQ data.
  `make.file(inputdir=., type=gz, prefix=stability)`
- **screen.seqs**: Filters sequences based on length and ambiguous bases.
  `screen.seqs(fasta=current, count=current, maxambig=0, maxlength=275)`
- **unique.seqs**: Collapses identical sequences to reduce computational load.
  `unique.seqs(fasta=current)`
- **align.seqs**: Aligns sequences to a reference database (e.g., SILVA).
  `align.seqs(fasta=current, reference=silva.v4.fasta)`

## Expert Tips & Best Practices
- **The "current" Keyword**: mothur tracks the most recently generated files. Use `fasta=current`, `count=current`, or `taxonomy=current` to chain commands without typing long filenames.
- **Parallelization**: Many commands support the `processors` parameter. Set this to the number of available CPU cores to significantly speed up alignment and clustering (e.g., `processors=8`).
- **Log Files**: mothur automatically generates a `mothur.YYYYMMDD.logfile`. Always check this file for warnings regarding sequence loss during screening or alignment failures.
- **Reference Databases**: Ensure your reference database (SILVA, RDP, or Greengenes) matches the region sequenced (e.g., V4 region). Use `pcr.seqs` to trim your reference database to the specific primer region for better alignment accuracy.
- **Chimera Detection**: Use the `vsearch` implementation within mothur for the best balance of speed and sensitivity: `chimera.vsearch(fasta=current, count=current, dereplicate=t)`.

## Reference documentation
- [mothur Project Home](./references/mothur_org_index.md)
- [Bioconda mothur Package](./references/anaconda_org_channels_bioconda_packages_mothur_overview.md)
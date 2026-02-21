---
name: svseq2
description: svseq2 is a specialized bioinformatics tool designed for the accurate and efficient detection of structural variations (SVs) in low-coverage sequencing datasets.
homepage: https://sourceforge.net/projects/svseq2/
---

# svseq2

## Overview

svseq2 is a specialized bioinformatics tool designed for the accurate and efficient detection of structural variations (SVs) in low-coverage sequencing datasets. It represents an advancement over the original SVseq tool, providing increased processing speed and the capability to identify both deletions and insertions. The tool primarily relies on soft-clipped read signatures within BAM files to pinpoint variation breakpoints.

## Command Line Usage

svseq2 uses a specific set of flags for its two primary modes: deletion calling and insertion calling.

### Calling Deletions
To detect deletions, use the following command structure:

```bash
./SVseq2 -r <reference.fasta> -b <bam_list.txt> -c <chromosome> [options]
```

**Required Arguments:**
- `-r`: The reference genome in FASTA format.
- `-b`: A text file containing a list of BAM file paths (one per line).
- `-c`: The specific chromosome name to process.

**Optional Arguments:**
- `--o`: Output filename (defaults to `result.txt`).
- `--c`: The support cut-off value (defaults to `3`).
- `--is`: Insert size and standard deviation (e.g., `300 50`). If provided, this value is applied to all BAM files in the list. If omitted, svseq2 will calculate these values automatically for each file.

### Calling Insertions
To detect insertions, you must include the `-insertion` flag:

```bash
./SVseq2 -insertion -b <bam_list.txt> -c <chromosome> [options]
```

**Required Arguments:**
- `-insertion`: Flag to enable insertion calling mode.
- `-b`: A text file containing a list of BAM file paths.
- `-c`: The specific chromosome name to process.

**Optional Arguments:**
- `--o`: Output filename (defaults to `result.txt`).
- `--ci`: The support cut-off value for insertions (defaults to `3`).

## Best Practices and Expert Tips

- **Input Preparation**: Ensure your BAM files are indexed and contain soft-clipped reads. svseq2 specifically looks for these signatures to identify SVs.
- **BAM List Format**: The `-b` argument expects a file containing paths, not the BAM files themselves. Ensure the paths in your list file are either absolute or relative to the execution directory.
- **Insert Size Estimation**: For heterogeneous datasets where libraries have different insert sizes, omit the `--is` flag. This allows the tool to perform per-sample estimation, which is generally more accurate than a global setting.
- **Sensitivity Tuning**: The cut-off parameters (`--c` for deletions, `--ci` for insertions) determine how many supporting reads are required to call a variant. Lowering this value increases sensitivity for very low-coverage data but may increase false positives.
- **Parallelization**: Since the tool requires a chromosome name (`-c`), you can parallelize the workload by running multiple instances of svseq2 simultaneously on different chromosomes.

## Reference documentation
- [SVseq2 - Browse Files at SourceForge.net](./references/sourceforge_net_projects_svseq2_files.md)
- [svseq2 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_svseq2_overview.md)
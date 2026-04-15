---
name: ltr_finder_parallel
description: ltr_finder_parallel is a parallelized wrapper for LTR_FINDER that speeds up the identification of long terminal repeat retrotransposons by processing genomic sequences in chunks. Use when user asks to identify LTR retrotransposons, run LTR_FINDER in parallel, or annotate transposable elements in large plant genomes.
homepage: https://github.com/oushujun/LTR_FINDER_parallel
metadata:
  docker_image: "quay.io/biocontainers/ltr_harvest_parallel:1.2--hdfd78af_2"
---

# ltr_finder_parallel

## Overview
`ltr_finder_parallel` is a Perl-based wrapper designed to overcome the performance bottlenecks of the original LTR_FINDER. It works by splitting large genomic sequences into smaller, overlapping chunks, processing them in parallel across multiple CPU cores, and then merging the results. This approach is particularly essential for complex plant genomes where standard LTR_FINDER execution might take hundreds or thousands of hours.

## Installation
The tool is available via Bioconda:
```bash
conda install -c bioconda ltr_finder_parallel
```

## Basic Usage
The core command requires a sequence file and the number of threads:
```bash
perl LTR_FINDER_parallel -seq genome.fasta -threads 16
```

## Command Line Options
| Option | Description | Default |
| :--- | :--- | :--- |
| `-seq [file]` | Input genome file in multi-FASTA format. | Required |
| `-threads [int]` | Number of CPU cores to utilize. | 1 |
| `-size [int]` | Size of sequence chunks (bp). | 5,000,000 |
| `-overlap [int]` | Overlap between chunks to prevent splitting LTRs. | 100,000 |
| `-time [int]` | Max runtime (seconds) per thread/region. | 120 |
| `-try1 [0\|1]` | If timeout occurs: 0=discard; 1=split into 50kb pieces. | 1 |
| `-harvest_out` | Output in LTRharvest format (required for LTR_retriever). | Table format |
| `-v` | Verbose mode; retains intermediate output files. | Off |

## Expert Tips and Best Practices

### Integration with LTR_retriever
If you are using this tool as part of a TE (Transposable Element) annotation pipeline with `LTR_retriever`, you must use the `-harvest_out` flag.
```bash
perl LTR_FINDER_parallel -seq genome.fasta -threads 32 -harvest_out > genome.harvest.scn
```

### Handling Timeouts in Repeat-Rich Regions
Highly repetitive regions can cause LTR_FINDER to hang. 
- If the tool skips too many regions, increase the `-time` parameter (e.g., `-time 300`).
- If you increase `-size`, you should proportionally increase `-time`.
- Use `-try1 1` (default) to attempt to salvage data from timed-out regions by further sub-chunking.

### Sequence Naming
Ensure your FASTA headers are short and simple (e.g., `>Chr1`, `>Scaffold_50`). Avoid special characters or extremely long headers, as these can cause parsing errors in the underlying Perl script.

### Memory Management
While parallelization speeds up the process, it increases memory overhead. For extremely large genomes like wheat (14.5 Gb), ensure the system has sufficient RAM to handle the number of threads specified. The parallel version is generally more memory-efficient per CPU than the original, but total usage scales with thread count.

## Reference documentation
- [GitHub Repository and Documentation](./references/github_com_oushujun_LTR_FINDER_parallel.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ltr_finder_parallel_overview.md)
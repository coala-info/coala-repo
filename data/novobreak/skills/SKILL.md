---
name: novobreak
description: novoBreak identifies somatic structural variation breakpoints in cancer genomes through local assembly of k-mers from tumor and normal paired-end data. Use when user asks to identify structural variations, discover somatic breakpoints, or detect virus integration sites.
homepage: https://github.com/czc/nb_distribution
metadata:
  docker_image: "quay.io/biocontainers/novobreak:1.1.3rc--h7132678_8"
---

# novobreak

## Overview

novoBreak is a specialized tool for cancer genomics designed to identify structural variation (SV) breakpoints through local assembly. By analyzing k-mers from tumor and normal paired-end Illumina data, it distinguishes somatic mutations from germline variations and provides high-resolution breakpoint coordinates for deletions (DEL), duplications (DUP), inversions (INV), and translocations (TRA). It is particularly effective for discovering accurate breakpoints that might be missed by standard alignment-based callers.

## Execution Patterns

### Standard Workflow (Recommended)

Use the provided shell script to handle the multi-step process (k-mer discovery, assembly, and filtering) automatically.

```bash
bash run_novoBreak.sh <novoBreak_exe_dir> <reference.fasta> <tumor.bam> <normal.bam> <num_threads> [output_dir]
```

### Direct K-mer Discovery

To run only the initial k-mer identification step:

```bash
novoBreak -i tumor.bam -c normal.bam -r reference.fasta -o output.kmer -k 31 -m 3
```

### Parameters

- `-k <int>`: K-mer size (maximum 31, default 31).
- `-m <int>`: Minimum k-mer count to be considered a "novo" k-mer (default 3).
- `-g <int>`: Set to 1 to output germline events (default 0, somatic only).

## Best Practices and Expert Tips

### Virus Integration Analysis
To detect virus integration sites (treated as Translocations/TRA):
1. Append the virus genome sequences to your reference FASTA file.
2. Re-align your reads to this augmented reference.
3. Run novoBreak normally; integration points will appear as TRA events between the host and virus chromosomes.

### Resource Management
- **Memory**: Ensure the system has at least 40GB of physical memory for human genome-scale analysis.
- **Input**: Use name-sorted BAM files or ensure `samtools` is available in your PATH to handle proper read pairing during the assembly phase.

### Filtering and Quality Control
The primary output is `novoBreak.pass.flt.vcf`. If you need to adjust stringency:
- **Column 6 (QUAL)**: A higher value indicates a more reliable event.
- **Manual Filtering**: Use the additional VCF fields (columns 11-39) to filter based on split-read support (`tumor_bkpt1_sp_reads`) or discordant read support (`tumor_bkpt1_discordant_reads`).
- **Alternative Filters**: If the default filter is too stringent, consider using `filter_sv2.pl` provided in the distribution.

### SV Size Limits
- **Minimum Size**: The default filters typically target SVs > 100 bp.
- **Insertions**: For novel insertions, novoBreak reports the breakpoints but may not provide the full inserted sequence.



## Subcommands

| Command | Description |
|---------|-------------|
| novoBreak | a tool for discovering somatic sv breakpoints |
| novobreak_run_novoBreak.sh | Runs the novoBreak pipeline. |

## Reference documentation

- [novoBreak README](./references/github_com_czc_nb_distribution_blob_master_README.md)
- [novoBreak Execution Script](./references/github_com_czc_nb_distribution_blob_master_run_novoBreak.sh.md)
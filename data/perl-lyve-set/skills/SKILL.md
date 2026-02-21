---
name: perl-lyve-set
description: Lyve-SET (Lyve version of the Snp Extraction Tool) is a phylogenomics pipeline optimized for genomic epidemiology and outbreak investigations.
homepage: https://github.com/lskatz/lyve-SET
---

# perl-lyve-set

## Overview

Lyve-SET (Lyve version of the Snp Extraction Tool) is a phylogenomics pipeline optimized for genomic epidemiology and outbreak investigations. It identifies high-quality SNPs (hqSNPs) by applying stringent filters to sequencing data, such as minimum coverage, consensus thresholds, and masking of problematic genomic regions (phages and "cliffs"). The tool transforms raw reads into multiple sequence alignments (MSA) and phylogenetic trees, providing the high resolution necessary to distinguish closely related bacterial isolates.

## Project Management

Lyve-SET uses a specific directory structure. Always use `set_manage.pl` to initialize and populate your project to ensure files are placed in the correct subdirectories (`reads/`, `ref/`, `bam/`, etc.).

### Initializing a Project
```bash
# Create a new project directory structure
set_manage.pl --create ProjectName
```

### Adding Data
```bash
# Add interleaved fastq files
set_manage.pl ProjectName --add-reads reads/sample1.fastq.gz

# Set or change the reference genome (Fasta or GenBank)
# Using GenBank (.gbk) allows for SNP annotation
set_manage.pl ProjectName --change-reference reference.fasta
```

## Read Preprocessing

Lyve-SET requires paired-end reads to be interleaved into a single file per sample.

```bash
# Interleave multiple pairs of fastq files into an output directory
shuffleSplitReads.pl --numcpus 8 -o interleaved_dir/ *.fastq.gz
```

## Executing the Pipeline

The main execution script is `launch_set.pl`. If run within a project directory without arguments, it assumes the current directory is the project.

### Basic Execution
```bash
launch_set.pl ProjectName --numcpus 8 --ref ProjectName/ref/reference.fasta
```

### High-Quality Filtering Options
To increase the stringency of SNP calling for outbreak clusters:
- `--min_coverage`: Minimum depth to call a SNP (default 10).
- `--min_alt_frac`: Minimum allele frequency/consensus (default 0.75).
- `--allowedFlanking`: Minimum distance between SNPs (default 5bp). SNPs closer than this are masked to avoid clusters of false positives.

### Advanced Workflow Patterns
```bash
# Fast run: Downsamples reads to 50x and skips phage/cliff masking
launch_set.pl ProjectName --fast --numcpus 12

# Comprehensive run with masking
launch_set.pl ProjectName --mask-phages --mask-cliffs --numcpus 16

# Skip phylogeny (generate only the SNP matrix and MSA)
launch_set.pl ProjectName --notrees
```

## Expert Tips

1. **Phage Masking**: Always use `--mask-phages` when working with species known for high horizontal gene transfer (e.g., *Salmonella* or *E. coli*) to prevent prophage variation from distorting the phylogeny.
2. **Interleaving**: If your reads are already interleaved, do not run `shuffleSplitReads.pl` again, as it may corrupt the read headers.
3. **Reference Selection**: The choice of reference genome significantly impacts SNP density. Use a reference closely related to the outbreak cluster for maximum resolution.
4. **Cluster Computing**: If using a grid scheduler (like SGE), use `--queue` and `--numnodes` to distribute the workload. Use `--noqsub` to force local execution on a single high-core machine.
5. **Output Location**: Final results (MSA and Newick trees) are stored in the `msa/` directory within your project folder.

## Reference documentation
- [github_com_lskatz_lyve-SET.md](./references/github_com_lskatz_lyve-SET.md)
- [anaconda_org_channels_bioconda_packages_perl-lyve-set_overview.md](./references/anaconda_org_channels_bioconda_packages_perl-lyve-set_overview.md)
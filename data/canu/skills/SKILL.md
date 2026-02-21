---
name: canu
description: Canu is a hierarchical assembly pipeline optimized for long-read technology.
homepage: https://github.com/marbl/canu
---

# canu

## Overview
Canu is a hierarchical assembly pipeline optimized for long-read technology. It transforms noisy raw reads into high-quality contigs through a four-step process: detecting overlaps using the MinHash Alignment Process (MHAP), generating a corrected sequence consensus, trimming corrected sequences to remove low-quality ends or technology-specific artifacts, and finally performing the assembly. While it is a legacy tool that has reached end-of-life for the most recent sequencing chemistries, it remains a standard for processing data from the 2017–2021 era and for specific workflows like trio binning.

## Common CLI Patterns

### Basic Assembly
The core command requires a project prefix, an output directory, an estimated genome size, and the input reads.

```bash
canu \
  -p ecoli -d ecoli-assembly \
  genomeSize=4.6m \
  -nanopore-raw reads.fastq.gz
```

### Read Type Selection
Specify the correct technology flag to ensure the pipeline uses the appropriate error models:
- **PacBio Raw**: `-pacbio-raw`
- **PacBio HiFi**: `-pacbio-hifi` (triggers the HiCanu algorithm)
- **Oxford Nanopore**: `-nanopore-raw`

### Trio Binning
For haplotype-resolved assembly when parental data is available:
1. Use `meryl` (included with Canu) to count k-mers in parental reads.
2. Run Canu with the `-haplotype` flags to bin the offspring reads before assembly.

## Expert Tips and Best Practices

### Genome Size Estimation
The `genomeSize` parameter is mandatory. It does not need to be exact, but it must be within a reasonable range (e.g., 3.1g for human, 4.6m for E. coli) as it influences memory allocation and coverage sampling.

### Resource Management
Canu is designed to run on both single machines and large clusters (SGE, Slurm, LSF, PBS). 
- On a local machine, it will attempt to use all available cores and memory unless restricted.
- For large genomes, ensure you have significant disk space; the intermediate overlap files (MHAP) can be much larger than the final assembly.

### Handling Modern Data
If you are working with very recent high-fidelity data (e.g., PacBio Revio or latest Nanopore Q20+), consider using newer assemblers like **Flye**, **Hifiasm**, or **Verkko** as recommended by the Canu developers, as Canu has not been tuned for these error profiles since 2021.

### Installation Note
Avoid downloading the source `.zip` from GitHub as it lacks necessary submodules. Use the pre-compiled binary releases or install via Conda:
```bash
conda install -c bioconda canu
```

## Reference documentation
- [Canu GitHub Repository](./references/github_com_marbl_canu.md)
- [Canu Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_canu_overview.md)
---
name: phyloflash
description: phyloFlash is a specialized bioinformatics pipeline designed to extract, assemble, and analyze SSU rRNA sequences (16S/18S) directly from raw Illumina sequencing reads.
homepage: https://github.com/HRGV/phyloFlash
---

# phyloflash

## Overview

phyloFlash is a specialized bioinformatics pipeline designed to extract, assemble, and analyze SSU rRNA sequences (16S/18S) directly from raw Illumina sequencing reads. It bypasses the need for full metagenome assembly by mapping reads against the SILVA database, then performing targeted assembly of the extracted rRNA-related reads. Use this skill to perform rapid taxonomic screening of metagenomes, reconstruct full-length rRNA genes for high-resolution phylogenetic placement, and generate interactive HTML reports of community composition.

## Installation and Setup

The recommended way to install phyloFlash is via Conda or Mamba:

```bash
conda create -n pf -c conda-forge -c bioconda phyloflash
conda activate pf
```

### Database Preparation
phyloFlash requires a formatted SILVA database. Pre-formatted versions (SILVA 138.1+) are available via Zenodo.
1. Download and unpack the database: `tar -xzf 138.1.tar.gz`
2. Point to the database location using the `-dbhome` flag during execution.

## Common CLI Patterns

### Standard Analysis (Recommended)
The `-almosteverything` flag is the standard recommendation for most users. It runs the SPAdes assembler for rRNA reconstruction but skips the more time-consuming EMIRGE.

```bash
phyloFlash.pl -lib <sample_name> -dbhome /path/to/138.1 -read1 R1.fq.gz -read2 R2.fq.gz -almosteverything -CPUs 16
```

### Working with Interleaved Reads
If your paired-end reads are in a single file:

```bash
phyloFlash.pl -lib <sample_name> -read1 interleaved.fq.gz -interleaved -almosteverything
```

### Single-Cell or MDA Data
For datasets with highly uneven coverage (e.g., Multiple Displacement Amplification), use the `-sc` toggle to optimize assembly parameters:

```bash
phyloFlash.pl -lib <sample_name> -read1 R1.fq.gz -read2 R2.fq.gz -sc -almosteverything
```

### Comprehensive Reconstruction
To run both SPAdes and EMIRGE for maximum reconstruction potential:

```bash
phyloFlash.pl -lib <sample_name> -read1 R1.fq.gz -read2 R2.fq.gz -everything
```

### Comparing Multiple Samples
After running phyloFlash on individual libraries, use `phyloFlash_compare.pl` to generate comparative heatmaps or barplots:

```bash
phyloFlash_compare.pl -task barplot -out comparison_output sample1.json sample2.json sample3.json
```

## Expert Tips and Best Practices

- **Environment Check**: Always run `phyloFlash.pl -check_env` after installation to ensure all dependencies (BBmap, SPAdes, VSEARCH, etc.) are correctly in the PATH.
- **Resource Management**: Use the `-CPUs` flag to limit thread usage, as the default behavior is to use all available cores.
- **Sensitivity vs. Speed**: By default, phyloFlash uses BBmap for initial mapping. If you need higher sensitivity for divergent sequences, use `-sortmerna`, though this is significantly slower.
- **Trusted Contigs**: If you have a prior assembly, use `-trusted contigs.fasta` to help the pipeline identify and prioritize known SSU sequences.
- **Output Organization**: Use `-zip` to automatically package results into a tarball and `-log` to ensure a record of the run parameters is preserved.

## Reference documentation
- [phyloFlash GitHub Repository](./references/github_com_HRGV_phyloFlash.md)
- [phyloFlash Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phyloflash_overview.md)
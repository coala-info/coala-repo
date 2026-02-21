---
name: shovill-se
description: shovill-se is a specialized fork of the Shovill assembly pipeline that extends support to single-end Illumina sequencing data.
homepage: https://github.com/rpetit3/shovill
---

# shovill-se

## Overview

shovill-se is a specialized fork of the Shovill assembly pipeline that extends support to single-end Illumina sequencing data. It is an "opinionated" workflow that streamlines bacterial isolate assembly by performing read depth reduction, adapter trimming, error correction, and assembly polishing. While SPAdes is the default engine, the tool allows for seamless switching between different assemblers while maintaining a consistent pre-processing and post-processing logic. This skill should be used for small, haploid microbial genomes; it is not suitable for metagenomic or large eukaryotic assembly tasks.

## Usage Patterns

### Basic Assembly
For single-end reads (the primary feature of this fork):
```bash
shovill --outdir assembly_out --R1 reads.fastq.gz
```

For standard paired-end reads:
```bash
shovill --outdir assembly_out --R1 R1.fastq.gz --R2 R2.fastq.gz
```

### Selecting an Assembler
Shovill-se supports multiple back-end engines. Choose based on your speed and accuracy requirements:
*   **SPAdes** (Default): Best all-rounder, handles varying coverage well.
*   **SKESA**: Faster, produces very conservative (high-fidelity) assemblies.
*   **MEGAHIT**: Extremely fast, low memory footprint.
*   **Velvet**: Legacy option, useful for specific comparative benchmarks.

```bash
shovill --assembler skesa --outdir out_skesa --R1 reads.fq.gz
```

### Resource Management
In HPC or cloud environments, explicitly define resource limits to prevent job crashes:
```bash
shovill --cpus 16 --ram 64 --outdir assembly_out --R1 reads.fq.gz
```

## Expert Tips and Best Practices

### Genome Size Estimation
If you know the expected genome size, provide it using `--gsize`. This improves the accuracy of the downsampling and error correction phases.
*   Example for *E. coli*: `--gsize 5M`
*   Example for *S. aureus*: `--gsize 2.8M`

### Handling High Depth
Shovill-se automatically downsamples reads to 150x depth by default to reduce noise and computation time. If you have extremely high coverage and want to keep more data, increase the `--depth` parameter, or set it to `0` to disable downsampling entirely (though this is rarely recommended for isolates).

### Trimming and Correction
*   **Trimming**: Use `--trim` to enable adapter trimming via Trimmomatic. This is recommended if your library prep hasn't been pre-cleaned.
*   **Polishing**: Shovill-se performs post-assembly correction (using Pilon) by default. If you are using a very high-fidelity assembler like SKESA and want to save time, you can disable this with `--nocorr`.

### Output Interpretation
The primary output is `contigs.fa`. Shovill-se renames contigs to a standard format (e.g., `contig00001`) and includes metadata in the header:
*   `len`: Length of the contig.
*   `cov`: K-mer coverage.
*   `corr`: Number of post-assembly corrections made to that contig.

### Constraints
*   **Isolates Only**: Do not use this tool for metagenomes. The downsampling and error correction logic assumes a single dominant organism. Use MEGAHIT directly for metagenomic data.
*   **Illumina Only**: This pipeline is optimized for short-read Illumina data and is not intended for PacBio or Oxford Nanopore long reads.

## Reference documentation
- [Shovill-se GitHub Repository](./references/github_com_rpetit3_shovill.md)
- [Bioconda shovill-se Package Overview](./references/anaconda_org_channels_bioconda_packages_shovill-se_overview.md)
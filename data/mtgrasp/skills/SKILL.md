---
name: mtgrasp
description: mtGrasp (Mitochondrial Genome Reference-grade Assembly and Standardization Pipeline) is a specialized utility designed to automate the assembly of animal mitochondrial genomes.
homepage: https://github.com/bcgsc/mtGrasp
---

# mtgrasp

## Overview
mtGrasp (Mitochondrial Genome Reference-grade Assembly and Standardization Pipeline) is a specialized utility designed to automate the assembly of animal mitochondrial genomes. It streamlines the process from raw paired-end sequencing reads to a standardized, annotated circular assembly. The tool is particularly effective because it combines de novo assembly (via ABySS) with reference-based filtering and gap filling, ensuring high-quality results even for non-model organisms.

## Installation and Setup
The most reliable way to install mtGrasp and its numerous dependencies (ABySS, Snakemake, BLAST, etc.) is via Conda:
```bash
conda install -c conda-forge -c bioconda mtgrasp
```
Always verify the installation before starting a real run:
```bash
mtgrasp.py -test
```

## Core Usage Pattern
A standard mtGrasp run requires full paths for all file inputs.

```bash
mtgrasp.py \
  -r1 /path/to/forward_reads.fastq.gz \
  -r2 /path/to/reverse_reads.fastq.gz \
  -r /path/to/reference_database.fasta \
  -m 5 \
  -o ./output_directory
```

### Required Parameters
- `-r1` / `-r2`: Forward and reverse paired-end reads.
- `-r`: A FASTA file containing reference sequences. These are used to build a BLAST database to filter mitochondrial contigs.
- `-m`: The NCBI translation table code (e.g., 2 for Vertebrates, 5 for Invertebrates).
- `-o`: The directory where results will be stored.

## Expert Tips and Best Practices

### Reference Selection
The quality of the assembly depends on the filtering database provided via `-r`.
- If the exact species reference is unavailable, use sequences from the same genus or family.
- You can include multiple sequences in the reference FASTA to increase the likelihood of a match.
- **Caution**: Avoid adding too many sequences or duplicates, as this significantly increases memory usage and runtime without improving assembly quality.

### Handling Large Datasets
By default, mtGrasp subsamples 2,000,000 read pairs to speed up assembly.
- To use the full dataset: Use the `-nsub` flag.
- To change the subsampling depth: Use `-sub <N>` (e.g., `-sub 5000000`).

### Optimization for ABySS
If the default assembly fails or produces fragmented contigs, adjust the de Bruijn graph parameters:
- `-k`: K-mer size (default is 91).
- `-c`: K-mer minimum coverage multiplicity cutoff (default is 3).

### Annotation and Cleanup
- **Annotation**: Use `-an` to trigger gene annotation using MITOS. If `runmitos.py` is not in your PATH, specify it with `-mp /path/to/mitos/bin`.
- **Storage**: Use `-d` to automatically delete intermediate subdirectories and files upon successful completion to save disk space.

## Common CLI Patterns

**High-sensitivity run for complex samples:**
```bash
mtgrasp.py -r1 $(pwd)/R1.fq.gz -r2 $(pwd)/R2.fq.gz -r $(pwd)/refs.fa -m 2 -o sensitive_mt -t 16 -k 75 -c 2
```

**Quick annotation of an existing dataset:**
```bash
mtgrasp.py -r1 $(pwd)/R1.fq.gz -r2 $(pwd)/R2.fq.gz -r $(pwd)/refs.fa -m 5 -o annotated_mt -an -mp /opt/mitos/bin
```

## Reference documentation
- [mtGrasp GitHub Repository](./references/github_com_bcgsc_mtGrasp.md)
- [mtGrasp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mtgrasp_overview.md)
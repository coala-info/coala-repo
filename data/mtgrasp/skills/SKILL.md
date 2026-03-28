---
name: mtgrasp
description: mtGrasp automates the assembly and standardization of high-quality mitochondrial genomes from Illumina paired-end sequencing data. Use when user asks to generate reference-grade mitogenome assemblies, annotate mitochondrial sequences using MITOS, or optimize de novo assembly parameters for mitochondrial DNA.
homepage: https://github.com/bcgsc/mtGrasp
---

# mtgrasp

## Overview

mtGrasp (Mitochondrial Genome Reference-grade Assembly and Standardization Pipeline) is a high-throughput bioinformatics utility designed to generate high-quality mitochondrial genome assemblies from Illumina paired-end reads. It automates a complex workflow involving de novo assembly with ABySS, mitochondrial sequence filtering via BLAST, gap filling with Sealer, and final standardization. It is particularly useful for researchers who need to move from raw sequencing data to a finalized, annotated mitogenome with minimal manual intervention.

## Core Usage Patterns

### Required Parameters
To run a standard assembly, you must provide full paths for the input reads and the reference database:

```bash
mtgrasp.py -r1 /full/path/to/R1.fastq.gz -r2 /full/path/to/R2.fastq.gz -o output_dir -m [code] -r /full/path/to/ref_database.fa
```

*   `-m`: The mitochondrial genetic code (translation table). Common codes include `2` (Vertebrate), `5` (Invertebrate), or `13` (Ascidian).
*   `-r`: A FASTA file containing reference mitogenomes from related species to guide the filtering process.

### Common CLI Workflows

**1. Assembly with Annotation**
To perform the assembly and automatically run gene annotation using MITOS:
```bash
mtgrasp.py -r1 $R1 -r2 $R2 -o out_dir -m 2 -r $REFS -an
```

**2. Processing Full Datasets**
By default, mtGrasp subsamples 2,000,000 read pairs to speed up assembly. To use the entire dataset:
```bash
mtgrasp.py -r1 $R1 -r2 $R2 -o out_dir -m 2 -r $REFS -nsub
```

**3. Optimizing Assembly Parameters**
If the default k-mer size (91) or coverage cutoff (3) is not ideal for your data:
```bash
mtgrasp.py -r1 $R1 -r2 $R2 -o out_dir -m 2 -r $REFS -k 75 -c 2 -t 16
```

## Expert Tips and Best Practices

*   **Reference Selection**: The reference database (`-r`) does not need to be an exact match. Using scaffolds or mitogenomes from the same family or genus is usually sufficient for the BLAST-based filtering step.
*   **Path Requirements**: mtGrasp is strict about file paths. Always use absolute (full) paths for `-r1`, `-r2`, and `-r` to avoid Snakemake execution errors.
*   **Genetic Code**: Verify the correct translation table for your target taxon via the NCBI Taxonomy Browser before starting the run.
*   **Handling Locks**: If a previous run was interrupted, the directory may be locked by Snakemake. Use the `-u` or `--unlock` flag to clear the lock.
*   **Resource Management**: Use the `-d` flag to delete intermediate subdirectories and files upon successful completion to save disk space.
*   **MITOS Path**: If `runmitos.py` is not in your system PATH, specify its location explicitly using `-mp /path/to/mitos/bin`.



## Subcommands

| Command | Description |
|---------|-------------|
| mtgrasp.py | de novo assembly of reference-grade animal mitochondrial genomes |
| runmitos.py | (No description) |

## Reference documentation
- [mtGrasp README](./references/github_com_BirolLab_mtGrasp_blob_master_README.md)
- [mtGrasp Wrapper Script Documentation](./references/github_com_BirolLab_mtGrasp_blob_master_mtgrasp.py.md)
- [mtGrasp Snakemake Workflow](./references/github_com_BirolLab_mtGrasp_blob_master_mtgrasp.smk.md)
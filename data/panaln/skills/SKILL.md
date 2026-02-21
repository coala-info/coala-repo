---
name: panaln
description: The `panaln` tool provides a specialized workflow for genomic read alignment that incorporates known genetic variation into the reference structure.
homepage: https://github.com/Lilu-guo/Panaln
---

# panaln

## Overview
The `panaln` tool provides a specialized workflow for genomic read alignment that incorporates known genetic variation into the reference structure. By using a pangenome index rather than a linear reference, it reduces reference bias and improves alignment performance for reads containing non-reference alleles. The workflow consists of three primary stages: combining reference and variant data, indexing the resulting pangenome, and performing the final alignment.

## Installation and Setup
The tool is available via Bioconda or can be compiled from source.

**Conda Installation:**
```bash
conda install bioconda::panaln
```

**Source Compilation:**
If compiling from source, you must build the dependencies (FM and semiWFA) located in the repository subdirectories before building the main executable.
```bash
cd FM && make
cd ../semiWFA && make
cd ../ && make
```

## Core Workflow

### 1. Generate Pangenome (`combine`)
This step merges a standard reference FASTA with a VCF file to create a `.pan` file.
```bash
panaln combine -s /absolute/path/ref.fasta -v /absolute/path/variants.vcf -b output_basename
```
*   **-s**: Reference genome (FASTA).
*   **-v**: Variant call file (VCF).
*   **-b**: Basename for the generated pangenome.
*   **-c**: Context size (default: 150). Adjust this based on your read length or local complexity.

### 2. Construct Index (`index`)
Once the `.pan` file is created, it must be indexed for efficient searching.
```bash
panaln index -p /absolute/path/output_basename.pan
```
*   **-p**: The pangenome file generated in the previous step.

### 3. Read Alignment (`align`)
Align FASTQ reads against the pangenome index to produce a SAM file.
```bash
panaln align -x /absolute/path/index_basename -f /absolute/path/reads.fastq -s /absolute/path/output.sam
```
*   **-x**: The basename of the index created in step 2.
*   **-f**: Input sequencing reads (FASTQ).
*   **-s**: Output alignment file (SAM).

## Best Practices and Tips
*   **Absolute Paths**: The tool requires absolute paths for all file arguments. Using relative paths often leads to execution errors.
*   **Memory Management**: Pangenome indexing is memory-intensive. Ensure your environment has sufficient RAM, especially when working with large eukaryotic genomes (e.g., Human).
*   **Variant Selection**: For the `combine` step, using a filtered VCF containing high-confidence common variants (like those from the GIAB project or dbSNP common sets) typically yields better results than using unfiltered raw callsets which may introduce noise into the index.
*   **Dependency Check**: If the `panaln` command is not found after a source build, ensure the binary is in your PATH or call it directly using `./panaln`.

## Reference documentation
- [Panaln GitHub Repository](./references/github_com_Lilu-guo_Panaln.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_panaln_overview.md)
---
name: bamsurgeon
description: Bamsurgeon modifies existing sequence alignment files to introduce known mutations such as SNVs, indels, and structural variants. Use when user asks to add synthetic mutations to BAM files, test variant callers with realistic sequencing data, or simulate genomic variants in existing alignments.
homepage: https://github.com/adamewing/bamsurgeon
---


# bamsurgeon

## Overview

Bamsurgeon is a specialized toolkit for "surgerizing" existing sequence alignment files. Instead of generating synthetic reads from a reference genome, it modifies real sequencing data to introduce known mutations. This approach is superior for testing variant callers because it preserves the original data's characteristics, such as sequencing artifacts, coverage fluctuations, and mapping biases. 

The tool suite consists of three primary scripts: `addsnv.py` for single nucleotide variants, `addindel.py` for small insertions and deletions, and `addsv.py` for complex structural variants.

## Core CLI Usage

### 1. Adding Single Nucleotide Variants (SNVs)
Use `addsnv.py` to introduce point mutations. You must provide a site list containing the chromosome, start, end, and desired variant allele frequency (VAF).

```bash
python3 -O bin/addsnv.py -v snv_sites.txt -f input.bam -r reference.fasta -o output_mutated.bam
```

### 2. Adding Indels
Use `addindel.py` for small insertions and deletions. The variant file format typically requires chromosome, start, end, VAF, and the sequence to be inserted or "DEL" for deletions.

```bash
python3 -O bin/addindel.py -v indel_sites.txt -f input.bam -r reference.fasta -o output_indels.bam
```

### 3. Adding Structural Variants (SVs)
Use `addsv.py` for large-scale changes like inversions, duplications, and translocations. This often requires an insertion library for novel sequences.

```bash
python3 -O bin/addsv.py -p 4 -v sv_sites.txt -f input.bam -r reference.fasta -o output_sv.bam --aligner mem --inslib insertion_library.fa
```

## Expert Tips and Best Practices

- **Dependency Verification**: Before running complex simulations, always verify your environment using the included check script:
  `python3 -O scripts/check_dependencies.py`
- **Performance Optimization**: Always use the `-O` flag with `python3`. This enables Python's basic optimizations and skips internal `assert` statements, which significantly improves processing speed for large BAM files.
- **Aligner Consistency**: Ensure the `--aligner` argument matches the aligner used for the original BAM file (e.g., `mem` for BWA-MEM, `bowtie2` for Bowtie2). Bamsurgeon realigns reads around the mutation site to ensure the spiked-in variant is biologically plausible.
- **Multithreading**: Use the `-p` flag to specify the number of threads. Variant simulation is computationally expensive because it involves local re-assembly and re-alignment.
- **Variant File Format**: Variant files are generally tab-delimited. 
  - For SNVs: `chrom  pos  pos  VAF`
  - For SVs: `chrom  start  end  type` (where type can be DEL, INS, DUP, INV, or TRA).
- **Secondary Alignments**: If your downstream caller relies on secondary or supplementary alignments, use the `--keepsecondary` flag to prevent Bamsurgeon from stripping them during the surgerization process.

## Reference documentation
- [Bamsurgeon GitHub Repository](./references/github_com_adamewing_bamsurgeon.md)
- [Bioconda Bamsurgeon Overview](./references/anaconda_org_channels_bioconda_packages_bamsurgeon_overview.md)
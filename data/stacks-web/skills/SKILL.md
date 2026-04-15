---
name: stacks-web
description: Stacks-web executes the Stacks pipeline to transform raw restriction-enzyme-based sequence data into genotyped loci for evolutionary and genetic analysis. Use when user asks to demultiplex RAD-seq data, run de novo or reference-aligned assembly workflows, or perform population genomics analysis.
homepage: https://catchenlab.life.illinois.edu/stacks/
metadata:
  docker_image: "biocontainers/stacks-web:v2.2dfsg-1-deb_cv1"
---

# stacks-web

---

## Overview
The Stacks pipeline is a modular suite of tools designed to transform raw restriction-enzyme-based sequence data (like RAD-seq or GBS) into genotyped loci. This skill provides the procedural knowledge required to execute both de novo and reference-aligned workflows. It assists in selecting the correct parameters for stack formation, managing the population catalog, and exporting data for downstream evolutionary and genetic analysis.

## Core Workflows

### 1. Raw Read Pre-processing
Before assembly, reads must be demultiplexed and quality-filtered.
- **RAD-seq data**: Use `process_radtags`.
- **Randomly sheared data**: Use `process_shortreads`.

```bash
# Example: Demultiplexing paired-end HiSeq data with a single enzyme (sbfI)
process_radtags -P -p ./raw_dir -o ./samples -b ./barcodes_file -e sbfI -r -c -q
```
*Key Flags:* `-r` (rescue barcodes/sites), `-c` (clean uncalled bases), `-q` (discard low quality).

### 2. De Novo Pipeline (The "Wrapper" Approach)
For organisms without a reference genome, use `denovo_map.pl` to automate the core modules (`ustacks`, `cstacks`, `sstacks`, `tsv2bam`, `gstacks`).

```bash
# Standard de novo execution
denovo_map.pl --samples ./samples --popmap ./popmap_file -o ./stacks -M 4 -n 4 -T 8
```
*Optimization Tip:* Use the "r80" method—vary `-M` (mismatches within individuals) and `-n` (mismatches between individuals) to maximize the number of polymorphic loci present in 80% of individuals.

### 3. Reference-Aligned Pipeline
If a reference genome is available, align reads using an external aligner (e.g., BWA or Bowtie2), then use `ref_map.pl`.

```bash
# Standard reference-based execution
ref_map.pl --samples ./aligned_bam_dir --popmap ./popmap_file -o ./stacks -T 8
```

### 4. Population Genomics Analysis
The `populations` module is used to calculate $F_{ST}$, $\pi$, and $F_{IS}$, and to export data.

```bash
# Calculate stats and export for STRUCTURE
populations -P ./stacks -M ./popmap_file -r 0.80 --structure --genepop --fstats
```
*Key Flags:* `-r 0.8` (require a locus in 80% of individuals), `-p` (minimum number of populations a locus must be in).

## Expert Tips and Best Practices

- **PCR Duplicates**: If using paired-end, single-digest RAD-seq, run `clone_filter` before `process_radtags` or use the `--rm-pcr-duplicates` flag in `gstacks` to remove artifacts.
- **Gapped Alignments**: Stacks supports gapped alignments by default. If you encounter issues with highly polymorphic regions, adjust `--max-gaps` in `ustacks` or `cstacks`.
- **Memory Management**: For very large datasets (hundreds of individuals), avoid adding every individual to the catalog in `cstacks`. Select a representative subset (e.g., 10-20 per population) to build the catalog, then match all individuals against it using `sstacks`.
- **Thread Usage**: Most modules support `-t` or `--threads`. Ensure your environment has sufficient OpenMP support.
- **Input Formats**: While FASTQ is standard, `gstacks` requires coordinate-sorted BAM files for reference-based runs.

## Reference documentation
- [Stacks Manual](./references/catchenlab_life_illinois_edu_stacks_manual.md)
- [Pipeline Components Overview](./references/catchenlab_life_illinois_edu_stacks_comp.php.md)
- [Frequently Asked Questions](./references/catchenlab_life_illinois_edu_stacks_faq.php.md)
- [process_radtags Documentation](./references/catchenlab_life_illinois_edu_stacks_comp_process_radtags.php.md)
- [gstacks Documentation](./references/catchenlab_life_illinois_edu_stacks_comp_gstacks.php.md)
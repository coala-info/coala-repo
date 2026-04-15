---
name: stacks
description: Stacks processes short-read sequences into genetic markers for population genomics and genetic mapping using de novo or reference-based workflows. Use when user asks to demultiplex RAD-seq data, perform de novo assembly of loci, align reads to a reference genome, or calculate population-level statistics like FST and Pi.
homepage: https://catchenlab.life.illinois.edu/stacks/
metadata:
  docker_image: "quay.io/biocontainers/stacks:2.68--h077b44d_3"
---

# stacks

## Overview
Stacks is a specialized bioinformatics suite designed to turn short-read sequences into genetic markers. It is primarily used for population genomics, phylogeography, and genetic mapping. The pipeline handles the entire workflow from demultiplexing raw Illumina reads to calculating population-level statistics like FST, π, and FIS. It supports both *de novo* assembly (when no reference genome is available) and reference-aligned workflows.

## Core Pipeline Workflows

### 1. Data Pre-processing
Before assembly, raw reads must be cleaned and demultiplexed.
- **process_radtags**: Use for RAD-seq data to check barcodes and restriction sites.
  `process_radtags -p ./raw -o ./samples -b ./barcodes -e sbfI -r -c -q`
- **clone_filter**: Use for paired-end, sheared data to remove PCR duplicates.
  `clone_filter -1 read1.fq.gz -2 read2.fq.gz -i gzfastq -o ./filtered`
- **process_shortreads**: Use for non-RAD genomic or transcriptomic data cleaning.

### 2. De Novo Pipeline (denovo_map.pl)
The most common entry point for users without a reference genome. It wraps `ustacks`, `cstacks`, `sstacks`, `tsv2bam`, `gstacks`, and `populations`.
- **Basic Execution**:
  `denovo_map.pl --samples ./samples --popmap ./popmap -o ./stacks -M 3 -n 3 -T 8`
- **Key Parameters**:
  - `-M`: Mismatches allowed between stacks within an individual (default 2).
  - `-n`: Mismatches allowed between stacks between individuals (often set equal to M).
  - `--paired`: Required if using paired-end data to trigger contig assembly in `gstacks`.

### 3. Reference-based Pipeline (ref_map.pl)
Use when reads have already been aligned to a reference genome (e.g., via BWA or Bowtie2).
- **Basic Execution**:
  `ref_map.pl --samples ./aligned_bam_dir --popmap ./popmap -o ./stacks -T 8`

### 4. Population Analysis (populations)
This module is often run multiple times after the core pipeline to refine filters or export different formats.
- **Filtering and Export**:
  `populations -P ./stacks -M ./popmap -r 0.80 -p 3 --vcf --genepop --structure --write-single-snp`
- **Parameters**:
  - `-r`: Minimum percentage of individuals in a population required to keep a locus.
  - `-p`: Minimum number of populations a locus must be present in.
  - `--write-single-snp`: Recommended for STRUCTURE to avoid linked markers.

## Expert Tips and Best Practices

- **Parameter Optimization**: Follow the "r80" method. Run the pipeline with varying `-M` and `-n` values (e.g., 1-9) and select the value that maximizes the number of polymorphic loci found in 80% of individuals.
- **Population Maps**: Ensure your popmap is a tab-separated file with `[sample_name] [population_id]`. The sample name must match the filename prefix in your samples directory.
- **Memory Management**: For very large datasets, avoid `denovo_map.pl`. Run `ustacks` individually across a cluster, then build a catalog (`cstacks`) using only a representative subset of individuals to reduce error accumulation.
- **PCR Duplicates**: If using single-digest RAD-seq with random shearing, always use `--rm-pcr-duplicates` in `gstacks` or `denovo_map.pl` to improve SNP calling accuracy.
- **Gapped Alignments**: Stacks 2.0+ supports gapped alignments. If your species has high indel rates, ensure gapped assembly is not disabled (it is enabled by default).



## Subcommands

| Command | Description |
|---------|-------------|
| clone_filter | You must specify an input file of a directory path to a set of input files. |
| cstacks | Build a catalog of loci from sample data. |
| gstacks | De novo and reference-based mode for variant calling. |
| populations | Stacks populations module for population genetics analysis. |
| process_radtags | Process RAD-seq data to demultiplex, clean, and filter reads. |
| process_shortreads | process_shortreads 2.68 |
| sstacks | Stacks de novo assembly pipeline |
| tsv2bam | Converts STACKS tsv files to BAM format. |
| ustacks | ustacks -f in_path -o out_path [-M max_dist] [-m min_reads] [-t num_threads] |

## Reference documentation
- [Stacks Manual](./references/catchenlab_life_illinois_edu_stacks_manual.md)
- [denovo_map.pl Documentation](./references/catchenlab_life_illinois_edu_stacks_comp_denovo_map.php.md)
- [populations Documentation](./references/catchenlab_life_illinois_edu_stacks_comp_populations.php.md)
- [Parameter Optimization Tutorial](./references/catchenlab_life_illinois_edu_stacks_param_tut.php.md)
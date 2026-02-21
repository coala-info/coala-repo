---
name: stacks
description: The `stacks` skill provides procedural knowledge for managing the Stacks software suite.
homepage: https://catchenlab.life.illinois.edu/stacks/
---

# stacks

## Overview
The `stacks` skill provides procedural knowledge for managing the Stacks software suite. It is designed to transform raw Illumina sequencing reads into genotyped loci and population-level statistics. Use this skill to navigate the modular components of the pipeline—from initial cleaning and demultiplexing to the final calculation of F-statistics and export of VCF files. It covers both the `denovo_map.pl` and `ref_map.pl` wrappers as well as the execution of individual core modules for custom workflows.

## Core Workflows

### 1. Data Pre-processing
Before building loci, raw reads must be cleaned and demultiplexed.
- **RAD-seq Data**: Use `process_radtags`. It checks barcodes and restriction sites.
  - *Pattern*: `process_radtags -p ./raw -o ./samples -b ./barcodes -e sbfI -r -c -q`
  - `-r`: Rescue barcodes and cutsites with minor errors.
  - `-c`: Remove reads with uncalled bases.
  - `-q`: Discard low-quality reads (sliding window).
- **Randomly Sheared Data**: Use `process_shortreads` for genomic/transcriptomic data that is not restriction-anchored.
- **PCR Duplicate Removal**: Use `clone_filter` for paired-end data to identify and remove clones based on identical insert lengths or random oligos.

### 2. De Novo Pipeline (The "ustacks" Path)
Used when no reference genome is available.
1. **ustacks**: Build stacks (putative alleles) for each individual.
   - `ustacks -f ./samples/sample1.fq.gz -o ./stacks -m 3 -M 2`
   - `-m`: Minimum depth to create a stack (default 3).
   - `-M`: Max distance (nucleotides) between stacks (default 2).
2. **cstacks**: Build a catalog of loci from a subset of individuals (e.g., parents in a cross or representative population samples).
   - `cstacks -P ./stacks -M ./popmap -n 1`
   - `-n`: Mismatches allowed between sample loci (default 1).
3. **sstacks**: Match all individuals against the catalog.
   - `sstacks -P ./stacks -M ./popmap`
4. **tsv2bam**: Transpose data to locus-oriented BAM files and integrate paired-end reads.
5. **gstacks**: Assemble contigs, call SNPs, and genotype individuals.
6. **populations**: Calculate population statistics and export data.

### 3. Reference-Based Pipeline (The "gstacks" Path)
Used when reads are already aligned to a reference genome (BAM files).
1. **Alignment**: Align reads using an external tool (e.g., BWA or Bowtie2) and sort by coordinate.
2. **gstacks**: Build loci directly from the BAM files.
   - `gstacks -I ./aligned -M ./popmap -O ./stacks`
3. **populations**: Filter and export.

## Expert Tips and Best Practices
- **Parameter Optimization**: Use the "r80" method. Vary `-M` and `-n` (usually keeping $n = M$ or $n = M+1$) and select values that maximize polymorphic loci present in 80% of individuals.
- **Population Maps**: Always maintain a tab-separated `popmap` file (Format: `SampleName [tab] PopulationID`). This is the primary way Stacks organizes metadata.
- **Thread Management**: Most modules support `-t` or `--threads`. Use this to leverage multi-core systems, especially for `ustacks` and `gstacks`.
- **Gapped Alignments**: Stacks supports gapped alignments by default (since v1.38). If processing very divergent taxa, ensure `--max-gaps` is tuned in `ustacks` and `cstacks`.
- **Memory Efficiency**: If `cstacks` consumes too much memory, limit the number of individuals added to the catalog to a representative subset rather than the entire dataset.

## Reference documentation
- [Stacks Manual](./references/catchenlab_life_illinois_edu_stacks_manual.md)
- [Pipeline Components](./references/catchenlab_life_illinois_edu_stacks_comp.php.md)
- [Frequently Asked Questions](./references/catchenlab_life_illinois_edu_stacks_faq.php.md)
- [process_radtags Details](./references/catchenlab_life_illinois_edu_stacks_comp_process_radtags.php.md)
- [gstacks Details](./references/catchenlab_life_illinois_edu_stacks_comp_gstacks.php.md)
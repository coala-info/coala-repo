---
name: locityper
description: Locityper resolves genotypes in highly polymorphic and structurally complex genomic regions using short-read or long-read data. Use when user asks to prepare target loci, recruit reads from BAM or CRAM files, align reads to candidate haplotypes, prune haplotype databases, or perform final genotyping.
homepage: https://github.com/tprodanov/locityper
metadata:
  docker_image: "quay.io/biocontainers/locityper:1.3.4--ha6fb395_0"
---

# locityper

## Overview

Locityper is a specialized bioinformatics tool designed to resolve genotypes in highly polymorphic and structurally complex regions of the genome. Unlike general-purpose variant callers, it focuses on specific loci, leveraging both short-read (Illumina) and long-read (PacBio/Oxford Nanopore) data to provide accurate haplotype-level calls. It is particularly useful for medical and population genetics research involving the immune system or other hyper-variable gene families where standard mapping often fails due to high sequence divergence.

## Core Workflow and CLI Usage

### 1. Target Preparation
Define the genomic regions of interest and prepare the reference environment.
- Use `locityper target` to specify loci.
- Support for multiple boundary expansions allows for better recruitment in flanking regions.
- **Pattern**: `locityper target -t <targets.bed> -r <reference.fasta> -o <output_dir>`

### 2. Read Recruitment
Extract reads that potentially belong to the target loci from WGS BAM/CRAM files.
- Use the `--distinct` argument to ensure unique read capture when dealing with overlapping or highly similar regions.
- Provide the index file as a second input to `-a` or `-I` when required.
- **Pattern**: `locityper recruit -i <input.bam> -t <target_dir> -o <recruited.bam>`

### 3. Haplotype Alignment
Align recruited reads against a database of known candidate haplotypes.
- **Best Practice**: Always use the `--ordered` flag to ensure the output is sorted, which is required for downstream genotyping.
- Locityper is optimized for speed; recent updates significantly improve alignment throughput.
- **Pattern**: `locityper align -i <recruited.bam> -r <haplotypes.fasta> -o <aligned.bam> --ordered`

### 4. Haplotype Pruning
Reduce the complexity of the search space by clustering and pruning similar haplotypes.
- Use `--n-clusters` to define the granularity of the pruning process.
- Pruning can be performed even if some values are missing in the distance matrix.
- **Pattern**: `locityper prune -i <distances.bin> --n-clusters <int> -o <pruned_haplotypes.fasta>`

### 5. Genotyping
Perform the final genotype call based on alignment likelihoods.
- Use `--recr-alt-len` to account for recruitment regions during the genotyping phase.
- The output is typically a JSON file containing the most likely haplotype pairs and their associated quality scores.
- **Pattern**: `locityper genotype -i <aligned.bam> -g <gene_name> -o <output.json>`

## Expert Tips and Best Practices

- **Read Length Handling**: Locityper is designed to handle both short and long reads. Ensure your recruitment parameters (like fragment size for short reads) match your library preparation.
- **Memory Management**: When working with large haplotype databases (e.g., full HLA IMGT/HLA sets), use the `prune` command to prevent memory exhaustion and reduce false positive alignments.
- **Progress Monitoring**: Recent versions show alignment progress; monitor this to estimate completion time for large cohorts.
- **Error Messages**: If the tool fails, check for specific error messages regarding missing values in pruning or recruitment region mismatches, as these are common points of failure in complex loci.



## Subcommands

| Command | Description |
|---------|-------------|
| locityper | Align medium-size sequence to each other. |
| locityper | Remove similar target haplotypes. |
| locityper preproc | Preprocess WGS dataset. |
| locityper recruit | Recruit reads to one/multiple loci. |
| locityper_genotype | Genotype complex loci. |
| locityper_target | Adds target locus/loci to the database. |

## Reference documentation

- [Locityper README](./references/github_com_tprodanov_locityper_blob_main_README.md)
- [Command Reference](./references/locityper_vercel_app_commands.md)
- [Recent Updates and Flags](./references/github_com_tprodanov_locityper_commits_main.md)
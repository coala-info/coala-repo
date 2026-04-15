---
name: mgems
description: mGEMS partitions sequencing reads from mixed samples into separate bins corresponding to different strains or species using a probabilistic framework. Use when user asks to bin mixed genomic reads, extract reads for specific taxonomic groups, or perform abundance-based read partitioning.
homepage: https://github.com/PROBIC/mGEMS
metadata:
  docker_image: "quay.io/biocontainers/mgems:1.3.3--h13024bc_2"
---

# mgems

## Overview
mGEMS (mixed Genomic Epidemiology with Mixed Samples) is a tool for partitioning sequencing reads from a mixed sample into separate bins corresponding to different strains or species. It utilizes a probabilistic framework to assign reads to their most likely source group. This skill provides the necessary command-line patterns to execute the full binning pipeline, including integration with its required upstream dependencies, Themisto and mSWEEP.

## Core Workflow
The mGEMS pipeline typically follows a four-step process: indexing, pseudoalignment, abundance estimation, and finally, binning.

### 1. Indexing (Themisto)
Before binning, you must create a k-mer index of your reference sequences.
```bash
themisto build -k 31 -i references.fasta -o themisto_index/index --temp-dir tmp/
```

### 2. Pseudoalignment (Themisto)
Align your paired-end reads to the index. The `--sort-output` flag is mandatory for mGEMS compatibility.
```bash
themisto pseudoalign -q reads_1.fastq.gz -o aln_1.aln -i themisto_index/index --sort-output --gzip-output
themisto pseudoalign -q reads_2.fastq.gz -o aln_2.aln -i themisto_index/index --sort-output --gzip-output
```

### 3. Abundance Estimation (mSWEEP)
Generate the probability matrix and abundance estimates required by mGEMS.
```bash
mSWEEP --themisto-1 aln_1.aln.gz --themisto-2 aln_2.aln.gz -i reference_grouping.txt --write-probs -o msweep_out
```

### 4. Binning and Extraction (mGEMS)
The primary `mGEMS` command performs both binning (assignment) and extraction (writing FASTQ files).
```bash
mGEMS -r reads_1.fastq.gz,reads_2.fastq.gz \
      -i reference_grouping.txt \
      --themisto-alns aln_1.aln.gz,aln_2.aln.gz \
      --probs msweep_out_probs.csv \
      -a msweep_out_abundances.txt \
      --index themisto_index \
      -o mgems_output_dir/
```

## Advanced CLI Patterns

### Selective Extraction
To save time and disk space, extract only specific groups of interest or filter by abundance:
- **Specific groups**: `--groups group_A,group_B`
- **Abundance threshold**: `--min-abundance 0.05` (extracts only groups with >5% relative abundance)

### Two-Step Processing
If you want to perform assignment first and extract reads later (or on a different machine):
1. **Bin only**: `mGEMS bin [options] -o output_dir/`
2. **Extract later**: `mGEMS extract --bins output_dir/group_A.bin -r reads_1.fastq.gz,reads_2.fastq.gz -o final_fastq/`

### Debugging and Validation
- **Assignment Table**: Use `--write-assignment-table` to output a `reads_to_groups.tsv` file, which is useful for auditing exactly where each read was placed.
- **Unassigned Reads**: Use `--write-unassigned` to capture reads that aligned to the reference but could not be confidently placed in a specific group.
- **Unique Assignments**: Use `--unique-only` to discard reads that map to multiple groups with similar probabilities, increasing the purity of the resulting bins.

## Expert Tips
- **Thread Management**: On Linux systems, use the undocumented `-t` flag to increase thread count for faster processing.
- **Memory Efficiency**: mGEMS is designed to handle large datasets, but ensure your temporary directory (`--temp-dir` in Themisto) has sufficient space, as pseudoalignment files can be quite large before compression.
- **Assembly Recommendation**: For downstream assembly of mGEMS bins, use **shovill** for standard cases. If the strains in your mixture are very closely related, consider **MEGAHIT**, which often handles fine-scale differences better.

## Reference documentation
- [mGEMS GitHub Repository](./references/github_com_PROBIC_mGEMS.md)
- [mGEMS Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mgems_overview.md)
---
name: metadmg
description: metaDMG-cpp quantifies DNA damage patterns in ancient metagenomic datasets by analyzing C-to-T and G-to-A transitions in alignment files. Use when user asks to estimate DNA damage profiles, perform taxonomic LCA analysis for metagenomics, or generate damage statistics for specific organisms and contigs.
homepage: https://github.com/metaDMG-dev/metaDMG-cpp
---


# metadmg

## Overview
metaDMG-cpp is a high-performance tool optimized for ancient metagenomics. It quantifies DNA damage patterns—specifically C-to-T transitions at the 5' end and G-to-A at the 3' end—by leveraging the MD tag in alignment files. This tool is significantly faster than legacy software and is built to handle datasets where reads are mapped against thousands of reference genomes or complex taxonomic trees. Use this skill to generate damage profiles for single organisms or to perform taxonomically-aware damage estimation for metagenomic samples.

## Installation and Setup
The most reliable way to install the tool is via Conda:
```bash
conda install -c bioconda metadmg
```
Note: The tool requires the `MD:Z` field in the input BAM/SAM files. If your alignments lack this field, you must use a tool like `samtools calmd` to add it before running metaDMG.

## Common CLI Patterns

### 1. Global Damage Estimation (Single Source)
Use this for bone or tooth samples where you need a single aggregate damage profile across all references (similar to mapDamage2.0).
```bash
metadmg-cpp getdamage --run_mode 0 --threads 8 --out_prefix sample_output input.bam
```

### 2. Local Damage Estimation (Metagenomics)
Use this to calculate damage statistics for every unique reference/contig in the BAM file.
```bash
metadmg-cpp getdamage --run_mode 1 --min_length 35 --print_length 5 input.bam
```

### 3. Taxonomic LCA Analysis
To retrieve damage estimates for specific taxonomic levels (e.g., species, genus), use the `lca` command. This requires NCBI taxonomy files.
```bash
metadmg-cpp lca --bam input.bam \
    --names ncbi/names.dmp.gz \
    --nodes ncbi/nodes.dmp.gz \
    --acc2tax ncbi/nucl_gb.accession2taxid.gz \
    --lca_rank species \
    --sim_score_low 0.95 --sim_score_high 1.0
```

### 4. Inspecting Results
The output is a binary `.bdamage.gz` file. To view the substitution matrix in a human-readable format:
```bash
metadmg-cpp print sample_output.bdamage.gz
```

## Expert Tips and Best Practices
- **CRAM Support**: When using CRAM files, you must provide the reference fasta file using the `-f/--fasta` flag.
- **Read Length Filtering**: Ancient DNA is typically short. Use `-l/--min_length` (default 35) to filter out ultra-short fragments that might lead to spurious alignments.
- **Damage Window**: The `-p/--print_length` parameter determines how many positions at the ends of the reads are used for damage estimation. The default is 5, but for highly degraded samples, you might increase this to 10 or 15 to see the full decay curve.
- **LCA Filtering**: For metagenomic data, use `--sim_score_low 0.95` and `--sim_score_high 1.0` to ensure that only high-confidence alignments contribute to the taxonomic damage profiles.
- **Memory Management**: When running `lca` mode with large NCBI taxonomy files, ensure the system has sufficient RAM to load the `accession2taxid` table.

## Reference documentation
- [metaDMG-cpp GitHub Repository](./references/github_com_metaDMG-dev_metaDMG-cpp.md)
- [metaDMG Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_metadmg_overview.md)
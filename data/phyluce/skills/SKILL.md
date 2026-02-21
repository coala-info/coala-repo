---
name: phyluce
description: Phyluce is a comprehensive bioinformatics suite designed to transform raw genomic data into phylogenomic insights.
homepage: https://github.com/faircloth-lab/phyluce
---

# phyluce

## Overview

Phyluce is a comprehensive bioinformatics suite designed to transform raw genomic data into phylogenomic insights. While originally built for Ultraconserved Elements (UCEs), it is versatile enough to handle various conserved loci across different evolutionary timescales. The toolset is modular, allowing users to assemble contigs from raw reads, identify specific target loci within those assemblies, and generate parallelized alignments for downstream phylogenetic inference.

## Installation and Environment

The recommended way to install phyluce is via Conda to manage its extensive dependency list:

```bash
conda install -c bioconda phyluce
```

Ensure you are working within a dedicated environment to avoid conflicts with other Python-based bioinformatics tools.

## Core Workflow Patterns

### 1. Assembly
Phyluce provides wrappers for common assemblers (like SPAdes or Velvet).
- **Pattern**: `phyluce_assembly_assemblo_spades`
- **Tip**: Ensure your input configuration file correctly maps sample names to their respective FASTQ files.

### 2. Identifying UCE Loci
After assembly, you must match your contigs against a probe set to identify UCEs.
- **Matching**: Use `phyluce_assembly_get_match_counts` to determine which contigs correspond to which UCE probes.
- **Extraction**: Use `phyluce_assembly_get_fastas_from_match_counts` to pull the identified sequences into a monolithic FASTA file for the next steps.

### 3. Alignment and Trimming
Phyluce automates the alignment of hundreds or thousands of loci in parallel.
- **Alignment**: `phyluce_align_seqcap_align` is the standard entry point for generating alignments.
- **Filtering**: Use `phyluce_align_get_only_loci_with_min_taxa` to filter your dataset. For example, if you have 50 taxa, you might only want to keep loci present in at least 75% (38) of them to reduce missing data.
- **Trimming**: Tools like `phyluce_align_get_trimmed_alignments_from_untrimmed` (often using internal engines like Gblocks or trimAl) help clean the data.

### 4. Data Summary and Export
- **Summary**: Use `phyluce_align_get_align_summary_data` to get statistics on your final matrix (number of loci, total base pairs, percentage of missing data).
- **Formatting**: Phyluce can export to various formats (NEXUS, PHYLIP) required by tree-building software like RAxML, IQ-TREE, or ExaML.

## Expert Tips

- **Memory Management**: Assembly steps (especially using SPAdes) are RAM-intensive. Monitor your system resources and use the `--cores` and `--memory` flags where available in the wrappers.
- **Naming Conventions**: Phyluce is sensitive to taxon names. Avoid using special characters (dashes, spaces, periods) in your sample names; underscores are the safest delimiter.
- **Locus Names**: When extracting FASTAs, the tool often appends locus names to the headers. If your downstream phylogenetic software has strict header length limits, use `phyluce_align_remove_locus_name_from_files` to clean them.
- **Phasing**: For population-level studies, explore the phasing workflows to resolve allelic variation in your UCE data.

## Reference documentation

- [Phyluce GitHub Repository](./references/github_com_faircloth-lab_phyluce.md)
- [Phyluce Issues and Script References](./references/github_com_faircloth-lab_phyluce_issues.md)
- [Bioconda Phyluce Overview](./references/anaconda_org_channels_bioconda_packages_phyluce_overview.md)
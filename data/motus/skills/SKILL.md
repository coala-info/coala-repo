---
name: motus
description: The `motus` tool provides a high-resolution method for taxonomic profiling by mapping metagenomic reads against a database of 10 universal marker genes (MGs).
homepage: http://motu-tool.org/
---

# motus

## Overview
The `motus` tool provides a high-resolution method for taxonomic profiling by mapping metagenomic reads against a database of 10 universal marker genes (MGs). Unlike methods that rely on full genomes, `motus` uses these MGs to delineate species-level operational taxonomic units (mOTUs), allowing for the quantification of both known reference organisms and previously uncharacterized microbial dark matter (meta-mOTUs). It is particularly effective for consistent profiling across different sequencing depths and environments.

## Core Workflows

### Basic Taxonomic Profiling
To generate a taxonomic profile from raw metagenomic reads (FASTQ), use the following pattern:

```bash
# Profile a single sample (paired-end)
motus profile -f forward.fq.gz -r reverse.fq.gz -t 8 > sample_profile.txt

# Profile a single sample (interleaved or single-end)
motus profile -s reads.fq.gz -n "Sample_Name" > sample_profile.txt
```

### Merging and Comparison
After profiling individual samples, merge them into a single abundance table for comparative analysis:

```bash
# Merge multiple profile files
motus merge -i sample1.txt,sample2.txt,sample3.txt -o merged_profiles.txt
```

### Advanced Profiling Options
- **Relative vs. Absolute Abundance**: By default, `motus` provides relative abundances. Use `-c` to get counts (useful for downstream tools like DESeq2).
- **Taxonomic Level**: Use `-l` to specify the rank (e.g., `phylum`, `genus`, `mOTU`). Default is `mOTU`.
- **Mapping Quality**: Adjust `-g` (number of marker genes required) to increase stringency in low-biomass samples.

## Expert Tips
- **Database Updates**: Ensure you are using the latest mOTUs database (v3+) to include the ~19,000 ext-mOTUs derived from metagenome-assembled genomes (MAGs).
- **Metatranscriptomics**: When profiling metatranscriptomes, the output represents "metabolic activity" rather than "genomic abundance."
- **Memory Management**: For large datasets, use the `-t` flag to specify threads, but monitor RAM usage as the marker gene database must be loaded into memory.
- **Consistency**: Always use the same version of `motus` and the same database across all samples in a single study to ensure profiles are comparable.

## Reference documentation
- [mOTUs Homepage and Summary](./references/motu-tool_org_index.md)
- [Bioconda motus Package Overview](./references/anaconda_org_channels_bioconda_packages_motus_overview.md)
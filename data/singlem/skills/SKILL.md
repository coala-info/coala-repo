---
name: singlem
description: SingleM is a specialized tool for profiling microbial and viral communities directly from shotgun metagenomic reads.
homepage: https://github.com/wwood/singlem
---

# singlem

## Overview
SingleM is a specialized tool for profiling microbial and viral communities directly from shotgun metagenomic reads. By focusing on specific marker genes rather than full assembly or k-mer distributions, it provides high accuracy in estimating relative abundance and excels at detecting novel lineages that lack close genomic representatives. It supports a variety of workflows including taxonomic profiling, prokaryotic fraction estimation, and data preparation for targeted metagenomic coassembly.

## Installation
Install SingleM via Bioconda:
```bash
conda install -c bioconda singlem
```

## Core CLI Usage

### Taxonomic Profiling with `pipe`
The `pipe` command is the primary entry point for processing raw metagenomic reads.
- **Basic Profiling**: Run `singlem pipe` on your input sequences (FASTQ/FASTA).
- **Long-Read Support**: For Nanopore (>= R10.4.1) or PacBio HiFi reads, ensure you are using version 0.20.0 or later.
- **Performance Tuning**: Use `--read-chunk-size` and `--read-chunk-num` to manage memory usage and parallel processing during the search phase.
- **Handling Frameshifts**: Use the `--frameshift` flag when assigning taxonomy to account for sequencing errors that might disrupt marker gene reading frames.
- **Taxonomy Assignment**: If you only need to extract marker sequences without taxonomic labels, use `--no-assign-taxonomy` to save time.

### Estimating Microbial Content
Use the `prokaryotic_fraction` mode to determine the prevalence of bacterial and archaeal DNA in a sample. This is essential for:
- Assessing eukaryotic or host contamination.
- Normalizing abundances across diverse biomes.

### Result Aggregation and Summarization
- **Summarise**: Use `singlem summarise` to collapse individual marker hits into OTU tables or taxonomic profiles.
- **Condense**: Use `singlem condense` to simplify complex outputs for downstream statistical analysis.
- **Renew**: Use `singlem renew` to update older SingleM outputs with newer taxonomic databases or metadata.

### Advanced Marker Extraction
Use the `supplement` command to extract specific data from processed samples:
- **Matched Proteins**: Use `--output-matched-protein-sequences` to extract the amino acid sequences of the markers identified in your reads.
- **Progress Tracking**: For large datasets, the tool supports progress bars (via tqdm) to monitor `hmmsearch` and aggregation steps.

## Expert Tips
- **Novelty Detection**: SingleM is specifically designed to be "novelty-inclusive." If your sample contains many "unclassified" hits in other profilers, SingleM's marker-based approach may provide better resolution of these novel branches.
- **Input Formats**: The tool natively supports compressed inputs including `.gz` and `.zst` (Zstandard).
- **Coassembly Preparation**: Use SingleM results as input for "Bin Chicken" to identify which metagenomes should be coassembled to maximize the recovery of specific novel MAGs.
- **Phage Profiling**: For dsDNA phages, ensure you are using the Lyrebird-compatible databases (available in version 0.19.0+).

## Reference documentation
- [singlem - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_singlem_overview.md)
- [wwood/singlem: Novelty-inclusive microbial community profiling](./references/github_com_wwood_singlem.md)
- [Commits · wwood/singlem](./references/github_com_wwood_singlem_commits_main.md)
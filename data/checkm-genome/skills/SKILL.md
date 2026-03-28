---
name: checkm-genome
description: CheckM evaluates the quality of genomic bins by estimating completeness and contamination using lineage-specific marker sets. Use when user asks to assess genome quality, identify single-copy marker genes, merge complementary bins, or remove outlier sequences from genomic datasets.
homepage: https://github.com/Ecogenomics/CheckM
---


# checkm-genome

## Overview
CheckM is a specialized bioinformatics suite designed to evaluate the quality of genomic bins. It uses a phylogenetic framework to identify sets of ubiquitous, single-copy genes (marker sets) specific to a genome's lineage. By checking for the presence, absence, or duplication of these markers, it provides robust estimates of how much of a genome is present (completeness) and how much foreign DNA is mixed in (contamination). This skill provides the necessary command patterns for executing standard workflows and managing large-scale genomic datasets.

## Core Workflows

### Lineage-Specific Workflow (Recommended)
The most common entry point. It automatically places bins in a reference tree, identifies the appropriate marker set, and calculates statistics.
```bash
checkm lineage_wf <bin_directory> <output_directory>
```
*   **Note**: Ensure your bins are in FASTA format (usually `.fna`, `.fasta`, or `.fa`).
*   **Threads**: Use `-t <threads>` to speed up the HMMER and Prodigal steps.

### Taxonomic-Specific Workflow
Use this if you already know the taxonomic identity of your bins and want to use a specific marker set (e.g., only Bacterial markers).
```bash
# List available taxa
checkm taxon_list

# Run for a specific rank (e.g., Family Enterobacteriaceae)
checkm taxon_set family Enterobacteriaceae <marker_file>
checkm analyze <marker_file> <bin_directory> <output_directory>
checkm qa <marker_file> <output_directory>
```

## Bin Exploration and Modification

### Identifying Mergable Bins
CheckM can suggest bins that might be parts of the same genome based on complementary marker sets.
```bash
checkm merge <marker_set_file> <bin_directory> <output_directory>
```
*   **Expert Tip**: Only merge bins if they also show similar GC content and coding density (check via `checkm qa`).

### Removing Outliers
Identify and remove sequences that don't fit the genomic profile (GC, tetranucleotide signature, or coding density) of the rest of the bin.
```bash
# 1. Calculate tetranucleotide signatures
checkm tetra <seq_file> <tetra_output_file>

# 2. Identify outliers
checkm outliers <output_directory> <bin_directory> <tetra_output_file> <outliers_tsv>

# 3. Modify bin (remove identified outliers)
checkm modify -r <seq_id> <original_bin.fna> <new_bin.fna>
```

## Best Practices and Troubleshooting

### Handling Large Datasets
*   **Memory Management**: For runs exceeding 1,000 genomes, split them into batches. A 64GB RAM machine typically handles ~1,000 genomes at 40 threads efficiently.
*   **Recursion Errors**: If you encounter Python recursion errors, it is a known symptom of processing too many genomes in a single directory; use smaller batches.

### Data Path Configuration
If CheckM cannot find its reference data, set the environment variable:
```bash
export CHECKM_DATA_PATH=/path/to/checkm_data
```

### Quality Thresholds
Standard "High-Quality" MAG (Metagenome-Assembled Genome) definitions often require:
*   **Completeness**: >90%
*   **Contamination**: <5%



## Subcommands

| Command | Description |
|---------|-------------|
| analyze | Identify marker genes in bins and calculate genome statistics. |
| checkm | CheckM is a tool for assessing the quality of microbial genome bins. |
| lineage_wf | Runs tree, lineage_set, analyze, qa |
| qa | Assess bins for contamination and completeness. |
| ssu_finder | Identify SSU (16S/18S) rRNAs in sequences. |
| taxonomy_wf | Runs taxon_set, analyze, qa |

## Reference documentation
- [CheckM Wiki Home](./references/github_com_Ecogenomics_CheckM_wiki.md)
- [Genome Quality Commands](./references/github_com_Ecogenomics_CheckM_wiki_Genome-Quality-Commands.md)
- [Bin Exploration and Modification](./references/github_com_Ecogenomics_CheckM_wiki_Bin-Exploration-and-Modification.md)
- [Workflows Overview](./references/github_com_Ecogenomics_CheckM_wiki_Workflows.md)
- [Bugs and Feature Requests (Batch Processing)](./references/github_com_Ecogenomics_CheckM_wiki_Bugs-and-Feature-Requests.md)
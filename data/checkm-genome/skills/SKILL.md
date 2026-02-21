---
name: checkm-genome
description: CheckM is a specialized bioinformatic toolset designed to determine the quality of microbial genomes.
homepage: https://github.com/Ecogenomics/CheckM
---

# checkm-genome

## Overview
CheckM is a specialized bioinformatic toolset designed to determine the quality of microbial genomes. It functions by identifying sets of marker genes that are typically ubiquitous and occur in single copies within specific phylogenetic lineages. By checking for the presence, absence, or duplication of these markers, CheckM provides robust estimates of genome completeness and contamination. This is particularly critical in metagenomics for validating the quality of bins before downstream functional analysis.

## Common CLI Patterns

### The Standard Workflow (lineage_wf)
The most frequent use case is the `lineage_wf`, which automates the placement of bins in a reference tree to infer lineage-specific marker sets.

```bash
checkm lineage_wf <bin_folder> <output_folder> -x <extension> -t <threads>
```
*   `<bin_folder>`: Directory containing your genome bins (FASTA format).
*   `-x`: Specify the file extension of your bins (e.g., `fasta`, `fna`, `fa`).
*   `-t`: Number of CPU threads to use.

### Taxonomic-Specific Workflow
If the taxonomy of the bins is already known, you can use a specific marker set for higher sensitivity.

```bash
# List available taxonomic marker sets
checkm taxon_list

# Run workflow for a specific rank and taxon (e.g., Genus Pseudomonas)
checkm taxonomy_wf genus Pseudomonas <bin_folder> <output_folder>
```

### Quality Assessment of Existing Results
If you have already run the `analyze` command and want to re-run the statistics (e.g., to change the output format), use `qa`.

```bash
checkm qa <lineage_file> <output_folder> --tab_table -f <output_file.tsv>
```

### Finding Ribosomal RNA
To identify 16S/18S (SSU) rRNAs within your bins:

```bash
checkm ssu_finder <input_fasta> <bin_folder> <output_folder>
```

## Expert Tips and Best Practices

*   **Data Path Configuration**: CheckM requires a large reference data package. Ensure the environment variable `CHECKM_DATA_PATH` is set to the directory containing the extracted data files to avoid "path not specified" errors.
*   **Memory Management**: CheckM is memory-intensive, especially during the `tree` and `lineage_wf` steps. Ensure at least 40GB+ of RAM is available for large datasets.
*   **CPR/Patescibacteria**: Standard marker sets often underestimate the quality of Candidate Phyla Radiation (CPR) genomes. Use the specific CPR marker set workflow for these organisms:
    `checkm analyze -p <cpr_marker_file> ...`
*   **CheckM v1 vs v2**: While this skill covers CheckM v1 (marker-gene based), CheckM v2 is available and uses machine learning models. v1 remains superior for exploring specific missing marker genes and systematic loss in related genomes.
*   **Handling Compressed Files**: Recent versions (v1.2.0+) support gzipped FASTA files directly. If using an older version, ensure bins are decompressed first.
*   **Output Interpretation**: 
    *   **Completeness >90% and Contamination <5%**: Generally considered a "High-quality" MAG.
    *   **Completeness >50% and Contamination <10%**: Generally considered a "Medium-quality" MAG.

## Reference documentation
- [CheckM Wiki Home](./references/github_com_Ecogenomics_CheckM_wiki.md)
- [CheckM GitHub Overview](./references/github_com_Ecogenomics_CheckM.md)
- [Bioconda CheckM Package](./references/anaconda_org_channels_bioconda_packages_checkm-genome_overview.md)
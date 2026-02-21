---
name: paragone
description: ParaGone is a specialized bioinformatics pipeline designed for "paralogy resolution"—the process of inferring orthologs from gene families containing multiple paralogous copies.
homepage: https://github.com/chrisjackson-pellicle/ParaGone
---

# paragone

## Overview

ParaGone is a specialized bioinformatics pipeline designed for "paralogy resolution"—the process of inferring orthologs from gene families containing multiple paralogous copies. It is particularly effective for target capture datasets (like Angiosperms353) and integrates seamlessly with outputs from HybPiper. By applying specific tree-parsing algorithms to gene trees, ParaGone extracts orthologous sequences into aligned fasta files ready for downstream phylogenetic analysis.

## Installation and Setup

The most reliable way to install ParaGone and its numerous dependencies (MAFFT, IQTREE, FastTree, TreeShrink, etc.) is via Conda:

```bash
conda create -n paragone bioconda::paragone
conda activate paragone
```

## Core CLI Usage

ParaGone can be executed as a single command for the entire pipeline or through discrete stages.

### Running the Full Pipeline
The `full_pipeline` command handles everything from initial alignment to final ortholog group extraction.

```bash
paragone full_pipeline --paralog_folder ./my_genes --internal_outgroup TAXON_ID
```

### Handling Outgroups
ParaGone requires outgroups to root trees and resolve paralogy. You must provide at least one of the following:

1.  **Internal Outgroups**: Designate specific taxa already present in your paralog fasta files.
    ```bash
    --internal_outgroup TaxonA --internal_outgroup TaxonB
    ```
2.  **External Outgroups**: Provide a separate fasta file containing outgroup sequences.
    ```bash
    --external_outgroups_file outgroups.fasta
    ```
    *Note: Fasta headers in the external file must match the gene identifiers used in your paralog files (e.g., `>TaxonName-GeneID`).*

### Key Parameters
- `--keep_intermediate_files`: Prevents the pipeline from deleting the 20+ intermediate folders. Highly recommended for first-time runs or debugging.
- `--external_outgroup <taxon_id>`: If using an external file, use this to limit analysis to specific taxa within that file.
- `--cleaning_cutoff`: Adjusts the stringency of sequence cleaning (TAPER/TreeShrink).

## Understanding Output

The pipeline generates numbered directories. If you are looking for the final, usable alignments, focus on these folders:

- **23_MO_final_alignments**: Monophyletic Outgroup method.
- **24_MI_final_alignments**: Map Ingroup method.
- **25_RT_final_alignments**: Rooted Tree method.
- **26-28**: Trimmed versions of the above (using Trimal).

## Expert Tips

- **HybPiper Compatibility**: ParaGone expects HybPiper's naming convention where the primary contig ends in `.main` and paralogs end in `.0`, `.1`, etc.
- **Resource Management**: ParaGone invokes heavy-duty aligners and tree builders (IQTREE). Ensure your environment has sufficient threads and memory for multi-gene processing.
- **Python Version**: If installing manually, ParaGone requires Python 3.6–3.9.16 due to specific compatibility requirements with TreeShrink.
- **TAPER Integration**: As of version 1.1.0, ParaGone uses TAPER for sequence correction. Ensure `correction_multi.jl` is in your system PATH if not using the Conda environment.

## Reference documentation
- [ParaGone Main Repository](./references/github_com_chrisjackson-pellicle_ParaGone.md)
- [ParaGone Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_paragone_overview.md)
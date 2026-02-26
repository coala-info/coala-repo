---
name: plant_tribes_gene_family_aligner
description: This tool generates multiple sequence alignments for gene families using algorithms like MAFFT or PASTA to prepare sequences for evolutionary analysis. Use when user asks to align gene family sequences, perform multiple sequence alignment on orthogroups, or prepare sequences for phylogenetic tree construction.
homepage: https://github.com/dePamphilis/PlantTribes
---


# plant_tribes_gene_family_aligner

## Overview
The `plant_tribes_gene_family_aligner` is a specialized tool within the PlantTribes suite used to generate high-quality multiple sequence alignments for gene families. It takes protein or nucleotide sequences organized into orthogroups and applies robust alignment algorithms to prepare them for evolutionary studies, such as phylogeny construction or substitution rate estimation. This tool is typically used after gene families have been classified and integrated, serving as the bridge between raw sequence clustering and phylogenetic tree inference.

## Command Line Usage

The primary executable for this pipeline is `GeneFamilyAligner`.

### Basic Execution
To run a standard alignment using MAFFT on a directory of integrated gene families:
```bash
GeneFamilyAligner --orthogroup_faa integratedGeneFamilies_dir --alignment_method mafft
```

### Core Arguments
- `--orthogroup_faa`: Path to the directory containing the FASTA files of the orthogroups (usually the output from `GeneFamilyIntegrator`).
- `--alignment_method`: Specifies the alignment algorithm. Supported options:
  - `mafft`: Recommended for most standard datasets due to its speed and accuracy.
  - `pasta`: Preferred for very large datasets or sequences with high divergence.
- `--num_threads`: (Optional) Specify the number of processors to use for parallel processing of orthogroups.

## Best Practices and Expert Tips

### Workflow Integration
- **Upstream Dependency**: This tool expects the input directory to be structured as produced by `GeneFamilyIntegrator`. Ensure your orthogroups are properly formatted and integrated before running the aligner.
- **Downstream Compatibility**: The output of this tool (typically found in `geneFamilyAlignments_dir/orthogroups_aln`) is the required input for the `GeneFamilyPhylogenyBuilder` pipeline.

### Method Selection
- **MAFFT**: Use MAFFT for the majority of comparative genomics tasks. It is the default choice for the PlantTribes pipeline and offers a good balance of performance and biological accuracy.
- **PASTA**: If you are dealing with thousands of sequences per orthogroup or sequences with significant length variation, PASTA (Practical Alignments using Saté and Trimal) is more robust as it utilizes a divide-and-conquer approach.

### Environment Setup
- **Dependency Check**: Ensure that `MAFFT`, `PASTA`, and `trimAl` are installed and available in your system's `$PATH`. If using the Bioconda installation, these are typically handled within the environment.
- **Scaffold Data**: While the aligner itself processes your specific sequences, ensure the PlantTribes scaffold datasets (e.g., 22Gv1.1) used in previous steps are consistent with your project goals.

### Troubleshooting
- **Empty Alignments**: If the tool fails to produce alignments, check the input FASTA files for non-standard amino acid characters or extremely short sequences that might be discarded by `trimAl` during the cleaning phase of the alignment.
- **Resource Allocation**: Multiple sequence alignment is computationally intensive. When processing hundreds of orthogroups, always utilize the `--num_threads` option to significantly reduce wall-clock time.

## Reference documentation
- [PlantTribes GitHub Repository](./references/github_com_dePamphilis_PlantTribes.md)
- [PlantTribes Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_plant_tribes_gene_family_aligner_overview.md)
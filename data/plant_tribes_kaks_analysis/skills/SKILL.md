---
name: plant_tribes_kaks_analysis
description: The `KaKsAnalysis` pipeline is a specialized component of the PlantTribes suite designed for comparative plant genomics.
homepage: https://github.com/dePamphilis/PlantTribes
---

# plant_tribes_kaks_analysis

## Overview

The `KaKsAnalysis` pipeline is a specialized component of the PlantTribes suite designed for comparative plant genomics. It automates the complex workflow of calculating pairwise substitution rates between gene sequences. The tool integrates several bioinformatics utilities—including BLAST, MAFFT, and PAML—to generate codon-aware alignments and estimate Ka/Ks ratios. It is particularly useful for researchers looking to identify whole-genome duplication (WGD) signatures or analyze the selective constraints acting on specific gene families across different plant lineages.

## Command Line Usage

The primary executable is `KaKsAnalysis`. Depending on your installation (Conda, Docker, or Manual), you may call it directly or via the full path `PlantTribes/pipelines/KaKsAnalysis`.

### Basic Paralogous Analysis
To estimate substitution rates for paralogs within a single species:
```bash
KaKsAnalysis --coding_sequences species_cds.fasta --protein_sequences species_proteins.fasta --comparison paralogous
```

### Basic Orthologous Analysis
To estimate substitution rates between orthologs of different species:
```bash
KaKsAnalysis --coding_sequences species1_cds.fasta --protein_sequences species1_proteins.fasta --ortholog_coding_sequences species2_cds.fasta --ortholog_protein_sequences species2_proteins.fasta --comparison orthologous
```

### Key Arguments
- `--coding_sequences`: Path to the FASTA file containing nucleotide coding sequences.
- `--protein_sequences`: Path to the FASTA file containing corresponding amino acid sequences.
- `--comparison`: Type of analysis to perform (`paralogous` or `orthologous`).
- `--crb_blast`: (Optional) Use Conditional Reciprocal Best BLAST for ortholog detection, which is more sensitive for divergent sequences.
- `--num_threads`: Specify the number of CPU cores to use for parallel processing.

## Expert Tips and Best Practices

- **Sequence ID Consistency**: Ensure that the headers in your coding sequence (CDS) FASTA file exactly match the headers in your protein FASTA file. The pipeline relies on these identifiers to map codons to amino acids during the alignment process.
- **Handling High-Frequency Amino Acids**: Be aware of a known issue where sequences with exceptionally high concentrations of Alanine (A), Threonine (T), Glycine (G), or Cysteine (C) can cause the pipeline to crash during the PAML/EMMIX phase. If a crash occurs, inspect the sequences for low-complexity regions.
- **Mixture Modeling**: The tool uses EMMIX for mixture model analysis of Ks distributions. This is highly effective for identifying peaks that correspond to ancient polyploidy events. Ensure your dataset is large enough (sufficient gene pairs) for the statistical mixture model to converge.
- **Dependency Environment**: If not using the Bioconda package, ensure that `codeml` (from PAML) and `emmix` are in your system `$PATH`. The pipeline acts as a wrapper and will fail silently or throw errors if these underlying binaries are missing.
- **Cleaning Data**: Before running the analysis, it is recommended to remove very short sequences or those with internal stop codons, as these can lead to unreliable Ka/Ks estimates or pipeline interruptions.

## Reference documentation
- [PlantTribes Overview](./references/github_com_dePamphilis_PlantTribes.md)
- [Known Issues and Bug Reports](./references/github_com_dePamphilis_PlantTribes_issues.md)
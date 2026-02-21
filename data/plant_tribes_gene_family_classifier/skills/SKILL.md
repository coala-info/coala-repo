---
name: plant_tribes_gene_family_classifier
description: The `GeneFamilyClassifier` is a specialized pipeline within the PlantTribes2 suite designed to categorize protein sequences into objective classifications.
homepage: https://github.com/dePamphilis/PlantTribes
---

# plant_tribes_gene_family_classifier

## Overview
The `GeneFamilyClassifier` is a specialized pipeline within the PlantTribes2 suite designed to categorize protein sequences into objective classifications. By leveraging curated scaffold datasets representing diverse plant genomes, the tool allows for the consistent assignment of new or uncharacterized sequences to known orthologous groups. This classification is a prerequisite for building gene family alignments and phylogenies within the PlantTribes workflow.

## Command Line Usage

The primary executable is `GeneFamilyClassifier`. Ensure that the required scaffold datasets are downloaded and decompressed in the `data` subdirectory of your PlantTribes installation before running.

### Basic Classification
To classify a set of protein sequences using the OrthoMCL clustering method and BLASTP:
```bash
GeneFamilyClassifier --proteins proteins.fasta --scaffold 22Gv1.1 --method orthomcl --classifier blastp
```

### Core Arguments
- `--proteins`: Path to the input FASTA file containing protein sequences.
- `--scaffold`: The identifier for the pre-computed scaffold dataset (e.g., `22Gv1.1`, `12Gv1.0`).
- `--method`: The clustering algorithm used to build the scaffold (typically `orthomcl` or `orthofinder`).
- `--classifier`: The search tool for classification, either `blastp` (sequence-based) or `hmmscan` (profile-based).

## Expert Tips and Best Practices

### Scaffold Management
- **Data Location**: The tool expects scaffold data in the `data/` directory relative to the installation path. If you are using a containerized version (Docker/Singularity), ensure this directory is correctly bound to the container.
- **Checksum Verification**: Always verify the integrity of downloaded scaffold archives using `md5sum` before decompression to prevent classification errors caused by corrupted reference data.

### Classifier Selection
- **BLASTP**: Best for general-purpose classification where sequence similarity is high. It is generally faster for smaller datasets.
- **HMMSCAN**: Recommended when dealing with more divergent sequences or when you want to leverage the sensitivity of Hidden Markov Models. Note that this requires the HMM profiles to be present in the scaffold data.

### Workflow Integration
- **Upstream**: If starting with transcript data, use the `AssemblyPostProcessor` first to generate the putative coding sequences and amino acid translations required by the classifier.
- **Downstream**: The output of this tool (typically found in the `geneFamilyClassification_dir/orthogroups_fasta` directory) serves as the direct input for `GeneFamilyIntegrator` or `PhylogenomicsAnalysis`.

### Performance
- Classification is computationally intensive. When running on large datasets, ensure that NCBI BLAST+ and HMMER are properly configured in your environment's `$PATH` to allow the pipeline to call these dependencies efficiently.

## Reference documentation
- [PlantTribes GitHub Repository](./references/github_com_dePamphilis_PlantTribes.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_plant_tribes_gene_family_classifier_overview.md)
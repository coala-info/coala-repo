---
name: plant_tribes_gene_family_integrator
description: This tool integrates classified protein sequences into orthogroup gene families based on specific scaffold datasets and clustering methods. Use when user asks to integrate classified orthogroups, organize gene families for downstream alignment, or prepare protein sequences for phylogenetic analysis.
homepage: https://github.com/dePamphilis/PlantTribes
---


# plant_tribes_gene_family_integrator

## Overview
The GeneFamilyIntegrator is a core component of the PlantTribes comparative genomics framework. It serves as a bridge between the initial classification of protein sequences and the subsequent alignment and phylogeny steps. Its primary function is to take the raw orthogroup FASTA files generated during classification and organize them based on the specific scaffold dataset and clustering method used, ensuring that the gene families are properly integrated and ready for tools like GeneFamilyAligner.

## CLI Usage Patterns

### Basic Integration
To integrate classified orthogroups, provide the path to the FASTA files, the scaffold version, and the clustering method:

```bash
GeneFamilyIntegrator --orthogroup_faa geneFamilyClassification_dir/orthogroups_fasta --scaffold 22Gv1.1 --method orthomcl
```

### Common Arguments
- `--orthogroup_faa`: Path to the directory containing the orthogroup FASTA files produced by the GeneFamilyClassifier.
- `--scaffold`: The specific PlantTribes scaffold dataset used for classification (e.g., `22Gv1.1`, `12Gv1.0`).
- `--method`: The clustering algorithm used to define the orthogroups (typically `orthomcl` or `orthofinder`).
- `--num_threads`: Specify the number of processors to use for parallel processing if supported by the environment.

## Best Practices and Expert Tips

### Workflow Continuity
- **Parameter Matching**: Always ensure that the `--scaffold` and `--method` arguments exactly match those used in the preceding `GeneFamilyClassifier` step. Mismatched parameters will lead to integration errors or empty outputs.
- **Input Validation**: Before running the integrator, verify that the `orthogroups_fasta` directory contains valid `.faa` files. If the classification step failed or produced no results, the integrator will have no data to process.

### Output Management
- **Downstream Compatibility**: The output of this tool (typically an `integratedGeneFamilies` directory) is the required input for `GeneFamilyAligner`. Keep the directory structure intact to avoid pathing issues in subsequent pipeline stages.
- **Resource Efficiency**: Unlike other PlantTribes modules, GeneFamilyIntegrator has no external dependencies (like BLAST or HMMER), making it a lightweight process. However, ensure you have sufficient disk space as it creates copies of sequence data organized by orthogroup.

### Troubleshooting
- **Pathing**: If running from a manual installation, ensure the `pipelines/` directory is in your `$PATH` or call the script using its full path.
- **Scaffold Data**: Ensure the scaffold data used is correctly installed in the PlantTribes `data` subdirectory, as the integrator may need to reference scaffold metadata during the integration process.

## Reference documentation
- [PlantTribes Overview](./references/github_com_dePamphilis_PlantTribes.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_plant_tribes_gene_family_integrator_overview.md)
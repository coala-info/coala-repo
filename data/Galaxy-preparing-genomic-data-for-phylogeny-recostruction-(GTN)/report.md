# preparing genomic data for phylogeny recostruction (GTN) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://training.galaxyproject.org
- **Package**: https://workflowhub.eu/workflows/1656
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1656/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 284
- **Last updated**: 2025-06-02
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `main-workflow.ga` (Main Workflow)
- **Project**: Galaxy Training Network
- **Views**: 2150
- **Discussion / source**: https://matrix.to/#/%23galaxyproject_admin:gitter.im

## Description

This workflow begins from a set of genome assemblies of different samples, strains, species. The genome is first annotated with Funnanotate. Predicted proteins are furtner annotated with Busco. Next, 'ProteinOrtho' finds orthologs across the samples and makes orthogroups. Orthogroups where all samples are represented are extracted. Orthologs in each orthogroup are aligned with ClustalW. The alignments are cleaned with ClipKIT and the concatenation matrix is built using PhyKit. This can be used for phylogeny reconstruction.

## Associated Tutorial

This workflows is part of the tutorial [Preparing genomic data for phylogeny reconstruction](https://training.galaxyproject.org/training-material/topics/ecology/tutorials/phylogeny-data-prep/tutorial.html), available in the [GTN](https://training.galaxyproject.org)





## Thanks to...

**Workflow Author(s)**: Miguel Roncoroni

**Tutorial Author(s)**: [Miguel Roncoroni](https://training.galaxyproject.org/training-material/hall-of-fame/roncoronimiguel/), [Brigida Gallone](https://training.galaxyproject.org/training-material/hall-of-fame/brigidagallone/)

[![gtn star logo followed by the word workflows](https://training.galaxyproject.org/training-material/assets/branding/gtn-workflows.png)](https://training.galaxyproject.org/training-material/)

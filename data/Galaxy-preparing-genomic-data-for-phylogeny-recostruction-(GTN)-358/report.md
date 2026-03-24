# preparing genomic data for phylogeny recostruction (GTN) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.be/workflows/list_published
- **Package**: https://workflowhub.eu/workflows/358
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/358/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 692
- **Last updated**: 2023-02-13
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-preparing_genomic_data_for_phylogeny_recostruction_(GTN)(1).ga` (Main Workflow)
- **Project**: usegalaxy.be workflows
- **Views**: 6955

## Description

This workflow begins from a set of genome assemblies of different samples, strains, species. The genome is first annotated with Funnanotate. Predicted proteins are furtner annotated with Busco. Next, 'ProteinOrtho' finds orthologs across the samples and makes orthogroups. Orthogroups where all samples are represented are extracted. Orthologs in each orthogroup are aligned with ClustalW. Test dataset: https://zenodo.org/record/6610704#.Ypn3FzlBw5k

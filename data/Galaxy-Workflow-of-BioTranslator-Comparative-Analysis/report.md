# Workflow of BioTranslator Comparative Analysis CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://workflowhub.eu/workflows/193
- **Package**: https://workflowhub.eu/workflows/193
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/193/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 842
- **Last updated**: 2023-01-16
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Workflow_of_BioTranslator_Comparative_Analysis.ga` (Main Workflow)
- **Project**: CO2MICS Lab
- **Views**: 6831

## Description

This workflow is based on the idea of comparing different gene sets through their semantic interpretation. In many cases, the user studies a specific phenotype (e.g. disease) by analyzing lists of genes resulting from different samples or patients. Their pathway analysis could result in different semantic networks, revealing mechanistic and phenotypic divergence between these gene sets. The workflow of BioTranslator Comparative Analysis compares quantitatively the outputs of pathway analysis, based on the topology of the underlying ontological graph, in order to derive a semantic similarity value for each pair of the initial gene sets. The workflow is available in a Galaxy application and can be used for 14 species. The algorithm accepts as input a batch of gene sets, such as BioTranslator, for the same organism. It performs pathway analysis according to the user-selected ontology and then it compares the derived semantic networks and extracts a matrix with their distances, as well as a respective heatmap.

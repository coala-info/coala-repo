---
name: allele-specific-expression-network-clustering-analysis-for-h
description: "This CWL workflow processes transcriptomic data to perform allele-specific expression-network clustering for Huntington's Disease using differential expression analysis, weighted gene co-expression networks, and gene set enrichment. Use this skill when you need to identify co-regulated gene modules and biological pathways that characterize the molecular landscape and regulatory mechanisms of Huntington's Disease."
homepage: https://workflowhub.eu/workflows/1253
---
# Allele-specific expression-network clustering analysis for Huntington's Disease

## Overview

This [Common Workflow Language (CWL) workflow](https://workflowhub.eu/workflows/1253) performs allele-specific expression-network clustering analysis specifically tailored for Huntington's Disease research. It provides a standardized pipeline for identifying gene modules and regulatory patterns by integrating transcriptomic data into co-expression networks.

The process begins with data pre-processing and quality control to ensure high-fidelity inputs for differential gene expression analysis. Following the identification of differentially expressed genes, the workflow utilizes Weighted Gene Co-expression Network Analysis (WGCNA) to cluster genes into functional modules based on their expression profiles.

The final stages focus on functional characterization and biological interpretation. The workflow executes gene set enrichment analysis (GSEA), calculates module eigengene correlation networks, and performs module enrichment analysis to visualize the biological significance of the identified clusters within the context of Huntington's Disease pathology.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| raw_counts | Microarray data | File | Illumina beadchip raw gene expression data -GSE77627 |
| bgxfile | Illumina beadchip array file | File | Illumina HumanHT-12 WG-DASL V4.0 R2 expression beadchip |
| clinical_data | Clinical data | File | Clinical phenotype data |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| pre_processing | Data pre-processing | Pre-processing input data |
| quality_control | Quality control | Quality control of input data |
| DEG | Differential gene expression analysis | Differential gene expression analysis using limma |
| wgcna | Weighted gene co-expression network analysis | Weighted gene co-expression network analysis for module identification |
| gsea_analysis | Gene set enrichment analysis and visualisation | Gene set enrichment analysis and visualisation in Cytoscape |
| ME_network | Module eigenegene correlation network | Module eigenegene correlation network and visualisation in Cytoscape |
| module_ora | Module enrichment analysis | Module enrichment analysis with significantly correlating modules |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| gsea_node_table | GSEA node table | File | Node table for GSEA network result visualisation in Cytoscape |
| gsea_edge_table | GSEA edge table | File | Edge table for GSEA network result visualisation in Cytoscape |
| net_data_table | Network data table | File | GSEA network data table |
| add_net_data_table | Additional network data table | File | GSEA network additional visualisation table |
| module_eigengene_net_nodetable | Module eigengene node data | File | Module eigenegene correlation network node table in Cytoscape |
| module_eigengene_net_edgetable | Module eigengene edge data | File | Module eigenegene correlation network edge table in Cytoscape |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1253
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata

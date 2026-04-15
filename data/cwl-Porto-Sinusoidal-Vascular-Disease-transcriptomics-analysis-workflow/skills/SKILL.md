---
name: porto-sinusoidal-vascular-disease-transcriptomics-analysis-w
description: This CWL workflow performs differential expression, weighted gene co-expression network analysis, and gene set enrichment on transcriptomics data to investigate the molecular basis of Porto-Sinusoidal Vascular Disease. Use this skill when you need to identify functional gene modules, characterize affected biological pathways, and uncover the regulatory mechanisms driving vascular liver disorders.
homepage: https://www.ejprarediseases.org/
metadata:
  docker_image: "N/A"
---

# porto-sinusoidal-vascular-disease-transcriptomics-analysis-w

## Overview

This [Common Workflow Language (CWL) workflow](https://workflowhub.eu/workflows/1040) provides a comprehensive pipeline for analyzing transcriptomics data, specifically tailored to investigate the molecular pathways involved in Porto-Sinusoidal Vascular Disease. It integrates standard differential expression techniques with advanced network analysis to identify key biological drivers of the condition.

The analytical process begins with data pre-processing and quality control, followed by differential gene expression (DGE) analysis. To capture higher-order biological relationships, the workflow performs Weighted Gene Co-expression Network Analysis (WGCNA) to identify clusters of highly correlated genes and evaluates their significance through module eigengene correlation networks.

The final stages focus on functional interpretation and visualization. The pipeline executes Gene Set Enrichment Analysis (GSEA) and module enrichment analysis to map identified gene sets to known biological pathways and molecular interactions. This structured approach allows researchers to move from raw transcriptomic counts to a detailed understanding of the disease's regulatory landscape.

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

- WorkflowHub: https://workflowhub.eu/workflows/1040
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
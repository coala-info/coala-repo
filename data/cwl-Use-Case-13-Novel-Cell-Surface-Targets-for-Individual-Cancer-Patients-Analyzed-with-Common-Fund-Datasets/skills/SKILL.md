---
name: use-case-13-novel-cell-surface-targets-for-individual-cancer
description: This CWL workflow identifies tumor-specific therapeutic targets from patient gene expression matrices by screening against GTEx healthy tissue data and integrating functional insights from LINCS, IDG, MetGENE, and GlyGen. Use this skill when you need to discover novel cell surface targets for precision oncology and characterize the metabolic, regulatory, and druggability profiles of candidate proteins in individual cancer cases.
homepage: https://playbook-workflow-builder.cloud/
metadata:
  docker_image: "N/A"
---

# use-case-13-novel-cell-surface-targets-for-individual-cancer

## Overview

This [CWL workflow](https://workflowhub.eu/workflows/814) identifies potential therapeutic targets by analyzing gene expression matrices from pediatric tumor data, such as those from the KidsFirst program. It utilizes TargetRanger to cross-reference tumor expression against healthy tissue data from the [GTEx project](https://gtexportal.org/home/), prioritizing genes that are highly expressed in tumors but minimally present in normal tissues.

Once a candidate gene is selected, the workflow leverages the [SigCom LINCS API](https://signature-commons.cloud/lincs/) to identify small molecule perturbagens and CRISPR knockouts that down-regulate the target. These results are further refined using the [IDG list of understudied proteins](https://druggablegenome.net/AboutIDGProteinList) to highlight novel or under-researched therapeutic opportunities.

Finally, the workflow integrates multi-omics context by querying [MetGENE](https://sc-cfdewebdev.sdsc.edu/MetGENE/metGene.php) for associated metabolites and pathways from the [Metabolomics Workbench](https://www.metabolomicsworkbench.org/). It also retrieves regulatory information via the [Linked Data Hub](https://ldh.genome.network/cfde/ldh/) and post-translational modification data from [GlyGen](https://www.glygen.org/), providing a comprehensive biological profile of the identified cancer target.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step-1-data | Input File | File | Upload a Data File |
| step-4-data | Select One Gene | File | Select one Gene |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step-1 | Input File | Upload a Data File |
| step-2 | Resolve a Gene Count Matrix from a File | Ensure a file contains a gene count matrix, load it into a standard format |
| step-3 | Screen for Targets against GTEx | Identify significantly overexpressed genes when compared to normal tissue in GTEx |
| step-4 | Select One Gene | Select one Gene |
| step-5 | LINCS L1000 Reverse Search | Identify RNA-seq-like LINCS L1000 Signatures which reverse the expression of the gene. |
| step-6 | Extract Down Regulating Perturbagens | Identify RNA-seq-like LINCS L1000 Chemical Perturbagen Signatures which reverse the expression of the gene. |
| step-7 | Extract Down Regulating CRISPR KOs | Identify RNA-seq-like LINCS L1000 CRISPR KO Signatures which reverse the expression of the gene. |
| step-8 | Filter genes by Understudied Proteins | Based on IDG understudied proteins list |
| step-9 | MetGENE Search | Identify gene-centric information from Metabolomics. |
| step-10 | MetGENE Metabolites | Extract Metabolomics metabolites for the gene from MetGENE |
| step-11 | MetGENE Reactions | Extract Metabolomics reactions for the gene from MetGENE |
| step-12 | Resolve Regulatory Elements from LDH | Resolve regulatory elements from gene with Linked Data Hub |
| step-13 | Search GlyGen for Protein Products | Find protein product records in GlyGen for the gene |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step-1-output | File URL | File | URL to a File |
| step-2-output | Gene Count Matrix | File | A gene count matrix file |
| step-3-output | Scored Genes | File | ZScores of Genes |
| step-4-output | Gene | File | Gene Term |
| step-5-output | LINCS L1000 Reverse Search Dashboard | File | A dashboard for performing L1000 Reverse Search queries for a given gene |
| step-6-output | Scored Drugs | File | ZScores of Drugs |
| step-7-output | Scored Genes | File | ZScores of Genes |
| step-8-output | Scored Genes | File | ZScores of Genes |
| step-9-output | MetGENE Summary | File | A dashboard for reviewing gene-centric information for a given gene from metabolomics |
| step-10-output | MetGENE metabolite table | File | MetGENE metabolite table |
| step-11-output | MetGENE Reaction Table | File | MetGENE Reaction Table |
| step-12-output | Regulatory Element Set | File | Set of Regulatory Elements |
| step-13-output | GlyGen Protein Products | File | Protein product records in GlyGen |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/814
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
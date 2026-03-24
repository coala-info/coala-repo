# Variant calling from matched tumor/normal sample pair (hg38 version) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.eu
- **Package**: https://workflowhub.eu/workflows/628
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/628/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 665
- **Last updated**: 2025-05-08
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: GPL-3.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Variant_calling_from_matched_tumor_normal_sample_pair_(hg38_version).ga` (Main Workflow)
- **Project**: usegalaxy-eu
- **Views**: 7380
- **Creators**: Wolfgang Maier

## Description

Call somatic, germline and LoH event variants from PE Illumina sequencing data obtained from matched pairs of tumor and normal tissue samples.

This workflow can be used with whole-genome and whole-exome sequencing data as input. For WES data, parts of the analysis can be restricted to the exome capture kits target regions by providing the optional "Regions of Interest" bed dataset.

The current version uses bwa-mem for read mapping and varscan somatic for variant calling and somatic status classification.

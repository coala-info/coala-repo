# Cancer variant annotation (hg38 VEP-based) with MAF export CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.eu
- **Package**: https://workflowhub.eu/workflows/629
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/629/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 715
- **Last updated**: 2025-05-08
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: GPL-3.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based)_with_MAF_export.ga` (Main Workflow)
- **Project**: usegalaxy-eu
- **Views**: 7431
- **Creators**: Wolfgang Maier

## Description

A variation of the Cancer variant annotation (hg38 VEP-based) workflow at https://doi.org/10.48546/workflowhub.workflow.607.1.

Like that other workflow it takes a list of tumor/normal sample pair variants in VCF format (see the other workflow for details about the expected format) and

1. annotates them using the ENSEMBL Variant Effect Predictor and custom annotation data
2. turns the annotated VCF into a MAF file for import into cBioPortal
3. generates human-readable variant- and gene-centric reports

In addition, this worklfow exports the resulting MAF dataset to a WebDAV-enabled remote folder for subsequent import into cBioPortal.
WebDAV access details can be configured in the Galaxy user preferences.

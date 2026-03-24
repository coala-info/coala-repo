# Cancer variant annotation (hg38 VEP-based) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.eu
- **Package**: https://workflowhub.eu/workflows/607
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/607/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 701
- **Last updated**: 2025-05-08
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Cancer_variant_annotation_(hg38_VEP-based).ga` (Main Workflow)
- **Project**: usegalaxy-eu
- **Views**: 7561
- **Creators**: Wolfgang Maier

## Description

This Galaxy workflow takes a list of tumor/normal sample pair variants in VCF format and
1. annotates them using the ENSEMBL Variant Effect Predictor and custom annotation data
2. turns the annotated VCF into a MAF file for import into cBioPortal
3. generates human-readable variant- and gene-centric reports

The input VCF is expected to encode somatic status, somatic p-value and germline p-value of each variant in varscan somatic format, i.e., via SS, SPV and GPV INFO keys, respectively.

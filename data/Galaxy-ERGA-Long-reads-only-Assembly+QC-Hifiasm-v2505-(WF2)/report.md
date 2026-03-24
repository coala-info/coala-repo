# ERGA Long reads-only Assembly+QC Hifiasm v2505 (WF2) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.erga-biodiversity.eu/
- **Package**: https://workflowhub.eu/workflows/1162
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1162/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 692
- **Last updated**: 2025-09-09
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ERGA_Long_reads-only_Assembly_QC_Hifiasm_v2505_(WF2).ga` (Main Workflow)
- **Project**: ERGA Assembly
- **Views**: 5730
- **Creators**: Diego De Panis
- **Discussion / source**: https://github.com/ERGA-consortium/pipelines/discussions

## Description

The workflow takes a long reads collection (HiFi, or ONT also possible now), and max coverage depth (calculated from WF1) to run Hifiasm in solo mode. It produces a Pri/Alt assembly, Bandage plots, and runs all the QC analysis (gfastats, BUSCO, and Merqury).

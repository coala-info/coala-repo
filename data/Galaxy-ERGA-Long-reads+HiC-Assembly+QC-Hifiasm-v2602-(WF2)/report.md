# ERGA Long reads+HiC Assembly+QC Hifiasm v2602 (WF2) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.erga-biodiversity.eu/
- **Package**: https://workflowhub.eu/workflows/605
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/605/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 715
- **Last updated**: 2026-02-11
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ERGA_Long_reads_HiC_Assembly_QC_Hifiasm_v2602_(WF2).ga` (Main Workflow)
- **Project**: ERGA Assembly
- **Views**: 8185
- **Creators**: Diego De Panis
- **Discussion / source**: https://github.com/ERGA-consortium/pipelines/discussions

## Description

The workflow takes a trimmed long reads collection, and Forward/Reverse HiC reads to run Hifiasm in HiC phasing mode. It produces both Pri/Alt and Hap1/Hap2 assemblies, and runs all the QC analysis (gfastats, BUSCO, and Merqury). The default Hifiasm purge level is aggressive (l3).

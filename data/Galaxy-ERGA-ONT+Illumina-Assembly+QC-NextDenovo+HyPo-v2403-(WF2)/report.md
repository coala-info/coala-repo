# ERGA ONT+Illumina Assembly+QC NextDenovo+HyPo v2403 (WF2) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.erga-biodiversity.eu/
- **Package**: https://workflowhub.eu/workflows/789
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/789/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 684
- **Last updated**: 2024-03-11
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ERGA_ONT_Illumina_Assembly_QC_NextDenovo_HyPo_v2403_(WF2).ga` (Main Workflow)
- **Project**: ERGA Assembly
- **Views**: 5591
- **Creators**: Diego De Panis
- **Discussion / source**: https://github.com/ERGA-consortium/pipelines/discussions

## Description

The workflow takes raw ONT reads and trimmed Illumina WGS paired reads collections, the ONT raw stats table (calculated from WF1) and the estimated genome size (calculated from WF1) to run NextDenovo and subsequently polish the assembly with HyPo. It produces collapsed assemblies (unpolished and polished) and runs all the QC analyses (gfastats, BUSCO, and Merqury).

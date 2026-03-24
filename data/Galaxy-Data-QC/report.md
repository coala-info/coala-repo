# Data QC CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.org.au/
- **Package**: https://workflowhub.eu/workflows/222
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/222/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 858
- **Last updated**: 2023-01-30
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Data_QC.ga` (Main Workflow)
- **Project**: Galaxy Australia
- **Views**: 8260
- **Creators**: Anna Syme

## Description

Data QC step, can run alone or as part of a combined workflow for large genome assembly. 

* What it does: Reports statistics from sequencing reads.
* Inputs: long reads (fastq.gz format), short reads (R1 and R2) (fastq.gz format).
* Outputs: For long reads: a nanoplot report (the HTML report summarizes all the information). For short reads: a MultiQC report.
* Tools used: Nanoplot, FastQC, MultiQC.
* Input parameters: None required.
* Workflow steps: Long reads are analysed by Nanoplot; Short reads (R1 and R2) are analysed by FastQC; the resulting reports are processed by MultiQC.
* Options: see the tool settings options at runtime and change as required. Alternative tool option: fastp

Infrastructure_deployment_metadata: Galaxy Australia (Galaxy)

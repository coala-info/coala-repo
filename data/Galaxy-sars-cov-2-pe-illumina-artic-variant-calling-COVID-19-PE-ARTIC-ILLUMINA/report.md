# sars-cov-2-pe-illumina-artic-variant-calling/COVID-19-PE-ARTIC-ILLUMINA CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/110
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/110/ro_crate?version=11
- **Conda**: N/A
- **Total Downloads**: 32.0K
- **Last updated**: 2026-03-14
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 11
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `pe-artic-variation.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 25201
- **Creators**: Wolfgang Maier

## Description

COVID-19: variation analysis on ARTIC PE data
---------------------------------------------

The workflow for Illumina-sequenced ampliconic data builds on the RNASeq workflow
for paired-end data using the same steps for mapping and variant calling, but
adds extra logic for trimming amplicon primer sequences off reads with the ivar
package. In addition, this workflow uses ivar also to identify amplicons
affected by primer-binding site mutations and, if possible, excludes reads
derived from such "tainted" amplicons when calculating allele-frequencies
of other variants.

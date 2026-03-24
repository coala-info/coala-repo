# sars-cov-2-ont-artic-variant-calling/COVID-19-ARTIC-ONT CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/111
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/111/ro_crate?version=5
- **Conda**: N/A
- **Total Downloads**: 17.5K
- **Last updated**: 2025-12-12
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 5
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `ont-artic-variation.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 16549
- **Creators**: Wolfgang Maier

## Description

COVID-19: variation analysis on ARTIC ONT data
----------------------------------------------

This workflow for ONT-sequenced ARTIC data is modeled after the alignment/variant-calling steps of the [ARTIC pipeline](https://artic.readthedocs.io/en/latest/). It performs, essentially, the same steps as that pipeline’s minion command, i.e. read mapping with minimap2 and variant calling with medaka. Like the Illumina ARTIC workflow it uses ivar for primer trimming. Since ONT-sequenced reads have a much higher error rate than Illumina-sequenced reads and are therefor plagued more by false-positive variant calls, this workflow does make no attempt to handle amplicons affected by potential primer-binding site mutations.

# De novo CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://training.galaxyproject.org
- **Package**: https://workflowhub.eu/workflows/2038
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/2038/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 81
- **Last updated**: 2025-12-16
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-De_novo.ga` (Main Workflow)
- **Project**: Galaxy Training Network
- **Views**: 713
- **Creators**: Molène Mahé

## Description

Workflow for processing amplicon pool sequencing data without reference sequence.

This workflow allows you to reconstruct a sequence from an amplicon pool without a reference sequence. To run this workflow, you need the reads from the pool library you want to analyse in FASTQ format, separated into two files: forward and reverse. You will also need the primers used during sequencing. This workflow creates one or two contigs (depending on whether your primers were used once or twice) and a metadata file containing the length of the contigs, the number of reads mapped to them, and the average, minimum, and maximum coverage depth.

# Map-to-reference CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://training.galaxyproject.org
- **Package**: https://workflowhub.eu/workflows/2036
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/2036/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 90
- **Last updated**: 2025-12-15
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Map-to-reference.ga` (Main Workflow)
- **Project**: Galaxy Training Network
- **Views**: 726
- **Creators**: Molène Mahé

## Description

Workflow for processing amplicon pool sequencing data with reference.

This workflow allows you to reconstruct a sequence from an amplicon pool using a reference sequence. To run this workflow, you need the reads from the pool library you want to analyse in FASTQ format, separated into two files: forward and reverse. You will also need your reference sequence in FASTA format. This workflow creates a consensus sequence and a metadata file containing the length of the consensus sequence, the number of reads mapped to it, and the average, minimum, and maximum coverage depth. You can also retrieve a file containing unmapped reads.

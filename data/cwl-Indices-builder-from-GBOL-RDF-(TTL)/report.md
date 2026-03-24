# Indices builder from GBOL RDF (TTL) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://m-unlock.com
- **Package**: https://workflowhub.eu/workflows/75
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/75/ro_crate?version=1
- **Source repository (git):** https://gitlab.com/m-unlock/cwl
- **Conda**: N/A
- **Total Downloads**: 936
- **Last updated**: 2023-01-16
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC0-1.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `workflows/workflow_indexbuilder.cwl` (Main Workflow)
- **Project**: UNLOCK
- **Views**: 4467
- **Creators**: Bart Nijsse
- **Discussion / source**: https://gitlab.com/m-unlock/cwl/-/issues

## Description

Workflow to build different indices for different tools from a genome and transcriptome. 

This workflow expects an (annotated) genome in GBOL ttl format.

Steps:
  - SAPP: rdf2gtf (genome fasta)
  - SAPP: rdf2fasta (transcripts fasta)
  - STAR index (Optional for Eukaryotic origin)
  - bowtie2 index
  - kallisto index

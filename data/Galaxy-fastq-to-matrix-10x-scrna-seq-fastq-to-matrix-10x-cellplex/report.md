# fastq-to-matrix-10x/scrna-seq-fastq-to-matrix-10x-cellplex CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/694
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/694/ro_crate?version=9
- **Conda**: N/A
- **Total Downloads**: 31.8K
- **Last updated**: 2026-02-20
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 9
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `scrna-seq-fastq-to-matrix-10x-cellplex.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 10049
- **Creators**: Lucille Delisle, Mehmet Tekman, Hans-Rudolf Hotz, Daniel Blankenberg, Wendi Bacon

## Description

This workflow processes the CMO fastqs with CITE-seq-Count and include the translation step required for cellPlex processing. In parallel it processes the Gene Expresion fastqs with STARsolo, filter cells with DropletUtils and reformat all outputs to be easily used by the function 'Read10X' from Seurat.

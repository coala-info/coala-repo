# Nanopore Guppy Basecalling Assembly Workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://m-unlock.com
- **Package**: https://workflowhub.eu/workflows/253
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/253/ro_crate?version=1
- **Source repository (git):** https://git.wur.nl/unlock/cwl
- **Conda**: N/A
- **Total Downloads**: 914
- **Last updated**: 2023-01-16
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `cwl/workflows/workflow_nanopore.cwl` (Main Workflow)
- **Project**: UNLOCK
- **Views**: 6077
- **Creators**: Bart Nijsse, Jasper Koehorst, Germán Royval
- **Discussion / source**: https://gitlab.com/m-unlock/cwl/-/issues

## Description

### - deprecated - 

Workflow for sequencing with ONT Nanopore, from basecalling to assembly.
  - Guppy (basecalling of raw reads)
  - MinIONQC (quality check)
  - FASTQ merging from multi into one file
  - Kraken2 (taxonomic classification)
  - Krona (classification visualization)
  - Flye (de novo assembly)
  - Medaka (assembly polishing)
  - QUAST (assembly quality reports)

**All tool CWL files and other workflows can be found here:**<br>
  Tools: https://git.wur.nl/unlock/cwl/-/tree/master/cwl<br>
  Workflows: https://git.wur.nl/unlock/cwl/-/tree/master/cwl/workflows<br>

# Extract transcripts - TSI CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.biocommons.org.au/
- **Package**: https://workflowhub.eu/workflows/879
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/879/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 614
- **Last updated**: 2024-05-09
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: GPL-3.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Extract-transcripts-TSI.ga` (Main Workflow)
- **Project**: Australian BioCommons
- **Views**: 5352
- **Creators**: Luke Silver, Anna Syme

## Description

This is part of a series of workflows to annotate a genome, tagged with `TSI-annotation`. 
These workflows are based on command-line code by Luke Silver, converted into Galaxy Australia workflows. 

The workflows can be run in this order: 
* Repeat masking
* RNAseq QC and read trimming
* Find transcripts
* Combine transcripts
* Extract transcripts
* Convert formats
* Fgenesh annotation

****

About this workflow:

* Input: merged_transcriptomes.fasta. 
* Runs TransDecoder to produce longest_transcripts.fasta
* (Runs both the LongOrfs and Predict parts together. Default settings except Long Orfs options: -m =20)
* Runs Busco on output.

# Convert formats - TSI CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.biocommons.org.au/
- **Package**: https://workflowhub.eu/workflows/880
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/880/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 721
- **Last updated**: 2024-05-09
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: GPL-3.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Convert-formats-TSI.ga` (Main Workflow)
- **Project**: Australian BioCommons
- **Views**: 5547
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

* Inputs: transdecoder-peptides.fasta, transdecoder-nucleotides.fasta
* Runs many steps to convert outputs into the formats required for Fgenesh - .pro, .dat and .cdna

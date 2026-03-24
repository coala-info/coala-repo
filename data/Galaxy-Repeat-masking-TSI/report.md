# Repeat masking - TSI CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.biocommons.org.au/
- **Package**: https://workflowhub.eu/workflows/875
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/875/ro_crate?version=3
- **Conda**: N/A
- **Total Downloads**: 1.5K
- **Last updated**: 2024-06-20
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 3
- **License**: GPL-3.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Repeat_masking_-_TSI-updated.ga` (Main Workflow)
- **Project**: Australian BioCommons
- **Views**: 7268
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

Workflow information:
* Input = genome.fasta.
* Outputs = soft_masked_genome.fasta, hard_masked_genome.fasta, and table of repeats found. 
* Runs RepeatModeler with default settings, uses the output of this (repeat library) as input into RepeatMasker. 
* Runs RepeatMasker with default settings except for: Skip masking of simple tandem repeats and low complexity regions. (-nolow) : default set to yes.  Perform softmasking instead of hardmasking - set to yes. 
* Converts the soft-masked genome to hard-masked for for use in other tools if required. 
* Workflow report displays an edited table of repeats found. Note: a known bug is that sometimes the workflow report text resets to default text. To restore, look for an earlier workflow version with correct workflow report text, and copy and paste report text into current version.

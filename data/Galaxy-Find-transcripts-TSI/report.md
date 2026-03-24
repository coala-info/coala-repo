# Find transcripts - TSI CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.biocommons.org.au/
- **Package**: https://workflowhub.eu/workflows/877
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/877/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 600
- **Last updated**: 2024-05-09
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: GPL-3.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Find-transcripts-TSI.ga` (Main Workflow)
- **Project**: Australian BioCommons
- **Views**: 5524
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

* Run this workflow per tissue. 
* Inputs: masked_genome.fasta and the trimmed RNAseq reads (R1 and R2) from one type of tissue. 
* Index genome and align reads to genome with HISAT2, with default settings except for: Advanced options: spliced alignment options: specify options: Transcriptome assembly reporting: selected option: Report alignments tailored for transcript assemblers including StringTie (equivalent to -dta flag). 
* Runs samtools sort to sort bam by coordinate. 
* Runs StringTie to generate gtf from sorted bam. 
* Output: transcripts.gtf from a single tissue.

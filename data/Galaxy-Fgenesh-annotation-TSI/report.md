# Fgenesh annotation -TSI CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.biocommons.org.au/
- **Package**: https://workflowhub.eu/workflows/881
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/881/ro_crate?version=5
- **Conda**: N/A
- **Total Downloads**: 2.3K
- **Last updated**: 2024-11-17
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 5
- **License**: GPL-3.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Fgenesh_annotation_-TSI.ga` (Main Workflow)
- **Project**: Australian BioCommons
- **Views**: 8889
- **Creators**: Luke Silver

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


Inputs required: assembled-genome.fasta, hard-repeat-masked-genome.fasta, and (because this workflow maps known mRNA sequences) .cdna, .pro and .dat files. It is also required to select certain databases for Fgenesh-annotate and for Busco. 

This workflow splits the input genomes into single sequences (to decrease computation time), annotates using FgenesH++, and merges the output. 

Outputs: genome annotation in gff3 format, genome annotation stats, fasta files of mRNAs, cDNAs and proteins, Busco report of proteins. 

Note: The input sequences to the tools to extract mRNA and cDNA here are the assembly.fasta sequences (unmasked) but there may be a reason to prefer the masked version, we are unsure of when that may be the case. 

Note: If you want to use this workflow without an input of known mRNAs, you can save a copy of the workflow and edit the "Fgenesh annotate" tool with "no" at this option, you will then not need an input of .cdna .pro and .dat files. 

Changes made 13 Nov 2024: Added correct input files and connected them to the split steps. Added inputs for db selections in the annotation step. Added lineage input to Busco. Added genome annotation stats derived from gff3 output. Connected in assembly.fasta sequences to "get mRNA/cDNA" tools. Expanded this information text and clarified the need for .cdna .pro and .dat files as input.

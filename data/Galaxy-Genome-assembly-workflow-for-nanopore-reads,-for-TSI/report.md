# Genome assembly workflow for nanopore reads, for TSI CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.biocommons.org.au/
- **Package**: https://workflowhub.eu/workflows/1114
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1114/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 513
- **Last updated**: 2024-09-03
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: GPL-3.0-or-later
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Genome_assembly_workflow_for_nanopore_reads_for_TSI.ga` (Main Workflow)
- **Project**: Australian BioCommons
- **Views**: 4477
- **Creators**: Anna Syme

## Description

**Genome assembly workflow for nanopore reads, for TSI**

Input: 
* Nanopore reads (can be in format: fastq, fastq.gz, fastqsanger, or fastqsanger.gz) 

Optional settings to specify when the workflow is run:
* [1] how many input files to split the original input into (to speed up the workflow). default = 0. example: set to 2000 to split a 60 GB read file into 2000 files of ~ 30 MB. 
* [2] filtering: min average read quality score. default = 10
* [3] filtering: min read length. default = 200
* [4] trimming: trim this many nucleotides from start of read. default = 50
* [5] note: these are suggestions and will depend on the characteristics of your raw reads and downstream aims. If filtering and trimming settings are too stringent, there may be no reads remaining and workflow will fail. 

Workflow steps:
* [1] runs FastQC on raw reads
* [2] splits input reads file into separate files to speed up the next step of Porechop
* [3] trims nanopore adapters using Porechop
* [4] trims and filters nanopore reads by quality and length using Nanofilt
* [5] collapses back into a single read file, fastqsanger format
* [6] runs FastqQC on trimmed/filtered reads
* [7] assembles genome with Flye
* [8] calculates statistics on genome assembly contigs with Fasta Statistics
* [9] draws genome assembly graph with Bandage 

Main outputs:
* [1] FastQC report on raw reads, html
* [2] Adpater-chopped, trimmed, filtered reads in fastqsanger format
* [3] FastQC report on filtered reads, html
* [4] genome assembly contigs in fasta format (primary assembly)
* [5] genome assembly statistics
* [6] genome assembly graph in Bandage format 

Note: You may wish to plot raw reads first (e.g. using the tool NanoPlot), to get a better of idea of read lengths and quality, to decide on filtering/trimming settings.

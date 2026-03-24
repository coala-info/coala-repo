# Genome-assessment-post-assembly CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.biocommons.org.au/
- **Package**: https://workflowhub.eu/workflows/794
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/794/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 1.2K
- **Last updated**: 2024-08-06
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: GPL-3.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Genome_assessment_post_assembly.ga` (Main Workflow)
- **Project**: Australian BioCommons
- **Views**: 6295
- **Creators**: Gareth Price, Anna Syme

## Description

Post-genome assembly quality control workflow using Quast, BUSCO, Meryl, Merqury and Fasta Statistics. Updates November 2023.  Inputs: reads as fastqsanger.gz (not fastq.gz), and assembly.fasta. New default settings for BUSCO: lineage = eukaryota; for Quast: lineage = eukaryotes, genome = large. Reports assembly stats into a table called metrics.tsv, including selected metrics from Fasta Stats, and read coverage; reports BUSCO versions and dependencies; and displays these tables in the workflow report. Note: a known bug is that sometimes the workflow report text resets to default text. To restore, look for an earlier workflow version with correct workflow report text, and copy and paste report text into current version.

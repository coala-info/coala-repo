# Genome-assessment-post-assembly CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.org.au/
- **Package**: https://workflowhub.eu/workflows/403
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/403/ro_crate?version=9
- **Conda**: N/A
- **Total Downloads**: 3.1K
- **Last updated**: 2024-12-04
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 9
- **License**: GPL-3.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Genome_assessment_post_assembly.ga` (Main Workflow)
- **Project**: Galaxy Australia
- **Views**: 13527
- **Creators**: Kate Farquharson, Gareth Price, Simon Tang, Anna Syme

## Description

Post-genome assembly quality control workflow using Quast, BUSCO, Meryl, Merqury and Fasta Statistics, with updates November 2024.

Workflow inputs: reads as fastqsanger.gz (not fastq.gz), and primary assembly.fasta. (To change reads format: click on the pencil icon next to the file in the Galaxy history, then "Datatypes", then set "New type" as fastqsanger.gz). Note: the reads should be those that were used for the assembly (i.e., the filtered/cleaned reads), not the raw reads. 

What it does:
Computes read coverage. 
Runs Quast. 
Runs Fasta Statistics.
Runs Meryl and Merqury. 
Runs Busco. (New default settings for BUSCO: lineage = eukaryota; for Quast: lineage = eukaryotes, genome = large.)

Workflow outputs:
Reports assembly stats into a table called metrics.tsv, including selected metrics from Fasta Stats, and read coverage; reports BUSCO versions and dependencies; and displays these tables in the workflow report.

Note: a known bug is that sometimes the workflow report text resets to default text. 

To check and restore: open the workflow in Galaxy for editing.

Click on the "Edit Report" icon (top right, pencil icon). 

Copy and paste the following text into the workflow report, then exit this report page, then save the workflow.

# Workflow Execution Report

Workflow name: Genome assessment post assembly

## Genome assembly metrics

Selected statistics from the workflow outputs. Additional metrics are available in other outputs in the history.

```galaxy
history_dataset_display(output="Genome assembly metrics")
```
## Software

Busco version and dependencies:

```galaxy
history_dataset_display(output="Busco and dependencies version")
```
## Galaxy Australia

Thanks for using Galaxy! When you use Galaxy Australia to support your publication or project, please acknowledge its use with the following statement: "This work is supported by Galaxy Australia, a service provided by the Australian Biocommons and its partners. The service receives NCRIS funding through Bioplatforms Australia and the Australian Research Data Commons (https://doi.org/10.47486/PL105), as well as The University of Melbourne and Queensland Government RICF funding."

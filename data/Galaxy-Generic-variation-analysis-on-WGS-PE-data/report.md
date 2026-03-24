# Generic variation analysis on WGS PE data CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.eu
- **Package**: https://workflowhub.eu/workflows/353
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/353/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 1.4K
- **Last updated**: 2023-02-13
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Generic_variation_analysis_on_WGS_PE_data.ga` (Main Workflow)
- **Project**: usegalaxy-eu
- **Views**: 8096
- **Discussion / source**: https://help.galaxyproject.org

## Description

# Generic variant calling


A generic workflow for identification of variants in a haploid genome such as genomes of bacteria or viruses. It can be readily used on MonkeyPox. The workflow accepts two inputs:

- A genbank file with the reference genomes
- A collection of paired fastqsanger files

The workflow outputs a collection of VCF files for each sample (each fastq pair). These VCF files serve as input to the [Reporting workflow](https://workflowhub.eu/workflows/354). 

Workflow can be accessed directly on [usegalaxy.org](https://usegalaxy.org/u/aun1/w/generic-variation-analysis-on-wgs-pe-data)

The general idea of the workflow is:

![](https://i.imgur.com/rk40Y4t.png)

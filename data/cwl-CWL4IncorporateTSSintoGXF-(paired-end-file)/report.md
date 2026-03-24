# CWL4IncorporateTSSintoGXF (paired-end file) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://bonohu.hiroshima-u.ac.jp/index_en.html
- **Package**: https://workflowhub.eu/workflows/1343
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1343/ro_crate?version=1
- **Source repository (git):** https://github.com/Linlab-slu/TSSr
- **Conda**: N/A
- **Total Downloads**: 511
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Linlab-slu/TSSr
- **Stars**: N/A
- **Version**: 1
- **License**: MIT
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `workflow/cageseq_gtf_update_pe.cwl` (Main Workflow)
- **Project**: bonohulab
- **Views**: 1670
- **Creators**: Ryo Nozu, Sora Yonezawa

## Description

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/RyoNozu/CWL4IncorporateTSSintoGXF/main)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
[![Lab Website](https://img.shields.io/badge/Lab%20Website-bonohulab-informational?style=flat-square)](https://bonohu.hiroshima-u.ac.jp/)

&nbsp;

# CWL4IncorporateTSSintoGXF

This workflow determines TSS based on the analysis of CAGE-seq data and incorporates TSS information and 5'UTR information calculated based on TSS information into the gene annotation file (gff/gtf). The R package, [TSSr](https://github.com/Linlab-slu/TSSr), is used to determine TSS.  

## Requirements

- [cwltool](https://github.com/common-workflow-language/cwltool)  

    Install using pip  
    ```
    pip  install cwltool  
    ```

    Install using conda  
    ```
    conda create -n cwltool  
    conda activate cwltool  
    conda install -c conda-forge cwltool 
    ``` 

- [docker](https://www.docker.com/)  

    † and Docker Desktop must be running  

## Simple usage  

- Clone this repository  

    ```
    git clone https://github.com/RyoNozu/CWL4IncorporateTSSintoGXF.git
    cd CWL4IncorporateTSSintoGXF
    ```

- Run workflow  

    ```
    # for paired-end reads case
    cwltool --debug --cachedir ./cwl_cache/ --outdir ./test/ ./workflow/cageseq_gtf_update_pe.cwl ./config/Workflow_config/cageseq_gtf_update_pe.yml
    ```
    - Prep your case yml file referring to the [template](https://github.com/RyoNozu/CWL4IncorporateTSSintoGXF/blob/main/config/workflow_template.yml)  
        • Refer to the [Link](https://view.commonwl.org/workflows/github.com/RyoNozu/CWL4IncorporateTSSintoGXF/blob/main/workflow/cageseq_gtf_update_pe.cwl) for details on each parameter that needs to be specified  
    - A single-ended version (cageseq_gtf_update_se.cwl) is in prep as of 20240417  

## Input files  

- CAGE-seq Read (fastq, paried/single-end)  
- reference genome (fasta)  
- gene annotation file (gff/gtf)  
- (BSgenome_data_package_seed_file (.txt))  
        > refere to forgeBSgenomeDataPkg function in [BSgenomeForge](https://bioconductor.org/packages/release/bioc/html/BSgenomeForge.html) package  

## Output files  

- updated gxf file (.gff/gtf)  

## FYI: Running time

***

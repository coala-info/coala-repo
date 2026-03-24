# chipseq-pe/main CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/398
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/398/ro_crate?version=17
- **Conda**: N/A
- **Total Downloads**: 47.5K
- **Last updated**: 2025-11-27
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 17
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `chipseq-pe.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 17707
- **Creators**: Lucille Delisle

## Description

Complete ChIP-seq analysis for paired-end sequencing data. Processes raw FASTQ files through adapter removal (cutadapt), alignment to reference genome (Bowtie2), and stringent quality filtering (MAPQ &gt;= 30, concordant pairs only). Peak calling with MACS2 optimized for paired-end reads identifies protein-DNA binding sites. Generates alignment files, peak calls, and quality metrics for downstream analysis.

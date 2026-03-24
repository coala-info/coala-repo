# chipseq-sr/main CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/397
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/397/ro_crate?version=16
- **Conda**: N/A
- **Total Downloads**: 45.1K
- **Last updated**: 2025-11-27
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 16
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `chipseq-sr.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 17303
- **Creators**: Lucille Delisle

## Description

Complete ChIP-seq analysis for single-end sequencing data. Processes raw FASTQ files through adapter removal (cutadapt), alignment to reference genome (Bowtie2), and quality filtering (MAPQ &gt;= 30). Peak calling with MACS2 uses either a fixed extension parameter or built-in model to identify protein-DNA binding sites. Generates alignment files, peak calls, and quality metrics for downstream analysis.

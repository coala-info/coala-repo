# rnaseq-sr/main CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/400
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/400/ro_crate?version=13
- **Conda**: N/A
- **Total Downloads**: 46.6K
- **Last updated**: 2026-02-18
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 13
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `rnaseq-sr.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 15305
- **Creators**: Lucille Delisle

## Description

This workflow takes as input a list of single-read fastqs. Adapters and bad quality bases are removed with cutadapt. Reads are mapped with STAR with ENCODE parameters and genes are counted simultaneously. The counts are reprocess to be similar to HTSeq-count output. FPKM are computed with cufflinks. Coverage (per million mapped reads) are computed with bedtools on uniquely mapped reads.

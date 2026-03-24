# atacseq/main CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://iwc.galaxyproject.org/
- **Package**: https://workflowhub.eu/workflows/399
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/399/ro_crate?version=19
- **Conda**: N/A
- **Total Downloads**: 43.3K
- **Last updated**: 2026-01-25
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 19
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `atacseq.ga` (Main Workflow)
- **Project**: Intergalactic Workflow Commission (IWC)
- **Views**: 20446
- **Creators**: Lucille Delisle

## Description

This workflow take as input a collection of paired fastq. It will remove bad quality and adapters with cutadapt. Map with Bowtie2 end-to-end. Will remove reads on MT and unconcordant pairs and pairs with mapping quality below 30 and PCR duplicates. Will compute the pile-up on 5' +- 100bp. Will call peaks and count the number of reads falling in the 1kb region centered on the summit. Will plot the number of reads for each fragment length.

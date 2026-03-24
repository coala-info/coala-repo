# Trio Analysis CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://training.galaxyproject.org
- **Package**: https://workflowhub.eu/workflows/363
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/363/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 1.1K
- **Last updated**: 2023-09-05
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: CC-BY-4.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `main_workflow.ga` (Main Workflow)
- **Project**: Galaxy Training Network
- **Views**: 8540
- **Creators**: Jasper Ouwerkerk

## Description

To discover causal mutations of inherited diseases it’s common practice to do a trio analysis. In a trio analysis DNA is sequenced of both the patient and parents. Using this method, it’s possible to identify multiple inheritance patterns. Some examples of these patterns are autosomal recessive, autosomal dominant, and de-novo variants, which are represented in the figure below. To elaborate, the most left tree shows an autosomal dominant inhertitance pattern where the offspring inherits a faulty copy of the gene from one of the parents.

To discover these mutations either whole exome sequencing (WES) or whole genome sequencing (WGS) can be used. With these technologies it is possible to uncover the DNA of the parents and offspring to find (shared) mutations in the DNA. These mutations can include insertions/deletions (indels), loss of heterozygosity (LOH), single nucleotide variants (SNVs), copy number variations (CNVs), and fusion genes.

In this workflow  we will also make use of the HTSGET protocol, which is a program to download our data securely and savely. This protocol has been implemented in the EGA Download Client Tool: toolshed.g2.bx.psu.edu/repos/iuc/ega_download_client/pyega3/4.0.0+galaxy0 tool, so we don’t have to leave Galaxy to retrieve our data.

We will not start our analysis from scratch, since the main goal of this tutorial is to use the HTSGET protocol to download variant information from an online archive and to find the causative variant from those variants. If you want to learn how to do the analysis from scratch, using the raw reads, you can have a look at the Exome sequencing data analysis for diagnosing a genetic disease tutorial.

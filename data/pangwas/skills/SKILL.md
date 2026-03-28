---
name: pangwas
description: panGWAS is an integrated bioinformatics framework for building pangenomes and performing genome-wide association studies to link genetic variations to phenotypes. Use when user asks to build a pangenome, identify genetic variations across a population, or run GWAS to link variants to specific phenotypes.
homepage: https://github.com/phac-nml/pangwas
---


# pangwas

## Overview

panGWAS is an integrated bioinformatics framework designed to bridge the gap between raw genomic assemblies and interpretable GWAS results. It automates the complex workflow of building a pangenome, identifying genetic variations across a population, and statistically linking those variations to specific phenotypes. By combining specialized tools like Bakta for annotation, MMseqs2 for clustering, and pyseer for association modeling, it provides a deterministic and reproducible path for analyzing both coding and non-coding sequences.

## Core Workflow and CLI Patterns

The tool can be used as a modular CLI for step-by-step analysis or as a Nextflow pipeline for end-to-end automation.

### Modular CLI Usage

For granular control over the pangenome construction process, use the individual subcommands:

1.  **Extraction**: Extract features from annotation files.
    `pangwas extract --gff sample1.gff3`
2.  **Collection**: Aggregate extracted features from multiple samples.
    `pangwas collect --tsv sample1.tsv sample2.tsv sample3.tsv`
3.  **Clustering**: Identify homologous regions across the collection.
    `pangwas cluster --fasta sequences.fasta`

### Nextflow Integration

For most production environments, running the Nextflow pipeline is the preferred method to ensure environment stability and process orchestration.

```bash
nextflow run phac-nml/pangwas --input samplesheet.csv --outdir results
```

## Expert Tips and Best Practices

*   **Non-Bacterial Genomes**: While panGWAS uses Bakta for automated bacterial annotation, you must provide your own GFF3 files when working with non-bacterial organisms. Ensure these GFF files are standardized to prevent errors during the `extract` phase.
*   **Deterministic Results**: panGWAS is designed to be deterministic. If you need to reproduce a specific study, ensure you use the same version of the underlying tools (MMseqs2, MAFFT, IQ-TREE) as these are the primary sources of variation in pangenome alignment.
*   **Variant Linking**: One of the tool's strengths is keeping variants tightly linked to their annotations. When interpreting GWAS results, always refer back to the cluster alignments to understand the functional context of a significant SNP or structural variant.
*   **Population Structure**: Always utilize the tree-building step (IQ-TREE) before running the GWAS modeling. Correcting for population structure is critical in bacterial GWAS to avoid false positives caused by clonal descent.
*   **Resource Management**: Clustering and alignment are memory-intensive. When running on large datasets (>500 genomes), ensure your environment has sufficient RAM for MMseqs2 and MAFFT.



## Subcommands

| Command | Description |
|---------|-------------|
| binarize | Convert a categorical column to multiple binary (0/1) columns. |
| defrag | Defrag clusters by associating fragments with their parent cluster. |
| gwas | Run genome-wide association study (GWAS) tests with pyseer. |
| heatmap | Plot a heatmap of variants alongside a tree. |
| manhattan | Plot the distribution of variant p-values across the genome. |
| pangwas collect | Collect extracted sequences from multiple samples into one file. |
| pangwas presence_absence | Extract presence absence of clusters. |
| pangwas structural | Extract structural variants from cluster alignments. |
| pangwas tree | Estimate a maximum-likelihood tree with IQ-TREE. |
| pangwas_align | Align clusters using mafft and create a pangenome alignment. |
| pangwas_annotate | Annotate genomic assemblies with bakta. |
| pangwas_cluster | Cluster nucleotide sequences with mmseqs. |
| pangwas_extract | Extract sequences and annotations from GFF files. |
| pangwas_summarize | Summarize clusters according to their annotations. |
| root_tree | Root tree on outgroup taxa. |
| snps | Extract SNPs from a pangenome alignment. |
| table_to_rtab | Convert a TSV/CSV table to an Rtab file based on regex filters. |
| vcf_to_rtab | Convert a VCF file to an Rtab file. |

## Reference documentation
- [panGWAS GitHub Repository](./references/github_com_phac-nml_pangwas_blob_main_README.md)
- [Pipeline Documentation](./references/phac-nml_github_io_pangwas_pipeline_pipeline.html.md)
- [Manual Table of Contents](./references/phac-nml_github_io_pangwas_manual_table_of_contents.html.md)
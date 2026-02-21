---
name: pangwas
description: panGWAS is a comprehensive bioinformatics toolset designed to bridge the gap between raw genomic assemblies and association results.
homepage: https://github.com/phac-nml/pangwas
---

# pangwas

## Overview

panGWAS is a comprehensive bioinformatics toolset designed to bridge the gap between raw genomic assemblies and association results. It provides a deterministic pipeline that reconstructs a pangenome, identifies variants (SNPs, presence/absence, and structural variants), and models their association with specific variables or traits. It is particularly effective for bacterial genomics as it integrates both coding and non-coding sequences and maintains tight links between variants and their functional annotations.

## CLI Usage and Best Practices

The `pangwas` tool can be used as a modular CLI for specific steps or as an automated Nextflow pipeline for end-to-end analysis.

### Core CLI Subcommands

The CLI follows a sequential logic for pangenome construction:

*   **Extraction**: Prepare data from GFF3 files.
    `pangwas extract --gff sample_name.gff3`
*   **Collection**: Aggregate extracted data for pangenome analysis.
    `pangwas collect --tsv sample1.tsv sample2.tsv ...`
*   **Clustering**: Identify homologous regions using MMseqs2.
    `pangwas cluster --fasta sequences.fasta`

### Nextflow Pipeline Execution

For reproducible, end-to-end runs, use the Nextflow implementation. This is the recommended approach for large datasets.

*   **Test Run**: Verify installation and environment setup.
    `nextflow run phac-nml/pangwas -profile test`
*   **Standard Run**: Execute the full pipeline on your data.
    `nextflow run phac-nml/pangwas -profile <docker/conda> --input <samplesheet.csv>`

### Expert Tips and Workflow Optimization

*   **Annotation**: While `bakta` is the default for bacterial genomes, users working with non-bacterial genomes must provide their own GFF annotations to the pipeline.
*   **Visualization**: 
    *   **Interactive Plots**: Always check the `.svg` outputs in the `manhattan` and `heatmap` directories. Opening these in a web browser (Edge or Firefox) enables interactive hovertext for variant details.
    *   **Pangenome Graphs**: Use **Bandage** to visualize the `.gfa` files found in the `summarize` output directory.
    *   **Phylogeny**: Use **Arborview** for interactive exploration of the Newick (`.nwk`) tree files generated during the `tree` step.
*   **Association Modeling**: The pipeline uses `pyseer` for GWAS. Ensure your phenotype data is correctly formatted to match the sample IDs used in the genomic assemblies.

## Reference documentation

- [panGWAS GitHub Repository](./references/github_com_phac-nml_pangwas.md)
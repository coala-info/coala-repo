---
name: bioinfokit
description: Bioinfokit is a Python toolkit designed for the analysis and visualization of genome-scale omics data through high-level wrappers for statistical testing and bioinformatics tasks. Use when user asks to generate volcano or Manhattan plots, normalize RNA-seq data, perform biostatistical tests like Tukey HSD, or manipulate sequence files such as VCF and GFF3.
homepage: https://reneshbedre.github.io/blog/howtoinstall.html
metadata:
  docker_image: "quay.io/biocontainers/bioinfokit:2.1.3--pyh7cba7a3_0"
---

# bioinfokit

## Overview
Bioinfokit is a specialized Python toolkit designed to simplify the analysis and visualization of genome-scale omics experiments. It provides high-level wrappers for complex bioinformatics tasks, allowing users to transform raw dataframes into biological insights through statistical testing and sophisticated graphical representations. Use this skill to streamline workflows involving gene expression analysis, variant annotation, and sequence manipulation without writing extensive boilerplate code.

## Core Functionalities and Patterns

### 1. Gene Expression Visualization
The `visuz` module is the primary interface for generating publication-ready figures.

*   **Volcano Plots**: Used to identify significantly differentially expressed genes.
    ```python
    from bioinfokit import visuz
    # df must be a pandas dataframe with logFC and p-values
    visuz.gene_exp.volcano(df=df, lfc='logFC', pv='p_value', geneid='GeneNames', genenames=('Gene1', 'Gene2'), show=True)
    ```
*   **MA Plots**: Useful for visualizing the relationship between concentration and fold change.
    ```python
    visuz.gene_exp.ma(df=df, lfc='logFC', ct_count='control_count', tr_count='treatment_count', show=True)
    ```

### 2. Data Normalization
The `analys` module provides standard methods for RNA-seq data normalization.

*   **TPM/RPKM/CPM**:
    ```python
    from bioinfokit.analys import norm
    nm = norm()
    # Requires a dataframe with raw counts and a column for gene lengths
    nm.tpm(df=df, gl='length')
    tpm_df = nm.tpm_norm
    ```

### 3. Variant and Sequence Analysis
Bioinfokit handles common file processing tasks for VCF and FASTA formats.

*   **Manhattan Plots**: For visualizing Genome-Wide Association Studies (GWAS).
    ```python
    visuz.stat.manhattan(df=df, chr='chrom', pv='p_value', show=True)
    ```
*   **Sequence Manipulation**:
    *   **GFF3 to GTF**: `tools.gff3_to_gtf(file='input.gff3')`
    *   **Reverse Complement**: `tools.rev_com('ATGC')`
    *   **VCF Processing**: Use `tools.vcf_split()` or `tools.vcf_concat()` for managing large variant files.

### 4. Biostatistical Tests
The toolkit includes wrappers for common biological statistics:
*   **Tukey HSD**: For post-hoc analysis after ANOVA.
*   **Correlation Matrix**: `visuz.stat.corr_matrix(df=df)`
*   **PCA**: Generate biplots and scree plots to visualize sample clustering.

## Expert Tips and Best Practices
*   **Data Preparation**: Bioinfokit is heavily dependent on `pandas`. Ensure your data is loaded into a DataFrame and that column names for Log Fold Change (LFC) and P-values are correctly specified in function arguments.
*   **Plot Customization**: Most visualization functions support `figtype` (e.g., 'png', 'pdf', 'svg') and `dim` (tuple for figure size). For publications, use `figtype='pdf'` or `figtype='svg'` to maintain vector quality.
*   **Interactive vs. Saved**: By default, many functions save the plot to the current directory. Set `show=True` to view the plot immediately in Jupyter notebooks or interactive shells.
*   **Memory Management**: When working with large FASTA or VCF files, use the specific readers provided in `bioinfokit.analys.get_data` to handle streams efficiently.

## Reference documentation
- [bioinfokit documentation](./references/reneshbedre_github_io_blog_howtoinstall.html.md)
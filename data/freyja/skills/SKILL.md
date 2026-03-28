---
name: freyja
description: Freyja recovers the relative abundance of SARS-CoV-2 lineages from mixed sequencing datasets using a library of lineage-defining mutational barcodes. Use when user asks to call variants from BAM files, update lineage barcodes, de-mix samples to estimate lineage proportions, or aggregate results from multiple samples.
homepage: https://github.com/andersen-lab/Freyja
---


# freyja

## Overview

Freyja is a specialized tool designed to recover the relative abundance of SARS-CoV-2 lineages from mixed sequencing datasets. It utilizes a "basis set" of lineage-defining mutational barcodes—derived from the UShER global phylogenetic tree—to solve a constrained de-mixing problem. By analyzing single nucleotide variant (SNV) frequencies and sequencing depth from a BAM file aligned to the Hu-1 reference, Freyja provides a statistical estimate of the lineages present in a sample.

## Core CLI Workflow

The standard Freyja pipeline follows a linear progression from aligned sequence data to aggregated lineage reports.

### 1. Variant Calling and Depth Calculation
Generate the required SNV frequency and depth files from an aligned, trimmed, and sorted BAM file.

```bash
freyja variants sample.bam \
  --variants output_variants.tsv \
  --depths output.depth \
  --ref NC_045512_Hu-1.fasta
```

### 2. Updating Lineage Barcodes
Lineage definitions change rapidly. Always ensure your local barcode library is current before de-mixing.

```bash
# Update the default data directory
freyja update

# Or specify a local directory for reproducibility/version control
freyja update --outdir ./my_barcodes/
```

### 3. Lineage De-mixing
Perform the actual abundance estimation using the variants and depth files generated in step 1.

```bash
freyja demix output_variants.tsv output.depth \
  --output sample_demix.tsv \
  --confirmedonly
```
*   **Tip**: Use `--confirmedonly` to restrict the solver to lineages officially recognized by the WHO/Pango, which often reduces noise in complex samples.
*   **Tip**: If you used a custom output directory for barcodes, specify it with `--barcodes ./my_barcodes/`.

### 4. Aggregating Results
When processing multiple samples, use the aggregate command to compile individual TSV outputs into a single summary table.

```bash
freyja aggregate path/to/demix_results/ \
  --output aggregated_report.tsv
```

## Best Practices and Expert Tips

*   **Input Requirements**: Ensure your BAM files are aligned to the **Hu-1 reference (NC_045512.2)**. Using other references will lead to incorrect SNV coordinates and failed de-mixing.
*   **Preprocessing**: Freyja is intended as a post-processing step. Always perform primer trimming (e.g., using `ivar trim`) and quality sorting before running `freyja variants`.
*   **Reproducibility**: For publication-quality results, record the barcode version used. You can check this with `freyja demix --version`. If you need to re-run an analysis with specific historical barcodes, point Freyja to a timestamped barcode file from the `Freyja-data` repository.
*   **Solver Selection**: If using Python 3.11+, Freyja utilizes the `Clarabel` solver, which is generally faster and more robust for the constrained optimization problem.
*   **Visualization**: After aggregation, you can use `freyja plot` to generate standard abundance plots, or import the aggregated TSV into tools like Excel or R for custom visualization.



## Subcommands

| Command | Description |
|---------|-------------|
| ampliconstat | Calculate amplicon statistics from a FASTA file. |
| barcode-build | Builds a barcode reference from a FASTA file. |
| demix | Generate relative lineage abundances from VARIANTS and DEPTHS |
| freyja aggregate | Aggregates all demix data in RESULTS directory |
| freyja boot | Perform bootstrapping method for freyja using VARIANTS and DEPTHS |
| freyja update | Update to the most recent barcodes and curated lineage data |
| freyja_covariants | Calls physically linked mutations in BAM_FILE using coVar (https://github.com/andersen-lab/covar) |
| freyja_dash | Generate an interactive dashboard from Freyja results. |
| freyja_extract | Extracts reads from INPUT_BAM containing one or more QUERY_MUTATIONS |
| freyja_filter | Excludes reads from INPUT_BAM containing one or more QUERY_MUTATIONS between MIN_SITE and MAX_SITE (genomic coordinates) |
| freyja_plot | Create plot from AGG_RESULTS |
| freyja_relgrowthrate | Calculates relative growth rates for each lineage using AGG_RESULTS and METADATA |
| freyja_variants | Perform variant calling using samtools and iVar on a BAMFILE |
| get-lineage-def | Get the mutations defining a LINEAGE of interest from provided barcodes |
| plot-covariants | Plot COVARIANTS output as a heatmap |

## Reference documentation
- [Freyja README](./references/github_com_andersen-lab_Freyja.md)
- [Command Line Workflow](./references/github_com_andersen-lab_Freyja_wiki_Command-Line-Workflow.md)
- [Freyja Wiki Home](./references/github_com_andersen-lab_Freyja_wiki.md)
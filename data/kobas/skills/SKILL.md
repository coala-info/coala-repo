---
name: kobas
description: "KOBAS performs functional annotation and pathway enrichment analysis to identify statistically significant biological pathways and GO terms. Use when user asks to annotate sequences with functional information, perform over-representation analysis, or identify enriched pathways from gene lists."
homepage: http://kobas.cbi.pku.edu.cn
---

# kobas

## Overview
KOBAS is a bioinformatics toolset designed for two primary purposes: assigning genes or proteins to functional categories (Annotation) and identifying statistically significant pathways or GO terms associated with a set of genes (Identification/Enrichment). It is particularly useful for interpreting high-throughput omics data by mapping sequences to known biological pathways across multiple species.

## Functional Annotation
Use the `kobas-annotate` command to map sequences to orthology terms.

- **Basic Annotation**:
  `kobas-annotate -i input.fasta -t fasta:blastp -s <species_code> -o output.annotate`
- **Input Types**: Supports `fasta` (protein/nucleotide), `blastout` (tabular), and `id` (Entrez, Ensembl, UniProt).
- **Species Codes**: Use standard abbreviations (e.g., `hsa` for Homo sapiens, `mmu` for Mus musculus).
- **Best Practice**: Ensure your BLAST E-value threshold (`-e`) is appropriate for your sequence similarity requirements (default is usually 1e-5).

## Pathway Enrichment Analysis
Use the `kobas-identify` command to perform statistical testing on annotated results.

- **Over-representation Analysis (ORA)**:
  `kobas-identify -i output.annotate -t 1 -m hyper -n <background_species> -o output.identify`
- **Statistical Methods (`-m`)**: 
  - `hyper`: Hypergeometric test (Standard for ORA).
  - `binom`: Binomial test.
  - `chi`: Chi-square test.
- **FDR Correction (`-b`)**: Always apply multiple testing correction using `-b BH` (Benjamini-Hochberg) or `-b Q` (Q-value) to minimize false positives.
- **Databases (`-d`)**: Specify target databases such as `kegg`, `reactome`, `biocyc`, or `go`. Multiple databases can be comma-separated.

## Expert Tips
- **Background Sets**: For more accurate enrichment, provide a custom background file (`-g`) representing all genes expressed or surveyed in your specific experiment, rather than using the entire genome.
- **Rank-based Analysis**: If you have a ranked list of genes (e.g., by fold change), use the `-m ks` (Kolmogorov-Smirnov) or `-m rank` options for gene set enrichment style analysis.
- **Output Interpretation**: Focus on the `Corrected P-value` column. A common threshold for significance is < 0.05.



## Subcommands

| Command | Description |
|---------|-------------|
| kobas-identify | Identify enriched biological terms from foreground and background gene lists. |
| kobas_kobas-annotate | Annotate input sequences with functional information. |

## Reference documentation
- [KOBAS Overview](./references/anaconda_org_channels_bioconda_packages_kobas_overview.md)
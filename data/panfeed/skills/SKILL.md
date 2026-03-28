---
name: panfeed
description: panfeed is a k-mer streaming tool that anchors genomic variation to specific gene clusters in bacterial pangenomes for association studies. Use when user asks to generate k-mer presence/absence patterns, perform fine-mapping of GWAS hits, or visualize k-mer associations within gene clusters.
homepage: https://github.com/microbial-pangenomes-lab/panfeed
---

# panfeed

## Overview
panfeed is a specialized k-mer streaming tool that processes bacterial pangenomes one gene cluster at a time. Unlike global de Bruijn graph approaches, panfeed anchors k-mers to specific gene clusters, which reduces computational artifacts in repetitive regions and makes the resulting GWAS hits much easier to interpret and visualize. It transforms annotated assemblies (GFF3) and pangenome matrices into k-mer tables, providing both presence/absence patterns for discovery and base-resolution mapping for fine-mapping.

## Workflow and CLI Patterns

### The Two-Pass Strategy
To optimize storage and speed, always use the two-pass approach.

**Pass 1: Discovery**
Generate the unique k-mer presence/absence patterns for the entire pangenome.
```bash
panfeed -g gff_folder/ -p gene_presence_absence.csv -o discovery_out --upstream 100 --downstream 100 --compress --cores 8
```
*   **-g**: Directory containing `SAMPLE.gff` files (must include nucleotide sequences at the end).
*   **-p**: The pangenome matrix from Roary, Panaroo, or ggCaller.
*   **--upstream/--downstream**: Captures non-coding variation surrounding the gene.

**Pass 2: Fine-Mapping**
After running GWAS (e.g., with pyseer) and identifying significant hits, extract the relevant clusters and re-run panfeed to get positional data.
```bash
# 1. Extract significant clusters (threshold e.g., 1E-7)
panfeed-get-clusters -a pyseer_results.tsv -p discovery_out/kmers_to_hashes.stv.gz -t 1E-7 > target_genes.txt

# 2. Run second pass for positional mapping
panfeed -g gff_folder/ -p gene_presence_absence.csv -o fine_mapping_out --genes target_genes.txt --upstream 100 --downstream 100 --compress
```

### Annotation and Visualization
Once the second pass is complete, merge the association statistics with the positional k-mer data to create interpretable plots.

```bash
# Annotate k-mers with association stats
panfeed-get-kmers -a pyseer_results.tsv -p discovery_out/kmers_to_hashes.tsv.gz -k fine_mapping_out/kmers.tsv.gz | gzip > annotated_kmers.tsv.gz

# Generate plots (Significance, Sequence, and Hybrid)
panfeed-plot -k annotated_kmers.tsv.gz -p phenotype_data.tsv --phenotype-column MY_TRAIT
```

## Expert Tips and Best Practices
*   **Input Formatting**: Ensure sample names in your GFF filenames (`SAMPLE.gff`) exactly match the column headers in your `gene_presence_absence.csv`.
*   **Missing Genes**: Use `--consider-missing` if you want the k-mer patterns to explicitly differentiate between a missing k-mer within a gene and the entire gene cluster being absent.
*   **Large Datasets**: For datasets with thousands of samples, provide a "file-of-files" to `-g` (a text file containing paths to GFFs) instead of a directory path to avoid shell argument limits and filesystem latency.
*   **Memory Management**: panfeed is efficient because it streams by cluster, but increasing `--cores` will increase memory usage linearly.
*   **Separate Fastas**: If your GFF3 files do not contain the `##FASTA` section, provide the sequences separately using `-f fasta_folder/`.



## Subcommands

| Command | Description |
|---------|-------------|
| panfeed | Get gene cluster specific k-mers from a set of bacterial genomes |
| panfeed-get-clusters | Indicate which genes clusters have significantly associated patterns |
| panfeed-get-kmers | Annotate association results with positional information |
| panfeed-plot | Plot association results from panfeed |

## Reference documentation
- [panfeed README and Quick Start](./references/github_com_microbial-pangenomes-lab_panfeed_blob_main_README.md)
- [panfeed Overview](./references/anaconda_org_channels_bioconda_packages_panfeed_overview.md)
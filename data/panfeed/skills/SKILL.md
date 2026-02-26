---
name: panfeed
description: panfeed is a k-mer counter that extracts gene-cluster-specific k-mer patterns from microbial pangenomes for association studies. Use when user asks to generate k-mer presence/absence matrices, perform fine-mapping of GWAS hits, or visualize k-mer positions relative to gene clusters.
homepage: https://github.com/microbial-pangenomes-lab/panfeed
---


# panfeed

## Overview

panfeed is a specialized k-mer counter designed for microbial pangenomics. Unlike global de Bruijn graph approaches, it streams k-mers one gene cluster at a time. This localized approach reduces computational artifacts in repetitive regions and significantly improves the interpretability of GWAS results. It takes GFF3 files and a gene presence/absence matrix (from tools like Panaroo or Roary) and produces k-mer presence/absence patterns compatible with association tools like pyseer.

## Installation

Install via bioconda for the most stable environment:
```bash
conda install -c bioconda panfeed
```

## Standard Workflow

### 1. First Pass: Pattern Generation
Generate the unique k-mer presence/absence patterns for the entire pangenome.
```bash
panfeed -g gff_folder/ -p gene_presence_absence.csv -o pass1_output --upstream 100 --downstream 100 --compress --cores 8
```
*   **-g**: Directory containing `.gff` files (must include nucleotide sequences).
*   **-p**: The presence/absence CSV from your pangenome pipeline.
*   **--upstream/--downstream**: Bases to include flanking the gene clusters.

### 2. Significance Filtering
After running GWAS (e.g., with pyseer) on `hashes_to_patterns.tsv.gz`, identify clusters containing significant k-mers.
```bash
panfeed-get-clusters -a gwas_results.tsv -p pass1_output/kmers_to_hashes.stv.gz -t 1E-7 > significant_clusters.txt
```

### 3. Second Pass: Fine-Mapping
Run panfeed again, but only on significant clusters to generate positional metadata.
```bash
panfeed -g gff_folder/ -p gene_presence_absence.csv -o pass2_output --genes significant_clusters.txt --targets samples.txt --upstream 100 --downstream 100 --compress
```

### 4. Annotation and Visualization
Merge GWAS statistics with k-mer positions and create plots.
```bash
# Merge data
panfeed-get-kmers -a gwas_results.tsv -p kmers_to_hashes.tsv.gz -k kmers.tsv.gz | gzip > annotated_kmers.tsv.gz

# Plot results
panfeed-plot -k annotated_kmers.tsv.gz -p phenotype_data.tsv --phenotype-column target_trait
```

## Expert Tips and Best Practices

*   **GFF3 Requirements**: Ensure your GFF3 files contain the `##FASTA` section at the end. If they do not, use the `-f` flag to point to a directory of matching FASTA files.
*   **Handling Large Datasets**: For thousands of samples, avoid shell "argument list too long" errors by providing a file containing paths instead of a directory: `panfeed -g file_of_gff_paths.txt ...`.
*   **Missing Data Encoding**: By default, a missing gene cluster is encoded as `0`. Use `--consider-missing` if you want the k-mer patterns to explicitly differentiate between a missing k-mer in an existing gene and a completely absent gene cluster.
*   **Memory Management**: When working with very large pangenomes, use the `--compress` flag to keep intermediate files small and reduce I/O overhead.
*   **Plot Customization**: Use `--start` and `--stop` in `panfeed-plot` to zoom into specific regions relative to the start codon (e.g., `--start -50 --stop 100` to focus on the promoter and 5' end).

## Reference documentation
- [panfeed GitHub Repository](./references/github_com_microbial-pangenomes-lab_panfeed.md)
- [panfeed Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_panfeed_overview.md)
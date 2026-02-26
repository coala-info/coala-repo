---
name: genview
description: genview automates the retrieval of genomic sequences and the alignment of gene-centric flanking regions to visualize synteny. Use when user asks to build a database of genetic environments, fetch genomes from NCBI by taxa or accession, or generate comparative maps of target genes.
homepage: https://github.com/EbmeyerSt/GEnView.git
---


# genview

## Overview

genview (GEnView) is a specialized tool for gene-centric comparative genomics. It automates the process of fetching genomic sequences, identifying target genes, extracting their flanking regions (typically 20kbp), and aligning these environments to visualize synteny. The workflow is split into two primary phases: database construction (`genview-makedb`) and interactive visualization (`genview-visualize`).

## Database Construction (genview-makedb)

The first step involves searching for target genes and building a local SQLite3 database of their genetic environments.

### Common CLI Patterns

**1. Searching NCBI by Taxon**
To download and process all genomes for a specific genus or species:
```bash
genview-makedb -d output_dir -db target_genes.fasta --taxa "Aeromonas" --assemblies --plasmids
```

**2. Using Local Genomes**
To analyze your own assembly files instead of downloading from NCBI:
```bash
genview-makedb -d output_dir -db target_genes.fasta --local /path/to/local/fasta_files/
```

**3. Processing Specific Accessions**
Use a CSV file containing one NCBI accession per row (e.g., GCA_006364295.1):
```bash
genview-makedb -d output_dir -db target_genes.fasta --accessions accessions.csv --assemblies
```

### Expert Tips for Database Creation
*   **Identity and Coverage:** Use `-id` (identity) and `-scov` (subject coverage) to filter hits. For example, `-id 90 -scov 80` ensures only high-quality matches are stored.
*   **Flanking Regions:** The default flanking length is 20kb. Adjust this using `--flanking_length` if you need to see more or less of the surrounding genetic context.
*   **Performance:** Use the `-p` flag to specify the number of CPU cores for parallel processing.
*   **Annotation:** If you have a local UniprotKB diamond database, provide it via `--uniprot_db` to speed up the annotation of flanking ORFs.

## Visualization (genview-visualize)

Once the database is created, use the visualization tool to generate the comparative maps.

### Common CLI Patterns

**1. Basic Visualization**
```bash
genview-visualize -gene "target_gene_name" -db output_dir/genview.db -id 90
```

**2. Filtering and Customization**
Limit the visualization to specific taxa or change the node connection style:
```bash
genview-visualize -gene "target_gene_name" -db output_dir/genview.db -id 90 --taxa "Escherichia coli" --nodes solid
```

## Best Practices and Warnings

*   **Avoid `--taxa 'all'`:** This command will attempt to download the entire NCBI database (>4TB), which can take days and exhaust storage. Always specify target taxa or accessions.
*   **Pre-analysis:** If you are unsure which taxa contain your gene, perform a manual BLAST on the NCBI website first to identify relevant groups before running `genview-makedb`.
*   **Database Updates:** Use the `--update` flag with `genview-makedb` to add new genomes to an existing project directory without re-processing everything.
*   **Clean Runs:** If a previous run failed or you want to start fresh in the same directory, use the `--clean` flag to remove temporary files.

## Reference documentation
- [GEnView GitHub Repository](./references/github_com_EbmeyerSt_GEnView.md)
- [genview Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_genview_overview.md)
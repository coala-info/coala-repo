---
name: recognizer
description: reCOGnizer performs functional characterization of proteomes by comparing protein sequences against conserved domain databases using RPS-BLAST. Use when user asks to annotate protein sequences, map hits to functional categories, or perform metabolic reconstruction and comparative genomics.
homepage: https://github.com/iquasere/reCOGnizer
metadata:
  docker_image: "quay.io/biocontainers/recognizer:1.11.1--hdfd78af_0"
---

# recognizer

## Overview
reCOGnizer is a specialized tool for the functional characterization of proteomes. It utilizes RPS-BLAST to compare protein sequences against Hidden Markov Models (HMMs) from the Conserved Domain Database (CDD), including COG, Pfam, and TIGRFAM. Beyond simple identification, it maps hits to higher-level functional categories, enzyme classifications, and orthology groups, making it an essential tool for metabolic reconstruction and comparative genomics.

## Installation
The tool is primarily distributed via Bioconda:
```bash
conda install -c conda-forge -c bioconda recognizer
```

## Command Line Usage

### Basic Annotation
To run a standard annotation with default settings (all available databases):
```bash
recognizer -f input_file.faa -o output_directory
```

### Performance Optimization
reCOGnizer supports multithreading for RPS-BLAST, which significantly reduces processing time for large datasets:
```bash
# Use a specific number of threads (default is max available)
recognizer -f input.faa -o output_dir -t 8
```

### Database Selection
You can limit the search to specific databases to save time or focus on specific functional schemas:
```bash
# Options include: CDD, NCBIfam, Pfam, TIGRFAM, Protein Clusters, SMART, COG, KOG
recognizer -f input.faa -dbs COG,Pfam,TIGRFAM
```

### Taxonomy-Aware Annotation
Providing taxonomic information allows reCOGnizer to filter Markov Models for specific taxa, increasing the precision of the assignments:
```bash
recognizer -f input.faa \
  --tax-file taxonomy_info.tsv \
  --tax-col 'Taxonomic lineage IDs' \
  --protein-id-col qseqid \
  --species-taxids
```
*Note: The tax-file should be a TSV with query names in the first column and TaxIDs in the second.*

## Expert Tips and Best Practices

- **Input Format**: Ensure your input is an amino acid FASTA file (typically `.faa` or `.fasta`). Nucleotide sequences must be translated before running reCOGnizer.
- **E-value Thresholds**: The default e-value is `1e-3`. For more stringent annotations, adjust using the `--evalue` flag (e.g., `--evalue 1e-5`).
- **Handling Headers**: By default, BLAST ignores sequence ID information after the first space. If your FASTA headers contain critical metadata, use the `--keep-spaces` flag to convert spaces to underscores.
- **Resource Management**: On first run, the tool will download and build the necessary databases in `~/recognizer_resources`. You can change this location using `-rd` or `--resources-directory`.
- **Output Interpretation**:
    - `reCOGnizer_results.tsv/xlsx`: Comprehensive annotation table.
    - `cog_quantification.tsv`: Summary of functional categories.
    - `krona_plot.html`: Interactive visualization of the functional landscape.
- **Debugging**: If a run fails or you need to inspect the alignment details, use `--keep-intermediates` to preserve the ASN, RPSBPROC, and BLAST reports.

## Reference documentation
- [reCOGnizer GitHub Repository](./references/github_com_iquasere_reCOGnizer.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_recognizer_overview.md)
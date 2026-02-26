---
name: cressent
description: cressent is a bioinformatic suite designed to process, annotate, and analyze Circular Rep-Encoding Single-Stranded DNA viral sequences from metagenomic data. Use when user asks to build taxonomic databases, cluster sequences, detect kitome contamination, reorient sequences to conserved motifs, or perform phylogenetic alignments.
homepage: https://github.com/ricrocha82/cressent
---


# cressent

## Overview

cressent (CRESSdna Extended aNnotation Toolkit) is a modular bioinformatic suite tailored for the study of Circular Rep-Encoding Single-Stranded DNA viruses. It streamlines the transition from raw metagenomic contigs to structured phylogenetic data by providing specialized modules for database curation, sequence clustering, and motif-based sequence adjustment. The tool is particularly effective for researchers needing to identify conserved viral proteins (Rep and Cap) and filter out known "kitome" contaminants from high-throughput sequencing data.

## Core CLI Modules and Patterns

### 1. Database Management
Use `db_builder` to create localized subsets of the CRESS-DNA database based on specific taxonomic ranks.

```bash
cressent db_builder \
  -t ./DB/taxonomy_accession_number.csv \
  -l Genus \
  -s "Restivirus" "Lophivirus" \
  -o ./my_DB \
  -e your.email@example.com
```
*   **Tip**: Always provide a valid email (`-e`) as this module often interacts with NCBI services.
*   **Tip**: Use the `-l` flag to specify the taxonomic level (e.g., Family, Genus).

### 2. Sequence Dereplication (Clustering)
Use the `cluster` module to reduce redundancy in metagenomic datasets.

```bash
cressent cluster -i input.fa -o ./output/cluster --keep_names
```
*   **Best Practice**: Use `--keep_names` to prevent the tool from replacing spaces with underscores in your FASTA headers, which can be critical for downstream metadata matching.

### 3. Contamination Detection
Screen for potential "kitome" sequences using the built-in contamination modules.

**Build the screening DB:**
```bash
cressent build_contaminant_db --accession-csv DB/decont_accession_list.csv -o DB
```

**Run detection:**
```bash
cressent detect_contamination \
  -i my_sequences.fa \
  --db ./DB/contaminant_db.fasta \
  -o /output/contamination \
  --seq-type nucl \
  --threads 32
```
*   **Expert Tip**: The `--seq-type` defaults to automatic detection, but explicitly setting `nucl` (blastn) or `prot` (blastp) ensures the correct algorithm is used for your specific input.

### 4. Sequence Adjustment
Before alignment, use `adjust_seq` to reorient sequences to start at a conserved nonanucleotide motif (default: `TAGTATTAC`).

```bash
# Using default nonanucleotide
cressent adjust_seq -i input.fa -o ./output_dir

# Using a custom Regex pattern
cressent adjust_seq -i input.fa -m ".{5}GK[TS].{4}" -o ./output_dir
```

### 5. Phylogenetic Alignment
The `align` module supports internal database references or user-provided sequences.

```bash
cressent align --threads 24 -i input.fa -o ./output_dir
```
*   **Note**: If using the tool's internal database, ensure the paths to `DB/caps` or `DB/reps` are correctly mapped in your environment.

## Tool-Specific Best Practices

*   **Environment Setup**: Installation via Mamba is highly recommended to resolve complex dependencies like IQ-TREE2 and BLAST+ efficiently.
*   **Resource Allocation**: Modules like `align` and `detect_contamination` are thread-intensive. Always specify `--threads` to match your HPC or workstation capacity to avoid default single-thread bottlenecks.
*   **Intermediate Files**: Use the `--keep-temp` flag during contamination detection if you need to inspect the raw BLAST results (`.tsv`) for manual verification of hits.
*   **Naming Conventions**: Be aware that without `--keep_names`, cressent may modify FASTA headers to ensure compatibility with certain phylogenetic tools that do not support spaces.

## Reference documentation
- [cressent GitHub Repository](./references/github_com_ricrocha82_cressent.md)
- [cressent Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cressent_overview.md)
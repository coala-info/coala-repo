---
name: genomics-data-index
description: The genomics-data-index transforms genomic features into a searchable database for rapid querying and comparative analysis. Use when user asks to build a genomic index from raw sequences or VCF files, query specific genetic markers, or export alignments and distance matrices from indexed samples.
homepage: https://github.com/apetkau/genomics-data-index
metadata:
  docker_image: "quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0"
---

# genomics-data-index

## Overview

The `genomics-data-index` (GDI) is a high-performance system designed to transform genomic information into a searchable database. It breaks down genomes into discrete features—such as nucleotide mutations, k-mers, or MLST alleles—and stores them in a structured index. This allows researchers to rapidly query thousands of samples to find specific genetic markers, calculate distances, or generate alignments and trees without re-processing raw data for every question.

## Core CLI Workflows

### 1. Building the Index
You can build an index either by analyzing raw sequence data or by loading pre-computed results.

**From Raw Sequences (Reads or Assemblies):**
Use the `analysis` command. It handles both compressed and uncompressed FASTA/FASTQ files.
```bash
gdi analysis --reference-file reference.gbk.gz sample1.fastq.gz sample2.fastq.gz
```

**From Existing VCF Files:**
If you already have variant calls, use the `load vcf` command.
```bash
gdi load vcf --reference-file reference.gbk.gz vcf_file_list.txt
```

**From MLST Results:**
GDI supports loading results from common MLST tools like `mlst` (tseemann) or `sistr`.
```bash
# Load from tseemann/mlst
gdi load mlst-tseemann mlst_results.tsv

# Load from sistr_cmd
gdi load mlst-sistr sistr_profiles.csv
```

### 2. Feature Naming Conventions
When querying the index, features must follow specific string formats:

*   **Nucleotide Mutations (SPDI-style):** `sequence:position:deletion:insertion`
    *   Example: `ref:100:A:T`
*   **Nucleotide Mutations (HGVS-style):** `hgvs:sequence:gene:p.protein_change`
    *   Example: `hgvs:ref:geneX:p.P20H`
*   **MLST/Genes:** `scheme:locus:allele`
    *   Example: `ecoli:adk:100`

### 3. Querying and Exporting
While GDI has a robust Python API, the CLI allows for quick summaries and data extraction.

**Summarizing Features:**
Generate a count of mutations or alleles present across the indexed samples.
```bash
# Example logical flow for a query (often used via Python API, but reflected in CLI summaries)
gdi --features-summary mlst
```

**Exporting Data:**
You can export nucleotide alignments, distance matrices, or trees constructed from subsets of features directly from the indexed data.

## Expert Tips and Best Practices

*   **Reference Genome Handling:** When building a SnpEff database for annotation, if you encounter errors with problematic genomes (e.g., CDS/Protein check failures), use the `--no-snpeff-reference-check` flag.
*   **Sample Name Sanitization:** GDI automatically sanitizes sample names during analysis to ensure compatibility with downstream tools like IQ-TREE and restores them afterward.
*   **Performance:** Use compressed input files (`.gz`, `.bz2`, `.xz`) to save disk space; GDI handles these natively.
*   **Indel Bias:** For assembly analysis, if you are missing indels, consider adjusting the `--indel-bias` (default is 1.0) in your configuration if you are calling variants via the internal pipeline.
*   **Version Compatibility:** Ensure you are using Python 3.8 or 3.9. GDI currently has known issues with Python 3.10+ due to dependencies in the ETE Toolkit.



## Subcommands

| Command | Description |
|---------|-------------|
| gdi analysis | Perform analysis on genomic data. |
| gdi load mlst-sistr | Load MLST-sistr data into the Genomics Data Index. |
| gdi load mlst-tseemann | Load MLST data from TSEEMANN format into the Genomics Data Index. |
| gdi load vcf | Load VCF files into the Genomics Data Index. |

## Reference documentation
- [Genomics Data Index README](./references/github_com_apetkau_genomics-data-index_blob_development_README.md)
- [GDI Changelog and Version History](./references/github_com_apetkau_genomics-data-index_blob_development_CHANGELOG.md)
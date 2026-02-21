---
name: genomics-data-index
description: The `genomics-data-index` (GDI) is a high-performance system designed to organize genomic information into a searchable database.
homepage: https://github.com/apetkau/genomics-data-index
---

# genomics-data-index

think software: genomics-data-index.
    *   Functionality: Indexing genomics data (SNVs, MLST, kmers) for rapid querying, clustering, and visualization.
    *   Components: Indexing (breaking genomes into features) and Querying (Python API and CLI).
    *   CLI commands: `gdi analysis`, `gdi load vcf`, `gdi load mlst-tseemann`, `gdi load mlst-sistr`.
    *   Feature naming: SPDI-inspired (sequence:position:deletion:insertion) or HGVS.
    *   Python API: `hasa()`, `isa()`, `isin()`, `summary_features()`, `tree_styler()`.
    *   Installation: Conda/Mamba (`bioconda` channel).

    *   Name: `genomics-data-index`
    *   Description: When to use? For indexing large genomic datasets (SNVs, MLST, kmers) to enable fast querying, sample selection, and comparative analysis. Use when you need to build a searchable database from VCFs, MLST results, or raw sequence data, or when performing complex sample filtering based on mutations and metadata.

    *   Overview: Explain what it is (indexing system for genomic features) and its value (rapid querying/clustering).
    *   CLI Patterns:
        *   Analysis: `gdi analysis --reference-file ...`
        *   Loading: `gdi load vcf`, `gdi load mlst-...`
    *   Feature Naming: Explain the SPDI and HGVS formats.
    *   Python API: Highlight the fluent interface (`isa`, `isin`, `hasa`).
    *   Best Practices: Use Mamba, check dependencies (mkisofs).

    *   No CWL.
    *   No YAML examples.
    *   Raw file content (no code fences).
    *   Reference documentation section at the end.

    *   *Frontmatter*:
        name: genomics-data-index
        description: Use this skill to index, query, and analyze large-scale genomics data including nucleotide variants (SNVs), MLST profiles, and kmers. It is ideal for rapid sample selection, feature summarization, and phylogenetic visualization based on specific mutations or metadata.

    *   *Overview*:
        The `genomics-data-index` (GDI) is a specialized tool designed to transform genomic data into a searchable index. By breaking genomes down into discrete features like mutations or alleles, it allows for near-instantaneous querying of thousands of samples. This is particularly useful for bioinformatics workflows involving outbreak investigation, population genomics, and comparative analysis where users need to filter samples by specific genetic markers or proximity in a phylogenetic tree.

    *   *CLI Usage*:
        - `gdi analysis`: Process raw reads or assemblies against a reference.
        - `gdi load vcf`: Index existing VCF files.
        - `gdi load mlst-tseemann`: Load MLST results from the `mlst` tool.

    *   *Feature Naming*:
        - SPDI: `ref:pos:del:ins`
        - HGVS: `hgvs:seq:gene:p.change`

    *   *Python API*:
        - `s.isa('lineage', isa_column='col')`
        - `s.isin(['Sample'], distance=1)`
        - `s.hasa('mutation')`

    *   *References*:
        - anaconda_org_channels_bioconda_packages_genomics-data-index_overview.md
        - github_com_apetkau_genomics-data-index.md

    *   Check: Did I include CWL? No.
    *   Check: Did I include YAML? No.
    *   Check: Is it raw markdown? Yes.
    *   Check: Is the overview in my own words? Yes.name: genomics-data-index
description: Use this skill to index, query, and analyze large-scale genomics data including nucleotide variants (SNVs), MLST profiles, and kmers. It is ideal for rapid sample selection, feature summarization, and phylogenetic visualization based on specific mutations or metadata.

## Overview

The `genomics-data-index` (GDI) is a high-performance system designed to organize genomic information into a searchable database. Instead of scanning raw files for every query, GDI breaks genomes into discrete features—such as nucleotide mutations, MLST alleles, or kmers—and stores them in an optimized index. This allows researchers to perform complex queries across thousands of samples in seconds, such as finding all samples with a specific protein-level mutation or identifying samples within a certain genetic distance of a cluster.

## Core Workflows

### 1. Indexing and Loading Data
GDI can build indexes from raw sequence data or ingest pre-computed results from other bioinformatics tools.

*   **From Raw Sequences**: Use the `analysis` command to process reads or assemblies against a reference genome.
    `gdi analysis --reference-file reference.gbk.gz *.fasta.gz`
*   **From VCF Files**: If you already have variant calls, load them directly.
    `gdi load vcf --reference-file reference.gbk.gz vcf-files.txt`
*   **From MLST Results**: GDI supports loading results from common MLST tools.
    - For `mlst` (tseemann): `gdi load mlst-tseemann mlst.tsv`
    - For `SISTR`: `gdi load mlst-sistr sistr-profiles.csv`

### 2. Feature Naming Conventions
When querying the index, features must follow specific naming formats:
*   **SNVs (SPDI-style)**: `sequence:position:deletion:insertion` (e.g., `ref:100:A:T`)
*   **SNVs (HGVS-style)**: Requires SnpEff-annotated data. Format: `hgvs:sequence:gene:p.protein_change` (e.g., `hgvs:ref:geneX:p.P20H`)
*   **MLST**: `scheme:locus:allele` (e.g., `ecoli:adk:100`)

### 3. Querying via Python API
The Python API uses a fluent interface to chain selection criteria.

```python
# Initialize your sample set 's'
# Chain queries: filter by lineage, then by tree distance, then by mutation
results = s.isa('B.1.1.7', isa_column='lineage') \
           .isin(['SampleA'], distance=1, units='substitutions') \
           .hasa('hgvs:MN996528.1:S:D614G')

# Export summaries or visualize
print(results.summary_features())
results.tree_styler().highlight(results).render()
```

## Expert Tips and Best Practices

*   **Environment Management**: Always install via Bioconda using Mamba for faster dependency resolution.
    `mamba create -c conda-forge -c bioconda -c defaults --name gdi genomics-data-index`
*   **SnpEff Dependency**: If using HGVS features, ensure `mkisofs` is installed on your system (e.g., `sudo apt install mkisofs` on Ubuntu) as it is required by SnpEff for certain operations.
*   **Reference Files**: Use compressed GenBank files (`.gbk.gz`) for references to save space while maintaining compatibility with GDI's analysis pipelines.
*   **Data Persistence**: The index is stored in a directory structure. This directory is portable and can be shared between users to provide immediate access to the indexed dataset without re-processing.

## Reference documentation
- [Genomics Data Index Overview](./references/anaconda_org_channels_bioconda_packages_genomics-data-index_overview.md)
- [GDI GitHub Repository and Documentation](./references/github_com_apetkau_genomics-data-index.md)
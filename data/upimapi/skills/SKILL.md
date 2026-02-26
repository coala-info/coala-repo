---
name: upimapi
description: upimapi is a bioinformatics tool that automates the high-throughput retrieval of functional annotations and ID mapping from the UniProt database, integrating with DIAMOND for sequence-based annotation. Use when user asks to annotate protein sequences, map UniProt IDs from existing alignment results, retrieve information for a list of UniProt IDs, customize output fields, fetch taxonomic lineage, or build taxon-specific DIAMOND databases.
homepage: https://github.com/iquasere/UPIMAPI
---


# upimapi

## Overview

upimapi (UniProt Id Mapping through API) is a specialized bioinformatics tool that automates the retrieval of functional information from the UniProt database. It serves as a high-throughput command-line interface for the UniProt ID mapping web service, capable of handling millions of identifiers. Beyond simple mapping, it integrates with the DIAMOND aligner to provide a seamless workflow from raw protein sequences to fully annotated functional tables, including Gene Ontology (GO) terms, pathways, and cross-references.

## Installation

Install via Bioconda:
```bash
conda install -c bioconda upimapi
```

## Common CLI Patterns

### 1. Homology-based Annotation (DIAMOND + Mapping)
To annotate protein sequences and automatically fetch UniProt metadata:
```bash
upimapi -i sequences.fasta -o output_dir -db swissprot -t 8
```
*   `-db`: Choose `uniprot` (all), `swissprot` (curated), or `taxids`.
*   `-t`: Number of threads for DIAMOND.

### 2. Mapping from Existing Results
If you already have a BLAST/DIAMOND output file (tabular format) with UniProt IDs:
```bash
upimapi -i aligned.blast -o output_dir --blast
```

### 3. Batch ID Mapping (CSV/List)
To retrieve information for a specific list of UniProt IDs provided in a comma-separated file:
```bash
upimapi -i ids.txt -o output_dir
```

### 4. Customizing Output Columns
By default, upimapi retrieves a broad set of fields (Entry, Gene Names, EC number, etc.). To request specific fields:
```bash
upimapi -i ids.txt -o output_dir --columns "Entry&Gene Names&Gene Ontology (GO)&Pathway"
```
*Note: Use `&` to separate column names within the string.*

## Expert Tips and Best Practices

*   **Taxonomy Retrieval**: upimapi allows fetching specific taxonomic levels. Use the syntax `Taxonomic lineage (LEVEL)` or `Taxonomic lineage IDs (LEVEL)`.
    *   Example: `--columns "Taxonomic lineage (PHYLUM)&Taxonomic lineage (GENUS)"`
*   **Column Validation**: If a column name is rejected, run `upimapi --show-available-columns` to see the current valid fields accepted by the UniProt API.
*   **Taxon-Specific Databases**: When the community composition is known, use `--database taxids` and `--tax-ids 9606,10090` to build a restricted DIAMOND database, significantly increasing search speed and relevance.
*   **Handling Large Datasets**: For millions of IDs, ensure a stable internet connection as the tool relies on the UniProt web API. The tool handles batching internally to prevent timeout errors.
*   **Output Files**:
    *   `uniprotinfo.tsv`: The primary results file containing the requested metadata.
    *   `aligned.blast`: The DIAMOND alignment results (if annotation was performed).
    *   `unaligned.fasta`: Sequences that failed to find a hit in the reference database.

## Reference documentation
- [upimapi GitHub README](./references/github_com_iquasere_UPIMAPI.md)
- [upimapi Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_upimapi_overview.md)
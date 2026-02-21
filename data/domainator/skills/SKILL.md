---
name: domainator
description: Domainator is a modular bioinformatics suite designed for workflows centered on protein domains and their genomic contexts.
homepage: https://github.com/nebiolabs/domainator
---

# domainator

## Overview

Domainator is a modular bioinformatics suite designed for workflows centered on protein domains and their genomic contexts. Unlike many tools that separate sequence data from annotations, Domainator utilizes the GenBank format as a primary carrier for both, ensuring data portability and consistency. It is particularly effective for "genome mining" workflows where a user needs to identify specific functional domains and then analyze the surrounding gene neighborhoods across multiple organisms or metagenomic contigs. The suite is organized into functional categories: editors (which transform GenBank files), reporters (which generate statistics or tables), and comparison/plotting tools (which create networks and trees).

## CLI Usage Patterns and Best Practices

### Core Logic: Input vs. Reference
In Domainator, the `-i` argument typically specifies the file being edited or searched, while the `-r` argument specifies the criteria (HMM profiles or reference sequences).
*   **Annotation**: `domainate.py -i unannotated.gb -r pfam-A.hmm -o annotated.gb`
*   **Searching**: `domain_search.py -i database.fasta -r query.hmm -o hits.gb`

### Chaining with Streaming
Many Domainator programs support stdin and stdout, allowing for efficient shell piping to avoid intermediate files.
*   **Pattern**: `cat input.gb | domainate.py -r ref.hmm | domain_search.py -r target.hmm > results.gb`
*   *Note*: Programs requiring multiple passes over the data do not support streaming.

### Common Workflow Examples

#### 1. Functional Annotation
Add functional hits to a set of contigs using both HMMs and protein sequences simultaneously:
`domainate.py -i contigs.gb -r pfam.hmm rebase_gold.fasta -o annotated.gb`

#### 2. Neighborhood Extraction
Extract the genomic neighborhood (e.g., 10kb flanking regions) around a specific domain hit:
`select_by_cds.py -i annotated.gb --query "Domain_Name" --flanking 10000 -o neighborhoods.gb`

#### 3. Sequence Similarity and Clustering
Deduplicate sequences based on similarity before downstream analysis:
`deduplicate_genbank.py -i input.gb --identity 0.90 -o representatives.gb`

#### 4. Comparative Analysis
Compare gene neighborhoods based on domain content using Jaccard or adjacency indexes:
`compare_contigs.py -i neighborhoods.gb -o distance_matrix.txt`

### Expert Tips
*   **HMM Subsetting**: Domainator treats HMM-profiles as first-class citizens; you can subset `.hmm` files directly within the suite to focus on specific protein families.
*   **Data Portability**: Always prefer GenBank output when moving between Domainator "editors" to ensure all metadata and domain hits are preserved for the next step.
*   **Visualization**: Use `build_ssn.py` to generate `.xgmml` files for Cytoscape when analyzing large protein families or neighborhood clusters.
*   **Help**: Every sub-program includes detailed documentation via the `-h` flag (e.g., `build_projection.py -h`).

## Reference documentation
- [Domainator GitHub Repository](./references/github_com_nebiolabs_domainator.md)
- [Bioconda Domainator Overview](./references/anaconda_org_channels_bioconda_packages_domainator_overview.md)
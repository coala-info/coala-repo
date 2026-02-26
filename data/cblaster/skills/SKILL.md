---
name: cblaster
description: cblaster detects clusters of homologous sequences that are physically co-located on a genome. Use when user asks to identify gene clusters, perform remote or local searches for genomic neighborhoods, or generate presence/absence matrices of homologous sequences.
homepage: https://github.com/gamcil/cblaster
---


# cblaster

## Overview
`cblaster` is a specialized tool designed to detect clusters of homologous sequences that are physically co-located on a genome. Unlike standard BLAST searches that return individual hits, `cblaster` parses these hits to identify instances where multiple query sequences land in close proximity within a subject genome. This is essential for researchers studying operons, gene clusters, or conserved genomic neighborhoods.

## Configuration
Before performing remote searches, you must configure `cblaster` with your email address to comply with NCBI API requirements.

```bash
cblaster config --email your.email@domain.com
```

## Common CLI Patterns

### Remote Search
To search a set of query sequences against the NCBI `nr` database remotely:
```bash
cblaster search --query_file queries.fasta
```

### Local Search
For faster processing or searching against private datasets, use local mode. This requires `diamond` to be installed and available in your PATH.
```bash
cblaster search --query_file queries.fasta --database local_db.dmnd
```

### Generating Comparative Matrices
To generate a presence/absence matrix (binary table) showing which query sequences are present in which identified clusters:
```bash
cblaster search --query_file queries.fasta --binary
```

### Filtering Results
Refine your search by setting thresholds for identity, coverage, and e-value to reduce noise in the cluster detection:
```bash
cblaster search -qf queries.fasta --min_identity 30 --min_coverage 50 --max_evalue 0.01
```

## Expert Tips
- **Genomic Context**: `cblaster` automatically fetches genomic coordinates from the NCBI Identical Protein Group (IPG) database during remote searches to determine if hits are co-located.
- **Interactive Visualizations**: Use the tool's ability to generate HTML-based interactive plots to explore gene cluster architectures visually.
- **Downstream Integration**:
    - Use **CAGEcleaner** to filter redundancy in results using ANI-based clustering.
    - Use **SyntenyQC** for filtering based on reciprocal best hits (RBH).
    - Use **blastCblast_stats** to visualize the taxonomic spread of your identified clusters.
- **Database Selection**: When performing remote searches, you can specify different NCBI databases (e.g., `refseq_protein`) to target specific subsets of genomic data.

## Reference documentation
- [cblaster GitHub Repository](./references/github_com_gamcil_cblaster.md)
- [cblaster Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cblaster_overview.md)
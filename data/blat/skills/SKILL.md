---
name: blat
description: BLAT is a high-speed sequence alignment tool designed to map DNA or protein sequences to genomic assemblies. Use when user asks to map mRNA or cDNA sequences to a genome, find genomic coordinates for sequences, or identify gene families.
homepage: https://genome.ucsc.edu/FAQ/FAQblat.html
metadata:
  docker_image: "quay.io/biocontainers/blat:36--0"
---

# blat

## Overview
BLAT (Blast-Like Alignment Tool) is a high-speed sequence alignment tool designed to quickly map sequences to genomic assemblies. Unlike BLAST, which searches a database of sequences, BLAT indexes the entire genome in memory to find matches. It is particularly effective for finding the genomic coordinates of mRNA/cDNA sequences and identifying gene families. This skill provides the necessary command-line patterns to replicate web-based results and optimize sensitivity for different sequence types.

## Command Line Usage

### Basic Alignment
The standard syntax for standalone BLAT requires a database (often in `.2bit` or `.fa` format) and a query file.
```bash
blat database.2bit query.fa output.psl
```

### Replicating Web-Based Results
To approximate the sensitivity and scoring of the UCSC Genome Browser's web interface, use the following parameters:
```bash
blat -stepSize=5 -repMatch=2253 -minScore=20 -minIdentity=0 database.2bit query.fa output.psl
```

### Common Alignment Types
- **DNA to DNA (Default):** Optimized for 95% similarity and 40+ bp length.
- **Protein to Protein:** Use `-t=prot -q=prot`. Optimized for 80% similarity and 20+ amino acids.
- **Translated DNA to Translated Protein:** Use `-t=dnax -q=prot`.
- **Translated DNA to Translated DNA:** Use `-t=dnax -q=dnax`.

### Key Parameters
- `-stepSize`: Sets the distance between nodes in the index. Smaller values (e.g., 5) increase sensitivity but use more memory and time.
- `-repMatch`: Sets the number of matches allowed for a tile before it is considered repetitive. Use a large value to find matches in repetitive regions.
- `-minScore`: Minimum score to output an alignment (default is 30).
- `-minIdentity`: Minimum sequence identity (percentage).
- `-ooc`: Use an "overused 11-mer" file (e.g., `11.ooc`) to mask highly repetitive genomic sequences and speed up the search.

## Expert Tips
- **Short Sequences:** BLAT may struggle with very short sequences (e.g., qPCR primers) that span splice sites. For these, ensure you include flanking sequences or use higher sensitivity settings (lower `stepSize`).
- **Memory Management:** DNA BLAT typically requires ~1GB of RAM for the human genome, while protein BLAT requires ~2GB. Ensure your environment has sufficient memory for the `.2bit` index.
- **Output Filtering:** Standalone BLAT results often benefit from post-processing. Use `pslReps` and `pslCDnaFilter` (from the Kent source utilities) to identify the best matches and filter out noise.
- **Coordinate Systems:** Note that BLAT uses 0-based start coordinates and 1-based end coordinates in PSL files.

## Reference documentation
- [BLAT FAQ](./references/genome_ucsc_edu_FAQ_FAQblat.html.md)
- [Bioconda BLAT Overview](./references/anaconda_org_channels_bioconda_packages_blat_overview.md)
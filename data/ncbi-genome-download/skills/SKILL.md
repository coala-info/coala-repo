---
name: ncbi-genome-download
description: This tool downloads genomic assemblies and metadata from NCBI's RefSeq or GenBank databases using command-line filters. Use when user asks to download sequences by taxonomic group, filter assemblies by quality level, fetch specific file formats like GFF or FASTA, or retrieve genomes using TaxIDs and genera.
homepage: https://github.com/kblin/ncbi-genome-download/
metadata:
  docker_image: "quay.io/biocontainers/ncbi-genome-download:0.3.3--pyh7cba7a3_0"
---

# ncbi-genome-download

## Overview
The `ncbi-genome-download` tool is a specialized CLI utility designed to bypass the complexity of navigating NCBI's FTP structure. It allows for high-throughput, filtered downloads of genomic assemblies. You should use this skill to construct precise commands for fetching sequences, annotations, and assembly reports based on taxonomic criteria (TaxIDs, genera), assembly quality (complete vs. contig), and database section (RefSeq vs. GenBank).

## Common CLI Patterns

### Basic Taxonomic Downloads
Download all bacterial RefSeq genomes in GenBank format (default):
`ncbi-genome-download bacteria`

Download multiple groups at once:
`ncbi-genome-download bacteria,viral,fungi`

### Filtering by Assembly Quality
To avoid fragmented data, filter by assembly level (e.g., only finished genomes):
`ncbi-genome-download --assembly-levels complete bacteria`

To include both complete genomes and those at the chromosome level:
`ncbi-genome-download --assembly-levels complete,chromosome bacteria`

### Selecting Specific Formats
By default, the tool downloads GenBank files. Use `--formats` to specify others:
- **FASTA DNA**: `ncbi-genome-download --formats fasta bacteria`
- **Protein Sequences**: `ncbi-genome-download --formats protein-fasta bacteria`
- **GFF Annotations**: `ncbi-genome-download --formats gff bacteria`
- **Multiple formats**: `ncbi-genome-download --formats fasta,gff,assembly-report bacteria`

### Targeted Downloads (TaxIDs and Genera)
Download by NCBI Taxonomy ID (e.g., E. coli is 562):
`ncbi-genome-download --species-taxids 562 bacteria`

Download a specific genus:
`ncbi-genome-download --genera Streptomyces bacteria`

Use a file containing a list of TaxIDs or Genera (one per line):
`ncbi-genome-download --taxids my_taxids.txt bacteria`

## Expert Tips and Best Practices

### Use Dry Runs First
Before starting a massive download, use `--dry-run` to see how many accessions match your filters:
`ncbi-genome-download --dry-run --assembly-levels complete viral`

### Parallelization
NCBI's FTP can be slow for single-threaded downloads. Use the `--parallel` flag to speed up the process:
`ncbi-genome-download --parallel 4 bacteria`

### Human-Readable Output
By default, the tool creates a nested directory structure matching the NCBI FTP. Use `--human-readable` to create a parallel directory structure with descriptive names (using symlinks):
`ncbi-genome-download --human-readable bacteria`

### RefSeq vs. GenBank
The tool defaults to the `--section refseq`. If you cannot find a specific assembly, it might only be available in GenBank:
`ncbi-genome-download --section genbank --genera "Streptomyces coelicolor" bacteria`

### Fuzzy Matching
If you are unsure of the exact organism name string used by NCBI, use the fuzzy match flag:
`ncbi-genome-download --genera coelicolor --fuzzy-genus bacteria`

## Reference documentation
- [NCBI Genome Download GitHub Repository](./references/github_com_kblin_ncbi-genome-download.md)
- [NCBI Genome Download Usage and Examples](./references/github_com_kblin_ncbi-genome-download_1.md)
---
name: bio-tradis
description: bio-tradis provides a streamlined command-line interface for fetching genomic data, extracting sequences, performing alignments, and querying taxonomic information. Use when user asks to fetch GenBank records, extract gene sequences, translate nucleotides to proteins, align sequences, generate VCF files, or query taxonomic lineages and metadata.
homepage: https://github.com/ialbert/bio
metadata:
  docker_image: "biocontainers/bio-tradis:v1.4.1dfsg-1-deb_cv1"
---

# bio-tradis

## Overview
The `bio-tradis` skill (utilizing the `bio` toolkit) provides a streamlined, "LEGO-like" interface for common bioinformatics operations. It replaces complex, multi-step "arcane incantations" with short, explicit commands designed to work together via Unix pipes. Use this skill to rapidly fetch data from public databases, extract specific gene sequences, perform alignments, and query taxonomic lineages without writing custom scripts for data retrieval or reformatting.

## Command-line Usage and Best Practices

### Data Retrieval
Fetch GenBank records directly using accession numbers.
```bash
# Fetch multiple accessions and save to a file
bio fetch NC_045512 MN996532 > genomes.gb
```

### Sequence Extraction and Conversion
The tool is highly efficient at slicing genomic data and extracting specific features.
- **Coordinate-based**: Use `--start` and `--end` to slice sequences.
- **Feature-based**: Use `--gene` to extract specific coding sequences.
- **Translation**: Use `--protein` to automatically translate nucleotide sequences to amino acids.

```bash
# Get the first 10 bases in FASTA format
bio fasta genomes.gb --end 10

# Extract the S protein sequence as a protein FASTA
bio fasta genomes.gb --gene S --protein
```

### Sequence Alignment and Variation
The tool supports stream-oriented alignment.
- **Standard Alignment**: Pipe FASTA output directly into the aligner.
- **VCF Generation**: Use the `--vcf` flag during alignment to produce variant call format output.

```bash
# Align sequences and view the first few lines
bio fasta genomes.gb --gene S --protein | bio align | head

# Generate a VCF file for specific gene variants
bio fetch NC_045512 MN996532 | bio fasta --gene S | bio align --vcf
```

### Taxonomy and Metadata
Query the NCBI taxonomy database and sample metadata.
- **Taxon**: Explore lineages or descendants using TaxIDs.
- **Meta**: Retrieve metadata for specific viral samples.

```bash
# Show the lineage for a specific TaxID
bio taxon 117565 --lineage

# Get metadata for a viral sample in human-readable format
bio meta 11138 -H
```

### Biological Terminology
Use the `explain` command to quickly define terms from Sequence Ontology or Gene Ontology.
```bash
bio explain exon
bio explain "food vacuole"
```

### Expert Tips
- **Stream Orientation**: Always look for opportunities to pipe commands. For example, `cat accessions.txt | bio fetch | bio fasta` is the preferred workflow for batch processing.
- **GFF Extraction**: Use `bio gff` to extract specific records from a GenBank file for downstream annotation tasks.
- **Taxonomy Exploration**: When exploring unknown samples, use `bio taxon [ID]` to see descendants and understand the classification hierarchy.

## Reference documentation
- [GitHub Repository: ialbert/bio](./references/github_com_ialbert_bio.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bio_overview.md)
---
name: bio-eagle
description: The bio-eagle skill leverages the bio command-line toolkit to fetch genomic records, extract biological features, and perform sequence alignments. Use when user asks to download NCBI records, convert sequences to FASTA format, extract specific genes or proteins, perform alignments, explore taxonomic lineages, or define biological ontology terms.
homepage: https://github.com/ialbert/bio
---


# bio-eagle

## Overview
The bio-eagle skill leverages the `bio` command-line toolkit to make bioinformatics tasks more intuitive and efficient. It is designed for rapid data exploration, allowing users to fetch genomic records, extract specific features (like genes or proteins), and perform alignments using simple, pipe-friendly commands. This skill is particularly useful for students, educators, and researchers who need to investigate genomic regions or viral/bacterial strains without writing complex scripts.

## Core CLI Patterns

### Data Retrieval and Conversion
Use `fetch` to download records from NCBI and `fasta` to manipulate the output.
- **Fetch by accession**: `bio fetch NC_045512 MN996532 > genomes.gb`
- **Convert to FASTA**: `bio fasta genomes.gb > sequences.fa`
- **Slice sequences**: `bio fasta genomes.gb --start 1 --end 100`
- **Extract specific genes**: `bio fasta genomes.gb --gene S`
- **Translate to protein**: `bio fasta genomes.gb --gene S --protein`

### Genomic Features and Alignment
Extract GFF records or perform quick alignments directly from the stream.
- **View GFF records**: `bio gff genomes.gb --gene S`
- **Align sequences**: `bio fasta genomes.gb --gene S | bio align`
- **Generate VCF from alignment**: `bio fasta genomes.gb --gene S | bio align --vcf`

### Taxonomy and Metadata
Explore the tree of life and sample information.
- **Taxonomic descendants**: `bio taxon 117565`
- **Full lineage**: `bio taxon 117565 --lineage`
- **Sample metadata**: `bio meta 11138 -H`

### Biological Ontology
Quickly define terms from Sequence Ontology (SO) or Gene Ontology (GO).
- **Explain term**: `bio explain exon` or `bio explain "food vacuole"`

## Expert Tips
- **Stream Orientation**: `bio` is designed for piping. You can pipe a list of accessions into fetch: `cat accessions.txt | bio fetch | bio fasta --gene S | bio align`.
- **Quick Testing**: Use `bio test` to verify the local installation and see functional usage examples in action.
- **Installation**: If the tool is missing, it is best installed via `pipx install bio` or `conda install bioconda::bio`.

## Reference documentation
- [Bio Project Overview](./references/github_com_ialbert_bio.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_bio_overview.md)
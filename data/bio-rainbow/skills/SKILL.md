---
name: bio-rainbow
description: The `bio-rainbow` skill (based on the `bio` package) provides a suite of modular, stream-oriented command-line utilities designed to make bioinformatics tasks more intuitive.
homepage: https://github.com/ialbert/bio
---

# bio-rainbow

## Overview

The `bio-rainbow` skill (based on the `bio` package) provides a suite of modular, stream-oriented command-line utilities designed to make bioinformatics tasks more intuitive. It follows a "LEGO-like" philosophy where small, specific commands are piped together to perform complex operations like fetching accessions, extracting specific genes, translating sequences, and generating alignments. This skill is particularly effective for researchers working with viral or bacterial strains who need to investigate genomic regions with high precision and minimal boilerplate.

## Core CLI Workflows

### Data Retrieval and Conversion
The primary entry point for most workflows is fetching data from NCBI and converting it to usable formats.

*   **Fetch GenBank records**: Retrieve sequences by accession number.
    ```bash
    bio fetch NC_045512 MN996532 > genomes.gb
    ```
*   **Convert to FASTA**: Extract sequences or specific sub-sections.
    ```bash
    # Get the first 100 bases
    bio fasta genomes.gb --end 100
    
    # Extract a specific gene
    bio fasta genomes.gb --gene S
    ```
*   **Protein Translation**: Translate coding sequences directly.
    ```bash
    bio fasta genomes.gb --gene S --protein
    ```

### Sequence Alignment and Variation
`bio` integrates alignment into the stream, allowing for rapid variant calling.

*   **Align and Visualize**: Pipe FASTA output directly into the aligner.
    ```bash
    bio fasta genomes.gb --gene S | bio align
    ```
*   **Generate VCF**: Create a Variant Call Format file from an alignment.
    ```bash
    bio fasta genomes.gb --gene S | bio align --vcf
    ```

### Taxonomy and Metadata
Query the NCBI taxonomy database and sample metadata.

*   **Taxonomic Lookups**: Search by TaxID to see descendants or lineage.
    ```bash
    # Show descendants
    bio taxon 117565
    
    # Show full lineage
    bio taxon 117565 --lineage
    ```
*   **Sample Metadata**: Retrieve metadata for specific viral samples.
    ```bash
    bio meta 11138 -H
    ```

### Biological Ontologies
Quickly define terms from Sequence Ontology (SO) or Gene Ontology (GO).

*   **Explain Terms**:
    ```bash
    bio explain exon
    bio explain "food vacuole"
    ```

## Expert Tips and Best Practices

1.  **Stream-Oriented Design**: Always look for opportunities to pipe. For example, if you have a file `acc.txt` with accession numbers, you can run:
    `cat acc.txt | bio fetch | bio fasta --gene S | bio align --vcf`
2.  **GFF Extraction**: Use `bio gff` to inspect the annotation records for specific genes before extracting them with `bio fasta`.
    `bio gff genomes.gb --gene S`
3.  **Installation**: For the most stable environment, install via `pipx` to keep dependencies isolated: `pipx install bio`.
4.  **Exploratory Analysis**: Use `head` at the end of long pipes to verify the output format before processing entire genomes.

## Reference documentation
- [bio: making bioinformatics fun again](./references/github_com_ialbert_bio.md)
- [bioconda bio overview](./references/anaconda_org_channels_bioconda_packages_bio_overview.md)
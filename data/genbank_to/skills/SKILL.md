---
name: genbank_to
description: The genbank_to tool extracts specific genomic components such as sequences, ORFs, and functional tables from GenBank records into various standardized bioinformatics formats. Use when user asks to extract nucleotide or protein sequences, generate GFF3 or functional tables, split multi-record GenBank files, or prepare data for AMR Finder Plus and Bakta.
homepage: https://github.com/linsalrob/genbank_to
---


# genbank_to

## Overview
The `genbank_to` tool is a specialized utility designed to bridge the gap between GenBank records and various bioinformatics pipelines. It excels at batch-extracting specific components of a genomic record—such as whole genomes, open reading frames (ORFs), or amino acid sequences—into standardized formats. It is particularly useful for preparing data for tools like AMR Finder Plus, Bakta, or phage analysis workflows.

## Command Line Usage

The basic syntax requires an input GenBank file (via `-g`) and at least one output flag.

### Core Extraction Patterns
*   **Whole Genome (Nucleotide):** Use `-n` to extract the full DNA sequence.
    `genbank_to -g input.gbk -n output.fna`
*   **Protein Sequences:** Use `-a` to extract amino acids for all ORFs.
    `genbank_to -g input.gbk -a output.faa`
*   **ORF Sequences (Nucleotide):** Use `-o` to extract the DNA sequences of the ORFs.
    `genbank_to -g input.gbk -o output.orfs`
*   **Functional Tables:** Use `-f` to generate a tab-separated file of protein IDs and their functions.
    `genbank_to -g input.gbk -f functions.tsv`

### Specialized Formats
*   **GFF3:** Generate standard genomic features format.
    `genbank_to -g input.gbk --gff3 output.gff3`
*   **Bakta JSON:** Create JSON files compatible with Bakta.
    `genbank_to -g input.gbk --bakta-json output.json --gram + --translation-table 11`
*   **AMR Finder Plus:** Use `--amr` to generate the specific file set (GFF, FAA, FNA) required for antimicrobial resistance detection.

## Expert Tips and Best Practices

### Handling Multi-Record Files
If your GenBank file contains multiple sequence records (delimited by `//`), use the `--separate` flag. 
*   **Without other flags:** Splits one multi-GenBank file into individual GenBank files.
*   **With extraction flags:** Writes the extracted data (e.g., `-a`) into separate files for each record.

### Filtering by Sequence ID
If a GenBank file contains multiple contigs or chromosomes but you only need one, use the `-i` or `--seqid` flag to target specific records by their identifier.

### Managing Pseudogenes
By default, `genbank_to` skips pseudogenes to avoid translation errors. If you require their inclusion in amino acid outputs, add the `--pseudo` flag, though be aware that Biopython may still reject sequences with internal stop codons or frame shifts.

### Batch Processing
You can request multiple output formats in a single command execution to save processing time:
`genbank_to -g input.gbk -n genome.fna -a proteins.faa --gff3 features.gff3`

## Reference documentation
- [genbank_to GitHub Repository](./references/github_com_linsalrob_genbank_to.md)
- [genbank_to Overview and Installation](./references/anaconda_org_channels_bioconda_packages_genbank_to_overview.md)
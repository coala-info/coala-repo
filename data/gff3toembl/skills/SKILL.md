---
name: gff3toembl
description: gff3toembl converts Prokka-generated GFF3 files into the EMBL flat-file format required for genome submissions. Use when user asks to convert GFF3 files to EMBL format, prepare annotated genomes for ENA submission, or format feature tables and metadata for EMBL/GenBank.
homepage: https://github.com/sanger-pathogens/gff3toembl/
metadata:
  docker_image: "quay.io/biocontainers/gff3toembl:1.1.4--pyh864c0ab_2"
---

# gff3toembl

## Overview
gff3toembl is a specialized conversion utility designed to bridge the gap between Prokka-generated GFF3 files and the strict EMBL flat-file submission format. It automates the formatting of feature tables, sequence data, and mandatory metadata—such as project accessions and taxon IDs—into a single .embl file. This tool is not a generic GFF3 converter; it implements EMBL-specific conventions and is used to prepare a significant portion of annotated genomes submitted to EMBL/GenBank.

## Usage Instructions

### Basic Command Structure
The tool requires five positional arguments followed by optional flags for metadata.

```bash
gff3_to_embl [options] <organism> <taxonid> <project_accession> <description> <input_gff>
```

### Common CLI Pattern
For a standard submission, include author and publication details to populate the RA (Reference Author), RT (Reference Title), and RL (Reference Location) lines:

```bash
gff3_to_embl \
    --authors 'Smith J., Doe J.' \
    --title 'Complete genome sequence of Organism X' \
    --publication 'Journal of Bioinformatics' \
    --genome_type circular \
    --classification PROK \
    --output_filename output.embl \
    "Organism name" 12345 PRJEB00000 "Genus species strain" input.gff
```

### Parameter Best Practices
- **Organism & Taxon ID**: Ensure the `taxonid` matches the official NCBI/ENA Taxonomy database ID for the `organism` string provided.
- **Project Accession**: This must be the study accession (e.g., PRJEBXXXXX) assigned by ENA.
- **Genome Type**: Explicitly set `--genome_type circular` for finished bacterial chromosomes or `linear` for scaffolds/contigs.
- **Locus Tags**: If your GFF3 file contains temporary locus tags, use `--locus_tag <PREFIX>` to overwrite them with your ENA-registered locus tag prefix.
- **Translation Tables**: Use `--translation_table 11` for most bacteria and archaea.
- **Chromosome Lists**: For multi-fasta/multi-contig GFF3 files, use `--chromosome_list <filename>` to generate the required chromosome list file for ENA submission.

### Expert Tips
- **Prokka Compatibility**: This tool is specifically optimized for GFF3 files produced by Prokka. Using GFF3 files from other pipelines may require manual adjustment of feature types to ensure compatibility.
- **Line Wrapping**: The tool automatically handles EMBL's strict 80-character line wrapping requirements for feature descriptions and sequences.
- **Validation**: gff3toembl is a converter, not a validator. Always run the ENA Webin-CLI validator on the resulting EMBL file before attempting a final submission.
- **Dependencies**: Ensure `genometools` (with Python bindings) is installed in your environment, as the tool relies on it for parsing GFF3 structures.

## Reference documentation
- [gff3toembl GitHub Repository](./references/github_com_sanger-pathogens_gff3toembl.md)
- [Bioconda gff3toembl Overview](./references/anaconda_org_channels_bioconda_packages_gff3toembl_overview.md)
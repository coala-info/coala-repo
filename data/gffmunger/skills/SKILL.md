---
name: gffmunger
description: gffmunger restructures GFF3 files by transferring functional annotations from polypeptide features to their parent mRNA or transcript features. Use when user asks to fix GFF3 feature relationships for WebApollo, move annotations from polypeptides to transcripts, or prepare Chado database exports for annotation platforms.
homepage: https://github.com/sanger-pathogens/gffmunger
---


# gffmunger

## Overview
gffmunger is a specialized bioinformatics utility designed to bridge the gap between GMOD/Chado database exports and the WebApollo annotation platform. Chado often exports GFF3 files where functional annotations (like Gene Ontology terms or protein metadata) are attached to "polypeptide" features. WebApollo, however, typically requires these annotations to be associated with the parent "mRNA" or "transcript" features. This tool automates that restructuring process.

## CLI Usage and Patterns

### Basic Transformation
The most common use case is running the default munging command to fix feature relationships.
```bash
gffmunger --input chado_export.gff3 --output webapollo_ready.gff3
```

### Handling Compressed Inputs and Streams
gffmunger supports gzipped input files and standard streams, making it easy to integrate into shell pipelines.
```bash
# Using gzipped input
gffmunger --input export.gff3.gz --output output.gff3

# Using pipes
zcat export.gff3.gz | gffmunger > output.gff3
```

### Managing FASTA Data
WebApollo often requires the underlying genomic sequence. If your GFF3 file does not contain the `##FASTA` section, you can provide an external FASTA file.
```bash
gffmunger --input input.gff3 --fasta genome.fasta --output output.gff3
```
*Note: If `--fasta` is omitted, the tool will automatically attempt to read FASTA data if it is embedded at the end of the input GFF3 file.*

### Available Commands
While `move_polypeptide_annot` is the default behavior, you can explicitly specify commands:
*   `move_polypeptide_annot`: Transfers annotations (attributes) from polypeptide features to the feature from which the polypeptide derives (usually the mRNA).

## Expert Tips
*   **Verbosity**: Use the `--verbose` flag when debugging complex Chado exports to see exactly which features are being modified.
*   **Configuration**: The tool looks for a configuration file at `/etc/gffmunger/gffmunger-config.yml`. If you are running in a restricted environment or a container, you can specify a custom config path using the `GFFMUNGER_CONFIG` environment variable.
*   **Quiet Mode**: Use `--quiet` in automated production pipelines to suppress all output except for critical errors.

## Reference documentation
- [GFF munger README](./references/github_com_sanger-pathogens_gffmunger.md)
- [gffmunger Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gffmunger_overview.md)
---
name: gffmunger
description: gffmunger restructures GFF3 data by moving annotations from the polypeptide level to the mRNA level to ensure compatibility between Chado database exports and WebApollo. Use when user asks to munge GFF files, move polypeptide annotations to mRNA, or prepare Chado exports for WebApollo.
homepage: https://github.com/sanger-pathogens/gffmunger
---

# gffmunger

## Overview

gffmunger is a specialized utility designed to bridge the gap between Chado database exports and WebApollo requirements. Its primary function is to restructure GFF3 data, specifically by moving annotations (like functional descriptions or GO terms) from the `polypeptide` level—where Chado often stores them—up to the `mRNA` level, which is required for proper display and editing in WebApollo.

## Usage Guidelines

### Basic Command Structure

The tool follows a simple command-based syntax. You can chain multiple commands if necessary, though `move_polypeptide_annot` is the primary and default operation.

```bash
gffmunger [command] --input <input.gff3> --output <output.gff3>
```

### Common CLI Patterns

- **Standard Transformation**: To process a Chado export for WebApollo:
  ```bash
  gffmunger move_polypeptide_annot --input chado_export.gff3 --output webapollo_ready.gff3
  ```

- **Handling Compressed Inputs**: The tool can natively read gzipped GFF3 files:
  ```bash
  gffmunger move_polypeptide_annot --input chado_export.gff3.gz --output processed.gff3
  ```

- **External FASTA Integration**: If the FASTA sequence is not embedded in the GFF3 file (after the `##FASTA` directive), provide it explicitly:
  ```bash
  gffmunger move_polypeptide_annot --input input.gff3 --fasta sequence.fasta --output output.gff3
  ```

- **Pipe-based Workflows**: Use standard streams for integration into larger bioinformatics pipelines:
  ```bash
  cat export.gff3 | gffmunger move_polypeptide_annot > processed.gff3
  ```

### Expert Tips

- **Default Command**: If no command is specified, `move_polypeptide_annot` is executed by default.
- **Logging**: Use `--verbose` to debug transformation issues or `--quiet` to suppress all output except errors during automated batch processing.
- **Configuration**: The tool looks for a `gffmunger-config.yml` for specific mapping logic. You can override the default config path by setting the `GFFMUNGER_CONFIG` environment variable.
- **GenomeTools Dependency**: Ensure `genometools` (specifically the `gt` binary) is in your PATH, as gffmunger relies on it for GFF3 validation and processing.



## Subcommands

| Command | Description |
|---------|-------------|
| gffmunger | Munges GFF files. Use one or more of the following commands: |
| gffmunger | Munges GFF files. Use one or more of the following commands: |

## Reference documentation

- [GFF munger README](./references/github_com_sanger-pathogens_gffmunger_blob_master_README.md)
- [GFF munger Config Schema](./references/github_com_sanger-pathogens_gffmunger_blob_master_gffmunger-config.yml.md)
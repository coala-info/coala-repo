---
name: mikado
description: Mikado is a Python-based pipeline that consolidates multiple transcript assemblies into a single, high-quality gene annotation by scoring and selecting the most biologically relevant models. Use when user asks to consolidate transcript assemblies, pick the best gene models from multiple assemblers, or generate a non-redundant set of gene annotations.
homepage: https://github.com/lucventurini/mikado
metadata:
  docker_image: "quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2"
---

# mikado

## Overview

Mikado is a Python-based discovery and selection pipeline designed to consolidate multiple transcript assemblies into a single, high-quality gene annotation. It works by grouping overlapping transcripts into "superloci," which are then refined into "subloci" based on shared splicing junctions. The tool evaluates each transcript using up to 50 different metrics—including coding sequence (CDS) length, UTR properties, and homology data—to pick the most biologically relevant model for each locus. It is an essential tool for researchers performing genome annotation who want to integrate results from different assemblers (like StringTie, Trinity, or Scallop) into a non-redundant set of gene models.

## Core Workflow

The standard Mikado workflow consists of four primary stages:

1.  **Prepare**: Standardize input GTF/GFF3 files and identify ORFs.
2.  **Serialise**: Load the transcripts and external metadata (BLAST, junctions) into a SQLite database.
3.  **Pick**: Score and select the best transcripts for each locus.
4.  **Util**: Generate statistics or convert formats.

## Common CLI Patterns

### 1. Configuration Generation
Before running the pipeline, generate a template configuration file (now using TOML by default in version 2.x).
```bash
mikado configure --list-metrics  # View available scoring metrics
mikado configure configuration.toml
```

### 2. Preparing Input Data
Standardize your transcript assemblies. This step ensures all input files follow the same naming conventions and format requirements.
```bash
mikado prepare --json-conf configuration.toml --out mikado_prepared.gtf
```

### 3. Serializing Data
Load your prepared transcripts, along with optional but recommended evidence like TransDecoder ORF predictions and BLAST homology results, into the Mikado database.
```bash
mikado serialise --json-conf configuration.toml --xml blast_results.xml --orfs transdecoder.pep
```

### 4. Picking the Best Models
This is the execution phase where Mikado scores transcripts and defines the final loci.
```bash
mikado pick --json-conf configuration.toml --subloci --out mikado_final.gff3
```

## Expert Tips and Best Practices

*   **Input Sorting**: While Mikado 2.2.0+ can handle unsorted files, it is a best practice to provide coordinate-sorted GTF/GFF3 files to ensure optimal performance during the "superlocus" definition phase.
*   **Junction Evidence**: Use junction confidence data from tools like Portcullis. You can provide these in BED12 format to help Mikado validate splice sites and penalize transcripts with unsupported introns.
*   **Homology Scoring**: Always include BLASTX or DIAMOND results if available. Homology is one of the strongest indicators of a "correct" transcript, especially when distinguishing between real genes and assembly artifacts.
*   **Monoexonic vs. Multiexonic**: Mikado treats these differently. Multiexonic transcripts are grouped by shared junctions, while monoexonic transcripts are grouped by base-pair overlap. Ensure your scoring file reflects the priority you want to give to spliced models over single-exon models.
*   **Random Seeds**: By default, Mikado uses a static seed for reproducibility. If you need to test the robustness of the selection process, use the `--random-seed` flag.
*   **Database Management**: The SQLite database created during `serialise` can become large. Use `mikado util stats` to verify the contents of your annotation files before and after the picking process.



## Subcommands

| Command | Description |
|---------|-------------|
| Mikado compare | Compare predictions to a reference annotation. |
| Mikado util | Mikado util |
| mikado configure | Configuration utility for Mikado |
| mikado_pick | Launcher of the Mikado pipeline. |
| mikado_prepare | Prepare input files for Mikado. |
| mikado_serialise | Serialise Mikado database |

## Reference documentation

- [Mikado - pick your transcript: a pipeline to determine and select the best RNA-Seq prediction](./references/github_com_lucventurini_mikado.md)
- [Mikado Description and Logic](./references/github_com_lucventurini_mikado_blob_master_DESCRIPTION.md)
- [Mikado Changelog and Version History](./references/github_com_lucventurini_mikado_blob_master_CHANGELOG.md)
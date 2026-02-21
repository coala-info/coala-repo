---
name: pasa
description: PASA (Program to Assemble Spliced Alignments) is a specialized pipeline designed to bridge the gap between transcriptomic data and genomic annotation.
homepage: https://pasapipeline.github.io/
---

# pasa

## Overview
PASA (Program to Assemble Spliced Alignments) is a specialized pipeline designed to bridge the gap between transcriptomic data and genomic annotation. It excels at taking raw transcript alignments—typically from tools like GMAP or BLAT—and processing them into coherent gene models. Use this tool to automatically refine gene structures, validate splice sites, and classify complex splicing events to ensure your genome annotation remains consistent with experimental evidence.

## Core Workflow and CLI Patterns

### 1. Configuration Setup
PASA requires a configuration file (typically `alignAssembly.config`) to manage database connections (MySQL/SQLite) and processing parameters.
- **Database**: Ensure the `DATABASE` parameter is unique for each project to avoid overwriting previous assemblies.
- **Template**: Copy the default template from the PASA installation directory before modifying.

### 2. Alignment Assembly Pipeline
The primary entry point is `Launch_PASA_pipeline.pl`. A standard execution involves:
- `-g`: Genomic FASTA file.
- `-t`: Transcript (cDNA/EST) FASTA file.
- `-c`: The configuration file.
- `-C -R`: Flags to create a new database and run the alignment/assembly.

```bash
Launch_PASA_pipeline.pl -g genome.fasta -t transcripts.fasta -c alignAssembly.config -C -R --ALIGNER gmap
```

### 3. Annotation Comparison and Updates
To update an existing annotation (e.g., from Augustus or Maker) with PASA-derived models:
- Use `PASA_Update_Manager.pl` or the `-A` flag in the main pipeline.
- Input must be in GFF3 format.
- This process identifies "failed" gene models where transcripts suggest a different structure than the current annotation.

### 4. Functional Annotation and Splicing Analysis
- **Alternative Splicing**: Run `pasa_asmbls_to_training_set.pl` to extract high-quality models for training gene predictors.
- **Comprehensive Analysis**: Use `classify_alt_splicing_variants.pl` to categorize events like exon skipping, intron retention, and alternative 3'/5' splice sites.

## Best Practices
- **Transcript Cleaning**: Always vector-trim and quality-filter your transcript sequences before running PASA to prevent chimeric assemblies.
- **Aligner Choice**: GMAP is generally preferred for its accuracy with splice sites, though BLAT is supported.
- **Memory Management**: For large transcript datasets, use the `--CPU` flag to parallelize the alignment step.
- **GFF3 Validation**: Ensure your input GFF3 files are strictly valid; PASA is sensitive to formatting errors in the attributes column.

## Reference documentation
- [PASA Overview](./references/anaconda_org_channels_bioconda_packages_pasa_overview.md)
- [PASA Pipeline Wiki](./references/pasapipeline_github_io_index.md)
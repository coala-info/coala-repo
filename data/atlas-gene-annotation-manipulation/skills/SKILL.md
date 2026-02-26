---
name: atlas-gene-annotation-manipulation
description: This tool extracts and reformats metadata from GTF files to create custom annotation tables and synchronize sequence files. Use when user asks to generate gene-to-symbol mappings, create transcript-to-gene files for quantification tools, synchronize cDNA FASTA files with annotations, or flag mitochondrial features.
homepage: https://github.com/ebi-gene-expression-group/atlas-gene-annotation-manipulation
---


# atlas-gene-annotation-manipulation

## Overview
The `atlas-gene-annotation-manipulation` tool provides a robust mechanism for extracting and reformatting metadata from Gene Transfer Format (GTF) files. Its primary utility lies in its ability to create custom annotation tables, such as gene-to-symbol or transcript-to-gene mappings, while ensuring consistency between sequence files (FASTA) and annotation records. This is particularly critical in single-cell and bulk RNA-seq workflows where mismatched identifiers between a transcriptome and a GTF file can cause pipeline failures.

## Common CLI Patterns

### 1. Generating Gene-to-Symbol Mappings
To create a simple lookup table for downstream visualization or differential expression analysis:
```bash
gtf2featureAnnotation.R \
  --gtf-file input.gtf \
  --feature-type "gene" \
  --fields "gene_id,gene_name" \
  --first-field "gene_id" \
  --output-file gene_metadata.txt
```

### 2. Creating Transcript-to-Gene (T2G) Mappings
Essential for tools like Salmon or Kallisto. Use `--version-transcripts` if your GTF contains versioned identifiers (e.g., ENST000001.1) to ensure they match the transcriptome FASTA.
```bash
gtf2featureAnnotation.R \
  --gtf-file input.gtf \
  --feature-type "transcript" \
  --fields "transcript_id,gene_id" \
  --version-transcripts \
  --no-header \
  --output-file t2g_mapping.txt
```

### 3. Synchronizing cDNA FASTA with Annotations
If your FASTA file contains transcripts not present in your GTF (or vice versa), use this pattern to filter the FASTA and generate a matching mapping file simultaneously.
```bash
gtf2featureAnnotation.R \
  --gtf-file input.gtf \
  --parse-cdnas reference_cdna.fasta \
  --parse-cdna-field "transcript_id" \
  --filter-cdnas-output filtered_cdna.fasta \
  --output-file synchronized_annotation.txt
```

### 4. Marking Mitochondrial Features
Useful for Quality Control (QC) steps to flag mitochondrial genes based on chromosome name or biotype.
```bash
gtf2featureAnnotation.R \
  --gtf-file input.gtf \
  --mito \
  --mito-chr "MT" \
  --mito-biotypes "mt_gene,mt_rRNA,mt_tRNA" \
  --output-file annotations_with_mito_flag.txt
```

## Expert Tips

*   **Handling Ensembl Inconsistencies**: Ensembl FASTA headers often contain extra metadata. Use `--parse-cdna-names` to attempt to extract annotation info directly from the FASTA headers when the GTF and FASTA are not perfectly aligned.
*   **Preventing Empty Fields**: When generating mappings for sensitive tools like Alevin, use `--fill-empty <field_name>` (e.g., `--fill-empty gene_id`) to ensure that if a specific attribute is missing for a record, it is populated with a fallback value rather than left blank.
*   **Feature Selection**: While "gene" and "transcript" are the most common `--feature-type` values, you can use any valid feature type present in the 3rd column of your GTF (e.g., "exon", "CDS").
*   **Header Management**: Use `--no-header` when the output is intended for direct input into tools that expect raw, tab-delimited data without column titles.

## Reference documentation
- [README Gene annotation manipulation](./references/github_com_ebi-gene-expression-group_atlas-gene-annotation-manipulation_blob_develop_README.md)
- [atlas-gene-annotation-manipulation - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_atlas-gene-annotation-manipulation_overview.md)
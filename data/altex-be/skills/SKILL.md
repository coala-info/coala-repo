---
name: altex-be
description: Use when designing single guide RNAs (sgRNAs) for targeted exon skipping using Base Editing (ABE or CBE). This skill is applicable for identifying targetable exons (Skipped Exons, Alternative Splice Sites), designing candidates for specific base editors, and evaluating off-target risks in genomic research.
---

# altex-be

Bioinformatics tool for automated sgRNA design for exon skipping via Base Editing.

## Core Workflow

The tool identifies targetable exons from transcript data and designs sgRNAs based on the editing window of specific Base Editors (BE).

### Required Inputs
- **Transcript Data**: Path to a `refFlat` file or `GTF` file.
- **Genome Sequence**: Path to a `FASTA` file containing all chromosomes for the target species.
- **Target**: Gene symbols (e.g., `DMD`) or RefSeq IDs (e.g., `NM_000109`).
- **Assembly**: Name of the genome assembly (e.g., `hg38`, `mm39`).

## Common CLI Patterns

### 1. Using Preset Base Editors
By default, AltEx-BE uses 6 built-in presets (Target-AID, BE4max, ABE8e with NGG/NG PAMs).
```bash
altex-be \
  --refflat-path ./hg38_refFlat.txt \
  --fasta-path ./hg38.fa \
  --output-dir ./results \
  --gene-symbols MYGENE \
  --assembly-name hg38
```

### 2. Custom Base Editor Configuration
Define a specific editor by providing its PAM and editing window.
- **Note**: The editing window is 1-indexed, counted from the base immediately adjacent to the PAM.
```bash
altex-be \
  --gtf-path ./annotations.gtf \
  --fasta-path ./genome.fa \
  --output-dir ./output \
  --gene-symbols MYGENE \
  --assembly-name hg38 \
  --be-name custom_cbe \
  --be-type cbe \
  --be-pam NGG \
  --be-start 17 \
  --be-end 19
```

### 3. Batch Processing
For multiple genes or multiple editors, use input files instead of space-separated lists.
- **Gene File**: A single-column file (CSV/TXT/TSV) with symbols or IDs (no header).
- **Editor File**: A CSV/TSV/TXT with columns: `base_editor_name`, `pam_sequence`, `editing_window_start`, `editing_window_end`, `base_editor_type`.

```bash
altex-be \
  --refflat-path ./refFlat.txt \
  --fasta-path ./genome.fa \
  --output-dir ./batch_results \
  --gene-file ./interesting_genes.txt \
  --be-files ./my_editors.csv \
  --assembly-name hg38
```

## Expert Tips & Constraints

- **GTF Conversion**: If a GTF is provided via `--gtf-path`, the tool automatically converts it to refFlat format in the output directory.
- **Chromosome Matching**: Ensure the FASTA file contains all chromosomes referenced in the transcript file; otherwise, the process will fail.
- **Transcript Logic**: Providing a Gene Symbol analyzes all known transcripts for that gene. Providing a RefSeq ID identifies the parent gene and analyzes all associated transcripts to ensure comprehensive splicing analysis.
- **Off-target Analysis**: The tool performs 12mer+PAM off-target risk assessment by default.
- **Output**: Review the generated reports to rank candidates based on the "In-frame" summary and off-target scores.
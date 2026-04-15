---
name: panisa
description: panISa performs ab initio identification and annotation of insertion sequences in bacterial genomes using short-read resequencing data. Use when user asks to detect insertion sequences from BAM files, validate IS families using ISFinder, or annotate the genomic location of identified insertions.
homepage: https://github.com/bvalot/panISa
metadata:
  docker_image: "quay.io/biocontainers/panisa:0.1.7--pyhdfd78af_0"
---

# panisa

## Overview

panISa (pan-Insertion Sequence analysis) is a specialized tool for the ab initio identification of insertion sequences in bacterial genomes using short-read resequencing data. Unlike database-dependent methods, panISa identifies IS signatures by analyzing clipped reads at potential insertion boundaries. It reconstructs the beginning of both sides of the IS (Inverted Repeat Left and Right) and validates the insertion by searching for inverted repeat regions. The workflow typically involves initial detection, homology validation via ISFinder, and final genomic annotation.

## Core Workflow and CLI Patterns

### 1. Ab Initio IS Detection
The primary script `panISa.py` processes a BAM file to find potential insertion sites.

```bash
# Basic usage
python panISa.py input.bam > panisa_results.tsv

# High-sensitivity run for low coverage data
# -m 5: reduces minimum clipped reads required to 5
# -q 15: lowers mapping quality threshold for clipped reads
python panISa.py -m 5 -q 15 -o sensitive_results.tsv input.bam
```

**Key Parameters:**
- `-q`: Minimum alignment quality for clipped reads (default: 20).
- `-m`: Minimum number of clipped reads at a position to trigger IS detection (default: 10).
- `-s`: Maximum size of the direct repeat region (default: 20bp).
- `-p`: Minimum base identity percentage for consensus reconstruction (default: 0.8).

### 2. Homology Validation
Use `ISFinder_search.py` to compare panISa results against the ISFinder database to identify IS families.

```bash
# Search ISFinder with default thresholds
python ISFinder_search.py panisa_results.tsv > isfinder_matches.tsv

# Stringent homology search
# -i 95: 95% identity
# -a 90: 90% alignment coverage
python ISFinder_search.py -i 95 -a 90 panisa_results.tsv > stringent_matches.tsv
```

### 3. Functional Annotation
Use `annotateISresult.py` to determine if identified IS are located within or near specific genomic features (e.g., CDS).

```bash
# Annotate results with a GFF3 file
python annotateISresult.py isfinder_matches.tsv genome_annotation.gff > final_annotation.tsv

# Target specific features other than CDS
python annotateISresult.py -f rRNA isfinder_matches.tsv genome_annotation.gff
```

## Expert Tips and Best Practices

- **Alignment Compatibility**: panISa is specifically optimized for alignments produced by **BWA**. Using other aligners may result in different clipping behaviors that could affect detection sensitivity.
- **Coverage Calibration**: The default `-m 10` is suitable for standard 50x-100x coverage. For very high coverage datasets, increase `-m` to reduce false positives; for low coverage (<30x), decrease `-m`.
- **Direct Repeat (DR) Analysis**: If you suspect long DRs (common in certain IS families), increase the `-s` parameter beyond the default 20bp.
- **Validation Logic**: The `ISFinder_search.py` script classifies hits as "one side" or "two side" matches. "Two side" matches (where both IRL and IRR match the same IS family) are significantly higher confidence.
- **Input Requirements**: Ensure the BAM file is indexed (`.bai` file present) and that the `emboss` package is installed in your environment, as panISa relies on it for sequence analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| panISa.py | Search integrative element (IS) insertion on a genome using BAM alignment |
| panisa_ISFinder_search.py | automate search IS homology in ISFinder from panISa output |

## Reference documentation
- [panISa Main Documentation](./references/github_com_bvalot_panISa_blob_master_README.rst.md)
- [ISFinder Search Tool](./references/github_com_bvalot_panISa_blob_master_ISFinder_search.py.md)
- [Annotation Tool](./references/github_com_bvalot_panISa_blob_master_annotateISresult.py.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_panisa_overview.md)
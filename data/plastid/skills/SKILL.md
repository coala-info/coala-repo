---
name: plastid
description: Plastid is a toolkit for high-resolution analysis of sequencing data that maps read alignments to specific functional sites like the ribosomal P-site. Use when user asks to estimate P-site offsets, generate metagene profiles, quantify gene expression and translation efficiency, or create visualization track files.
homepage: http://plastid.readthedocs.io/en/latest/
metadata:
  docker_image: "quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2"
---

# plastid

## Overview

Plastid is a specialized toolkit designed for high-resolution analysis of sequencing data where the exact position of a read (down to the nucleotide) carries biological meaning. Unlike general-purpose genomic tools, plastid excels at "mapping" read alignments to specific functional sites—such as the ribosomal P-site—using configurable mapping rules. It is the primary tool for processing ribosome profiling data to study translation efficiency and kinetics, as well as RNA structure probing assays like DMS-seq.

## Core Command-Line Patterns

### 1. Ribosome Profiling: P-site Offset Estimation
Before quantifying translation, you must determine the distance from the 5' end of a read to the ribosomal P-site.
```bash
# Estimate P-site offsets based on start codons
psite <alignment_file.bam> <output_prefix> --ann_file <annotation.gtf> --min_length 25 --max_length 35
```
*Expert Tip:* Use the resulting `.txt` file as input for the `--offset` parameter in other plastid scripts.

### 2. Metagene Analysis
Visualize read density relative to genomic landmarks (e.g., start/stop codons).
```bash
# Generate a metagene profile around start codons
metagene generate <output_prefix> --ann_file <annotation.gtf> --landmark start_codon --upstream 50 --downstream 50

# Count reads in those regions
metagene count <output_prefix>_rois.txt --count_files <alignment.bam> --fiveprime_variable <psite_offsets.txt> > <results.txt>
```

### 3. Quantifying Gene Expression and Density
Calculate RPKM and raw counts for transcripts or specific sub-regions (5' UTR, CDS, 3' UTR).
```bash
# Calculate counts and RPKM for all genes
cs count <annotation.gtf> <sample_name> --count_files <alignment.bam> --fiveprime_variable <psite_offsets.txt>
```

### 4. Generating Visualization Files
Create track files (Wiggle/bedGraph) that reflect your specific mapping rules for use in IGV.
```bash
# Create a P-site mapped wiggle file
make_wiggle --count_files <alignment.bam> --fiveprime_variable <psite_offsets.txt> --output <sample_psite>
```

## Mapping Rules Reference
Plastid uses specific flags to define how a read alignment is converted into a single data point:
- `--fiveprime`: Maps to the 5' end (plus an optional fixed `--offset`).
- `--fiveprime_variable`: Maps to an offset that changes based on read length (required for Ribo-seq).
- `--threeprime`: Maps to the 3' end.
- `--center`: Distributes the count across the read (useful for standard RNA-seq).

## Expert Tips & Troubleshooting
- **Argument Order:** Plastid is sensitive to argument order. Always place required positional arguments (like input files and sample names) before optional flags, or use `--` to separate them.
- **Zero Counts:** If `cs` or `counts_in_region` reports zero counts despite visible alignments in IGV, verify your `--offset` or mapping rule. A read is only counted if its *mapped* position falls within the feature boundaries.
- **Memory Efficiency:** For large genomes, prefer indexed formats. Use `BAM` for alignments and `BigWig`/`BigBed` for quantitative data and annotations.
- **Strandedness:** For dUTP or stranded kits, ensure you are counting the correct strand. If data is antisense, you may need to reverse-complement the FASTQ before alignment or use specific samtools filters.



## Subcommands

| Command | Description |
|---------|-------------|
| counts_in_region | Count the number of read alignments covering regions of interest in the genome, and calculate read densities (in reads per nucleotide and in RPKM) over these regions. |
| phase_by_size | Estimate sub-codon phasing in a ribosome profiling dataset, stratified by read length. |

## Reference documentation
- [Read mapping functions](./references/plastid_readthedocs_io_en_latest_concepts_mapping_rules.html.md)
- [List of command-line scripts](./references/plastid_readthedocs_io_en_latest_generated_plastid.bin.html.md)
- [Frequently asked questions](./references/plastid_readthedocs_io_en_latest_FAQ.html.md)
- [Glossary of terms](./references/plastid_readthedocs_io_en_latest_glossary.html.md)
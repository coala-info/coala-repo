---
name: imseq
description: The `imseq` skill enables the processing of immunogenetic sequencing data to derive repertoire distributions.
homepage: http://www.imtools.org/
---

# imseq

## Overview
The `imseq` skill enables the processing of immunogenetic sequencing data to derive repertoire distributions. It handles single-end and paired-end reads, performing alignment against V and J segment references while accounting for sequencing artifacts. Use this skill to automate the transition from raw NGS reads to quantified clonotype lists, applying quality filters and barcode-based clustering to ensure accurate immunological analysis.

## Core Command Patterns

### Single-End Analysis
For reads covering the V-CDR3-J region:
```bash
imseq -ref <segments.fa> -o <results.tsv> <input.fastq.gz>
```

### Paired-End Analysis
When one read covers the V-region and the other covers the J/CDR3 region:
```bash
imseq -ref <segments.fa> -o <results.tsv> <V-reads.fq> <VDJ-reads.fq>
```

### Output Options
You must specify at least one output type:
- `-o <file>`: Detailed per-read clonotyping (ID, CDR3 positions, segment matches, nucleotide/AA sequences).
- `-on <file>`: Nucleotide-based clonotype counts.
- `-oa <file>`: Amino acid-based clonotype counts.

## Expert Configuration & Best Practices

### Reference Data Preparation
The reference FASTA file must follow a strict ID format: `Gene|Type|SegmentID|AlleleID|CysPosition`.
Example: `>TRB|V|9|02|270`

### Error Correction & Clustering
To improve accuracy in low-quality runs, use clustering instead of aggressive filtering:
- **Quality-based clustering**: `-qc` (rescues erroneous reads by merging them with high-confidence clusters).
- **Segment ambiguity clustering**: `-ma` (merges clonotypes with ambiguous segment assignments).
- **Simple distance clustering**: `-sc` (merges based on edit distance).

### Handling Barcodes (UMIs)
If your library uses Unique Molecular Identifiers (UMIs) to correct PCR bias:
1. Define barcode length: `-bcl 10`
2. Specify barcode-corrected output: `-oab <file>` (amino acid) or `-onb <file>` (nucleotide).
3. Adjust error tolerance: `-bse <num>` (max errors allowed in barcode sequence).

### Performance Tuning
- **Parallelization**: Use `-j <threads>` to speed up processing.
- **Read Orientation**: By default, `imseq` reverse complements V(D)J-reads. Use `-r` to reverse this behavior if your library prep orientation is different (e.g., simulated forward-strand data).
- **Quality Thresholds**: Set `-mq <score>` (default 10) for minimum average Phred score.

### Troubleshooting Rejections
Use `-rlog <file>` to generate a log of rejected reads. Common rejection codes:
- `MOTIF_AMBIGUOUS`: Multiple segments match equally well but suggest different CDR3 boundaries.
- `NONSENSE_IN_CDR3`: Contains a stop codon.
- `OUT_OF_READING_FRAME`: Cys and Phe motifs are not in-frame.

## Reference documentation
- [IMSEQ Manual](./references/www_imtools_org_manual.md)
- [FASTA ID Specification](./references/www_imtools_org_fastaFormat.md)
- [IMSEQ Tutorial](./references/www_imtools_org_tutorial.md)
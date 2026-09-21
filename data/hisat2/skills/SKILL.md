---
name: hisat2
description: HISAT2 is a graph-based spliced aligner for mapping RNA-seq and DNA-seq reads to linear or variant-aware reference genomes. Use when user asks to align spliced RNA-seq or DNA-seq reads, prepare alignments for transcript assemblers like StringTie or Cufflinks, or build hierarchical genome indexes from FASTA and GTF or VCF annotations.
homepage: https://daehwankimlab.github.io/hisat2
metadata:
  docker_image: "quay.io/biocontainers/hisat2:2.2.3--h8471819_0"
---


# hisat2

## Overview

HISAT2 (Hierarchical Indexing for Spliced Alignment of Transcripts 2) is a graph-based spliced aligner optimized for mapping RNA-seq and DNA-seq reads to single references or graph genomes incorporating known population variants (SNPs and indels). It achieves low memory usage (~6.7 GB for human genomes) and high alignment speed through global and local FM indexes.

Use HISAT2 for:
- Spliced RNA-seq read alignment against linear or variant-aware (SNP/transcript) genomes.
- Generating alignments compatible with downstream transcript assemblers like StringTie and Cufflinks.
- Aligning unspliced DNA-seq reads (WGS, WES) by disabling spliced alignment modes.
- Building custom hierarchical genome indexes from FASTA sequences and GTF/VCF annotations.

---

## Index Types and Suffixes

HISAT2 indexes consist of multiple binary files:
- Small genomes (< 4 billion bases): 8 files ending in `.1.ht2` through `.8.ht2`.
- Large genomes: 8 files ending in `.1.ht2l` through `.8.ht2l`.

When referencing an index in commands, provide only the basename prefix (e.g., `grch38` for `grch38.1.ht2`).

### Index Categories

| Index Base | Description | Best Use Case |
|---|---|---|
| `genome` | Linear reference FASTA | Standard alignment, minimal overhead |
| `genome_snp` | Reference + common SNPs | Minimizes reference bias for variant calling |
| `genome_tran` | Reference + known transcripts | Standard RNA-seq with known gene models |
| `genome_snp_tran` | Reference + SNPs + transcripts | Comprehensive population-aware RNA-seq |
| `genome_rep` | Reference + repeats | Multi-mapping repeat resolution (v2.2.0+) |

Prebuilt indexes can be downloaded directly from AWS Public Datasets:
```bash
wget --content-disposition https://genome-idx.s3.amazonaws.com/hisat/grch38_tran.tar.gz
tar -xzf grch38_tran.tar.gz
```

---

## Index Building (`hisat2-build`)

### 1. Standard Linear Index
```bash
hisat2-build -p 8 genome.fa genome_idx
```

### 2. Transcript-Aware Index (from GTF)
Extract splice sites and exons before building:
```bash
hisat2_extract_splice_sites.py genes.gtf > splicesites.tsv
hisat2_extract_exons.py genes.gtf > exons.tsv

hisat2-build -p 16 \
  --ss splicesites.tsv \
  --exon exons.tsv \
  genome.fa genome_tran
```

### 3. SNP- and Haplotype-Aware Index (from VCF)
Extract SNPs and haplotypes to avoid graph combinatorial explosion:
```bash
hisat2_extract_snps_haplotypes_VCF.py genome.fa variants.vcf genome_snp

hisat2-build -p 16 \
  --snp genome_snp.snp \
  --haplotype genome_snp.haplotype \
  genome.fa genome_snp
```

---

## RNA-Seq Alignment Workflows

### Standard Paired-End RNA-Seq (Downstream StringTie)
For transcript assembly with StringTie, specify `--dta` (downstream transcriptome assembly), which guides alignments across known and novel junctions:

```bash
hisat2 \
  -p 8 \
  --dta \
  -x /path/to/genome_tran \
  -1 sample_R1.fastq.gz \
  -2 sample_R2.fastq.gz \
  --summary-file sample_align_summary.txt \
  --new-summary \
  | samtools sort -@ 4 -O BAM -o sample_sorted.bam -
```

### Single-End RNA-Seq
```bash
hisat2 \
  -p 8 \
  --dta \
  -x /path/to/genome_tran \
  -U sample.fastq.gz \
  --summary-file sample_align_summary.txt \
  | samtools sort -@ 4 -O BAM -o sample_sorted.bam -
```

### Stranded RNA-Seq
Specify RNA-seq strandness using `--rna-strandness`:
- **Unstranded**: Omit `--rna-strandness` (default).
- **dUTP / TruSeq Stranded / NEBNext Ultra II Directional**:
  - Paired-end: `--rna-strandness RF`
  - Single-end: `--rna-strandness R`
- **Ligation / Standard directional**:
  - Paired-end: `--rna-strandness FR`
  - Single-end: `--rna-strandness F`

Example:
```bash
hisat2 -x genome_tran -1 R1.fq.gz -2 R2.fq.gz --rna-strandness RF --dta -p 8 -S output.sam
```

---

## DNA-Seq Alignment (WGS / Exome)

When mapping whole-genome or exome DNA reads, disable spliced alignment and optionally configure fragment length bounds (`-I` min, `-X` max):

```bash
hisat2 \
  -p 8 \
  --no-spliced-alignment \
  -I 100 \
  -X 800 \
  -x /path/to/genome \
  -1 dna_R1.fastq.gz \
  -2 dna_R2.fastq.gz \
  -S dna_aligned.sam
```

---

## Key CLI Options & Parameters

### Alignment Tuning
- `--score-min <func>`: Minimum score threshold for reporting alignments. Default is `L,0.0,-0.2` (e.g., -20 for 100 bp, -30 for 150 bp).
- `--max-seeds <int>`: Max seeds extended for full alignment; higher increases sensitivity at cost of runtime.
- `--no-softclip`: Disable soft-clipping of read ends.
- `--no-templatelen-adjustment`: Disables automatic intron deduction when calculating template lengths (SAM TLEN).

### Input/Output Options
- `-q`: Input reads are FASTQ format (default).
- `-f`: Input reads are FASTA format.
- `--summary-file <file>`: Write alignment statistics to a file in addition to `stderr`.
- `--new-summary`: Output summary in machine-parseable key-value format.
- `--remove-chrname`: Strip `chr` prefix from reference sequence names in SAM output.
- `--add-chrname`: Add `chr` prefix to reference sequence names in SAM output.
- `--un-conc <path>`: Write pairs that do not align concordantly to specified file base.
- `--al-conc <path>`: Write pairs that align concordantly at least once.

### Downstream Assembly Flags
- `--dta`: Tailors SAM output for transcript assemblers (StringTie).
- `--dta-cufflinks`: Tailors SAM output with Cufflinks-specific tags (adds `XS:A` tag for spliced reads).

---

## Performance & Troubleshooting

1. **Memory mapped I/O (`--mm`)**:
   - Multiple hisat2 instances on the same node can share index memory:
     ```bash
     hisat2 --mm -x genome_tran -1 sample1_R1.fq -2 sample1_R2.fq -S sample1.sam &
     hisat2 --mm -x genome_tran -1 sample2_R1.fq -2 sample2_R2.fq -S sample2.sam &
     ```
2. **Direct BAM Streaming**:
   - HISAT2 produces large SAM outputs. Always pipe directly to `samtools sort`:
     ```bash
     hisat2 -x index -1 R1.fq.gz -2 R2.fq.gz -p 8 | samtools sort -@ 4 -m 2G -o output.bam
     ```
3. **Repeat Reads Handling (v2.2.0+)**:
   - For reads aligning >100 times, using `genome_rep` index types restricts reporting to single repeat records per read to avoid excessive disk utilization.

---



## Subcommands

| Command | Description |
|---------|-------------|
| hisat2 | HISAT2 is a fast and sensitive alignment program for mapping next-generation sequencing reads (both DNA and RNA) to a population of human genomes as well as to a single reference genome. |
| hisat2_extract_exons.py | Extracts exons from a GTF file for use with HISAT2 index building. |

## Reference documentation

- [HISAT2 Overview](./references/github_com_DaehwanKimLab_hisat2_blob_master_README.md)
- [HISAT2 Download and Index Details](./references/daehwankimlab_github_io_hisat2_download.md)
- [HISAT2 Release Notes and Feature History](./references/daehwankimlab_github_io_hisat2.md)
---
name: hisat2
description: HISAT2 (Hierarchical Indexing for Spliced Alignment of Transcripts 2) is a highly efficient alignment tool designed for mapping both DNA and RNA-seq reads.
homepage: http://daehwankimlab.github.io/hisat2
---

# hisat2

## Overview
HISAT2 (Hierarchical Indexing for Spliced Alignment of Transcripts 2) is a highly efficient alignment tool designed for mapping both DNA and RNA-seq reads. It utilizes a Hierarchical Graph FM index (HGFM) to represent a population of genomes, allowing it to account for genomic variations like SNPs and known splice sites during the alignment process. This makes it particularly powerful for transcriptomics workflows where accurate spliced alignment is critical. It is the recommended successor to HISAT and TopHat2.

## Core Workflows

### 1. Building Indexes
Before alignment, you must create an index of the reference genome. HISAT2 supports linear indexes and graph-based indexes that include SNPs and transcripts.

**Basic Index (Linear):**
```bash
hisat2-build -p 16 genome.fa genome_index
```

**Index with Splice Sites and Exons (Recommended for RNA-seq):**
First, extract information from your GTF:
```bash
hisat2_extract_splice_sites.py genome.gtf > genome.ss
hisat2_extract_exons.py genome.gtf > genome.exon
```
Then build the index:
```bash
hisat2-build -p 16 --ss genome.ss --exon genome.exon genome.fa genome_tran_index
```

**Index with SNPs:**
```bash
hisat2_extract_snps_haplotypes_UCSC.py genome.fa snp144Common.txt genome.snp genome.haplotype
hisat2-build -p 16 --snp genome.snp --haplotype genome.haplotype genome.fa genome_snp_index
```

### 2. Aligning Reads
HISAT2 outputs alignments in SAM format.

**RNA-seq Paired-end Alignment (Standard):**
```bash
hisat2 -p 16 -x genome_tran_index -1 reads_R1.fastq.gz -2 reads_R2.fastq.gz -S output.sam
```

**RNA-seq with Downstream Assembly (StringTie/Ballgown):**
Always use the `--dta` (reports alignments tailored for transcript assemblers) flag if you plan to use StringTie.
```bash
hisat2 -p 16 --dta -x genome_tran_index -1 R1.fq -2 R2.fq -S output.sam
```

**Handling Strand-Specific Data:**
Specify `--rna-strandness <FR/RF>` (for paired-end) or `<F/R>` (for single-end).
*   `FR`: Second mate (R2) is on the strand as the RNA.
*   `RF`: First mate (R1) is on the strand as the RNA (common for TruSeq Stranded).

### 3. HISAT-3N (Nucleotide Conversion)
For technologies like Bisulfite-seq (C -> T) or SLAM-seq (T -> C).

**Build 3N Index:**
```bash
hisat-3n-build --base-change C,T genome.fa genome_3n_index
```

**Align 3N Reads:**
```bash
hisat-3n -x genome_3n_index -U reads.fq --base-change C,T --directional-mapping -S output.sam
```

## Expert Tips and Best Practices
*   **Performance:** Use the `-p` flag to match the number of available CPU cores. Speedup is nearly linear.
*   **Memory Management:** Building a graph index with transcripts and SNPs for the human genome requires significant RAM (up to 160GB+). If memory is limited, stick to the HFM (linear) index.
*   **Soft-clipping:** By default, HISAT2 allows soft-clipping. To disable this for specific applications (like variant calling where end-to-end alignment is preferred), use `--no-softclip`.
*   **Summary Files:** Use `--summary-file <path>` to output alignment statistics to a machine-readable file instead of just stderr.
*   **SAM to BAM:** HISAT2 outputs SAM. Always pipe to `samtools view -bS` or use a post-processing step to save disk space.
*   **Repeat Reads:** In version 2.2.0+, HISAT2 introduced a "repeat" index mode to handle reads mapping to thousands of locations more efficiently.

## Reference documentation
- [HISAT2 Manual](./references/daehwankimlab_github_io_hisat2_manual.md)
- [HISAT-3N Guide](./references/daehwankimlab_github_io_hisat2_hisat-3n.md)
- [HowTo Guide](./references/daehwankimlab_github_io_hisat2_howto.md)
---
name: rmats
description: rMATS quantifies and compares alternative splicing patterns between replicate RNA-Seq datasets using a statistical model. Use when user asks to detect differential splicing events, calculate inclusion levels between two conditions, or identify novel splice sites from transcriptomic data.
homepage: http://rnaseq-mats.sourceforge.net
metadata:
  docker_image: "quay.io/biocontainers/rmats:4.3.0--py311hf2f0b74_5"
---

# rmats

## Overview
rMATS (Multivariate Analysis of Transcript Splicing) is a specialized bioinformatics tool used to quantify and compare alternative splicing patterns across replicate RNA-Seq datasets. It utilizes a statistical model to calculate P-values and False Discovery Rates (FDR), determining if the difference in isoform ratios (Inclusion Level) between two conditions is significant. The "turbo" version (v4.0+) is multi-threaded and significantly faster than earlier iterations, making it suitable for large-scale transcriptomic studies.

## Core CLI Usage

### Input Preparation
rMATS requires sample files (`.txt`) containing comma-separated paths to your BAM or FASTQ files.
- **Group 1 samples (`--b1` or `--fastq1`):** Control or condition A.
- **Group 2 samples (`--b2` or `--fastq2`):** Treatment or condition B.

### Common Command Patterns

**Running with BAM files (Pre-aligned):**
```bash
python rmats.py --b1 /path/to/b1.txt --b2 /path/to/b2.txt --gtf annotation.gtf -t paired --readLength 100 --nthread 8 --od ./output --tmp ./tmp
```

**Running with FASTQ files (Requires STAR index):**
```bash
python rmats.py --fastq1 /path/to/f1.txt --fastq2 /path/to/f2.txt --gtf annotation.gtf --bi /path/to/STAR_index -t paired --readLength 100 --nthread 8 --od ./output
```

### Key Parameters
- `-t`: Type of reads (`paired` or `single`).
- `--readLength`: The length of the RNA-Seq reads.
- `--nthread`: Number of threads to use (essential for rMATS-turbo performance).
- `--novelSS`: Enable detection of novel (unannotated) splice sites.
- `--variable-read-length`: Use this flag if your reads have been trimmed or have non-uniform lengths.
- `--allow-clipping`: Allows rMATS to process reads with soft-clipping (common in modern aligners).
- `--task`: Use `--task {prep,post,stat,both}` to split the workflow. For example, `--task stat` runs only the statistical model on previously generated count files.

## Expert Tips and Best Practices

### Workflow Optimization
- **Temporary Files:** Always specify a `--tmp` directory on a fast local disk (like an SSD) to speed up the counting process.
- **Statistical Reruns:** If you want to change the splicing difference threshold without re-counting reads, use `--task stat` with the existing output directory.
- **Memory Management:** While rMATS-turbo is efficient, novel splice site detection (`--novelSS`) increases memory consumption significantly.

### Handling Replicates
- rMATS is designed for replicates. If you have only one sample per group, use `--statoff` to skip the statistical model and obtain raw inclusion levels.
- For paired study designs (e.g., same patient before and after treatment), use the `--paired-stats` flag (requires PAIRADISE).

### Interpreting Outputs
- **JCEC vs JC:** Use `*.MATS.JCEC.txt` files for the most robust results, as they include both Junction Counts and Exon-Crossover counts. Use `*.MATS.JC.txt` if you only want to rely on reads spanning the splice junctions.
- **InclusionLevelDifference:** This value represents the change in Percent Spliced In (ΔPSI). A positive value indicates higher inclusion in Group 1.

## Reference documentation
- [rMATS Overview](./references/rnaseq-mats_sourceforge_io_index.md)
- [rMATS 4.3.0 Updates](./references/rnaseq-mats_sourceforge_io_rmats4.3.0.md)
- [rMATS 4.1.0 Experimental Features](./references/rnaseq-mats_sourceforge_io_rmats4.1.0.md)
- [rMATS 4.1.1 CLI Arguments](./references/rnaseq-mats_sourceforge_io_rmats4.1.1.md)
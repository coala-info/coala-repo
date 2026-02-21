---
name: wham
description: The wham suite is designed for the identification of structural variants (SVs) such as deletions, duplications, inversions, and insertions.
homepage: https://github.com/zeeev/wham
---

# wham

---

## Overview

The wham suite is designed for the identification of structural variants (SVs) such as deletions, duplications, inversions, and insertions. While the suite contains the original `wham` tool, the `whamg` program is the preferred implementation for most research applications because it offers significantly higher accuracy and lower false discovery rates. It works by analyzing BWA-MEM aligned BAM files and produces standard VCF 4.2 output.

## Tool Selection and Preparation

- **Use whamg**: Always prefer `whamg` over the original `wham` for general SV discovery.
- **Alignment Requirements**: Input BAM files must be generated using BWA-MEM.
- **Read Groups**: BAM files must contain read-group (`@RG`) information.
- **Library Constraints**: whamg assumes one library per BAM file.
- **Preprocessing**: Mark or remove duplicates before running. Indel realignment is recommended for better breakpoint resolution.

## Common CLI Patterns

### Basic SV Discovery
The standard workflow involves running whamg and piping the output through the provided filtering script to improve specificity.

```bash
whamg -e $EXCLUDE_LIST -a reference.fasta -f sample.bam | perl utils/filtWhamG.pl > output.vcf
```

### Joint Calling
To perform joint calling on multiple samples (e.g., trios or quads), provide a comma-separated list of BAMs or a text file containing the full path to one BAM per line.

```bash
# Comma-separated list
whamg -a ref.fasta -f sample1.bam,sample2.bam,sample3.bam > joint_calls.vcf

# File list
whamg -a ref.fasta -f bam_list.txt > joint_calls.vcf
```

### Targeted Analysis
To run whamg on a specific genomic region:

```bash
whamg -r chr1:1000000-2000000 -a ref.fasta -f sample.bam > region.vcf
```

## Expert Tips and Best Practices

### Insert Size Estimation
It is critical to use either the `-e` (exclude) or `-c` (include) flags. If neither is specified, whamg may incorrectly estimate the library's insert size distribution, leading to poor call quality.
- Use `-e` to mask problematic contigs (e.g., rDNA, short unplaced contigs, or decoy sequences).
- Use `-c` to specify a set of "clean" chromosomes (like chr1-22) to use for statistics collection.

### Performance Optimization
- **CPU Scaling**: Use the `-x` flag to specify the number of threads. Note that the initial BAM reading is I/O bound; if CPU usage drops, your I/O speed is likely the bottleneck.
- **Memory/Coverage**: For low-coverage data or exome sequencing, use the `-z` flag to force whamg to continue sampling random regions until it gathers enough data for statistical modeling.

### Troubleshooting Empty Outputs
If whamg produces an empty VCF or fails to process reads:
1. Verify that the BAM index (`.bai`) exists in the same directory as the BAM.
2. Ensure the reference FASTA used for whamg exactly matches the one used for alignment.
3. Check for the BWA-MEM `SA` tag. If using an older version of BWA, you may need to specify `-i XP`.

## Reference documentation
- [wham GitHub Repository](./references/github_com_zeeev_wham.md)
- [Bioconda wham Package](./references/anaconda_org_channels_bioconda_packages_wham_overview.md)
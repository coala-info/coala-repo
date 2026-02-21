---
name: svaba
description: SvABA is a specialized bioinformatic tool that detects structural variants and indels by performing local assembly across the genome.
homepage: https://github.com/walaj/svaba
---

# svaba

## Overview
SvABA is a specialized bioinformatic tool that detects structural variants and indels by performing local assembly across the genome. Unlike traditional split-read or discordant-pair mappers, SvABA uses a string graph assembler (SGA) to build contigs in 25kb windows, aligns these contigs to the reference using BWA-MEM, and then realigns reads to the contigs to score variants. This approach is particularly effective for identifying complex rearrangements and indels that are often missed by standard variant callers.

## Core CLI Patterns

### Somatic Variant Calling (Tumor/Normal)
To identify somatic SVs and indels, provide both tumor and normal BAM files.
```bash
svaba run -t tumor.bam -n normal.bam -p <threads> -D dbsnp_indel.vcf -a <output_prefix> -G <ref.fa>
```

### Germline Variant Calling
For germline analysis, use the `-t` flag for the sample. It is recommended to use specific flags to reduce computational overhead from mapping artifacts.
```bash
svaba run -t sample.bam -p <threads> -a <output_prefix> -G <ref.fa> -I -L 6
```
*   `-I`: Skips mate-region lookup if mates are on different chromosomes (reduces false positives in germline runs).
*   `-L 6`: Requires 6+ clustered mate reads to trigger a mate lookup.

### Targeted Assembly
If you only need to analyze specific regions (e.g., exome or specific loci), use the `-k` or `-L` flags.
```bash
# Run on a specific chromosome
svaba run -t tumor.bam -n normal.bam -k chr22 -G ref.fa -a output_id

# Run on targeted regions (BED file)
svaba run -t tumor.bam -n normal.bam -L targets.bed -G ref.fa -a output_id
```

## Output Interpretation
SvABA produces several key files. Understanding the difference between the raw output and the VCF is critical:

*   **`*.bps.txt.gz`**: The raw, unfiltered breakpoint strings. This is the source for all VCF entries.
*   **`*.svaba.somatic.sv.vcf`**: High-confidence somatic structural variants.
*   **`*.svaba.germline.indel.vcf`**: High-confidence germline indels.
*   **`*.contigs.bam`**: The assembled contigs aligned to the reference. **Note**: This file is unsorted; you must run `samtools sort` and `samtools index` before viewing in IGV.
*   **`*.alignments.txt.gz`**: ASCII representations of contig-to-reference and read-to-contig alignments. Use this for manual curation of difficult calls.

## Expert Tips & Best Practices

### Filtering and Refiltering
If the default VCF output is too stringent or too noisy, use the `refilter` command on the `bps.txt.gz` file rather than re-running the entire assembly.
```bash
svaba refilter -i <prefix>.bps.txt.gz -b <original.bam> -a <new_prefix>
```

### Scoring Metrics
When evaluating variants in the VCF or `bps` file, pay attention to these specific SvABA metrics:
*   **LOD (LO)**: Log of the odds that the variant is real vs. an artifact.
*   **LR**: Log of the odds for somatic vs. germline classification (allelic fraction 0 vs >= 0.5).
*   **SL (Scaled LOD)**: A heuristic score that adjusts the LOD based on mapping quality and mismatches (NM).

### Debugging Variants
To visually inspect a specific variant found in the VCF:
1.  Identify the contig name from the VCF entry (look for the `SCTG` tag).
2.  Extract the ASCII alignment for that contig:
    ```bash
    gunzip -c <prefix>.alignment.txt.gz | grep <contig_name> > debug_plot.txt
    ```
3.  View `debug_plot.txt` in a text editor with **line truncation turned OFF**.

## Reference documentation
- [SvABA GitHub Repository](./references/github_com_walaj_svaba.md)
- [Bioconda SvABA Package](./references/anaconda_org_channels_bioconda_packages_svaba_overview.md)
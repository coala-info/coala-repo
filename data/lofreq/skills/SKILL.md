---
name: lofreq
description: LoFreq is a sequence-quality aware variant caller designed to identify low-frequency mutations with high sensitivity and rigorous false-positive control.
homepage: http://csb5.github.io/lofreq/
---

# lofreq

## Overview
LoFreq is a sequence-quality aware variant caller designed to identify low-frequency mutations with high sensitivity and rigorous false-positive control. Unlike many callers that use hard thresholds, LoFreq incorporates base-call qualities, mapping uncertainty, and alignment probabilities into its mathematical model. It is particularly effective for heterogeneous samples like viral quasispecies or clinical somatic samples where variants may exist far below the standard 5% allele frequency threshold.

## Core Workflows

### Basic SNV Calling
To call SNVs from a single BAM file against a reference genome:
```bash
lofreq call -f ref.fa -o vars.vcf aln.bam
```

### Calling Indels
Indel calling requires indel qualities (BI/BD tags) in the BAM file. If these were not added during GATK BQSR, you must add them first:
```bash
# 1. Add indel qualities (use --dindel for Illumina data)
lofreq indelqual --dindel -f ref.fa -o aln_with_indelquals.bam aln.bam
# 2. Index the new BAM
samtools index aln_with_indelquals.bam
# 3. Call SNVs and Indels
lofreq call --call-indels -f ref.fa -o vars.vcf aln_with_indelquals.bam
```

### Parallel Execution
For large genomes (e.g., Human), always use the parallel wrapper to utilize multiple CPU cores:
```bash
lofreq call-parallel --pp-threads 8 -f ref.fa -o vars.vcf aln.bam
```

### Somatic Variant Calling
For matched tumor-normal pairs, use the somatic subcommand. This automatically enables source quality filtering.
```bash
lofreq somatic -n normal.bam -t tumor.bam -f ref.fa --threads 8 -o output_prefix_
```
*Note: Providing a dbSNP file (`-d dbsnp.vcf.gz`) is highly recommended for human samples to filter germline variants.*

## Expert Tips and Best Practices

### Preprocessing Requirements
*   **GATK Best Practices**: It is highly recommended to mark duplicates, realign indels, and perform Base Quality Score Recalibration (BQSR) before running LoFreq.
*   **High Coverage Warning**: Do NOT use `MarkDuplicates` on extremely high-coverage data (e.g., >1000x amplicon sequencing), as it will incorrectly flag unique reads as duplicates.
*   **Targeted Sequencing**: If using Exome or targeted panels, always provide the BED file using `-l regions.bed`. This prevents the Bonferroni correction from being overly conservative, which would otherwise hide true variants.

### Handling Specific Data Types
*   **Amplicons/PCR**: PCR artifacts often appear as low-frequency variants. To mitigate this, use a BED file to exclude primer regions and consider a higher frequency cutoff if artifacts are suspected.
*   **Non-Illumina Data**: For IonTorrent or PacBio, use `lofreq indelqual --uniform <rate>` to add uniform indel qualities if specific error models are unavailable.
*   **Mapping Quality Issues**: If using mappers like Bowtie or BWA-SW that assign low or ambiguous mapping qualities, consider disabling mapping quality integration with `-N` to maintain sensitivity.

### Troubleshooting "Missing" Variants
If a variant is visible in a pileup but not called:
1.  Check for **Strand Bias**: LoFreq filters variants with significant strand bias by default.
2.  Check **Alignment Quality**: High uncertainty in the local alignment (Viterbi) may downgrade the variant quality.
3.  **Permissive Run**: To diagnose, run with relaxed filters:
    ```bash
    lofreq call --no-default-filter -A -B -a 1 -b 1 -r region -f ref.fa aln.bam
    ```

## Reference documentation
- [LoFreq Commands](./references/csb5_github_io_lofreq_commands.md)
- [LoFreq FAQ](./references/csb5_github_io_lofreq_faq.md)
- [LoFreq Blog (Version Updates)](./references/csb5_github_io_lofreq_blog.md)
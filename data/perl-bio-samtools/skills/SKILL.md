---
name: perl-bio-samtools
description: This skill provides procedural knowledge for the Samtools, BCFtools, and HTSlib ecosystem.
homepage: https://www.htslib.org/
---

# perl-bio-samtools

## Overview

This skill provides procedural knowledge for the Samtools, BCFtools, and HTSlib ecosystem. It enables efficient handling of high-throughput sequencing data through optimized command-line patterns. Key capabilities include managing the transition from FASTQ to aligned BAM/CRAM files, performing coordinate sorting, marking PCR and optical duplicates, and executing variant calling pipelines. It emphasizes performance optimization through pipe-based workflows and advanced compression techniques like CRAM 3.1.

## Core Command Patterns

### Efficient Format Conversion (BAM to CRAM)
CRAM provides significant storage savings over BAM by using reference-based compression.
```bash
# Convert BAM to CRAM (requires reference)
samtools view -T reference.fasta -C -o output.cram input.bam

# Create CRAM with embedded reference (self-contained but larger)
samtools view -O CRAM,embed_ref -o output.cram input.bam
```

### The Standard Duplicate Marking Workflow
Duplicate marking should be performed in a specific sequence to ensure all necessary tags (MC, ms) are present.
1. **Collate**: Group reads by name.
2. **Fixmate**: Add mate-pair information and score tags.
3. **Sort**: Order by genomic coordinates.
4. **Markdup**: Identify and mark duplicates.

```bash
samtools collate -o name_collated.bam input.bam
samtools fixmate -m name_collated.bam fixmate.bam
samtools sort -o position_sorted.bam fixmate.bam
samtools markdup position_sorted.bam final_marked.bam
```

### High-Performance Pipelines
To minimize Disk I/O, use Unix pipes and uncompressed BAM (`-u`) for intermediate steps.
```bash
minimap2 -t 8 -a -x sr ref.fa r1.fq r2.fq | \
samtools fixmate -u -m - - | \
samtools sort -u -@2 -T /tmp/sort_prefix - | \
samtools markdup -@8 --reference ref.fa - final.cram
```

### Variant Calling (Mpileup)
Generate genotype calls from one or multiple BAM/CRAM files.
```bash
# Direct pipe from mpileup to calling
bcftools mpileup -Ou -f reference.fasta sample1.bam sample2.bam | \
bcftools call -vmO z -o study_variants.vcf.gz

# Index the resulting VCF
tabix -p vcf study_variants.vcf.gz
```

## Expert Tips and Best Practices

### Reference Management for CRAM
*   **REF_PATH and REF_CACHE**: Set these environment variables to automate reference retrieval via MD5 sums and avoid repeated downloads from EBI servers.
    ```bash
    export REF_PATH=/path/to/cache/%2s/%2s/%s:http://www.ebi.ac.uk/ena/cram/md5/%s
    export REF_CACHE=/path/to/cache/%2s/%2s/%s
    ```
*   **Validation**: If you encounter "MD5sum checksum reference mismatch," ensure the reference used for decompression exactly matches the one used during encoding.

### Performance Tuning
*   **Thread Allocation**: Use `-@` to specify additional threads for `sort`, `view`, and `markdup`.
*   **Memory Management**: In `samtools sort`, the `-m` flag is **per-thread**. Setting `-m 4G -@ 8` will attempt to use 32GB of RAM.
*   **Compression Levels**: Use `level=1` for temporary files to balance speed and size, or `level=0` (uncompressed) for pipes.

### Duplicate Marking Nuances
*   **Optical Duplicates**: Use the `-d` (distance) tag in `markdup` for patterned flow cells (e.g., 2500 for NovaSeq, 100 for HiSeq).
*   **Tags**: `markdup` relies on the `MC` (Mate Cigar) and `ms` (Mate Score) tags added by `fixmate -m`. Without these, duplicate detection is less accurate.

### VCF Filtering
*   Post-call filtering is preferred over pre-call filtering for flexibility.
*   Use `bcftools filter -i 'QUAL>30 && DP>10'` to quickly subset high-quality variants.
*   Use `bcftools stats` and `plot-vcfstats` to visualize quality distributions before deciding on hard filter thresholds.

## Reference documentation
- [Duplicate Marking](./references/www_htslib_org_algorithms_duplicate.html.md)
- [CRAM Benchmarks](./references/www_htslib_org_benchmarks_CRAM.html.md)
- [Reference Sequences](./references/www_htslib_org_doc_reference_seqs.html.md)
- [FASTQ to BAM / CRAM Workflow](./references/www_htslib_org_workflow_fastq.html.md)
- [WGS/WES Mapping to Variant Calls](./references/www_htslib_org_workflow_wgs-call.html.md)
- [Filtering of VCF Files](./references/www_htslib_org_workflow_filter.html.md)
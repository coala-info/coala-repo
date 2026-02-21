---
name: sam
description: The `sam` skill provides a specialized interface for the Samtools ecosystem, the industry standard for handling high-throughput sequencing data.
homepage: https://www.htslib.org/
---

# sam

## Overview
The `sam` skill provides a specialized interface for the Samtools ecosystem, the industry standard for handling high-throughput sequencing data. This skill enables efficient manipulation of alignment files, robust variant calling, and advanced file compression techniques. It is designed to help you navigate the transition from raw FASTQ data to analysis-ready CRAM or BAM files and subsequent variant discovery using BCFtools.

## Core Workflows

### FASTQ to Aligned CRAM
To produce the most efficient storage format (CRAM) from raw reads, use a piped approach to minimize disk I/O:

```bash
# Map, fix mates, sort, and mark duplicates in one pipeline
minimap2 -t 8 -a -x sr reference.fa read1.fq read2.fq | \
samtools fixmate -u -m - - | \
samtools sort -u -@2 -T /tmp/temp_prefix - | \
samtools markdup -@8 --reference reference.fa - final.cram
```

### Duplicate Marking Procedure
Proper duplicate marking requires specific tags added during the `fixmate` step:
1. **Collate**: `samtools collate -o name_collate.bam input.bam`
2. **Fixmate**: `samtools fixmate -m name_collate.bam fixmate.bam` (adds `ms` and `MC` tags)
3. **Sort**: `samtools sort -o position_sort.bam fixmate.bam`
4. **Markdup**: `samtools markdup position_sort.bam marked.bam`

### Variant Calling (SNP & Indel)
Use `mpileup` to generate likelihoods followed by `call` to determine genotypes:

```bash
# Multi-sample calling
bcftools mpileup -Ou -f reference.fa sample1.bam sample2.bam | \
bcftools call -vmO z -o study.vcf.gz
```

## Expert Tips & Best Practices

### CRAM Optimization
*   **Reference-Based Compression**: CRAM requires the reference genome to be accessible. Use `REF_PATH` and `REF_CACHE` environment variables to manage local MD5-summed reference caches to avoid repeated remote downloads.
*   **Embedding References**: For self-contained files (e.g., de-novo assemblies), use `embed_ref`:
    `samtools view -O CRAM,embed_ref -T ref.fa in.bam -o out.cram`
*   **Version Selection**: Use CRAM 3.1 for better compression of quality scores and base modifications (MM/ML tags) compared to 3.0.

### Performance Tuning
*   **Thread Allocation**: Use `-@` to specify additional threads for compression/decompression in `sort`, `view`, and `markdup`.
*   **Memory Management**: In `samtools sort`, the `-m` flag is **per-thread**. Ensure `threads * memory_per_thread` does not exceed system limits.
*   **Fast I/O**: Use `-u` or `-O bam,level=0` for uncompressed BAM output when piping between tools to save CPU cycles on intermediate compression.

### VCF Filtering
*   **Post-call Filtering**: Prefer `bcftools filter` or `view` with expressions over hard pre-call filters to maintain flexibility.
*   **Common Expressions**:
    *   Filter by Quality: `-i 'QUAL > 50'`
    *   Filter by Depth: `-e 'INFO/DP < 10'`
    *   Filter by Type: `-i 'TYPE="snp"'`

## Reference documentation
- [Duplicate Marking](./references/www_htslib_org_algorithms_duplicate.html.md)
- [CRAM Benchmarks and Versions](./references/www_htslib_org_benchmarks_CRAM.html.md)
- [Reference Sequence Management](./references/www_htslib_org_doc_reference_seqs.html.md)
- [FASTQ to BAM/CRAM Workflow](./references/www_htslib_org_workflow_fastq.html.md)
- [VCF Filtering Guide](./references/www_htslib_org_workflow_filter.html.md)
- [WGS Variant Calling](./references/www_htslib_org_workflow_wgs-call.html.md)
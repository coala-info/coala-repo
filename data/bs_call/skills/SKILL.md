---
name: bs_call
description: bs_call simultaneously calls DNA methylation states and genetic variants from bisulfite-treated sequencing data. Use when user asks to call methylation states, perform genotyping on bisulfite-seq data, or identify SNPs in the context of epigenetic modifications.
homepage: https://github.com/heathsc/bs_call
metadata:
  docker_image: "quay.io/biocontainers/bs-seeker2:2.1.7--0"
---

# bs_call

## Overview
bs_call is a specialized bioinformatics tool designed for the simultaneous calling of DNA methylation states and genetic variants from bisulfite-treated sequencing data. Unlike standard variant callers, it accounts for the chemical conversion of unmethylated cytosines to uracils (read as thymines), allowing for accurate genotyping in the context of epigenetic modifications. It is highly memory-efficient, processing reference contigs individually, and supports modern high-throughput sequencing formats.

## Common CLI Patterns

### Basic Methylation and Variant Calling
The most common use case involves processing a BAM file against a reference genome to produce a BCF file.
```bash
bs_call -r reference.fasta -n sample_name -o output.bcf input.bam
```

### Processing Paired-End Data
When working with paired-end reads, use the `-p` flag. It is often recommended to trim the ends of reads to remove potential artifacts from end-repair during library preparation.
```bash
bs_call -r reference.fasta -p -L 5 -n sample_name -o output.bcf input.bam
```
*Note: `-L 5` trims 5 bases from the left of the read pair.*

### Output Format Autodetection
The tool can automatically determine the desired output format based on the file extension provided to the `-o` flag.
- **BCF**: Use `.bcf`
- **Compressed VCF**: Use `.vcf.gz`
- **Uncompressed VCF**: Default if outputting to stdout or using `.vcf`

## Expert Tips and Best Practices

### Performance and Multithreading
bs_call uses a threading model that splits tasks between calculation, input, and output. For large Whole Genome Bisulfite Sequencing (WGBS) samples, ensure you have sufficient threads allocated to prevent bottlenecks in the I/O stream.

### Memory Management
The tool is optimized for low memory usage (typically < 10GB RAM for human WGBS) by only loading the reference for the specific contig being processed. This allows for parallel processing of multiple chromosomes on a single workstation.

### Improving SNP Accuracy with dbSNP
To improve the evaluation of SNP calling, you can provide dbSNP data. Newer versions support loading individual chromosomes from dbSNP JSON or VCF formats.
- Use the `-S` flag if your dbSNP index is sorted by contig to prevent segmentation faults.
- You can specify a list of SNPs to be "always called" using the appropriate input flags if you are targeting specific known variants.

### Handling CRAM Files
bs_call natively supports CRAM input via htslib. When using CRAM, ensure the reference fasta used for the CRAM compression is the same one provided to the `-r` argument.

### Trimming Strategy
If you observe bias at the ends of your reads (common in BS-Seq), use the specific trimming options:
- `-L`: Trim bases from the left.
- Newer versions support read-end specific trimming to handle directional library biases.

## Reference documentation
- [bs_call Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bs_call_overview.md)
- [bs_call GitHub Repository and README](./references/github_com_heathsc_bs_call.md)
- [bs_call Version History and Features](./references/github_com_heathsc_bs_call_commits_master.md)
---
name: ksnp
description: The ksnp tool performs haplotype assembly and variant phasing using a k-mer based approach on aligned reads. Use when user asks to phase heterozygous variants, reconstruct individual haplotypes, or update a VCF file with phasing information.
homepage: https://github.com/zhouqiansolab/KSNP
---


# ksnp

## Overview

The `ksnp` tool is a specialized utility for haplotype assembly using a k-mer based approach. It is primarily used in bioinformatics workflows to phase heterozygous variants. By analyzing the local k-mer environment around variants within aligned reads (BAM files), it determines the phase of variants and outputs an updated VCF file containing the phasing information. This tool is particularly useful for researchers working with diploid genomes who need to reconstruct individual haplotypes from short-read or long-read alignment data.

## Command Line Usage

The basic syntax for running `ksnp` requires four primary input files and an output destination.

```bash
ksnp -k <k-mer_size> -b <aln.bam> -r <ref.fa> -v <variants.vcf> -o <phased.vcf>
```

### Required Parameters

- `-b <BAM>`: The input BAM file containing aligned reads. This file **must** be sorted and indexed (e.g., using `samtools sort` and `samtools index`).
- `-r <FASTA>`: The reference genome sequence. This file **must** be indexed (e.g., using `samtools faidx`).
- `-v <VCF>`: The input VCF file containing the heterozygous variants you wish to phase.
- `-o <FILE>`: The path for the output phased VCF. If omitted, results are printed to `stdout`.

### Optional Parameters

- `-k <INT>`: Sets the k-mer size. Supported values range from 2 to 5. The default value is 2.
- `-c <CHR>`: Specifies a single chromosome/contig name to process. This is the primary method for manual parallelization.

## Best Practices and Expert Tips

### Pre-processing Requirements
- **VCF Filtering**: Before running `ksnp`, ensure your input VCF is properly filtered. Phasing accuracy is highly dependent on the quality of the initial variant calls. Remove low-quality calls or those with extreme depth values.
- **Index Verification**: Always verify that your `.bai` (for BAM) and `.fai` (for FASTA) index files are in the same directory as their respective source files. `ksnp` relies on `htslib` for random access and will fail if indices are missing.

### Parallelization Strategy
`ksnp` does not have a built-in multi-threading flag for a single execution. To process a whole genome efficiently:
1. Identify the list of chromosomes in your reference.
2. Launch separate `ksnp` instances for each chromosome using the `-c` flag.
3. Concatenate the resulting VCF files using `bcftools concat`.

### K-mer Selection
While the default k-mer size is 2, adjusting this value (up to 5) can sometimes help in regions with repetitive sequences or specific read lengths, though it may increase computational overhead. For most standard haplotype phasing tasks, the default value is sufficient.

### Troubleshooting Common Issues
- **Segmentation Faults**: Often caused by a mismatch between the chromosome names in the VCF/BAM and the reference FASTA, or by using an unindexed BAM file.
- **Empty Output**: If the output VCF contains no phasing information, check if the BAM file has sufficient coverage over the variant sites or if the read mapping quality is too low for k-mer extraction.

## Reference documentation

- [GitHub Repository - zhouqiansolab/KSNP](./references/github_com_zhouqiansolab_KSNP.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ksnp_overview.md)
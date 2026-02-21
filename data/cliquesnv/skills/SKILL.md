---
name: cliquesnv
description: CliqueSNV is a specialized bioinformatic tool for the reconstruction of viral sub-populations (haplotypes) within a single host.
homepage: https://github.com/vtsyvina/CliqueSNV
---

# cliquesnv

## Overview

CliqueSNV is a specialized bioinformatic tool for the reconstruction of viral sub-populations (haplotypes) within a single host. It utilizes a graph-based approach to identify "cliques" of correlated Single Nucleotide Variations (SNVs), effectively separating true biological variation from sequencing errors. Use this skill to guide the processing of SAM or FASTA files to determine the genetic diversity and frequency of viral strains in a sample, or to generate high-accuracy variant calls (VCF).

## Core Command Structure

The tool is typically executed as a Java executable. If installed via Conda, the `cliquesnv` command may be available directly; otherwise, use the JAR file.

```bash
java -jar clique-snv.jar -m <method> -in <input_file> [options]
```

### Method Selection (-m)
You must specify the sequencing platform and the desired task:
- `snv-illumina`: Haplotype reconstruction for Illumina reads (requires `.sam`).
- `snv-pacbio`: Haplotype reconstruction for PacBio reads (accepts `.sam` or `.fas`).
- `snv-illumina-vc`: Variant calling for Illumina reads (outputs `.vcf`).
- `snv-pacbio-vc`: Variant calling for PacBio reads (outputs `.vcf`).
- `consensus-illumina` / `consensus-pacbio`: Utility to generate a consensus sequence.

## High-Utility Parameters

### Sensitivity and Noise Reduction
- `-tf <float>`: Minimum frequency threshold for haplotypes (default: `0.05`). To detect rare variants (e.g., 1%), decrease this to `0.01`. Note that lower values increase runtime.
- `-t <int>`: Minimum threshold for the O22 value (default: `10`). This represents the number of reads supporting a pair of SNVs.
- `-el <int>`: Edges limit in the SNPs graph (default: `700`). Increasing this makes the tool more sensitive but can lead to exponential increases in processing time.
- `-cm <accurate|fast>`: Use `fast` for samples with a very large number of SNPs to avoid "clique explosion," though `accurate` is preferred for quality.

### Genomic Region Filtering
- **Processing Range**: `-sp <int>` (start) and `-ep <int>` (end) define the 0-based inclusive range where the tool searches for SNPs. Use this to speed up analysis if you are only interested in a specific gene.
- **Output Range**: `-os <int>` (start) and `-oe <int>` (end) define the range of the final output haplotypes. Unlike `-sp`/`-ep`, these do not affect the algorithm's logic, only the final file content.

### Performance and Logging
- `-threads <int>`: Number of threads. Defaults to all available cores.
- `-log`: Highly recommended to enable console output for monitoring progress.
- `-tl <int>`: Time limit in seconds (default: `10800` / 3 hours). If reached, the tool will output only the consensus.

## Best Practices

- **Input Preparation**: For Illumina data, always provide a `.sam` file. For PacBio FASTA input, ensure all reads are the same length; use 'N' padding for reads with offsets.
- **Memory Management**: Since CliqueSNV runs on the JVM, ensure you allocate sufficient heap memory for large datasets using `-Xmx` (e.g., `java -Xmx16g -jar clique-snv.jar ...`).
- **Output Customization**: Use `-fdf extended` to include sample names and higher precision frequencies in the resulting FASTA headers.
- **Read Assignment**: Use the `-rn` flag to generate a mapping file (`_read_names.txt`) that shows which specific NGS reads were assigned to each reconstructed haplotype.

## Reference documentation
- [CliqueSNV GitHub README](./references/github_com_vtsyvina_CliqueSNV.md)
- [Bioconda CliqueSNV Overview](./references/anaconda_org_channels_bioconda_packages_cliquesnv_overview.md)
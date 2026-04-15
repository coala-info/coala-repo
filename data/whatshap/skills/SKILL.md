---
name: whatshap
description: WhatsHap reconstructs haplotypes from sequencing data by phasing genomic variants using individual reads. Use when user asks to phase VCF files, haplotag reads in BAM or CRAM files, perform polyploid or pedigree-integrated phasing, or calculate phasing statistics.
homepage: https://whatshap.readthedocs.io
metadata:
  docker_image: "quay.io/biocontainers/whatshap:2.8--py39h2de1943_0"
---

# whatshap

## Overview

WhatsHap is a specialized tool for reconstructing haplotypes from sequencing data. It excels at "read-based phasing," where it uses the information contained within individual sequencing reads (especially long reads like PacBio or Oxford Nanopore) to determine which allelic variants belong to the same physical chromosome. Beyond standard diploid phasing, it supports polyploid organisms, pedigree-integrated phasing, and variant genotyping.

## Core Workflows

### 1. Basic Phasing
The most common task is phasing a VCF file using a BAM/CRAM file.
```bash
whatshap phase -o phased.vcf --reference ref.fasta input.vcf input.bam
```
*   **Best Practice**: Always provide a reference FASTA (`--reference`). This enables allele detection through realignment, which is significantly more accurate than simple edit-distance matching.
*   **Indels**: As of v2.0, indel phasing is enabled by default. Use `--only-snvs` if you wish to restrict phasing to single nucleotide variants.

### 2. Haplotagging Reads
After phasing a VCF, you can "tag" the original reads in a BAM/CRAM file to identify which haplotype they originated from.
```bash
whatshap haplotag -o tagged.bam --reference ref.fasta phased.vcf input.bam
```
*   **Supplementary Alignments**: Use `--tag-supplementary` to ensure that split reads or chimeric alignments are tagged consistently with the primary alignment.
*   **Ploidy**: For non-diploid organisms, specify `--ploidy`.

### 3. Polyploid Phasing
For organisms with ploidy > 2, use the `polyphase` subcommand.
```bash
whatshap polyphase -o poly.vcf --ploidy 4 input.vcf input.bam
```

### 4. Pedigree Phasing
If you have sequencing data for related individuals (e.g., trios), WhatsHap can use the inheritance constraints to improve phasing accuracy and bridge gaps between read-backed blocks.
```bash
whatshap phase -o pedigree_phased.vcf --ped family.ped --reference ref.fasta input.vcf child.bam father.bam mother.bam
```

## Advanced CLI Patterns

### Handling High Coverage
If processing very high-coverage data (>200x) and encountering performance issues or overflows, use the heuristic algorithm:
```bash
whatshap phase --algorithm=heuristic ...
```

### Phasing Statistics
To evaluate the quality of your phasing (e.g., block lengths, N50, number of phased variants):
```bash
whatshap stats --chromosomes chr1,chr2 phased.vcf
```

### Comparing VCFs
To compare two phased VCFs and calculate switch error rates:
```bash
whatshap compare --names "Method1,Method2" phased1.vcf phased2.vcf
```

### Filtering and Chromosomes
*   **Exclude Chromosomes**: Use `--exclude-chromosome` to skip specific contigs (e.g., mitochondria or unplaced scaffolds).
*   **Region-specific**: Use `--region` to restrict processing to a specific genomic interval, which is useful for parallelizing by chromosome.

## Expert Tips
*   **CRAM Files**: When using CRAM, ensure the reference FASTA is indexed and matches the one used for alignment.
*   **Multi-sample VCFs**: WhatsHap handles multi-sample VCFs. For `phase`, it will phase all samples present in the VCF that also have corresponding read data in the provided BAM files.
*   **Memory Efficiency**: For very large datasets, processing one chromosome at a time using the `--region` flag is the recommended way to manage memory and runtime.



## Subcommands

| Command | Description |
|---------|-------------|
| whatshap compare | Compare two or more phased variant files |
| whatshap find_snv_candidates | Generate candidate SNP positions. |
| whatshap genotype | Genotype variants |
| whatshap hapcut2vcf | Convert hapCUT output format to VCF |
| whatshap haplotag | Tag reads by haplotype |
| whatshap haplotagphase | Phase variants in VCF based on information from haplotagged reads |
| whatshap learn | Generate sequencing technology specific error profiles |
| whatshap phase | Phase variants in a VCF with the WhatsHap algorithm |
| whatshap polyphase | Phase variants in a polyploid VCF using a clustering+threading algorithm. |
| whatshap polyphasegenetic | Phase variants in a polyploid VCF using a clustering+threading algorithm. |
| whatshap split | Split reads by haplotype |
| whatshap stats | Print phasing statistics of a single VCF file |
| whatshap unphase | Remove phasing information from a VCF file |

## Reference documentation
- [WhatsHap GitHub Repository](./references/github_com_whatshap_whatshap.md)
- [WhatsHap Changes and Version History](./references/github_com_whatshap_whatshap_blob_main_CHANGES.rst.md)
- [WhatsHap ReadTheDocs Guide](./references/whatshap_readthedocs_io_en_latest_guide.html.md)
---
name: unfazed
description: unfazed phases de novo variants and structural variations in trios using multiple methods. Use when user asks to phase de novo variants, phase structural variants and CNVs, or phase sex chromosomes.
homepage: https://github.com/jbelyeu/unfazed
metadata:
  docker_image: "quay.io/biocontainers/unfazed:1.0.2--pyh3252c3a_0"
---

# unfazed

## Overview

unfazed is a tool for phasing de novo variants by leveraging informative heterozygous sites in a trio. It employs three primary methods: extended read-backed phasing (chaining reads via overlapping variants), allele-balance phasing for copy-number variants (CNVs), and sex-chromosome autophasing for males. It is designed to work with point mutations and large structural variations, providing higher sensitivity than standard read-backed phasing by searching across larger genomic distances.

## CLI Usage and Best Practices

### Core Command Structure
To phase de novo mutations (DNMs), provide the de novo calls, a VCF of informative sites for the trio, a pedigree file, and the offspring's alignment data.

```bash
unfazed \
  -d de_novo_variants.vcf \
  -s trio_informative_sites.vcf.gz \
  -p family.ped \
  -b /path/to/bam_directory/ \
  -g 38 \
  --outfile phased_variants.vcf
```

### Input Requirements
- **DNM File (`-d`)**: Can be VCF or BED. If using BED, ensure columns represent `chrom`, `start`, `end`, `kid_id`, and `var_type`.
- **Sites VCF (`-s`)**: Must be sorted, bgzipped, and indexed. It must contain genotypes for the child and both parents.
- **Pedigree (`-p`)**: Standard PED format defining the relationship between the kid and parents.
- **Alignments**: Use `-b` if BAMs/CRAMs are named `{sample_id}.bam` or `{sample_id}.cram`. Otherwise, use `--bam-pairs sample_id:/path/to/file.bam`.

### Handling Structural Variants (SVs) and CNVs
unfazed uses allele balance (AB) to phase deletions and duplications.
- **Deletions**: Phased when the allele from one parent "disappears" (appears hemizygous).
- **Duplications**: Phased when the AB shifts toward 0.66 for the duplicated parent's allele.
- **Tip**: If phasing is ambiguous, adjust `--evidence-min-ratio` (default 10:1) to change the stringency of the parental call.

### Sex Chromosome Phasing
Use the `-g` (build) flag to enable automatic phasing of sex chromosomes in males.
- **Build 37/38**: Automatically phases non-PAR X to mother and Y to father.
- **PAR Regions**: Variants in pseudoautosomal regions are treated with standard read-backed/AB phasing logic.
- **Non-human/Other**: Use `-g na` to disable autophasing.

### Performance Optimization
- **Multithreading**: Use `-t` to specify CPU cores.
- **CRAM Support**: When using CRAM files, the reference fasta is mandatory: `-r reference.fasta`.
- **Search Distance**: If variants are sparse, increase `--search-dist` (default is 1000bp) to look further for informative sites, though this increases processing time.

### Expert Tips
- **Informative Site Filtering**: By default, unfazed requires a minimum depth of 10 (`--min-depth`) and genotype quality of 20 (`--min-gt-qual`). Lower these for low-coverage data, or raise them to reduce false-positive phasing.
- **Extended Phasing**: Extended read-backed phasing is enabled by default. If you suspect issues with read chaining in complex regions, use `--no-extended` to limit phasing to single read pairs.
- **Verbose Output**: Use `--verbose` with BED output to see the specific sites and reads that contributed to each phasing decision.

## Reference documentation
- [Unfazed GitHub Repository](./references/github_com_jbelyeu_unfazed.md)
- [Bioconda Unfazed Overview](./references/anaconda_org_channels_bioconda_packages_unfazed_overview.md)
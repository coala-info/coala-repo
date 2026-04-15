---
name: psiclass
description: PsiCLASS is a reference-based transcriptome assembler that processes single or multiple RNA-seq samples simultaneously to produce individual and consensus transcript annotations. Use when user asks to assemble transcripts from BAM files, perform multi-sample transcriptome reconstruction, or generate a consensus set of meta-annotations from RNA-seq data.
homepage: https://github.com/splicebox/PsiCLASS
metadata:
  docker_image: "quay.io/biocontainers/psiclass:1.0.3--h5ca1c30_6"
---

# psiclass

## Overview
PsiCLASS is a reference-based transcriptome assembler designed to process single or multiple RNA-seq samples simultaneously. By using a global subexon splice graph and cross-sample feature selection, it achieves higher accuracy than conventional "assemble-then-merge" workflows. It produces both individual sample transcript sets and a consensus set of meta-annotations.

## Installation and Setup
The most efficient way to install PsiCLASS is via Bioconda:
```bash
conda install bioconda::psiclass
```
Alternatively, build from source by running `make` in the repository directory. Ensure `pthreads` and `zlib` are available on the system.

## Core Usage Patterns

### Basic Multi-sample Assembly
Provide a comma-separated list of BAM files.
```bash
psiclass -b sample1.bam,sample2.bam,sample3.bam -o experiment_prefix -p 8
```

### Large Sample Sets
For experiments with many samples, use a text file listing the paths to the BAM files (one per line).
```bash
psiclass --lb bam_list.txt -o experiment_prefix -p 16
```

### Handling Stranded Data
Specify the library type to improve assembly logic:
- `un`: Unstranded (default)
- `rf`: fr-firststrand (e.g., dUTP, TruSeq Stranded)
- `fr`: fr-secondstrand

```bash
psiclass -b samples.bam --stranded rf -o output
```

## Expert Workflows and Best Practices

### Alignment Compatibility (STAR/HISAT)
- **STAR Users**: You must run STAR with `--outSAMstrandField intronMotif` to include the `XS` tag.
- **Non-canonical Splice Sites**: If your alignments contain non-canonical sites, use the `addXS` utility included with PsiCLASS to ensure the assembler can interpret the strand correctly:
  ```bash
  samtools view -h in.bam | addXS reference_genome.fa | samtools view -bS - > out.bam
  ```

### Using Trusted Introns
You can guide the assembly using known annotations (e.g., GENCODE) or high-confidence introns from tools like JULIP. The input file must be a three-column, tab-delimited file: `chr_name`, `start_site`, `end_site`.
```bash
psiclass -b samples.bam -s trusted_introns.txt -o output
```

### Staged Execution and Optimization
PsiCLASS allows you to resume or re-run specific parts of the pipeline using the `--stage` flag:
- `0`: Full run (default).
- `3`: Start from assembling individual samples.
- `4`: Start from voting (consensus generation).

**Optimization Tip**: If you want to tune the consensus output without re-running the expensive assembly steps, run the assembly once, then iterate on Stage 4 with different `--vd` (minimum coverage depth) values:
```bash
psiclass --lb bam_list.txt --stage 4 --vd 2.0 -o output_v2
```

### Post-Processing
- **Gene Naming**: Use the `add-genename` utility to map PsiCLASS's novel identifiers to known gene names from a reference GTF.
- **Evaluation**: Use the `grader` tool to compare the output against a reference annotation to assess assembly quality.

## Reference documentation
- [PsiCLASS GitHub Repository](./references/github_com_splicebox_PsiCLASS.md)
- [Bioconda PsiCLASS Overview](./references/anaconda_org_channels_bioconda_packages_psiclass_overview.md)
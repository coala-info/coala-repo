---
name: pseudo-it
description: Pseudo-it automates the generation of pseudo-assemblies through iterative rounds of read mapping and variant calling to improve consensus sequences. Use when user asks to generate a pseudo-reference, perform iterative read mapping, or create a consensus sequence from divergent genomic data.
homepage: https://github.com/goodest-goodlab/pseudo-it
---


# pseudo-it

## Overview
The `pseudo-it` tool automates the generation of pseudo-assemblies by performing iterative rounds of read mapping and variant calling. In each iteration, the software maps raw FASTQ reads to a reference FASTA, identifies variants, and generates a new consensus sequence. This updated sequence then serves as the reference for the subsequent round. This process is designed to capture more variation and increase the number of successfully mapped reads compared to a single-pass assembly, which is particularly useful when the available reference genome is slightly divergent from the sample being sequenced.

## Installation and Verification
The recommended way to install `pseudo-it` and its bioinformatics dependencies (BWA, GATK, samtools, Picard, bedtools, bcftools) is via Bioconda.

```bash
conda create -n pseudo-it-env
conda activate pseudo-it-env
conda install pseudo-it
```

Before running a full pipeline, verify that all external dependencies are correctly configured in your environment:
```bash
pseudo_it.py --depcheck
```

## Core CLI Usage
The basic execution requires a reference genome, input reads, the number of iterations, and an output directory.

### Standard Paired-End Workflow
```bash
pseudo_it.py -ref reference.fasta -pe1 reads_R1.fastq -pe2 reads_R2.fastq -i 3 -p 8 -o ./assembly_output
```

### Input Read Options
`pseudo-it` supports various read configurations. You must provide at least one of the following:
- **Single-End:** `-se reads.fastq`
- **Paired-End:** `-pe1 R1.fastq -pe2 R2.fastq`
- **Merged Paired-End:** `-pem merged.fastq`

### Iteration and Resource Management
- **Iterations (`-i`):** Typically 2–4 iterations are sufficient to reach a plateau in mapping improvement.
- **Processes (`-p`):** Set this to the number of CPU cores available to parallelize mapping and variant calling.

## Advanced Patterns and Best Practices

### Resuming Interrupted Runs
If a run fails or is stopped, use the `-resume` flag to continue from the last successful iteration rather than starting from scratch.

### Region-Specific Assembly
To focus variant calling on specific genomic regions (e.g., exome or specific loci), provide a BED file:
```bash
pseudo_it.py -ref ref.fasta -pe1 R1.fq -pe2 R2.fq -i 3 -bed regions.bed -o ./output
```

### Alternative Mappers
While BWA is the default, `pseudo-it` supports HISAT2 for mapping, which can be specified using the `--mapper` flag:
```bash
pseudo_it.py -ref ref.fasta -pe1 R1.fq -pe2 R2.fq -i 3 --mapper hisat2 -o ./output
```

### Specialized Sequencing (e.g., SARS-CoV-2)
For specific viral assembly workflows where duplicate removal might be undesirable or hard-masking is required:
- Use `--nomkdups` to skip Picard MarkDuplicates.
- Use `--hardmask` to apply hard-masking to the assembly.

## Expert Tips
- **Reference Indexing:** While `pseudo-it` can index the reference automatically, pre-indexing your reference with `bwa index` or `samtools faidx` can save time in the first iteration.
- **Memory Allocation:** Ensure your environment has enough memory for GATK and Picard, as these Java-based tools can be resource-intensive during the variant calling phase.
- **Output Inspection:** Check the `.chain` files generated in the output directory; these are useful for lifting over annotations from the original reference to your new pseudo-assembly.

## Reference documentation
- [Bioconda pseudo-it Overview](./references/anaconda_org_channels_bioconda_packages_pseudo-it_overview.md)
- [pseudo-it GitHub Repository](./references/github_com_goodest-goodlab_pseudo-it.md)
---
name: biotdg
description: The Bioinformatics Test Data Generator (`biotdg`) is a specialized tool for creating realistic test datasets where chromosome counts vary.
homepage: https://github.com/biowdl/biotdg
---

# biotdg

## Overview
The Bioinformatics Test Data Generator (`biotdg`) is a specialized tool for creating realistic test datasets where chromosome counts vary. Unlike standard simulators that assume a uniform ploidy (usually 1 or 2), `biotdg` allows you to define a specific ploidy for every chromosome. It works by constructing a "true genome" FASTA file that contains the exact number of chromosome copies specified, applies mutations from a VCF in a phased manner, and then leverages `dwgsim` to generate the final FASTQ reads.

## CLI Usage and Patterns

### Basic Command Structure
To generate a dataset, you must provide the reference, the variants, a ploidy map, and the target sample name:

```bash
biotdg -r reference.fasta \
       --vcf mutations.vcf \
       -p ploidy_table.tsv \
       -s sample_name \
       -o output_directory
```

### Required Input Formats
*   **Ploidy Table (`-p`)**: A tab-delimited file with two columns: `[Chromosome Name] [Ploidy]`.
    *   Example:
        ```text
        chr1    2
        chrX    2
        chrY    1
        chr21   3
        ```
*   **VCF File (`--vcf`)**: Must contain the sample specified by `-s`. Genotypes in the VCF determine which mutations are applied to which copy of the chromosome.

### Simulation Parameters
*   **Coverage (`-C`)**: Note that the coverage value provided is multiplied by the ploidy of the chromosome. If you set `-C 10` and a chromosome has a ploidy of 3, the resulting reads will represent 30x total coverage for that region.
*   **Read Parameters**: Use `-l` for read length, `-e` for Read 1 error rate, and `-E` for Read 2 error rate. These are passed directly to the underlying `dwgsim` engine.
*   **Reproducibility**: Always set a random seed using `-z` to ensure the simulated reads are deterministic across runs.

## Expert Tips and Best Practices

*   **Phased Mutation Application**: `biotdg` applies mutations in a strictly phased manner. The first copy of a chromosome (`_0`) receives the first genotype index in the VCF, the second copy (`_1`) receives the second, and so on. Ensure your VCF genotypes are ordered correctly if specific phasing is required for your test case.
*   **Handling Sex Chromosomes**: This tool is ideal for simulating male (XY) vs female (XX) genomes. Simply provide different ploidy tables for each simulation.
*   **SNP Focus**: While the tool is robust for SNPs, it has not been extensively tested with Indels or complex structural variants. For high-fidelity Indel simulation, verify the output "true genome" FASTA before proceeding to downstream analysis.
*   **Output Inspection**: The tool generates a "true genome" FASTA in the output directory. If your pipeline is failing, check this file first to ensure the mutations and chromosome counts were applied as expected before troubleshooting the FASTQ generation.

## Reference documentation
- [github_com_biowdl_biotdg.md](./references/github_com_biowdl_biotdg.md)
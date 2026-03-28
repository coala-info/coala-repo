---
name: bamsurgeon
description: Bamsurgeon modifies existing BAM files by introducing synthetic mutations into reads while preserving the original data's noise and bias profiles. Use when user asks to add single nucleotide variants, introduce small insertions or deletions, or create complex structural variants in sequencing data.
homepage: https://github.com/adamewing/bamsurgeon
---


# bamsurgeon

## Overview
Bamsurgeon allows for the "surgical" modification of high-throughput sequencing data by re-aligning reads around a target site, introducing a mutation, and replacing the original reads with the mutated versions. Unlike simulators that generate data from scratch, Bamsurgeon preserves the original noise, coverage biases, and error profiles of the source BAM file, making it an industry standard for creating realistic "spike-in" datasets.

## Core Commands
The toolset consists of three primary Python scripts located in the `bin/` directory:

- `addsnv.py`: Introduces Single Nucleotide Variants.
- `addindel.py`: Introduces small insertions and deletions.
- `addsv.py`: Introduces complex Structural Variants (deletions, duplications, inversions, translocations).

## Common CLI Patterns

### Adding Structural Variants (SV)
To add structural variants, you must provide a variant file containing coordinates and types, a reference genome, and an insertion library if performing insertions.

```bash
python3 bin/addsv.py \
    -p 1 \
    -v variants.txt \
    -f input.bam \
    -r reference.fasta \
    -o output_mutated.bam \
    --aligner mem \
    --keepsecondary \
    --seed 1234 \
    --inslib insertion_library.fa
```

### Adding SNVs or Indels
The syntax for SNVs and Indels is similar, requiring a list of positions and desired allele frequencies.

```bash
python3 bin/addsnv.py -v snv_list.txt -f input.bam -r reference.fasta -o output_snv.bam
```

## Input File Formats
- **Variant File (-v)**: Typically a tab-delimited file. 
    - For SNVs: `chrom  pos  vaf`
    - For SVs: `chrom  start  end  type` (Types include DEL, DUP, INV, TRA).
- **Insertion Library**: A FASTA file containing sequences to be used for insertions or translocations.

## Expert Tips & Best Practices
- **Dependency Validation**: Before running complex simulations, use the provided check script to ensure all external aligners (BWA, Novoalign) and tools (Samtools, Picard, Velvet, Exonerate) are in your PATH:
  `python3 scripts/check_dependencies.py`
- **Aligner Consistency**: Always use the same aligner and parameters for Bamsurgeon that were used to create the original BAM file to avoid introducing alignment artifacts that variant callers might pick up as false positives.
- **Performance**: For large BAM files, Bamsurgeon can be resource-intensive. Use the `-p` flag to specify the number of threads for parallel processing where supported.
- **Secondary Alignments**: Use the `--keepsecondary` flag if your downstream analysis depends on secondary or supplementary alignments, as these are often stripped during the re-alignment phase by default.
- **Randomness**: Always set a `--seed` if you need to generate reproducible datasets for benchmarking.



## Subcommands

| Command | Description |
|---------|-------------|
| addsnv.py | Add SNVs to a BAM file to create a synthetic dataset. |
| bamsurgeon_addsv.py | Add structural variants to existing BAM files |

## Reference documentation
- [Bamsurgeon GitHub Repository](./references/github_com_adamewing_bamsurgeon.md)
- [Bamsurgeon Documentation and Manuals](./references/github_com_adamewing_bamsurgeon_tree_master_doc.md)
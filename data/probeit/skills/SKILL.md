---
name: probeit
description: `probeit` is a bioinformatics tool used to generate specialized probe sets for pathogen analysis, typically for use in assays like cRASL-seq.
homepage: https://github.com/steineggerlab/probeit
---

# probeit

## Overview
`probeit` is a bioinformatics tool used to generate specialized probe sets for pathogen analysis, typically for use in assays like cRASL-seq. It produces two types of probes: **Probe1** (ligation probe, ~40nt) which covers the target pathogen pattern, and **Probe2** (capture probe, ~20nt) which is located near but does not overlap with Probe1. The tool supports two primary workflows: `posnegset` for broad detection and `snp` for fine-grained genotyping.

## Installation
The tool is available via Bioconda:
```bash
conda install -c bioconda probeit
```

## Core Workflows

### 1. Pathogen Detection (posnegset)
Use this workflow to find sequences present in a target (positive) genome but absent in a background (negative) genome.

**Command Pattern:**
```bash
probeit posnegset -p positive.fa -n negative.fa -o output_directory
```

*   **-p / --positive**: FASTA file of the genome that must be covered.
*   **-n / --negative**: FASTA file of the genome that must be excluded.
*   **-o / --output**: Name of the output directory (created automatically by the tool).

### 2. Pathogen Genotyping (snp)
Use this workflow to design probes targeting specific mutations. It supports both nucleotide (nt) and amino acid (aa) substitutions.

**Nucleotide SNPs:**
Requires a reference genome, a strain genome, and a list of positions/mutations.
```bash
probeit snp -r ref.fa -s strain.fa -p "10,20" -m "nt:A21716G,nt:T26766C" -o output_dir
```

**Amino Acid SNPs:**
Requires a GFF annotation file in addition to the genomes.
```bash
probeit snp -r ref.fa -s strain.fa -p "10,20" -m "aa:orf1ab:L4715F,aa:S:E484K" -a ref.gff -o output_dir
```

*   **-r / --reference**: Wild-type/reference FASTA.
*   **-s / --strain**: Target strain FASTA.
*   **-p / --positions**: Comma-separated list of integers indicating the SNP position within the first probe.
*   **-m / --mutations**: Comma-separated array of SNPs (format: `nt:BasePosBase` or `aa:Gene:Mutation`).
*   **-a / --annotation**: GFF file (required only for `aa` mutations).

## Understanding Results
The tool generates two primary FASTA files in the output directory:

1.  **sorted1.fa (Probe1)**: Contains the primary detection/ligation probes (~40nt).
    *   *posnegset headers*: `>Name | Coordinates` (e.g., `>p1_0 | NC_001:100:140`).
    *   *snp headers*: `>Mutation;Position` (e.g., `>A21716G;10`).
2.  **sorted2.fa (Probe2)**: Contains the capture probes (~20nt).
    *   These are designed to be within 200nt of Probe1 without overlapping.
    *   Headers indicate which Probe1 or SNP they are associated with.

## Best Practices and Tips
*   **Directory Management**: Do not create the output directory beforehand; `probeit` will fail if the directory already exists or will create it for you.
*   **SNP Formatting**: When using the `snp` workflow, ensure the mutation string matches the expected prefix (`nt:` or `aa:`). For amino acids, the gene name in the `-m` string must match the ID/Name in the GFF file.
*   **Probe Distance**: By default, Probe2 is designed to be close to Probe1 (within 200nt) to facilitate efficient capture in downstream molecular assays.
*   **Validation**: Use `diff` to compare output files if running test samples from the `sample/` directory in the source repository to ensure the installation is functioning correctly.

## Reference documentation
- [Probeit GitHub Repository](./references/github_com_steineggerlab_probeit.md)
- [Probeit Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_probeit_overview.md)
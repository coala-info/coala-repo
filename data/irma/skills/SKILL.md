---
name: irma
description: IRMA (Iterative Refinement Meta-Assembler) is a specialized pipeline for the assembly and analysis of RNA virus genomes.
homepage: https://wonder.cdc.gov/amd/flu/irma/
---

# irma

## Overview
IRMA (Iterative Refinement Meta-Assembler) is a specialized pipeline for the assembly and analysis of RNA virus genomes. Unlike standard de novo assemblers, IRMA uses an iterative process of read gathering, sorting, and reference editing to produce a consensus that accurately reflects the sample's diversity. It is the standard tool for influenza surveillance and is highly effective for other viruses like SARS-CoV-2 and Ebola. Use this skill to guide the execution of IRMA, manage its modular configuration system, and interpret its multi-layered output.

## Core Usage Patterns

### Basic Execution
The standard command structure requires a module (with optional configuration suffix), input fastq files, and a sample name for the output directory.

**Paired-end reads (Illumina):**
```bash
IRMA FLU Sample_R1.fastq.gz Sample_R2.fastq.gz Output_Directory
```

**Single-end or long reads (PacBio/Ion Torrent):**
```bash
IRMA FLU-pacbio ccs_reads.fastq MyPacBioSample
IRMA FLU-pgm pgm_reads.fastq MyIonTorrentSample
```

### Module and Configuration Selection
Modules are stored in `IRMA_RES/modules/`. You can append specific configurations to the module name using a hyphen.

- **FLU**: Standard Influenza A/B assembly.
- **FLU-utr**: Optimized for samples where Untranslated Regions (UTRs) are expected.
- **FLU-lowQC**: For samples with lower quality scores or lower viral titer.
- **CoV**: For SARS-CoV-2 and MERS-CoV.
- **RSV**: For Respiratory Syncytial Virus (A and B).
- **EBOLA**: For various Ebolavirus species.

## Configuration and Optimization

### Local vs. Grid Execution
By default, IRMA may attempt to use a grid scheduler. For local multi-core execution, ensure `GRID_ON=0` is set. IRMA automatically detects available cores via `SINGLE_LOCAL_PROC`.

### Overriding Parameters
Use the `-c` or `--external-config` flag to pass a shell script containing variable overrides. This is the preferred way to modify heuristics without changing the global defaults.

```bash
# Example: custom_params.sh
MIN_F=0.01            # Set minimum frequency for SNV calling to 1%
QUAL_THRESHOLD=25     # Lower quality threshold for filtering
PADDED_CONSENSUS=1    # Enable N-padding for amplicon dropouts
```

Run with:
```bash
IRMA FLU R1.fq R2.fq MySample -c custom_params.sh
```

### Key Heuristics for Variant Calling
- **MIN_F**: Minimum frequency for calling single nucleotide variants (default ~0.008).
- **MIN_C**: Minimum allele count (default 2).
- **MIN_TCC**: Minimum coverage depth (total coverage count) required to call a variant (default 100).
- **SIG_LEVEL**: Significance level for statistical tests (default 0.999).

## Interpreting Output
IRMA produces a comprehensive directory structure for each sample:

- **amended_consensus/**: Contains the final consensus sequences. Look for `.pad.fa` if `PADDED_CONSENSUS` was enabled to see amplicon dropout regions masked as `N`.
- **tables/**:
    - `*-variants.txt`: List of called SNVs.
    - `*-allAlleles.txt`: Count of every base at every position.
    - `*-coverage.txt`: Per-position coverage depth.
- **figures/**: PDF visualizations of coverage and variants.
- **logs/**: `run_info.txt` contains the exact parameters used for the run, essential for reproducibility.
- **[Sample].bam**: The final alignment of reads to the generated consensus.

## Expert Tips
- **Read Merging**: For paired-end data, IRMA automatically attempts to merge overlapping reads. Check `tables/*-pairingStats.txt` to evaluate merging efficiency.
- **Iterative References**: If the assembly fails to elongate properly, check `intermediate/0-ITERATIVE-REFERENCES/` to see how the reference evolved across rounds.
- **Secondary Data**: If you suspect a co-infection (e.g., Flu A and B), check the `secondary/` folder. IRMA sifts reads that don't match the primary assembly into this directory.
- **Amended Consensus**: The `amended_consensus/` files use IUPAC ambiguity codes for minor variants if they exceed the `MIN_AMBIG` threshold (default 0.20).

## Reference documentation
- [Running IRMA](./references/wonder_cdc_gov_amd_flu_irma_run.html.md)
- [Configuring IRMA](./references/wonder_cdc_gov_amd_flu_irma_configuration.html.md)
- [Understanding IRMA Output](./references/wonder_cdc_gov_amd_flu_irma_output.html.md)
- [IRMA Modules](./references/wonder_cdc_gov_amd_flu_irma_modules.html.md)
- [Consensus Generation](./references/wonder_cdc_gov_amd_flu_irma_consensus.html.md)
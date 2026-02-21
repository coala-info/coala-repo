---
name: sprai
description: Sprai (Single-Pass Read Accuracy Improver) is a specialized bioinformatics pipeline designed to correct sequencing errors in long, noisy reads.
homepage: http://zombie.cb.k.u-tokyo.ac.jp/sprai/
---

# sprai

## Overview
Sprai (Single-Pass Read Accuracy Improver) is a specialized bioinformatics pipeline designed to correct sequencing errors in long, noisy reads. While many correctors focus on base-level identity, Sprai is optimized for the specific downstream goal of assembly continuity. It is most effective when working with PacBio Continuous Long Reads (CLRs) and serves as a pre-processing step before running assemblers like Celera Assembler.

## Common CLI Patterns

### Basic Error Correction Workflow
The primary entry point for Sprai is the `ezez_vx1.pl` script (or `ezez4qsub_vx1.pl` for SGE clusters). This script automates the alignment, trimming, and correction phases.

```bash
# Standard execution
ezez_vx1.pl input.fastq ec.spec
```

### Configuration (ec.spec)
Sprai requires a specification file (`ec.spec`) to define parameters. Key parameters include:
- `input_fastq`: Path to your raw reads.
- `estimated_genome_size`: Crucial for calculating coverage and overlap parameters.
- `target_coverage`: Usually set to 20-30x for the corrected output.
- `use_one_subread`: Set to `1` (default in newer versions) to use only the longest subread per molecule, reducing bias.

### Running in "Correction Only" Mode
If you intend to use a different assembler (like Flye or Canu) after correction, run Sprai in error-correction-only mode:

```bash
ezez_vx1.pl -ec_only input.fastq ec.spec
```

### Post-Processing and Assembly
After correction, Sprai typically generates a corrected FASTQ file. If using the full pipeline with Celera Assembler:
1. The script will generate a `.frg` file.
2. It will invoke `runCA` (Celera Assembler) automatically unless `-ec_only` is specified.

## Expert Tips
- **Memory Management**: For large genomes, ensure `blastn` is constrained. Sprai uses BLAST for overlaps; newer versions use `-max_target_seqs 100` to reduce memory overhead.
- **Circularization**: If assembling small genomes (e.g., plasmids or phage), use the `check_circularity.pl` utility provided in the Sprai bin directory to verify contig ends.
- **N50 Optimization**: If your N50 is lower than expected, check the `trim_len` parameter in your spec file. Increasing the minimum trim length can sometimes improve continuity at the cost of total throughput.
- **Input Quality**: Sprai is designed for CLRs. If you have circular consensus sequences (CCS/HiFi), Sprai is generally unnecessary as those reads are already high-accuracy.

## Reference documentation
- [Sprai Documentation](./references/kasahara-lab_github_io_sprai_doc.md)
- [Bioconda Sprai Package Overview](./references/anaconda_org_channels_bioconda_packages_sprai_overview.md)
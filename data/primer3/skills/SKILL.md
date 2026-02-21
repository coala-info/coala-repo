---
name: primer3
description: Primer3 is a specialized command-line tool for selecting optimal oligonucleotide primers for the Polymerase Chain Reaction (PCR).
homepage: https://github.com/primer3-org/primer3
---

# primer3

## Overview

Primer3 is a specialized command-line tool for selecting optimal oligonucleotide primers for the Polymerase Chain Reaction (PCR). It evaluates potential primers based on a wide array of criteria including melting temperature, length, GC content, 3' stability, self-complementarity, and the likelihood of forming hairpins or primer-dimers. It can also design internal hybridization probes and check primers against mispriming libraries to avoid non-specific amplification.

## Command Line Usage

The core functionality is accessed via the `primer3_core` executable. Primer3 uses a specific "BoulderIO" format for input and output, which consists of `TAG=VALUE` pairs.

### Basic Execution
To run Primer3, pipe an input file into the executable:
```bash
primer3_core < input_file > output_file
```

### Common Input Tags
Every input record must end with a termination line containing only `=`.
- `SEQUENCE_ID`: A unique identifier for the task.
- `SEQUENCE_TEMPLATE`: The DNA sequence to use for primer design.
- `PRIMER_PICK_LEFT_PRIMER`: Set to 1 to pick a forward primer.
- `PRIMER_PICK_RIGHT_PRIMER`: Set to 1 to pick a reverse primer.
- `PRIMER_PICK_INTERNAL_OLIGO`: Set to 1 to pick a hybridization probe (e.g., for TaqMan).
- `SEQUENCE_TARGET`: The specific region that must be amplified (start,length).
- `PRIMER_PRODUCT_SIZE_RANGE`: Desired size of the PCR product (e.g., 150-250).

### Thermodynamic Parameters
For accurate Tm calculations, ensure the thermodynamic parameters path is set if not using defaults:
```bash
primer3_core --default_version=2 -p ./primer3_config/ input_file
```

## Best Practices and Expert Tips

- **Input Validation**: Ensure sequences contain only A, C, G, T, and N. Primer3 is case-insensitive but treats non-IUPAC characters as errors or masks them depending on settings.
- **Mispriming Libraries**: Use the `PRIMER_MISPRIMING_LIBRARY` tag to provide a path to a FASTA file of repetitive elements (e.g., Alu, LINEs) to prevent primers from binding to common genomic repeats.
- **Penalty Weights**: If Primer3 fails to find primers, check the `PRIMER_MAX_PENALTY`. You can adjust the importance of specific criteria (like Tm vs. GC content) by modifying `PRIMER_WT_*` tags.
- **Handling Large Batches**: For high-throughput design, concatenate multiple BoulderIO records in a single file, each separated by the `=` terminator. Primer3 processes them sequentially in a single execution.
- **Sequence Masking**: Use `SEQUENCE_EXCLUDED_REGION` to prevent Primer3 from picking primers within specific areas (e.g., known SNPs or low-complexity regions).

## Reference documentation
- [Primer3 GitHub Repository](./references/github_com_primer3-org_primer3.md)
- [Bioconda Primer3 Overview](./references/anaconda_org_channels_bioconda_packages_primer3_overview.md)
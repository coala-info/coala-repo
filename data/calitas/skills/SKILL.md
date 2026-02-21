---
name: calitas
description: CALITAS (CRISPR-Cas-aware ALigner for In silico off-TArget Search) is a specialized bioinformatics tool designed to identify potential off-target sites for CRISPR guide sequences.
homepage: https://github.com/editasmedicine/calitas
---

# calitas

## Overview

CALITAS (CRISPR-Cas-aware ALigner for In silico off-TArget Search) is a specialized bioinformatics tool designed to identify potential off-target sites for CRISPR guide sequences. Unlike general-purpose aligners, CALITAS implements a customized gapped alignment algorithm that respects CRISPR-specific constraints, such as the relationship between the protospacer and the PAM. It is primarily used to enumerate candidate sites for further investigation, offering features like redundant alignment elimination and the integration of known genomic variants to ensure search results are comprehensive and biologically relevant.

## Installation and Environment

The most efficient way to use CALITAS is via the Bioconda package, which includes a helper script to manage the Java environment.

```bash
conda install -c bioconda calitas
```

If running the standalone JAR file directly, ensure Java 8+ is installed and allocate sufficient memory:
`java -Xmx8g -jar calitas.jar <command> [options]`

## Reference Preparation

Before running searches, the reference FASTA file must have both a FAI index and a sequence dictionary.

```bash
# Generate index
samtools faidx reference.fa

# Generate dictionary
samtools dict -a <assembly-name> -s <species> -o reference.dict reference.fa
```

## Core Command Patterns

### SearchReference
Use this to search an entire genome for candidate off-target sites.

**Crucial Syntax**: Provide the guide sequence in **UPPERCASE** and the PAM sequence in **lowercase**.

```bash
calitas SearchReference \
  -i CTTGCCCCACAGGGCAGTAAnrg \
  -I guide_name \
  -r reference.fa \
  -o results.txt \
  --max-guide-diffs 5 \
  --max-pam-mismatches 1 \
  --max-gaps-between-guide-and-pam 3
```

### AlignToReference
Use this to produce standardized alignments at specific genomic locations where guides are already known to align.

```bash
calitas AlignToReference -i input_locations.txt -r reference.fa -o output.txt --window-size 60
```
*Note: The input file must be tab-delimited with columns: `id`, `query`, `chrom`, `position`.*

### PrepareVcf
If performing a variant-aware search, always pre-process your VCF file to optimize performance.

```bash
calitas PrepareVcf -v input.vcf -o prepared.vcf
```

## Expert Tips and Best Practices

- **Scoring Customization**: CALITAS allows weighting mismatches differently from gaps. Use these parameters to fine-tune sensitivity if the default "canonical" alignment logic is too restrictive for your specific Cas enzyme.
- **PAM-less Searches**: For discovery of non-canonical targeting, you can perform PAM-less searches by omitting the lowercase PAM suffix in the input sequence.
- **Variant Integration**: When using `-v` with `SearchReference`, CALITAS will report if a candidate off-target site is created or modified by a known variant in your VCF, providing `variant_id` and `allele_frequency` in the output.
- **Memory Management**: For large genomes (like Human HG38), ensure at least 8GB of RAM is available to the JVM to prevent `OutOfMemoryError` during the alignment phase.
- **Output Interpretation**: The `strand` column indicates the strand of the genome the guide resembles. A `+` report means the guide binds to the bottom (negative) strand.

## Reference documentation
- [CALITAS GitHub Repository](./references/github_com_editasmedicine_calitas.md)
- [Bioconda CALITAS Overview](./references/anaconda_org_channels_bioconda_packages_calitas_overview.md)
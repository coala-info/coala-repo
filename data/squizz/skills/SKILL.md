---
name: squizz
description: "Squizz validates and converts sequence and alignment file formats. Use when user asks to check sequence file format or convert between sequence file formats."
homepage: http://ftp.pasteur.fr/pub/gensoft/projects/squizz/
---


# squizz

yaml
name: squizz
description: A command-line tool for checking and converting sequence and alignment file formats. Use when Claude needs to validate the format of sequence data (e.g., FASTA, FASTQ, SAM, BAM) or perform basic format conversions.
---
## Overview

Squizz is a versatile command-line utility designed for bioinformatics tasks. It excels at validating the integrity and format of various sequence and alignment files, ensuring data quality. Additionally, Squizz offers capabilities to convert between different sequence and alignment formats, streamlining data processing workflows.

## Usage Instructions

Squizz is primarily used via its command-line interface. The core functionality revolves around checking file formats and performing conversions.

### Checking File Formats

To check the format of a given file, use the `check` subcommand followed by the file path. Squizz will report any detected issues or confirm the format's validity.

**Basic Syntax:**

```bash
squizz check <input_file>
```

**Example:**

```bash
squizz check my_sequences.fasta
```

This command will analyze `my_sequences.fasta` and report if it conforms to the FASTA format.

### Converting File Formats

Squizz can convert files from one supported format to another. Use the `convert` subcommand, specifying the input file, output file, and the target format.

**Basic Syntax:**

```bash
squizz convert <input_file> <output_file> --to <target_format>
```

**Supported Formats (Commonly):**

*   FASTA
*   FASTQ
*   SAM
*   BAM

**Example: Convert a FASTA file to FASTQ:**

```bash
squizz convert my_sequences.fasta my_sequences.fastq --to fastq
```

This will convert `my_sequences.fasta` into `my_sequences.fastq`.

**Example: Convert a SAM file to BAM:**

```bash
squizz convert alignments.sam alignments.bam --to bam
```

This will convert `alignments.sam` into `alignments.bam`.

### Expert Tips

*   **Combine Checks and Conversions:** You can often perform a check implicitly by attempting a conversion. If the input file is malformed, the conversion will likely fail with an informative error.
*   **Consult Documentation for Specific Formats:** While Squizz supports common formats, always refer to its detailed documentation for the full list of supported input and output formats and any specific nuances for each.
*   **Error Handling:** Pay close attention to the output messages from Squizz. They provide crucial information about format violations or conversion errors.

## Reference documentation

- [Squizz Overview (Anaconda.org)](./references/anaconda_org_channels_bioconda_packages_squizz_overview.md)
- [Squizz Project Directory Index](./references/ftp_pasteur_fr_pub_gensoft_projects_squizz.md)
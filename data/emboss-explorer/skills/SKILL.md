---
name: emboss-explorer
description: emboss-explorer provides a comprehensive suite of bioinformatics tools for sequence manipulation, alignment, and molecular biology data analysis. Use when user asks to retrieve or convert sequence formats, perform local or global alignments, analyze protein properties, or configure bioinformatics databases.
homepage: http://emboss.open-bio.org/
metadata:
  docker_image: "biocontainers/emboss-explorer:v2.2.0-10-deb_cv1"
---

# emboss-explorer

# emboss-explorer

## Overview
EMBOSS is a comprehensive, open-source suite of over 400 bioinformatics tools designed to handle a wide array of molecular biology data. This skill enables the effective use of EMBOSS applications through the command line, providing procedural knowledge for sequence manipulation, database indexing, and environment configuration. It transforms a general agent into a specialized bioinformatics technician capable of navigating the AJAX/NUCLEUS libraries and the extensive application set.

## Core CLI Usage Patterns

### Sequence Retrieval and Conversion
The `seqret` tool is the primary utility for reading and writing sequences between different formats.

*   **Basic Retrieval**: `seqret <database>:<entry>`
    *   Example: `seqret embl:x65923`
*   **Format Conversion**: Use the `-osformat` qualifier to specify output formats (e.g., fasta, embl, genbank).
    *   Example: `seqret swissprot:p01234 -osformat fasta -outseq p01234.fasta`
*   **Handling Multiple Sequences**: To write sequences to individual files instead of a single stream, use the `ossingle` qualifier.

### Sequence Alignment
*   **Local Alignment (Waterman-Smith)**: Use `water`.
    *   Example: `water -asequence seq1.fa -bsequence seq2.fa -gapopen 10.0 -gapextend 0.5 -outfile align.water`
*   **Global Alignment (Needleman-Wunsch)**: Use `needle`.
*   **Forcing Sequence Type**: If a short protein sequence is mistaken for nucleic acid, use the `-protein` or `-nucleic` switch.

### Protein Analysis
*   **Antigenic Sites**: `antigenic -sequence prot.fa -minlen 6`
*   **Charge Plots**: `charge -sequence prot.fa`
*   **Helical Wheel Plots**: `pepwheel -sequence prot.fa -steps 18 -turns 5`

## Database Configuration (.embossrc)

To use databases like EMBL or SwissProt, they must be defined in a `.embossrc` file (user-level) or `emboss.default` (site-level).

### Definition Syntax
```text
DB <database_name>
[
    type: <N for nucleic, P for protein>
    method: direct
    format: <format_type>
    dir: <path_to_data>
    file: <filename_pattern>
    comment: "Description"
]
```

### Testing Definitions
Use `showdb` to verify that EMBOSS recognizes your configured databases.

## Environment Variables
EMBOSS relies on specific environment variables to locate data and documentation:

*   **PATH**: Must include the EMBOSS `bin` directory (e.g., `/usr/local/emboss/bin`).
*   **EMBOSS_DATA**: Directory for finding data files (e.g., matrices, codon tables).
*   **EMBOSS_ACDROOT**: Directory containing `.acd` files which define application parameters.
*   **EMBOSS_GRAPHICS**: Default device for visual output (e.g., `png`, `postscript`, `x11`).

## Expert Tips for Tool Integration

### ACD File Validation
Before developing new wrappers or scripts, validate the application's Ajax Command Definition (ACD) file:
*   `acdc <application>`: Tests the ACD file.
*   `acdvalid <application>`: Validates the syntax of the ACD file.
*   `acdpretty <application>`: Reformats the ACD file for readability.

### Non-Interactive Execution
For automated workflows, use the `-auto` qualifier to suppress interactive prompts and use default values for all optional parameters.

### Debugging
If an application fails or produces unexpected results:
*   Use `-debug` to generate a `.dbg` file containing detailed execution traces.
*   Check `embossversion` to ensure the environment is correctly linked to the expected library versions.



## Subcommands

| Command | Description |
|---------|-------------|
| emboss-explorer_aaindexextract | Extract amino acid property data from AAINDEX |
| emboss-explorer_prosextract | Process the PROSITE motif database for use by patmatmotifs |
| emboss-explorer_rebaseextract | Process the REBASE database for use by restriction enzyme applications |
| embossversion | Report the current EMBOSS version number |

## Reference documentation
- [EMBOSS Frequently Asked Questions](./references/emboss_open-bio_org_html_adm_apb.html.md)
- [Post-installation of EMBOSS](./references/emboss_open-bio_org_html_adm_ch01s06.html.md)
- [EMBOSS Applications (release R6)](./references/emboss_open-bio_org_html_use_apbs04.html.md)
- [Installation of CVS (Developers) Release](./references/emboss_open-bio_org_html_dev_ch01s02.html.md)
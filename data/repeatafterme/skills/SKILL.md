---
name: repeatafterme
description: RepeatAfterMe (specifically the `RAMExtend` tool) is a specialized utility for recovering the full length of repetitive DNA families from partial fragments.
homepage: https://github.com/Dfam-consortium/RepeatAfterMe
---

# repeatafterme

## Overview

RepeatAfterMe (specifically the `RAMExtend` tool) is a specialized utility for recovering the full length of repetitive DNA families from partial fragments. It takes a multiple sequence alignment (MSA) of repeat instances and uses flanking genomic sequences to perform local alignment extensions. This process generates consensus sequences for the extended regions, helping researchers identify the true boundaries of repetitive elements. It is an evolution of the RepeatScout algorithm, adding support for affine gap penalties, multiple scoring schemes, and satellite DNA detection.

## Input Requirements

To use `RAMExtend`, you must provide two primary inputs:

1.  **Genome Sequence**: Must be in UCSC `.2bit` format.
2.  **Core Alignment Ranges**: A modified BED-6 format (tab-separated) defining the instances to be extended.

### Modified BED-6 Format
| Field | Description |
| :--- | :--- |
| `chrom` | Sequence identifier (must match .2bit) |
| `chromStart` | Lower aligned position (0-based) |
| `chromEnd` | Upper aligned position (half-open) |
| `name` | **Left extendable flag** (0 = no, 1 = yes) |
| `score` | **Right extendable flag** (0 = no, 1 = yes) |
| `strand` | '+' for forward, '-' for reverse |

## Common CLI Patterns

### Basic Extension
Run a basic extension and view the summary in the terminal:
```bash
RAMExtend -ranges instances.tsv -twobit genome.2bit
```

### Full Output Generation
To save the resulting consensus and the individual extended sequences:
```bash
RAMExtend -ranges instances.tsv \
          -twobit genome.2bit \
          -cons extended_consensus.fasta \
          -outtsv extended_ranges.tsv \
          -outfa extended_sequences.fasta
```

### Working with Stockholm (.stk) Files
If you are working with RepeatModeler seed alignments, use the provided Perl wrapper to automate the conversion, extension, and MSA rebuilding:
```bash
./util/extend-stk.pl -assembly genome.2bit -input family.stk -output family_extended.stk
```

## Expert Tips and Best Practices

*   **Selective Extension**: Use the `name` and `score` fields (the 4th and 5th columns in the BED file) to prevent extension on specific sequences. This is critical if a sequence fragment is not actually proximal to the edge of the core alignment.
*   **Satellite Detection**: The tool automatically detects satellite DNA to prevent the algorithm from infinitely extending repeats beyond a single unit.
*   **Scoring Schemes**: `RAMExtend` supports affine gap penalties. If the default extension seems too conservative or aggressive, check the tool's help output for `-matrix` and `-bandwidth` adjustments.
*   **Coordinate System**: Ensure your input TSV strictly follows 0-based, half-open coordinate conventions to avoid off-by-one errors during the genomic fetch phase.

## Reference documentation
- [RepeatAfterMe Main Documentation](./references/github_com_Dfam-consortium_RepeatAfterMe.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_repeatafterme_overview.md)
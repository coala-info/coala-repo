[ ]
[ ]

[Skip to content](#simplify-taxa)

phu

simplify-taxa

Initializing search

[camilogarciabotero/phu](https://github.com/camilogarciabotero/phu "Go to repository")

phu

[camilogarciabotero/phu](https://github.com/camilogarciabotero/phu "Go to repository")

* [Home](../..)
* [x]

  Commands

  Commands
  + [cluster](../cluster/)
  + [ ]

    simplify-taxa

    [simplify-taxa](./)

    Table of contents
    - [Overview](#overview)
    - [Synopsis](#synopsis)
    - [Input/Output Formats](#inputoutput-formats)

      * [Supported Formats](#supported-formats)
      * [Expected Input Columns](#expected-input-columns)
    - [Transformation Logic](#transformation-logic)

      * [Before Transformation](#before-transformation)
      * [After Transformation](#after-transformation)
      * [Compact Code Format](#compact-code-format)
    - [Command Options](#command-options)
    - [Examples](#examples)

      * [Basic Usage](#basic-usage)
      * [Advanced Usage](#advanced-usage)
    - [Lineage Column Feature](#lineage-column-feature)

      * [Priority Order (Most → Least Specific)](#priority-order-most-least-specific)
      * [Example Output](#example-output)
    - [Special Cases Handled](#special-cases-handled)

      * [Edge Cases for "0" Chains](#edge-cases-for-0-chains)
      * [Multiple Candidates](#multiple-candidates)
    - [Quality Assessment](#quality-assessment)
    - [Workflow Integration](#workflow-integration)

      * [Typical Bioinformatics Pipeline](#typical-bioinformatics-pipeline)
    - [Comparison with Manual Processing](#comparison-with-manual-processing)
    - [Output File Structure](#output-file-structure)
  + [screen](../screen/)

Table of contents

* [Overview](#overview)
* [Synopsis](#synopsis)
* [Input/Output Formats](#inputoutput-formats)

  + [Supported Formats](#supported-formats)
  + [Expected Input Columns](#expected-input-columns)
* [Transformation Logic](#transformation-logic)

  + [Before Transformation](#before-transformation)
  + [After Transformation](#after-transformation)
  + [Compact Code Format](#compact-code-format)
* [Command Options](#command-options)
* [Examples](#examples)

  + [Basic Usage](#basic-usage)
  + [Advanced Usage](#advanced-usage)
* [Lineage Column Feature](#lineage-column-feature)

  + [Priority Order (Most → Least Specific)](#priority-order-most-least-specific)
  + [Example Output](#example-output)
* [Special Cases Handled](#special-cases-handled)

  + [Edge Cases for "0" Chains](#edge-cases-for-0-chains)
  + [Multiple Candidates](#multiple-candidates)
* [Quality Assessment](#quality-assessment)
* [Workflow Integration](#workflow-integration)

  + [Typical Bioinformatics Pipeline](#typical-bioinformatics-pipeline)
* [Comparison with Manual Processing](#comparison-with-manual-processing)
* [Output File Structure](#output-file-structure)

# simplify-taxa[¶](#simplify-taxa "Permanent link")

Convert vContact taxonomy prediction strings into compact lineage codes for downstream analysis.

## Overview[¶](#overview "Permanent link")

`phu simplify-taxa` transforms verbose vContact3 `*_prediction` columns into compact, standardized lineage codes (e.g. `Caudoviricetes:NF2:NG1`) to make taxonomy easier to filter, visualize, and analyze.

## Synopsis[¶](#synopsis "Permanent link")

```
phu simplify-taxa -i <INPUT_FILE> -o <OUTPUT_FILE> [OPTIONS]
```

Input accepts CSV or TSV files from vContact3's `final_assignments.csv` output. Output format is automatically detected from file extension.

## Input/Output Formats[¶](#inputoutput-formats "Permanent link")

### Supported Formats[¶](#supported-formats "Permanent link")

* **Input**: CSV, TSV (auto-detected from extension or `--sep` parameter)
* **Output**: CSV, TSV (auto-detected from file extension)

### Expected Input Columns[¶](#expected-input-columns "Permanent link")

The command automatically detects and processes any columns matching the pattern `*_prediction`:
- `kingdom_prediction`
- `phylum_prediction`
- `class_prediction`
- `order_prediction`
- `family_prediction`
- `subfamily_prediction`
- `genus_prediction`
- `realm_prediction` (if present)

## Transformation Logic[¶](#transformation-logic "Permanent link")

### Before Transformation[¶](#before-transformation "Permanent link")

```
novel_genus_1_of_novel_family_2_of_novel_order_3_of_Caudoviricetes
```

### After Transformation[¶](#after-transformation "Permanent link")

```
Caudoviricetes:NO3:NF2:NG1
```

### Compact Code Format[¶](#compact-code-format "Permanent link")

The transformation uses standardized rank codes:
- `NK` = Novel Kingdom
- `NP` = Novel Phylum
- `NC` = Novel Class
- `NO` = Novel Order
- `NF` = Novel Family
- `NSF` = Novel Subfamily
- `NG` = Novel Genus

## Command Options[¶](#command-options "Permanent link")

```
 Simplify vContact taxonomy prediction columns into compact lineage codes.

 Transforms verbose vContact taxonomy strings like
 'novel_genus_1_of_novel_family_2_of_Caudoviricetes' into compact codes like
 'Caudoviricetes:NF2:NG1'.

 Example:
     phu simplify-taxa -i final_assignments.csv -o simplified.csv
     --add-lineage

╭─ Options ─────────────────────────────────────────────────────────────────╮
│ *  --input-file       -i  PATH  Input vContact final_assignments.csv       │
│                              [required]                                   │
│ *  --output-file      -o  PATH  Output path (.csv or .tsv) [required]      │
│    --add-lineage         FLAG  Append compact_lineage column from deepest │
│                              simplified rank                              │
│    --lineage-col         TEXT  Name of the lineage column                 │
│                              [default: compact_lineage]                   │
│    --sep                 TEXT  Override delimiter: ',' or '\t'.           │
│                              Auto-detected from extension if not set      │
│    --help            -h        Show this message and exit.                │
╰───────────────────────────────────────────────────────────────────────────╯
```

## Examples[¶](#examples "Permanent link")

### Basic Usage[¶](#basic-usage "Permanent link")

```
# Simplify CSV
phu simplify-taxa -i final_assignments.csv -o simplified_taxonomy.csv

# Process TSV format with automatic detection
phu simplify-taxa -i final_assignments.tsv -o simplified_taxonomy.tsv

# Override input delimiter detection
phu simplify-taxa -i data.txt -o output.csv --sep "\t"
```

### Advanced Usage[¶](#advanced-usage "Permanent link")

```
# Add compact lineage column with deepest available classification
phu simplify-taxa -i final_assignments.csv -o simplified.csv --add-lineage

# Customize lineage column name
phu simplify-taxa -i final_assignments.csv -o simplified.csv \
  --add-lineage --lineage-col "best_taxonomy"
```

## Lineage Column Feature[¶](#lineage-column-feature "Permanent link")

The `--add-lineage` option creates an additional column containing the deepest (most specific) available taxonomic classification for each sequence.

### Priority Order (Most → Least Specific)[¶](#priority-order-most-least-specific "Permanent link")

1. `genus_prediction`
2. `subfamily_prediction`
3. `family_prediction`
4. `order_prediction`
5. `class_prediction`
6. `phylum_prediction`
7. `kingdom_prediction`
8. `realm_prediction`

### Example Output[¶](#example-output "Permanent link")

| Sequence | genus\_prediction | family\_prediction | compact\_lineage |
| --- | --- | --- | --- |
| seq1 | Caudoviricetes:NF2:NG1 | Caudoviricetes:NF2 | Caudoviricetes:NF2:NG1 |
| seq2 | - | Caudoviricetes:NF5 | Caudoviricetes:NF5 |
| seq3 | - | - | - |

## Special Cases Handled[¶](#special-cases-handled "Permanent link")

### Edge Cases for "0" Chains[¶](#edge-cases-for-0-chains "Permanent link")

The tool correctly handles vContact2's special "0" designation patterns:

```
# Input
novel_class_0_of_novel_phylum_0_of_novel_kingdom_5_of_Duplodnaviria

# Output
Duplodnaviria:NK5:NP0:NC0
```

### Multiple Candidates[¶](#multiple-candidates "Permanent link")

When vContact2 provides multiple taxonomic candidates (separated by `||`), each is processed independently:

```
# Input
Caudoviricetes:NF1:NG2||Caudoviricetes:NF3:NG4

# Output
Caudoviricetes:NF1:NG2||Caudoviricetes:NF3:NG4
```

## Quality Assessment[¶](#quality-assessment "Permanent link")

After processing, the command provides a summary showing remaining `novel_` strings for quality control:

```
QA Summary:
  genus_prediction: 45 remaining 'novel_' strings
  family_prediction: 12 remaining 'novel_' strings
  order_prediction: 3 remaining 'novel_' strings
```

## Workflow Integration[¶](#workflow-integration "Permanent link")

### Typical Bioinformatics Pipeline[¶](#typical-bioinformatics-pipeline "Permanent link")

```
# 1. Run vContact3 (external)
vcontact3 --nucleotide <viral-genome.fasta> --output-dir <vcontact-output>

# 2. Simplify taxonomy predictions
phu simplify-taxa -i vcontact_output/final_assignments.csv \
  -o taxonomy_simplified.csv --add-lineage

# 3. Use simplified taxonomy for downstream analysis
# - Phylogenetic visualization
# - Diversity analysis
# - Taxonomic filtering
```

## Comparison with Manual Processing[¶](#comparison-with-manual-processing "Permanent link")

| Task | phu simplify-taxa | Manual Processing |
| --- | --- | --- |
| **Complexity** | Single command | Custom scripts/regex |
| **Edge cases** | Automatically handled | Error-prone |
| **Consistency** | Standardized format | Variable approaches |
| **Speed** | Optimized pandas operations | Slower loops |
| **Maintenance** | Built-in updates | Manual fixes needed |

## Output File Structure[¶](#output-file-structure "Permanent link")

The output file preserves the original structure while transforming taxonomy columns:

```
Original columns + Simplified *_prediction columns [+ compact_lineage column]
```

All non-taxonomy columns remain unchanged, ensuring compatibility with existing workflows.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
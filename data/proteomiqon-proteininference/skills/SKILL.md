---
name: proteomiqon-proteininference
description: This tool aggregates peptide-level identifications into protein groups to resolve sequence redundancies and calculate protein-level statistics. Use when user asks to perform protein inference, group peptides into protein identifications, or assign peptide evidence for quantification.
homepage: https://csbiology.github.io/ProteomIQon/
---


# proteomiqon-proteininference

## Overview

Protein inference is the process of aggregating peptide-level identifications into protein-level results. Because many peptides share identical sequences across different proteins (such as splice variants), this tool organizes results into protein groups. It allows for fine-tuned control over how these groups are formed and how peptides are assigned for downstream quantification, providing a "Peptide evidence class" to indicate the purity of the protein group composition.

## Execution Patterns

### Basic Command Line Usage

To map identified peptide sequences to protein groups, use the following syntax:

```bash
proteomiqon -proteininference -i "path/to/input.qpsm" -d "path/to/database.sqlite" -o "path/to/outputDirectory" -p "path/to/params.json"
```

### Processing Multiple Files

You can process multiple scored PSM files simultaneously to share information across runs:

```bash
proteomiqon -proteininference -i "run1.qpsm" "run2.qpsm" "run3.qpsm" -d "database.sqlite" -o "outDirectory" -p "params.json"
```

### Incorporating Genomic Context

Supply a GFF3 file to determine inter-protein relationships and refine protein group assignments:

```bash
proteomiqon -proteininference -i "run.qpsm" -d "db.sqlite" -g "proteome.gff3" -o "outDir" -p "params.json"
```

## Parameter Configuration

The tool requires a `.json` parameter file. Key parameters include:

*   **Protein IntegrationStrictness**: 
    *   `Maximal`: Increases the grouping of proteins that share peptides.
    *   `Minimal`: Results in more granular protein reporting.
*   **PeptideUsageForQuantification**:
    *   `Minimal`: Only uses peptides unique to a protein/group.
    *   `Maximal`: Includes shared peptides in the abundance calculation.
*   **GetQValue**:
    *   `Storey`: Standard method for FDR calculation.
    *   `LogisticRegression`: Alternative semi-supervised approach.
    *   `NoQValue`: Skips FDR calculation at the protein level.

## Best Practices

*   **Input Requirements**: Ensure that the input `.qpsm` files have already passed FDR thresholds via the `PSMStatistics` tool.
*   **Database Consistency**: Always use the same SQLite peptide database (`-d`) that was used during the `PeptideSpectrumMatching` and `PSMStatistics` steps.
*   **Regex Matching**: Ensure the `ProteinIdentifierRegex` in your parameters matches the ID format used in your FASTA/Database (default is often `"id"`).
*   **Group Files**: Set `GroupFiles` to `true` when you want to perform a global protein inference across multiple MS runs, which improves the consistency of protein identification across a project.

## Reference documentation
- [Protein Inference](./references/csbiology_github_io_ProteomIQon_tools_ProteinInference.html.md)
- [ProteomIQon Overview](./references/csbiology_github_io_ProteomIQon.md)
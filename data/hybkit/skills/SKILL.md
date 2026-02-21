---
name: hybkit
description: `hybkit` is a specialized bioinformatic suite designed for the processing and analysis of RNA proximity-ligation data.
homepage: https://github.com/RenneLab/hybkit
---

# hybkit

## Overview

`hybkit` is a specialized bioinformatic suite designed for the processing and analysis of RNA proximity-ligation data. It provides a standardized framework for handling the `.hyb` format, which represents chimeric RNA sequences, often in conjunction with predicted secondary structure data (Vienna or CT formats). Use this skill to perform quality control, filter specific hybrid populations (such as miRNA-target pairs), and generate statistical analyses or plots from chimeric RNA experiments like CLASH or qCLASH.

## Core CLI Utilities

The toolkit provides four primary command-line utilities. Most commands accept a hyb file (`-i`) and an optional fold file (`-f`).

### 1. hyb_check
Use this to validate the integrity of your data files.
- **Purpose**: Parse hyb and fold files to identify formatting errors or inconsistencies.
- **Pattern**: `hyb_check -i input.hyb -f input.vienna`

### 2. hyb_eval
Use this to annotate your hybrids based on custom criteria.
- **Purpose**: Assign segment types (e.g., miRNA, mRNA, lncRNA) to the chimeric fragments.
- **Pattern**: `hyb_eval -i input.hyb --criteria custom_criteria.txt`

### 3. hyb_filter
Use this to create subsets of your data based on sequence content or attributes.
- **Purpose**: Extract specific hybrids, such as those containing a specific virus or gene.
- **Common Pattern**: `hyb_filter -i input.hyb -f input.vienna --filter <filter_type> <value>`
- **Example (Filter by ID)**: `hyb_filter -i data.hyb --filter any_seg_contains kshv`

### 4. hyb_analyze
Use this for high-level data synthesis and visualization.
- **Purpose**: Perform energy, type, miRNA, target, or fold analysis.
- **Output**: Generates tabular data (CSV) and graphical plots (e.g., pie charts of sequence types).
- **Pattern**: `hyb_analyze -i input.hyb --type target`

## Python API Best Practices

For custom workflows, use the `hybkit` Python module. It follows a pattern similar to BioPython.

### File Handling
Always use the context manager (`with` statement) to ensure proper file closure.
```python
import hybkit

# Open and iterate through a hyb file
with hybkit.HybFile.open('data.hyb', 'r') as hyb_file:
    for hyb_record in hyb_file:
        # Process record
        pass
```

### Record Manipulation
- **Type Evaluation**: Call `hyb_record.eval_types()` before checking for specific segment types.
- **Property Checking**: Use `hyb_record.has_prop(property_name, value)` for flexible filtering within scripts.
- **Fold Data**: Use `HybFoldIter` to iterate through hyb and fold files simultaneously, keeping records synchronized.

## Expert Tips
- **Secondary Structure**: When performing fold analysis, ensure your `.vienna` or `.ct` files match the order of the `.hyb` file.
- **Memory Efficiency**: For very large datasets, prefer the CLI filters or the API's iterative processing over loading entire datasets into memory.
- **Visualization**: `hyb_analyze` relies on `matplotlib`. Ensure a backend is available if running in a headless environment (e.g., use `Agg`).

## Reference documentation
- [hybkit Overview](./references/anaconda_org_channels_bioconda_packages_hybkit_overview.md)
- [hybkit GitHub Repository](./references/github_com_RenneLab_hybkit.md)
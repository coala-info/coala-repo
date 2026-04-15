---
name: primers
description: The primers tool designs and scores PCR primers for DNA assembly and synthetic biology applications. Use when user asks to create primer pairs for a target sequence, add 5' sequences for DNA assembly, check for off-target binding, or evaluate the quality of existing primers.
homepage: https://github.com/Lattice-Automation/primers
metadata:
  docker_image: "quay.io/biocontainers/primers:0.5.10--pyhdfd78af_0"
---

# primers

## Overview
The `primers` tool is a specialized utility for designing PCR primers, particularly for synthetic biology and DNA assembly. Unlike general-purpose tools, it excels at calculating the impact of 5' additions (like restriction sites or overlap sequences) on the total melting temperature and secondary structure. It uses a penalty-based scoring system to find the optimal primer pair by balancing length, Tm, GC ratio, and off-target binding.

## Usage Guidelines

### Basic Primer Creation
To generate a forward and reverse primer pair for a target sequence:
```bash
primers create <SEQUENCE>
```

### DNA Assembly (5' Additions)
When performing Gibson Assembly or Golden Gate cloning, use the `-f` (forward) and `-r` (reverse) flags to add specific sequences to the 5' ends.
*   **Fixed Additions**: Prepend the entire sequence.
    ```bash
    primers create -f GGTCTC -r GAAGAC <SEQUENCE>
    ```
*   **Variable Additions**: Allow the tool to choose the best subsequence from a range to optimize the total Tm.
    ```bash
    primers create -f GGATCGAGCTTGA -fl 5 12 <SEQUENCE>
    ```

### Off-Target Checking
To minimize non-specific binding, provide a template sequence (e.g., a plasmid backbone or genome) to check against:
```bash
primers create -t <TEMPLATE_SEQUENCE> <TARGET_SEQUENCE>
```

### Scoring Existing Primers
If you already have primer sequences and want to evaluate their quality against a template:
```bash
primers score <FWD_SEQ> <REV_SEQ> -s <TEMPLATE_SEQUENCE> --json
```

## Best Practices and Expert Tips
*   **Tm vs. Total Tm**: Pay attention to both `tm` (annealing portion) and `ttm` (total Tm including 5' additions). For the first few cycles of PCR, the `tm` is critical; for subsequent cycles, the `ttm` dominates.
*   **Penalty Scores**: The `p` column represents the penalty. A lower score is better. If penalties are high, check the JSON output (`--json`) to see if the issue is `penalty_dg` (secondary structure) or `penalty_tm_diff` (mismatched pairs).
*   **Secondary Structure**: The tool calculates `dg` (minimum free energy). Values closer to 0 are better. Highly negative `dg` values indicate stable hairpins or dimers that may inhibit PCR.
*   **JSON Integration**: For automated workflows, always use the `-j` or `--json` flag. This provides a detailed breakdown of the scoring components (penalty_gc, penalty_len, etc.), which is useful for debugging why a specific primer was chosen.
*   **Optimization Parameters**: In Python scripts, you can override defaults for `optimal_tm` (default 62.0) and `optimal_gc` (default 0.5) within the `create()` function to match specific polymerase requirements.



## Subcommands

| Command | Description |
|---------|-------------|
| primers create | create primers to amplify this sequence |
| primers score | Score primers based on amplification and off-target binding. |

## Reference documentation
- [primers README](./references/github_com_Lattice-Automation_primers_blob_master_README.md)
- [primers Repository Overview](./references/github_com_Lattice-Automation_primers.md)
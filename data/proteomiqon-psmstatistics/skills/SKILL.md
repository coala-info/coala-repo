---
name: proteomiqon-psmstatistics
description: This tool statistically evaluates and refines peptide-spectrum matches by calculating false discovery rates and confidence metrics using machine learning. Use when user asks to consolidate search engine scores, calculate Q-values or PEP values, and filter PSM results based on statistical thresholds.
homepage: https://csbiology.github.io/ProteomIQon/
metadata:
  docker_image: "quay.io/biocontainers/proteomiqon-psmstatistics:0.0.8--hdfd78af_0"
---

# proteomiqon-psmstatistics

## Overview
The `proteomiqon-psmstatistics` tool is designed to refine peptide identifications by statistically evaluating the quality of matches between measured MS/MS spectra and theoretical peptide sequences. By utilizing decoy databases (reversed peptide sequences), the tool applies machine learning to distinguish between true positive identifications and random matches. 

Use this tool when you need to:
1. Consolidate multiple search engine scores into a unified confidence metric.
2. Calculate Q-values (global FDR) and PEP values (local FDR) for peptide identifications.
3. Filter PSM results based on specific statistical thresholds before performing protein inference or quantification.

## CLI Usage and Patterns

### Basic Execution
To process a single PSM file against a peptide database:
```bash
proteomiqon-psmstatistics -i "path/to/run.psm" -d "path/to/database.sqlite" -o "path/to/outDirectory" -p "path/to/params.json"
```

### Parallel Processing
If working with multiple runs, use the `-c` flag to specify the number of CPU cores for parallel execution:
```bash
proteomiqon-psmstatistics -i "run1.psm" "run2.psm" "run3.psm" -d "database.sqlite" -o "output/" -p "params.json" -c 3
```

### Diagnostic Plotting
To evaluate the performance of the machine learning scorer and visualize the separation between decoys and target peptides, use the `-dc` flag:
```bash
proteomiqon-psmstatistics -i "run.psm" -d "database.sqlite" -o "output/" -p "params.json" -dc
```

## Parameter Configuration
The tool requires a JSON parameter file. Key parameters within this file include:

- **Threshold**: Defines the FDR cutoffs.
    - `QValueThreshold`: Typically set to `0.01` (1% global FDR).
    - `PepValueThreshold`: Typically set to `0.05`.
- **PepValueFittingMethod**: Usually set to `LinearLogit`.
- **ParseProteinIDRegexPattern**: A regex string (default `"id"`) used to extract protein identifiers from the database.
- **KeepTemporaryFiles**: Set to `true` if you need to debug the intermediate machine learning iterations.

### Example Parameter Structure (JSON)
```json
{
  "Threshold": {
    "Case": "Estimate",
    "Fields": [
      {
        "QValueThreshold": 0.01,
        "PepValueThreshold": 0.05,
        "MaxIterations": 15,
        "MinimumIncreaseBetweenIterations": 0.005,
        "PepValueFittingMethod": "LinearLogit"
      }
    ]
  },
  "ParseProteinIDRegexPattern": "id",
  "KeepTemporaryFiles": false
}
```

## Best Practices
- **Decoy Database**: Ensure the input `.psm` files were generated using a database containing decoys, as the tool relies on them to estimate the null distribution of scores.
- **Memory Management**: When processing many files in parallel with `-c`, ensure the system has sufficient RAM, as each thread will load a portion of the PSM data and the SQLite database into memory.
- **Iteration Tuning**: If the machine learning model fails to converge, consider increasing `MaxIterations` or adjusting the `MinimumIncreaseBetweenIterations` in the parameter file.

## Reference documentation
- [PSMStatistics Documentation](./references/csbiology_github_io_ProteomIQon_tools_PSMStatistics.html.md)
- [ProteomIQon Overview](./references/csbiology_github_io_ProteomIQon.md)
---
name: igblast-parser
description: This tool converts verbose IgBLAST output files into structured CSV tables or Python dictionaries for easier data analysis. Use when user asks to parse IgBLAST results, convert V(D)J alignment data to CSV, or extract immunoglobulin sequence features into a dataframe.
homepage: https://github.com/aerijman/igblast-parser
metadata:
  docker_image: "quay.io/biocontainers/igblast-parser:0.0.4--py39hf95cd2a_6"
---

# igblast-parser

## Overview

IgBLAST provides detailed information about immunoglobulin and T cell receptor sequences, including V(D)J germline gene matches and junctional analysis. However, its default output is often verbose and difficult to use directly in statistical software. The `igblast-parser` tool automates the extraction of these features into a flat CSV table. Use this skill to streamline the transition from sequence alignment to data analysis, especially when working with large repertoires where manual parsing is impossible.

## Installation

The tool can be installed via Conda or Pip:

```bash
# Via Bioconda (Recommended)
conda install -c bioconda igblast-parser

# Via Pip
pip install igblast-parser
```

## Command Line Usage

The parser supports both direct file arguments and standard input piping.

### Basic CLI Pattern
Specify the input file and the desired output prefix:

```bash
igblast-parser --in input_igblast.txt --out parsed_results
```
*Note: The `--out` argument specifies the prefix; the tool will generate a `.csv` file.*

### Piping Pattern
For integration into bioinformatics pipelines, use standard input:

```bash
cat input_igblast.txt | igblast-parser
```

## Python API Usage

If working within an interactive Python environment (like Jupyter) or a custom script, you can use the parser directly to create a Pandas DataFrame.

```python
import pandas as pd
from igblast_parser import igblast_parse

# Open the IgBLAST output file
with open('igblast.output', 'r') as f_in:
    # Parse into a dictionary (UMI/Sequence ID as primary key)
    parsed_data = igblast_parse(f_in)

# Convert to a structured DataFrame
df = pd.DataFrame(parsed_data).T

# Save or analyze
df.to_csv('parsed_output.csv')
```

## Best Practices

- **Input Format**: Ensure your IgBLAST output is in the standard text format. The parser is designed to handle the complex alignment blocks and junction details provided by the default IgBLAST output.
- **Downstream Analysis**: The resulting CSV uses the sequence ID (or UMI if present) as the primary identifier. This makes it easy to merge with other metadata using `pandas.merge()` or similar join operations in R.
- **Large Files**: When dealing with extremely large IgBLAST files, the CLI piping method (`cat file | igblast-parser`) is often the most memory-efficient way to handle the stream.

## Reference documentation

- [igblast-parser Overview](./references/anaconda_org_channels_bioconda_packages_igblast-parser_overview.md)
- [igblast-parser GitHub Repository](./references/github_com_aerijman_igblast-parser.md)
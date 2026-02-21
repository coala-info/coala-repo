---
name: seqlogo
description: `seqlogo` is a Python port of the R Bioconductor `seqLogo` package, utilizing the WebLogo API for rendering.
homepage: https://github.com/betteridiot/seqlogo
---

# seqlogo

## Overview
`seqlogo` is a Python port of the R Bioconductor `seqLogo` package, utilizing the WebLogo API for rendering. It provides a streamlined workflow for handling various Position Matrix (PM) formats and converting them into information-rich sequence logos. The tool is particularly effective for analyzing sequence motifs at genomic sites or within protein sequences, supporting a wide range of biological alphabets including DNA, RNA, and Amino Acids (AA).

## Core Workflows

### 1. Working with Position Probability Matrices (PPM)
If you have probability data where each position's values sum to 1, use the `Ppm` class. If no count data is provided, the tool generates Position Frequency Matrix (PFM) data by multiplying probabilities by 100 for compatibility.

```python
import seqlogo
import numpy as np

# Create a PPM from a numpy array or list
data = np.array([[0.1, 0.5, 0.2, 0.2], [0.0, 0.1, 0.1, 0.8]])
ppm = seqlogo.Ppm(data)
```

### 2. Converting Frequency Data (PFM) to Weight Matrices (PWM)
To compute Information Content and log-likelihood values from raw counts, use the `pfm2pwm` function.

```python
import pandas as pd
# pfm is a DataFrame where columns are alphabet letters and rows are positions
pwm = seqlogo.pfm2pwm(pfm_dataframe)
```

### 3. Comprehensive Matrix Management
The `CompletePM` class is the most powerful entry point, allowing you to input one matrix type and automatically impute the others (PFM, PPM, and PWM) using default backgrounds and pseudocounts.

```python
cpm = seqlogo.CompletePM(ppm = my_ppm_data)
print(cpm.pwm) # Access the calculated PWM
print(cpm.pfm) # Access the imputed PFM
```

## Visualization and Rendering
The `seqlogo` function (or the `.seqlogo` method on PM objects) handles the actual image generation.

### Supported Formats and Sizes
- **Formats**: `svg`, `eps`, `pdf`, `jpeg`, `png` (default).
- **Sizes**: 
  - `small`: 3.54" wide
  - `medium`: 5" wide
  - `large`: 7.25" wide
  - `xlarge`: 10.25" wide

### Alphabet Selection
Ensure you specify the correct alphabet for your data to avoid rendering errors:
- **DNA**: "DNA", "reduced DNA", "ambig DNA"
- **RNA**: "RNA", "reduced RNA", "ambig RNA"
- **Protein**: "AA", "reduced AA", "ambig AA"

## Expert Tips and Best Practices
- **Pseudocounts**: When converting PPM to PWM, `seqlogo` applies pseudocounts automatically to prevent probabilities of 0 from resulting in negative infinity.
- **Input Format**: Plain text files should be whitespace-delimited. The number of columns must match the alphabet size (e.g., 4 for DNA), and rows must match the sequence length.
- **Comments**: The tool automatically skips lines starting with `#` in matrix files.
- **Environment**: For the best experience, use `seqlogo` within an IPython or Jupyter environment to take advantage of inline plotting capabilities.
- **Ghostscript Dependency**: If generating PDF or EPS formats, ensure Ghostscript is installed and available on your system path.

## Reference documentation
- [GitHub Repository - seqlogo](./references/github_com_betteridiot_seqlogo.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_seqlogo_overview.md)
---
name: minvar
description: MinVar detects minority variants in HIV-1 and HCV populations from deep sequencing data. Use when user asks to analyze viral deep sequencing data to identify drug resistance mutations in HIV-1 and HCV.
homepage: https://git.io/minvar
---


# minvar

minvar/
├── SKILL.md
└── references/
    ├── anaconda_org_channels_bioconda_packages_minvar_overview.md
    └── ozagordi_github_io_MinVar.md
```

minvar/SKILL.md:
```markdown
---
name: minvar
description: A command-line tool to detect minority variants in HIV-1 and HCV populations using deep sequencing data. Use when analyzing viral deep sequencing data (FASTQ format) to identify drug resistance mutations in HIV-1 and HCV.
---
## Overview
MinVar is a command-line utility designed for the detection of minority variants, specifically focusing on drug resistance mutations in HIV-1 and HCV populations from deep sequencing data. It simplifies the analysis by requiring only a FASTQ input file and automatically generating a PDF report detailing identified mutations and their frequencies, along with resistance predictions for HIV-1.

## Usage Instructions

MinVar is designed for straightforward command-line execution. The primary input is a FASTQ file containing the sequencing reads.

### Basic Usage

The most common usage involves providing the input FASTQ file. MinVar will then process the data and generate a PDF report.

```bash
minvar --fastq <input.fastq>
```

### Output

By default, MinVar generates a PDF report. This report contains:
- For HIV-1: Resistance information to antiviral drugs as predicted by HIVDB.
- For HCV: An estimate of the genotype and a list of resistance-associated substitutions (RAS) with their frequencies.

### Key Features and Tips

*   **Input Format**: Ensure your input file is in FASTQ format.
*   **No Parameter Tuning Required**: For standard analysis, MinVar is designed to work without requiring complex parameter adjustments.
*   **Accuracy Threshold**: MinVar reliably calls variants down to 5%, which is recommended as an accurate detection threshold.
*   **Speed**: The tool is efficient, with runtimes typically in the order of a few minutes per sample.
*   **Platform Versatility**: MinVar has been tested with reads from Illumina MiSeq and Roche/454 sequencing platforms (HCV was tested with Illumina only).

## Reference documentation
- [MinVar Overview](https://anaconda.org/bioconda/minvar)
- [MinVar Documentation](https://ozagordi.github.io/MinVar/)
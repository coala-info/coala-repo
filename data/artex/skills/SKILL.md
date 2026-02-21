---
name: artex
description: Artex (Artic pipeline extension) is a bioinformatics tool designed to salvage variants at low-coverage or low-quality sites that are typically missed or filtered out by the standard ARTIC pipeline.
homepage: https://github.com/JMencius/Artex
---

# artex

## Overview

Artex (Artic pipeline extension) is a bioinformatics tool designed to salvage variants at low-coverage or low-quality sites that are typically missed or filtered out by the standard ARTIC pipeline. It functions by utilizing the amplicon mode of Clair3 to re-call variants within the regions identified in ARTIC's `FAIL.vcf` output. The tool then merges these recovered variants with the original "PASS" variants to produce a more comprehensive genomic profile, which is critical for identifying mutations in key areas like the S-gene that might otherwise be lost.

## Installation and Environment

Artex is primarily tested on Linux and is available via Bioconda.

```bash
# Recommended installation via Conda
conda create -n artex python=3.9.0
conda activate artex
conda install -c bioconda artex

# Verify installation
artex --test
```

## Command Line Usage

### Mandatory Parameters
To run a standard recovery, you must provide the input ARTIC directory, an output directory, and the basecalling configuration.

```bash
artex -i <artic_output_dir> -o <output_dir> -c <config>
```

*   **`-i, --input`**: Path to the directory containing ARTIC pipeline results.
*   **`-o, --output`**: Path where Artex results will be stored.
*   **`-c, --config`**: Basecalling configuration. Supported pre-downloaded Clair3 models include: `[R9G2, R9G4, R9G6]`.

### Advanced Options
*   **R10 Data**: If working with R10 configurations, you must manually specify the Clair3 model file using `-m` or `--model`.
*   **Performance**: Use `-t` or `--threads` to specify parallel threads for Clair3 (e.g., `-t 12`).
*   **Filtering**: Adjust `--min_coverage` to change the minimum depth required for Artex to attempt a re-call (default is tool-defined).
*   **Prefixing**: Use `-p` or `--prefix` to name your output files specifically.

### Example Workflow
```bash
artex --verbose -i ./artic_results/sample01 -o ./artex_results/sample01 -c R9G4
```

## Output Interpretation

After execution, the output directory contains several intermediate files and one primary result:

| File/Folder | Description |
| :--- | :--- |
| `sample.artex.vcf.gz` | **Final Result**: Combined VCF containing both original ARTIC PASS variants and Artex-recovered variants. |
| `artic.fail.vcf.gz` | The filtered variants extracted from the input ARTIC directory. |
| `clair3/` | Directory containing the raw Clair3 re-calling output. |
| `for_merge/0000.vcf` | The specific extra variants identified by Artex before merging. |

## Best Practices and Tips

*   **S-Gene Sensitivity**: Artex is specifically optimized to find variants in the S-gene that standard pipelines might drop. If your ARTIC consensus has N-masked regions in the Spike protein, running Artex is highly recommended.
*   **Resource Management**: Clair3 is computationally intensive. Ensure you allocate sufficient threads (`-t`) and monitor memory usage during the re-calling phase.
*   **Model Selection**: Always match the `-c` config to the flowcell and kit used during sequencing (e.g., R9.4.1 vs R10). Using the wrong model will lead to inaccurate variant calls.
*   **Validation**: Compare the `sample.artex.vcf.gz` against the original ARTIC `PASS.vcf` to see exactly which variants were recovered.

## Reference documentation
- [Artex Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_artex_overview.md)
- [Artex GitHub Repository](./references/github_com_JMencius_Artex.md)
---
name: msa4u
description: msa4u aligns biological sequences using MAFFT and generates publication-quality PDF visualizations of the results. Use when user asks to align sequences, visualize existing alignments, or customize sequence labels in alignment plots.
homepage: https://github.com/GCA-VH-lab/msa4u
metadata:
  docker_image: "quay.io/biocontainers/msa4u:0.4.0--pyh7e72e81_0"
---

# msa4u

## Overview
msa4u is a specialized tool for biological sequence analysis that streamlines the transition from raw sequence data to visual alignment plots. It serves two primary functions: acting as a wrapper for the MAFFT alignment algorithm and providing a rendering engine to produce clean, publication-quality PDF visualizations. It is particularly useful for researchers who need a quick, command-line driven way to inspect sequence conservation and alignment quality without manual formatting.

## Command Line Usage

### Basic Alignment and Visualization
To align unaligned sequences and generate a PDF in one step:
```bash
msa4u -fa sequences.fa
```
*   **Input**: A FASTA file with unaligned sequences.
*   **Process**: Runs `mafft --auto` internally.
*   **Output**: Generates `sequences.aln.fa` (alignment) and `sequences.pdf` (plot).

### Visualizing Existing Alignments
If you already have an aligned FASTA file, use the `-aln` flag to skip the alignment step:
```bash
msa4u -aln aligned_sequences.fasta -o custom_plot.pdf
```

### Label Customization
Control how sequences are identified in the output PDF using the `-label` parameter:
*   `id`: Uses only the sequence ID.
*   `description`: Uses the sequence description.
*   `all`: Uses the full FASTA header.

Example:
```bash
msa4u -aln input.aln.fa -label description -o visualization.pdf
```

### Post-Installation Setup
*   **Linux Users**: After installation, run the following command once to ensure configuration paths are correctly mapped for Linux environments:
    ```bash
    msa4u --linux
    ```
*   **Sample Data**: To download example datasets for testing:
    ```bash
    msa4u --data
    ```

## Python API Integration
For programmatic workflows, msa4u can be imported directly into Python scripts.

### Programmatic Alignment and Plotting
```python
import msa4u

# Initialize parameters
parameters = msa4u.manager.Parameters()

# Load and align
fasta = msa4u.manager.Fasta(fasta="sequences.fa", parameters=parameters)
mafft_output = fasta.run_mafft()

# Generate plot
msa = msa4u.manager.MSA(mafft_output, parameters)
msa.plot()
```

### Plotting Pre-aligned Data via API
```python
import msa4u

parameters = msa4u.manager.Parameters()
parameters.arguments["label"] = "description"
parameters.arguments["output_filename"] = "output.pdf"

msa = msa4u.manager.MSA("aligned.fasta", parameters)
msa.plot()
```

## Best Practices
*   **MAFFT Versioning**: The tool expects MAFFT to be available. While a version is often bundled, ensure your environment's PATH includes MAFFT if you encounter alignment errors.
*   **Output Management**: Always specify the `-o` flag when running multiple visualizations in the same directory to prevent the default `aa_sequences.pdf` from being overwritten.
*   **Large Alignments**: For very large alignments, PDF generation via `reportlab` can be resource-intensive. Consider subsetting sequences if the output file becomes unwieldy.

## Reference documentation
- [msa4u GitHub Repository](./references/github_com_GCA-VH-lab_msa4u.md)
- [msa4u Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_msa4u_overview.md)
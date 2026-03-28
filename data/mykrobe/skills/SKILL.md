---
name: mykrobe
description: "Predicts antibiotic resistance from genome sequence data for specific bacterial species. Use when you need to predict antibiotic resistance profiles for Staphylococcus aureus and Mycobacterium tuberculosis from their genome sequences."
homepage: https://github.com/iqbal-lab/Mykrobe-predictor
---

# mykrobe

Predicts antibiotic resistance from genome sequence data for specific bacterial species.
  Use when you need to rapidly determine antibiotic resistance profiles for Staphylococcus aureus and Mycobacterium tuberculosis based on their genomic data.
---
## Overview

The mykrobe tool is designed for rapid prediction of antibiotic resistance in bacterial pathogens, specifically focusing on *Staphylococcus aureus* and *Mycobacterium tuberculosis*. It analyzes genome sequence data to identify genetic markers associated with resistance, providing quick insights that can aid in clinical and research settings.

## Usage Instructions

mykrobe is a command-line tool for predicting antibiotic resistance from genome sequence data. It is primarily used for *Staphylococcus aureus* and *Mycobacterium tuberculosis*.

### Core Command Structure

The general structure for using mykrobe is:

```bash
mykrobe predict --input <genome_file> --species <species_name>
```

### Key Arguments and Options

*   `--input <genome_file>`: Path to the input genome sequence file (e.g., FASTA format).
*   `--species <species_name>`: Specifies the bacterial species for analysis. Supported species include `staphylococcus_aureus` and `mycobacterium_tuberculosis`.
*   `--output <output_file>`: (Optional) Path to save the prediction results to a file.
*   `--threads <num_threads>`: (Optional) Number of CPU threads to use for the prediction.
*   `--verbose`: (Optional) Enable verbose output for more detailed logging.

### Common Workflows and Examples

1.  **Predicting resistance for *Staphylococcus aureus***:

    ```bash
    mykrobe predict --input my_staph_genome.fasta --species staphylococcus_aureus
    ```

2.  **Predicting resistance for *Mycobacterium tuberculosis* and saving to a file**:

    ```bash
    mykrobe predict --input my_tb_genome.fasta --species mycobacterium_tuberculosis --output resistance_predictions.txt
    ```

3.  **Using multiple threads for faster processing**:

    ```bash
    mykrobe predict --input my_genome.fasta --species staphylococcus_aureus --threads 4
    ```

### Expert Tips

*   **Ensure correct species designation**: Always verify that the `--species` argument accurately reflects the organism in your input genome file. Incorrect species can lead to erroneous predictions.
*   **Input file format**: mykrobe typically expects genome sequences in FASTA format. Ensure your input file is correctly formatted.
*   **Check for updates**: Regularly check for updates to mykrobe to benefit from improved prediction models and expanded resistance gene databases. The bioconda channel is a reliable source for the latest versions.
*   **Interpreting results**: The output will detail predicted resistance or susceptibility to various antibiotics based on identified genetic markers. Consult the mykrobe documentation or relevant literature for detailed interpretation of the resistance profiles.



## Subcommands

| Command | Description |
|---------|-------------|
| mykrobe predict | Predicts antimicrobial resistance from sequencing data. |
| mykrobe variants | Manage variant databases |
| mykrobe_panels | Manage mykrobe panels |
| mykrobe_variants | mykrobe variants |

## Reference documentation
- [Overview](./references/anaconda_org_channels_bioconda_packages_mykrobe_overview.md)
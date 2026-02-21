---
name: codingquarry
description: CodingQuarry is a specialized gene prediction tool designed specifically for fungal genomes.
homepage: https://sourceforge.net/p/codingquarry/
---

# codingquarry

## Overview
CodingQuarry is a specialized gene prediction tool designed specifically for fungal genomes. It utilizes Hidden Markov Models (HMMs) and is optimized to integrate RNA-seq transcript data to improve the accuracy of gene models. It is particularly effective for fungal biology due to its ability to handle AT-rich regions and its dedicated mode for predicting effector proteins in plant pathogens.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::codingquarry
```

## Core CLI Usage and Best Practices

### Training with Annotations
When supplying an existing annotation file for training, use the `-a` parameter.
- **GFF Compatibility**: Ensure the GFF file follows standard specifications. CodingQuarry expects the stop codon to be included as part of the CDS.
- **Phase Field**: Ensure the phase field in your GFF is correctly calculated, as this is critical for HMM training.

### Handling AT-Rich Genomes
Fungal genomes often contain repeat-rich, AT-rich regions (e.g., *Leptosphaeria maculans*). 
- **GC Cut-off**: Use the `-c` parameter to supply a %GC content cut-off. 
- **Purpose**: This excludes intergenic regions with GC content below the threshold from the training set, preventing the model from being biased by non-coding AT-rich sequences.

### Pathogen Mode (CodingQuarry-PM)
For researchers working on fungal plant pathogens, use the Pathogen Mode to assist in the prediction of effectors.
- **Execution**: Run the specific `CodingQuarry-PM` binary or flag (depending on the version's PATH setup) to enable effector-specific prediction logic.

### Sequence Masking
CodingQuarry supports soft-masking of genomes.
- **Format**: Represent repeats using lower-case letters in your FASTA genome file.
- **Benefit**: This allows the predictor to recognize repeat regions without losing the underlying sequence information required for accurate HMM processing.

### Primary Outputs
After a run, the tool generates an output directory (typically named `out/`).
- **Predicted CDS**: The nucleotide sequences of predicted coding sequences are stored in `out/Predicted_CDS.fa`.
- **GFF3**: The structural annotations are provided in GFF3 format, including corrected stop codon and phase information.

## Reference documentation
- [CodingQuarry Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_codingquarry_overview.md)
- [CodingQuarry Wiki Home](./references/sourceforge_net_p_codingquarry_wiki_Home.md)
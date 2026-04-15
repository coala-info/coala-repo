---
name: rfplasmid
description: RFPlasmid uses Random Forest models to classify genomic contigs as either chromosomal or plasmid-derived based on kmer frequencies and marker genes. Use when user asks to predict plasmid sequences, classify genomic contigs, or separate mobile genetic elements from bacterial chromosomes.
homepage: https://github.com/aldertzomer/RFPlasmid
metadata:
  docker_image: "quay.io/biocontainers/rfplasmid:0.0.18--pyhdfd78af_0"
---

# rfplasmid

## Overview
RFPlasmid is a machine-learning tool that utilizes Random Forest models to classify genomic contigs. It evaluates sequences based on pentamer frequencies (kmers), contig size, and the presence of single-copy chromosomal marker genes versus plasmid-specific replication and typing genes. By integrating these features, it provides high-accuracy predictions (up to 99% sensitivity/specificity) to help researchers separate mobile genetic elements from the primary bacterial chromosome.

## Installation and Setup
Before the first run, the tool must download and prepare its internal databases.
```bash
# Initialize the plasmid databases (required once after installation)
rfplasmid --initialize
```

## Core Usage Patterns
The tool requires a directory of FASTA files as input and the specification of a target species model.

### Standard Prediction
```bash
rfplasmid --species <SpeciesName> --input <input_folder> --out <output_folder> --threads 8
```

### High-Performance Mode
It is strongly recommended to use Jellyfish for kmer counting, as the native Python implementation is significantly slower.
```bash
rfplasmid --species <SpeciesName> --input <input_folder> --jelly --threads 16 --out <output_folder>
```

## Model Selection
RFPlasmid performs best when using taxon-specific models.
- **Specific Taxa**: Use the exact name (e.g., `Campylobacter`, `Staphylococcus`, `Pseudomonas`).
- **Enterobacteriaceae**: Use the `Enterobacteriaceae` model for any genus within this family (e.g., E. coli, Salmonella, Klebsiella).
- **Unknown/Metagenomics**: Use the `Generic` model for samples where the species is unknown or for mixed community assemblies.
- **List Models**: Run `rfplasmid --specieslist` to see all 19+ available models.

## Expert Tips and Best Practices
- **Contig Length Constraints**: Predictions for very small contigs are often unreliable. These sequences frequently consist of repeat elements (like transposases) found in both chromosomes and plasmids, making kmer profiles and marker gene identification difficult.
- **Input Format**: Ensure the input directory contains only `.fasta` files. While some versions support `.fna`, `.fasta` is the standard expected extension.
- **Resource Management**: The `--threads` flag defaults to the maximum available up to 16. For large batches of assemblies, explicitly set this to balance system load.
- **Output Interpretation**: Review the generated `.rfo` files in the output directory. These contain the probability scores for each contig; higher scores indicate higher confidence in the plasmid/chromosome assignment.
- **Debugging**: If a run fails or produces unexpected results, use the `--debug` flag to prevent the tool from cleaning up intermediate files (DIAMOND blast results, kmer counts), allowing for manual inspection of the pipeline stages.

## Reference documentation
- [RFPlasmid GitHub Repository](./references/github_com_aldertzomer_RFPlasmid.md)
- [RFPlasmid Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rfplasmid_overview.md)
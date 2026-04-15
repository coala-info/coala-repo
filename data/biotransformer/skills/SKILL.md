---
name: biotransformer
description: BioTransformer predicts the metabolic products of small molecules across various biological and environmental systems using machine learning and rule-based models. Use when user asks to predict metabolic transformations, simulate human or microbial metabolism, or identify potential metabolites for drug discovery and toxicology.
homepage: https://bitbucket.org/djoumbou/biotransformer
metadata:
  docker_image: "quay.io/biocontainers/biotransformer:3.0.20230403--hdfd78af_0"
---

# biotransformer

## Overview
BioTransformer is a computational tool designed to predict the metabolic products of small molecules across various biological systems. It utilizes a combination of machine learning and rule-based approaches to simulate transformations in human tissues, the gut microbiome, and environmental settings (soil and water). This skill enables the systematic exploration of metabolic pathways to support drug discovery, toxicology, and environmental chemistry.

## Command Line Usage
BioTransformer is typically executed as a JAR file. Use the following patterns for common metabolic prediction tasks.

### Basic Prediction Syntax
Run a prediction by specifying the input molecule (SMILES or SDF), the transformation type, and the number of steps.

```bash
java -jar BioTransformer.jar -k <mode> -i <input_smiles> -s <steps> -o <output_file>
```

### Transformation Modes (-k)
Select the appropriate metabolism model based on the biological context:
- `ecbased`: Enzyme Commission-based transformations (general metabolism).
- `cyp450`: Cytochrome P450-mediated metabolism (human/mammalian liver).
- `phaseII`: Phase II transformations (conjugation reactions like glucuronidation).
- `hgut`: Human gut microbial metabolism.
- `env`: Environmental microbial metabolism (soil and aquatic).
- `all`: Executes all available transformation rules sequentially.

### Common CLI Options
- `-i`: Input molecule. Can be a SMILES string or a path to an .sdf file.
- `-s`: Number of metabolic steps (generations) to simulate (default is 1).
- `-o`: Output file path (usually .csv or .sdf).
- `-b`: Processing mode. Use `mass` for metabolite identification based on a target mass, or `none` for general prediction.
- `-t`: Mass tolerance (in Da or ppm) when using mass-based identification.

## Best Practices
- **Limit Steps**: For most drug metabolism studies, 1 or 2 steps are sufficient. Increasing steps exponentially grows the number of predicted metabolites and may include highly improbable structures.
- **Refine Input**: Ensure SMILES strings are neutralized and desalted before processing to improve prediction accuracy.
- **Sequential Modeling**: To simulate complete human metabolism, run `cyp450` first, then use the output as input for `phaseII` to predict conjugated metabolites.
- **Metabolite Identification**: When using BioTransformer to identify unknowns from MS data, provide the exact mass (-m) and a narrow tolerance (-t) to filter the predicted metabolic space effectively.

## Reference documentation
- [BioTransformer Overview](./references/anaconda_org_channels_bioconda_packages_biotransformer_overview.md)
- [BioTransformer Source and Documentation](./references/bitbucket_org_djoumbou_biotransformer.md)
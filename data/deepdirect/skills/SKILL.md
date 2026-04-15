---
name: deepdirect
description: Deepdirect is a framework for protein complex optimization that suggests amino acid substitutions to strengthen or weaken binding affinity between ligands and receptors. Use when user asks to optimize protein complexes, suggest amino acid mutations for affinity changes, or perform directed mutagenesis for vaccine development.
homepage: https://github.com/Jappy0/deepdirect
metadata:
  docker_image: "quay.io/biocontainers/deepdirect:0.2.5--pyhdfd78af_0"
---

# deepdirect

## Overview
Deepdirect is a specialized framework for protein complex optimization. Unlike random mutagenesis, it uses a directed approach to suggest amino acid substitutions that specifically aim to strengthen or weaken the binding between a ligand and a receptor. It is particularly useful for vaccine development (e.g., Novavax-vaccine applications) and evolution analysis where monotone affinity changes are required.

## Environment Setup
Deepdirect requires a specific legacy environment to ensure compatibility with its neural network architecture.

- **Python Version**: 3.6.8
- **Core Dependencies**: 
  - `tensorflow==2.4.0`
  - `keras==2.4.0`

To initialize the environment:
```bash
conda create --name deepdirect python=3.6.8
conda activate deepdirect
pip install tensorflow==2.4.0 keras==2.4.0
```

## Core Workflow
The tool operates by loading a trained mutator model and passing sequence and structural data through a prediction pipeline.

### 1. Model Initialization
Load the framework functions and the pre-trained weights (typically `model_i_weights.h5` for increasing affinity).

```python
from deepdirect_framework.model_function import build_aa_mutator

# Initialize the mutator
aa_mutator = build_aa_mutator()

# Load weights (ensure the path to the .h5 file is correct)
aa_mutator.load_weights('deepdirect_framework/model_i_weights.h5')
```

### 2. Input Data Preparation
The `predict` function requires six specific inputs formatted as `tf.float32` tensors:
- `pre`: The original amino acid sequence to be mutated.
- `rbd`: The Receptor Binding Domain (RBD) site information.
- `same`: Ligand-receptor index mapping.
- `x, y, z`: Protein tertiary structure coordinates.
- `input_noi`: Random noise input for the adversarial generator.

### 3. Executing Mutation
Run the prediction to generate the mutated sequence:
```python
# Returns the mutated amino acid sequence
mutated_sequence = aa_mutator.predict([pre, rbd, same, x, y, z, input_noi])
```

## Best Practices
- **Data Extraction**: Use `ab_bind_data_extract.py` or `skempi_data_extract.py` found in the `deepdirect_paper` directory to format your raw structural data into the required training/input tensors.
- **Weight Selection**: Ensure you are using the correct weight file for your goal. `model_i_weights.h5` is generally used for increasing affinity.
- **Runtime**: Expect mutation generation to take approximately 1 minute on standard hardware once the model is loaded.

## Reference documentation
- [Deepdirect GitHub Repository](./references/github_com_JappyPing_deepdirect.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_deepdirect_overview.md)
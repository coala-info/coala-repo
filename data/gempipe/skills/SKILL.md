---
name: gempipe
description: "Gempipe reconstructs, refines, and analyzes genome-scale metabolic models for microbial strains. Use when user asks to build a metabolic model for a specific microbial strain, curate existing metabolic models, or perform pan-model analysis across multiple strains."
homepage: https://github.com/lazzarigioele/gempipe
---


# gempipe

## Overview

Gempipe is a specialized bioinformatics tool designed for the creation, refinement, and analysis of metabolic models at the genome scale. It is particularly useful for working with models that represent individual strains or multiple strains of microorganisms. If you need to build, edit, or study the metabolic pathways and capabilities of specific microbial strains using computational models, gempipe is the tool for the job.

## Usage Instructions

Gempipe is primarily a command-line tool. The core functionality revolves around constructing and manipulating metabolic models.

### Installation

To install gempipe, use conda:

```bash
conda install bioconda::gempipe
```

### Core Commands and Patterns

While the full range of commands is extensive, common workflows involve:

*   **Model Reconstruction:** This is the primary function. You will typically provide input data (e.g., genomic information, gene annotations) to build a strain-specific metabolic model.
*   **Model Curation:** Refining existing models, adding or modifying reactions, genes, and metabolites.
*   **Pan-model Analysis:** Analyzing a collection of models to understand shared and unique metabolic features across strains.

**General Command Structure:**

The exact command structure can vary, but a typical pattern involves specifying an action and providing input files or parameters. For example, to reconstruct a model, you might use a command like:

```bash
gempipe reconstruct --genome <path_to_genome_fasta> --annotations <path_to_annotation_file> --output <output_model_name>
```

**Key Considerations:**

*   **Input Data:** Ensure your input data (genome sequences, annotation files) are in compatible formats. Refer to the gempipe documentation for specific requirements.
*   **Output:** Gempipe generates metabolic models, often in standard formats like SBML.
*   **Version Specificity:** When citing or using gempipe in research, it's important to specify the version used.

**Expert Tips:**

*   **Consult Documentation:** For detailed command options, parameters, and advanced workflows, always refer to the official gempipe documentation. The GitHub repository and Read the Docs page are excellent resources.
*   **Iterative Curation:** Metabolic model reconstruction is often an iterative process. Expect to perform multiple rounds of reconstruction and curation to achieve a high-quality model.
*   **Strain Specificity:** Pay close attention to parameters that define strain-specific characteristics, as this is a core strength of gempipe.

## Reference documentation

- [Gempipe Documentation](https://gempipe.readthedocs.io/)
- [GitHub Repository](https://github.com/lazzarigioele/gempipe)
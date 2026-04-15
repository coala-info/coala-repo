---
name: cameo
description: Cameo is a computer-aided metabolic engineering and optimization tool. Use when user asks to perform metabolic engineering tasks, analyze metabolic models, or optimize biological pathways.
homepage: http://cameo.bio
metadata:
  docker_image: "quay.io/biocontainers/cameo:0.13.6--pyhdfd78af_0"
---

# cameo

cameo/
├── SKILL.md
└── references/
    └── anaconda_org_channels_bioconda_packages_cameo_overview.md

SKILL.md:
```markdown
---
name: cameo
description: Computer-aided metabolic engineering and optimization tool. Use when Claude needs to perform metabolic engineering tasks, analyze metabolic models, or optimize biological pathways using the cameo software.
---

## Overview
The cameo tool is designed for computer-aided metabolic engineering and optimization. It allows users to analyze and manipulate metabolic models to understand and improve biological pathways. This skill is useful when you need to perform tasks related to metabolic engineering, such as model reconstruction, flux balance analysis, or pathway optimization.

## Usage Instructions

Cameo is a command-line tool. The primary way to interact with it is through its various subcommands.

### Installation

To install cameo, use conda:
```bash
conda install bioconda::cameo
```

### Core Functionality and Common Patterns

Cameo operates on metabolic models, typically in SBML format.

#### Model Analysis and Manipulation

*   **Loading a model**: Cameo can load models from various formats. The most common is SBML.
    ```bash
    cameo load-model path/to/your/model.xml
    ```
*   **Viewing model information**: Get a summary of the loaded model.
    ```bash
    cameo show-model
    ```
*   **Adding/Modifying reactions**: Cameo allows for the modification of existing reactions or the addition of new ones. Specific commands will depend on the exact operation, but often involve specifying reaction IDs, substrates, products, and stoichiometry.
    ```bash
    # Example: Adding a reaction (syntax may vary based on specific cameo version/subcommand)
    cameo add-reaction --id R_new --reaction "met1 <=> met2"
    ```

#### Flux Balance Analysis (FBA)

FBA is a core capability for understanding metabolic flux.

*   **Performing FBA**:
    ```bash
    cameo fba --objective <reaction_id_to_optimize>
    ```
    Replace `<reaction_id_to_optimize>` with the ID of the reaction you want to maximize or minimize.
*   **Setting objective**: You can also set the objective function before running FBA.
    ```bash
    cameo set-objective <reaction_id_to_optimize>
    cameo fba
    ```

#### Pathway Analysis and Optimization

Cameo provides tools to analyze and optimize specific pathways.

*   **Finding essential reactions**: Identify reactions critical for a specific objective.
    ```bash
    cameo find-essential --objective <reaction_id_to_optimize>
    ```
*   **Simulating gene knockouts**: Analyze the impact of removing specific genes on metabolic flux.
    ```bash
    cameo simulate-knockout --gene <gene_id> --objective <reaction_id_to_optimize>
    ```

### Expert Tips

*   **Model Format**: Ensure your metabolic models are in a compatible format, typically SBML.
*   **Reaction IDs**: Pay close attention to reaction and metabolite IDs. They are case-sensitive and must match exactly within the model.
*   **Objective Function**: Clearly define the objective function for FBA. This is crucial for meaningful optimization results. Common objectives include biomass production or the production of a specific metabolite.
*   **Documentation**: Refer to the official cameo documentation for detailed command syntax and advanced options, as the CLI can be extensive.



## Subcommands

| Command | Description |
|---------|-------------|
| cameo design | Compute strain designs for desired product. |
| cameo search | Search for available products. |

## Reference documentation
- [Cameo Overview on Anaconda.org](https://anaconda.org/bioconda/cameo)
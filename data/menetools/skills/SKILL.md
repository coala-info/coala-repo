---
name: menetools
description: MeneTools is a suite of Python utilities that uses network expansion algorithms to explore the producibility potential of metabolic networks. Use when user asks to calculate reachable metabolites, verify target producibility, identify dead-end metabolites, find production pathways, or suggest missing cofactors to unblock pathways.
homepage: https://github.com/cfrioux/MeneTools
metadata:
  docker_image: "quay.io/biocontainers/menetools:2.0.6--py_0"
---

# menetools

## Overview
MeneTools is a suite of Python utilities designed to explore the producibility potential of metabolic networks. Unlike flux-based methods, MeneTools uses a structural "network expansion" algorithm, making it ideal for draft or non-curated metabolic networks where stoichiometry may be unreliable. It allows users to determine which metabolites are reachable from a set of seeds, verify if specific targets can be produced, identify dead-end metabolites, and suggest cofactors to unblock metabolic pathways.

## Command Line Usage

The primary entry point is the `mene` command followed by a specific subcommand.

### Core Analysis Patterns

*   **Calculate Reachable Metabolites (Scope):**
    Determine all compounds producible from a set of nutrients.
    `mene scope -d draft_network.sbml -s seeds.sbml --output scope_results.txt`

*   **Verify Target Producibility:**
    Check if specific metabolites of interest (targets) can be produced.
    `mene check -d draft_network.sbml -s seeds.sbml -t targets.sbml`

*   **Identify Activable Reactions:**
    Find all reactions whose reactants are available in the current scope.
    `mene acti -d draft_network.sbml -s seeds.sbml`

*   **Find Production Pathways:**
    Generate a set of reactions explaining how a target is produced from seeds.
    `mene path -d draft_network.sbml -s seeds.sbml -t targets.sbml`

### Network Maintenance and Debugging

*   **Identify Dead-ends:**
    Find metabolites that are only produced or only consumed, indicating gaps in the network.
    `mene dead -d draft_network.sbml`

*   **Suggest Missing Cofactors:**
    Identify compounds that, if added to the seeds, would enable the production of blocked targets.
    `mene cof -d draft_network.sbml -s seeds.sbml -t targets.sbml`

*   **Extract Seed Metabolites:**
    Identify metabolites produced by exchange reactions (reactions without reactants).
    `mene seed -d draft_network.sbml`

*   **Expansion Steps:**
    Calculate the number of steps required by the expansion algorithm to reach targets.
    `mene scope_inc -d draft_network.sbml -s seeds.sbml -t targets.sbml`

## Expert Tips and Best Practices

*   **Input Format:** All network files (`-d`), seed files (`-s`), and target files (`-t`) must be in SBML format. If you have a list of seeds as a simple text file, they must be converted to a minimal SBML model before use.
*   **Draft Networks:** Because MeneTools ignores stoichiometry (treating `2A + B -> C` as `A + B -> C`), it is highly effective for early-stage "draft" reconstructions where coefficients are not yet refined.
*   **Seed Selection:** The "initiation rule" depends entirely on the seeds. If a target is unexpectedly non-producible, use `mene seed` to ensure your draft network actually contains the expected exchange reactions to support your seed set.
*   **Cofactor Analysis:** Use `mene cof` when a target is not producible to distinguish between a missing reaction in the network and a missing nutrient in the growth medium.

## Reference documentation
- [MeneTools GitHub Repository](./references/github_com_cfrioux_MeneTools.md)
- [MeneTools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_menetools_overview.md)
---
name: meneco
description: Meneco is a topological tool that identifies the minimal set of reactions needed to complete a metabolic network and restore the production of target metabolites. Use when user asks to identify gaps in metabolic reconstructions, find minimal reaction sets to restore network functionality, or enumerate alternative network completions from a reference database.
homepage: http://bioasp.github.io/meneco/
metadata:
  docker_image: "quay.io/biocontainers/meneco:1.5.2--py35_0"
---

# meneco

## Overview
Meneco is a qualitative, topology-based tool used to address incompleteness in genome-scale metabolic reconstructions. It employs Answer Set Programming (ASP) to determine if a draft network's topology allows for the production of "target" metabolites (such as biomass components) from "seed" metabolites (nutrients available in the environment). When gaps are found, Meneco identifies the smallest number of reactions to import from a larger reference database to restore functionality.

## Command Line Usage
The primary interface for Meneco requires four SBML files: the draft network, the seeds, the targets, and the repair (reference) network.

### Basic Network Completion
To find a minimal set of reactions to complete a network:
```bash
meneco -d draft.sbml -s seeds.sbml -t targets.sbml -r repair.sbml
```

### Enumerating All Solutions
By default, Meneco returns one minimal solution. To explore the full space of possible completions:
```bash
meneco -d draft.sbml -s seeds.sbml -t targets.sbml -r repair.sbml --enumerate
```

### Machine-Readable Output
For downstream processing or integration into pipelines, use the JSON flag:
```bash
meneco -d draft.sbml -s seeds.sbml -t targets.sbml -r repair.sbml --json
```

## Python API Integration
Meneco can be imported directly into Python scripts for programmatic workflows.

```python
from meneco import run_meneco

result = run_meneco(
    draftnet="draft.sbml",
    seeds="seeds.sbml",
    targets="targets.sbml",
    repairnet="repair.sbml",
    enumeration=False,
    json=True
)
```

The `result` object contains:
- **Unproducible targets**: Metabolites that cannot be synthesized even with the repair network.
- **Reconstructable targets**: Metabolites that can be synthesized after completion.
- **Essential reactions**: Reactions that appear in every possible minimal completion.
- **Union/Intersection**: The set of reactions found in all or at least one minimal solution.

## Best Practices
- **SBML Compatibility**: Ensure all input files are valid SBML. Meneco relies on the topological structure (species and reactions) defined within these files.
- **Seed Selection**: Be comprehensive when defining seeds. Missing essential cofactors or inorganic ions (e.g., H2O, ATP, Pi) in the seeds file will prevent the synthesis of targets.
- **Target Definition**: Targets should represent the functional requirements of the model, typically biomass precursors or specific metabolic outputs of interest.
- **Repair Networks**: Use high-quality, curated databases like MetaCyc or BiGG as your repair network to ensure the suggested completions are biologically relevant.

## Reference documentation
- [Meneco - A tool for the completion of metabolic networks](./references/bioasp_github_io_meneco.md)
- [meneco - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_meneco_overview.md)
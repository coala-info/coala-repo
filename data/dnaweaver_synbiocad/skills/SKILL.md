---
name: dnaweaver_synbiocad
description: dnaweaver_synbiocad automates the planning of DNA assembly strategies by analyzing SBOL sequences to determine the most efficient assembly route and resource usage. Use when user asks to plan DNA assembly strategies, determine assembly methods like Golden Gate or Gibson, or optimize primer and fragment reuse for genetic constructs.
homepage: https://github.com/brsynth/DNAWeaver_SynBioCAD/
metadata:
  docker_image: "quay.io/biocontainers/dnaweaver_synbiocad:1.0.2--pyhdfd78af_0"
---

# dnaweaver_synbiocad

## Overview

`dnaweaver_synbiocad` is a specialized command-line tool that automates the planning of DNA assembly strategies for complex genetic constructs. It bridges the gap between high-level genetic design and laboratory execution by analyzing sequences provided in SBOL format and determining the most efficient assembly route. The tool evaluates whether a construct can be built using Golden Gate assembly (based on the absence of specific Type IIS restriction sites) or if it requires Gibson assembly. A key feature of this tool is its ability to optimize resource usage by identifying opportunities to reuse primers and PCR fragments across multiple designs within a single project.

## Command Line Usage

The tool is executed as a Python module. The basic syntax requires an input SBOL file, a target output path for the Excel report, and the desired assembly method.

### Basic Command Pattern
```bash
python -m dnaweaver_synbiocad <input_sbol_file> <output_spreadsheet> <method>
```

### Assembly Methods
- `any_method`: The tool automatically selects the best method. It prefers Golden Gate if the sequence is compatible (lacks BsaI, BbsI, and BsmBI sites), otherwise it defaults to Gibson.
- `golden_gate`: Forces the tool to only consider Golden Gate assembly.
- `gibson`: Forces the tool to only consider Gibson assembly.

### Example Execution
To process a design file named `my_design.xml` and generate a report:
```bash
python -m dnaweaver_synbiocad my_design.xml assembly_plan.xlsx any_method
```

## Best Practices and Expert Tips

### Input Requirements
- **SBOL Format**: Ensure your input `.xml` file follows SBOL standards and includes both the construct designs (the list of parts) and the actual DNA sequences for those parts.
- **Sequence Content**: The tool assumes construct sequences are the direct concatenation of part sequences. It does not automatically add overhangs; instead, it designs primers with the necessary overhangs to create homologies for assembly.

### Interpreting Results
The output is a multi-sheet Excel spreadsheet. Key sheets to review include:
- **fragment_extensions**: Contains the specific primer sequences required for PCR.
- **assembly_plan**: Provides the step-by-step instructions for building each construct.
- **errors**: If the tool cannot find a valid assembly plan for a specific construct, check this sheet for troubleshooting details (e.g., internal restriction sites or homology issues).

### Optimization Logic
- **Primer Reuse**: The tool processes designs sequentially. It tracks primers and fragments generated for earlier designs and reuses them for subsequent ones if the sequences match. To maximize efficiency, process related designs in a single batch.
- **Restriction Site Constraints**: Golden Gate assembly will fail if BsaI, BbsI, or BsmBI sites are present within the part sequences. If your parts contain these sites, you must use `gibson` or `any_method`.

### Limitations to Consider
- **Repeated Parts**: For constructs with highly repetitive sequences or multiple identical parts in a row, Gibson assembly may lead to misannealing. The tool does not currently flag these specific biological risks, so manual verification of the plan is recommended for highly repetitive designs.

## Reference documentation
- [DNA Weaver (for SynBioCAD) README](./references/github_com_brsynth_DNAWeaver_SynBioCAD.md)
- [dnaweaver_synbiocad Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dnaweaver_synbiocad_overview.md)
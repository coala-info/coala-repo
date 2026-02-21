cwlVersion: v1.2
class: CommandLineTool
baseCommand: ligand-validation
label: ligand-validation
doc: "A tool for ligand validation. (Note: The provided text is a system error log
  and does not contain help documentation or argument definitions.)\n\nTool homepage:
  https://git.scicore.unibas.ch/schwede/ligand-validation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ligand-validation:0.0.1--pyh7e72e81_1
stdout: ligand-validation.out

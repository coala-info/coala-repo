cwlVersion: v1.2
class: CommandLineTool
baseCommand: olga-compute_pgen
label: olga_olga-compute_pgen
doc: "The provided help text contains only system error messages related to a container
  runtime failure (no space left on device) and does not contain usage information
  or argument definitions.\n\nTool homepage: https://github.com/zsethna/OLGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olga:1.3.0--pyh7e72e81_0
stdout: olga_olga-compute_pgen.out

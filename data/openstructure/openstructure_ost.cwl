cwlVersion: v1.2
class: CommandLineTool
baseCommand: ost
label: openstructure_ost
doc: "OpenStructure (OST) is a modular software framework for structural biology.
  Note: The provided help text contains only system error messages regarding container
  execution and does not list command-line arguments.\n\nTool homepage: https://openstructure.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openstructure:2.11.1--py310h1f7f436_0
stdout: openstructure_ost.out

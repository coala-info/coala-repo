cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnasketch_design-cofold.py
label: rnasketch_design-cofold.py
doc: "A tool for RNA design and cofolding. (Note: The provided help text contains
  container execution errors and does not list specific arguments.)\n\nTool homepage:
  https://github.com/ViennaRNA/RNAsketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasketch:1.5--py27_1
stdout: rnasketch_design-cofold.py.out

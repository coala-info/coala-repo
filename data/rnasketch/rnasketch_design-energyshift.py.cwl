cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnasketch_design-energyshift.py
label: rnasketch_design-energyshift.py
doc: "RNA design tool for energy shifts (Note: The provided text is a container execution
  error log and does not contain usage information or argument definitions.)\n\nTool
  homepage: https://github.com/ViennaRNA/RNAsketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasketch:1.5--py27_1
stdout: rnasketch_design-energyshift.py.out

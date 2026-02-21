cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnasketch_design-multistate.py
label: rnasketch_design-multistate.py
doc: "A tool for multistate RNA design. (Note: The provided help text contains container
  environment logs and a fatal error rather than command usage information.)\n\nTool
  homepage: https://github.com/ViennaRNA/RNAsketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasketch:1.5--py27_1
stdout: rnasketch_design-multistate.py.out

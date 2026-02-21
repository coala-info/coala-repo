cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnasketch_design-redprint-multistate.py
label: rnasketch_design-redprint-multistate.py
doc: "RNA design tool (Note: The provided text is a container execution error log
  and does not contain help information or argument definitions.)\n\nTool homepage:
  https://github.com/ViennaRNA/RNAsketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasketch:1.5--py27_1
stdout: rnasketch_design-redprint-multistate.py.out

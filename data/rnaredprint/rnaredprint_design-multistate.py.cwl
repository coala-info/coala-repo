cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaredprint_design-multistate.py
label: rnaredprint_design-multistate.py
doc: "A tool for multi-state RNA design. (Note: The provided text is a container execution
  error log and does not contain help documentation or argument definitions.)\n\n
  Tool homepage: https://github.com/yannponty/RNARedPrint"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaredprint:0.3--h9948957_2
stdout: rnaredprint_design-multistate.py.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: comparem
label: comparem
doc: "A tool for comparative genomics (Note: The provided text is a system error log
  and does not contain the help documentation or argument definitions).\n\nTool homepage:
  https://github.com/dparks1134/CompareM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparem:0.1.2--py_0
stdout: comparem.out

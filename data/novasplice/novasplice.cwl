cwlVersion: v1.2
class: CommandLineTool
baseCommand: novasplice
label: novasplice
doc: "A tool for splicing analysis (Note: The provided text contains container runtime
  error logs rather than the tool's help documentation).\n\nTool homepage: https://github.com/aryakaul/novasplice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novasplice:0.0.4--py_0
stdout: novasplice.out

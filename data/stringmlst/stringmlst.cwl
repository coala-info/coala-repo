cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringmlst
label: stringmlst
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains container runtime logs and a fatal error message regarding
  a failed image build.\n\nTool homepage: https://github.com/jordanlab/stringMLST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringmlst:0.6.3--py_0
stdout: stringmlst.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdhit-compare
label: cdhit-reader_cdhit-compare
doc: "The provided text does not contain help information for the tool. It contains
  system error logs related to a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/telatin/cdhit-parser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdhit-reader:0.2.0--pyhdfd78af_0
stdout: cdhit-reader_cdhit-compare.out

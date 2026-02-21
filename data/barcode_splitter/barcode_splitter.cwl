cwlVersion: v1.2
class: CommandLineTool
baseCommand: barcode_splitter
label: barcode_splitter
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or extract a container image
  due to insufficient disk space.\n\nTool homepage: https://bitbucket.org/princeton_genomics/barcode_splitter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barcode_splitter:0.18.6--py_0
stdout: barcode_splitter.out

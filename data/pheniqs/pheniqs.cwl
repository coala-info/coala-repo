cwlVersion: v1.2
class: CommandLineTool
baseCommand: pheniqs
label: pheniqs
doc: "Pheniqs (PHEnotypic IQS) is a tool for barcode demultiplexing and quality control
  of high-throughput sequencing data. Note: The provided text appears to be a container
  runtime error log rather than the tool's help output.\n\nTool homepage: http://biosails.github.io/pheniqs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pheniqs:2.1.0--py38h87cedfc_0
stdout: pheniqs.out

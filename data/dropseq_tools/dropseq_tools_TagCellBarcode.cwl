cwlVersion: v1.2
class: CommandLineTool
baseCommand: TagCellBarcode
label: dropseq_tools_TagCellBarcode
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error indicating that the container image could
  not be built or loaded due to insufficient disk space ('no space left on device').\n
  \nTool homepage: http://mccarrolllab.com/dropseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
stdout: dropseq_tools_TagCellBarcode.out

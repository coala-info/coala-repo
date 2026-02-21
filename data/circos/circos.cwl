cwlVersion: v1.2
class: CommandLineTool
baseCommand: circos
label: circos
doc: "Circos is a software package for visualizing data and information in a circular
  layout. (Note: The provided text is a container execution error log and does not
  contain help documentation; therefore, no arguments could be extracted.)\n\nTool
  homepage: http://circos.ca"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circos:0.69.9--hdfd78af_0
stdout: circos.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: trust4
label: trust4
doc: "TCR/BCR repertoire extraction and assembly from RNA-seq data\n\nTool homepage:
  https://github.com/liulab-dfci/TRUST4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: trust4.out

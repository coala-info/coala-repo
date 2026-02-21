cwlVersion: v1.2
class: CommandLineTool
baseCommand: libssw
label: libssw
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error message regarding a lack of disk space during a container
  image conversion.\n\nTool homepage: https://github.com/mengyao/Complete-Striped-Smith-Waterman-Library"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libssw:1.2.5--h5ca1c30_0
stdout: libssw.out

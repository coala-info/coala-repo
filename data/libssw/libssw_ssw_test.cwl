cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssw_test
label: libssw_ssw_test
doc: "The provided text does not contain help information for the tool; it contains
  system error messages regarding container image conversion and disk space issues.\n
  \nTool homepage: https://github.com/mengyao/Complete-Striped-Smith-Waterman-Library"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libssw:1.2.5--h5ca1c30_0
stdout: libssw_ssw_test.out

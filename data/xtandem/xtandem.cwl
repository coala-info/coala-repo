cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem
label: xtandem
doc: "X! TANDEM Vengeance (2015.12.15.2)\n\nTool homepage: https://github.com/bspratt/xtandem-g"
inputs:
  - id: filename
    type: File
    doc: any valid path to an XML input file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtandem:15.12.15.2--0
stdout: xtandem.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: miRge2.0
label: mirge_miRge2.0
doc: "Comprehensive analysis of miRNA sequencing Data\n\nTool homepage: https://github.com/mhalushka/miRge"
inputs:
  - id: command
    type: string
    doc: sub-command help
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirge:2.0.6--py27_4
stdout: mirge_miRge2.0.out

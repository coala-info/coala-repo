cwlVersion: v1.2
class: CommandLineTool
baseCommand: trinculo
label: trinculo
doc: "Trinculo is a tool for analyzing RNA sequencing data.\n\nTool homepage: https://github.com/Trinculo54/trinculo54.github.io"
inputs:
  - id: mode
    type: string
    doc: The mode of operation for trinculo (e.g., multinom).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trinculo:0.96--h470a237_2
stdout: trinculo.out

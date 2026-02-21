cwlVersion: v1.2
class: CommandLineTool
baseCommand: kart
label: kart
doc: "A divide-and-conquer algorithm for NGS read mapping\n\nTool homepage: https://github.com/hsinnan75/Kart"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kart:2.5.6--h13024bc_6
stdout: kart.out

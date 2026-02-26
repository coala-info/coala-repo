cwlVersion: v1.2
class: CommandLineTool
baseCommand: Ratatosk
label: ratatosk_Ratatosk
doc: "Hybrid error correction of long reads using colored de Bruijn graphs\n\nTool
  homepage: https://github.com/DecodeGenetics/Ratatosk"
inputs:
  - id: command
    type: string
    doc: Command to execute (correct, index)
    inputBinding:
      position: 1
  - id: parameters
    type:
      - 'null'
      - type: array
        items: string
    doc: Parameters for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ratatosk:0.9.0--h077b44d_2
stdout: ratatosk_Ratatosk.out

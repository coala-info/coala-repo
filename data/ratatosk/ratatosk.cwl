cwlVersion: v1.2
class: CommandLineTool
baseCommand: ratatosk
label: ratatosk
doc: "Ratatosk is a hybrid error correction tool for long reads using colored de Bruijn
  graphs.\n\nTool homepage: https://github.com/DecodeGenetics/Ratatosk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ratatosk:0.9.0--h077b44d_2
stdout: ratatosk.out

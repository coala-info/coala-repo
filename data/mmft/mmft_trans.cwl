cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmft_trans
label: mmft_trans
doc: "Translate a fasta into all six frames.\n\nTool homepage: https://github.com/ARU-life-sciences/mmft"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: Input fasta file path(s).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
stdout: mmft_trans.out

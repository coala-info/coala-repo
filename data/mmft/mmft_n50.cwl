cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmft_n50
label: mmft_n50
doc: "Calculates the N50 statistic for a given FASTA file.\n\nTool homepage: https://github.com/ARU-life-sciences/mmft"
inputs:
  - id: fasta_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
stdout: mmft_n50.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmft_extract
label: mmft_extract
doc: "Extract (sub)sequence within a fasta file record.\n\nTool homepage: https://github.com/ARU-life-sciences/mmft"
inputs:
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input fasta file path(s).
    inputBinding:
      position: 1
  - id: region
    type: string
    doc: Numeric region to extract.
    inputBinding:
      position: 102
      prefix: --region
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
stdout: mmft_extract.out

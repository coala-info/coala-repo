cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmft_len
label: mmft_len
doc: "Calculate lengths of fasta file records.\n\nTool homepage: https://github.com/ARU-life-sciences/mmft"
inputs:
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input fasta file path(s).
    inputBinding:
      position: 1
  - id: extract
    type:
      - 'null'
      - int
    doc: Fasta records with a length greater than specified are printed.
    inputBinding:
      position: 102
      prefix: --extract
  - id: less
    type:
      - 'null'
      - boolean
    doc: Print records with lengths less than value of extract. Default is 
      greater.
    inputBinding:
      position: 102
      prefix: --less
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
stdout: mmft_len.out

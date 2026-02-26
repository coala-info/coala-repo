cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmft regex
label: mmft_regex
doc: "Extract fasta records using regex on headers.\n\nTool homepage: https://github.com/ARU-life-sciences/mmft"
inputs:
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input fasta file path(s).
    inputBinding:
      position: 1
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: Inverse regex match.
    inputBinding:
      position: 102
      prefix: --inverse
  - id: regex
    type: string
    doc: Regex to compile.
    inputBinding:
      position: 102
      prefix: --regex
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
stdout: mmft_regex.out

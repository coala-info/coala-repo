cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmft_filter
label: mmft_filter
doc: "Filter sequences on a file of ID's\n\nTool homepage: https://github.com/ARU-life-sciences/mmft"
inputs:
  - id: input_fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input fasta file path(s).
    inputBinding:
      position: 1
  - id: file
    type: File
    doc: Name of text file with one ID per line.
    inputBinding:
      position: 102
      prefix: --file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
stdout: mmft_filter.out

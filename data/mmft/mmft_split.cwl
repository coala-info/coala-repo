cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmft split
label: mmft_split
doc: "Split a fasta into multiple files based on record count.\n\nTool homepage: https://github.com/ARU-life-sciences/mmft"
inputs:
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input fasta file path(s).
    inputBinding:
      position: 1
  - id: number
    type: int
    doc: Number of records per file.
    inputBinding:
      position: 102
      prefix: --number
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for split files. Default is current working directory.
    default: .
    inputBinding:
      position: 102
      prefix: --dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
stdout: mmft_split.out

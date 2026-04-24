cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - gap
label: seqtk_gap
doc: "Find gaps in a FASTA file\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: min_gap_length
    type:
      - 'null'
      - int
    doc: Minimum gap length
    inputBinding:
      position: 102
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_gap.out

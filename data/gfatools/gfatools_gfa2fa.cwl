cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gfatools
  - gfa2fa
label: gfatools_gfa2fa
doc: "Convert a GFA file to FASTA format\n\nTool homepage: https://github.com/lh3/gfatools"
inputs:
  - id: input_gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 1
  - id: line_length
    type:
      - 'null'
      - int
    doc: line length
    default: 60
    inputBinding:
      position: 102
      prefix: -l
  - id: only_rank0
    type:
      - 'null'
      - boolean
    doc: only output rank-0 sequences (rGFA only; force -s)
    inputBinding:
      position: 102
      prefix: '-0'
  - id: skip_rank0
    type:
      - 'null'
      - boolean
    doc: skip rank-0 sequences (rGFA only; force -s)
    inputBinding:
      position: 102
      prefix: -P
  - id: stable_sequences
    type:
      - 'null'
      - boolean
    doc: output stable sequences (rGFA only)
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
stdout: gfatools_gfa2fa.out

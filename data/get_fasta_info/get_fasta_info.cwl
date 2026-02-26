cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_fasta_info
label: get_fasta_info
doc: "Get basic summary info about fasta formatted files.\n\nTool homepage: https://github.com/nylander/get_fasta_info"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input fasta file(s)
    inputBinding:
      position: 1
  - id: count_gaps
    type:
      - 'null'
      - boolean
    doc: 'count gaps, i.e. missing data symbols. Default: Nn?Xx-'
    inputBinding:
      position: 102
      prefix: -g
  - id: missing_symbols
    type:
      - 'null'
      - string
    doc: use char(s) as missing symbols and use -g
    inputBinding:
      position: 102
      prefix: -C
  - id: noverbose
    type:
      - 'null'
      - boolean
    doc: noverbose
    inputBinding:
      position: 102
      prefix: -n
  - id: print_full_path
    type:
      - 'null'
      - boolean
    doc: print full path to file
    inputBinding:
      position: 102
      prefix: -p
  - id: use_dash_as_missing
    type:
      - 'null'
      - boolean
    doc: -C - -g
    inputBinding:
      position: 102
      prefix: -G
  - id: use_n_as_missing
    type:
      - 'null'
      - boolean
    doc: -C N -g
    inputBinding:
      position: 102
      prefix: -N
  - id: use_q_as_missing
    type:
      - 'null'
      - boolean
    doc: -C ? -g
    inputBinding:
      position: 102
      prefix: -Q
  - id: use_x_as_missing
    type:
      - 'null'
      - boolean
    doc: -C X -g
    inputBinding:
      position: 102
      prefix: -X
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_fasta_info:2.5.0--h577a1d6_0
stdout: get_fasta_info.out

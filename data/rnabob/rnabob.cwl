cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnabob
label: rnabob
doc: "fast RNA pattern searching\n\nTool homepage: https://github.com/JPSieg/KertisThesis2021"
inputs:
  - id: descriptor_file
    type: File
    doc: descriptor file
    inputBinding:
      position: 1
  - id: sequence_file
    type: File
    doc: sequence file
    inputBinding:
      position: 2
  - id: fancy
    type:
      - 'null'
      - boolean
    doc: 'fancy: show full alignments to pattern'
    inputBinding:
      position: 103
      prefix: -F
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'quiet: suppress verbose banner and headers'
    inputBinding:
      position: 103
      prefix: -q
  - id: search_both_strands
    type:
      - 'null'
      - boolean
    doc: search both strands of database
    inputBinding:
      position: 103
      prefix: -c
  - id: skip_mode
    type:
      - 'null'
      - boolean
    doc: 'skip mode: disallow overlapping matches'
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnabob:2.2.1--h470a237_1
stdout: rnabob.out
